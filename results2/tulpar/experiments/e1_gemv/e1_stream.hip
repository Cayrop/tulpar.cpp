// E1: machine-level streaming read/copy bandwidth ceiling on gfx1101.
#include <hip/hip_runtime.h>
#include <cstdio>
#include <cstdlib>

#define CK(x) do { hipError_t e_ = (x); if (e_) { printf("HIP error %s at %d\n", hipGetErrorString(e_), __LINE__); exit(1); } } while (0)

__global__ void read_bw(const float4 * __restrict__ p, size_t n, float * out) {
    float4 acc = {0.f, 0.f, 0.f, 0.f};
    size_t i = (size_t) blockIdx.x * blockDim.x + threadIdx.x;
    size_t s = (size_t) gridDim.x * blockDim.x;
    for (; i < n; i += s) {
        float4 v = p[i];
        acc.x += v.x; acc.y += v.y; acc.z += v.z; acc.w += v.w;
    }
    float r = acc.x + acc.y + acc.z + acc.w;
    if (r == 123456789.f) out[0] = r;
}

__global__ void copy_bw(const float4 * __restrict__ src, float4 * __restrict__ dst, size_t n) {
    size_t i = (size_t) blockIdx.x * blockDim.x + threadIdx.x;
    size_t s = (size_t) gridDim.x * blockDim.x;
    for (; i < n; i += s) dst[i] = src[i];
}

int main() {
    CK(hipSetDevice(0));
    hipDeviceProp_t prop;
    CK(hipGetDeviceProperties(&prop, 0));
    int waves, tpb = 256, wgs;
    CK(hipDeviceGetAttribute(&waves, hipDeviceAttributeMultiprocessorCount, 0));

    const size_t bytes = (size_t) 2 << 30;
    const size_t n4 = bytes / sizeof(float4);
    float4 * p, * q; float * out;
    CK(hipMalloc(&p, bytes));
    CK(hipMalloc(&q, bytes));
    CK(hipMalloc(&out, 4));
    CK(hipMemset(p, 1, bytes));
    CK(hipMemset(q, 2, bytes));

    hipEvent_t e0, e1;
    CK(hipEventCreate(&e0)); CK(hipEventCreate(&e1));
    float best_read = 0, best_copy = 0;
    int best_g = 0, best_t = 0;

    for (int g : {2048, 4096, 8192, 16384}) {
        for (int t : {256, 512}) {
            // warm
            read_bw<<<g, t>>>(p, n4, out); copy_bw<<<g, t>>>(p, q, n4);
            CK(hipDeviceSynchronize());
            const int passes = 20;
            CK(hipEventRecord(e0));
            for (int i = 0; i < passes; i++) read_bw<<<g, t>>>(p, n4, out);
            CK(hipEventRecord(e1));
            CK(hipEventSynchronize(e1));
            float msr; CK(hipEventElapsedTime(&msr, e0, e1));
            double r_gbps = (double) passes * bytes / (msr * 1e-3) / 1e9;

            CK(hipEventRecord(e0));
            for (int i = 0; i < passes / 2; i++) copy_bw<<<g, t>>>(p, q, n4);
            CK(hipEventRecord(e1));
            CK(hipEventSynchronize(e1));
            float msc; CK(hipEventElapsedTime(&msc, e0, e1));
            double c_gbps = 2.0 * (passes / 2) * bytes / (msc * 1e-3) / 1e9;

            printf("grid=%5d tpb=%3d  read %.1f GB/s   copy(R+W) %.1f GB/s\n", g, t, r_gbps, c_gbps);
            if (r_gbps > best_read) { best_read = r_gbps; best_copy = c_gbps; best_g = g; best_t = t; }
        }
    }
    printf("BEST: read %.1f GB/s (copy %.1f GB/s) at grid=%d tpb=%d  CUs=%d\n",
           best_read, best_copy, best_g, best_t, waves);
    return 0;
}
