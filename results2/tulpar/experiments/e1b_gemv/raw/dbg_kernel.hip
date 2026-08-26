#define GGML_COMMON_DECL_HIP
#define GGML_COMMON_IMPL_HIP
#include "ggml-common.h"
#include <hip/hip_runtime.h>
#include <cstdio>
#include <cstdint>

typedef int8_t int8x4_t __attribute__((ext_vector_type(4)));
typedef uint8_t uint8x4_t __attribute__((ext_vector_type(4)));
static __device__ __forceinline__ int __vsubss4(const int a, const int b) {
    const int8x4_t va = reinterpret_cast<const int8x4_t&>(a);
    const int8x4_t vb = reinterpret_cast<const int8x4_t&>(b);
    const int8x4_t c = __builtin_elementwise_sub_sat(va, vb);
    return reinterpret_cast<const int &>(c);
}
static __device__ __forceinline__ int __vsub4(const int a, const int b){return __vsubss4(a,b);}
static __device__ __forceinline__ unsigned int __vcmpne4(unsigned int a, unsigned int b){
    const uint8x4_t& va = reinterpret_cast<const uint8x4_t&>(a);
    const uint8x4_t& vb = reinterpret_cast<const uint8x4_t&>(b);
    unsigned int c; uint8x4_t& vc = reinterpret_cast<uint8x4_t&>(c);
#pragma unroll
    for(int i=0;i<4;++i) vc[i]= va[i]==vb[i]?0x00:0xff;
    return c;
}
typedef union { struct { uint16_t d; uint16_t s; }; uint32_t ds; } h2;

__global__ void dbg(const uint8_t * W, const uint8_t * y8){
    if (blockIdx.x==0 && threadIdx.x==0) {
        const block_iq3_xxs * bq3 = (const block_iq3_xxs*)W;
        const block_q8_1 * bq8 = (const block_q8_1*)y8;
        const int2 qp = make_int2(
            (int)((const uint8_t*)bq3->qs)[0]|((int)((const uint8_t*)bq3->qs)[1]<<8)|((int)((const uint8_t*)bq3->qs)[2]<<16)|((int)((const uint8_t*)bq3->qs)[3]<<24),
            0);
        printf("d=%04x q0=%02x %02x %02x %02x\n", (unsigned)*(uint16_t*)&bq3->d,
            ((const uint8_t*)bq3->qs)[0],((const uint8_t*)bq3->qs)[1],((const uint8_t*)bq3->qs)[2],((const uint8_t*)bq3->qs)[3]);
        // manual one-block dot replicating vecdotq
        const int2 q3_packed = make_int2(
            ((const uint8_t*)bq3->qs)[0] | (((const uint8_t*)bq3->qs)[1]<<8) | (((const uint8_t*)bq3->qs)[2]<<16) | (((int)((const uint8_t*)bq3->qs)[3])<<24),
            ((const uint8_t*)bq3->qs)[4] | (((const uint8_t*)bq3->qs)[5]<<8) | (((const uint8_t*)bq3->qs)[6]<<16) | (((int)((const uint8_t*)bq3->qs)[7])<<24));
        const uint8_t * q3 = (const uint8_t *) &q3_packed;
        const uint32_t aux32 = ((const uint8_t*)bq3->qs)[8] | (((const uint8_t*)bq3->qs)[9]<<8) | (((uint32_t)((const uint8_t*)bq3->qs)[10])<<16) | (((uint32_t)((const uint8_t*)bq3->qs)[11])<<24);
        printf("aux32=%08x q3p0=%08x q3p1=%08x\n", aux32, (unsigned)q3_packed.x, (unsigned)q3_packed.y);
        int sumi=0;
        for (int l0=0;l0<8;l0+=2){
            const int2 gp = make_int2(iq3xxs_grid[q3[l0]], iq3xxs_grid[q3[l0+1]]);
            const uint32_t v7=(aux32>>(7*l0/2))&0xFF;
            const uint32_t p=__popc(v7)&1; const uint32_t sg=(v7^(p<<7))*0x01010101u;
            const int s0=__vcmpne4(sg & 0x08040201,0);
            const int gl=__vsub4(gp.x ^ s0, s0);
            int u0; memcpy(&u0, bq8->qs+4*l0,4);
            const int s1=__vcmpne4(sg & 0x80402010,0);
            const int gh=__vsub4(gp.y ^ s1, s1);
            int u1; memcpy(&u1, bq8->qs+4*(l0+1),4);
            int c0=__builtin_amdgcn_sudot4(true, gl, true, u0, 0, false);
            int c1=__builtin_amdgcn_sudot4(true, gh, true, u1, 0, false);
            printf("l0=%d gp=%08x/%08x sg=%08x gl=%08x gh=%08x u0=%08x u1=%08x dot=%d,%d\n",
                l0,(unsigned)gp.x,(unsigned)gp.y,sg,(unsigned)gl,(unsigned)gh,(unsigned)u0,(unsigned)u1,c0,c1);
            sumi += c0+c1;
        }
        const int ls=aux32>>28;
        sumi=(ls*sumi+sumi/2)/2;
        float dd; *(uint16_t*)&bq3->d; 
        __half hf = *(const __half*)&bq3->d;
        float dv = __half2float(hf);
        __half hy = *(const __half*)&bq8->ds;
        float dy = __half2float(hy);
        printf("ls=%d sumi=%d d=%f dy=%f contrib=%f\n", ls, sumi, dv, dy, dv*dy*sumi);
    }
}
int main(){
    uint8_t *W,*Y; hipMalloc(&W,64); hipMalloc(&Y,64);
    uint8_t hw[64], hy[64];
    FILE*f=fopen("dbg_block.bin","rb");
    fread(hw,1,14,f); fread(hy,1,36,f); fclose(f);
    hipMemcpy(W,hw,64,hipMemcpyHostToDevice); hipMemcpy(Y,hy,64,hipMemcpyHostToDevice);
    dbg<<<1,32>>>(W,Y);
    hipDeviceSynchronize();
    return 0;
}
