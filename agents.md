# Tulpar.cpp / llama.cpp fork — Agent Working Agreement

Bu dosya proje agentleri icin ortak calisma sozlesmesidir.
Agentler optimizasyon, olcum, kod degisikligi ve raporlamada bu kurallara uyar.
Not: Buyuk harfli AGENTS.md upstream llama.cpp katkici kurallaridir; ayri bir dosyadir ve bu sozlesmenin yerine gecmez.

## Document Status

- Last updated by: Phase-2A Full Agent (attribution design + audit complete)
- Date: 2026-08-24
- Previous update: Phase-2A Addendum Agent (MTP-OFF target correction)
- Canonical file: agents.md
- AGENTS.md preserved: YES (not modified)
- Backup: agents.md.bak-phase2a-20260824-170408 (prior: agents.md.bak-addendum-20260824-160114)

## 0. Project Goal

Bu projenin ana hedefi:

- AMD Radeon RX 7800 XT / gfx1101 uzerinde llama.cpp fork'unun TG ve PP performansini optimize etmek.
- TG = token generation / decode. PP = prompt processing / prefill.
- Hedef sadece runtime parametreleriyle benchmark puani artirmak degildir.
- Gercek hedef: kaynak kod, kernel, graph, dispatch, memory path ve mimari seviyesinde dogrulanmis kazanc uretmektir.
- Uzun context performans cokusunu azaltmak kritik hedeftir.
- MTP/speculative decoding kullaniliyorsa performans ve dogruluk etkileri ayrı olculur.
- Upstream submission ayri branch'te yurutulur: fattn-rdna3-quant-tile @ 80cf14ff5 (results2/tulpar/PLAN.md kaydi). tulpar/main uzerinde push/PR yoktur.

### Primary optimization target (Phase-2A addendum, 2026-08-24)

- Primary optimization target: 40 tok/s TG (decode) with MTP OFF.
- MTP ON is secondary. User-reported 70-80 tok/s MTP coding speeds are observational, not measured evidence.
- MTP OFF improvements are preferred because they improve the base execution path and often indirectly improve MTP ON as well.
- Phase-1B MTP OFF baselines vs the 40 tok/s target: 1k 22.06, 16k 20.45, 63k 15.74, 128k 11.98.
- Language rule: future agent prompts and technical reports MUST be written in English unless the operator explicitly requests another language.

## 1. Hardware Context

- GPU: AMD Radeon RX 7800 XT
- Architecture: RDNA3
- GFX target: gfx1101 (rocminfo ile dogrulandi: amdgcn-amd-amdhsa--gfx1101, 60 CU)
- VRAM: 16 GB
- Memory bandwidth nominal: 624 GB/s
- Infinity Cache: 64 MB
- CPU: AMD Ryzen 7 5700X (16 thread, rocminfo ile goruldu)

Donanim teorik degerleri otomatik ulasilabilir performans olarak kabul edilmez.
Her iddia olcumle desteklenmelidir.

## 2. Model Context

- Model path: /home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf
- Model name: Qwen3.8-27B-UD-Q2_K_XL (general.name = Qwen3.8-27B)
- Quantization: MIXED
- Pure Q2 assumption: INVALID (dogrulandi: Q2_K sadece token_embd'de, toplam tensor baytinin %3.91'i)

Ayni dizideki diger modeller (envanter notu):
- Qwen3.8-27B-UD-IQ3_S.gguf (12.04 GB)
- Qwen3.8-27B-UD-Q3_K_XL.gguf (13.44 GB)
- mmproj-F16.gguf (0.93 GB)
Varsayilan calisma modeli Q2_K_XL dosyasidir; baska modele gecis explicit olcmeli yapilir.

### Model metadata

GGUF header okundu (gguf-py ile, agirlik yuklemeden). Tum alanlar VERIFIED:

