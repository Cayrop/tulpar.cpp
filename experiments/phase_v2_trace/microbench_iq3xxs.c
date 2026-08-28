/*
 * Microbenchmark: iq3xxs grid expansion, table vs arithmetic, on this machine.
 * Replicates the inner op sequence of ggml_vec_dot_iq3_xxs_q8_K (AVX2).
 * Measurement: rdtsc, median of N runs. No perf dependency.
 * Chunk layout (one ib32 pair, 64 elements): 64 B q8 + 16 B q3 + 8 B gas = 88 B.
 */
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "immintrin.h"

static uint64_t rdtsc(void) {
    uint32_t lo, hi;
    __asm__ volatile ("rdtsc" : "=a"(lo), "=d"(hi));
    return ((uint64_t)hi << 32) | lo;
}

static uint32_t table256[256];
static uint64_t signs64[128];
volatile uint32_t result_sink;

struct bench_args {
    char *buf;
    int   nchunk;
};

static uint64_t bench(uint64_t (*fn)(void *), void *arg, int runs) {
    uint64_t t[runs];
    for (int r = 0; r < runs; ++r) t[r] = fn(arg);
    for (int i = 1; i < runs; ++i)
        for (int j = i; j < runs; ++j)
            if (t[j] < t[i]) { uint64_t tmp = t[i]; t[i] = t[j]; t[j] = tmp; }
    return t[runs / 2];
}

/* one ib32 pair (64 elements): table path, faithful to ggml source op sequence */
static uint64_t run_table_impl(struct bench_args *a) {
    uint64_t t0 = rdtsc();
    uint32_t sink = 0;
    for (int c = 0; c < a->nchunk; ++c) {
        char *chunk = a->buf + c * 88;
        const int8_t  *q8  = (const int8_t  *)chunk;
        const uint8_t *q3  = (const uint8_t *)chunk + 64;
        const uint32_t *gas = (const uint32_t *)(chunk + 80);
        const __m256i q8_1 = _mm256_loadu_si256((const __m256i *)(q8));
        const __m256i q8_2 = _mm256_loadu_si256((const __m256i *)(q8 + 32));
        const __m256i q2_1 = _mm256_set_epi32(table256[q3[7]],  table256[q3[6]],  table256[q3[5]],  table256[q3[4]],
                                              table256[q3[3]],  table256[q3[2]],  table256[q3[1]],  table256[q3[0]]);
        const __m256i q2_2 = _mm256_set_epi32(table256[q3[15]], table256[q3[14]], table256[q3[13]], table256[q3[12]],
                                              table256[q3[11]], table256[q3[10]], table256[q3[9]],  table256[q3[8]]);
        const uint32_t a0 = gas[0], a1 = gas[1];
        const __m256i s2_1 = _mm256_set_epi64x(signs64[(a0 >> 21) & 127], signs64[(a0 >> 14) & 127],
                                               signs64[(a0 >> 7)  & 127], signs64[(a0 >> 0)  & 127]);
        const __m256i s2_2 = _mm256_set_epi64x(signs64[(a1 >> 21) & 127], signs64[(a1 >> 14) & 127],
                                               signs64[(a1 >> 7)  & 127], signs64[(a1 >> 0)  & 127]);
        const __m256i q8s_1 = _mm256_sign_epi8(q8_1, s2_1);
        const __m256i q8s_2 = _mm256_sign_epi8(q8_2, s2_2);
        __m256i p1 = _mm256_maddubs_epi16(q2_1, q8s_1);
        __m256i p2 = _mm256_maddubs_epi16(q2_2, q8s_2);
        __m256i h1 = _mm256_madd_epi16(p1, p1);
        __m256i h2 = _mm256_madd_epi16(p2, p2);
        h1 = _mm256_add_epi32(h1, h2);
        alignas(32) int32_t hv[8];
        _mm256_store_si256((__m256i *)hv, h1);
        for (int k = 0; k < 8; ++k) sink += hv[k];
    }
    result_sink = (sink);
    return rdtsc() - t0;
}

