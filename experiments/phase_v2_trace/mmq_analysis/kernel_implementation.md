# MMQ IQ3_XXS Kernel Implementation (RDNA3, gfx1101)

## Top-level

`mul_mat_q<type, J, fallback>` (mmq.cuh:946) is the kernel entry. It
allocates shared memory dynamically (`extern __shared__`), initializes
`ids_dst_shared` (mmq.cuh:973-984), and calls `mul_mat_q_process_tile`
(mmq.cuh:1049).

`mul_mat_q_process_tile<type, J, fallback, fixup>` (mmq.cuh:867) is the
real hot function. It runs `for (int kb0 = 0; kb0 < blocks_per_iter; ...)`
where `blocks_per_iter = MMQ_ITER_K / qk`. For IQ3_XXS, `qk=256`, so
`blocks_per_iter=1`.

Each iteration:
1. Calls `load_tiles(x, tile_x, ...)` to dequantize IQ3_XXS -> int8 tile in LDS.
2. Loads `tile_y` from quantized y (already Q8_1 from `quantize_mmq_q8_1_cuda`).
3. Calls `vec_dot(tile_x, tile_y, sum, k_offset)` to do dot product via MMA.
4. Repeats for the second half (k_offset = MMQ_TILE_NE_K = 32) of the y block.
5. After all blocks, calls `write_back` to store result.

## Load Tiles (Dequantization)

`ggml_cuda_mmq_load_tiles_iq3_xxs` (mmq-load-tiles.cuh:1287) is invoked with
`AMD_WMMA_AVAILABLE` defined, so the `use_mma_data_layout()` branch is taken.

Per block, the thread layout:
- `threads_per_row = (MMQ_ITER_K / (4*QR3_XXS)) / 2 = (256/16)/2 = 8`
- `nrows = warp_size / threads_per_row = 32/8 = 4`
- For `I=64`, `nwarps=4`: outer loop iterates `64 / (4*4) = 4` times
  (each iteration covers `nwarps*nrows = 16` rows).
- For each row, 4 QR3_XXS iterations.

In each iteration (mmq-load-tiles.cuh:1321-1347):
- `q3_packed` = 8 bytes of `qs` (2*kqsx, 2*kqsx+1).
- `aux32` = uint32 from `qs[QK_K/16 + kqsx]` (contains 7-bit packed signs +
  4-bit scale).
- For each `l in [0..QR3_XXS-1]`:
  - `grid_pos = (iq3xxs_grid[q3[2*l+0]], iq3xxs_grid[q3[2*l+1]])` - lookup
    into the 256-entry 32-bit grid table.
  - `signs = unpack_ksigns(aux32 >> (7*l))` - 7-bit packed sign.
  - `signs0 = __vcmpne4(signs & 0x08040201, 0)` (4-byte sign mask).
  - `grid_l = __vsub4(grid_pos.x ^ signs0, signs0)` - signed 4xINT8.
  - `signs1 = __vcmpne4(signs & 0x80402010, 0)`.
  - `grid_h = __vsub4(grid_pos.y ^ signs1, signs1)`.
  - Stored to `tile_x[i*sram_stride + 8*kqsx + (2*l+0..1)]`.
- Scale: `ls = aux32 >> 28; d = bxi->d; (ls*d + d/2)/2` -> float scale
  stored to `tile_df`.

The tile is laid out in LDS so that:
- `tile_x[i*sram_stride + j]` is the j-th 32-bit element of row i
  (i in [0..I-1], j in [0..sram_stride-1]).
- For the MMA path, the first `2*MMQ_TILE_NE_K = 64` 4-byte slots are the
  int8 quantized data; the remaining `sram_stride - 64 = 12` slots are
  float scales.

## Vec Dot (Dot Product via MMA)

`ggml_cuda_mmq_vec_dot_q8_0_q8_1_mma` (mmq-vec-dot.cuh:142) with
`AMD_WMMA_AVAILABLE` defined. For the IQ3_XXS template instantiation
`tile_A = tile<16, 8, int>`, `tile_B = tile<16, 8, int>`, `tile_C = tile<16, 16, int>`.

