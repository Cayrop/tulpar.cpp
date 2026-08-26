// E1b: IQ3_XXS GEMV standalone kernel sweep for RDNA3 (gfx1101).
// Baseline mirrors mul_mat_vec_q<IQ3_XXS, ncols_dst=1> (mmvq.cu) +
// vec_dot_iq3_xxs_q8_1 (vecdotq.cuh) @ tulpar/main 66dcba5eb.
// IQ3_XXS super-block: fp16 d + qs[96] = 98 B / 256 elements (3.0625 bpw).
// Production config on gfx1101 (RDNA3_0 table, IQ3_XXS not whitelisted):
//   nwarps=1, blockDim=(32,1), one dst element per block.
//   qi=QK_K/(4*QR)=16, vdr=2 -> blocks_per_iter = vdr*nwarps*32/qi = 4,
//   kbx starts at tid/(qi/vdr) = tid/8, kqs = 2*(tid % 8),
//   y super-block offset = kbx*8 q8_1 blocks, slice select = kqs/2.
//
// build: hipcc --offload-arch=gfx1101 -O3 -I <ggml/src> e1b_bench.hip ref_cpu.cpp -o e1b_bench
// usage: ./e1b_bench check|bench|info

#define GGML_COMMON_DECL_HIP
#define GGML_COMMON_IMPL_HIP
#include "ggml-common.h"

#include <hip/hip_runtime.h>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cstdint>
#include <vector>
#include <string>
#include <algorithm>

#define CK(x) do { hipError_t e_ = (x); if (e_ != hipSuccess) { \
    fprintf(stderr, "HIP error %s at %s:%d\n", hipGetErrorString(e_), __FILE__, __LINE__); exit(1);} } while(0)

// ---------- helpers copied from ggml-cuda/common.cuh + vendors/hip.h ----------
typedef int8_t int8x4_t __attribute__((ext_vector_type(4)));
typedef uint8_t uint8x4_t __attribute__((ext_vector_type(4)));
static __device__ __forceinline__ int __vsubss4(const int a, const int b) {
    const int8x4_t va = reinterpret_cast<const int8x4_t&>(a);
    const int8x4_t vb = reinterpret_cast<const int8x4_t&>(b);
#if __has_builtin(__builtin_elementwise_sub_sat)
    const int8x4_t c = __builtin_elementwise_sub_sat(va, vb);
    return reinterpret_cast<const int &>(c);
#else
    int8x4_t c;
#pragma unroll
    for (int i = 0; i < 4; i++) {
        int16_t tmp = va[i] - vb[i];
        if (tmp > 127) tmp = 127;
        if (tmp < -128) tmp = -128;
        c[i] = tmp;
    }
    return reinterpret_cast<const int &>(c);
#endif
}
static __device__ __forceinline__ int __vsub4(const int a, const int b) { return __vsubss4(a, b); }
static __device__ __forceinline__ unsigned int __vcmpne4(unsigned int a, unsigned int b) {
    const uint8x4_t& va = reinterpret_cast<const uint8x4_t&>(a);
    const uint8x4_t& vb = reinterpret_cast<const uint8x4_t&>(b);
    unsigned int c;
    uint8x4_t& vc = reinterpret_cast<uint8x4_t&>(c);
#pragma unroll
    for (int i = 0; i < 4; ++i) vc[i] = va[i] == vb[i] ? 0x00 : 0xff;
    return c;
}
static __device__ __forceinline__ int ggml_cuda_dp4a(const int a, const int b, int c) {
    return __builtin_amdgcn_sudot4(true, a, true, b, c, false);
}
static __device__ __forceinline__ int get_int_b2(const void * x, const int & i32) {
    const uint8_t * x8 = (const uint8_t *) x;
    return (int)x8[i32*4] | ((int)x8[i32*4+1] << 8) | ((int)x8[i32*4+2] << 16) | ((int)x8[i32*4+3] << 24);
}
static __device__ __forceinline__ uint32_t unpack_ksigns(const uint8_t v) {
    const uint32_t p = __popc(v) & 1;
    const uint32_t s = v ^ p << 7;
    return s * 0x01010101;
}

// ---------- verbatim vec_dot_iq3_xxs_q8_1 body (fixed kbx/iqs form) ----------
static __device__ __forceinline__ float vd_iq3xxs(
        const block_iq3_xxs * bq3, const block_q8_1 * bq8_base, const int iqs) {

    const int2 q3_packed = make_int2(get_int_b2(bq3->qs, iqs), get_int_b2(bq3->qs, iqs+1));
    const uint8_t * q3 = (const uint8_t *) &q3_packed;
    const uint32_t aux32 = get_int_b2(bq3->qs, 16 + iqs/2);
    const block_q8_1 * bq8 = bq8_base + iqs/2;

    int sumi = 0;
#pragma unroll
    for (int l0 = 0; l0 < 8; l0 += 2) {
        const int2 grid_pos = make_int2(iq3xxs_grid[q3[l0 + 0]], iq3xxs_grid[q3[l0 + 1]]);
        const uint32_t signs = unpack_ksigns(aux32 >> (7*l0/2));

        const int signs0 = __vcmpne4(signs & 0x08040201, 0);
        const int grid_l = __vsub4(grid_pos.x ^ signs0, signs0);

        const int u0 = *((const int *) bq8->qs + l0 + 0);

        const int signs1 = __vcmpne4(signs & 0x80402010, 0);
        const int grid_h = __vsub4(grid_pos.y ^ signs1, signs1);

        const int u1 = *((const int *) bq8->qs + l0 + 1);

        sumi = ggml_cuda_dp4a(grid_l, u0, sumi);
        sumi = ggml_cuda_dp4a(grid_h, u1, sumi);
    }

    const int ls = aux32 >> 28;
    sumi = (ls*sumi + sumi/2)/2;
    return __half2float(bq3->d) * __low2float(bq8->ds) * (float)sumi;
}

