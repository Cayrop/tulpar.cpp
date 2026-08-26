// Phase-4E / Subagent-E: independent-accumulator variants for the IQ3_XXS MMVQ kernel.
//
// Goal: break the 8-deep v_dot4_i32_iu8 serial chain (single sumi accumulator) by
// using independent accumulators, then combining. Verify bit-exactness vs V0 and
// measure throughput / stall / VGPR impact.
//
//   V0 : single sumi, 8 dp4a chained (baseline, 8-deep chain)
//   E1 : 4 accumulators (one per l0, each covers 2 dp4a), pairwise combine (depth 2)
//   E2 : 8 accumulators (one per dp4a), reduction-tree combine (depth 1)
//   E3 : E2 + hoisted gathers (all 8 grid values + u loads before any dp4a)
//
// Build:  hipcc -O3 -std=c++17 --offload-arch=gfx1101 -o mmvq_bench_accum mmvq_bench_accum.hip
// Run:    ./mmvq_bench_accum verify
//         ./mmvq_bench_accum bench
//
// NOTE: this is a synthetic replica harness (66-byte block layout, same hot-loop
// op counts as production). It is NOT a production source change.

#include <hip/hip_runtime.h>
#include <hip/hip_fp16.h>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cstdint>
#include <vector>
#include <string>
#include <algorithm>
#include <fstream>

#include "iq3xxs_grid.h"

#define CHECK_HIP(x) do { hipError_t e = (x); if (e != hipSuccess) { \
    fprintf(stderr, "HIP error %s at %s:%d\n", hipGetErrorString(e), __FILE__, __LINE__); exit(1);} } while (0)

// ===================== replicated definitions (ggml-common.h) =====================
#define QK4_0 32
#define QI4_0 (QK4_0 / (4 * 2))
#define QK8_0 32
#define QI8_0 (QK8_0 / (4 * 1))
#define QK8_1 32
#define QK_K 256
#define QR3_XXS 4
#define QI3_XXS (QK_K / (4 * QR3_XXS))

typedef struct { unsigned short d; unsigned char qs[QK4_0/2]; } block_q4_0; // 18 bytes
typedef struct { unsigned short d; unsigned char qs[QK8_0]; } block_q8_0;   // 34 bytes
typedef struct {
    union { struct { unsigned short d, s; }; }; // half2 ds at offset 0
    unsigned char qs[QK8_1];
} block_q8_1;   // 36 bytes
typedef struct { unsigned char qs[QK_K/4]; unsigned short d; } block_iq3_xxs; // 66 bytes
static_assert(sizeof(block_q4_0) == 18);
static_assert(sizeof(block_q8_0) == 34);
static_assert(sizeof(block_q8_1) == 36);
static_assert(sizeof(block_iq3_xxs) == 66);

// ===================== replicated helpers =====================
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

// ===================== HIP vendor shims (verbatim from vendors/hip.h) =====================
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

// ===================== vec_dot functions (verbatim logic from vecdotq.cuh) =====================
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
    return d4 * (sumi * ds8f.x - 4 * ds8f.y); // (8*vdr/QI4_0) == 4
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

