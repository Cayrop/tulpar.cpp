# MMQ IQ3_XXS ISA Analysis (gfx1101, J=16, fallback=true)

## Compilation

Compiled with: `/opt/rocm/lib/llvm/bin/clang++ -O3 -DNDEBUG --offload-arch=gfx1101`
(see `build-p3/ggml/src/ggml-hip/CMakeFiles/ggml-hip.dir/flags.make`).

The full HIPCC command was extracted and run with `--save-temps` against
`ggml/src/ggml-cuda/template-instances/mmq-instance-iq3_xxs.cu`.

## Source file
`/tmp/mmq_isa/mmq-instance-iq3_xxs-hip-amdgcn-amd-amdhsa-gfx1101.s`

## Active kernel

Function: `_ZL9mul_mat_qIL9ggml_type18ELi16ELb1EEv...` (lines 52965-56730)

Kernel metadata (from .amdhsa_kernel directive):
```
.amdhsa_next_free_vgpr  214
.amdhsa_next_free_sgpr  36
.amdhsa_kernarg_size    172
.amdhsa_wavefront_size32 1
.num_vgpr               214
.num_agpr               0
```

## Hot loop

Inner loop: `.LBB37_15` (2063 lines of assembly, lines 230-2293 of the
extracted `j16fb1.s`). This is the K-iteration loop of
`mul_mat_q_process_tile`, which combines:

1. Load_tiles (dequant + LDS store)
2. Y tile load
3. Vec_dot (LDS load + WMMA + scale FMA)
4. Loop bookkeeping

## Instruction mix (entire `.LBB37_15` body)

| Category              | Count | % of loop |
|-----------------------|------:|----------:|
| global_load (vmem)    |    54 |    2.6%   |
| ds_load (LDS read)    |    68 |    3.3%   |
| ds_store (LDS write)  |    26 |    1.3%   |
| v_wmma_i32_16x16x16_iu8 (MMA) |  16 |    0.8% |
| v_dot4 / v_dot2       |     0 |    0.0%   |
| v_fma / v_fma_mix / v_fmac_f32 | 55 |    2.7% |
| v_mul_*               |    58 |    2.8%   |
| v_add_*               |    28 |    1.4%   |
| v_xor_*               |    48 |    2.3%   |
| v_or_b*               |    96 |    4.6%   |
| v_and_b*              |   212 |   10.3%   |
| v_lshrrev / v_lshlrev |   140 |    6.8%   |
| v_bfe_*               |    76 |    3.7%   |
| v_bcnt_*              |    16 |    0.8%   |
| v_cmp_*               |    64 |    3.1%   |
| v_cndmask             |    64 |    3.1%   |
| v_cvt_*               |    72 |    3.5%   |
| v_mov_b*              |    35 |    1.7%   |
| v_perm_b32            |    64 |    3.1%   |
| v_sub_nc_i16 / v_sub_*|    16 |    0.8%   |
| s_waitcnt             |    76 |    3.7%   |
| s_delay_alu           |   349 |   16.9%   |
| s_clause              |    10 |    0.5%   |
| s_cbranch             |     1 |    0.0%   |
| Other VALU/SALU       |  ~390 |   19.0%   |
| **Total instr.**      |   2063|   100%    |

`s_delay_alu` is a scheduling hint (waits for the previous VALU dep), not a
pipeline stall in the cycle-counting sense; it is included in the count
because each `s_delay_alu` consumes an issue slot.

## Pipeline stalls

`s_waitcnt` (76 total):
- 46 `vmcnt` waits (global memory load latency)
- 30 `lgkmcnt` waits (LDS latency)
- 0 `expcnt` waits

The 46 vmcnt waits correspond to the 54 global_loads (some issued without
wait; consumer of an issued load can be hidden under later work).

`s_delay_alu` (349) is heavily used because the dequant path has long
VALU dependency chains (sign-extract -> XOR -> mask -> subtract -> permute).

## Register usage

214 VGPR per wave (from kernel metadata). The peak number of VGPRs
allocated is 214, which determines occupancy.

## Scratch / spills

No `scratch_*` instructions in the .s file. The kernel does not spill to
scratch. All 214 VGPRs are hardware registers.

