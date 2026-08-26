// Phase-4E / Subagent-D: VDR-increase variants of the IQ3_XXS MMVQ harness.
//
// Goal: test whether increasing VDR (iqs-slices per vec_dot call) reduces
// trip count and amortizes the per-trip fixed cost, with each slice
// accumulating into its own independent 8-deep v_dot4 chain.
//
// The harness uses 8 threads to cover the 8 iqs-slices of one bq3 block:
//   V0 (bpc=1):  8 threads per bq3, 1 iqs slice per thread, 4 bq3/warp/iter
//   D1 (bpc=2):  4 threads per bq3, 2 iqs slices per thread, 8 bq3/warp/iter
//   D2 (bpc=4):  2 threads per bq3, 4 iqs slices per thread, 16 bq3/warp/iter
//   D3 (bpc=8):  1 thread  per bq3, 8 iqs slices per thread, 32 bq3/warp/iter
//
// Per-call dp4a work = 8 * bpc (1, 2, 4, 8 v_dot4 chains in the call).
// Per-row trip count halves for each doubling of bpc (17 -> 8 -> 4 -> 2).
//
// Bit-exactness: every bq3 block is fully covered by 8 iqs slices across
// the threads in its group, regardless of bpc. The d*sumi contribution
// per (bq3, iqs-slice) is identical to V0. The only difference is the
// per-row float add order (bpc d*sumi values added in a single fma
// instead of bpc separate adds), which is at most a few ULPs.
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

typedef int8_t  int8x4_t  __attribute__((ext_vector_type(4)));
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

// ===================== vec_dot functions (templated on iqs-slices per call) =====================
//
// BPC = iqs-slices per vec_dot call. Each slice has its own 8-deep v_dot4
// chain into its own sumi accumulator. The d*sumi contribution per slice
// is identical to V0; only the per-row float add order changes (bpc slices
// are summed before being added to the row accumulator, vs. bpc separate
// adds in V0).
//
// The bq8_1 base pointer passed by the kernel points at the kby-th
// bq8_1 block. Slice s (0..bpc-1) reads bq8_1[kby + iqs/2 + s] and
// bq3[kbx] at iqs = 2*(iqs/2 + s).
template <int bpc>
static __device__ __forceinline__ float vec_dot_iq3_xxs_q8_1(const void * vbq, const block_q8_1 * bq8_1, const int kbx0, const int iqs_base) {
    static_assert(bpc >= 1, "bpc must be >= 1");
    static_assert((bpc & (bpc - 1)) == 0, "bpc must be a power of 2");
    static_assert(bpc <= 8, "bpc must be <= 8 (only 8 iqs slices per bq3)");

    const block_iq3_xxs * bq3 = (const block_iq3_xxs *) vbq + kbx0;
    const int iqs2_base = iqs_base / 2;
    float result = 0.0f;

#pragma unroll
    for (int s = 0; s < bpc; ++s) {
        const int iqs = iqs_base + 2 * s;
        const int iqs2 = iqs2_base + s;
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

            const int u0 = get_int_b4(bq8_1[iqs2].qs, l0 + 0);

            const int signs1 = __vcmpne4(signs & 0x80402010, 0);
            const int grid_h = __vsub4(grid_pos.y ^ signs1, signs1);

            const int u1 = get_int_b4(bq8_1[iqs2].qs, l0 + 1);

            sumi = ggml_cuda_dp4a(grid_l, u0, sumi);
            sumi = ggml_cuda_dp4a(grid_h, u1, sumi);
        }

        const int ls = aux32 >> 28;
        sumi = (ls*sumi + sumi/2)/2;
        const float d = __half2float(__ushort_as_half(bq3->d)) *
                        __low2float(*(const __half2 *)&bq8_1[iqs2].d);
        result += d * sumi;
    }
    return result;
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

// ===================== kernel =====================
enum MType { TYPE_Q4_0 = 2, TYPE_Q8_0 = 8, TYPE_IQ3_XXS = 18 };

