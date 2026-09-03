// Phase-4E synthetic MMVQ GEMV microbenchmark for gfx1101 (RX 7800 XT).
// Variant harness: V0 baseline (single sumi accumulator chain) vs
//   E1: 4 independent accumulators (one per l0 iteration),
//   E2: 8 independent accumulators (one per dp4a),
//   E3: 8 independent accumulators + hoisted grid/qs gathers before dp4a.
// Bit-exactness expected: integer dp4a sums are associative in 32-bit space.
//
// Build: ./build.sh

#include <hip/hip_runtime.h>
#include <hip/hip_fp16.h>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cstdint>
#include <vector>
#include <string>
#include <algorithm>

#include "iq3xxs_grid.h"

#define CHECK_HIP(x) do { hipError_t e = (x); if (e != hipSuccess) { \
    fprintf(stderr, "HIP error %s at %s:%d\n", hipGetErrorString(e), __FILE__, __LINE__); exit(1);} } while (0)

#define QK4_0 32
#define QI4_0 (QK4_0 / (4 * 2))
#define QK8_0 32
#define QI8_0 (QK8_0 / (4 * 1))
#define QK8_1 32
#define QK_K 256
#define QR3_XXS 4
#define QI3_XXS (QK_K / (4 * QR3_XXS))

typedef struct { unsigned short d; unsigned char qs[QK4_0/2]; } block_q4_0;
typedef struct { unsigned short d; unsigned char qs[QK8_0]; } block_q8_0;
typedef struct {
    union { struct { unsigned short d, s; }; };
    unsigned char qs[QK8_1];
} block_q8_1;
typedef struct { unsigned char qs[QK_K/4]; unsigned short d; } block_iq3_xxs;
static_assert(sizeof(block_q4_0) == 18);
static_assert(sizeof(block_q8_0) == 34);
static_assert(sizeof(block_q8_1) == 36);
static_assert(sizeof(block_iq3_xxs) == 66);

static __device__ __forceinline__ int get_int_b2(const void * x, const int & i32) {
    const unsigned short * x16 = (const unsigned short *) x;
    int x32  = x16[2*i32 + 0] <<  0;
    x32     |= x16[2*i32 + 1] << 16;
    return x32;
}
static __device__ __forceinline__ int get_int_b4(const void * x, const int & i32) {
    return ((const int *) x)[i32];
}
static __device__ __forceinline__ int ggml_cuda_dp4a(const int a, const int b, int c) {
    c = __builtin_amdgcn_sudot4(true, a, true, b, c, false);
    return c;
}
static __device__ __forceinline__ uint32_t unpack_ksigns(const unsigned char v) {
    const uint32_t p = __popc(v) & 1;
    const uint32_t s = v ^ p << 7;
    return s * 0x01010101;
}
static __device__ __forceinline__ float silu_single(float x) {
    return x / (1.0f + expf(-x));
}

template<int width>
static __device__ __forceinline__ float warp_reduce_sum(float x) {
#pragma unroll
    for (int offset = width/2; offset > 0; offset >>= 1) {
        x += __shfl_xor_sync(0xffffffffull, x, offset, width);
    }
    return x;
}

static constexpr int WARP_SIZE = 32;

typedef int8_t int8x4_t __attribute__((ext_vector_type(4)));
typedef uint8_t uint8x4_t __attribute__((ext_vector_type(4)));
static __device__ __forceinline__ unsigned int __vcmpne4(unsigned int a, unsigned int b) {
    const uint8x4_t& va = reinterpret_cast<const uint8x4_t&>(a);
    const uint8x4_t& vb = reinterpret_cast<const uint8x4_t&>(b);
    unsigned int c;
    uint8x4_t& vc = reinterpret_cast<uint8x4_t&>(c);
#pragma unroll
    for (int i = 0; i < 4; ++i) {
        vc[i] = va[i] == vb[i] ? 0x00 : 0xff;
    }
    return c;
}
static __device__ __forceinline__ int __vsubss4(const int a, const int b) {
    const int8x4_t va = reinterpret_cast<const int8x4_t&>(a);
    const int8x4_t vb = reinterpret_cast<const int8x4_t&>(b);
    const int8x4_t c = __builtin_elementwise_sub_sat(va, vb);
    return reinterpret_cast<const int &>(c);
}
static __device__ __forceinline__ int __vsub4(const int a, const int b) {
    return __vsubss4(a, b);
}

static __device__ __forceinline__ float vec_dot_q4_0_q8_1(const void * vbq, const block_q8_1 * bq8_1, const int kbx, const int iqs) {
    const block_q4_0 * bq4_0 = (const block_q4_0 *) vbq + kbx;
    int v[2], u[4];
#pragma unroll
    for (int i = 0; i < 2; ++i) {
        v[i]     = get_int_b2(bq4_0->qs, iqs + i);
        u[2*i+0] = get_int_b4(bq8_1->qs, iqs + i);
        u[2*i+1] = get_int_b4(bq8_1->qs, iqs + i + QI4_0);
    }
    int sumi = 0;
#pragma unroll
    for (int i = 0; i < 2; ++i) {
        const int vi0 = (v[i] >> 0) & 0x0F0F0F0F;
        const int vi1 = (v[i] >> 4) & 0x0F0F0F0F;
        sumi = ggml_cuda_dp4a(vi0, u[2*i+0], sumi);
        sumi = ggml_cuda_dp4a(vi1, u[2*i+1], sumi);
    }
    const float2 ds8f = __half22float2(*(const __half2 *)&bq8_1->d);
    const float d4 = __half2float(__ushort_as_half(bq4_0->d));
    return d4 * (sumi * ds8f.x - 4 * ds8f.y);
}

