// E1: GEMV bandwidth envelope on real model shapes.
// Links against the same ggml the server uses; benches mul_mat with
// batch=1 (decode path) per shape listed in shapes.txt.
#include "ggml.h"
#include "ggml-alloc.h"
#include "ggml-backend.h"
#include <cstring>

#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <chrono>
#include <vector>
#include <algorithm>

static ggml_type parse_type(const char * s) {
    if (!strcmp(s, "IQ3_XXS")) return GGML_TYPE_IQ3_XXS;
    if (!strcmp(s, "IQ3_S"))   return GGML_TYPE_IQ3_S;
    if (!strcmp(s, "IQ4_XS"))  return GGML_TYPE_IQ4_XS;
    if (!strcmp(s, "IQ2_S"))   return GGML_TYPE_IQ2_S;
    if (!strcmp(s, "Q3_K"))    return GGML_TYPE_Q3_K;
    if (!strcmp(s, "Q2_K"))    return GGML_TYPE_Q2_K;
    if (!strcmp(s, "Q4_K"))    return GGML_TYPE_Q4_K;
    if (!strcmp(s, "Q4_0"))    return GGML_TYPE_Q4_0;
    fprintf(stderr, "unknown type %s\n", s);
    exit(1);
}

// fill a quantized tensor with valid-pattern bytes without an imatrix:
// first half of each block is scale d -> set to 1.0f, rest random bytes
static void fill_quant_host(ggml_type type, std::vector<uint8_t> & buf, size_t nbytes) {
    const size_t bs = ggml_type_size(type);
    uint16_t one;
    float f = 1.0f;
    memcpy(&one, &f, 2); // low half of float 1.0 == f16 1.0 bits 0x3C00
    buf.resize(nbytes);
    for (size_t off = 0; off + bs <= nbytes; off += bs) {
        memcpy(buf.data() + off, &one, 2);
        for (size_t i = 2; i < bs; i++) {
            buf[off + i] = (uint8_t)((off / bs * 1315423911u + i * 2654435761u) >> 24);
        }
    }
}

int main(int argc, char ** argv) {
    if (argc < 2) { fprintf(stderr, "usage: %s shapes.txt\n", argv[0]); return 1; }
    FILE * f = fopen(argv[1], "r");
    if (!f) { perror("shapes"); return 1; }

    ggml_backend_dev_t dev = ggml_backend_dev_by_type(GGML_BACKEND_DEVICE_TYPE_GPU);
    if (!dev) { fprintf(stderr, "no GPU backend\n"); return 1; }
    printf("# device: %s\n", ggml_backend_dev_description(dev));
    ggml_backend_t bk = ggml_backend_dev_init(dev, NULL);

    char ty[32]; long long ne0, ne1, cnt; char label[64];
    double pred_ms_total = 0.0, wbytes_total = 0.0;
    printf("label,type,ne0,ne1,count,ms_per_call,gbps\n");
    while (fscanf(f, "%31s %lld %lld %lld %63s", ty, &ne0, &ne1, &cnt, label) == 5) {
        ggml_type type = parse_type(ty);

        struct ggml_init_params ip = {};
        ip.mem_size = 64 * 1024 * 1024;
        struct ggml_context * ctx = ggml_init(ip);
        ggml_set_no_alloc(ctx, true);

        struct ggml_tensor * a = ggml_new_tensor_2d(ctx, type, ne0, ne1);
        struct ggml_tensor * b = ggml_new_tensor_2d(ctx, GGML_TYPE_F32, ne0, 1);
        ggml_backend_buffer_t wbuf = ggml_backend_alloc_ctx_tensors_from_buft(ctx,
            ggml_backend_get_default_buffer_type(bk));
        size_t a_bytes = ggml_nbytes(a);
        float * bh = (float *) malloc(ggml_nbytes(b));
        for (long long i = 0; i < ne0; i++) bh[i] = 1.0f;

        std::vector<uint8_t> qa;
        fill_quant_host(type, qa, a_bytes);
        ggml_backend_tensor_set(a, qa.data(), 0, a_bytes);
        ggml_backend_tensor_set(b, bh, 0, ggml_nbytes(b));

        struct ggml_tensor * c = ggml_mul_mat(ctx, a, b);
        struct ggml_gallocr * gal = ggml_gallocr_new(ggml_backend_get_default_buffer_type(bk));
        struct ggml_cgraph * gf = ggml_new_graph(ctx);
        ggml_build_forward_expand(gf, c);
        ggml_gallocr_alloc_graph(gal, gf);

        // warmup + adaptive iteration count
        ggml_backend_graph_compute(bk, gf);
        ggml_backend_synchronize(bk);
        auto t0 = std::chrono::steady_clock::now();
        for (int i = 0; i < 3; i++) ggml_backend_graph_compute(bk, gf);
        ggml_backend_synchronize(bk);
        double pre = std::chrono::duration<double>(std::chrono::steady_clock::now() - t0).count() / 3.0;
        int iters = (int) std::min(500.0, std::max(20.0, 0.7 / std::max(pre, 1e-6)));

        t0 = std::chrono::steady_clock::now();
        for (int i = 0; i < iters; i++) ggml_backend_graph_compute(bk, gf);
        ggml_backend_synchronize(bk);
        double sec = std::chrono::duration<double>(std::chrono::steady_clock::now() - t0).count() / iters;

        double ms = sec * 1e3;
        double gbps = (a_bytes + ggml_nbytes(b) + ggml_nbytes(c)) / sec / 1e9;
        printf("%s,%s,%lld,%lld,%lld,%.4f,%.1f\n", label, ty, ne0, ne1, cnt, ms, gbps);
        pred_ms_total += ms * cnt;
        wbytes_total += a_bytes * cnt;

        ggml_gallocr_free(gal);
        ggml_backend_buffer_free(wbuf);
        free(bh);
        ggml_free(ctx);
    }
    fclose(f);
    printf("# predicted model GEMV total: %.2f ms/token over %.2f GB weights (%.1f GB/s aggregate)\n",
           pred_ms_total, wbytes_total / 1e9, wbytes_total / (pred_ms_total * 1e-3) / 1e9);
    ggml_backend_free(bk);
    return 0;
}