// V0: single sumi accumulator (baseline, 8-deep dp4a chain)
static __device__ __forceinline__ float vec_dot_iq3_xxs_q8_1(const void * vbq, const block_q8_1 * bq8_1, const int kbx, const int iqs) {
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

// E1: 4 independent accumulators (one per l0, each covers 2 dp4a), pairwise combine
//     chain depth per accumulator = 2
static __device__ __forceinline__ float vec_dot_iq3_xxs_q8_1_e1(const void * vbq, const block_q8_1 * bq8_1, const int kbx, const int iqs) {
    const block_iq3_xxs * bq3 = (const block_iq3_xxs *) vbq + kbx;

    const int2 q3_packed = make_int2(get_int_b2(bq3->qs, iqs), get_int_b2(bq3->qs, iqs+1));
    const unsigned char * q3 = (const unsigned char *) &q3_packed;
    const uint32_t aux32 = get_int_b2(bq3->qs, QK_K/16 + iqs/2);

    int s0 = 0, s1 = 0, s2 = 0, s3 = 0;
    // l0 = 0
    {
        const int2 grid_pos = make_int2(iq3xxs_grid[q3[0]], iq3xxs_grid[q3[1]]);
        const uint32_t signs = unpack_ksigns(aux32 >> 0);
        const int signs0 = __vcmpne4(signs & 0x08040201, 0);
        const int grid_l = __vsub4(grid_pos.x ^ signs0, signs0);
        const int u0 = get_int_b4(bq8_1[iqs/2].qs, 0);
        const int signs1 = __vcmpne4(signs & 0x80402010, 0);
        const int grid_h = __vsub4(grid_pos.y ^ signs1, signs1);
        const int u1 = get_int_b4(bq8_1[iqs/2].qs, 1);
        s0 = ggml_cuda_dp4a(grid_l, u0, s0);
        s0 = ggml_cuda_dp4a(grid_h, u1, s0);
    }
    // l0 = 2
    {
        const int2 grid_pos = make_int2(iq3xxs_grid[q3[2]], iq3xxs_grid[q3[3]]);
        const uint32_t signs = unpack_ksigns(aux32 >> 7);
        const int signs0 = __vcmpne4(signs & 0x08040201, 0);
        const int grid_l = __vsub4(grid_pos.x ^ signs0, signs0);
        const int u0 = get_int_b4(bq8_1[iqs/2].qs, 2);
        const int signs1 = __vcmpne4(signs & 0x80402010, 0);
        const int grid_h = __vsub4(grid_pos.y ^ signs1, signs1);
        const int u1 = get_int_b4(bq8_1[iqs/2].qs, 3);
        s1 = ggml_cuda_dp4a(grid_l, u0, s1);
        s1 = ggml_cuda_dp4a(grid_h, u1, s1);
    }
    // l0 = 4
    {
        const int2 grid_pos = make_int2(iq3xxs_grid[q3[4]], iq3xxs_grid[q3[5]]);
        const uint32_t signs = unpack_ksigns(aux32 >> 14);
        const int signs0 = __vcmpne4(signs & 0x08040201, 0);
        const int grid_l = __vsub4(grid_pos.x ^ signs0, signs0);
        const int u0 = get_int_b4(bq8_1[iqs/2].qs, 4);
        const int signs1 = __vcmpne4(signs & 0x80402010, 0);
        const int grid_h = __vsub4(grid_pos.y ^ signs1, signs1);
        const int u1 = get_int_b4(bq8_1[iqs/2].qs, 5);
        s2 = ggml_cuda_dp4a(grid_l, u0, s2);
        s2 = ggml_cuda_dp4a(grid_h, u1, s2);
    }
    // l0 = 6
    {
        const int2 grid_pos = make_int2(iq3xxs_grid[q3[6]], iq3xxs_grid[q3[7]]);
        const uint32_t signs = unpack_ksigns(aux32 >> 21);
        const int signs0 = __vcmpne4(signs & 0x08040201, 0);
        const int grid_l = __vsub4(grid_pos.x ^ signs0, signs0);
        const int u0 = get_int_b4(bq8_1[iqs/2].qs, 6);
        const int signs1 = __vcmpne4(signs & 0x80402010, 0);
        const int grid_h = __vsub4(grid_pos.y ^ signs1, signs1);
        const int u1 = get_int_b4(bq8_1[iqs/2].qs, 7);
        s3 = ggml_cuda_dp4a(grid_l, u0, s3);
        s3 = ggml_cuda_dp4a(grid_h, u1, s3);
    }
    int sumi = (s0 + s1) + (s2 + s3);
    const int ls = aux32 >> 28;
    sumi = (ls*sumi + sumi/2)/2;
    const float d = __half2float(__ushort_as_half(bq3->d)) *
                    __low2float(*(const __half2 *)&bq8_1[iqs/2].d);
    return d * sumi;
}

// E2: 8 independent accumulators (one per dp4a), reduction-tree combine
//     chain depth per accumulator = 1
static __device__ __forceinline__ float vec_dot_iq3_xxs_q8_1_e2(const void * vbq, const block_q8_1 * bq8_1, const int kbx, const int iqs) {
    const block_iq3_xxs * bq3 = (const block_iq3_xxs *) vbq + kbx;

    const int2 q3_packed = make_int2(get_int_b2(bq3->qs, iqs), get_int_b2(bq3->qs, iqs+1));
    const unsigned char * q3 = (const unsigned char *) &q3_packed;
    const uint32_t aux32 = get_int_b2(bq3->qs, QK_K/16 + iqs/2);

    int a0 = 0, a1 = 0, a2 = 0, a3 = 0, a4 = 0, a5 = 0, a6 = 0, a7 = 0;
    // l0 = 0
    {
        const int2 grid_pos = make_int2(iq3xxs_grid[q3[0]], iq3xxs_grid[q3[1]]);
        const uint32_t signs = unpack_ksigns(aux32 >> 0);
        const int signs0 = __vcmpne4(signs & 0x08040201, 0);
        const int grid_l = __vsub4(grid_pos.x ^ signs0, signs0);
        const int u0 = get_int_b4(bq8_1[iqs/2].qs, 0);
        const int signs1 = __vcmpne4(signs & 0x80402010, 0);
        const int grid_h = __vsub4(grid_pos.y ^ signs1, signs1);
        const int u1 = get_int_b4(bq8_1[iqs/2].qs, 1);
        a0 = ggml_cuda_dp4a(grid_l, u0, a0);
        a1 = ggml_cuda_dp4a(grid_h, u1, a1);
    }
    // l0 = 2
    {
        const int2 grid_pos = make_int2(iq3xxs_grid[q3[2]], iq3xxs_grid[q3[3]]);
        const uint32_t signs = unpack_ksigns(aux32 >> 7);
        const int signs0 = __vcmpne4(signs & 0x08040201, 0);
        const int grid_l = __vsub4(grid_pos.x ^ signs0, signs0);
        const int u0 = get_int_b4(bq8_1[iqs/2].qs, 2);
        const int signs1 = __vcmpne4(signs & 0x80402010, 0);
        const int grid_h = __vsub4(grid_pos.y ^ signs1, signs1);
        const int u1 = get_int_b4(bq8_1[iqs/2].qs, 3);
        a2 = ggml_cuda_dp4a(grid_l, u0, a2);
        a3 = ggml_cuda_dp4a(grid_h, u1, a3);
    }
    // l0 = 4
    {
        const int2 grid_pos = make_int2(iq3xxs_grid[q3[4]], iq3xxs_grid[q3[5]]);
        const uint32_t signs = unpack_ksigns(aux32 >> 14);
        const int signs0 = __vcmpne4(signs & 0x08040201, 0);
        const int grid_l = __vsub4(grid_pos.x ^ signs0, signs0);
        const int u0 = get_int_b4(bq8_1[iqs/2].qs, 4);
        const int signs1 = __vcmpne4(signs & 0x80402010, 0);
        const int grid_h = __vsub4(grid_pos.y ^ signs1, signs1);
        const int u1 = get_int_b4(bq8_1[iqs/2].qs, 5);
        a4 = ggml_cuda_dp4a(grid_l, u0, a4);
        a5 = ggml_cuda_dp4a(grid_h, u1, a5);
    }
    // l0 = 6
    {
        const int2 grid_pos = make_int2(iq3xxs_grid[q3[6]], iq3xxs_grid[q3[7]]);
        const uint32_t signs = unpack_ksigns(aux32 >> 21);
        const int signs0 = __vcmpne4(signs & 0x08040201, 0);
        const int grid_l = __vsub4(grid_pos.x ^ signs0, signs0);
        const int u0 = get_int_b4(bq8_1[iqs/2].qs, 6);
        const int signs1 = __vcmpne4(signs & 0x80402010, 0);
        const int grid_h = __vsub4(grid_pos.y ^ signs1, signs1);
        const int u1 = get_int_b4(bq8_1[iqs/2].qs, 7);
        a6 = ggml_cuda_dp4a(grid_l, u0, a6);
        a7 = ggml_cuda_dp4a(grid_h, u1, a7);
    }
    int sumi = ((a0 + a1) + (a2 + a3)) + ((a4 + a5) + (a6 + a7));
    const int ls = aux32 >> 28;
    sumi = (ls*sumi + sumi/2)/2;
    const float d = __half2float(__ushort_as_half(bq3->d)) *
                    __low2float(*(const __half2 *)&bq8_1[iqs/2].d);
    return d * sumi;
}

// E3: E2 + hoisted gathers (all 8 grid values + u loads computed before any dp4a)
static __device__ __forceinline__ float vec_dot_iq3_xxs_q8_1_e3(const void * vbq, const block_q8_1 * bq8_1, const int kbx, const int iqs) {
    const block_iq3_xxs * bq3 = (const block_iq3_xxs *) vbq + kbx;

    const int2 q3_packed = make_int2(get_int_b2(bq3->qs, iqs), get_int_b2(bq3->qs, iqs+1));
    const unsigned char * q3 = (const unsigned char *) &q3_packed;
    const uint32_t aux32 = get_int_b2(bq3->qs, QK_K/16 + iqs/2);

    // Hoist all 8 grid gathers + sign processing + u loads before any dp4a
    int grid_l[4], grid_h[4], u[8];
#pragma unroll
    for (int l0 = 0; l0 < 8; l0 += 2) {
        const int2 grid_pos = make_int2(iq3xxs_grid[q3[l0 + 0]], iq3xxs_grid[q3[l0 + 1]]);
        const uint32_t signs = unpack_ksigns(aux32 >> (7*l0/2));
        const int signs0 = __vcmpne4(signs & 0x08040201, 0);
        grid_l[l0/2] = __vsub4(grid_pos.x ^ signs0, signs0);
        const int signs1 = __vcmpne4(signs & 0x80402010, 0);
        grid_h[l0/2] = __vsub4(grid_pos.y ^ signs1, signs1);
        u[l0]     = get_int_b4(bq8_1[iqs/2].qs, l0 + 0);
        u[l0 + 1] = get_int_b4(bq8_1[iqs/2].qs, l0 + 1);
    }
    int a0 = 0, a1 = 0, a2 = 0, a3 = 0, a4 = 0, a5 = 0, a6 = 0, a7 = 0;
    a0 = ggml_cuda_dp4a(grid_l[0], u[0], a0);
    a1 = ggml_cuda_dp4a(grid_h[0], u[1], a1);
    a2 = ggml_cuda_dp4a(grid_l[1], u[2], a2);
    a3 = ggml_cuda_dp4a(grid_h[1], u[3], a3);
    a4 = ggml_cuda_dp4a(grid_l[2], u[4], a4);
    a5 = ggml_cuda_dp4a(grid_h[2], u[5], a5);
    a6 = ggml_cuda_dp4a(grid_l[3], u[6], a6);
    a7 = ggml_cuda_dp4a(grid_h[3], u[7], a7);
    int sumi = ((a0 + a1) + (a2 + a3)) + ((a4 + a5) + (a6 + a7));
    const int ls = aux32 >> 28;
    sumi = (ls*sumi + sumi/2)/2;
    const float d = __half2float(__ushort_as_half(bq3->d)) *
                    __low2float(*(const __half2 *)&bq8_1[iqs/2].d);
    return d * sumi;
}

// ===================== kernel (replicated from mmvq.cu lines 544-757) =====================
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

// accum: 0=V0 (single sumi), 1=E1 (4 accum), 2=E2 (8 accum), 3=E3 (8 accum + hoisted)
template<MType type, int ncols_dst, bool has_fusion = false,
         int nwarps_tbl = calc_nwarps<type>(ncols_dst), bool lds_grid = false, int accum = 0>
__global__ __launch_bounds__(nwarps_tbl*WARP_SIZE, 1)
void mul_mat_vec_q(
        const void * vx_ptr, const void * vgate_ptr, const void * vy_ptr, float * dst_ptr,
        const uint32_t ncols_x, const uint32_t stride_row_x,
        const uint32_t stride_col_y_blocks, const uint32_t stride_col_dst) {
    constexpr int qk  = qk_of(type);
    constexpr int qi  = qi_of(type);
    constexpr int vdr = vdr_of(type);
    constexpr int nwarps = nwarps_tbl;
    constexpr int rows_per_cuda_block = 1; // RDNA3 table -> always 1
    constexpr int warp_size = WARP_SIZE;

    const void * vx = vx_ptr;

    const int tid = warp_size*threadIdx.y + threadIdx.x;
    const int row0 = rows_per_cuda_block*blockIdx.x;
    const int blocks_per_row_x = ncols_x / qk;
    constexpr int blocks_per_iter = vdr * nwarps*warp_size / qi;

    const uint32_t channel_dst = blockIdx.y;
    const uint32_t channel_y = channel_dst; // ids==nullptr, single channel group

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
                    if constexpr (accum == 0) {
                        tmp[j][i] += vec_dot_iq3_xxs_q8_1(vx, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                    } else if constexpr (accum == 1) {
                        tmp[j][i] += vec_dot_iq3_xxs_q8_1_e1(vx, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                    } else if constexpr (accum == 2) {
                        tmp[j][i] += vec_dot_iq3_xxs_q8_1_e2(vx, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                    } else {
                        tmp[j][i] += vec_dot_iq3_xxs_q8_1_e3(vx, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                    }
                } else if (type == TYPE_Q4_0) {
                    tmp[j][i] += vec_dot_q4_0_q8_1(vx, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                } else {
                    tmp[j][i] += vec_dot_q8_0_q8_1(vx, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                }
                if (has_fusion) {
                    if (type == TYPE_IQ3_XXS) {
                        if constexpr (accum == 0) {
                            tmp_gate[j][i] += vec_dot_iq3_xxs_q8_1(vgate_ptr, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                        } else if constexpr (accum == 1) {
                            tmp_gate[j][i] += vec_dot_iq3_xxs_q8_1_e1(vgate_ptr, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                        } else if constexpr (accum == 2) {
                            tmp_gate[j][i] += vec_dot_iq3_xxs_q8_1_e2(vgate_ptr, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                        } else {
                            tmp_gate[j][i] += vec_dot_iq3_xxs_q8_1_e3(vgate_ptr, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
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

// ===================== dispatch =====================
template<MType type>
static const void * pick_kernel(int ncols_dst, bool has_fusion) {
    switch (ncols_dst) {
        case 1: return has_fusion ? (const void*)mul_mat_vec_q<type,1,true>  : (const void*)mul_mat_vec_q<type,1,false>;
        case 2: return (const void*)mul_mat_vec_q<type,2,false>;
        case 4: return (const void*)mul_mat_vec_q<type,4,false>;
        case 8: return (const void*)mul_mat_vec_q<type,8,false>;
    }
    return nullptr;
}

// E-variant dispatch: accum in {0,1,2,3}, IQ3_XXS only, batch=1
static const void * pick_kernel_e(int accum, int ncols_dst, bool has_fusion) {
    switch (accum) {
        case 0: return pick_kernel<TYPE_IQ3_XXS>(ncols_dst, has_fusion);
        case 1: return has_fusion ? (const void*)mul_mat_vec_q<TYPE_IQ3_XXS,1,true,1,false,1>
                                  : (const void*)mul_mat_vec_q<TYPE_IQ3_XXS,1,false,1,false,1>;
        case 2: return has_fusion ? (const void*)mul_mat_vec_q<TYPE_IQ3_XXS,1,true,1,false,2>
                                  : (const void*)mul_mat_vec_q<TYPE_IQ3_XXS,1,false,1,false,2>;
        case 3: return has_fusion ? (const void*)mul_mat_vec_q<TYPE_IQ3_XXS,1,true,1,false,3>
                                  : (const void*)mul_mat_vec_q<TYPE_IQ3_XXS,1,false,1,false,3>;
    }
    return nullptr;
}

static int nwarps_for(int type_i, int ncols_dst, int nwarps_ovr = 0) {
    if (nwarps_ovr > 0 && ncols_dst == 1 && type_i == TYPE_IQ3_XXS) return nwarps_ovr;
    if (ncols_dst == 1 && (type_i == TYPE_Q4_0 || type_i == TYPE_Q8_0)) return 8;
    return 1;
}

struct bench_result { double ms, p10, p90, mn, mx, bw_weight, bw_total; long long wg; int regs, occ_blocks; };

// E-variant bench: uses pick_kernel_e
static bench_result bench_e(int accum, int ncols_dst, int K, int N, int reps, bool fused) {
    size_t blk_size = 66, blks_per_row = K/256;
    size_t row_bytes = blk_size * blks_per_row;
    size_t wbytes = row_bytes * N;
    size_t nw = fused ? 2 : 1;

    std::vector<unsigned char> h_w(wbytes*nw);
    srand(42 + TYPE_IQ3_XXS + K);
    for (size_t i = 0; i < h_w.size(); ++i) h_w[i] = rand() & 0xFF;
    for (size_t m = 0; m < nw; ++m) {
        for (size_t r = 0; r < N; ++r) {
            for (size_t b = 0; b < blks_per_row; ++b) {
                size_t off = m*wbytes + r*row_bytes + b*blk_size;
                unsigned short dh = 0x3800 + (rand() % 512);
                memcpy(&h_w[off + 64], &dh, 2);
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

    const int nwarps = 1;
    dim3 blocks(N, 1, 1), threads(WARP_SIZE, nwarps, 1);

    const void * fn = pick_kernel_e(accum, ncols_dst, fused);
    if (!fn) { fprintf(stderr, "no kernel for accum=%d\n", accum); exit(1); }

    bench_result res{};
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

// Bit-exact verification: V0 vs E1/E2/E3, byte-for-byte dst comparison.
// Uses deterministic grid sweep (all 256 grid entries) + multiple random seeds.
static void verify_e(int K, int N, bool fused, std::ofstream & log) {
    size_t blk_size = 66, blks_per_row = K/256;
    size_t row_bytes = blk_size * blks_per_row;
    size_t wbytes = row_bytes * N;
    size_t nw = fused ? 2 : 1;

    // deterministic grid sweep: byte at position p = (p + shift) % 256
    // ensures all 256 grid entries are exercised
    for (uint8_t shift : {0, 1, 2, 3}) {
        std::vector<unsigned char> h_w(wbytes*nw);
        for (size_t i = 0; i < h_w.size(); ++i) h_w[i] = (unsigned char)((i + shift) % 256);
        for (size_t m = 0; m < nw; ++m) {
            for (size_t r = 0; r < N; ++r) {
                for (size_t b = 0; b < blks_per_row; ++b) {
                    size_t off = m*wbytes + r*row_bytes + b*blk_size;
                    unsigned short dh = 0x3800 + ((r + b + shift) % 512);
                    memcpy(&h_w[off + 64], &dh, 2);
                }
            }
        }
        void * d_w; CHECK_HIP(hipMalloc(&d_w, h_w.size()));
        CHECK_HIP(hipMemcpy(d_w, h_w.data(), h_w.size(), hipMemcpyHostToDevice));

        size_t ycol_bytes = (K/32) * sizeof(block_q8_1);
        size_t ybytes = ycol_bytes * 1;
        void * d_y; CHECK_HIP(hipMalloc(&d_y, ybytes));
        std::vector<unsigned char> h_y(ybytes);
        for (size_t i = 0; i < ybytes; ++i) h_y[i] = (unsigned char)((i + shift) % 256);
        for (size_t b = 0; b < K/32; ++b) {
            size_t off = b*sizeof(block_q8_1);
            unsigned short ds[2];
            ds[0] = 0x3800 + ((b + shift) % 256);
            ds[1] = 0x3800 + ((b + shift + 1) % 256);
            memcpy(&h_y[off], ds, 4);
        }
        CHECK_HIP(hipMemcpy(d_y, h_y.data(), ybytes, hipMemcpyHostToDevice));

        float * d_dst0; CHECK_HIP(hipMalloc(&d_dst0, sizeof(float)*N));
        float * d_dste; CHECK_HIP(hipMalloc(&d_dste, sizeof(float)*N));

        const int nwarps = 1;
        dim3 blocks(N, 1, 1), threads(WARP_SIZE, nwarps, 1);

        uint32_t ncols_x = (uint32_t)K;
        uint32_t stride_row_x = (uint32_t)blks_per_row;
        uint32_t stride_col_y_blocks = (uint32_t)(K/32);
        uint32_t stride_col_dst = (uint32_t)N;

        auto launch = [](const void * fn, float * dst, dim3 blocks, dim3 threads,
                         void * w, void * yv, uint32_t nx, uint32_t srx, uint32_t scyb, uint32_t scd) {
            void * args[] = {&w, &w, &yv, &dst, &nx, &srx, &scyb, &scd};
            CHECK_HIP(hipLaunchKernel(fn, blocks, threads, args, 0, 0));
        };

        const void * fn0 = pick_kernel_e(0, 1, fused);
        for (int accum = 1; accum <= 3; ++accum) {
            const void * fne = pick_kernel_e(accum, 1, fused);
            launch(fn0, d_dst0, blocks, threads, d_w, d_y, ncols_x, stride_row_x, stride_col_y_blocks, stride_col_dst);
            launch(fne, d_dste, blocks, threads, d_w, d_y, ncols_x, stride_row_x, stride_col_y_blocks, stride_col_dst);
            CHECK_HIP(hipDeviceSynchronize());

            std::vector<float> h0(N), he(N);
            CHECK_HIP(hipMemcpy(h0.data(), d_dst0, sizeof(float)*N, hipMemcpyDeviceToHost));
            CHECK_HIP(hipMemcpy(he.data(), d_dste, sizeof(float)*N, hipMemcpyDeviceToHost));

            bool identical = memcmp(h0.data(), he.data(), sizeof(float)*N) == 0;
            size_t first_diff = 0;
            if (!identical) {
                for (size_t i = 0; i < N; ++i) {
                    if (h0[i] != he[i]) { first_diff = i; break; }
                }
            }
            char vname[4];
            snprintf(vname, sizeof(vname), "E%d", accum);
            log << "sweep_shift=" << (int)shift << " " << vname << " fused=" << (fused?1:0)
                << " ok=" << (identical?1:0) << " first_diff=" << first_diff << " n=" << N << "\n";
            printf("verify sweep_shift=%d %s fused=%d -> %s (n=%d)\n",
                   (int)shift, vname, (int)fused, identical ? "BIT-EXACT" : "MISMATCH", (int)N);
        }

        hipFree(d_w); hipFree(d_y); hipFree(d_dst0); hipFree(d_dste);
    }

    // multiple random seeds
    for (uint32_t seed : {42u, 1u, 2u, 3u, 12345u, 99999u}) {
        std::vector<unsigned char> h_w(wbytes*nw);
        srand(seed);
        for (size_t i = 0; i < h_w.size(); ++i) h_w[i] = rand() & 0xFF;
        for (size_t m = 0; m < nw; ++m) {
            for (size_t r = 0; r < N; ++r) {
                for (size_t b = 0; b < blks_per_row; ++b) {
                    size_t off = m*wbytes + r*row_bytes + b*blk_size;
                    unsigned short dh = 0x3800 + (rand() % 512);
                    memcpy(&h_w[off + 64], &dh, 2);
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
        float * d_dste; CHECK_HIP(hipMalloc(&d_dste, sizeof(float)*N));

        const int nwarps = 1;
        dim3 blocks(N, 1, 1), threads(WARP_SIZE, nwarps, 1);

        uint32_t ncols_x = (uint32_t)K;
        uint32_t stride_row_x = (uint32_t)blks_per_row;
        uint32_t stride_col_y_blocks = (uint32_t)(K/32);
        uint32_t stride_col_dst = (uint32_t)N;

        auto launch = [](const void * fn, float * dst, dim3 blocks, dim3 threads,
                         void * w, void * yv, uint32_t nx, uint32_t srx, uint32_t scyb, uint32_t scd) {
            void * args[] = {&w, &w, &yv, &dst, &nx, &srx, &scyb, &scd};
            CHECK_HIP(hipLaunchKernel(fn, blocks, threads, args, 0, 0));
        };

        const void * fn0 = pick_kernel_e(0, 1, fused);
        for (int accum = 1; accum <= 3; ++accum) {
            const void * fne = pick_kernel_e(accum, 1, fused);
            launch(fn0, d_dst0, blocks, threads, d_w, d_y, ncols_x, stride_row_x, stride_col_y_blocks, stride_col_dst);
            launch(fne, d_dste, blocks, threads, d_w, d_y, ncols_x, stride_row_x, stride_col_y_blocks, stride_col_dst);
            CHECK_HIP(hipDeviceSynchronize());

            std::vector<float> h0(N), he(N);
            CHECK_HIP(hipMemcpy(h0.data(), d_dst0, sizeof(float)*N, hipMemcpyDeviceToHost));
            CHECK_HIP(hipMemcpy(he.data(), d_dste, sizeof(float)*N, hipMemcpyDeviceToHost));

            bool identical = memcmp(h0.data(), he.data(), sizeof(float)*N) == 0;
            size_t first_diff = 0;
            if (!identical) {
                for (size_t i = 0; i < N; ++i) {
                    if (h0[i] != he[i]) { first_diff = i; break; }
                }
            }
            char vname[4];
            snprintf(vname, sizeof(vname), "E%d", accum);
            log << "seed=" << seed << " " << vname << " fused=" << (fused?1:0)
                << " ok=" << (identical?1:0) << " first_diff=" << first_diff << " n=" << N << "\n";
            printf("verify seed=%u %s fused=%d -> %s (n=%d)\n",
                   seed, vname, (int)fused, identical ? "BIT-EXACT" : "MISMATCH", (int)N);
        }

        hipFree(d_w); hipFree(d_y); hipFree(d_dst0); hipFree(d_dste);
    }
}

int main(int argc, char ** argv) {
    if (argc < 2) {
        printf("usage: %s verify|bench [csv]\n", argv[0]);
        return 1;
    }

    if (strcmp(argv[1], "verify") == 0) {
        std::ofstream log("bit_exact_check.log");
        log << "bit-exact check: V0 vs E1/E2/E3 (IQ3_XXS MMVQ, gfx1101)\n";
        log << "integer addition is associative; regrouping dp4a accumulation must be bit-exact\n\n";

        verify_e(17408, 5120, false, log); // ffn_down unfused
        verify_e(5120, 17408, true, log);  // fused gateup pair

        log << "\nRESULT: see above (all ok=1 means ALL_BIT_EXACT)\n";
        printf("\nverify complete\n");
        return 0;
    }

    if (strcmp(argv[1], "bench") == 0) {
        const int reps = 100;
        const char * csv_path = argc > 2 ? argv[2] : "raw_measurements.csv";
        std::ofstream csv(csv_path);
        csv << "case,variant,K,N,ncols_dst,fused,median_ms,p10_ms,p90_ms,gbps_weight,gbps_total,regs,occ_blocks\n";

        struct Case { const char * name; int K; int N; int ncols_dst; bool fused; };
        Case cases[] = {
            {"ffn_down",   17408, 5120, 1, false},
            {"ffn_gateup", 5120,  17408, 1, true},
        };

        for (auto & c : cases) {
            for (int accum = 0; accum <= 3; ++accum) {
                bench_result r = bench_e(accum, c.ncols_dst, c.K, c.N, reps, c.fused);
                char vname[4];
                snprintf(vname, sizeof(vname), "%s", accum == 0 ? "V0" : (accum == 1 ? "E1" : (accum == 2 ? "E2" : "E3")));
                csv << c.name << "," << vname << "," << c.K << "," << c.N << ","
                    << c.ncols_dst << "," << (c.fused?1:0) << ","
                    << r.ms << "," << r.p10 << "," << r.p90 << ","
                    << r.bw_weight << "," << r.bw_total << ","
                    << r.regs << "," << r.occ_blocks << "\n";
                printf("%s %s: median=%.4f ms  GB/s(weight)=%.1f  GB/s(total)=%.1f  regs=%d occ=%d\n",
                       c.name, vname, r.ms, r.bw_weight, r.bw_total, r.regs, r.occ_blocks);
            }
        }
        printf("\nbench complete -> %s\n", csv_path);
        return 0;
    }

    printf("unknown mode %s\n", argv[1]);
    return 1;
}