static __device__ __forceinline__ float vec_dot_q8_0_q8_1(const void * vbq, const block_q8_1 * bq8_1, const int kbx, const int iqs) {
    const block_q8_0 * bq8_0 = (const block_q8_0 *) vbq + kbx;
    int sumi = 0;
#pragma unroll
    for (int i = 0; i < 2; ++i) {
        const int v = get_int_b4(bq8_0->qs, iqs + i);
        sumi = ggml_cuda_dp4a(v, get_int_b4(bq8_1->qs, iqs + i), sumi);
    }
    const float2 ds8f = __half22float2(*(const __half2 *)&bq8_1->d);
    return ds8f.x * __half2float(__ushort_as_half(bq8_0->d)) * sumi;
}

// ===================== vec_dot IQ3_XXS variants =====================

// V0: original single sumi chain. 8 dp4a into one int, serial dependency.
static __device__ __forceinline__ float vec_dot_iq3_xxs_q8_1_V0(const void * vbq, const block_q8_1 * bq8_1, const int kbx, const int iqs) {
    const block_iq3_xxs * bq3 = (const block_iq3_xxs *) vbq + kbx;
    const int2 q3_packed = make_int2(get_int_b2(bq3->qs, iqs), get_int_b2(bq3->qs, iqs+1));
    const unsigned char * q3 = (const unsigned char *) &q3_packed;
    const uint32_t aux32 = get_int_b2(bq3->qs, QK_K/16 + iqs/2);

    int sumi = 0;
#pragma unroll
    for (int l0 = 0; l0 < 8; l0 += 2) {
        const int2 grid_pos = make_int2(iq3xxs_grid[q3[l0 + 0]], iq3xxs_grid[q3[l0 + 1]]);
        const uint32_t signs = unpack_ksigns(aux32 >> (7*l0/2));

        const int signs0 = __vcmpne4(signs & 0x08040201, 0);
        const int grid_l = __vsub4(grid_pos.x ^ signs0, signs0);
        const int u0 = get_int_b4(bq8_1[iqs/2].qs, l0 + 0);

        const int signs1 = __vcmpne4(signs & 0x80402010, 0);
        const int grid_h = __vsub4(grid_pos.y ^ signs1, signs1);
        const int u1 = get_int_b4(bq8_1[iqs/2].qs, l0 + 1);

        sumi = ggml_cuda_dp4a(grid_l, u0, sumi);
        sumi = ggml_cuda_dp4a(grid_h, u1, sumi);
    }

    const int ls = aux32 >> 28;
    sumi = (ls*sumi + sumi/2)/2;
    const float d = __half2float(__ushort_as_half(bq3->d)) *
                    __low2float(*(const __half2 *)&bq8_1[iqs/2].d);
    return d * sumi;
}

// E1: 4 independent accumulators (one per l0 iter). 2 dp4a each.
static __device__ __forceinline__ float vec_dot_iq3_xxs_q8_1_E1(const void * vbq, const block_q8_1 * bq8_1, const int kbx, const int iqs) {
    const block_iq3_xxs * bq3 = (const block_iq3_xxs *) vbq + kbx;
    const int2 q3_packed = make_int2(get_int_b2(bq3->qs, iqs), get_int_b2(bq3->qs, iqs+1));
    const unsigned char * q3 = (const unsigned char *) &q3_packed;
    const uint32_t aux32 = get_int_b2(bq3->qs, QK_K/16 + iqs/2);

    int s0 = 0, s1 = 0, s2 = 0, s3 = 0;
#pragma unroll
    for (int l0 = 0; l0 < 8; l0 += 2) {
        const int2 grid_pos = make_int2(iq3xxs_grid[q3[l0 + 0]], iq3xxs_grid[q3[l0 + 1]]);
        const uint32_t signs = unpack_ksigns(aux32 >> (7*l0/2));

        const int signs0 = __vcmpne4(signs & 0x08040201, 0);
        const int grid_l = __vsub4(grid_pos.x ^ signs0, signs0);
        const int u0 = get_int_b4(bq8_1[iqs/2].qs, l0 + 0);

        const int signs1 = __vcmpne4(signs & 0x80402010, 0);
        const int grid_h = __vsub4(grid_pos.y ^ signs1, signs1);
        const int u1 = get_int_b4(bq8_1[iqs/2].qs, l0 + 1);

        if (l0 == 0) {
            s0 = ggml_cuda_dp4a(grid_l, u0, s0);
            s0 = ggml_cuda_dp4a(grid_h, u1, s0);
        } else if (l0 == 2) {
            s1 = ggml_cuda_dp4a(grid_l, u0, s1);
            s1 = ggml_cuda_dp4a(grid_h, u1, s1);
        } else if (l0 == 4) {
            s2 = ggml_cuda_dp4a(grid_l, u0, s2);
            s2 = ggml_cuda_dp4a(grid_h, u1, s2);
        } else {
            s3 = ggml_cuda_dp4a(grid_l, u0, s3);
            s3 = ggml_cuda_dp4a(grid_h, u1, s3);
        }
    }

    int sumi = (s0 + s1) + (s2 + s3);
    const int ls = aux32 >> 28;
    sumi = (ls*sumi + sumi/2)/2;
    const float d = __half2float(__ushort_as_half(bq3->d)) *
                    __low2float(*(const __half2 *)&bq8_1[iqs/2].d);
    return d * sumi;
}