constexpr int qk_of(MType t)  { return t == TYPE_Q4_0 ? QK4_0 : (t == TYPE_Q8_0 ? QK8_0 : QK_K); }
constexpr int qi_of(MType t)  { return t == TYPE_Q4_0 ? QI4_0 : (t == TYPE_Q8_0 ? QI8_0 : QI3_XXS); }

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

// IQ3_XXS-specific kernel: bpc = iqs-slices per vec_dot call.
// Thread mapping: 8/bpc threads per bq3, blocks_per_iter = 32 / (8/bpc) = 4*bpc.
template<int bpc, int ncols_dst, bool has_fusion, int nwarps_tbl>
__global__ __launch_bounds__(nwarps_tbl*WARP_SIZE, 1)
void mul_mat_vec_q_iq3(
        const void * vx_ptr, const void * vgate_ptr, const void * vy_ptr, float * dst_ptr,
        const uint32_t ncols_x, const uint32_t stride_row_x,
        const uint32_t stride_col_y_blocks, const uint32_t stride_col_dst) {
    constexpr int qk  = QK_K;
    constexpr int qi  = QI3_XXS;
    constexpr int nwarps = nwarps_tbl;
    constexpr int rows_per_cuda_block = 1;
    constexpr int warp_size = WARP_SIZE;
    constexpr int threads_per_bq3 = 8 / bpc;       // 8, 4, 2, 1 for bpc=1,2,4,8

    const void * vx = vx_ptr;

    const int tid = warp_size*threadIdx.y + threadIdx.x;
    const int row0 = rows_per_cuda_block*blockIdx.x;
    const int blocks_per_row_x = ncols_x / qk;
    // 32 threads / threads_per_bq3 bq3 per warp per iter.
    constexpr int blocks_per_iter = warp_size / threads_per_bq3;

    const uint32_t channel_dst = blockIdx.y;
    const uint32_t channel_y = channel_dst;

    float tmp[ncols_dst][rows_per_cuda_block];
    [[maybe_unused]] float tmp_gate[ncols_dst][rows_per_cuda_block];
#pragma unroll
    for (int j = 0; j < ncols_dst; ++j) { tmp[j][0] = 0.0f; tmp_gate[j][0] = 0.0f; }

    const block_q8_1 * y = ((const block_q8_1 *) vy_ptr) + channel_y*stride_col_y_blocks;
    const int kbx_offset = row0*stride_row_x;

    for (int kbx = tid / threads_per_bq3; kbx < blocks_per_row_x; kbx += blocks_per_iter) {
        const int kby = kbx * (qk/QK8_1);
        // iqs/2 = (tid % threads_per_bq3) * bpc -> first iqs slice for this thread
        const int iqs_base = 2 * ((tid % threads_per_bq3) * bpc);

#pragma unroll
        for (int j = 0; j < ncols_dst; ++j) {
#pragma unroll
            for (int i = 0; i < rows_per_cuda_block; ++i) {
                tmp[j][i] += vec_dot_iq3_xxs_q8_1<bpc>(vx, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, iqs_base);
                if (has_fusion) {
                    tmp_gate[j][i] += vec_dot_iq3_xxs_q8_1<bpc>(vgate_ptr, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, iqs_base);
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

// Forward declaration of the general mul_mat_vec_q (for non-IQ3_XXS or non-1 ncols_dst).
template<MType type, int ncols_dst, bool has_fusion = false, int nwarps_tbl = calc_nwarps<type>(ncols_dst)>
__global__ __launch_bounds__(nwarps_tbl*WARP_SIZE, 1)
void mul_mat_vec_q(
        const void * vx_ptr, const void * vgate_ptr, const void * vy_ptr, float * dst_ptr,
        const uint32_t ncols_x, const uint32_t stride_row_x,
        const uint32_t stride_col_y_blocks, const uint32_t stride_col_dst);

// Forward declaration of the IQ3_XXS-specific templated kernel.
// Forward declaration of the IQ3_XXS-specific templated kernel.
template<int bpc, int ncols_dst, bool has_fusion, int nwarps_tbl = 1>
__global__ __launch_bounds__(nwarps_tbl*WARP_SIZE, 1)
void mul_mat_vec_q_iq3(
        const void * vx_ptr, const void * vgate_ptr, const void * vy_ptr, float * dst_ptr,
        const uint32_t ncols_x, const uint32_t stride_row_x,
        const uint32_t stride_col_y_blocks, const uint32_t stride_col_dst);
template<MType type>
static const void * pick_kernel(int ncols_dst, bool has_fusion) {
    switch (ncols_dst) {
        case 1: return has_fusion ? (const void*)mul_mat_vec_q<TYPE_IQ3_XXS,1,true>  : (const void*)mul_mat_vec_q<TYPE_IQ3_XXS,1,false>;
        case 2: return (const void*)mul_mat_vec_q<TYPE_IQ3_XXS,2,false>;
        case 4: return (const void*)mul_mat_vec_q<TYPE_IQ3_XXS,4,false>;
        case 8: return (const void*)mul_mat_vec_q<TYPE_IQ3_XXS,8,false>;
    }
    return nullptr;
}

// For the IQ3_XXS path, we always use the new VDR-templated kernel above; the
// original mul_mat_vec_q is only used for non-1 ncols_dst (batch>1).
template<MType type, int ncols_dst, bool has_fusion, int nwarps_tbl>
__global__ __launch_bounds__(nwarps_tbl*WARP_SIZE, 1)
void mul_mat_vec_q(
        const void * vx_ptr, const void * vgate_ptr, const void * vy_ptr, float * dst_ptr,
        const uint32_t ncols_x, const uint32_t stride_row_x,
        const uint32_t stride_col_y_blocks, const uint32_t stride_col_dst) {
    constexpr int qk  = qk_of(type);
    constexpr int qi  = qi_of(type);
    constexpr int vdr = 2;
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
                    tmp[j][i] += vec_dot_iq3_xxs_q8_1<1>(vx, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                } else if (type == TYPE_Q4_0) {
                    tmp[j][i] += vec_dot_q4_0_q8_1(vx, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                } else {
                    tmp[j][i] += vec_dot_q8_0_q8_1(vx, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
                }
                if (has_fusion) {
                    if (type == TYPE_IQ3_XXS) {
                        tmp_gate[j][i] += vec_dot_iq3_xxs_q8_1<1>(vgate_ptr, &y[j*stride_col_y_blocks + kby], kbx_offset + i*stride_row_x + kbx, kqs);
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
    if (threadIdx.y > 0) return;
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
            if (has_fusion) result *= silu_single(tmp_gate[j][0]);
            dst[j*stride_col_dst] = result;
        }
    }
}

// bpc: 0=V0 (1 iqs slice per call, baseline), 1=D1 (2 slices), 2=D2 (4), 3=D3 (8).
static const void * pick_kernel_i(int type_i, int ncols_dst, bool has_fusion, int bpc) {
    if (type_i == TYPE_IQ3_XXS && ncols_dst == 1) {
        switch (bpc) {
            case 0: return has_fusion ? (const void*)&mul_mat_vec_q_iq3<1, 1, true,  1>
                                      : (const void*)&mul_mat_vec_q_iq3<1, 1, false, 1>;
            case 1: return has_fusion ? (const void*)&mul_mat_vec_q_iq3<2, 1, true,  1>
                                      : (const void*)&mul_mat_vec_q_iq3<2, 1, false, 1>;
            case 2: return has_fusion ? (const void*)&mul_mat_vec_q_iq3<4, 1, true,  1>
                                      : (const void*)&mul_mat_vec_q_iq3<4, 1, false, 1>;
            case 3: return has_fusion ? (const void*)&mul_mat_vec_q_iq3<8, 1, true,  1>
                                      : (const void*)&mul_mat_vec_q_iq3<8, 1, false, 1>;
        }
        return nullptr;
    }
    switch (type_i) {
        case TYPE_IQ3_XXS: return pick_kernel<TYPE_IQ3_XXS>(ncols_dst, has_fusion);
        case TYPE_Q4_0:    return pick_kernel<TYPE_Q4_0>(ncols_dst, has_fusion);
        case TYPE_Q8_0:    return pick_kernel<TYPE_Q8_0>(ncols_dst, has_fusion);
    }
    return nullptr;
}

static int nwarps_for(int type_i, int ncols_dst) {
    if (ncols_dst == 1 && (type_i == TYPE_Q4_0 || type_i == TYPE_Q8_0)) return 8;
    return 1;
}

struct bench_result { double ms, p10, p90, mn, mx, bw_weight, bw_total; long long wg; int regs, occ_blocks; };

static bench_result bench_one(int type_i, int ncols_dst, int K, int N, int reps, bool fused, int bpc) {
    size_t blk_size, blks_per_row;
    if (type_i == TYPE_IQ3_XXS)    { blk_size = 66; blks_per_row = K/256; }
    else if (type_i == TYPE_Q4_0)  { blk_size = 18; blks_per_row = K/32;  }
    else                           { blk_size = 34; blks_per_row = K/32;  }
    size_t row_bytes = blk_size * blks_per_row;
    size_t wbytes = row_bytes * N;
    size_t nw = fused ? 2 : 1;

    std::vector<unsigned char> h_w(wbytes*nw);
    srand(42 + type_i + K + bpc*1000);
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

    const void * fn = pick_kernel_i(type_i, ncols_dst, fused, bpc);
    if (!fn) { fprintf(stderr, "no kernel for type=%d bpc=%d\n", type_i, bpc); exit(1); }

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

// Bit-exact verification: V0 (bpc=0) vs D1/D2/D3 (bpc=1,2,3).
static void verify_one(int K, int N, bool fused) {
    size_t blk_size = 66;
    size_t blks_per_row = K/256;
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

    float * d_dst[4];
    for (int v = 0; v < 4; ++v) CHECK_HIP(hipMalloc(&d_dst[v], sizeof(float)*N));

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

    const void * fn[4];
    for (int v = 0; v < 4; ++v) fn[v] = pick_kernel_i(TYPE_IQ3_XXS, 1, fused, v);

    for (int i = 0; i < 3; ++i) for (int v = 0; v < 4; ++v) launch(fn[v], d_dst[v], blocks, threads, d_w, d_y, ncols_x, stride_row_x, stride_col_y_blocks, stride_col_dst);
    CHECK_HIP(hipDeviceSynchronize());
    for (int v = 0; v < 4; ++v) launch(fn[v], d_dst[v], blocks, threads, d_w, d_y, ncols_x, stride_row_x, stride_col_y_blocks, stride_col_dst);
    CHECK_HIP(hipDeviceSynchronize());

    std::vector<float> h[4];
    for (int v = 0; v < 4; ++v) {
        h[v].resize(N);
        CHECK_HIP(hipMemcpy(h[v].data(), d_dst[v], sizeof(float)*N, hipMemcpyDeviceToHost));
    }

    {
        unsigned long long s0 = 0; for (int i = 0; i < N; ++i) { unsigned u; memcpy(&u, &h[0][i], 4); s0 += u; }
        printf("V0_checksum K=%d N=%d fused=%d -> %016llx\n", K, N, (int)fused, s0);
    }
    for (int v = 1; v < 4; ++v) {
        bool bit_exact = true;
        long long ulp1 = 0, ulp2 = 0, ulp3 = 0, ulp4p = 0;
        double maxdiff = 0; double maxrel = 0; long long ndiff = 0;
        for (int i = 0; i < N; ++i) {
            float a = h[0][i], b = h[v][i];
            if (memcmp(&a, &b, 4) != 0) { bit_exact = false; ++ndiff; }
            float d = fabsf(a - b);
            if (d > maxdiff) maxdiff = d;
            float ref = fabsf(a); if (ref > 0) { double r = d / ref; if (r > maxrel) maxrel = r; }
            unsigned ua, ub;
            memcpy(&ua, &a, 4); memcpy(&ub, &b, 4);
            int sa = (ua >> 31) ? -1 : 1; int sb = (ub >> 31) ? -1 : 1;
            int32_t ma = (ua & 0x7FFFFFFF); int32_t mb = (ub & 0x7FFFFFFF);
            int32_t ulpd = sa == sb ? (ma - mb) : (ma + mb);
            if (ulpd < 0) ulpd = -ulpd;
            if (ulpd == 1) ++ulp1;
            else if (ulpd == 2) ++ulp2;
            else if (ulpd == 3) ++ulp3;
            else ++ulp4p;
        }
        const char * vname[] = {"V0", "D1", "D2", "D3"};
        const char * verdict;
        if (bit_exact) verdict = "BIT_EXACT";
        else if (ulp4p == 0 && ulp3 == 0) verdict = "BIT_EXACT_MODULO_2ULP";
        else if (ulp4p == 0) verdict = "BIT_EXACT_MODULO_3ULP";
        else verdict = "BEYOND_3ULP";
        printf("verify K=%d N=%d fused=%d %s_vs_%s -> %s max_abs_diff=%.6g max_rel_diff=%.6g differing=%lld ulp[1]=%lld ulp[2]=%lld ulp[3]=%lld ulp[4+]=%lld\n",
               K, N, (int)fused, vname[0], vname[v], verdict, maxdiff, maxrel, ndiff, ulp1, ulp2, ulp3, ulp4p);
    }

    for (int v = 0; v < 4; ++v) hipFree(d_dst[v]);
    hipFree(d_w); hipFree(d_y);
}

int main(int argc, char ** argv) {
    int reps = argc > 1 ? atoi(argv[1]) : 50;

    if (argc >= 2 && strcmp(argv[1], "verify") == 0) {
        verify_one(17408, 5120, false);
        verify_one(5120, 17408, true);
        return 0;
    }

    if (argc >= 4) {
        int s = atoi(argv[2]);
        int b = atoi(argv[3]);
        int v = argc > 4 ? atoi(argv[4]) : 0;
        bool fused = argc > 5 ? atoi(argv[5]) != 0 : (s == 1);
        int K = s == 0 ? 17408 : 5120;
        int N = s == 0 ? 5120 : 17408;
        bench_result r = bench_one(TYPE_IQ3_XXS, b, K, N, reps, fused, v);
        const char * vname[] = {"V0", "D1", "D2", "D3"};
        printf("shape=%d batch=%d bpc=%s fused=%d ms=%.4f min=%.4f p10=%.4f p90=%.4f max=%.4f GBps_weight=%.1f GBps_total=%.1f regs=%d occ_blocks=%d wg=%lld\n",
               s, b, vname[v], (int)fused, r.ms, r.mn, r.p10, r.p90, r.mx, r.bw_weight, r.bw_total, r.regs, r.occ_blocks, r.wg);
        return 0;
    }

    hipDeviceProp_t prop; CHECK_HIP(hipGetDeviceProperties(&prop, 0));
    printf("device=%s CUs=%d clock=%d MHz\n", prop.gcnArchName, prop.multiProcessorCount, prop.clockRate/1000);

    struct shape { const char * name; int K; int N; };
    shape shapes[2] = { {"ffn_down_K17408_N5120", 17408, 5120}, {"ffn_gateup_K5120_N17408", 5120, 17408} };
    const char * vname[] = {"V0", "D1", "D2", "D3"};

    for (int s = 0; s < 2; ++s) {
        printf("\n=== shape %s ===\n", shapes[s].name);
        printf("%-4s %-7s %11s %12s %13s %9s %6s %6s\n", "bpc", "batch", "ms", "GB/s(weight)", "GB/s(total)", "workgrp", "regs", "occ");
        for (int v = 0; v < 4; ++v) {
            bool do_fused = (s == 1);
            for (int bi = 0; bi < 4; ++bi) {
                int b = (bi == 0) ? 1 : (1 << bi);
                bench_result r = bench_one(TYPE_IQ3_XXS, b, shapes[s].K, shapes[s].N, reps, do_fused, v);
                printf("%-4s %-7d %11.4f %12.1f %13.1f %9lld %6d %6d%s\n",
                       vname[v], b, r.ms, r.bw_weight, r.bw_total, r.wg, r.regs, r.occ_blocks,
                       (do_fused && b==1) ? " [fused-glu]" : "");
                fflush(stdout);
            }
        }
    }
    return 0;
}