- Architecture: qwen35 (general.architecture = qwen35; "Qwen3.8" adi pazarlama adidir)
- Layer count: 65 (block_count) + 1 nextn/MTP layer (blk.64.nextn.*)
- Context length: 262144 (256k)
- Embedding length: 5120
- FFN length: 17408
- Attention head count: 24
- KV head count: 4
- Head size: 256 (attention.key_length = attention.value_length = 256). Fork commit'inin hedefledigi head size ile uyumlu.
- GQA: YES (24/4 = 6x)
- Vocab size: 248320 (token_embd shape [5120, 248320])
- RoPE: dimension_count = 64, freq_base = 10,000,000
- RMS norm eps: 1e-6
- full_attention_interval: 4 (hibrit/sliding-window dikkat oruntusu isareti; SWA metadata key'i bulunamadi, yorumlama yapilmaz)
- general.file_type: 14 (enum karsiligi gguf-py surumune gore dogrulanmadi; UD dinamik quant oldugu biliniyor)
- MTP/draft/speculative metadata: YES (qwen35.nextn_predict_layers = 1; tensorler: blk.64.nextn.eh_proj/enorm/hnorm/shared_head_norm)

### Tensor quant inventory

gguf-py ile GGUF reader uzerinden olcildi (tensor n_bytes toplamlari).

| ggml type | tensor count | bytes | pct |
|---|---|---|---|
| IQ3_XXS | 288 | 8,092,385,280 | 75.87% |
| IQ3_S | 99 | 1,376,460,800 | 12.91% |
| Q3_K | 1 | 546,304,000 | 5.12% |
| Q2_K | 1 | 417,177,600 | 3.91% |
| IQ4_XS | 21 | 217,251,840 | 2.04% |
| F32 | 360 | 10,686,464 | 0.10% |
| IQ1_M | 96 | 5,160,960 | 0.05% |

Tensor grubu bazinda dagilim:

- blk.ffn_gate / ffn_up / ffn_down: her biri ~20.9%, icinde %97.9 IQ3_XXS + %2.1 IQ4_XS
- output.weight: Q3_K (%100); token_embd.weight: Q2_K (%100)
- attn_q / attn_k / attn_output: IQ3_S (%100)
- attn_v: IQ4_XS (%100)
- mtp/nextn grubu: IQ4_XS (%99.8)
- Norm/agirlik olmayanlar: F32

Sonuc: Dominant quant format IQ3_XXS'tir (bayt bazinda %75.9). Decode GEMV path'inin ana yuku vec_dot IQ3_XXS kernel'indedir. Bu bulgu bu dosya uzerinde OLCULMUSTUR.

## 3. Repository Map

Repo root: resolve via `git rev-parse --show-toplevel` (absolute user paths not used)

### Key directories

- ggml/src/ggml-cuda/: paylasilan CUDA/HIP kernel kaynaklari (156 dosya). HIP backend bu kaynaklari HIP target ile derler.
- ggml/src/ggml-hip/: HIP backend sarmalayicisi (sadece CMakeLists.txt; gercek kod ggml-cuda'da)
- ggml/src/ggml-cpu/, ggml-metal/, ggml-opencl/, ggml-sycl/ vb.: diger backendler
- src/: llama library (model, context, KV cache, sampling)
- common/: arg parser (arg.cpp), ortak yardimcilar
- tools/: server, cli, llama-bench, quantize, perplexity, mtmd, tokenize, tts, ui vb.
- examples/: speculative, speculative-simple, gguf, gguf-hash, lookahead, lookup vb.
- tests/: test-backend-ops.cpp dahil test suite
- docs/, scripts/, cmake/, grammars/, vendor/

### Key files

Fork'a ozel degisiklik (tek commit 66dcba5eb, +4/-1 ve +4 satir):
- ggml/src/ggml-cuda/fattn.cu : RDNA3 + head size 256 + quantized KV decode icin tile FA dispatch (VEC zorlamasi kaldirildi)
- tests/test-backend-ops.cpp : decode-shaped quant KV head-size-256 test case'leri

Kernel haritasi (confidence HIGH, dosya duzeyinde):
- Dispatch: fattn.cu (FA secimi), mmq.cu / mmvq.cu (matmul secimi), quantize.cu
- GEMV: mmvq.cu + vecdotq.cuh (tum quant turleri icin vec_dot fonksiyonlari: IQ3_XXS dahil)
- GEMM/MMQ: mmq.cu + mmq-config-rdna3.cuh (RDNA3'e ozel config tablosu MEVCUT) + mmq-load-tiles.cuh, mmq-vec-dot.cuh
- Quantize/dequantize: quantize.cu, dequantize.cuh; quantize_q8_1: quantize.cu, fattn-common.cuh, fattn-vec.cuh icinde
- Flash attention: fattn-tile.cu (tile path, quantized KV -> F16 staging), fattn-vec.cuh (vec path), fattn-mma-f16.cuh (mma path), fattn-common.cuh
- Graph capture: ggml/src/ggml-cuda/ggml-cuda.cu (cudaGraph* cagrilari ~satir 2631-2649, 4197; HIP derlemesinde ayni yol hipGraph'a doner, GGML_HIP_GRAPHS=ON ile aktif)
- KV cache: src/llama-kv-cache.cpp/.h, src/llama-kv-cache-iswa.cpp, src/llama-memory-hybrid*.cpp; q4_0 KV runtime tip olarak -ctk/-ctv ile secilir
- Decode path: src/llama-context.cpp (decode/batch orkestrasyonu), src/llama-model.cpp (graph insasi), src/llama-graph.cpp, src/llama-batch.cpp
- Sampling: src/ altinda llama-sampling dosyalari; server sampling tools/server/
- MTP/nextn: src/llama-hparams.h:56 (n_layer_nextn); arch destegi src/llama-arch.cpp (LLM_ARCH_QWEN35 bekleniyor, detayli dogrulama yapilmadi: confidence MEDIUM); draft/verify mantigi examples/speculative* + tools/server spec destegi (--spec-type, LLAMA_ARG_SPEC_DRAFT_MODEL)
- Arg parser: common/arg.cpp (~4400+ satir)

### Build system

- CMake (CMakeLists.txt + CMakePresets.json var; Makefile sadece wrapper)
- Aktif build dizinleri: build/, build-p3/, build-v1/, build-v2/, build-v5/, build-v6/
- Tum cache'lerde ayni temel profil (CMakeCache.txt'den OKUNDU):
  - CMAKE_BUILD_TYPE=Release
  - GGML_HIP=ON, GGML_CUDA=OFF
  - GPU_TARGETS=gfx1101 (GPU_BUILD_TARGETS=gfx1101)
  - GGML_HIP_GRAPHS=ON, GGML_HIP_MMQ_MFMA=ON, GGML_HIP_NO_VMM=ON, GGML_HIP_RCCL=OFF
  - GGML_CUDA_FA_ALL_QUANTS=ON (FA tum quant kombinasyonlarini icerir)
  - GGML_BLAS=OFF, GGML_OPENMP=ON, LLAMA_CURL cache'te gorulmedi (UNKNOWN)
  - LLAMA_BUILD_EXAMPLES/SERVER=ON; TESTS: build=ON, build-p3=ON, build-v6=OFF
- Toolchain: CMake 4.4.2, HIP 7.2.53211 (ROCm 7.x), clang 22.1.8, rocm-smi 4.0.0

### Known binaries

- build/bin/: tam set (llama-cli, llama-server, llama-bench, llama-quantize, llama-perplexity, llama-gguf, llama-speculative, llama-speculative-simple, llama-mtmd-cli, test-backend-ops vb.)
- build-p3/bin/llama-server : Phase-1 raporuna gore production binary (ROCm 7.2.4, gfx1101)
- build-v1/v2/v5/v6/bin/llama-server : deney varyantlari (build_variant.sh ile uretilmis; v1-v6 farklilik detaylari UNKNOWN, results2/build_variant.sh ve build_*.log incelenerek cikarilmali)
- libggml-hip.so tum buildlerde mevcut (HIP backend link dogrulandi)

## 4. Runtime Parameter Map

Kaynak: common/arg.cpp (satir numaralari ile). Performans etkisi iddiasi YOKTUR; sadece tanim yeri ve aciklama.

Genel inference:
- -m/--model (3009), -c/--ctx-size (1636), -ngl/--gpu-layers/--n-gpu-layers (2763), -dev/--device (2718)
- -t/--threads (1514), -tb/--threads-batch (1524)
- -b/--batch-size (1658), -ub/--ubatch-size (1665)
- -n/--predict/--n-predict (1647)
- --temp/--temperature (2004), --top-k (2013), --top-p (2021)

Memory/cache:
- -fa/--flash-attn [on|off|auto] (1743)
- -ctk/--cache-type-k (2426), -ctv/--cache-type-v (2439)
- -nkvo/--no-kv-offload (2404)
- --mlock (2658), --no-mmap (2667), --mmap varsayilan acik

Graph/backend:
- HIP graph runtime CLI flag'i BULUNAMADI. Graph capture compile-time GGML_HIP_GRAPHS ile kontrol edilir. Runtime disable yolu env var mi var mi: UNKNOWN (incelenecek).
- Backend offload: -ngl, -nkvo, -dev; graph debug: GGML_SCHED_DEBUG benzeri env'ler dogrulanmadi (UNKNOWN)

Speculative/MTP (server+cli+speculative ornekleri):
- --spec-type (4173; tur listesi common_speculative_all_types_str)
- --spec-draft-model (4171 civari; env LLAMA_ARG_SPEC_DRAFT_MODEL)
- --draft/--draft-n/--draft-max (4311), --draft-min/--draft-n-min (4318)
- --spec-draft-p-min (4121), --spec-draft-p-split (4114)
- Draft tarafindan: --spec-draft-threads/-cache-type-* vb. genis aile (3927-4060)
- MTP (nextn) ozel parametresi: ayri CLI flag bulunamadi; nextn katmaninin spec type ile nasil secildigi UNKNOWN (kod incelemesi gerekir)

Benchmark (tools/llama-bench/llama-bench.cpp):
- -p/--n-prompt (568), -n/--n-gen (575), -b/--batch-size (600)
- -ctk (614), -ctv (634), -nkvo (795), -fa (818)
- -r/--repetitions (1007), -o/--output (1025)
- -ctg: BU SURUMDE YOK (bulunamadi; eski kayitlarda geciyor olabilir)

Server (tools/server): port/host/slots/metrics parametreleri mevcut (detay satirlari cikarilmadi, arg.cpp + tools/server README'den bakilir). Ayrintili map sonraki faza birakildi.

## 5. Evidence Rules

1. Olculmus production veya production-equivalent sonuc > isolated harness > standalone microbenchmark > teorik hesap > eski tahmin.
2. Upper bound, theoretical ceiling, traffic-equivalent GB/s gibi degerler achieved gain gibi sunulamaz.
3. Eski raporlardaki sayilar yeni olcumle dogrulanmadan "kanit" olarak kullanilmaz.
4. Korelasyon mekizma kaniti degildir.
5. Bilinmeyen degerler UNKNOWN olarak birakilir.
6. Config-only sonuclar nihai cozum degildir; sadece mekanizma izolasyonu olabilir.
7. Her degisiklik review, test ve bakim dagilimi icin uygun olmalidir (upstream PR standardi).
8. Degisiklik basit tutulmalidir; karmaşıklık güvenlik riskini ve bakim maliyetini artirir.

## 6. Measurement Rules

A/B karsilastirmalarinda mumkun oldugunca:

- same commit except tested change
- same GPU, same clock/power state
- same prompt set, same seed, same model, same quantization
- same MTP mode, same context, same measurement method

Kucuk kazancarda:

- en az 3 tekrar, tercihen 5+
- median raporla, raw spread sakla

Traced ve untraced olcumler karistirilmaz. Trace overhead ayrıca raporlanir.
Ortam manifesti cikarmak icin sablon: results2/tulpar/env/ (cpu/gpu/rocm/smi/power_profile kayitlari mevcut).

Kod yorumlari kisa ve net olmalidir; gereksiz yorum avoided edilmelidir. Yorumlar AST-STE100 Simplified Technical English ile yazilmalidir; hard wrapping kullanilmaz.

## 7. Correctness Rules

Her kod/kernel optimizasyonunda minimum dogruluk kapilari:

- deterministic greedy TR + EN
- factual QA, arithmetic, code completion
- JSON/schema/table structured generation
- single needle, multi needle, long-generation degeneration
- 128k needle, mumkunsa
- MTP ON/OFF ayri
- gerektiginde CPU/reference backend karsilastirmasi

Kernel seviyesinde mumkunse:

- max abs diff, relative error distribution, logits diff distribution
- per-layer comparison, cosine similarity where meaningful

Bit-exact zorunlu degildir. Ancak systematic drift, output degradation, needle failure, degeneration, MTP acceptance anomaly kabul edilmez.
Mevcut altyapi: results2/correctness_suite.py ve results2/p3_quality_suite.py (onceki fazlarda kullanilmis, yeniden kullanilabilir).

## 8. Branch Discipline

- Ana uretim branch'i tulpar/main korunur; push yok, PR yok.
- Deneyler ayri branch veya ayrı build dizini (build-v*) uzerinden yapilir; her deney ayni base commit'ten baslar (66dcba5eb).
- Her deney icin: explicit hypothesis, before/after measurement, correctness gate, GO/PARK/DEFER/INVESTIGATE karari.
- Production branch'e optimize kod ancak dogrulanmis deney sonrasi kontrollu sekilde alinir.
- Upstream submission istenirse ayri branch (fattn-rdna3-quant-tile) uzerinden, insan onayi ile yapilir.
- PR bir uzun vadeli baglildir; maintainer'lar koddan fazlasini review, entegre ve bakmak zorundadir.
- Feature request'ler once issue olarak acilmali, dogrulama yapilmalidir; dogrudan PR gonderilmemelidir.

## 9. Safety Rules

1. Hicbir process PPID tahminiyle kill edilmez.
2. Kill yalnizca explicit pidfile'daki PID'e uygulanir.
3. Production stop/start yalnizca mevcut launch script ile yapilir.
4. Profiler-wrapped production restart ancak explicit approval ile yapilir.
5. Her restart sonrasi health check yapilir.
6. Session-critical process'lere dokunulmaz.
7. Uretim binary degistirilmeden once rollback yolu tanimlanir.
8. Deneyler mumkunse isolated harness/process uzerinde yapilir.
9. Repo icinde pidfile bulunamadi (Phase-0 kontrolu); launch script konumu henuz envantere alınmadı (UNKNOWN).
10. AI yazili PR aciklamalari, commit mesajlari veya reviewer yanitlari yapilmaz.
11. Otomatik commit veya PR gonderileri yasaklidir; bu, contributor ban ile sonlanabilir.
12. Kullanici onayi olmadan git push veya gh pr create yapilmaz.
13. AI katkisi varsa disclose edilmelidir (pull request template'e gore). Otomatik tamamlamalar icin disclose gerekmez.
14. Tamamen otonom agent (örn. openclaw tabanli) bu depoya katkida bulunmamalidir; STOP yapilmalı ve llama.cpp disari taşınmalıdır.

## 10. Operational Pidfile and Measurement Window Policy

### Production and Benchmark Process Management

1. Production and benchmark process yonetimi pidfile uzerinden yapilir.
2. Production pidfile: <repo-root>/ops/run/llama-server.pid
3. Benchmark/test profilleri: <repo-root>/ops/run/<profile>.pid
4. pgrep yalnizca discovery/verification icin kullanilir; kill icin kullanilmaz.
5. Legacy process pidfile capture edilebilir; capture stop hakki vermez.
6. Production stop explicit insan onayi gerektirir.
7. Measurement window sirasida once production durdurulur, sonra baseline binary baslatilir, sonra production restore edilir.
8. Tulpar baseline binary: build-p3/bin/llama-server
9. Production binary: build-p3/bin/llama-server (corrected 2026-08-24 by Phase-2A full run; was build/bin/llama-server).
   Fallback binary: build/bin/llama-server. See ops/manifest/prod_flags_correction.md Correction 2.
10. HIP graph runtime disable: GGML_CUDA_DISABLE_GRAPHS=1 (removed from prod_flags.env manifest on 2026-08-24; production runs graphs-enabled; see ops/manifest/prod_flags_correction.md)
11. MTP activation: --spec-type draft-mtp --spec-draft-n-max 4 --spec-draft-p-min 0.8
12. 128k baseline kolu default olarak gated ve single-pass'tir.

## 11. Upstream Contribution Guidelines

Bu bölüm upstream llama.cpp PR/commit/test kurallarini özetler. Tulpar fork operasyon kurallari ile çesitlenirse Tulpar kurallari geçerlidir.

### PR Process

- Her PR uzun vadeli bir baglildir; maintainer'lar koddan fazlasini review, entegre ve bakmak zorundadir.
- Feature request'ler once issue olarak acilmali, dogrulama yapilmalidir; dogrudan PR gonderilmemelidir.
- PR gecerli olabilmek icin: uygun scope, proje kurallarina uyumluluk, contributor'in kodunu tam anlamasi gerekir.
- Private forks exempt.

### Contributor Obligations

1. Kodunu tam anlamali ve reviewer'a AI yardimisi olmadan aciklayabilmelidir.
2. Bakim sahibi olmalidir; bug'lara yanit vermeli ve geri bildirimle ilgili dusunmeli.
3. Direkt iletişim kurmalidir; uzun ve AI-sesli yanitlar kabul edilmez.
4. Maintainer'larin zamani saygı gösterilmeli; PR göndermeden önce mevcut issue/PR'lar kontrol edilmeli.
5. İlk katkıda bulunanlar CONTRIBUTING.md'yi okumustur.

### AI Usage

Permitted:
- Kod tabanini öğrenme ve keşfetme
- İnsan yazılı kod için öneriler
- Mekanik görevler: formatlama, tekrarlayan desenler, mevcut tasarımdan kod tamamlama
- Bileşenler için dokümantasyon taslağı (kontributor zaten kavrayıyorsa)
- Contributor'un sahip olduğu bir tasarımdan kod yazma

Prohibited (immediate PR closure):
- AI yazili PR aciklamalari, commit mesajlari veya reviewer yanitlari
- Kod tabanini anlamadan özellik implementasyonu
- Otomatik commit veya PR gonderileri (contributor ban ile sonlanabilir)

### Code and Commit Standards

- Kod yorumlari kisa tutulmalidir (genellikle 1-2 satir), gereksiz yorum avoided edilmelidir, hard wrapping kullanilmaz.
- Yorumlar AST-STE100 Simplified Technical English ile yazilmalidir; basit kelimeler kullanilmalidir.
- Mevcut altyapi yeniden kullanilmalidir; yeni bileşenler eklenmemeli.
- Degisiklikler mevcut kod kalıbına uyumlu olmalıdır; buyuk degisiklikler önce kullanıcıdan onay alinmalidir.
- Commit mesajlari kisa ve öz olmalıdır (örn. `llama : fix KV being cleared during context shift`).
- AI anlamli katkıda bulunduysa disclose edilmelidir (pull request template'e gore).
- Otomatik PR aciklamalari, commit mesajlari veya reviewer yanitlari AI tarafindan yazilamaz.
- Kullanici onayi olmadan git push veya gh pr create yapilamaz; bu, proje ban ile sonlanabilir.

### Testing

- tests/ dizinine yeni dosya eklenmeden önce maintainer onayı gerekir.
- Mevcut test altyapisi yeniden kullanılmalı; yeni özellikler için gereksiz test case'leri eklenmemeli.
- Her birleştirilen satir review, test ve bakim dagilimi icin uygun olmalidir.

## 12. Conflict Resolution

Aşağıdaki çelişkiler AGENTS.md (upstream) ile agents.md (Tulpar) arasinda tespit edilmistir. Tulpar proje kurallari ve operational safety kurallari önceliklidir.

| AGENTS.md rule | agents.md rule | Resolution | Reason |
|---|---|---|---|
| PR/commit must have explicit human approval | Production stop/start only via launch script | Both apply; Tulpar production safety rules govern operations, AGENTS.md commit rule governs code changes | Tulpar operational safety is more specific to this fork's workflow |
| AI-generated code allowed if understood | Evidence rules require measurement and correctness gates | Both apply; AGENTS.md governs contribution acceptance, agents.md governs validation discipline | Complementary: understanding is necessary but not sufficient for merge |
| Code comments in AST-STE100 English | agents.md uses Turkish/English mix | AGENTS.md comment style applies to C++ source code; agents.md is a project agreement document | Different document types; AGENTS.md comment style applies to code, not to this agreement |
| No autonomous agent contribution | No specific autonomous agent rule | AGENTS.md rule applies; agents.md safety rules reinforce this via pidfile and process management | AGENTS.md is the authoritative upstream rule for agent contribution |
| Feature requests → issue first | Upstream submission via separate branch with human approval | Both apply sequentially: issue first, then branch, then human approval | Complementary steps in the upstream contribution workflow |
| Do not add files in tests/* without approval | Reuse existing test infrastructure | Both apply; no conflict | Complementary |

### Conflict priority order

1. Production safety ve pidfile kurallari (agents.md Safety Rules, Operational Pidfile Policy)
2. Ölçüm disiplini ve evidence rules (agents.md Evidence Rules, Measurement Rules)
3. Tulpar proje hedefi (TG/PP optimization, code-level optimization)
4. Upstream contribution kurallari (AGENTS.md Upstream Contribution Guidelines)
5. Genel upstream alias kurallari (AGENTS.md coding standards)

## 13. Legacy / Upstream Notes

Bu bölümde AGENTS.md'den alınan ama doğrudan uygulanmayan veya referans amaçlı saklanan içerikler bulunmaktadır.

- AGENTS.md "Examples" section: good/bad code comment, commit message, and command examples — upstream ilustrative references, not enforceable rules for Tulpar.
- AGENTS.md "Useful Resources" links: skills/, CONTRIBUTING.md, docs/, server docs, chat template docs — upstream reference links, not Tulpar operational rules.
- AGENTS.md "Minja" reference: llama.cpp uses a dedicated Jinja engine in `common/jinja`, not Minja — historical note, upstream content.
- AGENTS.md detailed "Permitted AI Usage" and "Prohibited AI Usage" lists: summarized in Upstream Contribution Guidelines section above.
- AGENTS.md commit message format examples (good/bad): upstream reference, see Upstream Contribution Guidelines for the rule.
- AGENTS.md code comment examples (good/bad): upstream reference, see Upstream Contribution Guidelines for the rule.
- AGENTS.md "Commands" examples (good/bad): upstream reference, see Upstream Contribution Guidelines for the rule.
- AGENTS.md "Private forks are exempt" note: upstream rule, preserved here for reference.
- AGENTS.md "ggml-gh-bot" exception note: upstream rule, preserved here for reference.

## 14. Current Phase

Current phase:
Phase-2A COMPLETE (2026-08-24). Artifacts: experiments/phase2a/
phase2a_report.md (verdict READY_FOR_PROFILING_DESIGN=YES,
NEEDS_HUMAN_APPROVAL=YES), evidence_ledger.md, code_audit.md,
hypothesis_matrix.md, open_questions.md; design at
experiments/phase2b/profiling_design.md.
Key audit fact: the model is hybrid - 48 GDN linear-attention layers +
16 dense full-attention layers + 1 MTP block; KV applies to dense blocks
only. Manifest binary path corrected: production = build-p3/bin/llama-server,
fallback = build/bin/llama-server.

Phase-2B profiling execution remains blocked until the operator answers
experiments/phase2a/open_questions.md Q1-Q6 (window approval, production
stop, traced 128k, profiler permissions, MTP ON arm, binary path confirm).

## 15. GEMV Numerical-Safety Rule (permanent)

All GEMV optimizations must be performance-only changes and must not alter
the numerical computation path.

If kernel correctness is preserved:
- logits remain identical
- MTP acceptance rate does not change
- MTP behavior remains intact

If the internal numerical path of a kernel is changed:
- even small differences may affect MTP acceptance

Therefore, every GEMV modification MUST pass all three of:
1. correctness gate
2. deterministic greedy comparison against baseline logits
3. MTP acceptance check

A GEMV change that alters numerical results must be explicitly flagged and
must NOT be merged unless all three checks pass.

## 16. Experiment Logging Standard (MANDATORY)

Every significant experiment MUST be recorded in
experiments/<phase>/EXPERIMENT_LOG.md using this exact format:

    ## EXP-<NNN>: <short title>

    PROBLEM
    <one paragraph: what was broken/slow>

    EVIDENCE
    <trace data, ms/tok, kernel counts, bandwidth>

    HYPOTHESIS
    <what change should fix it and why>

    CHANGE
    <what was actually modified: file, function, logic>

    RESULT
    <before/after metrics, VRAM, regression notes>

    WHY IT WORKED
    <root cause explanation>

    CAVEAT
    <what was NOT measured, known risks, follow-ups>

Rules:
- One page per experiment. No narrative, no process story.
- Entries are APPENDED, never deleted. If superseded, mark with
  SUPERSEDED BY EXP-<NNN>.
- Agent must append this log BEFORE declaring phase complete.
- All phase prompts must reference this standard.

## 17. Hardcoded Path Prohibition

No script, config, or source file may contain absolute user-specific
paths such as /home/gencer/llama.cpp.

Required patterns:
- Python: ROOT = Path(__file__).resolve().parents[N]
  where N is the directory depth from script to repo root.
- Shell:  ROOT="$(git rev-parse --show-toplevel)"
- Paths outside the repo (e.g., model directory) must come from
  environment variables or a config file, never hardcoded in logic.

Verification command (must return zero matches):
  grep -rn "/home/gencer/llama.cpp" --include="*.py" --include="*.sh" \
    --include="*.cu" --include="*.cuh" --include="*.cpp" --include="*.h" .

## 18. Fork-Only Policy (No Upstream PR)

This fork is for private, aggressive optimization only.
- NEVER create a pull request to ggml-org/llama.cpp.
- NEVER push to the upstream remote. Upstream is fetch-only.
- All commits and pushes target the fork remote exclusively.
- Upstream sync, if ever needed, is merge/rebase FROM upstream,
  never push TO upstream.
- This rule is permanent and overrides any future suggestion to
  submit changes upstream.
