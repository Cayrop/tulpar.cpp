// E3.0: q4_0 -> f16 staging microbenchmark on real KV tensor shapes.
// One thread converts one q4_0 block (32 elems, 18 B) to 64 B of f16.
// Sweeps launch geometry; a pure-copy kernel on the same output
// footprint is the bandwidth reference.
#include <hip/hip_runtime.h>
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <hip/hip_fp16.h>

#define CK(x) do { hipError_t e_ = (x); if (e_) { printf("HIP error %s at %d\n", hipGetErrorString(e_), __LINE__); exit(1); } } while (0)

__device__ __forceinline__ uint32_t pack2(float a, float b) {
    __half2 h = __floats2half2_rn(a, b);
    return ((uint32_t) __half_as_ushort(__high2half(h)) << 16) | __half_as_ushort(__low2half(h));
}

__global__ void dequant_q4_0(const uint8_t * __restrict__ in, uint32_t * __restrict__ out, size_t nblk) {
    size_t i = (size_t) blockIdx.x * blockDim.x + threadIdx.x;
    size_t s = (size_t) gridDim.x * blockDim.x;
    for (; i < nblk; i += s) {
        const uint8_t * qb = in + i * 18;
        const float d = __half2float(*(const __half *) qb);
        float f[32];
        #pragma unroll
        for (int k = 0; k < 16; k++) {
            uint8_t b = qb[2 + k];
            f[2 * k]     = (b & 0xF) - 8;
            f[2 * k + 1] = (b >> 4) - 8;
        }
        #pragma unroll
        for (int k = 0; k < 16; k++) f[k] *= d;
        #pragma unroll
        for (int k = 16; k < 32; k++) f[k] = f[k - 16]; // bench-only fill of the second half
        uint32_t w[16];
        #pragma unroll
        for (int k = 0; k < 16; k++) w[k] = pack2(f[2 * k], f[2 * k + 1]);
        uint4 * ow = (uint4 *) (out + i * 16);
        ow[0] = make_uint4(w[0], w[1], w[2], w[3]);
        ow[1] = make_uint4(w[4], w[5], w[6], w[7]);
        ow[2] = make_uint4(w[8], w[9], w[10], w[11]);
        ow[3] = make_uint4(w[12], w[13], w[14], w[15]);
    }
}

__global__ void copy_bw(const uint4 * __restrict__ src, uint4 * __restrict__ dst, size_t n) {
    size_t i = (size_t) blockIdx.x * blockDim.x + threadIdx.x;
    size_t s = (size_t) gridDim.x * blockDim.x;
    for (; i < n; i += s) dst[i] = src[i];
}

int main(int argc, char ** argv) {
    CK(hipSetDevice(0));
    hipDeviceProp_t prop;
    CK(hipGetDeviceProperties(&prop, 0));
    int cus = prop.multiProcessorCount;
    printf("# device %s CUs=%d\n", prop.name, cus);

    long long toks[] = {16384, 65536, 131072};
    const int feats = 1024; // 4 kv heads x head_dim 256

    hipEvent_t e0, e1;
    CK(hipEventCreate(&e0)); CK(hipEventCreate(&e1));

    for (long long T : toks) {
        size_t nblk = (size_t) T * feats / 32;
        size_t in_b = nblk * 18, out_b = nblk * 64;
        uint8_t * din; uint32_t * dout;
        CK(hipMalloc(&din, in_b));
        CK(hipMalloc(&dout, out_b));
        CK(hipMemset(din, 0x88, in_b));

        double best = 0; int bg = 0, bt = 0;
        for (int tpb : {64, 128, 256, 512}) {
            for (int waves : {4, 8, 16, 32}) {
                int grid = cus * waves;
                if ((size_t) grid * tpb > nblk) continue;
                dequant_q4_0<<<grid, tpb>>>(din, dout, nblk);
                CK(hipDeviceSynchronize());
                const int iters = 30;
                CK(hipEventRecord(e0));
                for (int i = 0; i < iters; i++) dequant_q4_0<<<grid, tpb>>>(din, dout, nblk);
                CK(hipEventRecord(e1));
                CK(hipEventSynchronize(e1));
                float ms; CK(hipEventElapsedTime(&ms, e0, e1));
                ms /= iters;
                double gbps = (double)(in_b + out_b) / (ms * 1e-3) / 1e9;
                if (gbps > best) { best = gbps; bg = grid; bt = tpb; }
            }
        }
        printf("T=%lld  dequant best %.1f GB/s traffic (R %.1f MB + W %.1f MB) at grid=%d tpb=%d\n",
               T, best, in_b / 1e6, out_b / 1e6, bg, bt);

        double cbest = 0;
        size_t n4 = in_b / 16; // stay within source bounds
        for (int tpb : {256, 512}) {
            int grid = cus * 16;
            copy_bw<<<grid, tpb>>>((const uint4 *) din, (uint4 *) dout, n4);
            CK(hipDeviceSynchronize());
            const int iters = 30;
            CK(hipEventRecord(e0));
            for (int i = 0; i < iters; i++) copy_bw<<<grid, tpb>>>((const uint4 *) din, (uint4 *) dout, n4);
            CK(hipEventRecord(e1));
            CK(hipEventSynchronize(e1));
            float ms; CK(hipEventElapsedTime(&ms, e0, e1));
            ms /= iters;
            double gbps = (double)(in_b * 2) / (ms * 1e-3) / 1e9; // R+W
            if (gbps > cbest) cbest = gbps;
        }
        printf("T=%lld  copy ref %.1f GB/s (R+W)\n", T, cbest);

        CK(hipFree(din)); CK(hipFree(dout));
    }
    return 0;
}