/* arithmetic path: 12-bit codeword per 4 elems (2 per uint32), unpack + byte math */
static uint64_t run_arith_impl(struct bench_args *a) {
    uint64_t t0 = rdtsc();
    uint32_t sink = 0;
    for (int c = 0; c < a->nchunk; ++c) {
        char *chunk = a->buf + c * 88;
        const int8_t   *q8  = (const int8_t *)(chunk);
        const uint32_t *cw  = (const uint32_t *)(chunk + 64);
        const uint32_t *gas = (const uint32_t *)(chunk + 80);
        const __m256i q8_1 = _mm256_loadu_si256((const __m256i *)(q8));
        const __m256i q8_2 = _mm256_loadu_si256((const __m256i *)(q8 + 32));
        uint32_t c0 = cw[0], c1 = cw[1], c2 = cw[2], c3 = cw[3];
        uint32_t x[8] = { c0 & 0xfff, c0 >> 12, c1 & 0xfff, c1 >> 12,
                          c2 & 0xfff, c2 >> 12, c3 & 0xfff, c3 >> 12 };
        uint32_t g[8];
        for (int j = 0; j < 8; ++j) {
            uint32_t l0 = x[j] & 7, l1 = (x[j] >> 3) & 7, l2 = (x[j] >> 6) & 7, l3 = (x[j] >> 9) & 7;
            uint32_t b0 = (l0 << 3) + 4 - 2 * (l0 == 7);
            uint32_t b1 = (l1 << 3) + 4 - 2 * (l1 == 7);
            uint32_t b2 = (l2 << 3) + 4 - 2 * (l2 == 7);
            uint32_t b3 = (l3 << 3) + 4 - 2 * (l3 == 7);
            g[j] = b0 | (b1 << 8) | (b2 << 16) | (b3 << 24);
        }
        const __m256i q2_1 = _mm256_set_epi32(g[7], g[6], g[5], g[4], g[3], g[2], g[1], g[0]);
        const __m256i q2_2 = _mm256_set_epi32(g[3] + 1, g[2], g[1], g[0], g[7], g[6], g[5], g[4]);
        const uint32_t a0 = gas[0], a1 = gas[1];
        const __m256i s2_1 = _mm256_set_epi64x(signs64[(a0 >> 21) & 127], signs64[(a0 >> 14) & 127],
                                               signs64[(a0 >> 7)  & 127], signs64[(a0 >> 0)  & 127]);
        const __m256i s2_2 = _mm256_set_epi64x(signs64[(a1 >> 21) & 127], signs64[(a1 >> 14) & 127],
                                               signs64[(a1 >> 7)  & 127], signs64[(a1 >> 0)  & 127]);
        const __m256i q8s_1 = _mm256_sign_epi8(q8_1, s2_1);
        const __m256i q8s_2 = _mm256_sign_epi8(q8_2, s2_2);
        __m256i p1 = _mm256_maddubs_epi16(q2_1, q8s_1);
        __m256i p2 = _mm256_maddubs_epi16(q2_2, q8s_2);
        __m256i h1 = _mm256_madd_epi16(p1, p1);
        __m256i h2 = _mm256_madd_epi16(p2, p2);
        h1 = _mm256_add_epi32(h1, h2);
        alignas(32) int32_t hv[8];
        _mm256_store_si256((__m256i *)hv, h1);
        for (int k = 0; k < 8; ++k) sink += hv[k];
    }
    result_sink = (sink);
    return rdtsc() - t0;
}

/* 32 independent scalar gathers from a runtime 256-entry table (L1) */
static volatile uint32_t *gtable; /* volatile: prevents optimizer folding, same CPU load cost */
static uint32_t gidx[64];
static uint64_t run_gather_impl(struct bench_args *a) {
    uint64_t t0 = rdtsc();
    (void)a;
    uint32_t acc = 0;
    for (int i = 0; i < 32; ++i) acc += gtable[gidx[i]];
    result_sink = (acc);
    return rdtsc() - t0;
}