template <int WS>
static __device__ __forceinline__ float warp_reduce(float v) {
#pragma unroll
    for (int m = WS/2; m > 0; m >>= 1) v += __shfl_xor(v, m, WS);
    return v;
}

struct shape_t { int N, K, nsb, row_bytes; };
static shape_t mk_shape(int N, int K) { shape_t s; s.N=N; s.K=K; s.nsb=K/256; s.row_bytes=s.nsb*98; return s; }
static const shape_t SHAPES[2] = { {17408, 5120, 20, 1960}, {5120, 17408, 68, 6664} };

constexpr int QK = 256, QI = 16, VDR = 2;

// ---------------- V0: baseline, nwarps=1 (production config) ----------------
__global__ __launch_bounds__(32, 1) void k_v0(
        const uint8_t * W, const block_q8_1 * y, float * dst, int row_bytes) {
    const int tid = threadIdx.x;
    const int row = blockIdx.x;
    const int bpr = row_bytes / 98;
    constexpr int bpi = VDR*1*32/QI;            // 4
    const int kqs = VDR*(tid % (QI/VDR));       // 2*(tid%8)
    float tmp = 0.0f;
    const block_iq3_xxs * wrow = (const block_iq3_xxs *)(W + (size_t)row * row_bytes);
    for (int kbx = tid / (QI/VDR); kbx < bpr; kbx += bpi) {
        tmp += vd_iq3xxs(wrow + kbx, y + kbx*(QK/32), kqs);
    }
    tmp = warp_reduce<32>(tmp);
    if (tid == 0) dst[row] = tmp;
}

// ---------------- V1/V2: generalized nwarps (production-style reduction) -----
template <int NWARP>
__global__ void k_vnw(const uint8_t * W, const block_q8_1 * y, float * dst, int row_bytes) {
    const int tid = 32*threadIdx.y + threadIdx.x;
    const int row = blockIdx.x;
    const int bpr = row_bytes / 98;
    constexpr int bpi = NWARP*64/QI;
    constexpr int div = QI/VDR;                  // 8
    const int kqs = VDR*(tid % div);
    float tmp = 0.0f;
    const block_iq3_xxs * wrow = (const block_iq3_xxs *)(W + (size_t)row * row_bytes);
    for (int kbx = tid / div; kbx < bpr; kbx += bpi) {
        tmp += vd_iq3xxs(wrow + kbx, y + kbx*(QK/32), kqs);
    }
    if constexpr (NWARP > 1) {
        __shared__ float sh[NWARP-1][32];
        if (threadIdx.y > 0) sh[threadIdx.y-1][threadIdx.x] = tmp;
        __syncthreads();
        if (threadIdx.y == 0) {
#pragma unroll
            for (int l = 0; l < NWARP-1; ++l) tmp += sh[l][threadIdx.x];
            tmp = warp_reduce<32>(tmp);
            if (threadIdx.x == 0) dst[row] = tmp;
        }
    } else {
        tmp = warp_reduce<32>(tmp);
        if (tid == 0) dst[row] = tmp;
    }
}

// ---------------- V3: rows_per_block=2, wg=32 --------------------------------
__global__ __launch_bounds__(32, 1) void k_rows2(
        const uint8_t * W, const block_q8_1 * y, float * dst, int row_bytes) {
    const int tid = threadIdx.x;
    const int row0 = 2*blockIdx.x;
    const int bpr = row_bytes / 98;
    constexpr int bpi = 4, div = 8;
    const int kqs = VDR*(tid % div);
    float t0 = 0.0f, t1 = 0.0f;
    const block_iq3_xxs * w0 = (const block_iq3_xxs *)(W + (size_t)(row0+0)*row_bytes);
    const block_iq3_xxs * w1 = (const block_iq3_xxs *)(W + (size_t)(row0+1)*row_bytes);
    for (int kbx = tid / div; kbx < bpr; kbx += bpi) {
        t0 += vd_iq3xxs(w0 + kbx, y + kbx*(QK/32), kqs);
        t1 += vd_iq3xxs(w1 + kbx, y + kbx*(QK/32), kqs);
    }
    t0 = warp_reduce<32>(t0); t1 = warp_reduce<32>(t1);
    if (tid == 0) { dst[row0] = t0; dst[row0+1] = t1; }
}

// ---------------- V4: rows_per_block=4, wg=128 -------------------------------
__global__ void k_r4w128(const uint8_t * W, const block_q8_1 * y, float * dst, int row_bytes) {
    constexpr int NWARP = 4, ROWS = 4;
    const int tid = 32*threadIdx.y + threadIdx.x;
    const int row0 = ROWS*blockIdx.x;
    const int bpr = row_bytes / 98;
    constexpr int bpi = NWARP*64/QI, div = 8;
    const int kqs = VDR*(tid % div);
    float tmp[ROWS] = {0.f};
    for (int kbx = tid / div; kbx < bpr; kbx += bpi) {
#pragma unroll
        for (int i = 0; i < ROWS; ++i) {
            tmp[i] += vd_iq3xxs((const block_iq3_xxs *)(W + (size_t)(row0+i)*row_bytes) + kbx,
                                y + kbx*(QK/32), kqs);
        }
    }
    __shared__ float sh[NWARP-1][ROWS][32];
    if (threadIdx.y > 0) {
#pragma unroll
        for (int i = 0; i < ROWS; ++i) sh[threadIdx.y-1][i][threadIdx.x] = tmp[i];
    }
    __syncthreads();
    if (threadIdx.y == 0) {
#pragma unroll
        for (int i = 0; i < ROWS; ++i) {
#pragma unroll
            for (int l = 0; l < NWARP-1; ++l) tmp[i] += sh[l][i][threadIdx.x];
            tmp[i] = warp_reduce<32>(tmp[i]);
            if (threadIdx.x == 0) dst[row0+i] = tmp[i];
        }
    }
}

