
cobjs/co_098.o:	file format elf64-amdgpu

Disassembly of section .text:

0000000000041400 <_ZL9mul_mat_qIL9ggml_type18ELi64ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_>:
	s_clause 0x3                                               // 000000041400: BF850003
	s_load_b64 s[6:7], s[0:1], 0x58                            // 000000041404: F4040180 F8000058
	s_load_b64 s[20:21], s[0:1], 0x10                          // 00000004140C: F4040500 F8000010
	s_load_b128 s[16:19], s[0:1], 0x48                         // 000000041414: F4080400 F8000048
	s_load_b256 s[8:15], s[0:1], 0x64                          // 00000004141C: F40C0200 F8000064
	v_bfe_u32 v1, v0, 10, 10                                   // 000000041424: D6100001 02291500
	v_and_b32_e32 v3, 0x3ff, v0                                // 00000004142C: 360600FF 000003FF
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000041434: BF870091
	v_lshl_add_u32 v2, v1, 5, v3                               // 000000041438: D6460002 040D0B01
	v_cmp_gt_u32_e32 vcc_lo, 64, v2                            // 000000041440: 7C9804C0
	s_and_saveexec_b32 s5, vcc_lo                              // 000000041444: BE85206A
	v_lshl_add_u32 v0, v2, 2, 0                                // 000000041448: D6460000 02010502
	ds_store_b32 v0, v2                                        // 000000041450: D8340000 00000200
	s_or_b32 exec_lo, exec_lo, s5                              // 000000041458: 8C7E057E
	s_load_b128 s[24:27], s[0:1], 0x94                         // 00000004145C: F4080600 F8000094
	s_waitcnt lgkmcnt(0)                                       // 000000041464: BF89FC07
	s_mul_hi_u32 s5, s8, s4                                    // 000000041468: 96850408
	s_lshl_b32 s27, s3, 6                                      // 00000004146C: 841B8603
	s_add_i32 s5, s4, s5                                       // 000000041470: 81050504
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000041474: BF870009
	s_lshr_b32 s28, s5, s9                                     // 000000041478: 851C0905
	s_barrier                                                  // 00000004147C: BFBD0000
	s_mul_i32 s5, s28, s10                                     // 000000041480: 96050A1C
	buffer_gl0_inv                                             // 000000041484: E0AC0000 00000000
	s_sub_i32 s4, s4, s5                                       // 00000004148C: 81840504
	s_cmp_eq_u64 s[20:21], 0                                   // 000000041490: BF108014
	s_cbranch_scc1 46                                          // 000000041494: BFA2002E <_ZL9mul_mat_qIL9ggml_type18ELi64ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x150>
	s_load_b64 s[8:9], s[0:1], 0x18                            // 000000041498: F4040200 F8000018
	s_ashr_i32 s5, s4, 31                                      // 0000000414A0: 86059F04
	s_mov_b32 s3, 0                                            // 0000000414A4: BE830080
	s_lshl_b64 s[12:13], s[4:5], 2                             // 0000000414A8: 848C8204
	s_mov_b32 s5, 0                                            // 0000000414AC: BE850080
	s_waitcnt lgkmcnt(0)                                       // 0000000414B0: BF89FC07
	s_add_u32 s8, s8, s12                                      // 0000000414B4: 80080C08
	s_addc_u32 s9, s9, s13                                     // 0000000414B8: 82090D09
	s_load_b64 s[8:9], s[8:9], null                            // 0000000414BC: F4040204 F8000000
	s_waitcnt lgkmcnt(0)                                       // 0000000414C4: BF89FC07
	s_sub_i32 s16, s9, s8                                      // 0000000414C8: 81900809
	s_mov_b32 s9, 0                                            // 0000000414CC: BE890080
	s_cmp_lt_i32 s27, s16                                      // 0000000414D0: BF04101B
	s_cbranch_scc0 43                                          // 0000000414D4: BFA1002B <_ZL9mul_mat_qIL9ggml_type18ELi64ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x184>
	s_and_saveexec_b32 s5, vcc_lo                              // 0000000414D8: BE85206A
	s_cbranch_execz 19                                         // 0000000414DC: BFA50013 <_ZL9mul_mat_qIL9ggml_type18ELi64ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x12c>
	v_or_b32_e32 v0, s27, v2                                   // 0000000414E0: 3800041B
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000414E4: BF870091
	v_add_nc_u32_e32 v4, s8, v0                                // 0000000414E8: 4A080008
	v_ashrrev_i32_e32 v5, 31, v4                               // 0000000414EC: 340A089F
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000414F0: BF870091
	v_lshlrev_b64 v[4:5], 2, v[4:5]                            // 0000000414F4: D73C0004 00020882
	v_add_co_u32 v4, vcc_lo, s20, v4                           // 0000000414FC: D7006A04 00020814
	s_delay_alu instid0(VALU_DEP_1)                            // 000000041504: BF870001
	v_add_co_ci_u32_e64 v5, null, s21, v5, vcc_lo              // 000000041508: D5207C05 01AA0A15
	global_load_b32 v0, v[4:5], off                            // 000000041510: DC520000 007C0004
	v_lshl_add_u32 v4, v2, 2, 0                                // 000000041518: D6460004 02010502
	s_waitcnt vmcnt(0)                                         // 000000041520: BF8903F7
	ds_store_b32 v4, v0                                        // 000000041524: D8340000 00000004
	s_or_b32 exec_lo, exec_lo, s5                              // 00000004152C: 8C7E057E
	s_waitcnt lgkmcnt(0)                                       // 000000041530: BF89FC07
	s_barrier                                                  // 000000041534: BFBD0000
	s_mov_b32 s5, s8                                           // 000000041538: BE850008
	buffer_gl0_inv                                             // 00000004153C: E0AC0000 00000000
	s_mov_b32 s12, 0                                           // 000000041544: BE8C0080
	s_cbranch_execz 11                                         // 000000041548: BFA5000B <_ZL9mul_mat_qIL9ggml_type18ELi64ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x178>
	s_branch 16                                                // 00000004154C: BFA00010 <_ZL9mul_mat_qIL9ggml_type18ELi64ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x190>
	s_mul_i32 s8, s28, s26                                     // 000000041550: 96081A1C
	s_mul_i32 s9, s19, s27                                     // 000000041554: 96091B13
	s_mul_i32 s3, s28, s25                                     // 000000041558: 9603191C
	s_mul_i32 s5, s4, s12                                      // 00000004155C: 96050C04
	s_mul_i32 s10, s4, s13                                     // 000000041560: 960A0D04
	s_add_i32 s8, s8, s9                                       // 000000041564: 81080908
	s_add_i32 s3, s5, s3                                       // 000000041568: 81030305
	s_add_i32 s12, s8, s10                                     // 00000004156C: 810C0A08
	s_mov_b32 s5, 0                                            // 000000041570: BE850080
	s_cbranch_execnz 6                                         // 000000041574: BFA60006 <_ZL9mul_mat_qIL9ggml_type18ELi64ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x190>
	s_nop 0                                                    // 000000041578: BF800000
	s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)                       // 00000004157C: BFB60003
	s_endpgm                                                   // 000000041580: BFB00000
	s_mov_b32 s12, 0                                           // 000000041584: BE8C0080
	s_and_b32 vcc_lo, exec_lo, s9                              // 000000041588: 8B6A097E
	s_cbranch_vccz 65530                                       // 00000004158C: BFA3FFFA <_ZL9mul_mat_qIL9ggml_type18ELi64ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x178>
	s_load_b32 s25, s[0:1], 0x40                               // 000000041590: F4000640 F8000040
	v_and_b32_e32 v13, 15, v3                                  // 000000041598: 361A068F
	v_lshrrev_b32_e32 v5, 4, v3                                // 00000004159C: 320A0684
	s_mov_b32 s10, 0                                           // 0000000415A0: BE8A0080
	s_waitcnt lgkmcnt(0)                                       // 0000000415A4: BF89FC07
	s_cmp_gt_i32 s25, 0                                        // 0000000415A8: BF028019
	s_cbranch_scc1 4                                           // 0000000415AC: BFA20004 <_ZL9mul_mat_qIL9ggml_type18ELi64ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x1c0>
	v_and_b32_e32 v4, 15, v3                                   // 0000000415B0: 3608068F
	v_lshl_add_u32 v0, v1, 4, v5                               // 0000000415B4: D6460000 04150901
	s_branch 1                                                 // 0000000415BC: BFA00001 <_ZL9mul_mat_qIL9ggml_type18ELi64ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x1c4>
	s_mov_b32 s10, -1                                          // 0000000415C0: BE8A00C1
	s_load_b64 s[8:9], s[0:1], 0x20                            // 0000000415C4: F4040200 F8000020
	v_dual_mov_b32 v14, 0 :: v_dual_mov_b32 v15, 0             // 0000000415CC: CA100080 0E0E0080
	v_dual_mov_b32 v16, 0 :: v_dual_mov_b32 v17, 0             // 0000000415D4: CA100080 10100080
	v_dual_mov_b32 v18, 0 :: v_dual_mov_b32 v19, 0             // 0000000415DC: CA100080 12120080
	v_dual_mov_b32 v20, 0 :: v_dual_mov_b32 v21, 0             // 0000000415E4: CA100080 14140080
	v_dual_mov_b32 v23, 0 :: v_dual_mov_b32 v24, 0             // 0000000415EC: CA100080 17180080
	v_dual_mov_b32 v25, 0 :: v_dual_mov_b32 v26, 0             // 0000000415F4: CA100080 191A0080
	v_dual_mov_b32 v27, 0 :: v_dual_mov_b32 v28, 0             // 0000000415FC: CA100080 1B1C0080
	v_dual_mov_b32 v29, 0 :: v_dual_mov_b32 v30, 0             // 000000041604: CA100080 1D1E0080
	v_dual_mov_b32 v31, 0 :: v_dual_mov_b32 v32, 0             // 00000004160C: CA100080 1F200080
	v_dual_mov_b32 v33, 0 :: v_dual_mov_b32 v34, 0             // 000000041614: CA100080 21220080
	v_dual_mov_b32 v35, 0 :: v_dual_mov_b32 v36, 0             // 00000004161C: CA100080 23240080
	v_dual_mov_b32 v37, 0 :: v_dual_mov_b32 v38, 0             // 000000041624: CA100080 25260080
	v_dual_mov_b32 v39, 0 :: v_dual_mov_b32 v40, 0             // 00000004162C: CA100080 27280080
	v_dual_mov_b32 v41, 0 :: v_dual_mov_b32 v42, 0             // 000000041634: CA100080 292A0080
	v_dual_mov_b32 v43, 0 :: v_dual_mov_b32 v44, 0             // 00000004163C: CA100080 2B2C0080
	v_dual_mov_b32 v45, 0 :: v_dual_mov_b32 v22, 0             // 000000041644: CA100080 2D160080
	s_and_not1_b32 vcc_lo, exec_lo, s10                        // 00000004164C: 916A0A7E
	s_lshl_b32 s13, s2, 7                                      // 000000041650: 840D8702
	s_cbranch_vccnz 3383                                       // 000000041654: BFA40D37 <_ZL9mul_mat_qIL9ggml_type18ELi64ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x3734>
	s_load_b128 s[20:23], s[0:1], null                         // 000000041658: F4080500 F8000000
	v_lshrrev_b32_e32 v0, 3, v3                                // 000000041660: 32000683
	s_add_i32 s0, s5, s27                                      // 000000041664: 81001B05
	v_dual_mov_b32 v22, 0 :: v_dual_and_b32 v3, 7, v3          // 000000041668: CA240080 16020687
	s_mul_i32 s0, s0, 36                                       // 000000041670: 9600A400
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 000000041674: BF870122
	v_lshl_add_u32 v0, v1, 2, v0                               // 000000041678: D6460000 04010501
	s_add_i32 s0, s0, s3                                       // 000000041680: 81000300
	v_dual_mov_b32 v43, 0 :: v_dual_lshlrev_b32 v6, 5, v3      // 000000041684: CA220080 2B060685
	s_ashr_i32 s1, s0, 31                                      // 00000004168C: 86019F00
	s_delay_alu instid0(VALU_DEP_2)                            // 000000041690: BF870002
	v_mul_lo_u32 v46, s17, v0                                  // 000000041694: D72C002E 00020011
	s_lshl_b64 s[0:1], s[0:1], 2                               // 00000004169C: 84808200
	v_mul_u32_u24_e32 v7, 0x130, v0                            // 0000000416A0: 160E00FF 00000130
	s_mul_hi_u32 s5, s4, s6                                    // 0000000416A8: 96850604
	s_mul_hi_u32 s6, s28, s14                                  // 0000000416AC: 96860E1C
	v_dual_mov_b32 v45, 0 :: v_dual_lshlrev_b32 v4, 2, v3      // 0000000416B0: CA220080 2D040682
	s_delay_alu instid0(VALU_DEP_2)                            // 0000000416B8: BF870002
	v_add3_u32 v6, 0, v7, v6                                   // 0000000416BC: D6550006 041A0E80
	v_mul_u32_u24_e32 v12, 0x1300, v1                          // 0000000416C4: 161802FF 00001300
	s_waitcnt lgkmcnt(0)                                       // 0000000416CC: BF89FC07
	s_add_u32 s3, s22, s0                                      // 0000000416D0: 80030016
	s_addc_u32 s1, s23, s1                                     // 0000000416D4: 82010117
	s_add_i32 s0, s4, s5                                       // 0000000416D8: 81000504
	s_lshl_b32 s4, s17, 5                                      // 0000000416DC: 84048511
	v_mul_u32_u24_e32 v14, 0x130, v13                          // 0000000416E0: 161C1AFF 00000130
	v_dual_mov_b32 v44, 0 :: v_dual_add_nc_u32 v47, s4, v46    // 0000000416E8: CA200080 2C2E5C04
	v_lshl_add_u32 v0, v1, 4, v5                               // 0000000416F0: D6460000 04150901
	s_add_i32 s28, s28, s6                                     // 0000000416F8: 811C061C
	v_dual_mov_b32 v35, 0 :: v_dual_lshlrev_b32 v2, 2, v2      // 0000000416FC: CA220080 23020482
	s_lshr_b32 s5, s28, s15                                    // 000000041704: 85050F1C
	v_dual_mov_b32 v42, 0 :: v_dual_lshlrev_b32 v3, 1, v3      // 000000041708: CA220080 2A020681
	v_dual_mov_b32 v41, 0 :: v_dual_add_nc_u32 v48, s4, v47    // 000000041710: CA200080 29305E04
	v_dual_mov_b32 v39, 0 :: v_dual_add_nc_u32 v8, 0, v4       // 000000041718: CA200080 27080880
	v_dual_mov_b32 v40, 0 :: v_dual_add_nc_u32 v9, 0x2600, v6  // 000000041720: CA200080 28080CFF 00002600
	v_dual_mov_b32 v37, 0 :: v_dual_add_nc_u32 v10, 0x4c00, v6 // 00000004172C: CA200080 250A0CFF 00004C00
	v_dual_mov_b32 v36, 0 :: v_dual_add_nc_u32 v11, 0x7200, v6 // 000000041738: CA200080 240A0CFF 00007200
	v_mad_u32_u24 v1, 0x90, v13, 0                             // 000000041744: D60B0001 02021AFF 00000090
	v_add3_u32 v5, v12, v14, 0                                 // 000000041750: D6550005 02021D0C
	v_mad_u32_u24 v12, 0x130, v0, 0                            // 000000041758: D60B000C 020200FF 00000130
	s_mul_i32 s2, s17, s13                                     // 000000041764: 96020D11
	s_mul_i32 s5, s5, s24                                      // 000000041768: 96051805
	s_lshr_b32 s0, s0, s7                                      // 00000004176C: 85000700
	s_add_i32 s15, s5, s2                                      // 000000041770: 810F0205
	v_add_co_u32 v51, s2, s3, v2                               // 000000041774: D7000233 00020403
	v_dual_mov_b32 v38, 0 :: v_dual_add_nc_u32 v49, s4, v48    // 00000004177C: CA200080 26306004
	v_dual_mov_b32 v33, 0 :: v_dual_add_nc_u32 v50, 0, v2      // 000000041784: CA200080 21320480
	v_add_co_ci_u32_e64 v52, null, s1, 0, s2                   // 00000004178C: D5207C34 00090001
	v_dual_mov_b32 v34, 0 :: v_dual_add_nc_u32 v53, 0x110, v1  // 000000041794: CA200080 223402FF 00000110
	v_dual_mov_b32 v31, 0 :: v_dual_add_nc_u32 v54, 0x2500, v5 // 0000000417A0: CA200080 1F360AFF 00002500
	v_dual_mov_b32 v32, 0 :: v_dual_add_nc_u32 v55, 0x100, v1  // 0000000417AC: CA200080 203602FF 00000100
	v_dual_mov_b32 v29, 0 :: v_dual_add_nc_u32 v56, 0x2600, v12// 0000000417B8: CA200080 1D3818FF 00002600
	v_dual_mov_b32 v30, 0 :: v_dual_add_nc_u32 v57, 0x2580, v5 // 0000000417C4: CA200080 1E380AFF 00002580
	v_dual_mov_b32 v27, 0 :: v_dual_add_nc_u32 v58, 0x2610, v12// 0000000417D0: CA200080 1B3A18FF 00002610
	v_dual_mov_b32 v28, 0 :: v_dual_lshlrev_b32 v59, 1, v4     // 0000000417DC: CA220080 1C3A0881
	v_dual_mov_b32 v25, 0 :: v_dual_lshlrev_b32 v60, 1, v3     // 0000000417E4: CA220080 193C0681
	v_dual_mov_b32 v26, 0 :: v_dual_add_nc_u32 v61, 0x2500, v6 // 0000000417EC: CA200080 1A3C0CFF 00002500
	v_dual_mov_b32 v23, 0 :: v_dual_add_nc_u32 v62, 0x2508, v6 // 0000000417F8: CA200080 173E0CFF 00002508
	v_dual_mov_b32 v24, 0 :: v_dual_add_nc_u32 v63, 0x2510, v6 // 000000041804: CA200080 183E0CFF 00002510
	v_dual_mov_b32 v21, 0 :: v_dual_add_nc_u32 v64, 0x2518, v6 // 000000041810: CA200080 15400CFF 00002518
	v_dual_mov_b32 v20, 0 :: v_dual_add_nc_u32 v65, v8, v7     // 00000004181C: CA200080 14400F08
	v_dual_mov_b32 v19, 0 :: v_dual_add_nc_u32 v66, 0x2500, v9 // 000000041824: CA200080 134212FF 00002500
	v_dual_mov_b32 v18, 0 :: v_dual_add_nc_u32 v67, 0x2508, v9 // 000000041830: CA200080 124212FF 00002508
	v_dual_mov_b32 v17, 0 :: v_dual_add_nc_u32 v68, 0x2510, v9 // 00000004183C: CA200080 114412FF 00002510
	v_dual_mov_b32 v16, 0 :: v_dual_add_nc_u32 v69, 0x2518, v9 // 000000041848: CA200080 104412FF 00002518
	v_dual_mov_b32 v15, 0 :: v_dual_add_nc_u32 v70, 0x2500, v10// 000000041854: CA200080 0F4614FF 00002500
	v_dual_mov_b32 v14, 0 :: v_dual_add_nc_u32 v71, 0x2508, v10// 000000041860: CA200080 0E4614FF 00002508
	v_add_nc_u32_e32 v72, 0x2510, v10                          // 00000004186C: 4A9014FF 00002510
	v_add_nc_u32_e32 v73, 0x2518, v10                          // 000000041874: 4A9214FF 00002518
	v_add_nc_u32_e32 v74, 0x2500, v11                          // 00000004187C: 4A9416FF 00002500
	v_add_nc_u32_e32 v75, 0x2508, v11                          // 000000041884: 4A9616FF 00002508
	v_add_nc_u32_e32 v76, 0x2510, v11                          // 00000004188C: 4A9816FF 00002510
	v_add_nc_u32_e32 v77, 0x2518, v11                          // 000000041894: 4A9A16FF 00002518
	s_mul_i32 s6, s0, s11                                      // 00000004189C: 96060B00
	s_mov_b32 s0, 0                                            // 0000000418A0: BE800080
	s_mul_i32 s14, s18, 0x48                                   // 0000000418A4: 960EFF12 00000048
	s_add_i32 s15, s15, s6                                     // 0000000418AC: 810F060F
	s_mov_b32 s1, s0                                           // 0000000418B0: BE810000
	s_mov_b32 s2, s0                                           // 0000000418B4: BE820000
	s_mov_b32 s3, s0                                           // 0000000418B8: BE830000
	s_mov_b32 s4, s0                                           // 0000000418BC: BE840000
	s_mov_b32 s5, s0                                           // 0000000418C0: BE850000
	s_mov_b32 s6, s0                                           // 0000000418C4: BE860000
	s_mov_b32 s7, s0                                           // 0000000418C8: BE870000
	s_mov_b32 s17, s0                                          // 0000000418CC: BE910000
	s_delay_alu instid0(SALU_CYCLE_1)                          // 0000000418D0: BF870009
	s_add_i32 s10, s15, s17                                    // 0000000418D4: 810A110F
	v_mov_b16_e32 v78.l, 0                                     // 0000000418D8: 7E9C3880
	s_mul_i32 s11, s10, 0x62                                   // 0000000418DC: 960BFF0A 00000062
	s_mul_hi_i32 s22, s10, 0x62                                // 0000000418E4: 9716FF0A 00000062
	s_add_u32 s10, s20, s11                                    // 0000000418EC: 800A0B14
	s_addc_u32 s11, s21, s22                                   // 0000000418F0: 820B1615
	v_mov_b16_e32 v95.h, v78.l                                 // 0000000418F4: 7FBE394E
	v_mad_i64_i32 v[3:4], null, 0x62, v46, s[10:11]            // 0000000418F8: D6FF7C03 002A5CFF 00000062
	v_mad_i64_i32 v[1:2], null, 0x62, v47, s[10:11]            // 000000041904: D6FF7C01 002A5EFF 00000062
	v_mad_i64_i32 v[11:12], null, 0x62, v48, s[10:11]          // 000000041910: D6FF7C0B 002A60FF 00000062
	v_mov_b16_e32 v94.h, v78.l                                 // 00000004191C: 7FBC394E
	v_mov_b16_e32 v93.h, v78.l                                 // 000000041920: 7FBA394E
	v_add_co_u32 v5, vcc_lo, v3, v59                           // 000000041924: D7006A05 00027703
	s_delay_alu instid0(VALU_DEP_1)                            // 00000004192C: BF870001
	v_add_co_ci_u32_e64 v6, null, 0, v4, vcc_lo                // 000000041930: D5207C06 01AA0880
	global_load_d16_b16 v80, v[3:4], off                       // 000000041938: DC820000 507C0003
	v_mov_b16_e32 v92.h, v78.l                                 // 000000041940: 7FB8394E
	v_mov_b16_e32 v91.h, v78.l                                 // 000000041944: 7FB6394E
	global_load_b64 v[9:10], v[5:6], off offset:2              // 000000041948: DC560002 097C0005
	v_add_co_u32 v3, vcc_lo, v3, v60                           // 000000041950: D7006A03 00027903
	s_delay_alu instid0(VALU_DEP_1)                            // 000000041958: BF870001
	v_add_co_ci_u32_e64 v4, null, 0, v4, vcc_lo                // 00000004195C: D5207C04 01AA0880
	v_mov_b16_e32 v90.h, v78.l                                 // 000000041964: 7FB4394E
	v_mov_b16_e32 v89.h, v78.l                                 // 000000041968: 7FB2394E
	v_mov_b16_e32 v88.h, v78.l                                 // 00000004196C: 7FB0394E
	global_load_b32 v81, v[3:4], off offset:66                 // 000000041970: DC520042 517C0003
	v_add_co_u32 v3, vcc_lo, v1, v59                           // 000000041978: D7006A03 00027701
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 000000041980: BF8700A1
	v_add_co_ci_u32_e64 v4, null, 0, v2, vcc_lo                // 000000041984: D5207C04 01AA0480
	v_add_co_u32 v5, vcc_lo, v1, v60                           // 00000004198C: D7006A05 00027901
	v_add_co_ci_u32_e64 v6, null, 0, v2, vcc_lo                // 000000041994: D5207C06 01AA0480
	s_clause 0x1                                               // 00000004199C: BF850001
	global_load_b64 v[7:8], v[3:4], off offset:2               // 0000000419A0: DC560002 077C0003
	global_load_b32 v79, v[5:6], off offset:66                 // 0000000419A8: DC520042 4F7C0005
	v_add_co_u32 v3, vcc_lo, v11, v59                          // 0000000419B0: D7006A03 0002770B
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 0000000419B8: BF8700A1
	v_add_co_ci_u32_e64 v4, null, 0, v12, vcc_lo               // 0000000419BC: D5207C04 01AA1880
	v_add_co_u32 v99, vcc_lo, v11, v60                         // 0000000419C4: D7006A63 0002790B
	v_add_co_ci_u32_e64 v100, null, 0, v12, vcc_lo             // 0000000419CC: D5207C64 01AA1880
	global_load_b64 v[5:6], v[3:4], off offset:2               // 0000000419D4: DC560002 057C0003
	v_mad_i64_i32 v[3:4], null, 0x62, v49, s[10:11]            // 0000000419DC: D6FF7C03 002A62FF 00000062
	s_clause 0x1                                               // 0000000419E8: BF850001
	global_load_d16_b16 v11, v[11:12], off                     // 0000000419EC: DC820000 0B7C000B
	global_load_d16_b16 v96, v[1:2], off                       // 0000000419F4: DC820000 607C0001
	s_getpc_b64 s[10:11]                                       // 0000000419FC: BE8A4700
	s_add_u32 s10, s10, 0xfffe5000                             // 000000041A00: 800AFF0A FFFE5000
	s_addc_u32 s11, s11, lit(0xffffffff)                       // 000000041A08: 820BFF0B FFFFFFFF
	v_mov_b16_e32 v87.h, v78.l                                 // 000000041A10: 7FAE394E
	v_mov_b16_e32 v85.h, v78.l                                 // 000000041A14: 7FAA394E
	v_mov_b16_e32 v83.h, v78.l                                 // 000000041A18: 7FA6394E
	v_mov_b16_e32 v82.h, v78.l                                 // 000000041A1C: 7FA4394E
	v_add_co_u32 v101, vcc_lo, v3, v59                         // 000000041A20: D7006A65 00027703
	s_delay_alu instid0(VALU_DEP_1)                            // 000000041A28: BF870001
	v_add_co_ci_u32_e64 v102, null, 0, v4, vcc_lo              // 000000041A2C: D5207C66 01AA0880
	s_clause 0x1                                               // 000000041A34: BF850001
	global_load_b32 v12, v[99:100], off offset:66              // 000000041A38: DC520042 0C7C0063
	global_load_b64 v[1:2], v[101:102], off offset:2           // 000000041A40: DC560002 017C0065
	v_mov_b16_e32 v86.h, v78.l                                 // 000000041A48: 7FAC394E
	v_mov_b16_e32 v84.h, v78.l                                 // 000000041A4C: 7FA8394E
	v_mov_b16_e32 v98.h, v78.l                                 // 000000041A50: 7FC4394E
	s_waitcnt vmcnt(9)                                         // 000000041A54: BF8927F7
	v_cvt_f32_f16_e32 v97, v80.l                               // 000000041A58: 7EC21750
	s_waitcnt vmcnt(8)                                         // 000000041A5C: BF8923F7
	v_and_b32_e32 v104, 0xff, v10                              // 000000041A60: 36D014FF 000000FF
	v_lshrrev_b32_e32 v100, 6, v9                              // 000000041A68: 32C81286
	s_delay_alu instid0(VALU_DEP_3)                            // 000000041A6C: BF870003
	v_mul_f32_e32 v97, 0.5, v97                                // 000000041A70: 10C2C2F0
	v_lshrrev_b32_e32 v102, 14, v9                             // 000000041A74: 32CC128E
	v_lshrrev_b32_e32 v105, 6, v10                             // 000000041A78: 32D21486
	v_lshrrev_b32_e32 v107, 14, v10                            // 000000041A7C: 32D6148E
	v_lshrrev_b32_e32 v10, 22, v10                             // 000000041A80: 32141496
	v_and_b32_e32 v100, 0x3fc, v100                            // 000000041A84: 36C8C8FF 000003FC
	s_waitcnt vmcnt(7)                                         // 000000041A8C: BF891FF7
	v_and_b32_e32 v101, 0xff, v81                              // 000000041A90: 36CAA2FF 000000FF
	v_bfe_u32 v103, v81, 7, 8                                  // 000000041A98: D6100067 02210F51
	v_bfe_u32 v106, v81, 14, 8                                 // 000000041AA0: D610006A 02211D51
	v_bfe_u32 v108, v81, 21, 8                                 // 000000041AA8: D610006C 02212B51
	v_lshrrev_b32_e32 v81, 28, v81                             // 000000041AB0: 32A2A29C
	v_and_b32_e32 v102, 0x3fc, v102                            // 000000041AB4: 36CCCCFF 000003FC
	v_lshlrev_b32_e32 v104, 2, v104                            // 000000041ABC: 30D0D082
	v_and_b32_e32 v10, 0x3fc, v10                              // 000000041AC0: 361414FF 000003FC
	v_and_b32_e32 v105, 0x3fc, v105                            // 000000041AC8: 36D2D2FF 000003FC
	v_cvt_f32_ubyte0_e32 v128, v81                             // 000000041AD0: 7F002351
	s_waitcnt vmcnt(6)                                         // 000000041AD4: BF891BF7
	v_and_b32_e32 v109, 0xff, v7                               // 000000041AD8: 36DA0EFF 000000FF
	v_lshrrev_b32_e32 v110, 6, v7                              // 000000041AE0: 32DC0E86
	v_lshrrev_b32_e32 v112, 14, v7                             // 000000041AE4: 32E00E8E
	v_lshrrev_b32_e32 v7, 22, v7                               // 000000041AE8: 320E0E96
	v_fma_mix_f32 v80, v128, v80, v97 op_sel_hi:[0,1,0]        // 000000041AEC: CC200050 1586A180
	v_and_b32_e32 v99, 0xff, v9                                // 000000041AF4: 36C612FF 000000FF
	v_lshrrev_b32_e32 v9, 22, v9                               // 000000041AFC: 32121296
	v_and_b32_e32 v114, 0xff, v8                               // 000000041B00: 36E410FF 000000FF
	v_lshrrev_b32_e32 v115, 6, v8                              // 000000041B08: 32E61086
	v_lshrrev_b32_e32 v117, 14, v8                             // 000000041B0C: 32EA108E
	v_lshrrev_b32_e32 v8, 22, v8                               // 000000041B10: 32101096
	s_waitcnt vmcnt(4)                                         // 000000041B14: BF8913F7
	v_and_b32_e32 v119, 0xff, v5                               // 000000041B18: 36EE0AFF 000000FF
	v_lshrrev_b32_e32 v120, 6, v5                              // 000000041B20: 32F00A86
	v_lshrrev_b32_e32 v121, 14, v5                             // 000000041B24: 32F20A8E
	v_lshrrev_b32_e32 v5, 22, v5                               // 000000041B28: 320A0A96
	v_and_b32_e32 v122, 0xff, v6                               // 000000041B2C: 36F40CFF 000000FF
	v_dual_mul_f32 v80, 0.5, v80 :: v_dual_lshlrev_b32 v99, 2, v99// 000000041B34: C8E2A0F0 5062C682
	v_and_b32_e32 v9, 0x3fc, v9                                // 000000041B3C: 361212FF 000003FC
	v_and_b32_e32 v7, 0x3fc, v7                                // 000000041B44: 360E0EFF 000003FC
	v_and_b32_e32 v8, 0x3fc, v8                                // 000000041B4C: 361010FF 000003FC
	v_and_b32_e32 v107, 0x3fc, v107                            // 000000041B54: 36D6D6FF 000003FC
	v_lshlrev_b32_e32 v109, 2, v109                            // 000000041B5C: 30DADA82
	v_and_b32_e32 v110, 0x3fc, v110                            // 000000041B60: 36DCDCFF 000003FC
	v_and_b32_e32 v112, 0x3fc, v112                            // 000000041B68: 36E0E0FF 000003FC
	v_lshlrev_b32_e32 v114, 2, v114                            // 000000041B70: 30E4E482
	v_and_b32_e32 v115, 0x3fc, v115                            // 000000041B74: 36E6E6FF 000003FC
	v_and_b32_e32 v117, 0x3fc, v117                            // 000000041B7C: 36EAEAFF 000003FC
	v_lshlrev_b32_e32 v119, 2, v119                            // 000000041B84: 30EEEE82
	v_and_b32_e32 v120, 0x3fc, v120                            // 000000041B88: 36F0F0FF 000003FC
	v_and_b32_e32 v121, 0x3fc, v121                            // 000000041B90: 36F2F2FF 000003FC
	v_and_b32_e32 v133, 0x3fc, v5                              // 000000041B98: 370A0AFF 000003FC
	v_lshlrev_b32_e32 v122, 2, v122                            // 000000041BA0: 30F4F482
	s_clause 0x14                                              // 000000041BA4: BF850014
	global_load_b32 v150, v99, s[10:11]                        // 000000041BA8: DC520000 960A0063
	global_load_b32 v151, v100, s[10:11]                       // 000000041BB0: DC520000 970A0064
	global_load_b32 v152, v102, s[10:11]                       // 000000041BB8: DC520000 980A0066
	global_load_b32 v153, v9, s[10:11]                         // 000000041BC0: DC520000 990A0009
	global_load_b32 v154, v104, s[10:11]                       // 000000041BC8: DC520000 9A0A0068
	global_load_b32 v155, v105, s[10:11]                       // 000000041BD0: DC520000 9B0A0069
	global_load_b32 v156, v107, s[10:11]                       // 000000041BD8: DC520000 9C0A006B
	global_load_b32 v157, v10, s[10:11]                        // 000000041BE0: DC520000 9D0A000A
	global_load_b32 v158, v109, s[10:11]                       // 000000041BE8: DC520000 9E0A006D
	global_load_b32 v159, v110, s[10:11]                       // 000000041BF0: DC520000 9F0A006E
	global_load_b32 v160, v112, s[10:11]                       // 000000041BF8: DC520000 A00A0070
	global_load_b32 v161, v7, s[10:11]                         // 000000041C00: DC520000 A10A0007
	global_load_b32 v162, v114, s[10:11]                       // 000000041C08: DC520000 A20A0072
	global_load_b32 v163, v115, s[10:11]                       // 000000041C10: DC520000 A30A0073
	global_load_b32 v99, v117, s[10:11]                        // 000000041C18: DC520000 630A0075
	global_load_b32 v5, v8, s[10:11]                           // 000000041C20: DC520000 050A0008
	global_load_b32 v97, v119, s[10:11]                        // 000000041C28: DC520000 610A0077
	global_load_b32 v10, v120, s[10:11]                        // 000000041C30: DC520000 0A0A0078
	global_load_b32 v9, v121, s[10:11]                         // 000000041C38: DC520000 090A0079
	global_load_b32 v8, v133, s[10:11]                         // 000000041C40: DC520000 080A0085
	global_load_b32 v7, v122, s[10:11]                         // 000000041C48: DC520000 070A007A
	v_and_b32_e32 v111, 0xff, v79                              // 000000041C50: 36DE9EFF 000000FF
	v_lshrrev_b32_e32 v123, 6, v6                              // 000000041C58: 32F60C86
	v_bcnt_u32_b32 v124, v101, 0                               // 000000041C5C: D71E007C 00010165
	v_bfe_u32 v113, v79, 7, 8                                  // 000000041C64: D6100071 02210F4F
	v_bfe_u32 v118, v79, 21, 8                                 // 000000041C6C: D6100076 02212B4F
	v_bcnt_u32_b32 v125, v103, 0                               // 000000041C74: D71E007D 00010167
	v_bcnt_u32_b32 v126, v106, 0                               // 000000041C7C: D71E007E 0001016A
	v_bcnt_u32_b32 v127, v108, 0                               // 000000041C84: D71E007F 0001016C
	v_bcnt_u32_b32 v129, v111, 0                               // 000000041C8C: D71E0081 0001016F
	v_and_b32_e32 v81, 0x3fc, v123                             // 000000041C94: 36A2F6FF 000003FC
	v_and_b32_e32 v123, 1, v124                                // 000000041C9C: 36F6F881
	v_bcnt_u32_b32 v130, v113, 0                               // 000000041CA0: D71E0082 00010171
	v_bcnt_u32_b32 v132, v118, 0                               // 000000041CA8: D71E0084 00010176
	v_and_b32_e32 v124, 1, v125                                // 000000041CB0: 36F8FA81
	v_and_b32_e32 v125, 1, v126                                // 000000041CB4: 36FAFC81
	v_and_b32_e32 v126, 1, v127                                // 000000041CB8: 36FCFE81
	v_and_b32_e32 v127, 1, v129                                // 000000041CBC: 36FF0281
	v_lshlrev_b32_e32 v100, 7, v123                            // 000000041CC0: 30C8F687
	v_bfe_u32 v116, v79, 14, 8                                 // 000000041CC4: D6100074 02211D4F
	v_and_b32_e32 v128, 1, v130                                // 000000041CCC: 37010481
	v_and_b32_e32 v130, 1, v132                                // 000000041CD0: 37050881
	v_lshlrev_b32_e32 v102, 7, v124                            // 000000041CD4: 30CCF887
	v_lshlrev_b32_e32 v104, 7, v125                            // 000000041CD8: 30D0FA87
	v_lshlrev_b32_e32 v105, 7, v126                            // 000000041CDC: 30D2FC87
	v_lshlrev_b32_e32 v107, 7, v127                            // 000000041CE0: 30D6FE87
	v_xor_b32_e32 v100, v100, v101                             // 000000041CE4: 3AC8CB64
	v_bcnt_u32_b32 v131, v116, 0                               // 000000041CE8: D71E0083 00010174
	v_lshlrev_b32_e32 v112, 7, v130                            // 000000041CF0: 30E10487
	v_lshlrev_b32_e32 v109, 7, v128                            // 000000041CF4: 30DB0087
	v_xor_b32_e32 v101, v102, v103                             // 000000041CF8: 3ACACF66
	v_xor_b32_e32 v102, v104, v106                             // 000000041CFC: 3ACCD568
	v_xor_b32_e32 v103, v105, v108                             // 000000041D00: 3ACED969
	v_xor_b32_e32 v104, v107, v111                             // 000000041D04: 3AD0DF6B
	v_mul_lo_u32 v108, 0x1010101, v100                         // 000000041D08: D72C006C 0002C8FF 01010101
	v_and_b32_e32 v129, 1, v131                                // 000000041D14: 37030681
	v_xor_b32_e32 v107, v112, v118                             // 000000041D18: 3AD6ED70
	v_xor_b32_e32 v105, v109, v113                             // 000000041D1C: 3AD2E36D
	v_mul_lo_u32 v101, 0x1010101, v101                         // 000000041D20: D72C0065 0002CAFF 01010101
	v_mul_lo_u32 v102, 0x1010101, v102                         // 000000041D2C: D72C0066 0002CCFF 01010101
	v_mul_lo_u32 v103, 0x1010101, v103                         // 000000041D38: D72C0067 0002CEFF 01010101
	v_mul_lo_u32 v104, 0x1010101, v104                         // 000000041D44: D72C0068 0002D0FF 01010101
	v_lshlrev_b32_e32 v110, 7, v129                            // 000000041D50: 30DD0287
	v_mul_lo_u32 v100, 0x1010101, v107                         // 000000041D54: D72C0064 0002D6FF 01010101
	v_and_b32_e32 v107, 0x8040201, v108                        // 000000041D60: 36D6D8FF 08040201
	v_mul_lo_u32 v105, 0x1010101, v105                         // 000000041D68: D72C0069 0002D2FF 01010101
	v_lshrrev_b32_e32 v109, 18, v108                           // 000000041D74: 32DAD892
	v_xor_b32_e32 v106, v110, v116                             // 000000041D78: 3AD4E96E
	v_bfe_i32 v110, v108, 0, 1                                 // 000000041D7C: D611006E 0205016C
	v_lshrrev_b32_e32 v113, 18, v101                           // 000000041D84: 32E2CA92
	v_bfe_i32 v114, v101, 0, 1                                 // 000000041D88: D6110072 02050165
	v_and_b32_e32 v116, 0x8040201, v102                        // 000000041D90: 36E8CCFF 08040201
	v_lshrrev_b32_e32 v117, 18, v102                           // 000000041D98: 32EACC92
	v_bfe_i32 v118, v102, 0, 1                                 // 000000041D9C: D6110076 02050166
	v_and_b32_e32 v119, 0x80402010, v102                       // 000000041DA4: 36EECCFF 80402010
	v_lshrrev_b32_e32 v102, 22, v102                           // 000000041DAC: 32CCCC96
	v_and_b32_e32 v121, 0x80402010, v103                       // 000000041DB0: 36F2CEFF 80402010
	v_and_b32_e32 v122, 0x8040201, v104                        // 000000041DB8: 36F4D0FF 08040201
	v_and_b32_e32 v123, 0x80402010, v104                       // 000000041DC0: 36F6D0FF 80402010
	v_lshrrev_b32_e32 v131, 18, v104                           // 000000041DC8: 3306D092
	v_bfe_i32 v132, v104, 0, 1                                 // 000000041DCC: D6110084 02050168
	v_lshrrev_b32_e32 v104, 22, v104                           // 000000041DD4: 32D0D096
	v_lshrrev_b32_e32 v139, 24, v107                           // 000000041DD8: 3316D698
	v_and_b32_e32 v111, 0x80402010, v108                       // 000000041DDC: 36DED8FF 80402010
	v_and_b32_e32 v124, 0x8040201, v105                        // 000000041DE4: 36F8D2FF 08040201
	v_and_b32_e32 v125, 0x80402010, v105                       // 000000041DEC: 36FAD2FF 80402010
	v_bfe_i32 v130, v103, 0, 1                                 // 000000041DF4: D6110082 02050167
	v_lshrrev_b32_e32 v133, 18, v105                           // 000000041DFC: 330AD292
	v_bfe_i32 v134, v105, 0, 1                                 // 000000041E00: D6110086 02050169
	v_lshrrev_b32_e32 v105, 22, v105                           // 000000041E08: 32D2D296
	s_waitcnt vmcnt(24)                                        // 000000041E0C: BF8963F7
	v_lshrrev_b16 v11.h, 8, v107.l op_sel:[0,0,1]              // 000000041E10: D739400B 0002D688
	v_bfe_i32 v107, v109, 0, 1                                 // 000000041E18: D611006B 0205016D
	v_mov_b16_e32 v82.l, v110.l                                // 000000041E20: 7EA4396E
	v_lshrrev_b16 v85.l, 8, v121.l                             // 000000041E24: D7390055 0002F288
	v_bfe_i32 v110, v113, 0, 1                                 // 000000041E2C: D611006E 02050171
	v_lshrrev_b32_e32 v142, 24, v121                           // 000000041E34: 331CF298
	v_mov_b16_e32 v88.l, v114.l                                // 000000041E38: 7EB03972
	v_mov_b16_e32 v95.l, v118.l                                // 000000041E3C: 7EBE3976
	v_bfe_i32 v114, v102, 0, 1                                 // 000000041E40: D6110072 02050166
	v_lshrrev_b16 v118.l, 4, v121.l                            // 000000041E48: D7390076 0002F284
	v_bfe_i32 v121, v104, 0, 1                                 // 000000041E50: D6110079 02050168
	v_cmp_ne_u16_e64 vcc_lo, 0, v139.l                         // 000000041E58: D43D006A 00031680
	v_mul_lo_u32 v106, 0x1010101, v106                         // 000000041E60: D72C006A 0002D4FF 01010101
	v_and_b32_e32 v112, 0x8040201, v101                        // 000000041E6C: 36E0CAFF 08040201
	v_lshrrev_b32_e32 v129, 18, v103                           // 000000041E74: 3302CE92
	v_lshrrev_b32_e32 v137, 18, v100                           // 000000041E78: 3312C892
	v_lshrrev_b16 v83.l, 8, v111.l                             // 000000041E7C: D7390053 0002DE88
	v_lshrrev_b16 v89.l, 8, v123.l                             // 000000041E84: D7390059 0002F688
	v_lshrrev_b32_e32 v143, 24, v123                           // 000000041E8C: 331EF698
	v_mov_b16_e64 v98.l, v130.l                                // 000000041E90: D59C0062 00000182
	v_lshrrev_b16 v123.l, 4, v123.l                            // 000000041E98: D739007B 0002F684
	v_bfe_i32 v130, v105, 0, 1                                 // 000000041EA0: D6110082 02050169
	v_mov_b16_e32 v105.l, v107.l                               // 000000041EA8: 7ED2396B
	v_mov_b16_e32 v107.l, v110.l                               // 000000041EAC: 7ED6396E
	v_mov_b16_e32 v110.l, v114.l                               // 000000041EB0: 7EDC3972
	v_mov_b16_e32 v114.l, v121.l                               // 000000041EB4: 7EE43979
	v_cndmask_b32_e64 v121, 0, -1, vcc_lo                      // 000000041EB8: D5010079 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v11.h                          // 000000041EC0: 7C7B1680
	v_and_b32_e32 v115, 0x80402010, v101                       // 000000041EC4: 36E6CAFF 80402010
	v_and_b32_e32 v127, 0x80402010, v106                       // 000000041ECC: 36FED4FF 80402010
	v_bfe_i32 v138, v100, 0, 1                                 // 000000041ED4: D611008A 02050164
	v_lshrrev_b16 v86.l, 8, v112.l                             // 000000041EDC: D7390056 0002E088
	v_lshrrev_b16 v92.l, 8, v125.l                             // 000000041EE4: D739005C 0002FA88
	v_lshrrev_b32_e32 v145, 24, v125                           // 000000041EEC: 3322FA98
	v_lshrrev_b32_e32 v146, 24, v116                           // 000000041EF0: 3324E898
	v_lshrrev_b16 v94.l, 8, v116.l                             // 000000041EF4: D739005E 0002E888
	v_bfe_i32 v116, v129, 0, 1                                 // 000000041EFC: D6110074 02050181
	v_bfe_i32 v129, v133, 0, 1                                 // 000000041F04: D6110081 02050185
	v_lshrrev_b16 v125.l, 4, v125.l                            // 000000041F0C: D739007D 0002FA84
	v_bfe_i32 v133, v137, 0, 1                                 // 000000041F14: D6110085 02050189
	v_bfe_i32 v137, v123, 0, 1                                 // 000000041F1C: D6110089 0205017B
	v_cndmask_b32_e64 v123, 0, -1, vcc_lo                      // 000000041F24: D501007B 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v83.l                          // 000000041F2C: 7C7AA680
	v_lshrrev_b16 v91.l, 8, v115.l                             // 000000041F30: D739005B 0002E688
	s_waitcnt vmcnt(23)                                        // 000000041F38: BF895FF7
	v_lshrrev_b16 v96.h, 8, v127.l op_sel:[0,0,1]              // 000000041F3C: D7394060 0002FE88
	v_lshrrev_b32_e32 v147, 24, v127                           // 000000041F44: 3326FE98
	v_lshrrev_b16 v127.l, 4, v127.l                            // 000000041F48: D739007F 0002FE84
	v_mov_b16_e64 v104.l, v138.l                               // 000000041F50: D59C0068 0000018A
	v_bfe_i32 v138, v125, 0, 1                                 // 000000041F58: D611008A 0205017D
	v_cndmask_b32_e64 v125, 0, -1, vcc_lo                      // 000000041F60: D501007D 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v86.l                          // 000000041F68: 7C7AAC80
	v_lshrrev_b32_e32 v135, 18, v106                           // 000000041F6C: 330ED492
	v_lshrrev_b32_e32 v140, 24, v111                           // 000000041F70: 3318DE98
	v_lshrrev_b16 v109.l, 4, v111.l                            // 000000041F74: D739006D 0002DE84
	v_lshrrev_b32_e32 v144, 24, v115                           // 000000041F7C: 3320E698
	v_lshrrev_b16 v111.l, 4, v115.l                            // 000000041F80: D739006F 0002E684
	v_lshrrev_b16 v115.l, 4, v119.l                            // 000000041F88: D7390073 0002EE84
	v_bfe_i32 v164, v127, 0, 1                                 // 000000041F90: D61100A4 0205017F
	v_cndmask_b32_e64 v127, 0, -1, vcc_lo                      // 000000041F98: D501007F 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v91.l                          // 000000041FA0: 7C7AB680
	v_lshrrev_b32_e32 v108, 22, v108                           // 000000041FA4: 32D8D896
	v_lshrrev_b32_e32 v101, 22, v101                           // 000000041FA8: 32CACA96
	v_and_b32_e32 v120, 0x8040201, v103                        // 000000041FAC: 36F0CEFF 08040201
	v_lshrrev_b32_e32 v103, 22, v103                           // 000000041FB4: 32CECE96
	v_lshrrev_b16 v78.h, 8, v119.l op_sel:[0,0,1]              // 000000041FB8: D739404E 0002EE88
	v_lshrrev_b32_e32 v141, 24, v112                           // 000000041FC0: 331AE098
	v_lshrrev_b32_e32 v149, 24, v119                           // 000000041FC4: 332AEE98
	v_bfe_i32 v119, v131, 0, 1                                 // 000000041FC8: D6110077 02050183
	v_bfe_i32 v131, v135, 0, 1                                 // 000000041FD0: D6110083 02050187
	v_bfe_i32 v135, v115, 0, 1                                 // 000000041FD8: D6110087 02050173
	v_mov_b16_e64 v115.l, v129.l                               // 000000041FE0: D59C0073 00000181
	v_cndmask_b32_e64 v129, 0, -1, vcc_lo                      // 000000041FE8: D5010081 01A98280
	v_cmp_ne_u16_e64 vcc_lo, 0, v140.l                         // 000000041FF0: D43D006A 00031880
	v_and_b32_e32 v126, 0x8040201, v106                        // 000000041FF8: 36FCD4FF 08040201
	v_bfe_i32 v136, v106, 0, 1                                 // 000000042000: D6110088 0205016A
	v_lshrrev_b32_e32 v106, 22, v106                           // 000000042008: 32D4D496
	v_bfe_i32 v108, v108, 0, 1                                 // 00000004200C: D611006C 0205016C
	v_bfe_i32 v112, v101, 0, 1                                 // 000000042014: D6110070 02050165
	v_bfe_i32 v113, v117, 0, 1                                 // 00000004201C: D6110071 02050175
	v_bfe_i32 v117, v103, 0, 1                                 // 000000042024: D6110075 02050167
	v_mov_b16_e64 v102.l, v134.l                               // 00000004202C: D59C0066 00000186
	v_bfe_i32 v134, v111, 0, 1                                 // 000000042034: D6110086 0205016F
	v_mov_b16_e32 v111.l, v116.l                               // 00000004203C: 7EDE3974
	v_mov_b16_e64 v116.l, v130.l                               // 000000042040: D59C0074 00000182
	v_cndmask_b32_e64 v130, 0, -1, vcc_lo                      // 000000042048: D5010082 01A98280
	v_cmp_ne_u16_e64 vcc_lo, 0, v141.l                         // 000000042050: D43D006A 00031A80
	v_mov_b16_e64 v101.l, v132.l                               // 000000042058: D59C0065 00000184
	v_bfe_i32 v132, v106, 0, 1                                 // 000000042060: D6110084 0205016A
	v_mov_b16_e32 v106.l, v108.l                               // 000000042068: 7ED4396C
	v_mov_b16_e32 v108.l, v112.l                               // 00000004206C: 7ED83970
	v_mov_b16_e32 v112.l, v117.l                               // 000000042070: 7EE03975
	v_mov_b16_e64 v117.l, v131.l                               // 000000042074: D59C0075 00000183
	v_cndmask_b32_e64 v131, 0, -1, vcc_lo                      // 00000004207C: D5010083 01A98280
	v_cmp_ne_u16_e64 vcc_lo, 0, v144.l                         // 000000042084: D43D006A 00032080
	v_and_b32_e32 v128, 0x8040201, v100                        // 00000004208C: 3700C8FF 08040201
	v_mov_b16_e64 v103.l, v136.l                               // 000000042094: D59C0067 00000188
	v_bfe_i32 v136, v118, 0, 1                                 // 00000004209C: D6110088 02050176
	v_mov_b16_e64 v118.l, v132.l                               // 0000000420A4: D59C0076 00000184
	v_cndmask_b32_e64 v132, 0, -1, vcc_lo                      // 0000000420AC: D5010084 01A98280
	v_cmp_ne_u16_e64 vcc_lo, 0, v146.l                         // 0000000420B4: D43D006A 00032480
	v_lshrrev_b32_e32 v148, 24, v128                           // 0000000420BC: 33290098
	v_lshrrev_b16 v101.h, 8, v128.l op_sel:[0,0,1]             // 0000000420C0: D7394065 00030088
	v_bfe_i32 v128, v109, 0, 1                                 // 0000000420C8: D6110080 0205016D
	v_mov_b16_e32 v109.l, v113.l                               // 0000000420D0: 7EDA3971
	v_mov_b16_e32 v113.l, v119.l                               // 0000000420D4: 7EE23977
	v_mov_b16_e64 v119.l, v133.l                               // 0000000420D8: D59C0077 00000185
	v_cndmask_b32_e64 v133, 0, -1, vcc_lo                      // 0000000420E0: D5010085 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v94.l                          // 0000000420E8: 7C7ABC80
	v_lshrrev_b16 v84.l, 8, v120.l                             // 0000000420EC: D7390054 0002F088
	v_lshrrev_b32_e32 v120, 24, v120                           // 0000000420F4: 32F0F098
	v_lshrrev_b16 v87.l, 8, v122.l                             // 0000000420F8: D7390057 0002F488
	v_lshrrev_b32_e32 v122, 24, v122                           // 000000042100: 32F4F498
	v_cndmask_b32_e64 v139, 0, -1, vcc_lo                      // 000000042104: D501008B 01A98280
	v_cmp_ne_u16_e64 vcc_lo, 0, v149.l                         // 00000004210C: D43D006A 00032A80
	v_lshrrev_b16 v90.l, 8, v124.l                             // 000000042114: D739005A 0002F888
	v_lshrrev_b32_e32 v124, 24, v124                           // 00000004211C: 32F8F898
	v_lshrrev_b16 v93.l, 8, v126.l                             // 000000042120: D739005D 0002FC88
	v_lshrrev_b32_e32 v126, 24, v126                           // 000000042128: 32FCFC98
	v_cndmask_b32_e64 v140, 0, -1, vcc_lo                      // 00000004212C: D501008C 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v78.h                          // 000000042134: 7C7B9C80
	v_and_b16 v102.h, 0xff, v82.l op_sel:[0,0,1]               // 000000042138: D7624066 0002A4FF 000000FF
	v_and_b16 v78.h, 0xff, v105.l op_sel:[0,0,1]               // 000000042144: D762404E 0002D2FF 000000FF
	v_mov_b16_e32 v91.l, v125.l                                // 000000042150: 7EB6397D
	v_and_b16 v104.h, 0xff, v95.l op_sel:[0,0,1]               // 000000042154: D7624068 0002BEFF 000000FF
	v_cndmask_b32_e64 v141, 0, -1, vcc_lo                      // 000000042160: D501008D 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v120.l                         // 000000042168: 7C7AF080
	v_lshlrev_b16 v109.h, 8, v95.l op_sel:[0,0,1]              // 00000004216C: D738406D 0002BE88
	v_lshlrev_b16 v121.h, 8, v91.l op_sel:[0,0,1]              // 000000042174: D7384079 0002B688
	v_and_b16 v103.h, 0xff, v88.l op_sel:[0,0,1]               // 00000004217C: D7624067 0002B0FF 000000FF
	v_and_b16 v105.h, 0xff, v98.l op_sel:[0,0,1]               // 000000042188: D7624069 0002C4FF 000000FF
	v_cndmask_b32_e64 v144, 0, -1, vcc_lo                      // 000000042194: D5010090 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v84.l                          // 00000004219C: 7C7AA880
	v_mov_b16_e64 v84.l, v128.l                                // 0000000421A0: D59C0054 00000180
	v_lshlrev_b16 v110.h, 8, v98.l op_sel:[0,0,1]              // 0000000421A8: D738406E 0002C488
	v_mov_b16_e64 v98.l, v134.l                                // 0000000421B0: D59C0062 00000186
	v_and_b16 v83.l, 0xff, v107.l                              // 0000000421B8: D7620053 0002D6FF 000000FF
	v_cndmask_b32_e64 v146, 0, -1, vcc_lo                      // 0000000421C4: D5010092 01A98280
	v_cmp_ne_u16_e64 vcc_lo, 0, v142.l                         // 0000000421CC: D43D006A 00031C80
	v_mov_b16_e64 v125.l, v132.l                               // 0000000421D4: D59C007D 00000184
	v_mov_b16_e64 v132.l, v144.l                               // 0000000421DC: D59C0084 00000190
	v_mov_b16_e64 v144.l, v164.l                               // 0000000421E4: D59C0090 000001A4
	v_and_b16 v86.l, 0xff, v109.l                              // 0000000421EC: D7620056 0002DAFF 000000FF
	v_cndmask_b32_e64 v142, 0, -1, vcc_lo                      // 0000000421F8: D501008E 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v85.l                          // 000000042200: 7C7AAA80
	v_and_b16 v85.l, 0xff, v108.l                              // 000000042204: D7620055 0002D8FF 000000FF
	v_mov_b16_e64 v120.l, v135.l                               // 000000042210: D59C0078 00000187
	v_and_b16 v111.h, 0xff, v112.l op_sel:[0,0,1]              // 000000042218: D762406F 0002E0FF 000000FF
	v_mov_b16_e64 v134.l, v142.l                               // 000000042224: D59C0086 0000018E
	v_cndmask_b32_e64 v149, 0, -1, vcc_lo                      // 00000004222C: D5010095 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v122.l                         // 000000042234: 7C7AF480
	v_mov_b16_e64 v122.l, v129.l                               // 000000042238: D59C007A 00000181
	v_mov_b16_e64 v129.l, v146.l                               // 000000042240: D59C0081 00000192
	v_and_b16 v106.h, 0xff, v101.l op_sel:[0,0,1]              // 000000042248: D762406A 0002CAFF 000000FF
	v_and_b16 v112.h, 0xff, v113.l op_sel:[0,0,1]              // 000000042254: D7624070 0002E2FF 000000FF
	v_cndmask_b32_e64 v165, 0, -1, vcc_lo                      // 000000042260: D50100A5 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v87.l                          // 000000042268: 7C7AAE80
	v_and_b16 v87.l, 0xff, v110.l                              // 00000004226C: D7620057 0002DCFF 000000FF
	v_mov_b16_e64 v128.l, v137.l                               // 000000042278: D59C0080 00000189
	v_and_b16 v113.h, 0xff, v114.l op_sel:[0,0,1]              // 000000042280: D7624071 0002E4FF 000000FF
	v_mov_b16_e64 v137.l, v138.l                               // 00000004228C: D59C0089 0000018A
	v_cndmask_b32_e64 v166, 0, -1, vcc_lo                      // 000000042294: D50100A6 01A98280
	v_cmp_ne_u16_e64 vcc_lo, 0, v143.l                         // 00000004229C: D43D006A 00031E80
	v_and_b16 v107.h, 0xff, v102.l op_sel:[0,0,1]              // 0000000422A4: D762406B 0002CCFF 000000FF
	v_and_b16 v114.h, 0xff, v115.l op_sel:[0,0,1]              // 0000000422B0: D7624072 0002E6FF 000000FF
	v_and_b16 v115.h, 0xff, v116.l op_sel:[0,0,1]              // 0000000422BC: D7624073 0002E8FF 000000FF
	v_and_b16 v108.h, 0xff, v103.l op_sel:[0,0,1]              // 0000000422C8: D762406C 0002CEFF 000000FF
	v_cndmask_b32_e64 v143, 0, -1, vcc_lo                      // 0000000422D4: D501008F 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v89.l                          // 0000000422DC: 7C7AB280
	v_mov_b16_e32 v89.l, v121.l                                // 0000000422E0: 7EB23979
	v_mov_b16_e64 v121.l, v136.l                               // 0000000422E4: D59C0079 00000188
	v_mov_b16_e64 v136.l, v165.l                               // 0000000422EC: D59C0088 000001A5
	v_and_b16 v116.h, 0xff, v117.l op_sel:[0,0,1]              // 0000000422F4: D7624074 0002EAFF 000000FF
	v_cndmask_b32_e64 v167, 0, -1, vcc_lo                      // 000000042300: D50100A7 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v124.l                         // 000000042308: 7C7AF880
	v_lshlrev_b16 v119.h, 8, v89.l op_sel:[0,0,1]              // 00000004230C: D7384077 0002B288
	v_and_b16 v89.l, 0xff, v84.l                               // 000000042314: D7620059 0002A8FF 000000FF
	v_mov_b16_e64 v124.l, v139.l                               // 000000042320: D59C007C 0000018B
	v_mov_b16_e64 v135.l, v167.l                               // 000000042328: D59C0087 000001A7
	v_cndmask_b32_e64 v168, 0, -1, vcc_lo                      // 000000042330: D50100A8 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v90.l                          // 000000042338: 7C7AB480
	v_mov_b16_e32 v90.l, v123.l                                // 00000004233C: 7EB4397B
	v_mov_b16_e64 v123.l, v131.l                               // 000000042340: D59C007B 00000183
	v_or_b16 v78.h, v78.h, v119.h op_sel:[1,1,1]               // 000000042348: D763584E 0002EF4E
	v_or_b16 v94.l, v89.l, v121.h op_sel:[0,1,0]               // 000000042350: D763105E 0002F359
	v_cndmask_b32_e64 v169, 0, -1, vcc_lo                      // 000000042358: D50100A9 01A98280
	v_cmp_ne_u16_e64 vcc_lo, 0, v145.l                         // 000000042360: D43D006A 00032280
	v_lshlrev_b16 v120.h, 8, v90.l op_sel:[0,0,1]              // 000000042368: D7384078 0002B488
	v_mov_b16_e64 v131.l, v149.l                               // 000000042370: D59C0083 00000195
	v_mov_b16_e64 v139.l, v143.l                               // 000000042378: D59C008B 0000018F
	v_mov_b16_e64 v138.l, v169.l                               // 000000042380: D59C008A 000001A9
	v_cndmask_b32_e64 v145, 0, -1, vcc_lo                      // 000000042388: D5010091 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v92.l                          // 000000042390: 7C7AB880
	v_mov_b16_e32 v92.l, v127.l                                // 000000042394: 7EB8397F
	v_or_b16 v95.l, v102.h, v120.h op_sel:[1,1,0]              // 000000042398: D763185F 0002F166
	v_mov_b16_e64 v127.l, v133.l                               // 0000000423A0: D59C007F 00000185
	v_mov_b16_e64 v133.l, v166.l                               // 0000000423A8: D59C0085 000001A6
	v_cndmask_b32_e64 v170, 0, -1, vcc_lo                      // 0000000423B0: D50100AA 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v126.l                         // 0000000423B8: 7C7AFC80
	v_lshlrev_b16 v122.h, 8, v92.l op_sel:[0,0,1]              // 0000000423BC: D738407A 0002B888
	v_or_b32_e32 v164, v95, v78                                // 0000000423C4: 39489D5F
	v_lshlrev_b16 v95.l, 8, v123.l                             // 0000000423C8: D738005F 0002F688
	v_lshlrev_b16 v95.h, 8, v122.l op_sel:[0,0,1]              // 0000000423D0: D738405F 0002F488
	v_cndmask_b32_e64 v171, 0, -1, vcc_lo                      // 0000000423D8: D50100AB 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v93.l                          // 0000000423E0: 7C7ABA80
	v_mov_b16_e64 v93.l, v130.l                                // 0000000423E4: D59C005D 00000182
	v_mov_b16_e64 v126.l, v141.l                               // 0000000423EC: D59C007E 0000018D
	v_mov_b16_e64 v130.l, v140.l                               // 0000000423F4: D59C0082 0000018C
	v_mov_b16_e64 v141.l, v168.l                               // 0000000423FC: D59C008D 000001A8
	v_cndmask_b32_e64 v172, 0, -1, vcc_lo                      // 000000042404: D50100AC 01A98280
	v_cmp_ne_u16_e64 vcc_lo, 0, v147.l                         // 00000004240C: D43D006A 00032680
	v_lshlrev_b16 v102.h, 8, v93.l op_sel:[0,0,1]              // 000000042414: D7384066 0002BA88
	v_or_b16 v93.l, v103.h, v122.h op_sel:[1,1,0]              // 00000004241C: D763185D 0002F567
	v_lshlrev_b16 v103.h, 8, v124.l op_sel:[0,0,1]             // 000000042424: D7384067 0002F888
	v_mov_b16_e64 v140.l, v170.l                               // 00000004242C: D59C008C 000001AA
	v_cndmask_b32_e64 v147, 0, -1, vcc_lo                      // 000000042434: D5010093 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v96.h                          // 00000004243C: 7C7BC080
	v_lshlrev_b16 v96.h, 8, v82.l op_sel:[0,0,1]               // 000000042440: D7384060 0002A488
	v_and_b16 v82.l, 0xff, v106.l                              // 000000042448: D7620052 0002D4FF 000000FF
	v_or_b16 v91.l, v104.h, v103.h op_sel:[1,1,0]              // 000000042454: D763185B 0002CF68
	v_lshlrev_b16 v104.h, 8, v133.l op_sel:[0,0,1]             // 00000004245C: D7384068 00030A88
	v_cndmask_b32_e64 v173, 0, -1, vcc_lo                      // 000000042464: D50100AD 01A98280
	v_cmp_ne_u16_e64 vcc_lo, 0, v148.l                         // 00000004246C: D43D006A 00032880
	v_or_b16 v78.h, v82.l, v102.h op_sel:[0,1,1]               // 000000042474: D763504E 0002CD52
	v_and_b16 v82.l, 0xff, v98.l                               // 00000004247C: D7620052 0002C4FF 000000FF
	v_mov_b16_e64 v142.l, v145.l                               // 000000042488: D59C008E 00000191
	v_mov_b16_e64 v143.l, v172.l                               // 000000042490: D59C008F 000001AC
	v_cndmask_b32_e64 v148, 0, -1, vcc_lo                      // 000000042498: D5010094 01A98280
	v_or_b32_e32 v123, v94, v78                                // 0000000424A0: 38F69D5E
	v_or_b16 v78.h, v83.l, v95.l op_sel:[0,0,1]                // 0000000424A4: D763404E 0002BF53
	v_lshlrev_b16 v94.l, 8, v125.l                             // 0000000424AC: D738005E 0002FA88
	v_or_b16 v92.l, v82.l, v95.h op_sel:[0,1,0]                // 0000000424B4: D763105C 0002BF52
	v_and_b16 v82.l, 0xff, v120.l                              // 0000000424BC: D7620052 0002F0FF 000000FF
	v_cmp_ne_u16_e32 vcc_lo, 0, v101.h                         // 0000000424C8: 7C7BCA80
	v_or_b32_e32 v124, v93, v78                                // 0000000424CC: 38F89D5D
	v_or_b16 v78.h, v85.l, v94.l op_sel:[0,0,1]                // 0000000424D0: D763404E 0002BD55
	v_lshlrev_b16 v93.l, 8, v127.l                             // 0000000424D8: D738005D 0002FE88
	v_lshlrev_b16 v93.h, 8, v126.l op_sel:[0,0,1]              // 0000000424E0: D738405D 0002FC88
	v_lshlrev_b16 v101.h, 8, v88.l op_sel:[0,0,1]              // 0000000424E8: D7384065 0002B088
	v_and_b16 v88.l, 0xff, v111.l                              // 0000000424F0: D7620058 0002DEFF 000000FF
	v_or_b32_e32 v125, v92, v78                                // 0000000424FC: 38FA9D5C
	v_or_b16 v78.h, v86.l, v93.l op_sel:[0,0,1]                // 000000042500: D763404E 0002BB56
	v_lshlrev_b16 v92.l, 8, v130.l                             // 000000042508: D738005C 00030488
	v_lshlrev_b16 v92.h, 8, v129.l op_sel:[0,0,1]              // 000000042510: D738405C 00030288
	v_or_b16 v90.l, v82.l, v93.h op_sel:[0,1,0]                // 000000042518: D763105A 0002BB52
	v_and_b16 v83.l, 0xff, v121.l                              // 000000042520: D7620053 0002F2FF 000000FF
	v_or_b32_e32 v126, v91, v78                                // 00000004252C: 38FC9D5B
	v_or_b16 v78.h, v87.l, v92.l op_sel:[0,0,1]                // 000000042530: D763404E 0002B957
	v_lshlrev_b16 v91.l, 8, v132.l                             // 000000042538: D738005B 00030888
	v_lshlrev_b16 v91.h, 8, v131.l op_sel:[0,0,1]              // 000000042540: D738405B 00030688
	v_or_b16 v89.l, v105.h, v92.h op_sel:[1,1,0]               // 000000042548: D7631859 0002B969
	v_and_b16 v82.l, 0xff, v128.l                              // 000000042550: D7620052 000300FF 000000FF
	v_or_b32_e32 v127, v90, v78                                // 00000004255C: 38FE9D5A
	v_or_b16 v78.h, v88.l, v91.l op_sel:[0,0,1]                // 000000042560: D763404E 0002B758
	v_lshlrev_b16 v90.l, 8, v134.l                             // 000000042568: D738005A 00030C88
	v_or_b16 v88.l, v83.l, v91.h op_sel:[0,1,0]                // 000000042570: D7631058 0002B753
	v_lshlrev_b16 v90.h, 8, v135.l op_sel:[0,0,1]              // 000000042578: D738405A 00030E88
	v_lshlrev_b16 v105.h, 8, v139.l op_sel:[0,0,1]             // 000000042580: D7384069 00031688
	v_or_b32_e32 v129, v89, v78                                // 000000042588: 39029D59
	v_or_b16 v78.h, v111.h, v90.l op_sel:[1,0,1]               // 00000004258C: D763484E 0002B56F
	v_lshlrev_b16 v89.l, 8, v136.l                             // 000000042594: D7380059 00031088
	v_or_b16 v87.l, v106.h, v104.h op_sel:[1,1,0]              // 00000004259C: D7631857 0002D16A
	v_lshlrev_b16 v89.h, 8, v138.l op_sel:[0,0,1]              // 0000000425A4: D7384059 00031488
	v_or_b16 v85.l, v82.l, v90.h op_sel:[0,1,0]                // 0000000425AC: D7631055 0002B552
	v_or_b32_e32 v130, v88, v78                                // 0000000425B4: 39049D58
	v_or_b16 v78.h, v112.h, v89.l op_sel:[1,0,1]               // 0000000425B8: D763484E 0002B370
	v_lshlrev_b16 v88.h, 8, v141.l op_sel:[0,0,1]              // 0000000425C0: D7384058 00031A88
	v_mov_b16_e64 v145.l, v171.l                               // 0000000425C8: D59C0091 000001AB
	v_and_b16 v86.l, 0xff, v137.l                              // 0000000425D0: D7620056 000312FF 000000FF
	v_lshlrev_b16 v88.l, 8, v140.l                             // 0000000425DC: D7380058 00031888
	v_or_b32_e32 v131, v87, v78                                // 0000000425E4: 39069D57
	v_or_b16 v78.h, v113.h, v105.h op_sel:[1,1,1]              // 0000000425E8: D763584E 0002D371
	v_lshlrev_b16 v87.l, 8, v142.l                             // 0000000425F0: D7380057 00031C88
	v_or_b16 v83.l, v107.h, v89.h op_sel:[1,1,0]               // 0000000425F8: D7631853 0002B36B
	v_mov_b16_e64 v146.l, v173.l                               // 000000042600: D59C0092 000001AD
	v_lshlrev_b16 v87.h, 8, v143.l op_sel:[0,0,1]              // 000000042608: D7384057 00031E88
	v_or_b32_e32 v132, v85, v78                                // 000000042610: 39089D55
	v_or_b16 v78.h, v114.h, v88.h op_sel:[1,1,1]               // 000000042614: D763584E 0002B172
	v_lshlrev_b16 v106.h, 8, v145.l op_sel:[0,0,1]             // 00000004261C: D738406A 00032288
	v_or_b16 v82.l, v86.l, v88.l                               // 000000042624: D7630052 0002B156
	v_cndmask_b32_e64 v174, 0, -1, vcc_lo                      // 00000004262C: D50100AE 01A98280
	v_and_b16 v117.h, 0xff, v118.l op_sel:[0,0,1]              // 000000042634: D7624075 0002ECFF 000000FF
	v_or_b32_e32 v133, v83, v78                                // 000000042640: 390A9D53
	v_or_b16 v78.h, v115.h, v87.l op_sel:[1,0,1]               // 000000042644: D763484E 0002AF73
	v_and_b16 v85.l, 0xff, v144.l                              // 00000004264C: D7620055 000320FF 000000FF
	v_lshlrev_b16 v85.h, 8, v146.l op_sel:[0,0,1]              // 000000042658: D7384055 00032488
	v_lshlrev_b16 v107.h, 8, v147.l op_sel:[0,0,1]             // 000000042660: D738406B 00032688
	v_or_b16 v86.l, v108.h, v87.h op_sel:[1,1,0]               // 000000042668: D7631856 0002AF6C
	v_or_b32_e32 v134, v82, v78                                // 000000042670: 390C9D52
	v_or_b16 v78.h, v116.h, v106.h op_sel:[1,1,1]              // 000000042674: D763584E 0002D574
	v_mov_b16_e64 v149.l, v174.l                               // 00000004267C: D59C0095 000001AE
	v_lshlrev_b16 v111.h, 8, v84.l op_sel:[0,0,1]              // 000000042684: D738406F 0002A888
	v_or_b16 v84.l, v85.l, v85.h op_sel:[0,1,0]                // 00000004268C: D7631054 0002AB55
	v_and_b16 v11.h, 0xff, v104.l op_sel:[0,0,1]               // 000000042694: D762400B 0002D0FF 000000FF
	v_or_b32_e32 v135, v86, v78                                // 0000000426A0: 390E9D56
	v_or_b16 v78.h, v117.h, v107.h op_sel:[1,1,1]              // 0000000426A4: D763584E 0002D775
	v_lshlrev_b16 v94.h, 8, v117.l op_sel:[0,0,1]              // 0000000426AC: D738405E 0002EA88
	v_lshlrev_b16 v83.h, 8, v149.l op_sel:[0,0,1]              // 0000000426B4: D7384053 00032A88
	s_waitcnt vmcnt(20)                                        // 0000000426BC: BF8953F7
	v_xor_b32_e32 v117, v150, v164                             // 0000000426C0: 3AEB4996
	s_waitcnt vmcnt(19)                                        // 0000000426C4: BF894FF7
	v_xor_b32_e32 v123, v151, v123                             // 0000000426C8: 3AF6F797
	v_or_b32_e32 v84, v84, v78                                 // 0000000426CC: 38A89D54
	v_and_b16 v118.h, 0xff, v119.l op_sel:[0,0,1]              // 0000000426D0: D7624076 0002EEFF 000000FF
	v_lshlrev_b16 v83.l, 8, v148.l                             // 0000000426DC: D7380053 00032888
	s_waitcnt vmcnt(18)                                        // 0000000426E4: BF894BF7
	v_xor_b32_e32 v124, v152, v124                             // 0000000426E8: 3AF8F998
	s_waitcnt vmcnt(17)                                        // 0000000426EC: BF8947F7
	v_xor_b32_e32 v125, v153, v125                             // 0000000426F0: 3AFAFB99
	s_waitcnt vmcnt(16)                                        // 0000000426F4: BF8943F7
	v_xor_b32_e32 v126, v154, v126                             // 0000000426F8: 3AFCFD9A
	s_waitcnt vmcnt(15)                                        // 0000000426FC: BF893FF7
	v_xor_b32_e32 v127, v155, v127                             // 000000042700: 3AFEFF9B
	s_waitcnt vmcnt(14)                                        // 000000042704: BF893BF7
	v_xor_b32_e32 v129, v156, v129                             // 000000042708: 3B03039C
	s_waitcnt vmcnt(13)                                        // 00000004270C: BF8937F7
	v_xor_b32_e32 v136, v157, v130                             // 000000042710: 3B11059D
	v_lshlrev_b16 v105.l, 8, v105.l                            // 000000042714: D7380069 0002D288
	v_lshlrev_b16 v106.l, 8, v106.l                            // 00000004271C: D738006A 0002D488
	v_lshlrev_b16 v82.l, 8, v98.l                              // 000000042724: D7380052 0002C488
	v_lshlrev_b16 v86.l, 8, v137.l                             // 00000004272C: D7380056 00031288
	v_or_b16 v98.l, v11.h, v83.h op_sel:[1,1,0]                // 000000042734: D7631862 0002A70B
	s_waitcnt vmcnt(12)                                        // 00000004273C: BF8933F7
	v_xor_b32_e32 v137, v158, v131                             // 000000042740: 3B13079E
	s_waitcnt vmcnt(11)                                        // 000000042744: BF892FF7
	v_xor_b32_e32 v138, v159, v132                             // 000000042748: 3B15099F
	s_waitcnt vmcnt(10)                                        // 00000004274C: BF892BF7
	v_xor_b32_e32 v139, v160, v133                             // 000000042750: 3B170BA0
	s_waitcnt vmcnt(9)                                         // 000000042754: BF8927F7
	v_xor_b32_e32 v140, v161, v134                             // 000000042758: 3B190DA1
	s_waitcnt vmcnt(8)                                         // 00000004275C: BF8923F7
	v_xor_b32_e32 v141, v162, v135                             // 000000042760: 3B1B0FA2
	s_waitcnt vmcnt(7)                                         // 000000042764: BF891FF7
	v_xor_b32_e32 v143, v163, v84                              // 000000042768: 3B1EA9A3
	v_and_b16 v11.h, 0xff00, v117.l op_sel:[0,0,1]             // 00000004276C: D762400B 0002EAFF FFFFFF00
	v_lshlrev_b16 v84.l, 8, v117.l                             // 000000042778: D7380054 0002EA88
	v_and_b16 v84.h, 0xff00, v117.h op_sel:[0,1,1]             // 000000042780: D7625054 0002EAFF FFFFFF00
	v_lshlrev_b16 v112.h, 8, v117.h op_sel:[0,1,1]             // 00000004278C: D7385070 0002EA88
	v_and_b16 v113.h, 0xff00, v123.l op_sel:[0,0,1]            // 000000042794: D7624071 0002F6FF FFFFFF00
	v_lshlrev_b16 v114.h, 8, v123.l op_sel:[0,0,1]             // 0000000427A0: D7384072 0002F688
	v_and_b16 v115.h, 0xff00, v123.h op_sel:[0,1,1]            // 0000000427A8: D7625073 0002F6FF FFFFFF00
	v_lshlrev_b16 v116.h, 8, v123.h op_sel:[0,1,1]             // 0000000427B4: D7385074 0002F688
	v_lshlrev_b16 v107.l, 8, v107.l                            // 0000000427BC: D738006B 0002D688
	v_lshlrev_b16 v108.l, 8, v108.l                            // 0000000427C4: D738006C 0002D888
	v_lshlrev_b16 v82.h, 8, v120.l op_sel:[0,0,1]              // 0000000427CC: D7384052 0002F088
	v_lshlrev_b16 v108.h, 8, v121.l op_sel:[0,0,1]             // 0000000427D4: D738406C 0002F288
	v_or_b16 v78.h, v118.h, v83.l op_sel:[1,0,1]               // 0000000427DC: D763484E 0002A776
	v_and_b16 v117.l, 0xff00, v124.l                           // 0000000427E4: D7620075 0002F8FF FFFFFF00
	v_lshlrev_b16 v117.h, 8, v124.l op_sel:[0,0,1]             // 0000000427F0: D7384075 0002F888
	v_and_b16 v118.h, 0xff00, v124.h op_sel:[0,1,1]            // 0000000427F8: D7625076 0002F8FF FFFFFF00
	v_lshlrev_b16 v120.l, 8, v124.h op_sel:[0,1,0]             // 000000042804: D7381078 0002F888
	v_and_b16 v121.l, 0xff00, v125.l                           // 00000004280C: D7620079 0002FAFF FFFFFF00
	v_lshlrev_b16 v122.l, 8, v125.l                            // 000000042818: D738007A 0002FA88
	v_and_b16 v123.l, 0xff00, v125.h op_sel:[0,1,0]            // 000000042820: D762107B 0002FAFF FFFFFF00
	v_lshlrev_b16 v123.h, 8, v125.h op_sel:[0,1,1]             // 00000004282C: D738507B 0002FA88
	v_lshlrev_b16 v109.l, 8, v109.l                            // 000000042834: D738006D 0002DA88
	v_lshlrev_b16 v110.l, 8, v110.l                            // 00000004283C: D738006E 0002DC88
	v_and_b16 v124.l, 0xff00, v126.l                           // 000000042844: D762007C 0002FCFF FFFFFF00
	v_lshlrev_b16 v124.h, 8, v126.l op_sel:[0,0,1]             // 000000042850: D738407C 0002FC88
	v_and_b16 v125.l, 0xff00, v126.h op_sel:[0,1,0]            // 000000042858: D762107D 0002FCFF FFFFFF00
	v_lshlrev_b16 v125.h, 8, v126.h op_sel:[0,1,1]             // 000000042864: D738507D 0002FC88
	v_and_b16 v126.l, 0xff00, v127.l                           // 00000004286C: D762007E 0002FEFF FFFFFF00
	v_lshlrev_b16 v126.h, 8, v127.l op_sel:[0,0,1]             // 000000042878: D738407E 0002FE88
	v_and_b16 v127.l, 0xff00, v127.h op_sel:[0,1,0]            // 000000042880: D762107F 0002FEFF FFFFFF00
	v_lshlrev_b16 v127.h, 8, v127.h op_sel:[0,1,1]             // 00000004288C: D738507F 0002FE88
	v_lshlrev_b16 v111.l, 8, v111.l                            // 000000042894: D738006F 0002DE88
	v_lshlrev_b16 v112.l, 8, v112.l                            // 00000004289C: D7380070 0002E088
	v_lshlrev_b16 v85.l, 8, v128.l                             // 0000000428A4: D7380055 00030088
	v_and_b16 v128.l, 0xff00, v129.l                           // 0000000428AC: D7620080 000302FF FFFFFF00
	v_lshlrev_b16 v128.h, 8, v129.l op_sel:[0,0,1]             // 0000000428B8: D7384080 00030288
	v_and_b16 v129.l, 0xff00, v129.h op_sel:[0,1,0]            // 0000000428C0: D7621081 000302FF FFFFFF00
	v_lshlrev_b16 v129.h, 8, v129.h op_sel:[0,1,1]             // 0000000428CC: D7385081 00030288
	v_and_b16 v130.l, 0xff00, v136.l                           // 0000000428D4: D7620082 000310FF FFFFFF00
	v_lshlrev_b16 v130.h, 8, v136.l op_sel:[0,0,1]             // 0000000428E0: D7384082 00031088
	v_and_b16 v131.l, 0xff00, v136.h op_sel:[0,1,0]            // 0000000428E8: D7621083 000310FF FFFFFF00
	v_lshlrev_b16 v131.h, 8, v136.h op_sel:[0,1,1]             // 0000000428F4: D7385083 00031088
	v_lshlrev_b16 v86.h, 8, v144.l op_sel:[0,0,1]              // 0000000428FC: D7384056 00032088
	v_and_b16 v132.l, 0xff00, v137.l                           // 000000042904: D7620084 000312FF FFFFFF00
	v_lshlrev_b16 v132.h, 8, v137.l op_sel:[0,0,1]             // 000000042910: D7384084 00031288
	v_and_b16 v133.l, 0xff00, v137.h op_sel:[0,1,0]            // 000000042918: D7621085 000312FF FFFFFF00
	v_lshlrev_b16 v133.h, 8, v137.h op_sel:[0,1,1]             // 000000042924: D7385085 00031288
	v_and_b16 v134.l, 0xff00, v138.l                           // 00000004292C: D7620086 000314FF FFFFFF00
	v_lshlrev_b16 v134.h, 8, v138.l op_sel:[0,0,1]             // 000000042938: D7384086 00031488
	v_and_b16 v135.l, 0xff00, v138.h op_sel:[0,1,0]            // 000000042940: D7621087 000314FF FFFFFF00
	v_lshlrev_b16 v135.h, 8, v138.h op_sel:[0,1,1]             // 00000004294C: D7385087 00031488
	v_and_b16 v136.l, 0xff00, v139.l                           // 000000042954: D7620088 000316FF FFFFFF00
	v_lshlrev_b16 v136.h, 8, v139.l op_sel:[0,0,1]             // 000000042960: D7384088 00031688
	v_and_b16 v137.l, 0xff00, v139.h op_sel:[0,1,0]            // 000000042968: D7621089 000316FF FFFFFF00
	v_lshlrev_b16 v137.h, 8, v139.h op_sel:[0,1,1]             // 000000042974: D7385089 00031688
	v_and_b16 v138.l, 0xff00, v140.l                           // 00000004297C: D762008A 000318FF FFFFFF00
	v_lshlrev_b16 v138.h, 8, v140.l op_sel:[0,0,1]             // 000000042988: D738408A 00031888
	v_and_b16 v139.l, 0xff00, v140.h op_sel:[0,1,0]            // 000000042990: D762108B 000318FF FFFFFF00
	v_lshlrev_b16 v139.h, 8, v140.h op_sel:[0,1,1]             // 00000004299C: D738508B 00031888
	v_and_b16 v140.l, 0xff00, v141.l                           // 0000000429A4: D762008C 00031AFF FFFFFF00
	v_lshlrev_b16 v140.h, 8, v141.l op_sel:[0,0,1]             // 0000000429B0: D738408C 00031A88
	v_and_b16 v141.l, 0xff00, v141.h op_sel:[0,1,0]            // 0000000429B8: D762108D 00031AFF FFFFFF00
	v_and_b16 v142.l, 0xff00, v143.l                           // 0000000429C4: D762008E 00031EFF FFFFFF00
	v_lshlrev_b16 v142.h, 8, v143.l op_sel:[0,0,1]             // 0000000429D0: D738408E 00031E88
	v_sub_nc_i16 v143.l, v11.h, v120.h op_sel:[1,1,0] clamp    // 0000000429D8: D70E988F 0002F10B
	v_sub_nc_i16 v84.l, v84.l, v96.h op_sel:[0,1,0] clamp      // 0000000429E0: D70E9054 0002C154
	v_sub_nc_i16 v144.l, v84.h, v119.h op_sel:[1,1,0] clamp    // 0000000429E8: D70E9890 0002EF54
	v_sub_nc_i16 v105.l, v112.h, v105.l op_sel:[1,0,0] clamp   // 0000000429F0: D70E8869 0002D370
	v_sub_nc_i16 v145.l, v113.h, v121.h op_sel:[1,1,0] clamp   // 0000000429F8: D70E9891 0002F371
	v_sub_nc_i16 v146.l, v114.h, v111.h op_sel:[1,1,0] clamp   // 000000042A00: D70E9892 0002DF72
	v_sub_nc_i16 v147.l, v115.h, v102.h op_sel:[1,1,0] clamp   // 000000042A08: D70E9893 0002CD73
	v_sub_nc_i16 v106.l, v116.h, v106.l op_sel:[1,0,0] clamp   // 000000042A10: D70E886A 0002D574
	v_lshlrev_b16 v141.h, 8, v141.h op_sel:[0,1,1]             // 000000042A18: D738508D 00031A88
	v_sub_nc_i16 v117.l, v117.l, v122.h op_sel:[0,1,0] clamp   // 000000042A20: D70E9075 0002F575
	v_sub_nc_i16 v148.l, v117.h, v101.h op_sel:[1,1,0] clamp   // 000000042A28: D70E9894 0002CB75
	v_sub_nc_i16 v95.l, v118.h, v95.l op_sel:[1,0,0] clamp     // 000000042A30: D70E885F 0002BF76
	v_sub_nc_i16 v107.l, v120.l, v107.l clamp                  // 000000042A38: D70E806B 0002D778
	v_sub_nc_i16 v120.l, v121.l, v95.h op_sel:[0,1,0] clamp    // 000000042A40: D70E9078 0002BF79
	v_sub_nc_i16 v82.l, v122.l, v82.l clamp                    // 000000042A48: D70E8052 0002A57A
	v_sub_nc_i16 v94.l, v123.l, v94.l clamp                    // 000000042A50: D70E805E 0002BD7B
	v_sub_nc_i16 v108.l, v123.h, v108.l op_sel:[1,0,0] clamp   // 000000042A58: D70E886C 0002D97B
	v_sub_nc_i16 v121.l, v124.l, v103.h op_sel:[0,1,0] clamp   // 000000042A60: D70E9079 0002CF7C
	v_sub_nc_i16 v122.l, v124.h, v109.h op_sel:[1,1,0] clamp   // 000000042A68: D70E987A 0002DB7C
	v_sub_nc_i16 v93.l, v125.l, v93.l clamp                    // 000000042A70: D70E805D 0002BB7D
	v_sub_nc_i16 v109.l, v125.h, v109.l op_sel:[1,0,0] clamp   // 000000042A78: D70E886D 0002DB7D
	v_sub_nc_i16 v123.l, v126.l, v93.h op_sel:[0,1,0] clamp    // 000000042A80: D70E907B 0002BB7E
	v_sub_nc_i16 v124.l, v126.h, v82.h op_sel:[1,1,0] clamp    // 000000042A88: D70E987C 0002A57E
	v_sub_nc_i16 v92.l, v127.l, v92.l clamp                    // 000000042A90: D70E805C 0002B97F
	v_sub_nc_i16 v110.l, v127.h, v110.l op_sel:[1,0,0] clamp   // 000000042A98: D70E886E 0002DD7F
	v_sub_nc_i16 v125.l, v128.l, v92.h op_sel:[0,1,0] clamp    // 000000042AA0: D70E907D 0002B980
	v_sub_nc_i16 v126.l, v128.h, v110.h op_sel:[1,1,0] clamp   // 000000042AA8: D70E987E 0002DD80
	v_sub_nc_i16 v91.l, v129.l, v91.l clamp                    // 000000042AB0: D70E805B 0002B781
	v_sub_nc_i16 v111.l, v129.h, v111.l op_sel:[1,0,0] clamp   // 000000042AB8: D70E886F 0002DF81
	v_sub_nc_i16 v127.l, v130.l, v91.h op_sel:[0,1,0] clamp    // 000000042AC0: D70E907F 0002B782
	v_sub_nc_i16 v128.l, v130.h, v108.h op_sel:[1,1,0] clamp   // 000000042AC8: D70E9880 0002D982
	v_sub_nc_i16 v90.l, v131.l, v90.l clamp                    // 000000042AD0: D70E805A 0002B583
	v_sub_nc_i16 v112.l, v131.h, v112.l op_sel:[1,0,0] clamp   // 000000042AD8: D70E8870 0002E183
	v_sub_nc_i16 v131.l, v135.l, v105.h op_sel:[0,1,0] clamp   // 000000042AE0: D70E9083 0002D387
	v_sub_nc_i16 v88.l, v138.l, v88.l clamp                    // 000000042AE8: D70E8058 0002B18A
	v_sub_nc_i16 v86.l, v138.h, v86.l op_sel:[1,0,0] clamp     // 000000042AF0: D70E8856 0002AD8A
	v_sub_nc_i16 v135.l, v141.l, v106.h op_sel:[0,1,0] clamp   // 000000042AF8: D70E9087 0002D58D
	v_perm_b32 v84, v84, v143, 0xc0c0105                       // 000000042B00: D6440054 03FF1F54 0C0C0105
	v_perm_b32 v105, v105, v144, 0xc0c0105                     // 000000042B0C: D6440069 03FF2169 0C0C0105
	v_perm_b32 v138, v146, v145, 0xc0c0105                     // 000000042B18: D644008A 03FF2392 0C0C0105
	v_perm_b32 v106, v106, v147, 0xc0c0105                     // 000000042B24: D644006A 03FF276A 0C0C0105
	v_sub_nc_i16 v129.l, v132.l, v104.h op_sel:[0,1,0] clamp   // 000000042B30: D70E9081 0002D184
	v_sub_nc_i16 v132.l, v136.l, v89.h op_sel:[0,1,0] clamp    // 000000042B38: D70E9084 0002B388
	v_sub_nc_i16 v136.l, v141.h, v94.h op_sel:[1,1,0] clamp    // 000000042B40: D70E9888 0002BD8D
	v_perm_b32 v117, v148, v117, 0xc0c0105                     // 000000042B48: D6440075 03FEEB94 0C0C0105
	v_perm_b32 v95, v107, v95, 0xc0c0105                       // 000000042B54: D644005F 03FEBF6B 0C0C0105
	v_perm_b32 v82, v82, v120, 0xc0c0105                       // 000000042B60: D6440052 03FEF152 0C0C0105
	v_perm_b32 v94, v108, v94, 0xc0c0105                       // 000000042B6C: D644005E 03FEBD6C 0C0C0105
	v_perm_b32 v108, v122, v121, 0xc0c0105                     // 000000042B78: D644006C 03FEF37A 0C0C0105
	v_perm_b32 v93, v109, v93, 0xc0c0105                       // 000000042B84: D644005D 03FEBB6D 0C0C0105
	v_perm_b32 v109, v124, v123, 0xc0c0105                     // 000000042B90: D644006D 03FEF77C 0C0C0105
	v_perm_b32 v92, v110, v92, 0xc0c0105                       // 000000042B9C: D644005C 03FEB96E 0C0C0105
	v_sub_nc_i16 v130.l, v134.l, v90.h op_sel:[0,1,0] clamp    // 000000042BA8: D70E9082 0002B586
	v_perm_b32 v110, v126, v125, 0xc0c0105                     // 000000042BB0: D644006E 03FEFB7E 0C0C0105
	v_perm_b32 v91, v111, v91, 0xc0c0105                       // 000000042BBC: D644005B 03FEB76F 0C0C0105
	v_perm_b32 v111, v128, v127, 0xc0c0105                     // 000000042BC8: D644006F 03FEFF80 0C0C0105
	v_perm_b32 v90, v112, v90, 0xc0c0105                       // 000000042BD4: D644005A 03FEB570 0C0C0105
	v_lshl_or_b32 v84, v105, 16, v84                           // 000000042BE0: D6560054 05512169
	v_lshl_or_b32 v105, v106, 16, v138                         // 000000042BE8: D6560069 0629216A
	v_lshlrev_b16 v101.l, 8, v101.l                            // 000000042BF0: D7380065 0002CA88
	v_lshlrev_b16 v102.l, 8, v102.l                            // 000000042BF8: D7380066 0002CC88
	v_lshlrev_b16 v113.l, 8, v113.l                            // 000000042C00: D7380071 0002E288
	v_lshlrev_b16 v114.l, 8, v114.l                            // 000000042C08: D7380072 0002E488
	v_lshlrev_b16 v115.l, 8, v115.l                            // 000000042C10: D7380073 0002E688
	v_lshlrev_b16 v116.l, 8, v116.l                            // 000000042C18: D7380074 0002E888
	v_lshl_or_b32 v95, v95, 16, v117                           // 000000042C20: D656005F 05D5215F
	v_lshl_or_b32 v82, v94, 16, v82                            // 000000042C28: D6560052 0549215E
	v_lshl_or_b32 v93, v93, 16, v108                           // 000000042C30: D656005D 05B1215D
	v_lshl_or_b32 v92, v92, 16, v109                           // 000000042C38: D656005C 05B5215C
	v_lshl_or_b32 v91, v91, 16, v110                           // 000000042C40: D656005B 05B9215B
	v_lshl_or_b32 v90, v90, 16, v111                           // 000000042C48: D656005A 05BD215A
	ds_store_2addr_b32 v61, v84, v105 offset1:1                // 000000042C50: D8380100 0069543D
	ds_store_2addr_b32 v62, v95, v82 offset1:1                 // 000000042C58: D8380100 00525F3E
	ds_store_2addr_b32 v63, v93, v92 offset1:1                 // 000000042C60: D8380100 005C5D3F
	ds_store_2addr_b32 v64, v91, v90 offset1:1                 // 000000042C68: D8380100 005A5B40
	v_sub_nc_i16 v101.l, v132.h, v101.l op_sel:[1,0,0] clamp   // 000000042C70: D70E8865 0002CB84
	v_sub_nc_i16 v89.l, v133.l, v89.l clamp                    // 000000042C78: D70E8059 0002B385
	v_sub_nc_i16 v113.l, v133.h, v113.l op_sel:[1,0,0] clamp   // 000000042C80: D70E8871 0002E385
	v_sub_nc_i16 v85.l, v134.h, v85.l op_sel:[1,0,0] clamp     // 000000042C88: D70E8855 0002AB86
	v_sub_nc_i16 v114.l, v135.h, v114.l op_sel:[1,0,0] clamp   // 000000042C90: D70E8872 0002E587
	v_sub_nc_i16 v102.l, v136.h, v102.l op_sel:[1,0,0] clamp   // 000000042C98: D70E8866 0002CD88
	v_sub_nc_i16 v133.l, v137.l, v88.h op_sel:[0,1,0] clamp    // 000000042CA0: D70E9085 0002B189
	v_sub_nc_i16 v115.l, v137.h, v115.l op_sel:[1,0,0] clamp   // 000000042CA8: D70E8873 0002E789
	v_sub_nc_i16 v87.l, v139.l, v87.l clamp                    // 000000042CB0: D70E8057 0002AF8B
	v_sub_nc_i16 v116.l, v139.h, v116.l op_sel:[1,0,0] clamp   // 000000042CB8: D70E8874 0002E98B
	v_sub_nc_i16 v137.l, v142.l, v85.h op_sel:[0,1,0] clamp    // 000000042CC0: D70E9089 0002AB8E
	v_sub_nc_i16 v84.l, v142.h, v86.h op_sel:[1,1,0] clamp     // 000000042CC8: D70E9854 0002AD8E
	global_load_b32 v82, v81, s[10:11]                         // 000000042CD0: DC520000 520A0051
	v_sub_nc_i16 v134.l, v140.l, v87.h op_sel:[0,1,0] clamp    // 000000042CD8: D70E9086 0002AF8C
	v_perm_b32 v101, v101, v129, 0xc0c0105                     // 000000042CE0: D6440065 03FF0365 0C0C0105
	v_perm_b32 v89, v113, v89, 0xc0c0105                       // 000000042CEC: D6440059 03FEB371 0C0C0105
	v_perm_b32 v85, v85, v130, 0xc0c0105                       // 000000042CF8: D6440055 03FF0555 0C0C0105
	v_perm_b32 v112, v114, v131, 0xc0c0105                     // 000000042D04: D6440070 03FF0772 0C0C0105
	v_perm_b32 v102, v102, v132, 0xc0c0105                     // 000000042D10: D6440066 03FF0966 0C0C0105
	v_perm_b32 v113, v115, v133, 0xc0c0105                     // 000000042D1C: D6440071 03FF0B73 0C0C0105
	v_perm_b32 v88, v86, v88, 0xc0c0105                        // 000000042D28: D6440058 03FEB156 0C0C0105
	v_perm_b32 v87, v116, v87, 0xc0c0105                       // 000000042D34: D6440057 03FEAF74 0C0C0105
	v_perm_b32 v91, v84, v137, 0xc0c0105                       // 000000042D40: D644005B 03FF1354 0C0C0105
	v_and_b32_e32 v84, 0x80402010, v100                        // 000000042D4C: 36A8C8FF 80402010
	v_lshl_or_b32 v89, v89, 16, v101                           // 000000042D54: D6560059 05952159
	v_lshl_or_b32 v94, v112, 16, v85                           // 000000042D5C: D656005E 05552170
	v_lshl_or_b32 v101, v113, 16, v102                         // 000000042D64: D6560065 05992171
	v_lshl_or_b32 v102, v87, 16, v88                           // 000000042D6C: D6560066 05612157
	v_or_b32_e32 v85, v98, v78                                 // 000000042D74: 38AA9D62
	v_lshlrev_b16 v78.h, 8, v143.h op_sel:[0,1,1]              // 000000042D78: D738504E 00031E88
	v_lshlrev_b16 v81.l, 8, v118.l                             // 000000042D80: D7380051 0002EC88
	v_lshrrev_b32_e32 v88, 24, v84                             // 000000042D88: 32B0A898
	v_and_b16 v11.h, 0xff00, v143.h op_sel:[0,1,1]             // 000000042D8C: D762500B 00031EFF FFFFFF00
	v_lshrrev_b32_e32 v92, 22, v100                            // 000000042D98: 32B8C896
	v_and_b32_e32 v95, 0xff, v12                               // 000000042D9C: 36BE18FF 000000FF
	v_sub_nc_i16 v87.l, v78.h, v81.l op_sel:[1,0,0] clamp      // 000000042DA4: D70E8857 0002A34E
	v_lshrrev_b16 v81.l, 8, v84.l                              // 000000042DAC: D7390051 0002A888
	v_cmp_ne_u16_e32 vcc_lo, 0, v88.l                          // 000000042DB4: 7C7AB080
	v_sub_nc_i16 v86.l, v11.h, v107.h op_sel:[1,1,0] clamp     // 000000042DB8: D70E9856 0002D70B
	v_lshrrev_b16 v84.l, 4, v84.l                              // 000000042DC0: D7390054 0002A884
	s_waitcnt vmcnt(7)                                         // 000000042DC8: BF891FF7
	v_xor_b32_e32 v85, v99, v85                                // 000000042DCC: 3AAAAB63
	v_lshlrev_b16 v81.h, 8, v104.l op_sel:[0,0,1]              // 000000042DD0: D7384051 0002D088
	v_cndmask_b32_e64 v88, 0, -1, vcc_lo                       // 000000042DD8: D5010058 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v81.l                          // 000000042DE0: 7C7AA280
	v_perm_b32 v93, v87, v86, 0xc0c0105                        // 000000042DE4: D644005D 03FEAD57 0C0C0105
	v_bfe_i32 v86, v92, 0, 1                                   // 000000042DF0: D6110056 0205015C
	v_bfe_i32 v98, v84, 0, 1                                   // 000000042DF8: D6110062 02050154
	v_mov_b16_e32 v81.l, v88.l                                 // 000000042E00: 7EA23958
	v_cndmask_b32_e64 v92, 0, -1, vcc_lo                       // 000000042E04: D501005C 01A98280
	v_bcnt_u32_b32 v88, v95, 0                                 // 000000042E0C: D71E0058 0001015F
	v_and_b16 v11.h, 0xff00, v85.l op_sel:[0,0,1]              // 000000042E14: D762400B 0002AAFF FFFFFF00
	v_lshlrev_b16 v78.h, 8, v85.l op_sel:[0,0,1]               // 000000042E20: D738404E 0002AA88
	v_mov_b16_e32 v84.l, v86.l                                 // 000000042E28: 7EA83956
	v_mov_b16_e32 v85.l, v92.l                                 // 000000042E2C: 7EAA395C
	v_mov_b16_e32 v86.l, v98.l                                 // 000000042E30: 7EAC3962
	v_and_b32_e32 v88, 1, v88                                  // 000000042E34: 36B0B081
	v_sub_nc_i16 v87.l, v11.h, v83.h op_sel:[1,1,0] clamp      // 000000042E38: D70E9857 0002A70B
	v_and_b16 v11.h, 0xff, v84.l op_sel:[0,0,1]                // 000000042E40: D762400B 0002A8FF 000000FF
	v_lshlrev_b16 v83.h, 8, v81.l op_sel:[0,0,1]               // 000000042E4C: D7384053 0002A288
	v_lshlrev_b16 v84.h, 8, v85.l op_sel:[0,0,1]               // 000000042E54: D7384054 0002AA88
	v_and_b16 v81.l, 0xff, v86.l                               // 000000042E5C: D7620051 0002ACFF 000000FF
	v_lshrrev_b32_e32 v92, 14, v6                              // 000000042E68: 32B80C8E
	v_lshlrev_b32_e32 v88, 7, v88                              // 000000042E6C: 30B0B087
	v_lshrrev_b32_e32 v6, 22, v6                               // 000000042E70: 320C0C96
	v_sub_nc_i16 v85.l, v78.h, v81.h op_sel:[1,1,0] clamp      // 000000042E74: D70E9855 0002A34E
	v_or_b16 v78.h, v11.h, v83.h op_sel:[1,1,1]                // 000000042E7C: D763584E 0002A70B
	v_or_b16 v81.l, v81.l, v84.h op_sel:[0,1,0]                // 000000042E84: D7631051 0002A951
	v_mov_b16_e32 v81.h, v78.l                                 // 000000042E8C: 7FA2394E
	v_and_b32_e32 v92, 0x3fc, v92                              // 000000042E90: 36B8B8FF 000003FC
	v_xor_b32_e32 v88, v88, v95                                // 000000042E98: 3AB0BF58
	v_and_b32_e32 v6, 0x3fc, v6                                // 000000042E9C: 360C0CFF 000003FC
	v_perm_b32 v95, v85, v87, 0xc0c0105                        // 000000042EA4: D644005F 03FEAF55 0C0C0105
	v_add_co_u32 v87, vcc_lo, v3, v60                          // 000000042EB0: D7006A57 00027903
	v_or_b32_e32 v98, v81, v78                                 // 000000042EB8: 38C49D51
	s_clause 0x1                                               // 000000042EBC: BF850001
	global_load_b32 v81, v92, s[10:11]                         // 000000042EC0: DC520000 510A005C
	global_load_b32 v6, v6, s[10:11]                           // 000000042EC8: DC520000 060A0006
	v_mul_lo_u32 v92, 0x1010101, v88                           // 000000042ED0: D72C005C 0002B0FF 01010101
	v_add_co_ci_u32_e64 v88, null, 0, v4, vcc_lo               // 000000042EDC: D5207C58 01AA0880
	s_waitcnt vmcnt(8)                                         // 000000042EE4: BF8923F7
	v_xor_b32_e32 v98, v5, v98                                 // 000000042EE8: 3AC4C505
	v_and_b16 v11.h, 0xff00, v85.h op_sel:[0,1,1]              // 000000042EEC: D762500B 0002AAFF FFFFFF00
	v_lshlrev_b16 v78.h, 8, v85.h op_sel:[0,1,1]               // 000000042EF8: D738504E 0002AA88
	global_load_b32 v5, v[87:88], off offset:66                // 000000042F00: DC520042 057C0057
	v_lshlrev_b16 v85.l, 8, v119.l                             // 000000042F08: D7380055 0002EE88
	v_and_b32_e32 v100, 0x8040201, v92                         // 000000042F10: 36C8B8FF 08040201
	v_lshlrev_b16 v103.l, 8, v103.l                            // 000000042F18: D7380067 0002CE88
	v_sub_nc_i16 v99.l, v11.h, v83.l op_sel:[1,0,0] clamp      // 000000042F20: D70E8863 0002A70B
	v_lshlrev_b16 v83.l, 8, v86.l                              // 000000042F28: D7380053 0002AC88
	v_sub_nc_i16 v85.l, v78.h, v85.l op_sel:[1,0,0] clamp      // 000000042F30: D70E8855 0002AB4E
	v_lshrrev_b32_e32 v86, 24, v100                            // 000000042F38: 32ACC898
	v_sub_nc_i16 v103.l, v140.h, v103.l op_sel:[1,0,0] clamp   // 000000042F3C: D70E8867 0002CF8C
	v_perm_b32 v114, v136, v135, 0xc0c0105                     // 000000042F44: D6440072 03FF0F88 0C0C0105
	v_lshrrev_b32_e32 v87, 18, v92                             // 000000042F50: 32AEB892
	v_perm_b32 v88, v85, v99, 0xc0c0105                        // 000000042F54: D6440058 03FEC755 0C0C0105
	v_lshrrev_b16 v85.l, 8, v100.l                             // 000000042F60: D7390055 0002C888
	v_cmp_ne_u16_e32 vcc_lo, 0, v86.l                          // 000000042F68: 7C7AAC80
	v_perm_b32 v103, v103, v134, 0xc0c0105                     // 000000042F6C: D6440067 03FF0D67 0C0C0105
	v_lshlrev_b16 v78.h, 8, v98.l op_sel:[0,0,1]               // 000000042F78: D738404E 0002C488
	v_bfe_i32 v87, v87, 0, 1                                   // 000000042F80: D6110057 02050157
	v_bfe_i32 v100, v92, 0, 1                                  // 000000042F88: D6110064 0205015C
	v_cndmask_b32_e64 v86, 0, -1, vcc_lo                       // 000000042F90: D5010056 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v85.l                          // 000000042F98: 7C7AAA80
	v_lshl_or_b32 v90, v114, 16, v103                          // 000000042F9C: D656005A 059D2172
	v_and_b16 v11.h, 0xff00, v98.l op_sel:[0,0,1]              // 000000042FA4: D762400B 0002C4FF FFFFFF00
	v_sub_nc_i16 v99.l, v78.h, v83.l op_sel:[1,0,0] clamp      // 000000042FB0: D70E8863 0002A74E
	v_mov_b16_e32 v83.l, v87.l                                 // 000000042FB8: 7EA63957
	v_cndmask_b32_e64 v103, 0, -1, vcc_lo                      // 000000042FBC: D5010067 01A98280
	v_mov_b16_e32 v85.l, v86.l                                 // 000000042FC4: 7EAA3956
	v_mov_b16_e32 v86.l, v100.l                                // 000000042FC8: 7EAC3964
	v_sub_nc_i16 v98.l, v11.h, v84.h op_sel:[1,1,0] clamp      // 000000042FCC: D70E9862 0002A90B
	v_and_b16 v11.h, 0xff, v83.l op_sel:[0,0,1]                // 000000042FD4: D762400B 0002A6FF 000000FF
	v_mov_b16_e32 v87.l, v103.l                                // 000000042FE0: 7EAE3967
	v_lshlrev_b16 v84.h, 8, v85.l op_sel:[0,0,1]               // 000000042FE4: D7384054 0002AA88
	v_and_b16 v85.l, 0xff, v86.l                               // 000000042FEC: D7620055 0002ACFF 000000FF
	v_lshlrev_b16 v84.l, 8, v84.l                              // 000000042FF8: D7380054 0002A888
	v_mov_b16_e32 v100.h, v78.l                                // 000000043000: 7FC8394E
	v_lshlrev_b16 v85.h, 8, v87.l op_sel:[0,0,1]               // 000000043004: D7384055 0002AE88
	v_lshlrev_b16 v87.l, 8, v98.h op_sel:[0,1,0]               // 00000004300C: D7381057 0002C488
	v_or_b16 v78.h, v11.h, v84.h op_sel:[1,1,1]                // 000000043014: D763584E 0002A90B
	v_and_b16 v86.h, 0xff00, v98.h op_sel:[0,1,1]              // 00000004301C: D7625056 0002C4FF FFFFFF00
	v_lshrrev_b32_e32 v79, 28, v79                             // 000000043028: 329E9E9C
	v_or_b16 v100.l, v85.l, v85.h op_sel:[0,1,0]               // 00000004302C: D7631064 0002AB55
	v_sub_nc_i16 v84.l, v87.l, v84.l clamp                     // 000000043034: D70E8054 0002A957
	v_cvt_f32_f16_e32 v87, v96.l                               // 00000004303C: 7EAE1760
	v_sub_nc_i16 v85.l, v86.h, v83.h op_sel:[1,1,0] clamp      // 000000043040: D70E9855 0002A756
	v_cvt_f32_ubyte0_e32 v79, v79                              // 000000043048: 7E9E234F
	v_or_b32_e32 v100, v100, v78                               // 00000004304C: 38C89D64
	v_lshlrev_b16 v83.h, 8, v86.l op_sel:[0,0,1]               // 000000043050: D7384053 0002AC88
	v_mul_f32_e32 v87, 0.5, v87                                // 000000043058: 10AEAEF0
	v_bfe_u32 v86, v12, 7, 8                                   // 00000004305C: D6100056 02210F0C
	v_perm_b32 v98, v99, v98, 0xc0c0105                        // 000000043064: D6440062 03FEC563 0C0C0105
	s_waitcnt vmcnt(8)                                         // 000000043070: BF8923F7
	v_xor_b32_e32 v97, v97, v100                               // 000000043074: 3AC2C961
	v_perm_b32 v99, v84, v85, 0xc0c0105                        // 000000043078: D6440063 03FEAB54 0C0C0105
	v_fma_mix_f32 v79, v79, v96, v87 op_sel_hi:[0,1,0]         // 000000043084: CC20004F 155EC14F
	v_bcnt_u32_b32 v87, v86, 0                                 // 00000004308C: D71E0057 00010156
	v_lshl_or_b32 v91, v93, 16, v91                            // 000000043094: D656005B 056D215D
	v_and_b16 v11.h, 0xff00, v97.l op_sel:[0,0,1]              // 00000004309C: D762400B 0002C2FF FFFFFF00
	v_lshl_or_b32 v88, v88, 16, v95                            // 0000000430A8: D6560058 057D2158
	v_lshl_or_b32 v93, v99, 16, v98                            // 0000000430B0: D656005D 05892163
	ds_store_2addr_b32 v66, v89, v94 offset1:1                 // 0000000430B8: D8380100 005E5942
	ds_store_2addr_b32 v67, v101, v102 offset1:1               // 0000000430C0: D8380100 00666543
	ds_store_2addr_b32 v68, v90, v91 offset1:1                 // 0000000430C8: D8380100 005B5A44
	ds_store_2addr_b32 v69, v88, v93 offset1:1                 // 0000000430D0: D8380100 005D5845
	v_sub_nc_i16 v88.l, v11.h, v85.h op_sel:[1,1,0] clamp      // 0000000430D8: D70E9858 0002AB0B
	v_and_b32_e32 v85, 1, v87                                  // 0000000430E0: 36AAAE81
	v_and_b32_e32 v87, 0x80402010, v92                         // 0000000430E4: 36AEB8FF 80402010
	v_lshlrev_b16 v78.h, 8, v97.l op_sel:[0,0,1]               // 0000000430EC: D738404E 0002C288
	v_lshrrev_b32_e32 v90, 22, v92                             // 0000000430F4: 32B4B896
	v_lshlrev_b16 v83.l, 8, v83.l                              // 0000000430F8: D7380053 0002A688
	v_lshlrev_b32_e32 v85, 7, v85                              // 000000043100: 30AAAA87
	v_lshrrev_b32_e32 v91, 24, v87                             // 000000043104: 32B6AE98
	v_sub_nc_i16 v89.l, v78.h, v83.h op_sel:[1,1,0] clamp      // 000000043108: D70E9859 0002A74E
	v_lshrrev_b16 v83.h, 8, v87.l op_sel:[0,0,1]               // 000000043110: D7394053 0002AE88
	v_bfe_i32 v90, v90, 0, 1                                   // 000000043118: D611005A 0205015A
	v_xor_b32_e32 v85, v85, v86                                // 000000043120: 3AAAAD55
	v_cmp_ne_u16_e32 vcc_lo, 0, v91.l                          // 000000043124: 7C7AB680
	v_lshrrev_b16 v86.l, 4, v87.l                              // 000000043128: D7390056 0002AE84
	v_lshlrev_b16 v78.h, 8, v97.h op_sel:[0,1,1]               // 000000043130: D738504E 0002C288
	v_mov_b16_e32 v84.l, v90.l                                 // 000000043138: 7EA8395A
	v_mul_lo_u32 v91, 0x1010101, v85                           // 00000004313C: D72C005B 0002AAFF 01010101
	v_cndmask_b32_e64 v87, 0, -1, vcc_lo                       // 000000043148: D5010057 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v83.h                          // 000000043150: 7C7BA680
	v_bfe_i32 v86, v86, 0, 1                                   // 000000043154: D6110056 02050156
	global_load_d16_b16 v3, v[3:4], off                        // 00000004315C: DC820000 037C0003
	v_sub_nc_i16 v93.l, v78.h, v83.l op_sel:[1,0,0] clamp      // 000000043164: D70E885D 0002A74E
	v_mov_b16_e32 v83.l, v87.l                                 // 00000004316C: 7EA63957
	v_cndmask_b32_e64 v90, 0, -1, vcc_lo                       // 000000043170: D501005A 01A98280
	v_mov_b16_e32 v4.l, v86.l                                  // 000000043178: 7E083956
	v_and_b32_e32 v87, 0xff, v1                                // 00000004317C: 36AE02FF 000000FF
	v_and_b16 v11.h, 0xff00, v97.h op_sel:[0,1,1]              // 000000043184: D762500B 0002C2FF FFFFFF00
	s_waitcnt vmcnt(0)                                         // 000000043190: BF8903F7
	v_lshlrev_b16 v3.h, 8, v83.l op_sel:[0,0,1]                // 000000043194: D7384003 0002A688
	v_mov_b16_e32 v85.l, v90.l                                 // 00000004319C: 7EAA395A
	v_and_b32_e32 v90, 0x8040201, v91                          // 0000000431A0: 36B4B6FF 08040201
	v_and_b16 v83.l, 0xff, v4.l                                // 0000000431A8: D7620053 000208FF 000000FF
	v_sub_nc_i16 v92.l, v11.h, v84.h op_sel:[1,1,0] clamp      // 0000000431B4: D70E985C 0002A90B
	v_and_b16 v11.h, 0xff, v84.l op_sel:[0,0,1]                // 0000000431BC: D762400B 0002A8FF 000000FF
	v_lshlrev_b16 v4.h, 8, v85.l op_sel:[0,0,1]                // 0000000431C8: D7384004 0002AA88
	v_lshrrev_b32_e32 v86, 24, v90                             // 0000000431D0: 32ACB498
	v_lshrrev_b16 v83.h, 8, v90.l op_sel:[0,0,1]               // 0000000431D4: D7394053 0002B488
	v_lshlrev_b32_e32 v85, 2, v87                              // 0000000431DC: 30AAAE82
	v_lshrrev_b32_e32 v87, 18, v91                             // 0000000431E0: 32AEB692
	v_or_b16 v78.h, v11.h, v3.h op_sel:[1,1,1]                 // 0000000431E4: D763584E 0002070B
	v_cmp_ne_u16_e32 vcc_lo, 0, v86.l                          // 0000000431EC: 7C7AAC80
	v_or_b16 v94.l, v83.l, v4.h op_sel:[0,1,0]                 // 0000000431F0: D763105E 00020953
	global_load_b32 v90, v85, s[10:11]                         // 0000000431F8: DC520000 5A0A0055
	v_bfe_i32 v85, v87, 0, 1                                   // 000000043200: D6110055 02050157
	v_bfe_i32 v87, v91, 0, 1                                   // 000000043208: D6110057 0205015B
	v_cndmask_b32_e64 v86, 0, -1, vcc_lo                       // 000000043210: D5010056 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v83.h                          // 000000043218: 7C7BA680
	v_mov_b16_e32 v94.h, v78.l                                 // 00000004321C: 7FBC394E
	v_mov_b16_e32 v83.l, v85.l                                 // 000000043220: 7EA63955
	v_mul_f32_e32 v79, 0.5, v79                                // 000000043224: 109E9EF0
	v_mov_b16_e32 v85.l, v86.l                                 // 000000043228: 7EAA3956
	v_cndmask_b32_e64 v95, 0, -1, vcc_lo                       // 00000004322C: D501005F 01A98280
	v_mov_b16_e32 v86.l, v87.l                                 // 000000043234: 7EAC3957
	v_or_b32_e32 v94, v94, v78                                 // 000000043238: 38BC9D5E
	v_and_b16 v11.h, 0xff, v83.l op_sel:[0,0,1]                // 00000004323C: D762400B 0002A6FF 000000FF
	v_lshlrev_b16 v83.h, 8, v85.l op_sel:[0,0,1]               // 000000043248: D7384053 0002AA88
	v_mov_b16_e32 v87.l, v95.l                                 // 000000043250: 7EAE395F
	v_and_b16 v84.h, 0xff, v86.l op_sel:[0,0,1]                // 000000043254: D7624054 0002ACFF 000000FF
	ds_store_2addr_stride64_b32 v65, v80, v79 offset0:38 offset1:76// 000000043260: D83C4C26 004F5041
	v_lshlrev_b16 v4.l, 8, v4.l                                // 000000043268: D7380004 00020888
	v_or_b16 v78.h, v11.h, v83.h op_sel:[1,1,1]                // 000000043270: D763584E 0002A70B
	v_lshlrev_b16 v85.l, 8, v87.l                              // 000000043278: D7380055 0002AE88
	v_perm_b32 v87, v89, v88, 0xc0c0105                        // 000000043280: D6440057 03FEB159 0C0C0105
	v_perm_b32 v88, v93, v92, 0xc0c0105                        // 00000004328C: D6440058 03FEB95D 0C0C0105
	v_xor_b32_e32 v89, v10, v94                                // 000000043298: 3AB2BD0A
	v_mov_b16_e32 v92.h, v78.l                                 // 00000004329C: 7FB8394E
	v_or_b16 v92.l, v84.h, v85.l op_sel:[1,0,0]                // 0000000432A0: D763085C 0002AB54
	v_lshlrev_b16 v79.l, 8, v84.l                              // 0000000432A8: D738004F 0002A888
	v_lshl_or_b32 v87, v88, 16, v87                            // 0000000432B0: D6560057 055D2158
	v_and_b16 v10.l, 0xff00, v89.l                             // 0000000432B8: D762000A 0002B2FF FFFFFF00
	v_lshlrev_b16 v10.h, 8, v89.l op_sel:[0,0,1]               // 0000000432C4: D738400A 0002B288
	v_or_b32_e32 v80, v92, v78                                 // 0000000432CC: 38A09D5C
	v_and_b16 v11.h, 0xff00, v89.h op_sel:[0,1,1]              // 0000000432D0: D762500B 0002B2FF FFFFFF00
	v_lshlrev_b16 v78.h, 8, v89.h op_sel:[0,1,1]               // 0000000432DC: D738504E 0002B288
	v_sub_nc_i16 v10.l, v10.l, v4.h op_sel:[0,1,0] clamp       // 0000000432E4: D70E900A 0002090A
	v_bfe_u32 v88, v12, 14, 8                                  // 0000000432EC: D6100058 02211D0C
	v_xor_b32_e32 v9, v9, v80                                  // 0000000432F4: 3A12A109
	v_sub_nc_i16 v80.l, v10.h, v4.l op_sel:[1,0,0] clamp       // 0000000432F8: D70E8850 0002090A
	v_sub_nc_i16 v84.l, v11.h, v3.h op_sel:[1,1,0] clamp       // 000000043300: D70E9854 0002070B
	v_sub_nc_i16 v79.l, v78.h, v79.l op_sel:[1,0,0] clamp      // 000000043308: D70E884F 00029F4E
	v_lshlrev_b16 v4.h, 8, v86.l op_sel:[0,0,1]                // 000000043310: D7384004 0002AC88
	v_and_b16 v3.h, 0xff00, v9.l op_sel:[0,0,1]                // 000000043318: D7624003 000212FF FFFFFF00
	v_perm_b32 v86, v80, v10, 0xc0c0105                        // 000000043324: D6440056 03FE1550 0C0C0105
	v_bcnt_u32_b32 v10, v88, 0                                 // 000000043330: D71E000A 00010158
	v_perm_b32 v89, v79, v84, 0xc0c0105                        // 000000043338: D6440059 03FEA94F 0C0C0105
	v_and_b32_e32 v79, 0x80402010, v91                         // 000000043344: 369EB6FF 80402010
	v_lshlrev_b16 v4.l, 8, v9.l                                // 00000004334C: D7380004 00021288
	v_lshrrev_b32_e32 v80, 22, v91                             // 000000043354: 32A0B696
	v_and_b32_e32 v10, 1, v10                                  // 000000043358: 36141481
	v_sub_nc_i16 v92.l, v3.h, v85.l op_sel:[1,0,0] clamp       // 00000004335C: D70E885C 0002AB03
	v_lshrrev_b32_e32 v84, 24, v79                             // 000000043364: 32A89E98
	v_sub_nc_i16 v93.l, v4.l, v4.h op_sel:[0,1,0] clamp        // 000000043368: D70E905D 00020904
	v_and_b16 v3.h, 0xff00, v9.h op_sel:[0,1,1]                // 000000043370: D7625003 000212FF FFFFFF00
	v_lshlrev_b16 v4.l, 8, v9.h op_sel:[0,1,0]                 // 00000004337C: D7381004 00021288
	v_lshlrev_b32_e32 v9, 7, v10                               // 000000043384: 30121487
	v_bfe_i32 v80, v80, 0, 1                                   // 000000043388: D6110050 02050150
	v_lshrrev_b16 v4.h, 8, v79.l op_sel:[0,0,1]                // 000000043390: D7394004 00029E88
	v_cmp_ne_u16_e32 vcc_lo, 0, v84.l                          // 000000043398: 7C7AA880
	v_lshrrev_b32_e32 v10, 6, v1                               // 00000004339C: 32140286
	v_xor_b32_e32 v85, v9, v88                                 // 0000000433A0: 3AAAB109
	v_mov_b16_e32 v9.l, v80.l                                  // 0000000433A4: 7E123950
	v_lshrrev_b16 v79.l, 4, v79.l                              // 0000000433A8: D739004F 00029E84
	v_cndmask_b32_e64 v80, 0, -1, vcc_lo                       // 0000000433B0: D5010050 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h                           // 0000000433B8: 7C7B0880
	v_mul_lo_u32 v88, 0x1010101, v85                           // 0000000433BC: D72C0058 0002AAFF 01010101
	v_and_b32_e32 v10, 0x3fc, v10                              // 0000000433C8: 361414FF 000003FC
	v_bfe_i32 v85, v79, 0, 1                                   // 0000000433D0: D6110055 0205014F
	v_and_b16 v9.h, 0xff, v9.l op_sel:[0,0,1]                  // 0000000433D8: D7624009 000212FF 000000FF
	v_cndmask_b32_e64 v84, 0, -1, vcc_lo                       // 0000000433E4: D5010054 01A98280
	v_lshlrev_b16 v4.h, 8, v83.l op_sel:[0,0,1]                // 0000000433EC: D7384004 0002A688
	global_load_b32 v91, v10, s[10:11]                         // 0000000433F4: DC520000 5B0A000A
	v_mov_b16_e32 v10.l, v80.l                                 // 0000000433FC: 7E143950
	v_mov_b16_e32 v80.l, v85.l                                 // 000000043400: 7EA03955
	v_mov_b16_e32 v79.l, v84.l                                 // 000000043404: 7E9E3954
	v_and_b32_e32 v84, 0x8040201, v88                          // 000000043408: 36A8B0FF 08040201
	v_lshrrev_b32_e32 v85, 14, v1                              // 000000043410: 32AA028E
	v_lshlrev_b16 v10.l, 8, v10.l                              // 000000043414: D738000A 00021488
	v_lshrrev_b32_e32 v94, 18, v88                             // 00000004341C: 32BCB092
	v_lshlrev_b16 v10.h, 8, v79.l op_sel:[0,0,1]               // 000000043420: D738400A 00029E88
	v_lshrrev_b32_e32 v79, 24, v84                             // 000000043428: 329EA898
	v_and_b32_e32 v85, 0x3fc, v85                              // 00000004342C: 36AAAAFF 000003FC
	v_or_b16 v78.h, v9.h, v10.l op_sel:[1,0,1]                 // 000000043434: D763484E 00021509
	v_lshrrev_b16 v9.h, 8, v84.l op_sel:[0,0,1]                // 00000004343C: D7394009 0002A888
	v_and_b16 v11.h, 0xff, v80.l op_sel:[0,0,1]                // 000000043444: D762400B 0002A0FF 000000FF
	v_cmp_ne_u16_e32 vcc_lo, 0, v79.l                          // 000000043450: 7C7A9E80
	global_load_b32 v96, v85, s[10:11]                         // 000000043454: DC520000 600A0055
	v_bfe_i32 v84, v94, 0, 1                                   // 00000004345C: D6110054 0205015E
	v_bfe_i32 v94, v88, 0, 1                                   // 000000043464: D611005E 02050158
	v_or_b16 v95.l, v11.h, v10.h op_sel:[1,1,0]                // 00000004346C: D763185F 0002150B
	v_cndmask_b32_e64 v85, 0, -1, vcc_lo                       // 000000043474: D5010055 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v9.h                           // 00000004347C: 7C7B1280
	v_mov_b16_e32 v95.h, v78.l                                 // 000000043480: 7FBE394E
	v_mov_b16_e32 v79.l, v84.l                                 // 000000043484: 7E9E3954
	v_mov_b16_e32 v84.l, v94.l                                 // 000000043488: 7EA8395E
	v_mov_b16_e32 v83.l, v85.l                                 // 00000004348C: 7EA63955
	v_cndmask_b32_e64 v97, 0, -1, vcc_lo                       // 000000043490: D5010061 01A98280
	v_or_b32_e32 v94, v95, v78                                 // 000000043498: 38BC9D5F
	v_and_b16 v9.h, 0xff, v79.l op_sel:[0,0,1]                 // 00000004349C: D7624009 00029EFF 000000FF
	v_and_b16 v79.h, 0xff, v84.l op_sel:[0,0,1]                // 0000000434A8: D762404F 0002A8FF 000000FF
	v_lshlrev_b16 v11.h, 8, v83.l op_sel:[0,0,1]               // 0000000434B4: D738400B 0002A688
	v_mov_b16_e32 v85.l, v97.l                                 // 0000000434BC: 7EAA3961
	v_xor_b32_e32 v8, v8, v94                                  // 0000000434C0: 3A10BD08
	v_mov_b16_e32 v85.h, v78.l                                 // 0000000434C4: 7FAA394E
	v_sub_nc_i16 v83.l, v3.h, v83.h op_sel:[1,1,0] clamp       // 0000000434C8: D70E9853 0002A703
	v_or_b16 v78.h, v9.h, v11.h op_sel:[1,1,1]                 // 0000000434D0: D763584E 00021709
	v_lshlrev_b16 v80.h, 8, v85.l op_sel:[0,0,1]               // 0000000434D8: D7384050 0002AA88
	v_sub_nc_i16 v4.l, v4.l, v4.h op_sel:[0,1,0] clamp         // 0000000434E0: D70E9004 00020904
	v_and_b16 v3.h, 0xff00, v8.l op_sel:[0,0,1]                // 0000000434E8: D7624003 000210FF FFFFFF00
	v_lshl_or_b32 v86, v89, 16, v86                            // 0000000434F4: D6560056 05592159
	v_perm_b32 v89, v93, v92, 0xc0c0105                        // 0000000434FC: D6440059 03FEB95D 0C0C0105
	v_or_b16 v85.l, v79.h, v80.h op_sel:[1,1,0]                // 000000043508: D7631855 0002A14F
	v_perm_b32 v83, v4, v83, 0xc0c0105                         // 000000043510: D6440053 03FEA704 0C0C0105
	v_sub_nc_i16 v92.l, v3.h, v10.h op_sel:[1,1,0] clamp       // 00000004351C: D70E985C 00021503
	v_lshlrev_b16 v3.h, 8, v8.l op_sel:[0,0,1]                 // 000000043524: D7384003 00021088
	v_and_b16 v4.h, 0xff00, v8.h op_sel:[0,1,1]                // 00000004352C: D7625004 000210FF FFFFFF00
	v_or_b32_e32 v85, v85, v78                                 // 000000043538: 38AA9D55
	v_lshlrev_b16 v4.l, 8, v80.l                               // 00000004353C: D7380004 0002A088
	v_lshrrev_b32_e32 v1, 22, v1                               // 000000043544: 32020296
	v_mov_b16_e32 v97.h, v78.l                                 // 000000043548: 7FC2394E
	v_sub_nc_i16 v10.l, v4.h, v10.l op_sel:[1,0,0] clamp       // 00000004354C: D70E880A 00021504
	v_xor_b32_e32 v85, v7, v85                                 // 000000043554: 3AAAAB07
	v_lshlrev_b16 v7.l, 8, v8.h op_sel:[0,1,0]                 // 000000043558: D7381007 00021088
	v_lshrrev_b32_e32 v8, 22, v88                              // 000000043560: 3210B096
	v_and_b32_e32 v88, 0x80402010, v88                         // 000000043564: 36B0B0FF 80402010
	v_lshlrev_b16 v7.h, 8, v9.l op_sel:[0,0,1]                 // 00000004356C: D7384007 00021288
	v_sub_nc_i16 v9.l, v3.h, v4.l op_sel:[1,0,0] clamp         // 000000043574: D70E8809 00020903
	v_lshlrev_b16 v4.h, 8, v84.l op_sel:[0,0,1]                // 00000004357C: D7384004 0002A888
	v_bfe_i32 v8, v8, 0, 1                                     // 000000043584: D6110008 02050108
	v_lshrrev_b32_e32 v93, 24, v88                             // 00000004358C: 32BAB098
	v_lshrrev_b16 v4.l, 8, v88.l                               // 000000043590: D7390004 0002B088
	v_and_b32_e32 v95, 0x3fc, v1                               // 000000043598: 36BE02FF 000003FC
	v_sub_nc_i16 v80.l, v7.l, v7.h op_sel:[0,1,0] clamp        // 0000000435A0: D70E9050 00020F07
	v_mov_b16_e32 v7.l, v8.l                                   // 0000000435A8: 7E0E3908
	v_cmp_ne_u16_e32 vcc_lo, 0, v93.l                          // 0000000435AC: 7C7ABA80
	v_bfe_u32 v93, v12, 21, 8                                  // 0000000435B0: D610005D 02212B0C
	v_lshrrev_b16 v8.l, 4, v88.l                               // 0000000435B8: D7390008 0002B084
	v_and_b16 v3.h, 0xff00, v85.l op_sel:[0,0,1]               // 0000000435C0: D7624003 0002AAFF FFFFFF00
	v_and_b16 v1.h, 0xff, v7.l op_sel:[0,0,1]                  // 0000000435CC: D7624001 00020EFF 000000FF
	v_cndmask_b32_e64 v84, 0, -1, vcc_lo                       // 0000000435D8: D5010054 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.l                           // 0000000435E0: 7C7A0880
	v_bfe_i32 v8, v8, 0, 1                                     // 0000000435E4: D6110008 02050108
	v_sub_nc_i16 v94.l, v3.h, v80.h op_sel:[1,1,0] clamp       // 0000000435EC: D70E985E 0002A103
	v_lshlrev_b16 v3.h, 8, v85.l op_sel:[0,0,1]                // 0000000435F4: D7384003 0002AA88
	v_mov_b16_e32 v1.l, v84.l                                  // 0000000435FC: 7E023954
	v_bcnt_u32_b32 v84, v93, 0                                 // 000000043600: D71E0054 0001015D
	v_cndmask_b32_e64 v88, 0, -1, vcc_lo                       // 000000043608: D5010058 01A98280
	v_and_b16 v7.h, 0xff, v8.l op_sel:[0,0,1]                  // 000000043610: D7624007 000210FF 000000FF
	v_sub_nc_i16 v85.l, v3.h, v4.h op_sel:[1,1,0] clamp        // 00000004361C: D70E9855 00020903
	v_lshlrev_b16 v1.l, 8, v1.l                                // 000000043624: D7380001 00020288
	v_and_b32_e32 v84, 1, v84                                  // 00000004362C: 36A8A881
	v_mov_b16_e32 v4.l, v88.l                                  // 000000043630: 7E083958
	global_load_b32 v88, v95, s[10:11]                         // 000000043634: DC520000 580A005F
	v_lshlrev_b16 v4.h, 8, v79.l op_sel:[0,0,1]                // 00000004363C: D7384004 00029E88
	v_or_b16 v78.h, v1.h, v1.l op_sel:[1,0,1]                  // 000000043644: D763484E 00020301
	v_lshlrev_b32_e32 v84, 7, v84                              // 00000004364C: 30A8A887
	v_lshlrev_b16 v4.l, 8, v4.l                                // 000000043650: D7380004 00020888
	v_perm_b32 v9, v9, v92, 0xc0c0105                          // 000000043658: D6440009 03FEB909 0C0C0105
	v_perm_b32 v10, v80, v10, 0xc0c0105                        // 000000043664: D644000A 03FE1550 0C0C0105
	v_and_b32_e32 v95, 0xff, v2                                // 000000043670: 36BE04FF 000000FF
	v_xor_b32_e32 v84, v84, v93                                // 000000043678: 3AA8BB54
	v_or_b16 v97.l, v7.h, v4.l op_sel:[1,0,0]                  // 00000004367C: D7630861 00020907
	v_and_b16 v3.h, 0xff00, v85.h op_sel:[0,1,1]               // 000000043684: D7625003 0002AAFF FFFFFF00
	v_lshlrev_b16 v1.h, 8, v85.h op_sel:[0,1,1]                // 000000043690: D7385001 0002AA88
	v_lshl_or_b32 v83, v83, 16, v89                            // 000000043698: D6560053 05652153
	v_mul_lo_u32 v84, 0x1010101, v84                           // 0000000436A0: D72C0054 0002A8FF 01010101
	v_or_b32_e32 v79, v97, v78                                 // 0000000436AC: 389E9D61
	v_lshl_or_b32 v89, v10, 16, v9                             // 0000000436B0: D6560059 0425210A
	v_lshlrev_b32_e32 v93, 2, v95                              // 0000000436B8: 30BABE82
	v_sub_nc_i16 v95.l, v3.h, v11.h op_sel:[1,1,0] clamp       // 0000000436BC: D70E985F 00021703
	v_sub_nc_i16 v97.l, v1.h, v4.h op_sel:[1,1,0] clamp        // 0000000436C4: D70E9861 00020901
	v_xor_b32_e32 v79, v82, v79                                // 0000000436CC: 3A9E9F52
	v_perm_b32 v80, v85, v94, 0xc0c0105                        // 0000000436D0: D6440050 03FEBD55 0C0C0105
	v_and_b32_e32 v82, 0x8040201, v84                          // 0000000436DC: 36A4A8FF 08040201
	global_load_b32 v93, v93, s[10:11]                         // 0000000436E4: DC520000 5D0A005D
	v_perm_b32 v85, v97, v95, 0xc0c0105                        // 0000000436EC: D6440055 03FEBF61 0C0C0105
	v_and_b16 v1.h, 0xff00, v79.l op_sel:[0,0,1]               // 0000000436F8: D7624001 00029EFF FFFFFF00
	v_lshrrev_b32_e32 v10, 18, v84                             // 000000043704: 3214A892
	v_lshrrev_b32_e32 v9, 24, v82                              // 000000043708: 3212A498
	v_lshrrev_b16 v3.h, 8, v82.l op_sel:[0,0,1]                // 00000004370C: D7394003 0002A488
	v_lshl_or_b32 v85, v85, 16, v80                            // 000000043714: D6560055 05412155
	v_sub_nc_i16 v80.l, v1.h, v4.l op_sel:[1,0,0] clamp        // 00000004371C: D70E8850 00020901
	v_lshlrev_b16 v1.h, 8, v79.l op_sel:[0,0,1]                // 000000043724: D7384001 00029E88
	v_cmp_ne_u16_e32 vcc_lo, 0, v9.l                           // 00000004372C: 7C7A1280
	v_lshlrev_b16 v4.l, 8, v8.l                                // 000000043730: D7380004 00021088
	v_bfe_i32 v8, v10, 0, 1                                    // 000000043738: D6110008 0205010A
	v_bfe_i32 v10, v84, 0, 1                                   // 000000043740: D611000A 02050154
	v_and_b32_e32 v92, 0x80402010, v84                         // 000000043748: 36B8A8FF 80402010
	v_cndmask_b32_e64 v9, 0, -1, vcc_lo                        // 000000043750: D5010009 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v3.h                           // 000000043758: 7C7B0680
	v_sub_nc_i16 v79.l, v1.h, v4.l op_sel:[1,0,0] clamp        // 00000004375C: D70E884F 00020901
	v_and_b16 v1.h, 0xff, v8.l op_sel:[0,0,1]                  // 000000043764: D7624001 000210FF 000000FF
	v_and_b16 v4.h, 0xff, v10.l op_sel:[0,0,1]                 // 000000043770: D7624004 000214FF 000000FF
	v_lshlrev_b16 v3.h, 8, v9.l op_sel:[0,0,1]                 // 00000004377C: D7384003 00021288
	v_cndmask_b32_e64 v82, 0, -1, vcc_lo                       // 000000043784: D5010052 01A98280
	v_lshrrev_b32_e32 v9, 6, v2                                // 00000004378C: 32120486
	v_and_b16 v7.h, 0xff00, v79.h op_sel:[0,1,1]               // 000000043790: D7625007 00029EFF FFFFFF00
	v_lshlrev_b16 v10.l, 8, v10.l                              // 00000004379C: D738000A 00021488
	v_or_b16 v78.h, v1.h, v3.h op_sel:[1,1,1]                  // 0000000437A4: D763584E 00020701
	v_mov_b16_e32 v4.l, v82.l                                  // 0000000437AC: 7E083952
	v_perm_b32 v82, v79, v80, 0xc0c0105                        // 0000000437B0: D6440052 03FEA14F 0C0C0105
	v_and_b32_e32 v9, 0x3fc, v9                                // 0000000437BC: 361212FF 000003FC
	v_mov_b16_e32 v80.h, v78.l                                 // 0000000437C4: 7FA0394E
	v_lshlrev_b16 v1.h, 8, v79.h op_sel:[0,1,1]                // 0000000437C8: D7385001 00029E88
	v_lshlrev_b16 v4.l, 8, v4.l                                // 0000000437D0: D7380004 00020888
	v_lshrrev_b32_e32 v79, 24, v92                             // 0000000437D8: 329EB898
	global_load_b32 v94, v9, s[10:11]                          // 0000000437DC: DC520000 5E0A0009
	v_lshrrev_b32_e32 v12, 28, v12                             // 0000000437E4: 3218189C
	v_or_b16 v80.l, v4.h, v4.l op_sel:[1,0,0]                  // 0000000437E8: D7630850 00020904
	v_lshlrev_b16 v4.h, 8, v7.l op_sel:[0,0,1]                 // 0000000437F0: D7384004 00020E88
	v_lshrrev_b16 v7.l, 8, v92.l                               // 0000000437F8: D7390007 0002B888
	v_cmp_ne_u16_e32 vcc_lo, 0, v79.l                          // 000000043800: 7C7A9E80
	s_delay_alu instid0(VALU_DEP_4)                            // 000000043804: BF870004
	v_or_b32_e32 v9, v80, v78                                  // 000000043808: 38129D50
	v_lshrrev_b32_e32 v80, 22, v84                             // 00000004380C: 32A0A896
	v_sub_nc_i16 v84.l, v7.h, v1.l op_sel:[1,0,0] clamp        // 000000043810: D70E8854 00020307
	v_cndmask_b32_e64 v79, 0, -1, vcc_lo                       // 000000043818: D501004F 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v7.l                           // 000000043820: 7C7A0E80
	v_xor_b32_e32 v81, v81, v9                                 // 000000043824: 3AA21351
	v_lshrrev_b16 v9.l, 4, v92.l                               // 000000043828: D7390009 0002B884
	v_bfe_i32 v80, v80, 0, 1                                   // 000000043830: D6110050 02050150
	v_cndmask_b32_e64 v92, 0, -1, vcc_lo                       // 000000043838: D501005C 01A98280
	v_and_b32_e32 v97, 0xff, v5                                // 000000043840: 36C20AFF 000000FF
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 000000043848: BF870214
	v_bfe_i32 v95, v9, 0, 1                                    // 00000004384C: D611005F 02050109
	v_mov_b16_e32 v7.l, v80.l                                  // 000000043854: 7E0E3950
	v_mov_b16_e32 v9.l, v79.l                                  // 000000043858: 7E12394F
	v_mov_b16_e32 v79.l, v92.l                                 // 00000004385C: 7E9E395C
	v_bcnt_u32_b32 v92, v97, 0                                 // 000000043860: D71E005C 00010161
	v_mov_b16_e32 v80.l, v95.l                                 // 000000043868: 7EA0395F
	v_and_b16 v7.h, 0xff, v7.l op_sel:[0,0,1]                  // 00000004386C: D7624007 00020EFF 000000FF
	v_lshlrev_b16 v8.h, 8, v9.l op_sel:[0,0,1]                 // 000000043878: D7384008 00021288
	v_lshlrev_b16 v9.l, 8, v79.l                               // 000000043880: D7380009 00029E88
	v_and_b32_e32 v79, 1, v92                                  // 000000043888: 369EB881
	v_and_b16 v9.h, 0xff, v80.l op_sel:[0,0,1]                 // 00000004388C: D7624009 0002A0FF 000000FF
	v_mov_b16_e32 v92.h, v78.l                                 // 000000043898: 7FB8394E
	v_or_b16 v78.h, v7.h, v8.h op_sel:[1,1,1]                  // 00000004389C: D763584E 00021107
	v_and_b16 v1.l, 0xff00, v81.l                              // 0000000438A4: D7620001 0002A2FF FFFFFF00
	v_lshlrev_b32_e32 v79, 7, v79                              // 0000000438B0: 309E9E87
	v_or_b16 v92.l, v9.h, v9.l op_sel:[1,0,0]                  // 0000000438B4: D763085C 00021309
	v_lshlrev_b16 v10.h, 8, v81.l op_sel:[0,0,1]               // 0000000438BC: D738400A 0002A288
	v_sub_nc_i16 v81.l, v1.h, v4.h op_sel:[1,1,0] clamp        // 0000000438C4: D70E9851 00020901
	v_sub_nc_i16 v95.l, v1.l, v4.l clamp                       // 0000000438CC: D70E805F 00020901
	v_xor_b32_e32 v79, v79, v97                                // 0000000438D4: 3A9EC34F
	v_or_b32_e32 v92, v92, v78                                 // 0000000438D8: 38B89D5C
	v_and_b16 v1.l, 0xff00, v81.h op_sel:[0,1,0]               // 0000000438DC: D7621001 0002A2FF FFFFFF00
	v_lshlrev_b16 v4.l, 8, v8.l                                // 0000000438E8: D7380004 00021088
	v_sub_nc_i16 v10.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 0000000438F0: D70E880A 0002150A
	v_lshlrev_b16 v1.h, 8, v81.h op_sel:[0,1,1]                // 0000000438F8: D7385001 0002A288
	v_xor_b32_e32 v6, v6, v92                                  // 000000043900: 3A0CB906
	v_mul_lo_u32 v92, 0x1010101, v79                           // 000000043904: D72C005C 00029EFF 01010101
	v_sub_nc_i16 v8.l, v1.l, v3.h op_sel:[0,1,0] clamp         // 000000043910: D70E9008 00020701
	v_perm_b32 v81, v81, v84, 0xc0c0105                        // 000000043918: D6440051 03FEA951 0C0C0105
	v_perm_b32 v84, v10, v95, 0xc0c0105                        // 000000043924: D6440054 03FEBF0A 0C0C0105
	v_and_b16 v1.l, 0xff00, v6.l                               // 000000043930: D7620001 00020CFF FFFFFF00
	v_sub_nc_i16 v4.l, v1.h, v4.l op_sel:[1,0,0] clamp         // 00000004393C: D70E8804 00020901
	v_lshrrev_b32_e32 v10, 14, v2                              // 000000043944: 3214048E
	v_lshrrev_b32_e32 v2, 22, v2                               // 000000043948: 32040496
	v_and_b32_e32 v79, 0x8040201, v92                          // 00000004394C: 369EB8FF 08040201
	v_sub_nc_i16 v97.l, v1.l, v9.l clamp                       // 000000043954: D70E8061 00021301
	v_perm_b32 v95, v4, v8, 0xc0c0105                          // 00000004395C: D644005F 03FE1104 0C0C0105
	v_and_b32_e32 v4, 0x3fc, v10                               // 000000043968: 360814FF 000003FC
	v_lshrrev_b32_e32 v10, 18, v92                             // 000000043970: 3214B892
	v_lshrrev_b32_e32 v9, 24, v79                              // 000000043974: 32129E98
	v_lshrrev_b16 v1.l, 8, v79.l                               // 000000043978: D7390001 00029E88
	v_and_b32_e32 v2, 0x3fc, v2                                // 000000043980: 360404FF 000003FC
	global_load_b32 v98, v4, s[10:11]                          // 000000043988: DC520000 620A0004
	v_lshlrev_b16 v1.h, 8, v6.l op_sel:[0,0,1]                 // 000000043990: D7384001 00020C88
	v_cmp_ne_u16_e32 vcc_lo, 0, v9.l                           // 000000043998: 7C7A1280
	v_lshlrev_b16 v3.h, 8, v80.l op_sel:[0,0,1]                // 00000004399C: D7384003 0002A088
	global_load_b32 v100, v2, s[10:11]                         // 0000000439A4: DC520000 640A0002
	v_bfe_i32 v4, v10, 0, 1                                    // 0000000439AC: D6110004 0205010A
	v_bfe_i32 v10, v92, 0, 1                                   // 0000000439B4: D611000A 0205015C
	v_cndmask_b32_e64 v9, 0, -1, vcc_lo                        // 0000000439BC: D5010009 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v1.l                           // 0000000439C4: 7C7A0280
	v_and_b16 v1.l, 0xff00, v6.h op_sel:[0,1,0]                // 0000000439C8: D7621001 00020CFF FFFFFF00
	v_mov_b16_e32 v2.l, v4.l                                   // 0000000439D4: 7E043904
	v_mov_b16_e32 v6.l, v10.l                                  // 0000000439D8: 7E0C390A
	v_mov_b16_e32 v4.l, v9.l                                   // 0000000439DC: 7E083909
	v_cndmask_b32_e64 v79, 0, -1, vcc_lo                       // 0000000439E0: D501004F 01A98280
	s_mul_i32 s10, s14, s17                                    // 0000000439E8: 960A110E
	v_sub_nc_i16 v99.l, v1.h, v3.h op_sel:[1,1,0] clamp        // 0000000439EC: D70E9863 00020701
	v_sub_nc_i16 v101.l, v1.l, v8.h op_sel:[0,1,0] clamp       // 0000000439F4: D70E9065 00021101
	v_and_b16 v1.l, 0xff, v2.l                                 // 0000000439FC: D7620001 000204FF 000000FF
	v_mov_b16_e32 v8.l, v79.l                                  // 000000043A08: 7E10394F
	v_lshlrev_b16 v1.h, 8, v4.l op_sel:[0,0,1]                 // 000000043A0C: D7384001 00020888
	v_and_b16 v2.h, 0xff, v6.l op_sel:[0,0,1]                  // 000000043A14: D7624002 00020CFF 000000FF
	s_ashr_i32 s11, s10, 31                                    // 000000043A20: 860B9F0A
	v_lshlrev_b16 v4.h, 8, v7.l op_sel:[0,0,1]                 // 000000043A24: D7384004 00020E88
	v_lshlrev_b16 v3.h, 8, v8.l op_sel:[0,0,1]                 // 000000043A2C: D7384003 00021088
	s_lshl_b64 s[10:11], s[10:11], 2                           // 000000043A34: 848A820A
	v_or_b16 v78.h, v1.l, v1.h op_sel:[0,1,1]                  // 000000043A38: D763504E 00020301
	v_mov_b16_e32 v9.h, v78.l                                  // 000000043A40: 7F12394E
	v_add_co_u32 v7, vcc_lo, v51, s10                          // 000000043A44: D7006A07 00001533
	v_or_b16 v9.l, v2.h, v3.h op_sel:[1,1,0]                   // 000000043A4C: D7631809 00020702
	v_add_co_ci_u32_e64 v8, null, s11, v52, vcc_lo             // 000000043A54: D5207C08 01AA680B
	v_lshlrev_b16 v4.l, 8, v6.h op_sel:[0,1,0]                 // 000000043A5C: D7381004 00020C88
	s_mov_b32 s10, -8                                          // 000000043A64: BE8A00C8
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 000000043A68: BF8700A3
	v_or_b32_e32 v102, v9, v78                                 // 000000043A6C: 38CC9D09
	v_add_co_u32 v9, vcc_lo, 0x1000, v7                        // 000000043A70: D7006A09 00020EFF 00001000
	v_add_co_ci_u32_e64 v10, null, 0, v8, vcc_lo               // 000000043A7C: D5207C0A 01AA1080
	v_add_co_u32 v79, vcc_lo, v7, 0x2000                       // 000000043A84: D7006A4F 0001FF07 00002000
	s_delay_alu instid0(VALU_DEP_1)                            // 000000043A90: BF870001
	v_add_co_ci_u32_e64 v80, null, 0, v8, vcc_lo               // 000000043A94: D5207C50 01AA1080
	s_clause 0x8                                               // 000000043A9C: BF850008
	global_load_b32 v103, v[7:8], off                          // 000000043AA0: DC520000 677C0007
	global_load_b32 v104, v[7:8], off offset:1024              // 000000043AA8: DC520400 687C0007
	global_load_b32 v105, v[7:8], off offset:2048              // 000000043AB0: DC520800 697C0007
	global_load_b32 v106, v[7:8], off offset:3072              // 000000043AB8: DC520C00 6A7C0007
	global_load_b32 v107, v[79:80], off offset:-4096           // 000000043AC0: DC521000 6B7C004F
	global_load_b32 v108, v[9:10], off offset:1024             // 000000043AC8: DC520400 6C7C0009
	global_load_b32 v109, v[9:10], off offset:2048             // 000000043AD0: DC520800 6D7C0009
	global_load_b32 v110, v[9:10], off offset:3072             // 000000043AD8: DC520C00 6E7C0009
	global_load_b32 v79, v[79:80], off                         // 000000043AE0: DC520000 4F7C004F
	v_sub_nc_i16 v1.l, v4.l, v4.h op_sel:[0,1,0] clamp         // 000000043AE8: D70E9001 00020904
	v_perm_b32 v9, v99, v97, 0xc0c0105                         // 000000043AF0: D6440009 03FEC363 0C0C0105
	v_lshl_or_b32 v7, v81, 16, v82                             // 000000043AFC: D6560007 05492151
	v_lshl_or_b32 v8, v95, 16, v84                             // 000000043B04: D6560008 0551215F
	v_cvt_f32_f16_e32 v80, v11.l                               // 000000043B0C: 7EA0170B
	v_perm_b32 v10, v1, v101, 0xc0c0105                        // 000000043B10: D644000A 03FECB01 0C0C0105
	s_waitcnt vmcnt(16)                                        // 000000043B1C: BF8943F7
	v_xor_b32_e32 v4, v90, v102                                // 000000043B20: 3A08CD5A
	s_delay_alu instid0(VALU_DEP_1)                            // 000000043B24: BF870001
	v_and_b16 v1.l, 0xff00, v4.l                               // 000000043B28: D7620001 000208FF FFFFFF00
	v_lshlrev_b16 v2.h, 8, v4.l op_sel:[0,0,1]                 // 000000043B34: D7384002 00020888
	v_lshlrev_b16 v4.l, 8, v6.l                                // 000000043B3C: D7380004 00020C88
	v_lshl_or_b32 v6, v10, 16, v9                              // 000000043B44: D6560006 0425210A
	v_bfe_u32 v9, v5, 7, 8                                     // 000000043B4C: D6100009 02210F05
	ds_store_2addr_b32 v70, v87, v86 offset1:1                 // 000000043B54: D8380100 00565746
	ds_store_2addr_b32 v71, v83, v89 offset1:1                 // 000000043B5C: D8380100 00595347
	ds_store_2addr_b32 v72, v85, v7 offset1:1                  // 000000043B64: D8380100 00075548
	ds_store_2addr_b32 v73, v8, v6 offset1:1                   // 000000043B6C: D8380100 00060849
	v_and_b32_e32 v7, 0x80402010, v92                          // 000000043B74: 360EB8FF 80402010
	v_cvt_f32_ubyte0_e32 v10, v12                              // 000000043B7C: 7E14230C
	v_mul_f32_e32 v12, 0.5, v80                                // 000000043B80: 1018A0F0
	v_bcnt_u32_b32 v81, v9, 0                                  // 000000043B84: D71E0051 00010109
	v_sub_nc_i16 v80.l, v1.l, v3.h op_sel:[0,1,0] clamp        // 000000043B8C: D70E9050 00020701
	v_lshrrev_b32_e32 v8, 24, v7                               // 000000043B94: 32100E98
	v_sub_nc_i16 v4.l, v2.h, v4.l op_sel:[1,0,0] clamp         // 000000043B98: D70E8804 00020902
	v_and_b16 v1.l, 0xff00, v4.h op_sel:[0,1,0]                // 000000043BA0: D7621001 000208FF FFFFFF00
	v_and_b32_e32 v6, 1, v81                                   // 000000043BAC: 360CA281
	v_lshrrev_b16 v2.h, 8, v7.l op_sel:[0,0,1]                 // 000000043BB0: D7394002 00020E88
	v_cmp_ne_u16_e32 vcc_lo, 0, v8.l                           // 000000043BB8: 7C7A1080
	v_fma_mix_f32 v10, v10, v11, v12 op_sel_hi:[0,1,0]         // 000000043BBC: CC20000A 1432170A
	v_perm_b32 v11, v4, v80, 0xc0c0105                         // 000000043BC4: D644000B 03FEA104 0C0C0105
	v_lshlrev_b32_e32 v6, 7, v6                                // 000000043BD0: 300C0C87
	v_sub_nc_i16 v80.l, v1.l, v1.h op_sel:[0,1,0] clamp        // 000000043BD4: D70E9050 00020301
	v_lshrrev_b32_e32 v12, 22, v92                             // 000000043BDC: 3218B896
	v_lshrrev_b16 v4.l, 4, v7.l                                // 000000043BE0: D7390004 00020E84
	v_cndmask_b32_e64 v7, 0, -1, vcc_lo                        // 000000043BE8: D5010007 01A98280
	v_xor_b32_e32 v1, v6, v9                                   // 000000043BF0: 3A021306
	v_cmp_ne_u16_e32 vcc_lo, 0, v2.h                           // 000000043BF4: 7C7B0480
	v_bfe_i32 v6, v12, 0, 1                                    // 000000043BF8: D6110006 0205010C
	v_bfe_i32 v12, v4, 0, 1                                    // 000000043C00: D611000C 02050104
	v_mov_b16_e32 v6.h, v78.l                                  // 000000043C08: 7F0C394E
	v_mul_lo_u32 v9, 0x1010101, v1                             // 000000043C0C: D72C0009 000202FF 01010101
	v_cndmask_b32_e64 v8, 0, -1, vcc_lo                        // 000000043C18: D5010008 01A98280
	v_mov_b16_e32 v4.l, v6.l                                   // 000000043C20: 7E083906
	v_mov_b16_e32 v6.l, v7.l                                   // 000000043C24: 7E0C3907
	v_lshlrev_b16 v1.l, 8, v4.h op_sel:[0,1,0]                 // 000000043C28: D7381001 00020888
	v_lshlrev_b16 v1.h, 8, v2.l op_sel:[0,0,1]                 // 000000043C30: D7384001 00020488
	v_mov_b16_e32 v7.l, v8.l                                   // 000000043C38: 7E0E3908
	v_mov_b16_e32 v2.l, v12.l                                  // 000000043C3C: 7E04390C
	v_and_b32_e32 v8, 0x8040201, v9                            // 000000043C40: 361012FF 08040201
	v_and_b16 v2.h, 0xff, v4.l op_sel:[0,0,1]                  // 000000043C48: D7624002 000208FF 000000FF
	v_sub_nc_i16 v12.l, v1.l, v1.h op_sel:[0,1,0] clamp        // 000000043C54: D70E900C 00020301
	v_lshlrev_b16 v4.h, 8, v7.l op_sel:[0,0,1]                 // 000000043C5C: D7384004 00020E88
	v_lshlrev_b16 v3.h, 8, v6.l op_sel:[0,0,1]                 // 000000043C64: D7384003 00020C88
	v_lshrrev_b32_e32 v7, 24, v8                               // 000000043C6C: 320E1098
	v_lshrrev_b16 v1.l, 8, v8.l                                // 000000043C70: D7390001 00021088
	v_and_b16 v6.l, 0xff, v2.l                                 // 000000043C78: D7620006 000204FF 000000FF
	v_lshrrev_b32_e32 v81, 18, v9                              // 000000043C84: 32A21292
	v_or_b16 v78.h, v2.h, v3.h op_sel:[1,1,1]                  // 000000043C88: D763584E 00020702
	v_cmp_ne_u16_e32 vcc_lo, 0, v7.l                           // 000000043C90: 7C7A0E80
	v_perm_b32 v12, v12, v80, 0xc0c0105                        // 000000043C94: D644000C 03FEA10C 0C0C0105
	v_or_b16 v6.l, v6.l, v4.h op_sel:[0,1,0]                   // 000000043CA0: D7631006 00020906
	v_bfe_i32 v8, v81, 0, 1                                    // 000000043CA8: D6110008 02050151
	v_bfe_i32 v81, v9, 0, 1                                    // 000000043CB0: D6110051 02050109
	v_cndmask_b32_e64 v7, 0, -1, vcc_lo                        // 000000043CB8: D5010007 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v1.l                           // 000000043CC0: 7C7A0280
	v_or_b32_e32 v83, v6, v78                                  // 000000043CC4: 38A69D06
	v_mov_b16_e32 v1.l, v8.l                                   // 000000043CC8: 7E023908
	v_mov_b16_e32 v80.h, v78.l                                 // 000000043CCC: 7FA0394E
	v_mov_b16_e32 v6.l, v7.l                                   // 000000043CD0: 7E0C3907
	v_cndmask_b32_e64 v82, 0, -1, vcc_lo                       // 000000043CD4: D5010052 01A98280
	v_mov_b16_e32 v7.l, v81.l                                  // 000000043CDC: 7E0E3951
	v_and_b16 v1.h, 0xff, v1.l op_sel:[0,0,1]                  // 000000043CE0: D7624001 000202FF 000000FF
	v_lshl_or_b32 v12, v12, 16, v11                            // 000000043CEC: D656000C 042D210C
	v_lshlrev_b16 v2.h, 8, v6.l op_sel:[0,0,1]                 // 000000043CF4: D7384002 00020C88
	v_mov_b16_e32 v8.l, v82.l                                  // 000000043CFC: 7E103952
	s_waitcnt vmcnt(15)                                        // 000000043D00: BF893FF7
	v_xor_b32_e32 v81, v91, v83                                // 000000043D04: 3AA2A75B
	v_and_b16 v6.l, 0xff, v7.l                                 // 000000043D08: D7620006 00020EFF 000000FF
	v_bfe_u32 v82, v5, 14, 8                                   // 000000043D14: D6100052 02211D05
	v_or_b16 v78.h, v1.h, v2.h op_sel:[1,1,1]                  // 000000043D1C: D763584E 00020501
	v_lshlrev_b16 v6.h, 8, v8.l op_sel:[0,0,1]                 // 000000043D24: D7384006 00021088
	v_and_b16 v7.h, 0xff00, v81.l op_sel:[0,0,1]               // 000000043D2C: D7624007 0002A2FF FFFFFF00
	v_lshlrev_b16 v8.l, 8, v81.l                               // 000000043D38: D7380008 0002A288
	v_lshlrev_b16 v1.h, 8, v2.l op_sel:[0,0,1]                 // 000000043D40: D7384001 00020488
	v_and_b16 v2.l, 0xff00, v81.h op_sel:[0,1,0]               // 000000043D48: D7621002 0002A2FF FFFFFF00
	v_or_b16 v80.l, v6.l, v6.h op_sel:[0,1,0]                  // 000000043D54: D7631050 00020D06
	v_sub_nc_i16 v81.l, v7.h, v4.h op_sel:[1,1,0] clamp        // 000000043D5C: D70E9851 00020907
	v_lshlrev_b16 v6.l, 8, v81.h op_sel:[0,1,0]                // 000000043D64: D7381006 0002A288
	v_sub_nc_i16 v8.l, v8.l, v1.h op_sel:[0,1,0] clamp         // 000000043D6C: D70E9008 00020308
	v_lshlrev_b16 v4.l, 8, v4.l                                // 000000043D74: D7380004 00020888
	v_or_b32_e32 v80, v80, v78                                 // 000000043D7C: 38A09D50
	v_sub_nc_i16 v2.l, v2.l, v3.h op_sel:[0,1,0] clamp         // 000000043D80: D70E9002 00020702
	v_lshlrev_b16 v3.h, 8, v7.l op_sel:[0,0,1]                 // 000000043D88: D7384003 00020E88
	v_perm_b32 v11, v8, v81, 0xc0c0105                         // 000000043D90: D644000B 03FEA308 0C0C0105
	v_bcnt_u32_b32 v8, v82, 0                                  // 000000043D9C: D71E0008 00010152
	s_waitcnt vmcnt(14)                                        // 000000043DA4: BF893BF7
	v_xor_b32_e32 v80, v96, v80                                // 000000043DA8: 3AA0A160
	v_sub_nc_i16 v4.l, v6.l, v4.l clamp                        // 000000043DAC: D70E8004 00020906
	v_mul_f32_e32 v83, 0.5, v10                                // 000000043DB4: 10A614F0
	v_lshlrev_b16 v1.l, 8, v1.l                                // 000000043DB8: D7380001 00020288
	v_and_b32_e32 v7, 1, v8                                    // 000000043DC0: 360E1081
	v_and_b16 v1.h, 0xff00, v80.l op_sel:[0,0,1]               // 000000043DC4: D7624001 0002A0FF FFFFFF00
	v_and_b32_e32 v8, 0x80402010, v9                           // 000000043DD0: 361012FF 80402010
	v_perm_b32 v81, v4, v2, 0xc0c0105                          // 000000043DD8: D6440051 03FE0504 0C0C0105
	v_lshlrev_b16 v2.l, 8, v80.l                               // 000000043DE4: D7380002 0002A088
	v_and_b16 v4.l, 0xff00, v80.h op_sel:[0,1,0]               // 000000043DEC: D7621004 0002A0FF FFFFFF00
	v_sub_nc_i16 v10.l, v1.h, v6.h op_sel:[1,1,0] clamp        // 000000043DF8: D70E980A 00020D01
	v_lshlrev_b32_e32 v6, 7, v7                                // 000000043E00: 300C0E87
	v_lshrrev_b32_e32 v7, 24, v8                               // 000000043E04: 320E1098
	v_lshrrev_b16 v1.h, 8, v8.l op_sel:[0,0,1]                 // 000000043E08: D7394001 00021088
	v_sub_nc_i16 v80.l, v2.l, v3.h op_sel:[0,1,0] clamp        // 000000043E10: D70E9050 00020702
	v_sub_nc_i16 v84.l, v4.l, v2.h op_sel:[0,1,0] clamp        // 000000043E18: D70E9054 00020504
	v_xor_b32_e32 v2, v6, v82                                  // 000000043E20: 3A04A506
	v_cmp_ne_u16_e32 vcc_lo, 0, v7.l                           // 000000043E24: 7C7A0E80
	v_lshrrev_b32_e32 v9, 22, v9                               // 000000043E28: 32121296
	v_lshrrev_b16 v4.l, 4, v8.l                                // 000000043E2C: D7390004 00021084
	v_lshl_or_b32 v81, v81, 16, v11                            // 000000043E34: D6560051 042D2151
	v_mul_lo_u32 v82, 0x1010101, v2                            // 000000043E3C: D72C0052 000204FF 01010101
	v_cndmask_b32_e64 v7, 0, -1, vcc_lo                        // 000000043E48: D5010007 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v1.h                           // 000000043E50: 7C7B0280
	v_bfe_i32 v6, v9, 0, 1                                     // 000000043E54: D6110006 02050109
	v_bfe_i32 v9, v4, 0, 1                                     // 000000043E5C: D6110009 02050104
	v_lshlrev_b16 v1.h, 8, v80.h op_sel:[0,1,1]                // 000000043E64: D7385001 0002A088
	v_mov_b16_e32 v4.l, v7.l                                   // 000000043E6C: 7E083907
	v_cndmask_b32_e64 v8, 0, -1, vcc_lo                        // 000000043E70: D5010008 01A98280
	v_mov_b16_e32 v2.l, v6.l                                   // 000000043E78: 7E043906
	v_mov_b16_e32 v7.l, v9.l                                   // 000000043E7C: 7E0E3909
	v_sub_nc_i16 v85.l, v1.h, v1.l op_sel:[1,0,0] clamp        // 000000043E80: D70E8855 00020301
	v_lshlrev_b16 v3.h, 8, v4.l op_sel:[0,0,1]                 // 000000043E88: D7384003 00020888
	v_mov_b16_e32 v6.l, v8.l                                   // 000000043E90: 7E0C3908
	v_and_b32_e32 v8, 0x8040201, v82                           // 000000043E94: 3610A4FF 08040201
	v_and_b16 v2.h, 0xff, v2.l op_sel:[0,0,1]                  // 000000043E9C: D7624002 000204FF 000000FF
	v_and_b16 v4.h, 0xff, v7.l op_sel:[0,0,1]                  // 000000043EA8: D7624004 00020EFF 000000FF
	v_lshrrev_b32_e32 v9, 18, v82                              // 000000043EB4: 3212A492
	v_lshlrev_b16 v4.l, 8, v6.l                                // 000000043EB8: D7380004 00020C88
	v_lshrrev_b32_e32 v6, 24, v8                               // 000000043EC0: 320C1098
	v_lshrrev_b16 v1.l, 8, v8.l                                // 000000043EC4: D7390001 00021088
	v_or_b16 v78.h, v2.h, v3.h op_sel:[1,1,1]                  // 000000043ECC: D763584E 00020702
	v_mov_b16_e32 v8.h, v78.l                                  // 000000043ED4: 7F10394E
	v_or_b16 v8.l, v4.h, v4.l op_sel:[1,0,0]                   // 000000043ED8: D7630808 00020904
	v_cmp_ne_u16_e32 vcc_lo, 0, v6.l                           // 000000043EE0: 7C7A0C80
	v_bfe_i32 v9, v9, 0, 1                                     // 000000043EE4: D6110009 02050109
	v_bfe_i32 v86, v82, 0, 1                                   // 000000043EEC: D6110056 02050152
	v_lshlrev_b16 v7.l, 8, v7.l                                // 000000043EF4: D7380007 00020E88
	v_or_b32_e32 v89, v8, v78                                  // 000000043EFC: 38B29D08
	v_cndmask_b32_e64 v6, 0, -1, vcc_lo                        // 000000043F00: D5010006 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v1.l                           // 000000043F08: 7C7A0280
	v_mov_b16_e32 v1.l, v9.l                                   // 000000043F0C: 7E023909
	v_mov_b16_e32 v8.l, v86.l                                  // 000000043F10: 7E103956
	v_mov_b16_e32 v9.h, v78.l                                  // 000000043F14: 7F12394E
	v_lshlrev_b16 v2.h, 8, v6.l op_sel:[0,0,1]                 // 000000043F18: D7384002 00020C88
	v_cndmask_b32_e64 v87, 0, -1, vcc_lo                       // 000000043F20: D5010057 01A98280
	v_and_b16 v1.h, 0xff, v1.l op_sel:[0,0,1]                  // 000000043F28: D7624001 000202FF 000000FF
	v_and_b16 v4.h, 0xff, v8.l op_sel:[0,0,1]                  // 000000043F34: D7624004 000210FF 000000FF
	v_perm_b32 v80, v80, v10, 0xc0c0105                        // 000000043F40: D6440050 03FE1550 0C0C0105
	v_and_b32_e32 v10, 0x80402010, v82                         // 000000043F4C: 3614A4FF 80402010
	v_mov_b16_e32 v9.l, v87.l                                  // 000000043F54: 7E123957
	s_waitcnt vmcnt(13)                                        // 000000043F58: BF8937F7
	v_xor_b32_e32 v86, v88, v89                                // 000000043F5C: 3AACB358
	v_or_b16 v78.h, v1.h, v2.h op_sel:[1,1,1]                  // 000000043F60: D763584E 00020501
	v_lshlrev_b16 v2.l, 8, v2.l                                // 000000043F68: D7380002 00020488
	v_perm_b32 v84, v85, v84, 0xc0c0105                        // 000000043F70: D6440054 03FEA955 0C0C0105
	v_lshlrev_b16 v6.l, 8, v9.l                                // 000000043F7C: D7380006 00021288
	v_and_b16 v6.h, 0xff00, v86.l op_sel:[0,0,1]               // 000000043F84: D7624006 0002ACFF FFFFFF00
	v_lshlrev_b16 v7.h, 8, v86.l op_sel:[0,0,1]                // 000000043F90: D7384007 0002AC88
	v_and_b16 v1.h, 0xff00, v86.h op_sel:[0,1,1]               // 000000043F98: D7625001 0002ACFF FFFFFF00
	v_bfe_u32 v87, v5, 21, 8                                   // 000000043FA4: D6100057 02212B05
	v_or_b16 v9.l, v4.h, v6.l op_sel:[1,0,0]                   // 000000043FAC: D7630809 00020D04
	v_lshlrev_b16 v4.h, 8, v86.h op_sel:[0,1,1]                // 000000043FB4: D7385004 0002AC88
	v_sub_nc_i16 v4.l, v6.h, v4.l op_sel:[1,0,0] clamp         // 000000043FBC: D70E8804 00020906
	v_sub_nc_i16 v7.l, v7.h, v7.l op_sel:[1,0,0] clamp         // 000000043FC4: D70E8807 00020F07
	v_sub_nc_i16 v86.l, v1.h, v3.h op_sel:[1,1,0] clamp        // 000000043FCC: D70E9856 00020701
	v_or_b32_e32 v9, v9, v78                                   // 000000043FD4: 38129D09
	v_sub_nc_i16 v2.l, v4.h, v2.l op_sel:[1,0,0] clamp         // 000000043FD8: D70E8802 00020504
	v_lshrrev_b32_e32 v82, 22, v82                             // 000000043FE0: 32A4A496
	v_perm_b32 v85, v7, v4, 0xc0c0105                          // 000000043FE4: D6440055 03FE0907 0C0C0105
	v_lshrrev_b32_e32 v7, 24, v10                              // 000000043FF0: 320E1498
	v_lshrrev_b16 v3.h, 8, v10.l op_sel:[0,0,1]                // 000000043FF4: D7394003 00021488
	v_lshlrev_b16 v4.l, 8, v8.l                                // 000000043FFC: D7380004 00021088
	v_bcnt_u32_b32 v8, v87, 0                                  // 000000044004: D71E0008 00010157
	s_waitcnt vmcnt(12)                                        // 00000004400C: BF8933F7
	v_xor_b32_e32 v9, v93, v9                                  // 000000044010: 3A12135D
	v_cmp_ne_u16_e32 vcc_lo, 0, v7.l                           // 000000044014: 7C7A0E80
	v_perm_b32 v86, v2, v86, 0xc0c0105                         // 000000044018: D6440056 03FEAD02 0C0C0105
	v_lshl_or_b32 v80, v84, 16, v80                            // 000000044024: D6560050 05412154
	v_and_b32_e32 v89, 1, v8                                   // 00000004402C: 36B21081
	v_and_b16 v1.h, 0xff00, v9.l op_sel:[0,0,1]                // 000000044030: D7624001 000212FF FFFFFF00
	v_lshlrev_b16 v2.l, 8, v9.l                                // 00000004403C: D7380002 00021288
	v_lshrrev_b16 v9.l, 4, v10.l                               // 000000044044: D7390009 00021484
	v_bfe_i32 v10, v82, 0, 1                                   // 00000004404C: D611000A 02050152
	v_cndmask_b32_e64 v82, 0, -1, vcc_lo                       // 000000044054: D5010052 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v3.h                           // 00000004405C: 7C7B0680
	v_sub_nc_i16 v6.l, v1.h, v6.l op_sel:[1,0,0] clamp         // 000000044060: D70E8806 00020D01
	v_bfe_i32 v90, v9, 0, 1                                    // 000000044068: D611005A 02050109
	v_mov_b16_e32 v7.l, v10.l                                  // 000000044070: 7E0E390A
	v_mov_b16_e32 v8.l, v82.l                                  // 000000044074: 7E103952
	v_cndmask_b32_e64 v88, 0, -1, vcc_lo                       // 000000044078: D5010058 01A98280
	v_lshlrev_b32_e32 v82, 7, v89                              // 000000044080: 30A4B287
	v_mov_b16_e32 v10.l, v90.l                                 // 000000044084: 7E14395A
	v_and_b16 v3.h, 0xff, v7.l op_sel:[0,0,1]                  // 000000044088: D7624003 00020EFF 000000FF
	v_lshlrev_b16 v4.h, 8, v8.l op_sel:[0,0,1]                 // 000000044094: D7384004 00021088
	v_mov_b16_e32 v9.l, v88.l                                  // 00000004409C: 7E123958
	v_xor_b32_e32 v8, v82, v87                                 // 0000000440A0: 3A10AF52
	v_and_b16 v7.h, 0xff, v10.l op_sel:[0,0,1]                 // 0000000440A4: D7624007 000214FF 000000FF
	v_mov_b16_e32 v82.h, v78.l                                 // 0000000440B0: 7FA4394E
	v_or_b16 v78.h, v3.h, v4.h op_sel:[1,1,1]                  // 0000000440B4: D763584E 00020903
	v_lshlrev_b16 v6.h, 8, v9.l op_sel:[0,0,1]                 // 0000000440BC: D7384006 00021288
	v_mul_lo_u32 v8, 0x1010101, v8                             // 0000000440C4: D72C0008 000210FF 01010101
	v_sub_nc_i16 v2.l, v2.l, v4.l clamp                        // 0000000440D0: D70E8002 00020902
	v_lshl_or_b32 v84, v86, 16, v85                            // 0000000440D8: D6560054 05552156
	v_and_b16 v1.h, 0xff00, v9.h op_sel:[0,1,1]                // 0000000440E0: D7625001 000212FF FFFFFF00
	v_or_b16 v82.l, v7.h, v6.h op_sel:[1,1,0]                  // 0000000440EC: D7631852 00020D07
	v_lshlrev_b16 v1.l, 8, v1.l                                // 0000000440F4: D7380001 00020288
	v_perm_b32 v85, v2, v6, 0xc0c0105                          // 0000000440FC: D6440055 03FE0D02 0C0C0105
	v_lshlrev_b16 v2.l, 8, v9.h op_sel:[0,1,0]                 // 000000044108: D7381002 00021288
	v_sub_nc_i16 v87.l, v1.h, v2.h op_sel:[1,1,0] clamp        // 000000044110: D70E9857 00020501
	v_or_b32_e32 v11, v82, v78                                 // 000000044118: 38169D52
	v_and_b32_e32 v82, 0x8040201, v8                           // 00000004411C: 36A410FF 08040201
	v_lshrrev_b32_e32 v86, 18, v8                              // 000000044124: 32AC1092
	v_sub_nc_i16 v88.l, v2.l, v1.l clamp                       // 000000044128: D70E8058 00020302
	v_lshlrev_b16 v2.l, 8, v10.l                               // 000000044130: D7380002 00021488
	s_waitcnt vmcnt(11)                                        // 000000044138: BF892FF7
	v_xor_b32_e32 v9, v94, v11                                 // 00000004413C: 3A12175E
	v_lshrrev_b32_e32 v11, 24, v82                             // 000000044140: 3216A498
	v_lshrrev_b16 v2.h, 8, v82.l op_sel:[0,0,1]                // 000000044144: D7394002 0002A488
	v_bfe_i32 v86, v86, 0, 1                                   // 00000004414C: D6110056 02050156
	v_mov_b16_e32 v90.h, v78.l                                 // 000000044154: 7FB4394E
	v_and_b16 v1.l, 0xff00, v9.l                               // 000000044158: D7620001 000212FF FFFFFF00
	v_cmp_ne_u16_e32 vcc_lo, 0, v11.l                          // 000000044164: 7C7A1680
	v_lshlrev_b16 v1.h, 8, v9.l op_sel:[0,0,1]                 // 000000044168: D7384001 00021288
	v_and_b32_e32 v11, 0x80402010, v8                          // 000000044170: 361610FF 80402010
	v_mov_b16_e32 v4.l, v86.l                                  // 000000044178: 7E083956
	v_sub_nc_i16 v82.l, v1.l, v6.h op_sel:[0,1,0] clamp        // 00000004417C: D70E9052 00020D01
	v_cndmask_b32_e64 v10, 0, -1, vcc_lo                       // 000000044184: D501000A 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v2.h                           // 00000004418C: 7C7B0480
	v_bfe_i32 v6, v8, 0, 1                                     // 000000044190: D6110006 02050108
	v_sub_nc_i16 v86.l, v1.h, v2.l op_sel:[1,0,0] clamp        // 000000044198: D70E8856 00020501
	v_lshrrev_b16 v3.h, 8, v11.l op_sel:[0,0,1]                // 0000000441A0: D7394003 00021688
	v_mov_b16_e32 v1.l, v10.l                                  // 0000000441A8: 7E02390A
	v_cndmask_b32_e64 v10, 0, -1, vcc_lo                       // 0000000441AC: D501000A 01A98280
	v_mov_b16_e32 v2.l, v6.l                                   // 0000000441B4: 7E043906
	v_lshrrev_b16 v9.l, 4, v11.l                               // 0000000441B8: D7390009 00021684
	v_and_b16 v1.h, 0xff, v4.l op_sel:[0,0,1]                  // 0000000441C0: D7624001 000208FF 000000FF
	v_lshlrev_b16 v1.l, 8, v1.l                                // 0000000441CC: D7380001 00020288
	v_mov_b16_e32 v6.l, v10.l                                  // 0000000441D4: 7E0C390A
	v_lshrrev_b32_e32 v10, 24, v11                             // 0000000441D8: 32141698
	v_lshrrev_b32_e32 v8, 22, v8                               // 0000000441DC: 32101096
	v_bfe_i32 v89, v9, 0, 1                                    // 0000000441E0: D6110059 02050109
	v_or_b16 v78.h, v1.h, v1.l op_sel:[1,0,1]                  // 0000000441E8: D763484E 00020301
	v_and_b16 v1.h, 0xff, v2.l op_sel:[0,0,1]                  // 0000000441F0: D7624001 000204FF 000000FF
	v_cmp_ne_u16_e32 vcc_lo, 0, v10.l                          // 0000000441FC: 7C7A1480
	v_lshlrev_b16 v6.l, 8, v6.l                                // 000000044200: D7380006 00020C88
	v_bfe_i32 v8, v8, 0, 1                                     // 000000044208: D6110008 02050108
	v_and_b16 v2.h, 0xff00, v9.h op_sel:[0,1,1]                // 000000044210: D7625002 000212FF FFFFFF00
	v_lshlrev_b16 v8.h, 8, v9.h op_sel:[0,1,1]                 // 00000004421C: D7385008 00021288
	v_cndmask_b32_e64 v10, 0, -1, vcc_lo                       // 000000044224: D501000A 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v3.h                           // 00000004422C: 7C7B0680
	v_or_b16 v90.l, v1.h, v6.l op_sel:[1,0,0]                  // 000000044230: D763085A 00020D01
	v_and_b16 v1.h, 0xff, v8.l op_sel:[0,0,1]                  // 000000044238: D7624001 000210FF 000000FF
	v_lshlrev_b16 v7.l, 8, v7.l                                // 000000044244: D7380007 00020E88
	v_mov_b16_e32 v9.l, v10.l                                  // 00000004424C: 7E12390A
	v_cndmask_b32_e64 v11, 0, -1, vcc_lo                       // 000000044250: D501000B 01A98280
	v_mov_b16_e32 v10.h, v78.l                                 // 000000044258: 7F14394E
	v_lshlrev_b16 v2.l, 8, v2.l                                // 00000004425C: D7380002 00020488
	v_sub_nc_i16 v7.l, v8.h, v7.l op_sel:[1,0,0] clamp         // 000000044264: D70E8807 00020F08
	v_lshlrev_b16 v3.h, 8, v9.l op_sel:[0,0,1]                 // 00000004426C: D7384003 00021288
	v_mov_b16_e32 v10.l, v11.l                                 // 000000044274: 7E14390B
	v_mov_b16_e32 v11.l, v89.l                                 // 000000044278: 7E163959
	v_or_b32_e32 v9, v90, v78                                  // 00000004427C: 38129D5A
	v_sub_nc_i16 v89.l, v2.h, v4.h op_sel:[1,1,0] clamp        // 000000044280: D70E9859 00020902
	v_or_b16 v78.h, v1.h, v3.h op_sel:[1,1,1]                  // 000000044288: D763584E 00020701
	v_lshlrev_b16 v6.h, 8, v10.l op_sel:[0,0,1]                // 000000044290: D7384006 00021488
	v_and_b16 v7.h, 0xff, v11.l op_sel:[0,0,1]                 // 000000044298: D7624007 000216FF 000000FF
	v_lshlrev_b16 v4.l, 8, v4.l                                // 0000000442A4: D7380004 00020888
	v_lshrrev_b32_e32 v5, 28, v5                               // 0000000442AC: 320A0A9C
	s_waitcnt vmcnt(10)                                        // 0000000442B0: BF892BF7
	v_xor_b32_e32 v9, v98, v9                                  // 0000000442B4: 3A121362
	v_perm_b32 v87, v88, v87, 0xc0c0105                        // 0000000442B8: D6440057 03FEAF58 0C0C0105
	v_or_b16 v10.l, v7.h, v6.h op_sel:[1,1,0]                  // 0000000442C4: D763180A 00020D07
	v_cvt_f32_ubyte0_e32 v5, v5                                // 0000000442CC: 7E0A2305
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_4)// 0000000442D0: BF870224
	v_and_b16 v1.h, 0xff00, v9.l op_sel:[0,0,1]                // 0000000442D4: D7624001 000212FF FFFFFF00
	v_lshlrev_b16 v2.h, 8, v9.l op_sel:[0,0,1]                 // 0000000442E0: D7384002 00021288
	v_or_b32_e32 v10, v10, v78                                 // 0000000442E8: 38149D0A
	v_perm_b32 v78, v86, v82, 0xc0c0105                        // 0000000442EC: D644004E 03FEA556 0C0C0105
	v_perm_b32 v82, v7, v89, 0xc0c0105                         // 0000000442F8: D6440052 03FEB307 0C0C0105
	v_and_b16 v4.h, 0xff00, v9.h op_sel:[0,1,1]                // 000000044304: D7625004 000212FF FFFFFF00
	v_lshlrev_b16 v7.l, 8, v9.h op_sel:[0,1,0]                 // 000000044310: D7381007 00021288
	s_waitcnt vmcnt(9)                                         // 000000044318: BF8927F7
	v_xor_b32_e32 v10, v100, v10                               // 00000004431C: 3A141564
	v_sub_nc_i16 v6.l, v1.h, v6.l op_sel:[1,0,0] clamp         // 000000044320: D70E8806 00020D01
	v_sub_nc_i16 v9.l, v2.h, v2.l op_sel:[1,0,0] clamp         // 000000044328: D70E8809 00020502
	v_sub_nc_i16 v86.l, v4.h, v1.l op_sel:[1,0,0] clamp        // 000000044330: D70E8856 00020304
	v_sub_nc_i16 v7.l, v7.l, v4.l clamp                        // 000000044338: D70E8007 00020907
	v_and_b16 v7.h, 0xff00, v10.l op_sel:[0,0,1]               // 000000044340: D7624007 000214FF FFFFFF00
	v_lshlrev_b16 v1.l, 8, v10.l                               // 00000004434C: D7380001 00021488
	v_lshlrev_b16 v1.h, 8, v11.l op_sel:[0,0,1]                // 000000044354: D7384001 00021688
	v_and_b16 v2.l, 0xff00, v10.h op_sel:[0,1,0]               // 00000004435C: D7621002 000214FF FFFFFF00
	v_lshlrev_b16 v2.h, 8, v10.h op_sel:[0,1,1]                // 000000044368: D7385002 00021488
	v_lshlrev_b16 v4.l, 8, v8.l                                // 000000044370: D7380004 00021088
	v_cvt_f32_f16_e32 v8, v3.l                                 // 000000044378: 7E101703
	v_sub_nc_i16 v88.l, v7.h, v6.h op_sel:[1,1,0] clamp        // 00000004437C: D70E9858 00020D07
	v_sub_nc_i16 v1.l, v1.l, v1.h op_sel:[0,1,0] clamp         // 000000044384: D70E9001 00020301
	v_sub_nc_i16 v2.l, v2.l, v3.h op_sel:[0,1,0] clamp         // 00000004438C: D70E9002 00020702
	v_sub_nc_i16 v4.l, v2.h, v4.l op_sel:[1,0,0] clamp         // 000000044394: D70E8804 00020902
	v_mul_f32_e32 v8, 0.5, v8                                  // 00000004439C: 101010F0
	v_perm_b32 v6, v9, v6, 0xc0c0105                           // 0000000443A0: D6440006 03FE0D09 0C0C0105
	v_perm_b32 v7, v7, v86, 0xc0c0105                          // 0000000443AC: D6440007 03FEAD07 0C0C0105
	v_perm_b32 v1, v1, v88, 0xc0c0105                          // 0000000443B8: D6440001 03FEB101 0C0C0105
	v_perm_b32 v2, v4, v2, 0xc0c0105                           // 0000000443C4: D6440002 03FE0504 0C0C0105
	v_fma_mix_f32 v3, v5, v3, v8 op_sel_hi:[0,1,0]             // 0000000443D0: CC200003 14220705
	v_lshl_or_b32 v4, v87, 16, v85                             // 0000000443D8: D6560004 05552157
	v_lshl_or_b32 v5, v82, 16, v78                             // 0000000443E0: D6560005 05392152
	v_lshl_or_b32 v6, v7, 16, v6                               // 0000000443E8: D6560006 04192107
	v_lshl_or_b32 v1, v2, 16, v1                               // 0000000443F0: D6560001 04052102
	v_mul_f32_e32 v2, 0.5, v3                                  // 0000000443F8: 100406F0
	ds_store_2addr_b32 v74, v12, v81 offset1:1                 // 0000000443FC: D8380100 00510C4A
	ds_store_2addr_b32 v75, v80, v84 offset1:1                 // 000000044404: D8380100 0054504B
	ds_store_2addr_b32 v76, v4, v5 offset1:1                   // 00000004440C: D8380100 0005044C
	ds_store_2addr_b32 v77, v6, v1 offset1:1                   // 000000044414: D8380100 0001064D
	ds_store_2addr_stride64_b32 v65, v83, v2 offset0:114 offset1:152// 00000004441C: D83C9872 00025341
	s_waitcnt vmcnt(7)                                         // 000000044424: BF891FF7
	ds_store_2addr_stride64_b32 v50, v103, v104 offset0:1 offset1:5// 000000044428: D83C0501 00686732
	s_waitcnt vmcnt(5)                                         // 000000044430: BF8917F7
	ds_store_2addr_stride64_b32 v50, v105, v106 offset0:9 offset1:13// 000000044434: D83C0D09 006A6932
	s_waitcnt vmcnt(3)                                         // 00000004443C: BF890FF7
	ds_store_2addr_stride64_b32 v50, v107, v108 offset0:17 offset1:21// 000000044440: D83C1511 006C6B32
	s_waitcnt vmcnt(1)                                         // 000000044448: BF8907F7
	ds_store_2addr_stride64_b32 v50, v109, v110 offset0:25 offset1:29// 00000004444C: D83C1D19 006E6D32
	s_waitcnt vmcnt(0)                                         // 000000044454: BF8903F7
	ds_store_b32 v50, v79 offset:8448                          // 000000044458: D8342100 00004F32
	v_dual_mov_b32 v1, v56 :: v_dual_mov_b32 v2, v55           // 000000044460: CA100138 01020137
	v_dual_mov_b32 v3, v54 :: v_dual_mov_b32 v4, v53           // 000000044468: CA100136 03040135
	s_waitcnt lgkmcnt(0)                                       // 000000044470: BF89FC07
	s_barrier                                                  // 000000044474: BFBD0000
	buffer_gl0_inv                                             // 000000044478: E0AC0000 00000000
	ds_load_b128 v[110:113], v3                                // 000000044480: DBFC0000 6E000003
	ds_load_b128 v[114:117], v3 offset:16                      // 000000044488: DBFC0010 72000003
	ds_load_b128 v[86:89], v4                                  // 000000044490: DBFC0000 56000004
	ds_load_b128 v[118:121], v4 offset:16                      // 000000044498: DBFC0010 76000004
	ds_load_2addr_stride64_b32 v[138:139], v2 offset1:9        // 0000000444A0: D8E00900 8A000002
	ds_load_b128 v[94:97], v4 offset:2304                      // 0000000444A8: DBFC0900 5E000004
	ds_load_b128 v[102:105], v4 offset:4608                    // 0000000444B0: DBFC1200 66000004
	ds_load_2addr_b32 v[140:141], v1 offset1:152               // 0000000444B8: D8DC9800 8C000001
	ds_load_b128 v[122:125], v4 offset:6912                    // 0000000444C0: DBFC1B00 7A000004
	ds_load_b128 v[126:129], v4 offset:2320                    // 0000000444C8: DBFC0910 7E000004
	ds_load_b128 v[130:133], v4 offset:4624                    // 0000000444D0: DBFC1210 82000004
	ds_load_2addr_stride64_b32 v[142:143], v2 offset0:18 offset1:27// 0000000444D8: D8E01B12 8E000002
	ds_load_b128 v[134:137], v4 offset:6928                    // 0000000444E0: DBFC1B10 86000004
	v_add_nc_u32_e32 v78, 0x400, v1                            // 0000000444E8: 4A9C02FF 00000400
	v_add_nc_u32_e32 v79, 0x800, v1                            // 0000000444F0: 4A9E02FF 00000800
	v_add_nc_u32_e32 v80, 0xe00, v1                            // 0000000444F8: 4AA002FF 00000E00
	v_dual_mov_b32 v12, s7 :: v_dual_mov_b32 v11, s6           // 000000044500: CA100007 0C0A0006
	v_dual_mov_b32 v10, s5 :: v_dual_mov_b32 v9, s4            // 000000044508: CA100005 0A080004
	v_dual_mov_b32 v8, s3 :: v_dual_mov_b32 v7, s2             // 000000044510: CA100003 08060002
	v_dual_mov_b32 v6, s1 :: v_dual_mov_b32 v5, s0             // 000000044518: CA100001 06040000
	ds_load_2addr_b32 v[144:145], v78 offset0:48 offset1:200   // 000000044520: D8DCC830 9000004E
	ds_load_2addr_b32 v[146:147], v79 offset0:96 offset1:248   // 000000044528: D8DCF860 9200004F
	ds_load_2addr_b32 v[148:149], v80 offset0:16 offset1:168   // 000000044530: D8DCA810 94000050
	s_add_i32 s10, s10, 8                                      // 000000044538: 810A880A
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000004453C: BF870009
	s_cmp_lt_u32 s10, 24                                       // 000000044540: BF0A980A
	s_waitcnt lgkmcnt(13)                                      // 000000044544: BF89FCD7
	v_wmma_i32_16x16x16_iu8 v[78:85], v[110:113], v[86:89], v[5:12] neg_lo:[1,1,0] clamp// 000000044548: CC44C04E 7C16AD6E
	s_waitcnt lgkmcnt(10)                                      // 000000044550: BF89FCA7
	v_wmma_i32_16x16x16_iu8 v[86:93], v[110:113], v[94:97], v[5:12] neg_lo:[1,1,0] clamp// 000000044554: CC44C056 7C16BD6E
	s_waitcnt lgkmcnt(9)                                       // 00000004455C: BF89FC97
	v_wmma_i32_16x16x16_iu8 v[94:101], v[110:113], v[102:105], v[5:12] neg_lo:[1,1,0] clamp// 000000044560: CC44C05E 7C16CD6E
	s_waitcnt lgkmcnt(7)                                       // 000000044568: BF89FC77
	v_wmma_i32_16x16x16_iu8 v[102:109], v[110:113], v[122:125], v[5:12] neg_lo:[1,1,0] clamp// 00000004456C: CC44C066 7C16F56E
	v_wmma_i32_16x16x16_iu8 v[78:85], v[114:117], v[118:121], v[78:85] neg_lo:[1,1,0] clamp// 000000044574: CC44C04E 7D3AED72
	s_waitcnt lgkmcnt(6)                                       // 00000004457C: BF89FC67
	v_wmma_i32_16x16x16_iu8 v[86:93], v[114:117], v[126:129], v[86:93] neg_lo:[1,1,0] clamp// 000000044580: CC44C056 7D5AFD72
	s_waitcnt lgkmcnt(5)                                       // 000000044588: BF89FC57
	v_wmma_i32_16x16x16_iu8 v[94:101], v[114:117], v[130:133], v[94:101] neg_lo:[1,1,0] clamp// 00000004458C: CC44C05E 7D7B0572
	s_waitcnt lgkmcnt(3)                                       // 000000044594: BF89FC37
	v_wmma_i32_16x16x16_iu8 v[102:109], v[114:117], v[134:137], v[102:109] neg_lo:[1,1,0] clamp// 000000044598: CC44C066 7D9B0D72
	v_cvt_f32_i32_e32 v5, v78                                  // 0000000445A0: 7E0A0B4E
	v_cvt_f32_i32_e32 v6, v79                                  // 0000000445A4: 7E0C0B4F
	v_cvt_f32_i32_e32 v7, v80                                  // 0000000445A8: 7E0E0B50
	v_cvt_f32_i32_e32 v8, v81                                  // 0000000445AC: 7E100B51
	v_cvt_f32_i32_e32 v9, v82                                  // 0000000445B0: 7E120B52
	v_cvt_f32_i32_e32 v10, v83                                 // 0000000445B4: 7E140B53
	v_cvt_f32_i32_e32 v11, v84                                 // 0000000445B8: 7E160B54
	v_cvt_f32_i32_e32 v12, v85                                 // 0000000445BC: 7E180B55
	v_cvt_f32_i32_e32 v78, v86                                 // 0000000445C0: 7E9C0B56
	v_cvt_f32_i32_e32 v79, v87                                 // 0000000445C4: 7E9E0B57
	v_cvt_f32_i32_e32 v80, v88                                 // 0000000445C8: 7EA00B58
	v_cvt_f32_i32_e32 v81, v89                                 // 0000000445CC: 7EA20B59
	v_cvt_f32_i32_e32 v82, v90                                 // 0000000445D0: 7EA40B5A
	v_cvt_f32_i32_e32 v83, v91                                 // 0000000445D4: 7EA60B5B
	v_cvt_f32_i32_e32 v84, v92                                 // 0000000445D8: 7EA80B5C
	v_cvt_f32_i32_e32 v85, v93                                 // 0000000445DC: 7EAA0B5D
	v_cvt_f32_i32_e32 v86, v94                                 // 0000000445E0: 7EAC0B5E
	v_cvt_f32_i32_e32 v87, v95                                 // 0000000445E4: 7EAE0B5F
	v_cvt_f32_i32_e32 v88, v96                                 // 0000000445E8: 7EB00B60
	v_cvt_f32_i32_e32 v89, v97                                 // 0000000445EC: 7EB20B61
	v_cvt_f32_i32_e32 v90, v98                                 // 0000000445F0: 7EB40B62
	v_cvt_f32_i32_e32 v91, v99                                 // 0000000445F4: 7EB60B63
	v_cvt_f32_i32_e32 v92, v100                                // 0000000445F8: 7EB80B64
	v_cvt_f32_i32_e32 v93, v101                                // 0000000445FC: 7EBA0B65
	v_cvt_f32_i32_e32 v94, v102                                // 000000044600: 7EBC0B66
	v_cvt_f32_i32_e32 v95, v103                                // 000000044604: 7EBE0B67
	v_cvt_f32_i32_e32 v96, v104                                // 000000044608: 7EC00B68
	v_cvt_f32_i32_e32 v97, v105                                // 00000004460C: 7EC20B69
	v_cvt_f32_i32_e32 v98, v106                                // 000000044610: 7EC40B6A
	v_cvt_f32_i32_e32 v99, v107                                // 000000044614: 7EC60B6B
	v_cvt_f32_i32_e32 v100, v108                               // 000000044618: 7EC80B6C
	v_cvt_f32_i32_e32 v101, v109                               // 00000004461C: 7ECA0B6D
	v_dual_mul_f32 v5, v140, v5 :: v_dual_add_nc_u32 v4, 32, v4// 000000044620: C8E00B8C 050408A0
	s_waitcnt lgkmcnt(2)                                       // 000000044628: BF89FC27
	v_dual_mul_f32 v8, v145, v8 :: v_dual_add_nc_u32 v3, 32, v3// 00000004462C: C8E01191 080206A0
	s_waitcnt lgkmcnt(1)                                       // 000000044634: BF89FC17
	v_dual_mul_f32 v9, v146, v9 :: v_dual_add_nc_u32 v2, 4, v2 // 000000044638: C8E01392 09020484
	v_dual_mul_f32 v10, v147, v10 :: v_dual_add_nc_u32 v1, 4, v1// 000000044640: C8E01593 0A000284
	v_dual_mul_f32 v6, v141, v6 :: v_dual_mul_f32 v7, v144, v7 // 000000044648: C8C60D8D 06060F90
	s_waitcnt lgkmcnt(0)                                       // 000000044650: BF89FC07
	v_dual_mul_f32 v11, v148, v11 :: v_dual_mul_f32 v12, v149, v12// 000000044654: C8C61794 0B0C1995
	v_dual_mul_f32 v83, v147, v83 :: v_dual_mul_f32 v78, v140, v78// 00000004465C: C8C6A793 534E9D8C
	v_dual_mul_f32 v79, v141, v79 :: v_dual_mul_f32 v80, v144, v80// 000000044664: C8C69F8D 4F50A190
	v_dual_mul_f32 v81, v145, v81 :: v_dual_mul_f32 v82, v146, v82// 00000004466C: C8C6A391 5152A592
	v_dual_mul_f32 v85, v149, v85 :: v_dual_mul_f32 v84, v148, v84// 000000044674: C8C6AB95 5554A994
	v_dual_mul_f32 v87, v141, v87 :: v_dual_mul_f32 v86, v140, v86// 00000004467C: C8C6AF8D 5756AD8C
	v_dual_mul_f32 v89, v145, v89 :: v_dual_mul_f32 v88, v144, v88// 000000044684: C8C6B391 5958B190
	v_dual_mul_f32 v91, v147, v91 :: v_dual_mul_f32 v90, v146, v90// 00000004468C: C8C6B793 5B5AB592
	v_dual_mul_f32 v93, v149, v93 :: v_dual_mul_f32 v92, v148, v92// 000000044694: C8C6BB95 5D5CB994
	v_dual_mul_f32 v95, v141, v95 :: v_dual_mul_f32 v94, v140, v94// 00000004469C: C8C6BF8D 5F5EBD8C
	v_dual_mul_f32 v97, v145, v97 :: v_dual_mul_f32 v96, v144, v96// 0000000446A4: C8C6C391 6160C190
	v_dual_mul_f32 v99, v147, v99 :: v_dual_mul_f32 v98, v146, v98// 0000000446AC: C8C6C793 6362C592
	v_dual_mul_f32 v101, v149, v101 :: v_dual_mul_f32 v100, v148, v100// 0000000446B4: C8C6CB95 6564C994
	v_fmac_f32_e32 v45, v138, v6                               // 0000000446BC: 565A0D8A
	v_dual_fmac_f32 v22, v138, v5 :: v_dual_fmac_f32 v37, v139, v79// 0000000446C0: C8000B8A 16249F8B
	v_dual_fmac_f32 v44, v138, v7 :: v_dual_fmac_f32 v35, v139, v81// 0000000446C8: C8000F8A 2C22A38B
	v_dual_fmac_f32 v43, v138, v8 :: v_dual_fmac_f32 v38, v139, v78// 0000000446D0: C800118A 2B269D8B
	v_dual_fmac_f32 v42, v138, v9 :: v_dual_fmac_f32 v33, v139, v83// 0000000446D8: C800138A 2A20A78B
	v_dual_fmac_f32 v41, v138, v10 :: v_dual_fmac_f32 v36, v139, v80// 0000000446E0: C800158A 2924A18B
	v_dual_fmac_f32 v40, v138, v11 :: v_dual_fmac_f32 v31, v139, v85// 0000000446E8: C800178A 281EAB8B
	v_dual_fmac_f32 v39, v138, v12 :: v_dual_fmac_f32 v34, v139, v82// 0000000446F0: C800198A 2722A58B
	v_dual_fmac_f32 v32, v139, v84 :: v_dual_fmac_f32 v29, v142, v87// 0000000446F8: C800A98B 201CAF8E
	v_dual_fmac_f32 v30, v142, v86 :: v_dual_fmac_f32 v19, v143, v96// 000000044700: C800AD8E 1E12C18F
	v_dual_fmac_f32 v28, v142, v88 :: v_dual_fmac_f32 v21, v143, v94// 000000044708: C800B18E 1C14BD8F
	v_dual_fmac_f32 v27, v142, v89 :: v_dual_fmac_f32 v20, v143, v95// 000000044710: C800B38E 1B14BF8F
	v_dual_fmac_f32 v26, v142, v90 :: v_dual_fmac_f32 v15, v143, v100// 000000044718: C800B58E 1A0EC98F
	v_dual_fmac_f32 v25, v142, v91 :: v_dual_fmac_f32 v18, v143, v97// 000000044720: C800B78E 1912C38F
	v_dual_fmac_f32 v24, v142, v92 :: v_dual_fmac_f32 v17, v143, v98// 000000044728: C800B98E 1810C58F
	v_dual_fmac_f32 v23, v142, v93 :: v_dual_fmac_f32 v16, v143, v99// 000000044730: C800BB8E 1710C78F
	v_fmac_f32_e32 v14, v143, v101                             // 000000044738: 561CCB8F
	s_cbranch_scc1 65360                                       // 00000004473C: BFA2FF50 <_ZL9mul_mat_qIL9ggml_type18ELi64ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x3080>
	s_mul_i32 s10, s17, 0x48                                   // 000000044740: 960AFF11 00000048
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_4) | instid1(SALU_CYCLE_1)// 000000044748: BF8704D9
	s_add_i32 s10, s10, 36                                     // 00000004474C: 810AA40A
	s_barrier                                                  // 000000044750: BFBD0000
	s_mul_i32 s10, s10, s18                                    // 000000044754: 960A120A
	buffer_gl0_inv                                             // 000000044758: E0AC0000 00000000
	s_ashr_i32 s11, s10, 31                                    // 000000044760: 860B9F0A
	s_lshl_b64 s[10:11], s[10:11], 2                           // 000000044764: 848A820A
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000044768: BF870099
	v_add_co_u32 v1, vcc_lo, v51, s10                          // 00000004476C: D7006A01 00001533
	v_add_co_ci_u32_e64 v2, null, s11, v52, vcc_lo             // 000000044774: D5207C02 01AA680B
	s_mov_b32 s10, -8                                          // 00000004477C: BE8A00C8
	v_add_co_u32 v3, vcc_lo, 0x1000, v1                        // 000000044780: D7006A03 000202FF 00001000
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000004478C: BF8700A1
	v_add_co_ci_u32_e64 v4, null, 0, v2, vcc_lo                // 000000044790: D5207C04 01AA0480
	v_add_co_u32 v5, vcc_lo, v1, 0x2000                        // 000000044798: D7006A05 0001FF01 00002000
	v_add_co_ci_u32_e64 v6, null, 0, v2, vcc_lo                // 0000000447A4: D5207C06 01AA0480
	s_clause 0x8                                               // 0000000447AC: BF850008
	global_load_b32 v7, v[1:2], off                            // 0000000447B0: DC520000 077C0001
	global_load_b32 v8, v[1:2], off offset:1024                // 0000000447B8: DC520400 087C0001
	global_load_b32 v9, v[1:2], off offset:2048                // 0000000447C0: DC520800 097C0001
	global_load_b32 v10, v[1:2], off offset:3072               // 0000000447C8: DC520C00 0A7C0001
	global_load_b32 v11, v[5:6], off offset:-4096              // 0000000447D0: DC521000 0B7C0005
	global_load_b32 v12, v[3:4], off offset:1024               // 0000000447D8: DC520400 0C7C0003
	global_load_b32 v78, v[3:4], off offset:2048               // 0000000447E0: DC520800 4E7C0003
	global_load_b32 v79, v[3:4], off offset:3072               // 0000000447E8: DC520C00 4F7C0003
	global_load_b32 v5, v[5:6], off                            // 0000000447F0: DC520000 057C0005
	v_dual_mov_b32 v1, v58 :: v_dual_mov_b32 v2, v55           // 0000000447F8: CA10013A 01020137
	v_mov_b32_e32 v3, v57                                      // 000000044800: 7E060339
	v_mov_b32_e32 v4, v53                                      // 000000044804: 7E080335
	s_waitcnt vmcnt(7)                                         // 000000044808: BF891FF7
	ds_store_2addr_stride64_b32 v50, v7, v8 offset0:1 offset1:5// 00000004480C: D83C0501 00080732
	s_waitcnt vmcnt(5)                                         // 000000044814: BF8917F7
	ds_store_2addr_stride64_b32 v50, v9, v10 offset0:9 offset1:13// 000000044818: D83C0D09 000A0932
	s_waitcnt vmcnt(3)                                         // 000000044820: BF890FF7
	ds_store_2addr_stride64_b32 v50, v11, v12 offset0:17 offset1:21// 000000044824: D83C1511 000C0B32
	s_waitcnt vmcnt(1)                                         // 00000004482C: BF8907F7
	ds_store_2addr_stride64_b32 v50, v78, v79 offset0:25 offset1:29// 000000044830: D83C1D19 004F4E32
	s_waitcnt vmcnt(0)                                         // 000000044838: BF8903F7
	ds_store_b32 v50, v5 offset:8448                           // 00000004483C: D8342100 00000532
	s_waitcnt lgkmcnt(0)                                       // 000000044844: BF89FC07
	s_barrier                                                  // 000000044848: BFBD0000
	buffer_gl0_inv                                             // 00000004484C: E0AC0000 00000000
	ds_load_b128 v[110:113], v3                                // 000000044854: DBFC0000 6E000003
	ds_load_b128 v[114:117], v3 offset:16                      // 00000004485C: DBFC0010 72000003
	ds_load_b128 v[86:89], v4                                  // 000000044864: DBFC0000 56000004
	ds_load_b128 v[118:121], v4 offset:16                      // 00000004486C: DBFC0010 76000004
	ds_load_2addr_stride64_b32 v[138:139], v2 offset1:9        // 000000044874: D8E00900 8A000002
	ds_load_b128 v[94:97], v4 offset:2304                      // 00000004487C: DBFC0900 5E000004
	ds_load_b128 v[102:105], v4 offset:4608                    // 000000044884: DBFC1200 66000004
	ds_load_2addr_b32 v[140:141], v1 offset1:152               // 00000004488C: D8DC9800 8C000001
	ds_load_b128 v[122:125], v4 offset:6912                    // 000000044894: DBFC1B00 7A000004
	ds_load_b128 v[126:129], v4 offset:2320                    // 00000004489C: DBFC0910 7E000004
	ds_load_b128 v[130:133], v4 offset:4624                    // 0000000448A4: DBFC1210 82000004
	ds_load_2addr_stride64_b32 v[142:143], v2 offset0:18 offset1:27// 0000000448AC: D8E01B12 8E000002
	ds_load_b128 v[134:137], v4 offset:6928                    // 0000000448B4: DBFC1B10 86000004
	v_add_nc_u32_e32 v78, 0x400, v1                            // 0000000448BC: 4A9C02FF 00000400
	v_add_nc_u32_e32 v79, 0x800, v1                            // 0000000448C4: 4A9E02FF 00000800
	v_add_nc_u32_e32 v80, 0xe00, v1                            // 0000000448CC: 4AA002FF 00000E00
	v_dual_mov_b32 v12, s7 :: v_dual_mov_b32 v11, s6           // 0000000448D4: CA100007 0C0A0006
	v_dual_mov_b32 v10, s5 :: v_dual_mov_b32 v9, s4            // 0000000448DC: CA100005 0A080004
	v_dual_mov_b32 v8, s3 :: v_dual_mov_b32 v7, s2             // 0000000448E4: CA100003 08060002
	v_dual_mov_b32 v6, s1 :: v_dual_mov_b32 v5, s0             // 0000000448EC: CA100001 06040000
	ds_load_2addr_b32 v[144:145], v78 offset0:48 offset1:200   // 0000000448F4: D8DCC830 9000004E
	ds_load_2addr_b32 v[146:147], v79 offset0:96 offset1:248   // 0000000448FC: D8DCF860 9200004F
	ds_load_2addr_b32 v[148:149], v80 offset0:16 offset1:168   // 000000044904: D8DCA810 94000050
	s_add_i32 s10, s10, 8                                      // 00000004490C: 810A880A
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000044910: BF870009
	s_cmp_lt_u32 s10, 24                                       // 000000044914: BF0A980A
	s_waitcnt lgkmcnt(13)                                      // 000000044918: BF89FCD7
	v_wmma_i32_16x16x16_iu8 v[78:85], v[110:113], v[86:89], v[5:12] neg_lo:[1,1,0] clamp// 00000004491C: CC44C04E 7C16AD6E
	s_waitcnt lgkmcnt(10)                                      // 000000044924: BF89FCA7
	v_wmma_i32_16x16x16_iu8 v[86:93], v[110:113], v[94:97], v[5:12] neg_lo:[1,1,0] clamp// 000000044928: CC44C056 7C16BD6E
	s_waitcnt lgkmcnt(9)                                       // 000000044930: BF89FC97
	v_wmma_i32_16x16x16_iu8 v[94:101], v[110:113], v[102:105], v[5:12] neg_lo:[1,1,0] clamp// 000000044934: CC44C05E 7C16CD6E
	s_waitcnt lgkmcnt(7)                                       // 00000004493C: BF89FC77
	v_wmma_i32_16x16x16_iu8 v[102:109], v[110:113], v[122:125], v[5:12] neg_lo:[1,1,0] clamp// 000000044940: CC44C066 7C16F56E
	v_wmma_i32_16x16x16_iu8 v[78:85], v[114:117], v[118:121], v[78:85] neg_lo:[1,1,0] clamp// 000000044948: CC44C04E 7D3AED72
	s_waitcnt lgkmcnt(6)                                       // 000000044950: BF89FC67
	v_wmma_i32_16x16x16_iu8 v[86:93], v[114:117], v[126:129], v[86:93] neg_lo:[1,1,0] clamp// 000000044954: CC44C056 7D5AFD72
	s_waitcnt lgkmcnt(5)                                       // 00000004495C: BF89FC57
	v_wmma_i32_16x16x16_iu8 v[94:101], v[114:117], v[130:133], v[94:101] neg_lo:[1,1,0] clamp// 000000044960: CC44C05E 7D7B0572
	s_waitcnt lgkmcnt(3)                                       // 000000044968: BF89FC37
	v_wmma_i32_16x16x16_iu8 v[102:109], v[114:117], v[134:137], v[102:109] neg_lo:[1,1,0] clamp// 00000004496C: CC44C066 7D9B0D72
	v_cvt_f32_i32_e32 v5, v78                                  // 000000044974: 7E0A0B4E
	v_cvt_f32_i32_e32 v6, v79                                  // 000000044978: 7E0C0B4F
	v_cvt_f32_i32_e32 v7, v80                                  // 00000004497C: 7E0E0B50
	v_cvt_f32_i32_e32 v8, v81                                  // 000000044980: 7E100B51
	v_cvt_f32_i32_e32 v9, v82                                  // 000000044984: 7E120B52
	v_cvt_f32_i32_e32 v10, v83                                 // 000000044988: 7E140B53
	v_cvt_f32_i32_e32 v11, v84                                 // 00000004498C: 7E160B54
	v_cvt_f32_i32_e32 v12, v85                                 // 000000044990: 7E180B55
	v_cvt_f32_i32_e32 v78, v86                                 // 000000044994: 7E9C0B56
	v_cvt_f32_i32_e32 v79, v87                                 // 000000044998: 7E9E0B57
	v_cvt_f32_i32_e32 v80, v88                                 // 00000004499C: 7EA00B58
	v_cvt_f32_i32_e32 v81, v89                                 // 0000000449A0: 7EA20B59
	v_cvt_f32_i32_e32 v82, v90                                 // 0000000449A4: 7EA40B5A
	v_cvt_f32_i32_e32 v83, v91                                 // 0000000449A8: 7EA60B5B
	v_cvt_f32_i32_e32 v84, v92                                 // 0000000449AC: 7EA80B5C
	v_cvt_f32_i32_e32 v85, v93                                 // 0000000449B0: 7EAA0B5D
	v_cvt_f32_i32_e32 v86, v94                                 // 0000000449B4: 7EAC0B5E
	v_cvt_f32_i32_e32 v87, v95                                 // 0000000449B8: 7EAE0B5F
	v_cvt_f32_i32_e32 v88, v96                                 // 0000000449BC: 7EB00B60
	v_cvt_f32_i32_e32 v89, v97                                 // 0000000449C0: 7EB20B61
	v_cvt_f32_i32_e32 v90, v98                                 // 0000000449C4: 7EB40B62
	v_cvt_f32_i32_e32 v91, v99                                 // 0000000449C8: 7EB60B63
	v_cvt_f32_i32_e32 v92, v100                                // 0000000449CC: 7EB80B64
	v_cvt_f32_i32_e32 v93, v101                                // 0000000449D0: 7EBA0B65
	v_cvt_f32_i32_e32 v94, v102                                // 0000000449D4: 7EBC0B66
	v_cvt_f32_i32_e32 v95, v103                                // 0000000449D8: 7EBE0B67
	v_cvt_f32_i32_e32 v96, v104                                // 0000000449DC: 7EC00B68
	v_cvt_f32_i32_e32 v97, v105                                // 0000000449E0: 7EC20B69
	v_cvt_f32_i32_e32 v98, v106                                // 0000000449E4: 7EC40B6A
	v_cvt_f32_i32_e32 v99, v107                                // 0000000449E8: 7EC60B6B
	v_cvt_f32_i32_e32 v100, v108                               // 0000000449EC: 7EC80B6C
	v_cvt_f32_i32_e32 v101, v109                               // 0000000449F0: 7ECA0B6D
	v_dual_mul_f32 v5, v140, v5 :: v_dual_add_nc_u32 v4, 32, v4// 0000000449F4: C8E00B8C 050408A0
	s_waitcnt lgkmcnt(2)                                       // 0000000449FC: BF89FC27
	v_dual_mul_f32 v8, v145, v8 :: v_dual_add_nc_u32 v3, 32, v3// 000000044A00: C8E01191 080206A0
	s_waitcnt lgkmcnt(1)                                       // 000000044A08: BF89FC17
	v_dual_mul_f32 v9, v146, v9 :: v_dual_add_nc_u32 v2, 4, v2 // 000000044A0C: C8E01392 09020484
	v_dual_mul_f32 v10, v147, v10 :: v_dual_add_nc_u32 v1, 4, v1// 000000044A14: C8E01593 0A000284
	v_dual_mul_f32 v6, v141, v6 :: v_dual_mul_f32 v7, v144, v7 // 000000044A1C: C8C60D8D 06060F90
	s_waitcnt lgkmcnt(0)                                       // 000000044A24: BF89FC07
	v_dual_mul_f32 v11, v148, v11 :: v_dual_mul_f32 v12, v149, v12// 000000044A28: C8C61794 0B0C1995
	v_dual_mul_f32 v83, v147, v83 :: v_dual_mul_f32 v78, v140, v78// 000000044A30: C8C6A793 534E9D8C
	v_dual_mul_f32 v79, v141, v79 :: v_dual_mul_f32 v80, v144, v80// 000000044A38: C8C69F8D 4F50A190
	v_dual_mul_f32 v81, v145, v81 :: v_dual_mul_f32 v82, v146, v82// 000000044A40: C8C6A391 5152A592
	v_dual_mul_f32 v85, v149, v85 :: v_dual_mul_f32 v84, v148, v84// 000000044A48: C8C6AB95 5554A994
	v_dual_mul_f32 v87, v141, v87 :: v_dual_mul_f32 v86, v140, v86// 000000044A50: C8C6AF8D 5756AD8C
	v_dual_mul_f32 v89, v145, v89 :: v_dual_mul_f32 v88, v144, v88// 000000044A58: C8C6B391 5958B190
	v_dual_mul_f32 v91, v147, v91 :: v_dual_mul_f32 v90, v146, v90// 000000044A60: C8C6B793 5B5AB592
	v_dual_mul_f32 v93, v149, v93 :: v_dual_mul_f32 v92, v148, v92// 000000044A68: C8C6BB95 5D5CB994
	v_dual_mul_f32 v95, v141, v95 :: v_dual_mul_f32 v94, v140, v94// 000000044A70: C8C6BF8D 5F5EBD8C
	v_dual_mul_f32 v97, v145, v97 :: v_dual_mul_f32 v96, v144, v96// 000000044A78: C8C6C391 6160C190
	v_dual_mul_f32 v99, v147, v99 :: v_dual_mul_f32 v98, v146, v98// 000000044A80: C8C6C793 6362C592
	v_dual_mul_f32 v101, v149, v101 :: v_dual_mul_f32 v100, v148, v100// 000000044A88: C8C6CB95 6564C994
	v_fmac_f32_e32 v45, v138, v6                               // 000000044A90: 565A0D8A
	v_dual_fmac_f32 v22, v138, v5 :: v_dual_fmac_f32 v37, v139, v79// 000000044A94: C8000B8A 16249F8B
	v_dual_fmac_f32 v44, v138, v7 :: v_dual_fmac_f32 v35, v139, v81// 000000044A9C: C8000F8A 2C22A38B
	v_dual_fmac_f32 v43, v138, v8 :: v_dual_fmac_f32 v38, v139, v78// 000000044AA4: C800118A 2B269D8B
	v_dual_fmac_f32 v42, v138, v9 :: v_dual_fmac_f32 v33, v139, v83// 000000044AAC: C800138A 2A20A78B
	v_dual_fmac_f32 v41, v138, v10 :: v_dual_fmac_f32 v36, v139, v80// 000000044AB4: C800158A 2924A18B
	v_dual_fmac_f32 v40, v138, v11 :: v_dual_fmac_f32 v31, v139, v85// 000000044ABC: C800178A 281EAB8B
	v_dual_fmac_f32 v39, v138, v12 :: v_dual_fmac_f32 v34, v139, v82// 000000044AC4: C800198A 2722A58B
	v_dual_fmac_f32 v32, v139, v84 :: v_dual_fmac_f32 v29, v142, v87// 000000044ACC: C800A98B 201CAF8E
	v_dual_fmac_f32 v30, v142, v86 :: v_dual_fmac_f32 v19, v143, v96// 000000044AD4: C800AD8E 1E12C18F
	v_dual_fmac_f32 v28, v142, v88 :: v_dual_fmac_f32 v21, v143, v94// 000000044ADC: C800B18E 1C14BD8F
	v_dual_fmac_f32 v27, v142, v89 :: v_dual_fmac_f32 v20, v143, v95// 000000044AE4: C800B38E 1B14BF8F
	v_dual_fmac_f32 v26, v142, v90 :: v_dual_fmac_f32 v15, v143, v100// 000000044AEC: C800B58E 1A0EC98F
	v_dual_fmac_f32 v25, v142, v91 :: v_dual_fmac_f32 v18, v143, v97// 000000044AF4: C800B78E 1912C38F
	v_dual_fmac_f32 v24, v142, v92 :: v_dual_fmac_f32 v17, v143, v98// 000000044AFC: C800B98E 1810C58F
	v_dual_fmac_f32 v23, v142, v93 :: v_dual_fmac_f32 v16, v143, v99// 000000044B04: C800BB8E 1710C78F
	v_fmac_f32_e32 v14, v143, v101                             // 000000044B0C: 561CCB8F
	s_cbranch_scc1 65360                                       // 000000044B10: BFA2FF50 <_ZL9mul_mat_qIL9ggml_type18ELi64ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x3454>
	s_add_i32 s17, s17, 1                                      // 000000044B14: 81118111
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000044B18: BF870009
	s_cmp_eq_u32 s17, s25                                      // 000000044B1C: BF061911
	s_barrier                                                  // 000000044B20: BFBD0000
	buffer_gl0_inv                                             // 000000044B24: E0AC0000 00000000
	s_cbranch_scc0 62312                                       // 000000044B2C: BFA1F368 <_ZL9mul_mat_qIL9ggml_type18ELi64ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x4d0>
	v_mov_b32_e32 v4, v13                                      // 000000044B30: 7E08030D
	s_add_i32 s0, s12, s13                                     // 000000044B34: 81000D0C
	s_not_b32 s2, s27                                          // 000000044B38: BE821E1B
	s_ashr_i32 s1, s0, 31                                      // 000000044B3C: 86019F00
	s_delay_alu instid0(VALU_DEP_1)                            // 000000044B40: BF870001
	v_lshl_add_u32 v1, v4, 2, 0                                // 000000044B44: D6460001 02010504
	s_lshl_b64 s[0:1], s[0:1], 2                               // 000000044B4C: 84808200
	s_add_i32 s2, s16, s2                                      // 000000044B50: 81020210
	s_waitcnt lgkmcnt(0)                                       // 000000044B54: BF89FC07
	s_add_u32 s0, s8, s0                                       // 000000044B58: 80000008
	s_addc_u32 s1, s9, s1                                      // 000000044B5C: 82010109
	s_mov_b32 s3, exec_lo                                      // 000000044B60: BE83007E
	v_cmpx_ge_i32_e64 s2, v4                                   // 000000044B64: D4C6007E 00020802
	s_cbranch_execz 31                                         // 000000044B6C: BFA5001F <_ZL9mul_mat_qIL9ggml_type18ELi64ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x37ec>
	ds_load_b32 v5, v1                                         // 000000044B70: D8D80000 05000001
	s_waitcnt lgkmcnt(0)                                       // 000000044B78: BF89FC07
	v_mad_u64_u32 v[2:3], null, v5, s19, v[0:1]                // 000000044B7C: D6FE7C02 04002705
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000044B84: BF870091
	v_ashrrev_i32_e32 v3, 31, v2                               // 000000044B88: 3406049F
	v_lshlrev_b64 v[2:3], 2, v[2:3]                            // 000000044B8C: D73C0002 00020482
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000044B94: BF870091
	v_add_co_u32 v2, vcc_lo, s0, v2                            // 000000044B98: D7006A02 00020400
	v_add_co_ci_u32_e64 v3, null, s1, v3, vcc_lo               // 000000044BA0: D5207C03 01AA0601
	s_clause 0x7                                               // 000000044BA8: BF850007
	global_store_b32 v[2:3], v22, off                          // 000000044BAC: DC6A0000 007C1602
	global_store_b32 v[2:3], v45, off offset:8                 // 000000044BB4: DC6A0008 007C2D02
	global_store_b32 v[2:3], v44, off offset:16                // 000000044BBC: DC6A0010 007C2C02
	global_store_b32 v[2:3], v43, off offset:24                // 000000044BC4: DC6A0018 007C2B02
	global_store_b32 v[2:3], v42, off offset:32                // 000000044BCC: DC6A0020 007C2A02
	global_store_b32 v[2:3], v41, off offset:40                // 000000044BD4: DC6A0028 007C2902
	global_store_b32 v[2:3], v40, off offset:48                // 000000044BDC: DC6A0030 007C2802
	global_store_b32 v[2:3], v39, off offset:56                // 000000044BE4: DC6A0038 007C2702
	s_or_b32 exec_lo, exec_lo, s3                              // 000000044BEC: 8C7E037E
	v_or_b32_e32 v2, 16, v4                                    // 000000044BF0: 38040890
	s_mov_b32 s3, exec_lo                                      // 000000044BF4: BE83007E
	s_delay_alu instid0(VALU_DEP_1)                            // 000000044BF8: BF870001
	v_cmpx_ge_i32_e64 s2, v2                                   // 000000044BFC: D4C6007E 00020402
	s_cbranch_execz 31                                         // 000000044C04: BFA5001F <_ZL9mul_mat_qIL9ggml_type18ELi64ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x3884>
	ds_load_b32 v5, v1 offset:64                               // 000000044C08: D8D80040 05000001
	s_waitcnt lgkmcnt(0)                                       // 000000044C10: BF89FC07
	v_mad_u64_u32 v[2:3], null, v5, s19, v[0:1]                // 000000044C14: D6FE7C02 04002705
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000044C1C: BF870091
	v_ashrrev_i32_e32 v3, 31, v2                               // 000000044C20: 3406049F
	v_lshlrev_b64 v[2:3], 2, v[2:3]                            // 000000044C24: D73C0002 00020482
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000044C2C: BF870091
	v_add_co_u32 v2, vcc_lo, s0, v2                            // 000000044C30: D7006A02 00020400
	v_add_co_ci_u32_e64 v3, null, s1, v3, vcc_lo               // 000000044C38: D5207C03 01AA0601
	s_clause 0x7                                               // 000000044C40: BF850007
	global_store_b32 v[2:3], v38, off                          // 000000044C44: DC6A0000 007C2602
	global_store_b32 v[2:3], v37, off offset:8                 // 000000044C4C: DC6A0008 007C2502
	global_store_b32 v[2:3], v36, off offset:16                // 000000044C54: DC6A0010 007C2402
	global_store_b32 v[2:3], v35, off offset:24                // 000000044C5C: DC6A0018 007C2302
	global_store_b32 v[2:3], v34, off offset:32                // 000000044C64: DC6A0020 007C2202
	global_store_b32 v[2:3], v33, off offset:40                // 000000044C6C: DC6A0028 007C2102
	global_store_b32 v[2:3], v32, off offset:48                // 000000044C74: DC6A0030 007C2002
	global_store_b32 v[2:3], v31, off offset:56                // 000000044C7C: DC6A0038 007C1F02
	s_or_b32 exec_lo, exec_lo, s3                              // 000000044C84: 8C7E037E
	v_or_b32_e32 v2, 32, v4                                    // 000000044C88: 380408A0
	s_mov_b32 s3, exec_lo                                      // 000000044C8C: BE83007E
	s_delay_alu instid0(VALU_DEP_1)                            // 000000044C90: BF870001
	v_cmpx_ge_i32_e64 s2, v2                                   // 000000044C94: D4C6007E 00020402
	s_cbranch_execz 31                                         // 000000044C9C: BFA5001F <_ZL9mul_mat_qIL9ggml_type18ELi64ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x391c>
	ds_load_b32 v5, v1 offset:128                              // 000000044CA0: D8D80080 05000001
	s_waitcnt lgkmcnt(0)                                       // 000000044CA8: BF89FC07
	v_mad_u64_u32 v[2:3], null, v5, s19, v[0:1]                // 000000044CAC: D6FE7C02 04002705
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000044CB4: BF870091
	v_ashrrev_i32_e32 v3, 31, v2                               // 000000044CB8: 3406049F
	v_lshlrev_b64 v[2:3], 2, v[2:3]                            // 000000044CBC: D73C0002 00020482
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000044CC4: BF870091
	v_add_co_u32 v2, vcc_lo, s0, v2                            // 000000044CC8: D7006A02 00020400
	v_add_co_ci_u32_e64 v3, null, s1, v3, vcc_lo               // 000000044CD0: D5207C03 01AA0601
	s_clause 0x7                                               // 000000044CD8: BF850007
	global_store_b32 v[2:3], v30, off                          // 000000044CDC: DC6A0000 007C1E02
	global_store_b32 v[2:3], v29, off offset:8                 // 000000044CE4: DC6A0008 007C1D02
	global_store_b32 v[2:3], v28, off offset:16                // 000000044CEC: DC6A0010 007C1C02
	global_store_b32 v[2:3], v27, off offset:24                // 000000044CF4: DC6A0018 007C1B02
	global_store_b32 v[2:3], v26, off offset:32                // 000000044CFC: DC6A0020 007C1A02
	global_store_b32 v[2:3], v25, off offset:40                // 000000044D04: DC6A0028 007C1902
	global_store_b32 v[2:3], v24, off offset:48                // 000000044D0C: DC6A0030 007C1802
	global_store_b32 v[2:3], v23, off offset:56                // 000000044D14: DC6A0038 007C1702
	s_or_b32 exec_lo, exec_lo, s3                              // 000000044D1C: 8C7E037E
	v_or_b32_e32 v2, 48, v4                                    // 000000044D20: 380408B0
	s_delay_alu instid0(VALU_DEP_1)                            // 000000044D24: BF870001
	v_cmp_ge_i32_e32 vcc_lo, s2, v2                            // 000000044D28: 7C8C0402
	s_and_saveexec_b32 s2, vcc_lo                              // 000000044D2C: BE82206A
	s_cbranch_execz 61969                                      // 000000044D30: BFA5F211 <_ZL9mul_mat_qIL9ggml_type18ELi64ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x178>
	ds_load_b32 v3, v1 offset:192                              // 000000044D34: D8D800C0 03000001
	s_waitcnt lgkmcnt(0)                                       // 000000044D3C: BF89FC07
	v_mad_u64_u32 v[1:2], null, v3, s19, v[0:1]                // 000000044D40: D6FE7C01 04002703
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000044D48: BF870091
	v_ashrrev_i32_e32 v2, 31, v1                               // 000000044D4C: 3404029F
	v_lshlrev_b64 v[0:1], 2, v[1:2]                            // 000000044D50: D73C0000 00020282
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000044D58: BF870091
	v_add_co_u32 v0, vcc_lo, s0, v0                            // 000000044D5C: D7006A00 00020000
	v_add_co_ci_u32_e64 v1, null, s1, v1, vcc_lo               // 000000044D64: D5207C01 01AA0201
	s_clause 0x7                                               // 000000044D6C: BF850007
	global_store_b32 v[0:1], v21, off                          // 000000044D70: DC6A0000 007C1500
	global_store_b32 v[0:1], v20, off offset:8                 // 000000044D78: DC6A0008 007C1400
	global_store_b32 v[0:1], v19, off offset:16                // 000000044D80: DC6A0010 007C1300
	global_store_b32 v[0:1], v18, off offset:24                // 000000044D88: DC6A0018 007C1200
	global_store_b32 v[0:1], v17, off offset:32                // 000000044D90: DC6A0020 007C1100
	global_store_b32 v[0:1], v16, off offset:40                // 000000044D98: DC6A0028 007C1000
	global_store_b32 v[0:1], v15, off offset:48                // 000000044DA0: DC6A0030 007C0F00
	global_store_b32 v[0:1], v14, off offset:56                // 000000044DA8: DC6A0038 007C0E00
	s_nop 0                                                    // 000000044DB0: BF800000
	s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)                       // 000000044DB4: BFB60003
	s_endpgm                                                   // 000000044DB8: BFB00000
		...