/* dependent gather chain: next index depends on the previous load */
static uint64_t run_gather_chain_impl(struct bench_args *a) {
    uint64_t t0 = rdtsc();
    (void)a;
    uint32_t idx = gidx[0];
    uint32_t acc = 0;
    for (int i = 0; i < 64; ++i) {
        uint32_t v = gtable[idx];
        acc += v;
        idx = (idx * 7 + (v & 255)) & 255;
    }
    result_sink = (acc);
    return rdtsc() - t0;
}

/* 16 256-bit shift+add (pure ALU MOP throughput), values from runtime buffer */
static uint64_t run_alu_impl(struct bench_args *a) {
    uint64_t t0 = rdtsc();
    const __m256i b0 = _mm256_loadu_si256((const __m256i *)a->buf);
    const __m256i b1 = _mm256_loadu_si256((const __m256i *)(a->buf + 32));
    __m256i x = _mm256_add_epi32(b0, b1);
    for (int r = 0; r < 14; ++r) {
        x = _mm256_add_epi32(x, _mm256_slli_epi32(x, 3));
    }
    alignas(32) int32_t xv[8];
    _mm256_store_si256((__m256i *)xv, x);
    uint32_t acc = (uint32_t)(xv[0] + xv[1] + xv[2] + xv[3] + xv[4] + xv[5] + xv[6] + xv[7]);
    result_sink = (acc);
    return rdtsc() - t0;
}

/* 2 independent 32B L1 loads per chunk (512 B touched per chunk) */
static uint64_t run_l1stream_impl(struct bench_args *a) {
    uint64_t t0 = rdtsc();
    uint32_t acc = 0;
    char *buf = a->buf;
    for (int c = 0; c < a->nchunk; ++c) {
        const __m256i x0 = _mm256_loadu_si256((const __m256i *)(buf + c * 88));
        const __m256i x1 = _mm256_loadu_si256((const __m256i *)(buf + c * 88 + 32));
        alignas(32) int32_t v0[8], v1[8];
        _mm256_store_si256((__m256i *)v0, x0);
        _mm256_store_si256((__m256i *)v1, x1);
        for (int k = 0; k < 8; ++k) acc += v0[k] + v1[k];
    }
    result_sink = (acc);
    return rdtsc() - t0;
}

static uint64_t wrap_table(void *a)      { return run_table_impl((struct bench_args *)a); }
static uint64_t wrap_arith(void *a)      { return run_arith_impl((struct bench_args *)a); }
static uint64_t wrap_gather(void *a)     { return run_gather_impl((struct bench_args *)a); }
static uint64_t wrap_gather_chain(void *a) { return run_gather_chain_impl((struct bench_args *)a); }
static uint64_t wrap_alu(void *a)        { return run_alu_impl((struct bench_args *)a); }
static uint64_t wrap_l1stream(void *a)   { return run_l1stream_impl((struct bench_args *)a); }

static void fill_chunk(char *chunk, int arith_packed) {
    for (int i = 0; i < 64; ++i) chunk[i] = (char)rand();
    for (int i = 64; i < 80; ++i) chunk[i] = rand() % 256; /* q3 indices */
    for (int i = 80; i < 88; ++i) chunk[i] = rand();
    if (arith_packed) {
        /* repack the 16 q3 indices (bytes 64..79) as 8 x 12-bit codewords into bytes 64..79 */
        uint32_t *cw = (uint32_t *)(chunk + 64);
        for (int p = 0; p < 4; ++p) {
            uint32_t w = 0;
            for (int h = 0; h < 2; ++h) {
                int base = (p * 2 + h) * 4;
                uint32_t x = 0;
                for (int b = 0; b < 4; ++b) x |= (uint32_t)(chunk[64 + base + b] % 8) << (3 * b);
                w |= x << (12 * h);
            }
            cw[p] = w;
        }
    }
}

