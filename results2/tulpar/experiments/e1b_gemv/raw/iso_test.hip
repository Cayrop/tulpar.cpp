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
static __device__ __forceinline__ int dp4a_(const int a,const int b,int c){return __builtin_amdgcn_sudot4(true,a,true,b,c,false);}
static __device__ __forceinline__ int get_int_b2(const void * x,const int & i32){
    const uint8_t * x8=(const uint8_t*)x;
    return (int)x8[i32*4]|((int)x8[i32*4+1]<<8)|((int)x8[i32*4+2]<<16)|((int)x8[i32*4+3]<<24);
}
static __device__ __forceinline__ uint32_t unpack_ksigns(const uint8_t v){
    const uint32_t p=__popc(v)&1; const uint32_t s=v^p<<7; return s*0x01010101;
}

static __device__ __forceinline__ uint32_t ld_un(const uint8_t * p) {
    const uintptr_t a = (uintptr_t) p;
    const uint32_t * ap = (const uint32_t *)(a & ~(uintptr_t)3);
    const int sh = (int)(a & 3) * 8;
    if (!sh) return ap[0];
    return __funnelshift_r(ap[0], ap[1], sh);
}

__global__ void probe(const uint8_t * W, const block_q8_1 * y){
    if (blockIdx.x==0&&threadIdx.x==0){
        const block_iq3_xxs * bq3=(const block_iq3_xxs*)W;
        // slice ip=0 -> iqs=0
        int iqs=0;
        const uint32_t qa=ld_un(bq3->qs+4*iqs);
        const uint32_t qb=ld_un(bq3->qs+4*(iqs+1));
        const uint32_t aux=ld_un(bq3->qs+64+4*(iqs/2));
        const uint32_t qa2=get_int_b2(bq3->qs,iqs);
        const uint32_t qb2=get_int_b2(bq3->qs,iqs+1);
        const uint32_t aux2=get_int_b2(bq3->qs,16+iqs/2);
        printf("fastld qa=%08x qb=%08x aux=%08x\n",qa,qb,aux);
        printf("getb2  qa=%08x qb=%08x aux=%08x\n",qa2,qb2,aux2);
        // also iqs=2 case (odd dword index)
        iqs=2;
        const uint32_t ca=ld_un(bq3->qs+4*iqs);
        const uint32_t cb=ld_un(bq3->qs+4*(iqs+1));
        const uint32_t caux=ld_un(bq3->qs+64+4*(iqs/2));
        printf("iqs2 fastld %08x %08x %08x | getb2 %08x %08x %08x\n",ca,cb,caux,
               get_int_b2(bq3->qs,iqs),get_int_b2(bq3->qs,iqs+1),get_int_b2(bq3->qs,16+iqs/2));
    }
}
int main(){
    uint8_t *W,*Y; hipMalloc(&W,4096); hipMalloc(&Y,4096);
    FILE*f=fopen("iso_row.bin","rb");
    uint8_t hw[1960],hy[8*36];
    fread(hw,1,1960,f); fread(hy,1,8*36,f); fclose(f);
    hipMemcpy(W,hw,1960,hipMemcpyHostToDevice); hipMemcpy(Y,hy,8*36,hipMemcpyHostToDevice);
    probe<<<1,32>>>(W,(const block_q8_1*)Y);
    hipDeviceSynchronize();
    return 0;
}