// ---------------- V5: funnel-shift unaligned dword loads ---------------------
// qs payload dwords are 2-mod-4 misaligned for odd super-blocks; assemble each
// needed dword from two ALIGNED dword loads via funnel shift instead of four
// byte loads.
static __device__ __forceinline__ uint32_t ld_un(const uint8_t * p) {
    const uintptr_t a = (uintptr_t) p;
    const uint32_t * ap = (const uint32_t *)(a & ~(uintptr_t)3);
    const int sh = (int)(a & 3) * 8;
    if (!sh) return ap[0];
    return __funnelshift_r(ap[0], ap[1], sh);
}

static __device__ __forceinline__ float vd_iq3xxs_fastld(
        const block_iq3_xxs * bq3, const block_q8_1 * bq8_base, const int iqs) {

    const uint32_t qa = ld_un(bq3->qs + 4*iqs);
    const uint32_t qb = ld_un(bq3->qs + 4*(iqs+1));
    const uint32_t aux32 = ld_un(bq3->qs + 64 + 4*(iqs/2));
    const uint8_t * q3a = (const uint8_t *) &qa;
    const uint8_t * q3b = (const uint8_t *) &qb;
    const block_q8_1 * bq8 = bq8_base + iqs/2;

    int sumi = 0;
#pragma unroll
    for (int l0 = 0; l0 < 8; l0 += 2) {
        const bool lo = l0 < 4;
        const int2 grid_pos = make_int2(iq3xxs_grid[lo ? q3a[l0] : q3b[l0-4]],
                                        iq3xxs_grid[lo ? q3a[l0+1] : q3b[l0-3]]);
        const uint32_t signs = unpack_ksigns(aux32 >> (7*l0/2));
        const int signs0 = __vcmpne4(signs & 0x08040201, 0);
        const int grid_l = __vsub4(grid_pos.x ^ signs0, signs0);
        const int u0 = *((const int *) bq8->qs + l0 + 0);
        const int signs1 = __vcmpne4(signs & 0x80402010, 0);
        const int grid_h = __vsub4(grid_pos.y ^ signs1, signs1);
        const int u1 = *((const int *) bq8->qs + l0 + 1);
        sumi = ggml_cuda_dp4a(grid_l, u0, sumi);
        sumi = ggml_cuda_dp4a(grid_h, u1, sumi);
    }
    const int ls = aux32 >> 28;
    sumi = (ls*sumi + sumi/2)/2;
    return __half2float(bq3->d) * __low2float(bq8->ds) * (float)sumi;
}

template <int NWARP>
__global__ void k_fastld(const uint8_t * W, const block_q8_1 * y, float * dst, int row_bytes) {
    const int tid = 32*threadIdx.y + threadIdx.x;
    const int row = blockIdx.x;
    const int bpr = row_bytes / 98;
    constexpr int bpi = NWARP*64/QI, div = 8;
    const int kqs = VDR*(tid % div);
    float tmp = 0.0f;
    const block_iq3_xxs * wrow = (const block_iq3_xxs *)(W + (size_t)row * row_bytes);
    for (int kbx = tid / div; kbx < bpr; kbx += bpi) {
        tmp += vd_iq3xxs_fastld(wrow + kbx, y + kbx*(QK/32), kqs);
    }
if constexpr (NWARP > 1) {
        __shared__ float sh[NWARP-1][32];
        if (threadIdx.y > 0) sh[threadIdx.y-1][threadIdx.x] = tmp;
        __syncthreads();
        if (threadIdx.y == 0) {
#pragma unroll
            for (int l = 0; l < NWARP-1; ++l) tmp += sh[l][threadIdx.x];
            tmp = warp_reduce<32>(tmp);
            if (threadIdx.x == 0) dst[row] = tmp;
        }
    } else {
        tmp = warp_reduce<32>(tmp);
        if (tid == 0) dst[row] = tmp;
    }
}

// ---------------- V6: LDS-cached grid table ----------------------------------
template <int NWARP>
__global__ void k_ldsg(const uint8_t * W, const block_q8_1 * y, float * dst, int row_bytes) {
    __shared__ uint32_t g[256];
    const int tid = 32*threadIdx.y + threadIdx.x;
    const int lane = tid & 31;
    for (int j = tid; j < 256; j += NWARP*32) g[j] = iq3xxs_grid[j];
    __syncthreads();
    const int row = blockIdx.x;
    const int bpr = row_bytes / 98;
    constexpr int bpi = NWARP*64/QI, div = 8;
    const int kqs = VDR*(tid % div);
    float tmp = 0.0f;
    const block_iq3_xxs * wrow = (const block_iq3_xxs *)(W + (size_t)row * row_bytes);
    for (int kbx = tid / div; kbx < bpr; kbx += bpi) {
        const block_iq3_xxs * bq3 = wrow + kbx;
        const block_q8_1 * bq8 = y + kbx*(QK/32) + kqs/2;
        const int2 q3_packed = make_int2(get_int_b2(bq3->qs, kqs), get_int_b2(bq3->qs, kqs+1));
        const uint8_t * q3 = (const uint8_t *) &q3_packed;
        const uint32_t aux32 = get_int_b2(bq3->qs, 16 + kqs/2);
        int sumi = 0;
#pragma unroll
        for (int l0 = 0; l0 < 8; l0 += 2) {
            const int2 grid_pos = make_int2(g[q3[l0]], g[q3[l0+1]]);
            const uint32_t signs = unpack_ksigns(aux32 >> (7*l0/2));
            const int signs0 = __vcmpne4(signs & 0x08040201, 0);
            const int grid_l = __vsub4(grid_pos.x ^ signs0, signs0);
            const int u0 = *((const int *) bq8->qs + l0 + 0);
            const int signs1 = __vcmpne4(signs & 0x80402010, 0);
            const int grid_h = __vsub4(grid_pos.y ^ signs1, signs1);
            const int u1 = *((const int *) bq8->qs + l0 + 1);
            sumi = ggml_cuda_dp4a(grid_l, u0, sumi);
            sumi = ggml_cuda_dp4a(grid_h, u1, sumi);
        }
        const int ls = aux32 >> 28;
        sumi = (ls*sumi + sumi/2)/2;
        tmp += __half2float(bq3->d) * __low2float(bq8->ds) * (float)sumi;
    }
    (void)lane;
    if constexpr (NWARP > 1) {
        __shared__ float sh[NWARP-1][32];
        if (threadIdx.y > 0) sh[threadIdx.y-1][lane] = tmp;
        __syncthreads();
        if (threadIdx.y == 0) {
#pragma unroll
            for (int l = 0; l < NWARP-1; ++l) tmp += sh[l][lane];
            tmp = warp_reduce<32>(tmp);
            if (lane == 0) dst[row] = tmp;
        }
    } else {
        tmp = warp_reduce<32>(tmp);
        if (tid == 0) dst[row] = tmp;
    }
}

