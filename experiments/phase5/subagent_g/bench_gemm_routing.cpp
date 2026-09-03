// Synthetic benchmark: MMVQ vs MMQ routing for IQ3_XXS on gfx1101 (RDNA3).
//
// Measures ggml_mul_mat throughput for the two Phase-4E FFN shapes at small
// batch sizes. With stock dispatch, ne11 <= 8 runs the MMVQ kernel and
// ne11 in [9..16] runs the MMQ kernel with the same <type=IQ3_XXS, J=16>
// instantiation and grid that ne11 in [4..5] would use (mul_mat_q_switch_J
// picks the smallest config J with ntiles_x == 1, which is 16 for any
// ne11 <= 16).
//
// Outputs are compared against the CPU backend reference.
#include <ggml.h>
#include <ggml-alloc.h>
#include <ggml-backend.h>
#include <ggml-cpu.h>

#include <algorithm>
#include <chrono>
#include <cmath>
#include <cstdio>
#include <cstring>
#include <random>
#include <vector>

struct result {
    int n;
    const char * path;     // "MMVQ" / "MMQ" per stock dispatch rules
    double ms_min;
    double ms_avg;
    double gbps_eff;       // weight bytes streamed once per call / min time
    double gflops;
    bool has_ref;
    float max_abs_diff_vs_cpu;
    float max_rel_diff_vs_cpu;
};

static std::vector<float> gen_activations(int64_t k, int64_t n, uint32_t seed) {
    std::mt19937 rng(seed);
    std::uniform_real_distribution<float> dist(-1.0f, 1.0f);
    std::vector<float> y(k*n);
    for (auto & v : y) {
        v = dist(rng);
    }
    return y;
}

static void compute_cpu_ref(ggml_backend_t cpu, ggml_type type_a, int64_t k, int64_t m, int n,
                            const void * a_data_host, size_t a_nbytes,
                            const std::vector<float> & y_host,
                            std::vector<float> & ref_out) {
    size_t ctx_size = ggml_tensor_overhead()*8 + ggml_graph_overhead();
    struct ggml_init_params ip = { ctx_size, nullptr, /*no_alloc=*/true };
    struct ggml_context * ctx = ggml_init(ip);

    struct ggml_tensor * a = ggml_new_tensor_2d(ctx, type_a, k, m);
    struct ggml_tensor * b = ggml_new_tensor_2d(ctx, GGML_TYPE_F32, k, n);
    struct ggml_tensor * out = ggml_mul_mat(ctx, a, b);

    struct ggml_backend_buffer * buf = ggml_backend_alloc_ctx_tensors(ctx, cpu);
    ggml_backend_tensor_set(a, a_data_host, 0, a_nbytes);
    ggml_backend_tensor_set(b, y_host.data(), 0, y_host.size()*sizeof(float));

    struct ggml_cgraph * cgraph = ggml_new_graph(ctx);
    ggml_build_forward_expand(cgraph, out);
    ggml_backend_graph_compute(cpu, cgraph);

    ref_out.resize(ggml_nelements(out));
    ggml_backend_tensor_get(out, ref_out.data(), 0, ref_out.size()*sizeof(float));

    ggml_backend_buffer_free(buf);
    ggml_free(ctx);
}

// Runs MUL_MAT(out[m,n]) = a[k,m] x b[k,n]^T on the given backend.
static result bench_case(ggml_backend_t backend, ggml_type type_a,
                         int64_t k, int64_t m, int n,
                         const void * a_data_host, size_t a_nbytes,
                         const std::vector<float> & y_host,
                         const std::vector<float> & ref) {
    result r{};
    r.n = n;
    r.path = (n <= 8) ? "MMVQ" : "MMQ";
    r.has_ref = !ref.empty();

    size_t ctx_size = ggml_tensor_overhead()*8 + ggml_graph_overhead();
    struct ggml_init_params ip = { ctx_size, nullptr, /*no_alloc=*/true };
    struct ggml_context * ctx = ggml_init(ip);

    struct ggml_tensor * a = ggml_new_tensor_2d(ctx, type_a, k, m);
    struct ggml_tensor * b = ggml_new_tensor_2d(ctx, GGML_TYPE_F32, k, n);
    struct ggml_tensor * out = ggml_mul_mat(ctx, a, b);

    struct ggml_backend_buffer * buf = ggml_backend_alloc_ctx_tensors(ctx, backend);
    ggml_backend_tensor_set(a, a_data_host, 0, a_nbytes);
    ggml_backend_tensor_set(b, y_host.data(), 0, y_host.size()*sizeof(float));

    struct ggml_cgraph * cgraph = ggml_new_graph(ctx);
    ggml_build_forward_expand(cgraph, out);

    for (int i = 0; i < 5; ++i) {
        ggml_backend_graph_compute(backend, cgraph);
    }

    constexpr int iters = 30;
    double best = 1e30;
    double sum = 0.0;
    for (int i = 0; i < iters; ++i) {
        auto t0 = std::chrono::high_resolution_clock::now();
        ggml_backend_graph_compute(backend, cgraph);
        auto t1 = std::chrono::high_resolution_clock::now();
        double ms = std::chrono::duration<double, std::milli>(t1 - t0).count();
        best = std::min(best, ms);
        sum += ms;
    }
    r.ms_min = best;
    r.ms_avg = sum/iters;

    const double wbytes = (double) ggml_nbytes(a); // weights must be streamed once per call
    r.gbps_eff = wbytes/(best*1e-3)/1e9;
    r.gflops = 2.0*k*m*n/(best*1e-3)/1e9;

    if (!ref.empty()) {
        std::vector<float> out_host(ggml_nelements(out));
        ggml_backend_tensor_get(out, out_host.data(), 0, out_host.size()*sizeof(float));

        float max_abs = 0.0f;
        float max_rel = 0.0f;
        for (size_t i = 0; i < out_host.size(); ++i) {
            const float d = std::fabs(out_host[i] - ref[i]);
            max_abs = std::max(max_abs, d);
            const float denom = std::max(1e-6f, std::fabs(ref[i]));
            max_rel = std::max(max_rel, d/denom);
        }
        r.max_abs_diff_vs_cpu = max_abs;
        r.max_rel_diff_vs_cpu = max_rel;
    }

    ggml_backend_buffer_free(buf);
    ggml_free(ctx);
    return r;
}