// E2: 8 independent accumulators (one per dp4a).
static __device__ __forceinline__ float vec_dot_iq3_xxs_q8_1_E2(const void * vbq, const block_q8_1 * bq8_1, const int kbx, const int iqs) {
    const block_iq3_xxs * bq3 = (const block_iq3_xxs *) vbq + kbx;
    const int2 q3_packed = make_int2(get_int_b2(bq3->qs, iqs), get_int_b2(bq3->qs, iqs+1));
    const unsigned char * q3 = (const unsigned char *) &q3_packed;
    const uint32_t aux32 = get_int_b2(bq3->qs, QK_K/16 + iqs/2);

    int s[8] = {0,0,0,0,0,0,0,0};
#pragma unroll
    for (int l0 = 0; l0 < 8; l0 += 2) {
        const int2 grid_pos = make_int2(iq3xxs_grid[q3[l0 + 0]], iq3xxs_grid[q3[l0 + 1]]);
        const uint32_t signs = unpack_ksigns(aux32 >> (7*l0/2));

        const int signs0 = __vcmpne4(signs & 0x08040201, 0);
        const int grid_l = __vsub4(grid_pos.x ^ signs0, signs0);
        const int u0 = get_int_b4(bq8_1[iqs/2].qs, l0 + 0);

        const int signs1 = __vcmpne4(signs & 0x80402010, 0);
        const int grid_h = __vsub4(grid_pos.y ^ signs1, signs1);
        const int u1 = get_int_b4(bq8_1[iqs/2].qs, l0 + 1);

        s[l0 + 0] = ggml_cuda_dp4a(grid_l, u0, s[l0 + 0]);
        s[l0 + 1] = ggml_cuda_dp4a(grid_h, u1, s[l0 + 1]);
    }

    int sumi = ((s[0] + s[1]) + (s[2] + s[3])) + ((s[4] + s[5]) + (s[6] + s[7]));
    const int ls = aux32 >> 28;
    sumi = (ls*sumi + sumi/2)/2;
    const float d = __half2float(__ushort_as_half(bq3->d)) *
                    __low2float(*(const __half2 *)&bq8_1[iqs/2].d);
    return d * sumi;
}

// E3: 8 independent accumulators + hoisted grid/qs gathers.
static __device__ __forceinline__ float vec_dot_iq3_xxs_q8_1_E3(const void * vbq, const block_q8_1 * bq8_1, const int kbx, const int iqs) {
    const block_iq3_xxs * bq3 = (const block_iq3_xxs *) vbq + kbx;
    const int2 q3_packed = make_int2(get_int_b2(bq3->qs, iqs), get_int_b2(bq3->qs, iqs+1));
    const unsigned char * q3 = (const unsigned char *) &q3_packed;
    const uint32_t aux32 = get_int_b2(bq3->qs, QK_K/16 + iqs/2);

    // 1. Hoist all q3 byte indices and aux signs.
    unsigned char qb[8];
    uint32_t sn[4];
#pragma unroll
    for (int l0 = 0; l0 < 8; l0 += 2) {
        qb[l0 + 0] = q3[l0 + 0];
        qb[l0 + 1] = q3[l0 + 1];
        sn[l0/2] = aux32 >> (7*l0/2);
    }
    // 2. Hoist all 8 u loads.
    const block_q8_1 * bq8_l = &bq8_1[iqs/2];
    int uL[4], uH[4];
    uL[0] = get_int_b4(bq8_l->qs, 0); uH[0] = get_int_b4(bq8_l->qs, 1);
    uL[1] = get_int_b4(bq8_l->qs, 2); uH[1] = get_int_b4(bq8_l->qs, 3);
    uL[2] = get_int_b4(bq8_l->qs, 4); uH[2] = get_int_b4(bq8_l->qs, 5);
    uL[3] = get_int_b4(bq8_l->qs, 6); uH[3] = get_int_b4(bq8_l->qs, 7);
    // 3. Hoist all 8 grid lookups + sign unpacking + sign xor/sub.
    int grL[4], grH[4];
#pragma unroll
    for (int l0 = 0; l0 < 8; l0 += 2) {
        const int2 grid_pos = make_int2(iq3xxs_grid[qb[l0 + 0]], iq3xxs_grid[qb[l0 + 1]]);
        const uint32_t signs = unpack_ksigns(sn[l0/2]);
        const int s0 = __vcmpne4(signs & 0x08040201, 0);
        const int s1 = __vcmpne4(signs & 0x80402010, 0);
        grL[l0/2] = __vsub4(grid_pos.x ^ s0, s0);
        grH[l0/2] = __vsub4(grid_pos.y ^ s1, s1);
    }
    // 4. All 8 dp4a into independent accumulators.
    int s[8];
    s[0] = ggml_cuda_dp4a(grL[0], uL[0], 0);
    s[1] = ggml_cuda_dp4a(grH[0], uH[0], 0);
    s[2] = ggml_cuda_dp4a(grL[1], uL[1], 0);
    s[3] = ggml_cuda_dp4a(grH[1], uH[1], 0);
    s[4] = ggml_cuda_dp4a(grL[2], uL[2], 0);
    s[5] = ggml_cuda_dp4a(grH[2], uH[2], 0);
    s[6] = ggml_cuda_dp4a(grL[3], uL[3], 0);
    s[7] = ggml_cuda_dp4a(grH[3], uH[3], 0);

    int sumi = ((s[0] + s[1]) + (s[2] + s[3])) + ((s[4] + s[5]) + (s[6] + s[7]));
    const int ls = aux32 >> 28;
    sumi = (ls*sumi + sumi/2)/2;
    const float d = __half2float(__ushort_as_half(bq3->d)) *
                    __low2float(*(const __half2 *)&bq8_1[iqs/2].d);
    return d * sumi;
}