// ---------------- V7: 2-way ILP split accumulators ---------------------------
__global__ __launch_bounds__(32, 1) void k_ilp2(
        const uint8_t * W, const block_q8_1 * y, float * dst, int row_bytes) {
    const int tid = threadIdx.x;
    const int row = blockIdx.x;
    const int bpr = row_bytes / 98;
    constexpr int bpi = 4, div = 8;
    const int kqs = VDR*(tid % div);
    float ta = 0.0f, tb = 0.0f;
    const block_iq3_xxs * wrow = (const block_iq3_xxs *)(W + (size_t)row * row_bytes);
    int ka = tid / div, kb = ka + bpi;
    for (; kb < bpr; ka += 2*bpi, kb += 2*bpi) {
        ta += vd_iq3xxs(wrow + ka, y + ka*(QK/32), kqs);
        tb += vd_iq3xxs(wrow + kb, y + kb*(QK/32), kqs);
    }
    if (ka < bpr) ta += vd_iq3xxs(wrow + ka, y + ka*(QK/32), kqs);
    float tmp = warp_reduce<32>(ta + tb);
    if (tid == 0) dst[row] = tmp;
}

// ---------------- V8: fastld + nontemporal weight reads ----------------------
static __device__ __forceinline__ uint32_t ld_un_nt(const uint8_t * p) {
    const uintptr_t a = (uintptr_t) p;
    const uint32_t * ap = (const uint32_t *)(a & ~(uintptr_t)3);
    const int sh = (int)(a & 3) * 8;
    if (!sh) return __builtin_nontemporal_load(ap);
    return __funnelshift_r(__builtin_nontemporal_load(ap), __builtin_nontemporal_load(ap+1), sh);
}

static __device__ __forceinline__ float vd_iq3xxs_nt(
        const block_iq3_xxs * bq3, const block_q8_1 * bq8_base, const int iqs) {
    const uint32_t qa = ld_un_nt(bq3->qs + 4*iqs);
    const uint32_t qb = ld_un_nt(bq3->qs + 4*(iqs+1));
    const uint32_t aux32 = ld_un_nt(bq3->qs + 64 + 4*(iqs/2));
    const uint8_t * q3a = (const uint8_t *) &qa;
    const uint8_t * q3b = (const uint8_t *) &qb;
    const block_q8_1 * bq8 = bq8_base + iqs/2;
    int sumi = 0;
#pragma unroll
    for (int l0 = 0; l0 < 8; l0 += 2) {
        const bool lo = l0 < 4;
        const int2 grid_pos = make_int2(iq3xxs_grid[lo ? q3a[l0] : q3b[l0-4]],
                                        iq3xxs_grid[lo ? q3a[l0+1] : q3b[l0-3]]);
        const uint32_t signs = unpack_ksigns(aux32 >> (7*l0/2));
        const int signs0 = __vcmpne4(signs & 0x08040201, 0);
        const int grid_l = __vsub4(grid_pos.x ^ signs0, signs0);
        const int u0 = *((const int *) bq8->qs + l0 + 0);
        const int signs1 = __vcmpne4(signs & 0x80402010, 0);
        const int grid_h = __vsub4(grid_pos.y ^ signs1, signs1);
        const int u1 = *((const int *) bq8->qs + l0 + 1);
        sumi = ggml_cuda_dp4a(grid_l, u0, sumi);
        sumi = ggml_cuda_dp4a(grid_h, u1, sumi);
    }
    const int ls = aux32 >> 28;
    sumi = (ls*sumi + sumi/2)/2;
    return __half2float(bq3->d) * __low2float(bq8->ds) * (float)sumi;
}

template <int NWARP>
__global__ void k_stream_nt(const uint8_t * W, const block_q8_1 * y, float * dst, int row_bytes) {
    const int tid = 32*threadIdx.y + threadIdx.x;
    const int row = blockIdx.x;
    const int bpr = row_bytes / 98;
    constexpr int bpi = NWARP*64/QI, div = 8;
    const int kqs = VDR*(tid % div);
    float tmp = 0.0f;
    const block_iq3_xxs * wrow = (const block_iq3_xxs *)(W + (size_t)row * row_bytes);
    for (int kbx = tid / div; kbx < bpr; kbx += bpi) {
        tmp += vd_iq3xxs_nt(wrow + kbx, y + kbx*(QK/32), kqs);
    }
    if constexpr (NWARP > 1) {
        __shared__ float sh[NWARP-1][32];
        if (threadIdx.y > 0) sh[threadIdx.y-1][threadIdx.x] = tmp;
        __syncthreads();
        if (threadIdx.y == 0) {
#pragma unroll
            for (int l = 0; l < NWARP-1; ++l) tmp += sh[l][threadIdx.x];
            tmp = warp_reduce<32>(tmp);
            if (threadIdx.x == 0) dst[row] = tmp;
        }
    } else {
        tmp = warp_reduce<32>(tmp);
        if (tid == 0) dst[row] = tmp;
    }
}

