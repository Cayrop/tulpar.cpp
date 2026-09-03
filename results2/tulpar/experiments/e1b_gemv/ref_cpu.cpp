// Host-side IQ3_XXS GEMV reference for E1b.
// Replicates vec_dot_iq3_xxs_q8_1 + mul_mat_vec_q<IQ3_XXS> semantics exactly
// (ggml/src/ggml-cuda/vecdotq.cuh, mmvq.cuh @ tulpar/main 66dcba5eb).
// IQ3_XXS: 256-element super-blocks: fp16 d + qs[96]; 3.0625 bpw.
#define GGML_COMMON_DECL_CPP
#define GGML_COMMON_IMPL_CPP
#include "ggml-common.h"

#include <cstdint>
#include <cstring>
#include <cstdio>

static uint32_t h_popc(uint32_t v) { uint32_t c = 0; while (v) { c += v & 1u; v >>= 1; } return c; }

static int h_vcmpne4_zero(uint32_t x) {
    int r = 0;
    for (int i = 0; i < 4; ++i) {
        if (((x >> (8*i)) & 0xFF) != 0) r |= 0xFF << (8*i);
    }
    return r;
}

static uint32_t h_sat_sub4(uint32_t a, uint32_t m) {
    // per-byte saturated subtract, mirrors __vsub4/__vsubss4
    uint32_t r = 0;
    for (int i = 0; i < 4; ++i) {
        int8_t ab = (int8_t)((a >> (8*i)) & 0xFF);
        int8_t mb = (int8_t)((m >> (8*i)) & 0xFF);
        int16_t d = (int16_t)ab - (int16_t)mb;
        if (d > 127) d = 127;
        if (d < -128) d = -128;
        r |= ((uint32_t)(uint8_t)d) << (8*i);
    }
    return r;
}

static int h_dp4a(uint32_t a, uint32_t b, int c) {
    int s = c;
    for (int i = 0; i < 4; ++i) {
        int8_t ba = (int8_t)((a >> (8*i)) & 0xFF);
        int8_t bb = (int8_t)((b >> (8*i)) & 0xFF);
        s += (int)ba * (int)bb;
    }
    return s;
}

static float h_half2float(uint16_t h) {
    uint32_t sign = (h & 0x8000u) << 16;
    uint32_t exp  = (h >> 10) & 0x1Fu;
    uint32_t man  = h & 0x3FFu;
    uint32_t bits;
    if (exp == 0) {
        if (man == 0) { bits = sign; }
        else {
            exp = 127 - 15 - 9; while (!(man & 0x400)) { man <<= 1; exp--; }
            man &= 0x3FF; bits = sign | ((exp + 1) << 23) | (man << 13);
        }
    } else if (exp == 31) {
        bits = sign | 0x7F800000u | (man << 13);
    } else {
        bits = sign | ((exp - 15 + 127) << 23) | (man << 13);
    }
    float f; memcpy(&f, &bits, 4); return f;
}

// one 32-value slice of a super-block, mirrors vec_dot_iq3_xxs_q8_1 inner logic
static inline float ref_slice(const uint8_t * qs, const uint8_t * yblk_qs, const uint16_t * yblk_d, uint32_t aux32) {
    // NOTE: caller passes pre-read values; kept for clarity in gemv below
    (void)qs; (void)yblk_qs; (void)yblk_d; (void)aux32;
    return 0.f;
}

extern "C" void iq3xxs_ref_gemv(
        const uint8_t * W,   // nrows x row_bytes (row_bytes = nsb*98)
        const uint8_t * y8,  // (K/32) x 36 B block_q8_1
        float * dst,
        int nrows, int row_bytes) {

    const int nsb = row_bytes / 98;

    for (int r = 0; r < nrows; ++r) {
        const uint8_t * row = W + (size_t)r * row_bytes;
        float acc = 0.0f;

        for (int sb = 0; sb < nsb; ++sb) {
            const block_iq3_xxs * bq = (const block_iq3_xxs *)(row + (size_t)sb * 98);
            const block_q8_1 * ybase = (const block_q8_1 *)(y8 + (size_t)sb * 8 * 36);

            for (int ip = 0; ip < 8; ++ip) {          // iqs = 2*ip
                const int iqs = 2*ip;
                const block_q8_1 * bq8 = ybase + ip;

                uint32_t qp[2], aux32;
                memcpy(&qp[0], bq->qs + 4*iqs, 4);
                memcpy(&qp[1], bq->qs + 4*(iqs+1), 4);
                memcpy(&aux32, bq->qs + 64 + 4*ip, 4);

                const uint8_t * q3 = (const uint8_t *) qp;      // 8 contiguous bytes

                int sumi = 0;
                for (int l0 = 0; l0 < 8; l0 += 2) {
                    const uint32_t gx = iq3xxs_grid[q3[l0]];
                    const uint32_t gy = iq3xxs_grid[q3[l0+1]];
                    const uint32_t v7 = (aux32 >> (7*l0/2)) & 0xFFu;
                    const uint32_t sg = ((v7 ^ ((h_popc(v7)&1u)<<7)) * 0x01010101u);

                    const int m0 = h_vcmpne4_zero(sg & 0x08040201u);
                    const int m1 = h_vcmpne4_zero(sg & 0x80402010u);

                    uint32_t u0,u1;
                    memcpy(&u0, ((const uint8_t *)bq8) + 4 + 4*l0, 4);
                    memcpy(&u1, ((const uint8_t *)bq8) + 4 + 4*(l0+1), 4);

                    const uint32_t gl = h_sat_sub4(gx^(uint32_t)m0,(uint32_t)m0);
                    const uint32_t gh = h_sat_sub4(gy^(uint32_t)m1,(uint32_t)m1);

                    sumi = h_dp4a(gl,u0,sumi);
                    sumi = h_dp4a(gh,u1,sumi);
                }

                const int ls = aux32 >> 28;
                sumi = (ls*sumi + sumi/2)/2;

                const float dy = h_half2float(((const uint16_t *)bq8)[0]);
                const float d  = h_half2float(*(const uint16_t *)bq);
                acc += d * dy * (float)sumi;
            }
        }
        dst[r] = acc;
    }
}