// ===================== kernel =====================
enum MType { TYPE_Q4_0 = 2, TYPE_Q8_0 = 8, TYPE_IQ3_XXS = 18 };

constexpr int qk_of(MType t)  { return t == TYPE_Q4_0 ? QK4_0 : (t == TYPE_Q8_0 ? QK8_0 : QK_K); }
constexpr int qi_of(MType t)  { return t == TYPE_Q4_0 ? QI4_0 : (t == TYPE_Q8_0 ? QI8_0 : QI3_XXS); }
constexpr int vdr_of(MType t) { return 2; }

template<MType type>
constexpr int calc_nwarps(int ncols_dst) {
    if (ncols_dst == 1) {
        switch (type) {
            case TYPE_Q4_0:
            case TYPE_Q8_0:
                return 8;
            default:
                return 1;
        }
    }
    return 1;
}

template<MType type, int ncols_dst, bool has_fusion, int nwarps_tbl, int accum_variant>
__global__ __launch_bounds__(nwarps_tbl*WARP_SIZE, 1)
void mul_mat_vec_q(
        const void * vx_ptr, const void * vgate_ptr, const void * vy_ptr, float * dst_ptr,
        const uint32_t ncols_x, const uint32_t stride_row_x,
        const uint32_t stride_col_y_blocks, const uint32_t stride_col_dst) {
    constexpr int qk  = qk_of(type);
    constexpr int qi  = qi_of(type);
    constexpr int vdr = vdr_of(type);
    constexpr int nwarps = nwarps_tbl;
    constexpr int rows_per_cuda_block = 1;
    constexpr int warp_size = WARP_SIZE;

    const void * vx = vx_ptr;

    const int tid = warp_size*threadIdx.y + threadIdx.x;
    const int row0 = rows_per_cuda_block*blockIdx.x;
    const int blocks_per_row_x = ncols_x / qk;
    constexpr int blocks_per_iter = vdr * nwarps*warp_size / qi;

    const uint32_t channel_dst = blockIdx.y;
    const uint32_t channel_y = channel_dst;

    float tmp[ncols_dst][rows_per_cuda_block];
    [[maybe_unused]] float tmp_gate[ncols_dst][rows_per_cuda_block];
#pragma unroll
    for (int j = 0; j < ncols_dst; ++j) { tmp[j][0] = 0.0f; tmp_gate[j][0] = 0.0f; }

    const block_q8_1 * y = ((const block_q8_1 *) vy_ptr) + channel_y*stride_col_y_blocks;
    const int kbx_offset = row0*stride_row_x;

    for (int kbx = tid / (qi/vdr); kbx < blocks_per_row_x; kbx += blocks_per_iter) {
        const int kby = kbx * (qk/QK8_1);
        const int kqs = vdr * (tid % (qi/vdr));

#pragma unroll
        for (int j = 0; j < ncols_dst; ++j) {
#pragma unroll
            for (int i = 0; i < rows_per_cuda_block; ++i) {
                if (type == TYPE_IQ3_XXS) {
                    if constexpr (accum_variant == 0) {
                        tmp[j][i] += vec_dot_iq3_xxs_q8_1_V0(vx, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                    } else if constexpr (accum_variant == 1) {
                        tmp[j][i] += vec_dot_iq3_xxs_q8_1_E1(vx, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                    } else if constexpr (accum_variant == 2) {
                        tmp[j][i] += vec_dot_iq3_xxs_q8_1_E2(vx, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                    } else {
                        tmp[j][i] += vec_dot_iq3_xxs_q8_1_E3(vx, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                    }
                } else if (type == TYPE_Q4_0) {
                    tmp[j][i] += vec_dot_q4_0_q8_1(vx, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                } else {
                    tmp[j][i] += vec_dot_q8_0_q8_1(vx, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                }
                if (has_fusion) {
                    if (type == TYPE_IQ3_XXS) {
                        if constexpr (accum_variant == 0) {
                            tmp_gate[j][i] += vec_dot_iq3_xxs_q8_1_V0(vgate_ptr, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                        } else if constexpr (accum_variant == 1) {
                            tmp_gate[j][i] += vec_dot_iq3_xxs_q8_1_E1(vgate_ptr, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                        } else if constexpr (accum_variant == 2) {
                            tmp_gate[j][i] += vec_dot_iq3_xxs_q8_1_E2(vgate_ptr, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                        } else {
                            tmp_gate[j][i] += vec_dot_iq3_xxs_q8_1_E3(vgate_ptr, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                        }
                    } else if (type == TYPE_Q4_0) {
                        tmp_gate[j][i] += vec_dot_q4_0_q8_1(vgate_ptr, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                    } else {
                        tmp_gate[j][i] += vec_dot_q8_0_q8_1(vgate_ptr, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                    }
                }
            }
        }
    }

    __shared__ float tmp_shared[nwarps-1 > 0 ? nwarps-1 : 1][ncols_dst][rows_per_cuda_block][warp_size];
    [[maybe_unused]] __shared__ float tmp_shared_gate[(has_fusion && nwarps-1 > 0) ? nwarps-1 : 1][ncols_dst][rows_per_cuda_block][warp_size];

    if (threadIdx.y > 0) {
#pragma unroll
        for (int j = 0; j < ncols_dst; ++j) {
            tmp_shared[threadIdx.y-1][j][0][threadIdx.x] = tmp[j][0];
            if (has_fusion) tmp_shared_gate[threadIdx.y-1][j][0][threadIdx.x] = tmp_gate[j][0];
        }
    }
    __syncthreads();
    if (threadIdx.y > 0) {
        return;
    }

    float * dst = dst_ptr + channel_dst*stride_col_dst + row0;

#pragma unroll
    for (int j = 0; j < ncols_dst; ++j) {
#pragma unroll
        for (int l = 0; l < nwarps-1; ++l) {
            tmp[j][0] += tmp_shared[l][j][0][threadIdx.x];
            if (has_fusion) tmp_gate[j][0] += tmp_shared_gate[l][j][0][threadIdx.x];
        }
        tmp[j][0] = warp_reduce_sum<warp_size>(tmp[j][0]);
        if (has_fusion) tmp_gate[j][0] = warp_reduce_sum<warp_size>(tmp_gate[j][0]);
        if (threadIdx.x == 0) {
            float result = tmp[j][0];
            if (has_fusion) {
                result *= silu_single(tmp_gate[j][0]);
            }
            dst[j*stride_col_dst] = result;
        }
    }
}

template<MType type, int ncols_dst, bool has_fusion, int nwarps_tbl, int accum_variant>
static const void * pick_kernel_iq() {
    return (const void*)mul_mat_vec_q<type, ncols_dst, has_fusion, nwarps_tbl, accum_variant>;
}

template<int ncols_dst, bool has_fusion, int nwarps_tbl, int accum_variant>
static const void * pick_kernel_for_variant(int type_i) {
    if (type_i == TYPE_IQ3_XXS) return pick_kernel_iq<TYPE_IQ3_XXS, ncols_dst, has_fusion, nwarps_tbl, accum_variant>();
    if (type_i == TYPE_Q4_0)    return pick_kernel_iq<TYPE_Q4_0,    ncols_dst, has_fusion, nwarps_tbl, accum_variant>();
    return pick_kernel_iq<TYPE_Q8_0, ncols_dst, has_fusion, nwarps_tbl, accum_variant>();
}

template<int ncols_dst, bool has_fusion, int nwarps_tbl, int accum_variant>
static const void * pick_kernel_dispatch_nc(int type_i) {
    return pick_kernel_for_variant<ncols_dst, has_fusion, nwarps_tbl, accum_variant>(type_i);
}

template<int nwarps_tbl, int accum_variant>
static const void * pick_kernel_dispatch_nw(int type_i, int ncols_dst, bool has_fusion) {
    if (ncols_dst == 1) {
        return has_fusion
            ? pick_kernel_dispatch_nc<1, true,  nwarps_tbl, accum_variant>(type_i)
            : pick_kernel_dispatch_nc<1, false, nwarps_tbl, accum_variant>(type_i);
    }
    if (ncols_dst == 2) return pick_kernel_dispatch_nc<2, false, nwarps_tbl, accum_variant>(type_i);
    if (ncols_dst == 4) return pick_kernel_dispatch_nc<4, false, nwarps_tbl, accum_variant>(type_i);
    return pick_kernel_dispatch_nc<8, false, nwarps_tbl, accum_variant>(type_i);
}

template<int accum_variant>
static const void * pick_kernel_variant(int type_i, int ncols_dst, bool has_fusion) {
    if (ncols_dst == 1 && (type_i == TYPE_Q4_0 || type_i == TYPE_Q8_0)) {
        return pick_kernel_dispatch_nw<8, accum_variant>(type_i, 1, has_fusion);
    }
    return pick_kernel_dispatch_nw<1, accum_variant>(type_i, ncols_dst, has_fusion);
}

struct bench_result { double ms, p10, p90, mn, mx, bw_weight, bw_total; long long wg; int regs, occ_blocks; int variant; };

static bench_result bench_one(int type_i, int ncols_dst, int K, int N, int reps, bool fused, int variant) {
    size_t blk_size, blks_per_row;
    if (type_i == TYPE_IQ3_XXS)    { blk_size = 66; blks_per_row = K/256; }
    else if (type_i == TYPE_Q4_0)  { blk_size = 18; blks_per_row = K/32;  }
    else                           { blk_size = 34; blks_per_row = K/32;  }
    size_t row_bytes = blk_size * blks_per_row;
    size_t wbytes = row_bytes * N;
    size_t nw = fused ? 2 : 1;

    std::vector<unsigned char> h_w(wbytes*nw);
    srand(42 + type_i + K);
    for (size_t i = 0; i < h_w.size(); ++i) h_w[i] = rand() & 0xFF;
    for (size_t m = 0; m < nw; ++m) {
        for (size_t r = 0; r < N; ++r) {
            for (size_t b = 0; b < blks_per_row; ++b) {
                size_t off = m*wbytes + r*row_bytes + b*blk_size;
                unsigned short dh = 0x3800 + (rand() % 512);
                if (type_i == TYPE_IQ3_XXS) memcpy(&h_w[off + 64], &dh, 2);
                else                        memcpy(&h_w[off], &dh, 2);
            }
        }
    }
    void * d_w; CHECK_HIP(hipMalloc(&d_w, h_w.size()));
    CHECK_HIP(hipMemcpy(d_w, h_w.data(), h_w.size(), hipMemcpyHostToDevice));

    size_t ycol_bytes = (K/32) * sizeof(block_q8_1);
    size_t ybytes = ycol_bytes * ncols_dst;
    void * d_y; CHECK_HIP(hipMalloc(&d_y, ybytes));
    std::vector<unsigned char> h_y(ybytes);
    for (size_t i = 0; i < ybytes; ++i) h_y[i] = rand() & 0xFF;
    for (int j = 0; j < ncols_dst; ++j) {
        for (size_t b = 0; b < K/32; ++b) {
            size_t off = j*ycol_bytes + b*sizeof(block_q8_1);
            unsigned short ds[2];
            ds[0] = 0x3800 + (rand() % 256);
            ds[1] = 0x3800 + (rand() % 256);
            memcpy(&h_y[off], ds, 4);
        }
    }
    CHECK_HIP(hipMemcpy(d_y, h_y.data(), ybytes, hipMemcpyHostToDevice));

    float * d_dst; CHECK_HIP(hipMalloc(&d_dst, sizeof(float)*N*ncols_dst));

    int nwarps;
    if (ncols_dst == 1 && (type_i == TYPE_Q4_0 || type_i == TYPE_Q8_0)) nwarps = 8;
    else nwarps = 1;
    dim3 blocks(N, 1, 1), threads(WARP_SIZE, nwarps, 1);

    const void * fn;
    switch (variant) {
        case 0: fn = pick_kernel_variant<0>(type_i, ncols_dst, fused); break;
        case 1: fn = pick_kernel_variant<1>(type_i, ncols_dst, fused); break;
        case 2: fn = pick_kernel_variant<2>(type_i, ncols_dst, fused); break;
        case 3: fn = pick_kernel_variant<3>(type_i, ncols_dst, fused); break;
        default: fprintf(stderr, "bad variant %d\n", variant); exit(1);
    }
    if (!fn) { fprintf(stderr, "no kernel for type=%d variant=%d ncols=%d fused=%d\n", type_i, variant, ncols_dst, (int)fused); exit(1); }

    bench_result res{};
    res.variant = variant;
    CHECK_HIP(hipOccupancyMaxActiveBlocksPerMultiprocessor(&res.occ_blocks, fn, threads.x*threads.y, 0));
    hipFuncAttributes attr;
    CHECK_HIP(hipFuncGetAttributes(&attr, fn));
    res.regs = attr.numRegs;
    res.wg = (long long)threads.x*threads.y;

    uint32_t ncols_x = (uint32_t)K;
    uint32_t stride_row_x = (uint32_t)blks_per_row;
    uint32_t stride_col_y_blocks = (uint32_t)(K/32);
    uint32_t stride_col_dst = (uint32_t)N;

    auto launch_once = [&]() {
        void * args[] = {&d_w, &d_w, &d_y, &d_dst, &ncols_x, &stride_row_x, &stride_col_y_blocks, &stride_col_dst};
        CHECK_HIP(hipLaunchKernel(fn, blocks, threads, args, 0, 0));
    };

    for (int i = 0; i < 5; ++i) launch_once();
    CHECK_HIP(hipDeviceSynchronize());
    CHECK_HIP(hipGetLastError());

    hipEvent_t e0, e1; CHECK_HIP(hipEventCreate(&e0)); CHECK_HIP(hipEventCreate(&e1));
    std::vector<double> times;
    for (int r = 0; r < reps; ++r) {
        CHECK_HIP(hipEventRecord(e0, 0));
        launch_once();
        CHECK_HIP(hipEventRecord(e1, 0));
        CHECK_HIP(hipEventSynchronize(e1));
        float ms; CHECK_HIP(hipEventElapsedTime(&ms, e0, e1));
        times.push_back(ms);
    }
    std::sort(times.begin(), times.end());
    double med = times[times.size()/2];
    res.p10 = times[(times.size()-1)/10];
    res.p90 = times[(times.size()*9)/10];
    res.mn  = times.front();
    res.mx  = times.back();

    res.ms = med;
    res.bw_weight = ((double)wbytes*nw) / (med*1e-3) / 1e9;
    res.bw_total  = (((double)wbytes*nw) + (double)ybytes + sizeof(float)*N*ncols_dst) / (med*1e-3) / 1e9;

    hipFree(d_w); hipFree(d_y); hipFree(d_dst);
    return res;
}

// ===================== bit-exact verification =====================
// Compares dst from variant V (0..3) against V0 baseline on the SAME seeded buffers.
// IMPORTANT: We launch each variant independently and check dst V[i] == dst V0.
// For V0 == V0 the test trivially passes (sanity check).
struct verify_summary { int total_runs, identical_runs, total_diffs; double max_abs_diff; };

static verify_summary verify_variant(int variant, int type_i, int K, int N, bool fused, int seed, int n_runs) {
    size_t blk_size, blks_per_row;
    if (type_i == TYPE_IQ3_XXS)    { blk_size = 66; blks_per_row = K/256; }
    else                           { blk_size = 18; blks_per_row = K/32;  }
    size_t row_bytes = blk_size * blks_per_row;
    size_t wbytes = row_bytes * N;
    size_t nw = fused ? 2 : 1;

    std::vector<unsigned char> h_w(wbytes*nw);
    srand(seed + type_i + K);
    for (size_t i = 0; i < h_w.size(); ++i) h_w[i] = rand() & 0xFF;
    for (size_t m = 0; m < nw; ++m) {
        for (size_t r = 0; r < N; ++r) {
            for (size_t b = 0; b < blks_per_row; ++b) {
                size_t off = m*wbytes + r*row_bytes + b*blk_size;
                unsigned short dh = 0x3800 + (rand() % 512);
                if (type_i == TYPE_IQ3_XXS) memcpy(&h_w[off + 64], &dh, 2);
                else                        memcpy(&h_w[off], &dh, 2);
            }
        }
    }
    void * d_w; CHECK_HIP(hipMalloc(&d_w, h_w.size()));
    CHECK_HIP(hipMemcpy(d_w, h_w.data(), h_w.size(), hipMemcpyHostToDevice));

    size_t ycol_bytes = (K/32) * sizeof(block_q8_1);
    size_t ybytes = ycol_bytes * 1;
    void * d_y; CHECK_HIP(hipMalloc(&d_y, ybytes));
    std::vector<unsigned char> h_y(ybytes);
    for (size_t i = 0; i < ybytes; ++i) h_y[i] = rand() & 0xFF;
    for (size_t b = 0; b < K/32; ++b) {
        size_t off = b*sizeof(block_q8_1);
        unsigned short ds[2];
        ds[0] = 0x3800 + (rand() % 256);
        ds[1] = 0x3800 + (rand() % 256);
        memcpy(&h_y[off], ds, 4);
    }
    CHECK_HIP(hipMemcpy(d_y, h_y.data(), ybytes, hipMemcpyHostToDevice));

    float * d_dst0; CHECK_HIP(hipMalloc(&d_dst0, sizeof(float)*N));
    float * d_dstV; CHECK_HIP(hipMalloc(&d_dstV, sizeof(float)*N));

    int nwarps;
    if (type_i == TYPE_Q4_0 || type_i == TYPE_Q8_0) nwarps = 8;
    else nwarps = 1;
    dim3 blocks(N, 1, 1), threads(WARP_SIZE, nwarps, 1);

    const void * fn0;
    switch (0) {
        case 0: fn0 = pick_kernel_variant<0>(type_i, 1, fused); break;
        case 1: fn0 = pick_kernel_variant<1>(type_i, 1, fused); break;
        case 2: fn0 = pick_kernel_variant<2>(type_i, 1, fused); break;
        case 3: fn0 = pick_kernel_variant<3>(type_i, 1, fused); break;
        default: exit(1);
    }
    const void * fnV;
    switch (variant) {
        case 0: fnV = pick_kernel_variant<0>(type_i, 1, fused); break;
        case 1: fnV = pick_kernel_variant<1>(type_i, 1, fused); break;
        case 2: fnV = pick_kernel_variant<2>(type_i, 1, fused); break;
        case 3: fnV = pick_kernel_variant<3>(type_i, 1, fused); break;
        default: exit(1);
    }

    uint32_t ncols_x = (uint32_t)K;
    uint32_t stride_row_x = (uint32_t)blks_per_row;
    uint32_t stride_col_y_blocks = (uint32_t)(K/32);
    uint32_t stride_col_dst = (uint32_t)N;

    auto launch = [](const void * fn, float * dst, dim3 blocks, dim3 threads,
                     void * w, void * yv, uint32_t nx, uint32_t srx, uint32_t scyb, uint32_t scd) {
        void * args[] = {&w, &w, &yv, &dst, &nx, &srx, &scyb, &scd};
        CHECK_HIP(hipLaunchKernel(fn, blocks, threads, args, 0, 0));
    };

    verify_summary sum{};
    sum.total_runs = n_runs;
    sum.max_abs_diff = 0.0;
    for (int run = 0; run < n_runs; ++run) {
        for (int i = 0; i < 3; ++i) launch(fn0, d_dst0, blocks, threads, d_w, d_y, ncols_x, stride_row_x, stride_col_y_blocks, stride_col_dst);
        for (int i = 0; i < 3; ++i) launch(fnV, d_dstV, blocks, threads, d_w, d_y, ncols_x, stride_row_x, stride_col_y_blocks, stride_col_dst);
        launch(fn0, d_dst0, blocks, threads, d_w, d_y, ncols_x, stride_row_x, stride_col_y_blocks, stride_col_dst);
        launch(fnV, d_dstV, blocks, threads, d_w, d_y, ncols_x, stride_row_x, stride_col_y_blocks, stride_col_dst);
        CHECK_HIP(hipDeviceSynchronize());

        std::vector<float> h0(N), hV(N);
        CHECK_HIP(hipMemcpy(h0.data(), d_dst0, sizeof(float)*N, hipMemcpyDeviceToHost));
        CHECK_HIP(hipMemcpy(hV.data(), d_dstV, sizeof(float)*N, hipMemcpyDeviceToHost));

        bool identical = memcmp(h0.data(), hV.data(), sizeof(float)*N) == 0;
        long long ndiff = 0;
        for (int i = 0; i < N; ++i) {
            float d = fabsf(h0[i] - hV[i]);
            if (d > sum.max_abs_diff) sum.max_abs_diff = d;
            if (d != 0.0f) ++ndiff;
        }
        sum.total_diffs += (int)ndiff;
        if (identical) ++sum.identical_runs;
    }

    hipFree(d_w); hipFree(d_y); hipFree(d_dst0); hipFree(d_dstV);
    return sum;
}

int main(int argc, char ** argv) {
    if (argc >= 2 && strcmp(argv[1], "verify") == 0) {
        int seeds[3] = {42, 1337, 9001};
        int type_i = TYPE_IQ3_XXS;
        int total_checked = 0;
        int total_failed = 0;
        printf("=== exhaustive bit-exact verification: V0 vs {V0, E1, E2, E3} ===\n");
        printf("=== type=IQ3_XXS, shapes: ffn_down K=17408 N=5120 (unfused) and fused gateup K=5120 N=17408 ===\n\n");
        for (int s_idx = 0; s_idx < 3; ++s_idx) {
            int seed = seeds[s_idx];
            printf("[seed=%d]\n", seed);
            for (int shape = 0; shape < 2; ++shape) {
                int K = shape == 0 ? 17408 : 5120;
                int N = shape == 0 ? 5120  : 17408;
                bool fused = (shape == 1);
                for (int variant = 0; variant <= 3; ++variant) {
                    verify_summary v = verify_variant(variant, type_i, K, N, fused, seed, /*n_runs=*/4);
                    const char * name = (variant == 0) ? "V0" :
                                        (variant == 1) ? "E1" :
                                        (variant == 2) ? "E2" : "E3";
                    bool ok = (v.identical_runs == v.total_runs) && (v.total_diffs == 0);
                    if (!ok) ++total_failed;
                    ++total_checked;
                    printf("  shape=%s variant=%s identical_runs=%d/%d total_diffs=%d max_abs_diff=%.6g %s\n",
                           fused ? "ffn_gateup(fused)" : "ffn_down(unfused)",
                           name, v.identical_runs, v.total_runs, v.total_diffs, v.max_abs_diff,
                           ok ? "OK" : "NUMERICAL_PATH_CHANGED");
                    fflush(stdout);
                    if (!ok) {
                        printf("BIT-EXACT FAILED: variant %s differs from V0\n", name);
                        if (variant != 0) {
                            // Critical: E1/E2/E3 must match V0. If they don't, mark NUMERICAL_PATH_CHANGED and stop.
                            printf("NUMERICAL_PATH_CHANGED: aborting\n");
                            return 1;
                        }
                    }
                }
            }
        }
        printf("\n--- summary: %d configs checked, %d failed ---\n", total_checked, total_failed);
        if (total_failed == 0) {
            printf("ALL VARIANTS BIT-EXACT AGAINST V0\n");
            return 0;
        }
        return 1;
    }

    if (argc >= 5) {
        int type_i = atoi(argv[2]);
        int s = atoi(argv[3]);
        int b = atoi(argv[4]);
        bool fused = argc > 5 ? atoi(argv[5]) != 0 : (s == 1);
        int variant = argc > 6 ? atoi(argv[6]) : 0;
        int reps = argc > 7 ? atoi(argv[7]) : atoi(argv[1]);
        int K = s == 0 ? 17408 : 5120;
        int N = s == 0 ? 5120 : 17408;
        bench_result r = bench_one(type_i, b, K, N, reps, fused, variant);
        printf("type=%d shape=%d batch=%d fused=%d variant=%d ms=%.4f min=%.4f p10=%.4f p90=%.4f max=%.4f GBps_weight=%.1f regs=%d occ_blocks=%d wg=%lld\n",
               type_i, s, b, (int)fused, variant, r.ms, r.mn, r.p10, r.p90, r.mx, r.bw_weight, r.regs, r.occ_blocks, r.wg);
        return 0;
    }

    hipDeviceProp_t prop; CHECK_HIP(hipGetDeviceProperties(&prop, 0));
    printf("device=%s CUs=%d clock=%d MHz\n", prop.gcnArchName, prop.multiProcessorCount, prop.clockRate/1000);

    int reps = argc > 1 ? atoi(argv[1]) : 100;
    printf("reps=%d\n", reps);
    struct shape { const char * name; int K; int N; };
    shape shapes[2] = { {"ffn_down_K17408_N5120", 17408, 5120}, {"ffn_gateup_K5120_N17408", 5120, 17408} };

    for (int s = 0; s < 2; ++s) {
        printf("\n=== shape %s ===\n", shapes[s].name);
        printf("%-12s %-7s %11s %12s %13s %9s %6s %6s\n", "variant","batch","ms","GB/s(weight)","GB/s(total)","workgrp","regs","occ");
        bool fused = (s == 1);
        for (int variant = 0; variant <= 3; ++variant) {
            for (int b = 1; b <= 1; ++b) { // batch=1 only (the production path)
                bench_result r = bench_one(TYPE_IQ3_XXS, b, shapes[s].K, shapes[s].N, reps, fused, variant);
                const char * name = (variant == 0) ? "V0" :
                                    (variant == 1) ? "E1" :
                                    (variant == 2) ? "E2" : "E3";
                printf("%-12s %-7d %11.4f %12.1f %13.1f %9lld %6d %6d%s\n",
                       name, b, r.ms, r.bw_weight, r.bw_total, r.wg, r.regs, r.occ_blocks,
                       fused ? " [fused-glu]" : "");
                fflush(stdout);
            }
        }
    }
    return 0;
}
