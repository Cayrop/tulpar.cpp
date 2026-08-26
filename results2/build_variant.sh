#!/bin/bash
# Build FA-VEC tuning variants into isolated build dirs. Usage: build_variant.sh v1|v2|v3
set -e
SRC="$(git rev-parse --show-toplevel)"
FATTN=$SRC/ggml/src/ggml-cuda/fattn-vec.cuh
VAR=$1
cd $SRC

git diff --quiet -- $FATTN || { echo 'SOURCE DIRTY - aborting'; exit 1; }

case $VAR in
  v1)  # nthreads_KQ_q: 2 -> 4 on RDNA quantized-K path
    sed -i 's/    constexpr int nthreads_KQ_q = 2;/    constexpr int nthreads_KQ_q = 4;/' $FATTN
    BUILD=build-v1 ;;
  v2)  # block size 128 -> 256 (host + device)
    sed -i 's/static int ggml_cuda_fattn_vec_get_nthreads_host(const int cc) {\n    return 128;//' $FATTN
    TULPAR_SRC="$SRC" python3 - <<'EOF'
import os
import re
p=os.environ["TULPAR_SRC"]+"/ggml/src/ggml-cuda/fattn-vec.cuh"
s=open(p).read()
s=s.replace("static int ggml_cuda_fattn_vec_get_nthreads_host(const int cc) {\n    return 128;",
            "static int ggml_cuda_fattn_vec_get_nthreads_host(const int cc) {\n    return 256;")
s=s.replace("static constexpr __device__ int ggml_cuda_fattn_vec_get_nthreads_device() {\n    return 128;\n}",
            "static constexpr __device__ int ggml_cuda_fattn_vec_get_nthreads_device() {\n    return 256;\n}")
open(p,"w").write(s)
EOF
    BUILD=build-v2 ;;
  v3)  # both
    TULPAR_SRC="$SRC" python3 - <<'EOF'
import os
p=os.environ["TULPAR_SRC"]+"/ggml/src/ggml-cuda/fattn-vec.cuh"
s=open(p).read()
s=s.replace("    constexpr int nthreads_KQ_q = 2;","    constexpr int nthreads_KQ_q = 4;")
s=s.replace("static int ggml_cuda_fattn_vec_get_nthreads_host(const int cc) {\n    return 128;",
            "static int ggml_cuda_fattn_vec_get_nthreads_host(const int cc) {\n    return 256;")
s=s.replace("static constexpr __device__ int ggml_cuda_fattn_vec_get_nthreads_device() {\n    return 128;\n}",
            "static constexpr __device__ int ggml_cuda_fattn_vec_get_nthreads_device() {\n    return 256;\n}")
open(p,"w").write(s)
EOF
    BUILD=build-v3 ;;
  v5)  # allow TILE for quantized KV at decode (remove forced VEC for ne11<=2)
    TULPAR_SRC="$SRC" python3 - <<'PYEOF'
import os
p=os.environ["TULPAR_SRC"]+"/ggml/src/ggml-cuda/fattn.cu"
s=open(p).read()
old="""        } else {
            if (Q->ne[1] <= 2) {
                return BEST_FATTN_KERNEL_VEC;
            }
        }"""
new="""        } else {
            if (Q->ne[1] <= 2 && false) { // EXPERIMENT v5: allow tile+dequant path
                return BEST_FATTN_KERNEL_VEC;
            }
        }"""
assert old in s
s=s.replace(old,new)
open(p,"w").write(s)
PYEOF
    BUILD=build-v5 ;;
  *) echo "unknown variant"; exit 1 ;;
esac

echo "== variant $VAR -> $BUILD =="
cmake -S . -B $BUILD \
  -DCMAKE_BUILD_TYPE=Release \
  -DGGML_HIP=ON \
  -DGPU_TARGETS=gfx1101 \
  -DGGML_CUDA_FA_ALL_QUANTS=ON \
  -DGGML_HIP_GRAPHS=ON \
  -DLLAMA_BUILD_TESTS=OFF \
  -DGGML_CCACHE=ON > /tmp/opencode/cmake_$VAR.log 2>&1
cmake --build $BUILD --target llama-server -j 16 > /tmp/opencode/build_$VAR.log 2>&1
echo "== build done: $BUILD/bin/llama-server =="
ls -la $BUILD/bin/llama-server

# restore pristine source
git checkout -- $FATTN ggml/src/ggml-cuda/fattn.cu
git diff --stat ggml/src/ggml-cuda/fattn-vec.cuh | tail -1 || true