static void run_shape(const char * name, ggml_type type_a, int64_t k, int64_t m,
                      const std::vector<int> & ns, ggml_backend_t cuda,
                      ggml_backend_t cpu, FILE * fout) {
    std::vector<float> w(k*m);
    std::mt19937 rng(1234);
    std::uniform_real_distribution<float> dist(-1.0f, 1.0f);
    for (auto & v : w) {
        v = dist(rng);
    }
    const size_t qnbytes = (size_t) ggml_row_size(type_a, k)*m;
    std::vector<uint8_t> qbuf(qnbytes);
    const size_t written = ggml_quantize_chunk(type_a, w.data(), qbuf.data(), 0, m, k, nullptr);
    if (written != qnbytes) {
        fprintf(stderr, "%s: quantize size mismatch %zu vs %zu\n", name, written, qnbytes);
    }

    printf("== %s: W[%lld x %lld] %s (%.1f MiB), K=%lld\n",
           name, (long long) k, (long long) m, ggml_type_name(type_a),
           qnbytes/1024.0/1024.0, (long long) k);
    fprintf(fout, "# == %s k=%lld m=%lld type=%s nbytes=%zu\n",
            name, (long long) k, (long long) m, ggml_type_name(type_a), qnbytes);
    fprintf(fout, "shape,n,path,ms_min,ms_avg,eff_GBps,GFLOPS,max_abs_vs_cpu,max_rel_vs_cpu\n");

    for (int n : ns) {
        std::vector<float> y = gen_activations(k, n, 5678u + n);

        std::vector<float> ref;
        compute_cpu_ref(cpu, type_a, k, m, n, qbuf.data(), qnbytes, y, ref);

        result r = bench_case(cuda, type_a, k, m, n, qbuf.data(), qnbytes, y, ref);

        printf("  n=%3d [%s] min=%8.4f ms avg=%8.4f ms eff=%7.1f GB/s %8.1f GFLOPS",
               r.n, r.path, r.ms_min, r.ms_avg, r.gbps_eff, r.gflops);
        if (r.has_ref) {
            printf(" |cpu| abs=%.4g rel=%.3g", r.max_abs_diff_vs_cpu, r.max_rel_diff_vs_cpu);
        }
        printf("\n");
        fprintf(fout, "%s,%d,%s,%.5f,%.5f,%.2f,%.2f,%.6g,%.6g\n",
                name, r.n, r.path, r.ms_min, r.ms_avg, r.gbps_eff, r.gflops,
                r.has_ref ? r.max_abs_diff_vs_cpu : -1.f,
                r.has_ref ? r.max_rel_diff_vs_cpu : -1.f);
        fflush(fout);
    }
}

int main(int argc, char ** argv) {
    const char * out_path = argc > 1 ? argv[1] : "results.csv";

    ggml_backend_t cuda = nullptr;
    for (size_t i = 0; i < ggml_backend_dev_count() && !cuda; ++i) {
        ggml_backend_dev_t d = ggml_backend_dev_get(i);
        if (ggml_backend_dev_type(d) == GGML_BACKEND_DEVICE_TYPE_GPU) {
            cuda = ggml_backend_dev_init(d, nullptr);
        }
    }
    if (!cuda) {
        fprintf(stderr, "no GPU backend found\n");
        return 1;
    }
    ggml_backend_dev_t dev = ggml_backend_get_device(cuda);
    printf("device: %s\n", ggml_backend_dev_description(dev));

    ggml_backend_t cpu = ggml_backend_cpu_init();
    if (!cpu) {
        fprintf(stderr, "CPU backend not available\n");
        return 1;
    }

    FILE * fout = fopen(out_path, "w");
    if (!fout) {
        fprintf(stderr, "cannot open %s\n", out_path);
        return 1;
    }

    // Phase-4E shapes, Qwen3.8-27B FFN: n_embd=5120, n_ff=17408
    // ffn_down: out=n_ff, k=n_embd ; gate/up: out=n_embd, k=n_ff
    const std::vector<int> ns = {1, 2, 4, 5, 8, 9, 12, 16, 32, 64};
    run_shape("ffn_down", GGML_TYPE_IQ3_XXS, 5120, 17408, ns, cuda, cpu, fout);
    run_shape("gateup",   GGML_TYPE_IQ3_XXS, 17408, 5120, ns, cuda, cpu, fout);

    // control: F16 weights go through the F32-accumulating vector kernel,
    // so error vs CPU should collapse to plain float rounding
    run_shape("ffn_down_f16_ctrl", GGML_TYPE_F16, 5120, 17408, {4}, cuda, cpu, fout);

    fclose(fout);
    ggml_backend_free(cpu);
    ggml_backend_free(cuda);
    printf("done, wrote %s\n", out_path);
    return 0;
}
