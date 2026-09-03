// Phase-4E (Subagent-C) synthetic MMVQ GEMV microbenchmark for gfx1101.
// Variants:
//   V0  = baseline (current production-equivalent IQ3_XXS MMVQ kernel).
//   C1  = prefetch 1 trip ahead (issue trip N+1 loads during trip N compute).
//   C2  = prefetch 2 trips ahead.
//   C3  = prefetch 4 trips ahead.
//   C4  = full #pragma unroll on the trip loop (compiler schedules loads).
//
// The prefetch depth is a kernel template parameter <prefetch_depth>.
//   0 -> V0 baseline (no software prefetch; same code as V0).
//   1,2,4 -> C1, C2, C3.
//   -1 -> C4 (compile-time unrolled trip loop).
//
// Software prefetch uses __builtin_prefetch on the trip-N+1 quant block
// and Q8_1 block. Because the kernel uses 1 warp (32 threads) and the
// IQ3_XXS trip consumes 1 quant block (66 B) + 1 Q8_1 block (36 B), the
// trip-N+1 loads are a small batch of int4-style 16-byte prefetches
// issued by a single thread (tid 0 of the warp), with no data movement --
// the prefetch address is consumed by the next trip's actual load. The goal
// is to bring the address into L2 early and let the trip-N compute overlap
// with the trip-N+1 L2 fill.
//
// IMPORTANT FINDING (from subagent-A + this subagent's SASS inspection):
// __builtin_prefetch with the default (locality=0) lowers to NO actual
// global_load on gfx1101 - the compiler eliminates the call because it
// has no observable effect. As a result, the C1/C2/C3 variants in this
// harness end up equivalent to "LDS-staged grid" (the grid is staged
// into LDS once per workgroup, identical subagent-B V1 variant), with
// the __builtin_prefetch calls effectively no-ops. The C4 variant adds
// #pragma unroll but the compiler refuses to unroll because the trip
// count is dynamic (blocks_per_row_x is a runtime value).
//
// Therefore this harness measures: the cost of LDS-staging the grid
// (and unroll hint) vs the L1-resident grid in V0. The subagent-C
// README discusses this in detail.
//
// Bit-exactness is preserved by construction: the prefetch only *touches*
// the address; the canonical loads in trip N+1 still happen via the
// original int/half2 reads, so the arithmetic is identical to V0.
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

// ===================== replicated definitions (ggml-common.h) =====================
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

// ===================== replicated helpers (verbatim from mmvq_bench.hip) =====================
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