int main(void) {
    srand(12345);
    static const int bytevals[8] = {4, 12, 20, 28, 36, 44, 52, 62};
    for (int i = 0; i < 256; ++i) {
        uint32_t v = 0;
        for (int j = 0; j < 4; ++j) {
            int l = rand() % 8;
            v |= (uint32_t)bytevals[l] << (8 * j);
        }
        table256[i] = v;
    }
    for (int i = 0; i < 128; ++i) {
        uint64_t v = 0;
        int par = 0;
        for (int b = 0; b < 7; ++b) {
            v |= (uint64_t)(0xFFULL * ((i >> b) & 1)) << (8 * b);
            par ^= (i >> b) & 1;
        }
        v |= (uint64_t)(0xFFULL * par) << (8 * 7);
        signs64[i] = v;
    }

    enum { NCHUNK_L1 = 128 };  /* 128 * 88 B = 11 KB: L1-resident (Zen 3 L1D = 32 KB) */
    enum { NCHUNK_L2 = 4096 }; /* 358 KB: L2-resident */
    char *bufL1  = aligned_alloc(64, NCHUNK_L1 * 88);
    char *bufL2  = aligned_alloc(64, NCHUNK_L2 * 88);
    char *bufL1p = aligned_alloc(64, NCHUNK_L1 * 88);
    char *bufL2p = aligned_alloc(64, NCHUNK_L2 * 88);
    for (int i = 0; i < NCHUNK_L1; ++i) { fill_chunk(bufL1 + i * 88, 0); memcpy(bufL1p + i * 88, bufL1 + i * 88, 88); fill_chunk(bufL1p + i * 88, 1); }
    for (int i = 0; i < NCHUNK_L2; ++i) { fill_chunk(bufL2 + i * 88, 0); memcpy(bufL2p + i * 88, bufL2 + i * 88, 88); fill_chunk(bufL2p + i * 88, 1); }

    for (int i = 0; i < 32; ++i) gidx[i] = (i * 37 + 13) % 256; /* distinct low addresses */
    {
        uint32_t *gbuf = aligned_alloc(64, 1024);
        for (int i = 0; i < 256; ++i) gbuf[i] = (uint32_t)rand();
        gtable = (volatile uint32_t *)gbuf;
    }

    struct bench_args aL1  = { bufL1,  NCHUNK_L1 };
    struct bench_args aL1p = { bufL1p, NCHUNK_L1 };
    struct bench_args aL2  = { bufL2,  NCHUNK_L2 };
    struct bench_args aL2p = { bufL2p, NCHUNK_L2 };
    struct bench_args dummy = { bufL1, 1 };

    const int RUNS = 31;
    printf("buffer 11 KB (L1-resident):\n");
    printf("  table path : %7.1f cyc / 64 elems\n", bench(wrap_table, &aL1, RUNS) / (double)NCHUNK_L1);
    printf("  arith path : %7.1f cyc / 64 elems\n", bench(wrap_arith, &aL1p, RUNS) / (double)NCHUNK_L1);
    printf("buffer 358 KB (L2-resident):\n");
    printf("  table path : %7.1f cyc / 64 elems\n", bench(wrap_table, &aL2, RUNS) / (double)NCHUNK_L2);
    printf("  arith path : %7.1f cyc / 64 elems\n", bench(wrap_arith, &aL2p, RUNS) / (double)NCHUNK_L2);
    printf("micro-ops:\n");
    { uint64_t gth = bench(wrap_gather, &dummy, RUNS);
      printf("  32 indep gathers: %7.1f cyc total (%.2f cyc/load)\n", (double)gth, (double)gth / 32.0); }
    { uint64_t gch = bench(wrap_gather_chain, &dummy, RUNS);
      printf("  64 dep gathers  : %7.1f cyc / 64 loads (%.2f cyc/load, latency bound)\n", (double)gch, (double)gch / 64.0); }
    { uint64_t alu = bench(wrap_alu, &dummy, RUNS);
      printf("  16 ALU ops      : %7.1f cyc / 16 ops  (%.2f cyc/op)\n", (double)alu, (double)alu / 16.0); }
    { uint64_t l1s = bench(wrap_l1stream, &aL1, RUNS);
      printf("  stream load 32B : %7.2f cyc / load\n", (double)l1s / (double)NCHUNK_L1 / 2.0); }
    return 0;
}