// ---------------- V9: software-pipelined weight prefetch ----------------------
// Issue all six weight loads for iteration i+1 before doing the arithmetic of
// iteration i, doubling memory-level parallelism per thread.
__global__ __launch_bounds__(32, 1) void k_pipe(
        const uint8_t * W, const block_q8_1 * y, float * dst, int row_bytes) {
    const int tid = threadIdx.x;
    const int row = blockIdx.x;
    const int bpr = row_bytes / 98;
    constexpr int bpi = 4, div = 8;
    const int kqs = VDR*(tid % div);
    const block_iq3_xxs * wrow = (const block_iq3_xxs *)(W + (size_t)row * row_bytes);

    int kbx = tid / div;
    float tmp = 0.0f;

    uint32_t qa = 0, qb = 0, au = 0;
    if (kbx < bpr) {
        qa = ld_un(wrow[kbx].qs + 4*kqs);
        qb = ld_un(wrow[kbx].qs + 4*(kqs+1));
        au = ld_un(wrow[kbx].qs + 64 + 4*(kqs/2));
    }
    while (kbx < bpr) {
        const int kn = kbx + bpi;
        uint32_t qa_n = 0, qb_n = 0, au_n = 0;
        if (kn < bpr) {
            qa_n = ld_un(wrow[kn].qs + 4*kqs);
            qb_n = ld_un(wrow[kn].qs + 4*(kqs+1));
            au_n = ld_un(wrow[kn].qs + 64 + 4*(kqs/2));
        }
        // consume current
        const uint8_t * qA = (const uint8_t *)&qa;
        const uint8_t * qB = (const uint8_t *)&qb;
        const block_q8_1 * bq8 = y + kbx*(QK/32) + kqs/2;
        int sumi = 0;
#pragma unroll
        for (int l0 = 0; l0 < 8; l0 += 2) {
            const bool lo = l0 < 4;
            const int2 grid_pos = make_int2(iq3xxs_grid[lo ? qA[l0] : qB[l0-4]],
                                            iq3xxs_grid[lo ? qA[l0+1] : qB[l0-3]]);
            const uint32_t signs = unpack_ksigns(au >> (7*l0/2));
            const int signs0 = __vcmpne4(signs & 0x08040201, 0);
            const int grid_l = __vsub4(grid_pos.x ^ signs0, signs0);
            const int u0 = *((const int *) bq8->qs + l0 + 0);
            const int signs1 = __vcmpne4(signs & 0x80402010, 0);
            const int grid_h = __vsub4(grid_pos.y ^ signs1, signs1);
            const int u1 = *((const int *) bq8->qs + l0 + 1);
            sumi = ggml_cuda_dp4a(grid_l, u0, sumi);
            sumi = ggml_cuda_dp4a(grid_h, u1, sumi);
        }
        const int ls = au >> 28;
        sumi = (ls*sumi + sumi/2)/2;
        tmp += __half2float(wrow[kbx].d) * __low2float(bq8->ds) * (float)sumi;

        qa = qa_n; qb = qb_n; au = au_n;
        kbx = kn;
    }
    tmp = warp_reduce<32>(tmp);
    if (tid == 0) dst[row] = tmp;
}

// ---------------- V10: uint4-vectorized q8 loads ------------------------------
__global__ __launch_bounds__(32, 1) void k_q8v4(
        const uint8_t * W, const block_q8_1 * y, float * dst, int row_bytes) {
    const int tid = threadIdx.x;
    const int row = blockIdx.x;
    const int bpr = row_bytes / 98;
    constexpr int bpi = 4, div = 8;
    const int kqs = VDR*(tid % div);
    float tmp = 0.0f;
    const block_iq3_xxs * wrow = (const block_iq3_xxs *)(W + (size_t)row * row_bytes);
    for (int kbx = tid / div; kbx < bpr; kbx += bpi) {
        const block_iq3_xxs * bq3 = wrow + kbx;
        const block_q8_1 * bq8 = y + kbx*(QK/32) + kqs/2;
        const uint32_t qa = ld_un(bq3->qs + 4*kqs);
        const uint32_t qb = ld_un(bq3->qs + 4*(kqs+1));
        const uint32_t au = ld_un(bq3->qs + 64 + 4*(kqs/2));
        const uint8_t * qA = (const uint8_t *)&qa;
        const uint8_t * qB = (const uint8_t *)&qb;
        // one 16-byte window covers ints l0=0..3; second covers 4..7
        const int4 u_lo = *(const int4 *)(bq8->qs + 0);
        const int4 u_hi = *(const int4 *)(bq8->qs + 16);
        int sumi = 0;
#pragma unroll
        for (int l0 = 0; l0 < 8; l0 += 2) {
            const bool lo = l0 < 4;
            const int2 grid_pos = make_int2(iq3xxs_grid[lo ? qA[l0] : qB[l0-4]],
                                            iq3xxs_grid[lo ? qA[l0+1] : qB[l0-3]]);
            const uint32_t signs = unpack_ksigns(au >> (7*l0/2));
            const int signs0 = __vcmpne4(signs & 0x08040201, 0);
            const int grid_l = __vsub4(grid_pos.x ^ signs0, signs0);
            const int signs1 = __vcmpne4(signs & 0x80402010, 0);
            const int grid_h = __vsub4(grid_pos.y ^ signs1, signs1);
            const int u0 = lo ? ((const int *)&u_lo)[l0] : ((const int *)&u_hi)[l0-4];
            const int u1 = lo ? ((const int *)&u_lo)[l0+1] : ((const int *)&u_hi)[l0-3];
            sumi = ggml_cuda_dp4a(grid_l, u0, sumi);
            sumi = ggml_cuda_dp4a(grid_h, u1, sumi);
        }
        const int ls = au >> 28;
        sumi = (ls*sumi + sumi/2)/2;
        tmp += __half2float(bq3->d) * __low2float(bq8->ds) * (float)sumi;
    }
    tmp = warp_reduce<32>(tmp);
    if (tid == 0) dst[row] = tmp;
}

// ---------------- host data generation (deterministic xorshift64) ------------
static uint64_t rng_s = 42;
static uint64_t rng() { rng_s ^= rng_s << 13; rng_s ^= rng_s >> 7; rng_s ^= rng_s << 17; return rng_s; }