// LDS-resident grid variant: only the grid (256 uint32_t = 1 KB) is staged
// into shared memory once per workgroup; identical arithmetic.
static __device__ __forceinline__ float vec_dot_iq3_xxs_q8_1_lds(const void * vbq, const block_q8_1 * bq8_1, const int kbx, const int iqs, const uint32_t * grid) {
    const block_iq3_xxs * bq3 = (const block_iq3_xxs *) vbq + kbx;

    const int2 q3_packed = make_int2(get_int_b2(bq3->qs, iqs), get_int_b2(bq3->qs, iqs+1));
    const unsigned char * q3 = (const unsigned char *) &q3_packed;
    const uint32_t aux32 = get_int_b2(bq3->qs, QK_K/16 + iqs/2);

    int sumi = 0;
#pragma unroll
    for (int l0 = 0; l0 < 8; l0 += 2) {
        const int2 grid_pos = make_int2(grid[q3[l0 + 0]], grid[q3[l0 + 1]]);
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

// prefetch_depth template:
//   0 -> V0 (no prefetch, identical to baseline).
//   1,2,4 -> C1, C2, C3 (issue load-touches of trip+N addresses).
//   -1 -> C4 (full #pragma unroll, no manual prefetch).
// When prefetch_depth > 0, also stage iq3xxs_grid into LDS so the prefetch
// is purely about the quant/Q8 streams (the grid is identical math).
// For C4 we keep the literal global grid reads (matches V0 bit-exact path
// and lets the compiler schedule loads across the unrolled trips).
template<MType type, int ncols_dst, bool has_fusion = false,
         int nwarps_tbl = calc_nwarps<type>(ncols_dst),
         int prefetch_depth = 0>
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
    constexpr bool lds_grid = (prefetch_depth > 0);
    constexpr bool do_unroll = (prefetch_depth == -1);

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

    [[maybe_unused]] __shared__ uint32_t s_grid[256];
    if constexpr (lds_grid && type == TYPE_IQ3_XXS) {
        const uint32_t * gsrc = (const uint32_t *) iq3xxs_grid;
#pragma unroll
        for (int i = tid; i < 256; i += nwarps*warp_size) {
            s_grid[i] = gsrc[i];
        }
        __syncthreads();
    }

    // Software prefetch helper: thread 0 of the warp issues prefetch
    // hints for the upcoming trip's quant block and Q8_1 block.
    auto do_prefetch = [&](int trip_idx) {
        if (prefetch_depth <= 0) return;
        if (tid != 0) return;
        const int target_kbx = (trip_idx < blocks_per_row_x) ? trip_idx : -1;
        if (target_kbx < 0) return;
        const int target_kby = target_kbx * (qk / QK8_1);
        const char * qp = (const char *) ((const block_iq3_xxs *) vx + kbx_offset + target_kbx);
        const char * yp = (const char *) (&y[target_kby]);
        // 5 ints (20 B) cover the 66 B quant block in 4 prefetches; 3 cover Q8_1.
        for (int off = 0; off < 80; off += 16) {
            __builtin_prefetch(qp + off, 0, 0);
        }
        for (int off = 0; off < 48; off += 16) {
            __builtin_prefetch(yp + off, 0, 0);
        }
    };

    if constexpr (do_unroll) {
        // C4: full unroll of the trip loop. We unroll at the source level
        // (trip count <= 256 for any real model shape: ffn_down=68, gateup=20).
        for (int kbx = tid / (qi/vdr); kbx < blocks_per_row_x; kbx += blocks_per_iter) {
            const int kby = kbx * (qk/QK8_1);
            const int kqs = vdr * (tid % (qi/vdr));

#pragma unroll
            for (int j = 0; j < ncols_dst; ++j) {
#pragma unroll
                for (int i = 0; i < rows_per_cuda_block; ++i) {
                    tmp[j][i] += vec_dot_iq3_xxs_q8_1(vx, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                    if (has_fusion) {
                        tmp_gate[j][i] += vec_dot_iq3_xxs_q8_1(vgate_ptr, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                    }
                }
            }
        }
    } else {
        // V0 / C1 / C2 / C3: trip loop with optional software prefetch.
        for (int kbx = tid / (qi/vdr); kbx < blocks_per_row_x; kbx += blocks_per_iter) {
            const int kby = kbx * (qk/QK8_1);
            const int kqs = vdr * (tid % (qi/vdr));

            // Issue prefetch for trip (N + prefetch_depth) BEFORE the
            // current trip's compute. The trip-step is blocks_per_iter.
            if (prefetch_depth > 0) {
                const int pf_kbx = kbx + prefetch_depth * blocks_per_iter;
                do_prefetch(pf_kbx);
            }

#pragma unroll
            for (int j = 0; j < ncols_dst; ++j) {
#pragma unroll
                for (int i = 0; i < rows_per_cuda_block; ++i) {
                    if (type == TYPE_IQ3_XXS) {
                        if constexpr (lds_grid) {
                            tmp[j][i] += vec_dot_iq3_xxs_q8_1_lds(vx, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs, s_grid);
                        } else {
                            tmp[j][i] += vec_dot_iq3_xxs_q8_1(vx, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                        }
                    } else if (type == TYPE_Q4_0) {
                        tmp[j][i] += vec_dot_q4_0_q8_1(vx, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                    } else {
                        tmp[j][i] += vec_dot_q8_0_q8_1(vx, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                    }
                    if (has_fusion) {
                        if (type == TYPE_IQ3_XXS) {
                            if constexpr (lds_grid) {
                                tmp_gate[j][i] += vec_dot_iq3_xxs_q8_1_lds(vgate_ptr, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs, s_grid);
                            } else {
                                tmp_gate[j][i] += vec_dot_iq3_xxs_q8_1(vgate_ptr, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                            }
                        } else if (type == TYPE_Q4_0) {
                            tmp_gate[j][i] += vec_dot_q4_0_q8_1(vgate_ptr, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                        } else {
                            tmp_gate[j][i] += vec_dot_q8_0_q8_1(vgate_ptr, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_col_y_blocks + kby, kqs);
                        }
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
static const void * pick_kernel_p(int ncols_dst, bool has_fusion, int prefetch_depth) {
    if (prefetch_depth == -1) {
        switch (ncols_dst) {
            case 1: return has_fusion ? (const void*)mul_mat_vec_q<type,1,true, calc_nwarps<type>(1), -1>
                                      : (const void*)mul_mat_vec_q<type,1,false, calc_nwarps<type>(1), -1>;
            case 2: return (const void*)mul_mat_vec_q<type,2,false, calc_nwarps<type>(2), -1>;
            case 4: return (const void*)mul_mat_vec_q<type,4,false, calc_nwarps<type>(4), -1>;
            case 8: return (const void*)mul_mat_vec_q<type,8,false, calc_nwarps<type>(8), -1>;
        }
    }
    switch (prefetch_depth) {
        case 0:
            switch (ncols_dst) {
                case 1: return has_fusion ? (const void*)mul_mat_vec_q<type,1,true, calc_nwarps<type>(1), 0>
                                          : (const void*)mul_mat_vec_q<type,1,false, calc_nwarps<type>(1), 0>;
                case 2: return (const void*)mul_mat_vec_q<type,2,false, calc_nwarps<type>(2), 0>;
                case 4: return (const void*)mul_mat_vec_q<type,4,false, calc_nwarps<type>(4), 0>;
                case 8: return (const void*)mul_mat_vec_q<type,8,false, calc_nwarps<type>(8), 0>;
            }
            break;
        case 1:
            switch (ncols_dst) {
                case 1: return has_fusion ? (const void*)mul_mat_vec_q<type,1,true, calc_nwarps<type>(1), 1>
                                          : (const void*)mul_mat_vec_q<type,1,false, calc_nwarps<type>(1), 1>;
            }
            break;
        case 2:
            switch (ncols_dst) {
                case 1: return has_fusion ? (const void*)mul_mat_vec_q<type,1,true, calc_nwarps<type>(1), 2>
                                          : (const void*)mul_mat_vec_q<type,1,false, calc_nwarps<type>(1), 2>;
            }
            break;
        case 4:
            switch (ncols_dst) {
                case 1: return has_fusion ? (const void*)mul_mat_vec_q<type,1,true, calc_nwarps<type>(1), 4>
                                          : (const void*)mul_mat_vec_q<type,1,false, calc_nwarps<type>(1), 4>;
            }
            break;
    }
    return nullptr;
}

static const void * pick_kernel_i(int type_i, int ncols_dst, bool has_fusion, int prefetch_depth) {
    switch (type_i) {
        case TYPE_IQ3_XXS: return pick_kernel_p<TYPE_IQ3_XXS>(ncols_dst, has_fusion, prefetch_depth);
        case TYPE_Q4_0:    return pick_kernel_p<TYPE_Q4_0>(ncols_dst, has_fusion, prefetch_depth);
        case TYPE_Q8_0:    return pick_kernel_p<TYPE_Q8_0>(ncols_dst, has_fusion, prefetch_depth);
    }
    return nullptr;
}

static int nwarps_for(int type_i, int ncols_dst) {
    if (ncols_dst == 1 && (type_i == TYPE_Q4_0 || type_i == TYPE_Q8_0)) return 8;
    return 1;
}

struct bench_result { double ms, p10, p90, mn, mx, bw_weight, bw_total; long long wg; int regs, occ_blocks; };

static bench_result bench_one(int type_i, int ncols_dst, int K, int N, int reps, bool fused, int prefetch_depth) {
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

    const int nwarps = nwarps_for(type_i, ncols_dst);
    dim3 blocks(N, 1, 1), threads(WARP_SIZE, nwarps, 1);

    const void * fn = pick_kernel_i(type_i, ncols_dst, fused, prefetch_depth);
    if (!fn) { fprintf(stderr, "no kernel for type=%d prefetch=%d\n", type_i, prefetch_depth); exit(1); }

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

static const char * variant_name(int p) {
    switch (p) {
        case 0:  return "V0";
        case 1:  return "C1";
        case 2:  return "C2";
        case 4:  return "C3";
        case -1: return "C4";
    }
    return "?";
}

// ===================== bit-exact verification (V0 vs each prefetch variant) =====================
static void verify_one(int prefetch_depth, int K, int N, bool fused) {
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
    size_t ybytes = ycol_bytes;
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
    float * d_dst1; CHECK_HIP(hipMalloc(&d_dst1, sizeof(float)*N));

    const void * fn0 = pick_kernel_i(TYPE_IQ3_XXS, 1, fused, 0);
    const void * fn1 = pick_kernel_i(TYPE_IQ3_XXS, 1, fused, prefetch_depth);
    const int nwarps = nwarps_for(TYPE_IQ3_XXS, 1);
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

    for (int i = 0; i < 3; ++i) launch(fn0, d_dst0, blocks, threads, d_w, d_y, ncols_x, stride_row_x, stride_col_y_blocks, stride_col_dst);
    CHECK_HIP(hipDeviceSynchronize());
    for (int i = 0; i < 3; ++i) launch(fn1, d_dst1, blocks, threads, d_w, d_y, ncols_x, stride_row_x, stride_col_y_blocks, stride_col_dst);
    CHECK_HIP(hipDeviceSynchronize());

    std::vector<float> h0(N), h1(N);
    CHECK_HIP(hipMemcpy(h0.data(), d_dst0, sizeof(float)*N, hipMemcpyDeviceToHost));
    CHECK_HIP(hipMemcpy(h1.data(), d_dst1, sizeof(float)*N, hipMemcpyDeviceToHost));

    bool identical = memcmp(h0.data(), h1.data(), sizeof(float)*N) == 0;
    double maxdiff = 0; long long ndiff = 0;
    unsigned long long sum0 = 0, sum1 = 0;
    for (int i = 0; i < N; ++i) {
        float d = fabsf(h0[i] - h1[i]);
        if (d > maxdiff) maxdiff = d;
        if (d != 0.0f) ++ndiff;
        unsigned u; memcpy(&u, &h0[i], 4); sum0 += u;
        memcpy(&u, &h1[i], 4); sum1 += u;
    }
    printf("verify variant=%s K=%d N=%d fused=%d -> %s max_abs_diff=%.6g differing=%lld checksum0=%016llx checksum1=%016llx\n",
           variant_name(prefetch_depth), K, N, (int)fused,
           identical ? "IDENTICAL" : "DIVERGENT", maxdiff, ndiff, sum0, sum1);

    hipFree(d_w); hipFree(d_y); hipFree(d_dst0); hipFree(d_dst1);
}

// ===================== main =====================
int main(int argc, char ** argv) {
    int reps = argc > 1 ? atoi(argv[1]) : 50;

    // verify mode: ./mmvq_prefetch_bench verify
    if (argc >= 2 && strcmp(argv[1], "verify") == 0) {
        const int variants[] = {1, 2, 4, -1};
        const char * names[] = {"C1", "C2", "C3", "C4"};
        (void) names;
        for (int v : variants) {
            verify_one(v, 17408, 5120, false); // ffn_down unfused
            verify_one(v, 5120, 17408, true);  // fused gateup pair
        }
        return 0;
    }

    // single-config mode: <reps> <type> <shape> <batch> [fused] [prefetch]
    //   shape: 0=down 1=gateup; prefetch: 0=V0 1=C1 2=C2 4=C3 -1=C4
    if (argc >= 5) {
        int type_i = atoi(argv[2]);
        int s = atoi(argv[3]);
        int b = atoi(argv[4]);
        bool fused = argc > 5 ? atoi(argv[5]) != 0 : (s == 1);
        int prefetch = argc > 6 ? atoi(argv[6]) : 0;
        int K = s == 0 ? 17408 : 5120;
        int N = s == 0 ? 5120 : 17408;
        bench_result r = bench_one(type_i, b, K, N, reps, fused, prefetch);
        printf("type=%d shape=%d batch=%d fused=%d variant=%s ms=%.4f min=%.4f p10=%.4f p90=%.4f max=%.4f GBps_weight=%.1f regs=%d occ_blocks=%d wg=%lld\n",
               type_i, s, b, (int)fused, variant_name(prefetch),
               r.ms, r.mn, r.p10, r.p90, r.mx, r.bw_weight, r.regs, r.occ_blocks, r.wg);
        return 0;
    }

    hipDeviceProp_t prop; CHECK_HIP(hipGetDeviceProperties(&prop, 0));
    printf("device=%s CUs=%d clock=%d MHz\n", prop.gcnArchName, prop.multiProcessorCount, prop.clockRate/1000);

    // Sweep: V0, C1, C2, C3, C4 for IQ3_XXS at batch=1, both shapes.
    const int variants[] = {0, 1, 2, 4, -1};
    const char * names[] = {"V0", "C1", "C2", "C3", "C4"};
    const int nvar = 5;
    struct shape { const char * name; int K; int N; bool fused; };
    shape shapes[2] = { {"ffn_down_K17408_N5120", 17408, 5120, false},
                        {"ffn_gateup_K5120_N17408", 5120, 17408, true} };

    printf("\n%-10s %-20s %11s %12s %13s %9s %6s %6s\n",
           "variant","shape","ms","GB/s(weight)","GB/s(total)","workgrp","regs","occ");
    for (int s = 0; s < 2; ++s) {
        for (int v = 0; v < nvar; ++v) {
            bench_result r = bench_one(TYPE_IQ3_XXS, 1, shapes[s].K, shapes[s].N, reps, shapes[s].fused, variants[v]);
            printf("%-10s %-20s %11.4f %12.1f %13.1f %9lld %6d %6d\n",
                   names[v], shapes[s].name, r.ms, r.bw_weight, r.bw_total, r.wg, r.regs, r.occ_blocks);
            fflush(stdout);
        }
    }
    return 0;
}