The function body (mmq-vec-dot.cuh:166-201):
```
for (int k01 = 0; k01 < MMQ_TILE_NE_K; k01 += QI8_0) {  // QI8_0 = 8
    for (int n = 0; n < ntx; ++ntx) {
        load_ldmatrix(A[n], x_qs + (i0 + n*tile_A::I)*sram_stride + k0, sram_stride);
    }
    for (int j0 = 0; j0 < J; j0 += ntx*tile_C::J) {
        tile_B B;
        load_ldmatrix(B, y_qs + j0*MMQ_TILE_Y_K + k01, MMQ_TILE_Y_K);
        float dB = y_df[j*MMQ_TILE_Y_K + k01/QI8_1];
        for (int n = 0; n < ntx; ++ntx) {
            tile_C C;
            mma(C, A[n], B);
            for (int l = 0; l < tile_C::ne; ++l) {
                int i = i0 + n*tile_A::I + tile_C::get_i(l);
                float dA = x_df[i*sram_stride + k0/QI8_0];
                sum[(j0/tile_C::J + n)*tile_C::ne + l] += C.x[l]*dA*dB;
            }
        }
    }
}
```

`mma(C, A, B)` where `C, A, B` are int32/int32/int32 tiles of shape
(16x16, 16x8, 16x8) calls `__builtin_amdgcn_wmma_i32_16x16x16_iu8_w32`
on RDNA3 (mma.cuh:1326-1331), twice (K dim is 16, but A has only 8 elements
in K direction, so two calls are needed to cover 16 K elements).

Each wmma call does `16*16*16 = 4096` INT8 MAC operations per warp.

## Write Back

`ggml_cuda_mmq_write_back_mma` (mmq.cuh:467) writes the sum register array
to dst in column-major order with `tile_C<16, 16, int, DATA_LAYOUT_J_MAJOR>`
layout.

## ISA summary (gfx1101, J=16, fallback=true)

The compiled kernel is `mmq-instance-iq3_xxs-hip-amdgcn-amd-amdhsa-gfx1101.s`,
function `_ZL9mul_mat_qIL9ggml_type18ELi16ELb1E`.

Kernel metadata:
```
.amdhsa_next_free_vgpr  214
.amdhsa_next_free_sgpr  36
.amdhsa_kernarg_size    172
.amdhsa_wavefront_size32 1
.num_vgpr               214
.num_agpr               0
```

The hot inner loop `.LBB37_15` is 2063 lines of assembly and contains
all per-iteration work: dequant + load_ldmatrix + WMMA. The unroll factor
is roughly 8 (the J dimension is 16 split across ntx=1 with rows_per_warp=16
and an unroll of 8).

## Inner loop structure (annotated)

Per outer K-block (256 K elements = 1 IQ3_XXS block), the inner work is:
1. **DeQuant (load_tiles)**: For each of 4 row-pairs (4*4=16 rows per warp
   * 4 warps = 64 rows), load the IQ3_XXS block, look up `iq3xxs_grid` for
   8 indices (2*QR3_XXS=8), extract 7-bit signs, XOR with 0xff/0x00 mask,
   store to LDS as 2x INT8 per entry. This generates heavy
   `v_lshrrev`/`v_and`/`v_bfe`/`v_bcnt`/`v_cndmask`/`v_sub` traffic.
2. **Y-load**: Copy 16 J rows of Q8_1 from global to LDS (already pre-quantized).
3. **MMA (vec_dot)**: 
   - 2x sub-iteration (k_offset 0 and 32)
   - In each: load A (16x8 int) and B (16x8 int) tiles from LDS via
     `load_ldmatrix` (8 bytes of LDS read = 2 dwords).
   - Issue `v_wmma_i32_16x16x16_iu8` (16x16x16 INT8 -> INT32).
   - 2 wmma calls per K-subiter (K=16 split into two K=8 chunks).
4. **FMA scaling**: `C.x[l]*dA*dB` post-scale (since WMMA only does int*int,
   scales are FP32 applied after the MMA).

## Critical Observations

- The vec_dot path is the MMA path. The mma call signature is
  `v_wmma_i32_16x16x16_iu8_w32` (RDNA3 INT8 WMMA), with `neg_lo:[1,1,0]`
  indicating the signs are baked into the loaded tile via sign-flip in
  load_tiles.
- The dequant logic produces a signed INT8 tile (signs applied via
  `__vsub4(xor, mask)`) which is exactly what the iu8 WMMA expects.
- The vec_dot loop is the same template as for Q2_K/Q4_0/Q8_0/etc.
  (mma path), so the MMA schedule is shared across types.
- Tile_x occupies ~19 KiB of LDS, the y tile is small.