## Comparison with Q3_K MMQ (J=16, fallback=true)

Q3_K is a useful reference: same template, same MMA path, no lookup table
dequant. The hot loop `.LBB37_15` is 1634 lines.

| Category              | IQ3_XXS | Q3_K  | Delta |
|-----------------------|--------:|------:|------:|
| global_load           |      54 |    32 | +22   |
| ds_load               |      68 |   100 | -32   |
| ds_store              |      26 |    26 |  0    |
| v_wmma_i32_16x16x16   |      16 |    16 |  0    |
| v_fma / fma_mix / fmac|      55 |    96 | -41   |
| v_mul                 |      58 |   105 | -47   |
| v_cmp                 |      64 |     0 | +64   |
| v_lshrrev             |     140 |   100 | +40   |
| v_and_b*              |     212 |   102 | +110  |
| v_bfe                 |      76 |    12 | +64   |
| v_cndmask             |      64 |     0 | +64   |
| v_cvt                 |      72 |   138 | -66   |
| s_waitcnt (vmcnt)     |      46 |    19 | +27   |
| s_waitcnt (lgkmcnt)   |      30 |    40 | -10   |
| **VGPR/wave**         |     214 |   254 | -40   |
| **Hot loop lines**    |    2063 |  1634 | +429  |

Interpretation:
- **Q3_K has 0 v_cmp / 0 v_cndmask** because Q3_K's sign is stored in
  the high bit of each 4-bit code and is folded into the dequant with a
  simple XOR+subtract. No `v_bcnt`-based sign-extraction.
- **IQ3_XXS has 64 v_cmp + 64 v_cndmask + 16 v_bcnt** for the
  unpack_ksigns path, which extracts a 4-bit sign mask per byte.
- IQ3_XXS has 110 extra v_and and 64 extra v_bfe relative to Q3_K,
  primarily from the iq3xxs_grid lookup and sign handling.
- IQ3_XXS uses 40 fewer VGPR than Q3_K. This is because Q3_K's per-thread
  state (multiple 4-bit nibbles with bit-level dequant) requires more
  register pressure, while IQ3_XXS's dequant produces compact INT8 tiles.
- IQ3_XXS has +27 vmcnt waits: more global loads to feed the grid lookup
  (`global_load_d16_b16 v9, v[9:10]` for the d scale, plus 32-bit loads
  for the qs/signs words).

## Instruction mix summary

The hot loop of IQ3_XXS MMQ is **dominated by dequant bit-manipulation
(212 v_and, 140 v_lshrrev, 76 v_bfe, 64 v_cmp, 64 v_cndmask, 16 v_bcnt,
48 v_xor, 96 v_or)** = ~716 bit-level ops (35%).

The MMA path contributes only 16 v_wmma + 55 v_fma + 58 v_mul + 28 v_add
+ 72 v_cvt = ~229 ops (11%).

This means the **compute path is dominated by the dequantization/lookup,
not by the tensor-core MMA**. Each IQ3_XXS K-block (256 elements)
requires ~50 v_and + ~30 v_lshrrev + ~16 v_bfe + ~12 v_cmp/cndmask of
per-thread work for dequant, while the MMA path issues only 2 v_wmma
calls (per warp) that do 4096 INT8 MACs.

## Stalls / waves

Per-K-block (256 elements) per warp:
- ~2-3 vmcnt waits (waiting for d scale FP16 + qs/signs load)
- ~1-2 lgkmcnt waits (waiting for tile_y load)
- s_delay_alu chains through dequant: ~80 ops

This suggests the dequant is a 4-5 cycle VALU chain per iteration,
which fits within the typical VLIW issue rate (RDNA3 can dual-issue
VALU+VALU or VALU+LOAD).

## Conclusion

The MMQ IQ3_XXS kernel is **DEQUANT-bound**, not MMA-bound. The 16
v_wmma_i32_16x16x16_iu8 calls per hot loop iteration (4096 INT8 MACs
each = 65536 INT8 MACs/iter) are heavily underutilized relative to the
~2000 cycles of VALU dequant work that precede them. Hoisting or
simplifying the dequant would expose more WMMA throughput.