static void gen_weights(uint8_t * buf, size_t row_bytes, int nrows) {
    // valid-pattern fill: fp16 d ~ [0.5,1.06); random payload; aux scale nibble >= 1
    for (size_t off = 0; off + 98 <= (size_t)nrows*row_bytes; off += 98) {
        uint16_t d_bits = 0x3800u | (uint16_t)(rng() & 0x1FFu);
        memcpy(buf + off, &d_bits, 2);
        for (int j = 0; j < 96; ++j) buf[off + 2 + j] = (uint8_t)rng();
        for (int k = 0; k < 8; ++k) buf[off + 2 + 64 + 4*k + 3] |= 0x10;
    }
}

static void gen_y(block_q8_1 * y, int K) {
    const int nb = K/32;
    std::vector<float> x(K);
    for (int b = 0; b < nb; ++b) {
        float amax = 0.f;
        for (int i = 0; i < 32; ++i) {
            x[b*32+i] = ((float)((int)(rng() % 4096) - 2048)) / 2048.f * 1.5f;
            amax = std::max(amax, fabsf(x[b*32+i]));
        }
        const float d = amax / 127.f;
        float s = 0.f;
        for (int i = 0; i < 32; ++i) {
            y[b].qs[i] = (int8_t)std::round(x[b*32+i]/d);
            s += (float)y[b].qs[i]*d;
        }
        y[b].ds.x = __float2half(d);
        y[b].ds.y = __float2half(s);
    }
}

// ---------------- launchers ---------------------------------------------------
static void lchk(){ hipError_t e_=hipGetLastError(); if(e_!=hipSuccess){fprintf(stderr,"launch err %s\n",hipGetErrorString(e_)); exit(1);} }

typedef void (*launch_fn)(const uint8_t*, const block_q8_1*, float*, int, dim3&, dim3&);

static void launch_v0(const uint8_t*W,const block_q8_1*y,float*d,int rb,dim3&g,dim3&b){b=dim3(32);k_v0<<<g,b>>>(W,y,d,rb);lchk();}
static void launch_v1(const uint8_t*W,const block_q8_1*y,float*d,int rb,dim3&g,dim3&b){b=dim3(32,2);k_vnw<2><<<g,b>>>(W,y,d,rb);lchk();}
static void launch_v2(const uint8_t*W,const block_q8_1*y,float*d,int rb,dim3&g,dim3&b){b=dim3(32,4);k_vnw<4><<<g,b>>>(W,y,d,rb);lchk();}
static void launch_v3(const uint8_t*W,const block_q8_1*y,float*d,int rb,dim3&g,dim3&b){b=dim3(32);k_rows2<<<g,b>>>(W,y,d,rb);lchk();}
static void launch_v4(const uint8_t*W,const block_q8_1*y,float*d,int rb,dim3&g,dim3&b){b=dim3(32,4);k_r4w128<<<g,b>>>(W,y,d,rb);lchk();}
static void launch_v5(const uint8_t*W,const block_q8_1*y,float*d,int rb,dim3&g,dim3&b){b=dim3(32);k_fastld<1><<<g,b>>>(W,y,d,rb);lchk();}
static void launch_v6(const uint8_t*W,const block_q8_1*y,float*d,int rb,dim3&g,dim3&b){b=dim3(32);k_ldsg<1><<<g,b>>>(W,y,d,rb);lchk();}
static void launch_v7(const uint8_t*W,const block_q8_1*y,float*d,int rb,dim3&g,dim3&b){b=dim3(32);k_ilp2<<<g,b>>>(W,y,d,rb);lchk();}
static void launch_v8(const uint8_t*W,const block_q8_1*y,float*d,int rb,dim3&g,dim3&b){b=dim3(32);k_stream_nt<1><<<g,b>>>(W,y,d,rb);lchk();}

static void launch_v9(const uint8_t*W,const block_q8_1*y,float*d,int rb,dim3&g,dim3&b){b=dim3(32);k_pipe<<<g,b>>>(W,y,d,rb);lchk();}
static void launch_v10(const uint8_t*W,const block_q8_1*y,float*d,int rb,dim3&g,dim3&b){b=dim3(32);k_q8v4<<<g,b>>>(W,y,d,rb);lchk();}

static launch_fn LFN[11] = { launch_v0, launch_v1, launch_v2, launch_v3, launch_v4, launch_v5, launch_v6, launch_v7, launch_v8, launch_v9, launch_v10 };
static const char * VNAMES[11] = { "V0_baseline_wg32", "V1_wg64", "V2_wg128", "V3_rows2_wg32", "V4_rows4_wg128",
                                   "V5_fastld_funnel", "V6_lds_grid", "V7_ilp2", "V8_fastld_nt", "V9_pipe_prefetch", "V10_q8_uint4" };
static const void * KPTR[11];
static inline int grid_for(int vid, int N) { return vid == 3 ? N/2 : vid == 4 ? N/4 : N; }

__global__ void k_noop() {}
__global__ void k_dep(float * p) { float v = *p; *p = v + 1.0f; }

extern "C" void iq3xxs_ref_gemv(const uint8_t*, const uint8_t*, float*, int, int);

