#include "llama.h"

#include <algorithm>
#include <climits>
#include <clocale>
#include <cstdio>
#include <cstring>
#include <string>
#include <vector>

static void print_usage(const char * prog) {
    fprintf(stderr, "usage: %s -m model.gguf -o out.bin [-t out.toks] [-x out.txt] [-p prompt] [-n n_predict] [-s seed] [-ngl n_gpu_layers]\n", prog);
}

int main(int argc, char ** argv) {
    std::setlocale(LC_NUMERIC, "C");

    std::string model_path;
    std::string prompt = "The quick brown fox jumps over the lazy dog. ";
    std::string out_bin;
    std::string out_toks;
    std::string out_text;
    int n_predict = 128;
    int seed = 42;
    int ngl = 999;

    for (int i = 1; i < argc; ++i) {
        if (strcmp(argv[i], "-m") == 0 && i + 1 < argc) {
            model_path = argv[++i];
        } else if (strcmp(argv[i], "-p") == 0 && i + 1 < argc) {
            prompt = argv[++i];
        } else if (strcmp(argv[i], "-o") == 0 && i + 1 < argc) {
            out_bin = argv[++i];
        } else if (strcmp(argv[i], "-t") == 0 && i + 1 < argc) {
            out_toks = argv[++i];
        } else if (strcmp(argv[i], "-x") == 0 && i + 1 < argc) {
            out_text = argv[++i];
        } else if (strcmp(argv[i], "-n") == 0 && i + 1 < argc) {
            n_predict = std::stoi(argv[++i]);
        } else if (strcmp(argv[i], "-s") == 0 && i + 1 < argc) {
            seed = std::stoi(argv[++i]);
        } else if (strcmp(argv[i], "-ngl") == 0 && i + 1 < argc) {
            ngl = std::stoi(argv[++i]);
        } else {
            print_usage(argv[0]);
            return 1;
        }
    }

    if (model_path.empty() || out_bin.empty()) {
        print_usage(argv[0]);
        return 1;
    }

    ggml_backend_load_all();

    llama_model_params model_params = llama_model_default_params();
    model_params.n_gpu_layers = ngl;
    model_params.load_mode = LLAMA_LOAD_MODE_MMAP;

    llama_model * model = llama_model_load_from_file(model_path.c_str(), model_params);
    if (model == NULL) {
        fprintf(stderr, "error: unable to load model\n");
        return 1;
    }

    const llama_vocab * vocab = llama_model_get_vocab(model);
    const int32_t n_vocab = llama_vocab_n_tokens(vocab);

    const int n_prompt = -llama_tokenize(vocab, prompt.c_str(), prompt.size(), NULL, 0, true, true);
    std::vector<llama_token> prompt_tokens(n_prompt);
    if (llama_tokenize(vocab, prompt.c_str(), prompt.size(), prompt_tokens.data(), prompt_tokens.size(), true, true) < 0) {
        fprintf(stderr, "error: failed to tokenize the prompt\n");
        return 1;
    }

    llama_context_params ctx_params = llama_context_default_params();
    ctx_params.n_ctx = n_prompt + n_predict + 8;
    ctx_params.n_batch = 512;
    ctx_params.n_threads = 1;
    ctx_params.n_threads_batch = 1;
    ctx_params.flash_attn_type = LLAMA_FLASH_ATTN_TYPE_ENABLED;
    ctx_params.type_k = GGML_TYPE_Q4_0;
    ctx_params.type_v = GGML_TYPE_Q4_0;

    llama_context * ctx = llama_init_from_model(model, ctx_params);
    if (ctx == NULL) {
        fprintf(stderr, "error: failed to create the llama_context\n");
        return 1;
    }

    FILE * fbin = fopen(out_bin.c_str(), "wb");
    if (fbin == NULL) {
        fprintf(stderr, "error: unable to open %s\n", out_bin.c_str());
        return 1;
    }

    FILE * ftoks = NULL;
    if (!out_toks.empty()) {
        ftoks = fopen(out_toks.c_str(), "w");
        if (ftoks == NULL) {
            fprintf(stderr, "error: unable to open %s\n", out_toks.c_str());
            return 1;
        }
        fprintf(ftoks, "step\ttoken_id\n");
    }

    FILE * ftext = NULL;
    if (!out_text.empty()) {
        ftext = fopen(out_text.c_str(), "w");
        if (ftext == NULL) {
            fprintf(stderr, "error: unable to open %s\n", out_text.c_str());
            return 1;
        }
    }

    const uint32_t magic = 0x474C4732;
    const uint32_t version = 1;
    const uint32_t n_rows = (uint32_t)n_predict;
    fwrite(&magic,   sizeof(magic),   1, fbin);
    fwrite(&version, sizeof(version), 1, fbin);
    fwrite(&seed,    sizeof(seed),    1, fbin);
    fwrite(&n_rows,  sizeof(n_rows),  1, fbin);
    fwrite(&n_vocab, sizeof(n_vocab), 1, fbin);

    llama_batch batch = llama_batch_get_one(prompt_tokens.data(), prompt_tokens.size());
    if (llama_decode(ctx, batch)) {
        fprintf(stderr, "error: failed to eval prompt\n");
        return 1;
    }

    for (int step = 0; step < n_predict; ++step) {
        float * logits = llama_get_logits(ctx);
        if (logits == NULL) {
            fprintf(stderr, "error: no logits at step %d\n", step);
            return 1;
        }

        fwrite(logits, sizeof(float), (size_t)n_vocab, fbin);
        if (ferror(fbin)) {
            fprintf(stderr, "error: write failure at step %d\n", step);
            return 1;
        }

        llama_token best = 0;
        float best_logit = logits[0];
        for (int32_t i = 1; i < n_vocab; ++i) {
            if (logits[i] > best_logit) {
                best_logit = logits[i];
                best = (llama_token)i;
            }
        }

        if (ftoks != NULL) {
            fprintf(ftoks, "%d\t%d\n", step, (int)best);
        }

        if (ftext != NULL) {
            char buf[512];
            int n = llama_token_to_piece(vocab, best, buf, sizeof(buf), 0, true);
            if (n > 0) {
                fwrite(buf, 1, (size_t)n, ftext);
            }
        }

        batch = llama_batch_get_one(&best, 1);
        if (llama_decode(ctx, batch)) {
            fprintf(stderr, "error: failed to eval step %d\n", step);
            return 1;
        }
    }

    if (fclose(fbin) != 0) {
        fprintf(stderr, "error: closing %s\n", out_bin.c_str());
        return 1;
    }
    if (ftoks != NULL && fclose(ftoks) != 0) {
        fprintf(stderr, "error: closing %s\n", out_toks.c_str());
        return 1;
    }
    if (ftext != NULL && fclose(ftext) != 0) {
        fprintf(stderr, "error: closing %s\n", out_text.c_str());
        return 1;
    }

    llama_free(ctx);
    llama_model_free(model);

    return 0;
}