int main(int argc, char ** argv) {
    const std::string mode = argc > 1 ? argv[1] : "bench";
    const int only_v = argc > 2 ? atoi(argv[2]) : -1;
    CK(hipInit(0));
    hipDeviceProp_t prop; CK(hipGetDeviceProperties(&prop, 0));
    printf("# device %s CUs=%d\n", prop.name, prop.multiProcessorCount);

    KPTR[0]=(void*)k_v0; KPTR[1]=(void*)k_vnw<2>; KPTR[2]=(void*)k_vnw<4>; KPTR[3]=(void*)k_rows2;
    KPTR[4]=(void*)k_r4w128; KPTR[5]=(void*)k_fastld<1>; KPTR[6]=(void*)k_ldsg<1>; KPTR[7]=(void*)k_ilp2;
    KPTR[8]=(void*)k_stream_nt<1>; KPTR[9]=(void*)k_pipe; KPTR[10]=(void*)k_q8v4;

    const int NBUF = 24;

    if (mode == "info") {
        FILE * f = fopen("compiler_kernel_info.json", "w");
        fprintf(f, "{\n  \"device\": \"%s\",\n  \"note\": \"num_regs from hipFuncGetAttributes (VGPR count on ROCm)\",\n  \"kernels\": [\n", prop.name);
        for (int i = 0; i < 11; ++i) {
            hipFuncAttributes attr; CK(hipFuncGetAttributes(&attr, KPTR[i]));
            int occ32 = 0; CK(hipOccupancyMaxActiveBlocksPerMultiprocessor(&occ32, KPTR[i], 32, 0));
            fprintf(f, "    {\"name\":\"%s\",\"num_regs\":%d,\"shared_bytes\":%zu,\"local_bytes\":%zu,\"max_threads\":%d,\"occ_blocks_at_32thr\":%d}%s\n",
                    VNAMES[i], attr.numRegs, attr.sharedSizeBytes, attr.localSizeBytes, attr.maxThreadsPerBlock, occ32, i<10?",":"");
            printf("%-18s regs=%d shared=%zu local=%zu occ32=%d\n", VNAMES[i], attr.numRegs, attr.sharedSizeBytes, attr.localSizeBytes, occ32);
        }
        fprintf(f, "  ]\n}\n"); fclose(f);
        return 0;
    }

    for (int si = 0; si < 2; ++si) {
        const shape_t S = SHAPES[si];
        const size_t wbytes_one = (size_t)S.N * S.row_bytes;
        const size_t ybytes = (size_t)S.K/32*36;

        std::vector<uint8_t> whost(wbytes_one);
        gen_weights(whost.data(), S.row_bytes, S.N);
        std::vector<uint8_t> yhost(ybytes);
        gen_y((block_q8_1 *)yhost.data(), S.K);

        uint8_t ** Wdev = new uint8_t *[NBUF];
        for (int c = 0; c < NBUF; ++c) { CK(hipMalloc((void**)&Wdev[c], wbytes_one)); CK(hipMemcpy(Wdev[c], whost.data(), wbytes_one, hipMemcpyHostToDevice)); }
        block_q8_1 * ydev; CK(hipMalloc((void**)&ydev, ybytes)); CK(hipMemcpy(ydev, yhost.data(), ybytes, hipMemcpyHostToDevice));
        float * dst; CK(hipMalloc((void**)&dst, sizeof(float)*S.N));

        std::vector<float> refh(S.N), gpu(S.N);

        if (mode == "check") {
            iq3xxs_ref_gemv(whost.data(), yhost.data(), refh.data(), S.N, S.row_bytes);
            printf("[ref] row0=%.4f\n", refh[0]);
            double rmax = 0; for (int i = 0; i < S.N; ++i) rmax = std::max(rmax, (double)fabsf(refh[i]));
            printf("shape%d N=%d K=%d row_bytes=%d |ref|max=%.4f\n", si, S.N, S.K, S.row_bytes, rmax);
            for (int v = 0; v < 11; ++v) {
                if (only_v >= 0 && v != only_v) continue;
                CK(hipMemset(dst, 0, sizeof(float)*S.N));
                dim3 g(grid_for(v, S.N)), b(32);
                LFN[v](Wdev[0], ydev, dst, S.row_bytes, g, b);
                CK(hipDeviceSynchronize());
                CK(hipMemcpy(gpu.data(), dst, sizeof(float)*S.N, hipMemcpyDeviceToHost));
                double mx = 0, sum = 0, mxrel = 0; long bitexact = 0;
                static std::vector<float> base; static bool have_base = false;
                if (v == 0) { base = gpu; have_base = true; }
                for (int i = 0; i < S.N; ++i) {
                    const double e = fabs((double)gpu[i] - (double)refh[i]);
                    mx = std::max(mx, e); sum += e;
                    mxrel = std::max(mxrel, e / std::max(rmax, 1e-30));
                    if (have_base && gpu[i] == base[i]) ++bitexact;
                }
                printf("  %-18s max_abs=%.3e mean_abs=%.3e rel_max=%.3e vs_ref | vs_base_bitmatch=%.4f | gpu0=%g ref0=%g\n",
                       VNAMES[v], mx, sum/S.N, mxrel, (double)bitexact/S.N, (double)gpu[0], (double)refh[0]);
            }
        } else if (mode == "graph") {
            hipStream_t st; CK(hipStreamCreate(&st));
            const int ITER = 192;
            dim3 b(32), g(grid_for(0, S.N));
            for (int c = 0; c < 30; ++c) k_v0<<<g,b,0,st>>>(Wdev[c%NBUF], ydev, dst, S.row_bytes);
            CK(hipStreamSynchronize(st));
            std::vector<double> rs;
            for (int r = 0; r < 7; ++r) {
                hipEvent_t e0,e1; CK(hipEventCreate(&e0)); CK(hipEventCreate(&e1));
                CK(hipEventRecord(e0, st));
                for (int c = 0; c < ITER; ++c) k_v0<<<g,b,0,st>>>(Wdev[c%NBUF], ydev, dst, S.row_bytes);
                CK(hipEventRecord(e1, st)); CK(hipEventSynchronize(e1));
                float ms=0; CK(hipEventElapsedTime(&ms,e0,e1)); rs.push_back(ms/ITER);
                CK(hipEventDestroy(e0)); CK(hipEventDestroy(e1));
            }
            std::sort(rs.begin(), rs.end());
            printf("shape%d v0_stream med_us_per_call=%.2f eff_gbps=%.1f\n", si, rs[3]*1e3, wbytes_one/(rs[3]*1e-3)/1e9);
            {
                const int NODES = NBUF;
                CK(hipStreamBeginCapture(st, hipStreamCaptureModeRelaxed));
                for (int c = 0; c < NODES; ++c) k_v0<<<g,b,0,st>>>(Wdev[c], ydev, dst, S.row_bytes);
                hipGraph_t gr; CK(hipStreamEndCapture(st, &gr));
                hipGraphExec_t ex; CK(hipGraphInstantiate(&ex, gr, nullptr, nullptr, 0));
                for (int w = 0; w < 5; ++w) CK(hipGraphLaunch(ex, st));
                CK(hipStreamSynchronize(st));
                std::vector<double> rg;
                const int REPLAY = ITER / NODES;
                for (int r = 0; r < 7; ++r) {
                    hipEvent_t e0,e1; CK(hipEventCreate(&e0)); CK(hipEventCreate(&e1));
                    CK(hipEventRecord(e0, st));
                    for (int q = 0; q < REPLAY; ++q) CK(hipGraphLaunch(ex, st));
                    CK(hipEventRecord(e1, st)); CK(hipEventSynchronize(e1));
                    float ms=0; CK(hipEventElapsedTime(&ms,e0,e1)); rg.push_back(ms/(double)(REPLAY*NODES));
                    CK(hipEventDestroy(e0)); CK(hipEventDestroy(e1));
                }
                std::sort(rg.begin(), rg.end());
                printf("shape%d v0_graph med_us_per_call=%.2f eff_gbps=%.1f nodes=%d\n", si, rg[3]*1e3, wbytes_one/(rg[3]*1e-3)/1e9, NODES);
                CK(hipGraphExecDestroy(ex)); CK(hipGraphDestroy(gr));
            }
            {
                float * flag; CK(hipMalloc((void**)&flag, 4)); CK(hipMemset(flag, 0, 4));
                dim3 g1(1);
                const int M = 512;
                for (int w = 0; w < 50; ++w) k_dep<<<g1,32,0,st>>>(flag);
                CK(hipStreamSynchronize(st));
                std::vector<double> rd;
                for (int r = 0; r < 5; ++r) {
                    hipEvent_t e0,e1; CK(hipEventCreate(&e0)); CK(hipEventCreate(&e1));
                    CK(hipEventRecord(e0, st));
                    for (int i = 0; i < M; ++i) k_dep<<<g1,32,0,st>>>(flag);
                    CK(hipEventRecord(e1, st)); CK(hipEventSynchronize(e1));
                    float ms=0; CK(hipEventElapsedTime(&ms,e0,e1)); rd.push_back(ms/M*1e3);
                    CK(hipEventDestroy(e0)); CK(hipEventDestroy(e1));
                }
                std::sort(rd.begin(), rd.end());
                printf("shape%d dep_chain_stream med_us_per_node=%.2f\n", si, rd[2]);
                {
                    CK(hipStreamBeginCapture(st, hipStreamCaptureModeRelaxed));
                    for (int i = 0; i < M; ++i) k_dep<<<g1,32,0,st>>>(flag);
                    hipGraph_t gr; CK(hipStreamEndCapture(st, &gr));
                    hipGraphExec_t ex; CK(hipGraphInstantiate(&ex, gr, nullptr, nullptr, 0));
                    for (int w = 0; w < 5; ++w) CK(hipGraphLaunch(ex, st));
                    CK(hipStreamSynchronize(st));
                    std::vector<double> rgd;
                    for (int r = 0; r < 5; ++r) {
                        hipEvent_t e0,e1; CK(hipEventCreate(&e0)); CK(hipEventCreate(&e1));
                        CK(hipEventRecord(e0, st));
                        for (int q = 0; q < 20; ++q) CK(hipGraphLaunch(ex, st));
                        CK(hipEventRecord(e1, st)); CK(hipEventSynchronize(e1));
                        float ms=0; CK(hipEventElapsedTime(&ms,e0,e1)); rgd.push_back(ms/(20.0*M)*1e3);
                        CK(hipEventDestroy(e0)); CK(hipEventDestroy(e1));
                    }
                    std::sort(rgd.begin(), rgd.end());
                    printf("shape%d dep_chain_graph med_us_per_node=%.2f\n", si, rgd[2]);
                    CK(hipGraphExecDestroy(ex)); CK(hipGraphDestroy(gr));
                }
                CK(hipFree(flag));
            }
            CK(hipStreamDestroy(st));
        } else if (mode == "bench") {
            const int ITER = 192, REPS = 7;
            printf("shape%d N=%d K=%d wbytes_per_call=%.2f MB\n", si, S.N, S.K, wbytes_one/1e6);
            for (int v = 0; v < 11; ++v) {
                if (only_v >= 0 && v != only_v) continue;
                dim3 b(32);
                for (int c = 0; c < 30; ++c) {
                    dim3 g(grid_for(v, S.N));
                    LFN[v](Wdev[c%NBUF], ydev, dst, S.row_bytes, g, b);
                }
                CK(hipDeviceSynchronize());
                std::vector<double> rep_ms;
                for (int r = 0; r < REPS; ++r) {
                    hipEvent_t e0, e1; CK(hipEventCreate(&e0)); CK(hipEventCreate(&e1));
                    CK(hipEventRecord(e0));
                    for (int c = 0; c < ITER; ++c) {
                        dim3 g(grid_for(v, S.N));
                        LFN[v](Wdev[c%NBUF], ydev, dst, S.row_bytes, g, b);
                    }
                    CK(hipEventRecord(e1)); CK(hipEventSynchronize(e1));
                    float ms = 0; CK(hipEventElapsedTime(&ms, e0, e1));
                    CK(hipEventDestroy(e0)); CK(hipEventDestroy(e1));
                    rep_ms.push_back(ms/ITER);
                }
                std::vector<double> sorted(rep_ms);
                std::sort(sorted.begin(), sorted.end());
                const double med = sorted[REPS/2];
                const double gbps = wbytes_one / (med*1e-3) / 1e9;
                printf("shape%d %-18s med_ms_per_call=%.5f eff_gbps=%.1f reps=[", si, VNAMES[v], med, gbps);
                for (double m : rep_ms) printf("%.5f ", m);
                printf("]\n");
                fflush(stdout);
            }
        }

        for (int c = 0; c < NBUF; ++c) CK(hipFree(Wdev[c]));
        CK(hipFree(ydev)); CK(hipFree(dst));
        delete[] Wdev;
    }
    return 0;
}
