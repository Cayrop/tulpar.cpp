
cobjs/co_098.o:	file format elf64-amdgpu

Disassembly of section .text:

000000000002d300 <_ZL9mul_mat_qIL9ggml_type18ELi16ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_>:
	s_clause 0x3                                               // 00000002D300: BF850003
	s_load_b64 s[6:7], s[0:1], 0x58                            // 00000002D304: F4040180 F8000058
	s_load_b64 s[20:21], s[0:1], 0x10                          // 00000002D30C: F4040500 F8000010
	s_load_b128 s[16:19], s[0:1], 0x48                         // 00000002D314: F4080400 F8000048
	s_load_b256 s[8:15], s[0:1], 0x64                          // 00000002D31C: F40C0200 F8000064
	v_bfe_u32 v16, v0, 10, 10                                  // 00000002D324: D6100010 02291500
	v_and_b32_e32 v1, 0x3ff, v0                                // 00000002D32C: 360200FF 000003FF
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002D334: BF870091
	v_lshl_add_u32 v0, v16, 5, v1                              // 00000002D338: D6460000 04050B10
	v_cmp_gt_u32_e32 vcc_lo, 16, v0                            // 00000002D340: 7C980090
	s_and_saveexec_b32 s5, vcc_lo                              // 00000002D344: BE85206A
	v_lshl_add_u32 v2, v0, 2, 0                                // 00000002D348: D6460002 02010500
	ds_store_b32 v2, v0                                        // 00000002D350: D8340000 00000002
	s_or_b32 exec_lo, exec_lo, s5                              // 00000002D358: 8C7E057E
	s_load_b128 s[24:27], s[0:1], 0x94                         // 00000002D35C: F4080600 F8000094
	s_waitcnt lgkmcnt(0)                                       // 00000002D364: BF89FC07
	s_mul_hi_u32 s5, s8, s4                                    // 00000002D368: 96850408
	s_lshl_b32 s28, s3, 4                                      // 00000002D36C: 841C8403
	s_add_i32 s5, s4, s5                                       // 00000002D370: 81050504
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000002D374: BF870009
	s_lshr_b32 s31, s5, s9                                     // 00000002D378: 851F0905
	s_barrier                                                  // 00000002D37C: BFBD0000
	s_mul_i32 s5, s31, s10                                     // 00000002D380: 96050A1F
	buffer_gl0_inv                                             // 00000002D384: E0AC0000 00000000
	s_sub_i32 s4, s4, s5                                       // 00000002D38C: 81840504
	s_cmp_eq_u64 s[20:21], 0                                   // 00000002D390: BF108014
	s_cbranch_scc1 46                                          // 00000002D394: BFA2002E <_ZL9mul_mat_qIL9ggml_type18ELi16ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x150>
	s_load_b64 s[8:9], s[0:1], 0x18                            // 00000002D398: F4040200 F8000018
	s_ashr_i32 s5, s4, 31                                      // 00000002D3A0: 86059F04
	s_mov_b32 s3, 0                                            // 00000002D3A4: BE830080
	s_lshl_b64 s[12:13], s[4:5], 2                             // 00000002D3A8: 848C8204
	s_mov_b32 s5, 0                                            // 00000002D3AC: BE850080
	s_waitcnt lgkmcnt(0)                                       // 00000002D3B0: BF89FC07
	s_add_u32 s8, s8, s12                                      // 00000002D3B4: 80080C08
	s_addc_u32 s9, s9, s13                                     // 00000002D3B8: 82090D09
	s_load_b64 s[8:9], s[8:9], null                            // 00000002D3BC: F4040204 F8000000
	s_waitcnt lgkmcnt(0)                                       // 00000002D3C4: BF89FC07
	s_sub_i32 s16, s9, s8                                      // 00000002D3C8: 81900809
	s_mov_b32 s9, 0                                            // 00000002D3CC: BE890080
	s_cmp_lt_i32 s28, s16                                      // 00000002D3D0: BF04101C
	s_cbranch_scc0 41                                          // 00000002D3D4: BFA10029 <_ZL9mul_mat_qIL9ggml_type18ELi16ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x17c>
	s_and_saveexec_b32 s5, vcc_lo                              // 00000002D3D8: BE85206A
	s_cbranch_execz 19                                         // 00000002D3DC: BFA50013 <_ZL9mul_mat_qIL9ggml_type18ELi16ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x12c>
	v_or_b32_e32 v2, s28, v1                                   // 00000002D3E0: 3804021C
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002D3E4: BF870091
	v_add_nc_u32_e32 v2, s8, v2                                // 00000002D3E8: 4A040408
	v_ashrrev_i32_e32 v3, 31, v2                               // 00000002D3EC: 3406049F
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002D3F0: BF870091
	v_lshlrev_b64 v[2:3], 2, v[2:3]                            // 00000002D3F4: D73C0002 00020482
	v_add_co_u32 v2, vcc_lo, s20, v2                           // 00000002D3FC: D7006A02 00020414
	s_delay_alu instid0(VALU_DEP_1)                            // 00000002D404: BF870001
	v_add_co_ci_u32_e64 v3, null, s21, v3, vcc_lo              // 00000002D408: D5207C03 01AA0615
	global_load_b32 v2, v[2:3], off                            // 00000002D410: DC520000 027C0002
	v_lshl_add_u32 v3, v0, 2, 0                                // 00000002D418: D6460003 02010500
	s_waitcnt vmcnt(0)                                         // 00000002D420: BF8903F7
	ds_store_b32 v3, v2                                        // 00000002D424: D8340000 00000203
	s_or_b32 exec_lo, exec_lo, s5                              // 00000002D42C: 8C7E057E
	s_waitcnt lgkmcnt(0)                                       // 00000002D430: BF89FC07
	s_barrier                                                  // 00000002D434: BFBD0000
	s_mov_b32 s5, s8                                           // 00000002D438: BE850008
	buffer_gl0_inv                                             // 00000002D43C: E0AC0000 00000000
	s_mov_b32 s25, 0                                           // 00000002D444: BE990080
	s_cbranch_execz 11                                         // 00000002D448: BFA5000B <_ZL9mul_mat_qIL9ggml_type18ELi16ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x178>
	s_branch 14                                                // 00000002D44C: BFA0000E <_ZL9mul_mat_qIL9ggml_type18ELi16ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x188>
	s_mul_i32 s8, s31, s26                                     // 00000002D450: 96081A1F
	s_mul_i32 s9, s19, s28                                     // 00000002D454: 96091C13
	s_mul_i32 s3, s31, s25                                     // 00000002D458: 9603191F
	s_mul_i32 s5, s4, s12                                      // 00000002D45C: 96050C04
	s_mul_i32 s10, s4, s13                                     // 00000002D460: 960A0D04
	s_add_i32 s8, s8, s9                                       // 00000002D464: 81080908
	s_add_i32 s3, s5, s3                                       // 00000002D468: 81030305
	s_add_i32 s25, s8, s10                                     // 00000002D46C: 81190A08
	s_mov_b32 s5, 0                                            // 00000002D470: BE850080
	s_cbranch_execnz 4                                         // 00000002D474: BFA60004 <_ZL9mul_mat_qIL9ggml_type18ELi16ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x188>
	s_endpgm                                                   // 00000002D478: BFB00000
	s_mov_b32 s25, 0                                           // 00000002D47C: BE990080
	s_and_b32 vcc_lo, exec_lo, s9                              // 00000002D480: 8B6A097E
	s_cbranch_vccz 65532                                       // 00000002D484: BFA3FFFC <_ZL9mul_mat_qIL9ggml_type18ELi16ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x178>
	s_load_b32 s30, s[0:1], 0x40                               // 00000002D488: F4000780 F8000040
	v_and_b32_e32 v18, 15, v1                                  // 00000002D490: 3624028F
	s_mov_b32 s8, 0                                            // 00000002D494: BE880080
	s_waitcnt lgkmcnt(0)                                       // 00000002D498: BF89FC07
	s_cmp_gt_i32 s30, 0                                        // 00000002D49C: BF02801E
	s_cbranch_scc1 2                                           // 00000002D4A0: BFA20002 <_ZL9mul_mat_qIL9ggml_type18ELi16ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x1ac>
	v_and_b32_e32 v2, 15, v1                                   // 00000002D4A4: 3604028F
	s_branch 1                                                 // 00000002D4A8: BFA00001 <_ZL9mul_mat_qIL9ggml_type18ELi16ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x1b0>
	s_mov_b32 s8, -1                                           // 00000002D4AC: BE8800C1
	s_load_b64 s[26:27], s[0:1], 0x20                          // 00000002D4B0: F4040680 F8000020
	v_dual_mov_b32 v24, 0 :: v_dual_mov_b32 v29, 0             // 00000002D4B8: CA100080 181C0080
	v_lshrrev_b32_e32 v17, 4, v1                               // 00000002D4C0: 32220284
	v_dual_mov_b32 v28, 0 :: v_dual_mov_b32 v35, 0             // 00000002D4C4: CA100080 1C220080
	v_dual_mov_b32 v30, 0 :: v_dual_mov_b32 v19, 0             // 00000002D4CC: CA100080 1E120080
	v_mov_b32_e32 v32, 0                                       // 00000002D4D4: 7E400280
	v_mov_b32_e32 v34, 0                                       // 00000002D4D8: 7E440280
	s_and_not1_b32 vcc_lo, exec_lo, s8                         // 00000002D4DC: 916A087E
	s_lshl_b32 s29, s2, 6                                      // 00000002D4E0: 841D8602
	s_cbranch_vccnz 3633                                       // 00000002D4E4: BFA40E31 <_ZL9mul_mat_qIL9ggml_type18ELi16ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x3aac>
	s_load_b128 s[20:23], s[0:1], null                         // 00000002D4E8: F4080500 F8000000
	s_add_i32 s0, s5, s28                                      // 00000002D4F0: 81001C05
	s_mul_hi_u32 s5, s4, s6                                    // 00000002D4F4: 96850604
	s_mul_i32 s0, s0, 36                                       // 00000002D4F8: 9600A400
	v_lshrrev_b32_e32 v2, 3, v1                                // 00000002D4FC: 32040283
	s_add_i32 s0, s0, s3                                       // 00000002D500: 81000300
	s_mul_hi_u32 s6, s31, s14                                  // 00000002D504: 96860E1F
	s_ashr_i32 s1, s0, 31                                      // 00000002D508: 86019F00
	s_mov_b32 s8, 0                                            // 00000002D50C: BE880080
	s_lshl_b64 s[0:1], s[0:1], 2                               // 00000002D510: 84808200
	v_lshl_add_u32 v2, v16, 2, v2                              // 00000002D514: D6460002 04090510
	s_mov_b32 s9, s8                                           // 00000002D51C: BE890008
	s_mov_b32 s10, s8                                          // 00000002D520: BE8A0008
	s_mov_b32 s12, s8                                          // 00000002D524: BE8C0008
	s_mov_b32 s13, s8                                          // 00000002D528: BE8D0008
	s_mov_b32 s14, s8                                          // 00000002D52C: BE8E0008
	v_mul_lo_u32 v20, s17, v2                                  // 00000002D530: D72C0014 00020411
	v_mul_u32_u24_e32 v2, 0x130, v2                            // 00000002D538: 160404FF 00000130
	v_mul_u32_u24_e32 v9, 36, v18                              // 00000002D540: 161224A4
	v_lshl_add_u32 v10, v16, 4, v17                            // 00000002D544: D646000A 04450910
	s_waitcnt lgkmcnt(0)                                       // 00000002D54C: BF89FC07
	s_add_u32 s0, s22, s0                                      // 00000002D550: 80000016
	s_addc_u32 s1, s23, s1                                     // 00000002D554: 82010117
	s_add_i32 s3, s4, s5                                       // 00000002D558: 81030504
	s_add_i32 s31, s31, s6                                     // 00000002D55C: 811F061F
	s_lshr_b32 s3, s3, s7                                      // 00000002D560: 85030703
	s_lshr_b32 s5, s31, s15                                    // 00000002D564: 85050F1F
	s_mul_i32 s3, s3, s11                                      // 00000002D568: 96030B03
	s_mov_b32 s11, s8                                          // 00000002D56C: BE8B0008
	s_mov_b32 s15, s8                                          // 00000002D570: BE8F0008
	v_and_b32_e32 v1, 7, v1                                    // 00000002D574: 36020287
	v_mov_b32_e32 v19, 0                                       // 00000002D578: 7E260280
	s_lshl_b32 s4, s17, 4                                      // 00000002D57C: 84048411
	v_lshlrev_b32_e32 v0, 2, v0                                // 00000002D580: 30000082
	v_add_nc_u32_e32 v21, s4, v20                              // 00000002D584: 4A2A2804
	v_lshlrev_b32_e32 v4, 5, v1                                // 00000002D588: 30080285
	v_lshlrev_b32_e32 v3, 2, v1                                // 00000002D58C: 30060282
	v_lshlrev_b32_e32 v1, 1, v1                                // 00000002D590: 30020281
	v_mad_u32_u24 v11, 0x1300, v16, 0                          // 00000002D594: D60B000B 020220FF 00001300
	v_mul_u32_u24_e32 v12, 0x130, v18                          // 00000002D5A0: 161824FF 00000130
	v_add3_u32 v4, 0, v2, v4                                   // 00000002D5A8: D6550004 04120480
	v_dual_mov_b32 v34, 0 :: v_dual_add_nc_u32 v5, 0, v3       // 00000002D5B0: CA200080 22040680
	v_lshl_add_u32 v25, v9, 2, 0                               // 00000002D5B8: D6460019 02010509
	v_mad_u32_u24 v26, 0x130, v10, 0                           // 00000002D5C0: D60B001A 020214FF 00000130
	s_delay_alu instid0(VALU_DEP_4)                            // 00000002D5CC: BF870004
	v_add_nc_u32_e32 v6, 0x1300, v4                            // 00000002D5D0: 4A0C08FF 00001300
	v_dual_mov_b32 v32, 0 :: v_dual_add_nc_u32 v7, 0x2600, v4  // 00000002D5D8: CA200080 200608FF 00002600
	v_add_nc_u32_e32 v8, 0x3900, v4                            // 00000002D5E4: 4A1008FF 00003900
	v_dual_mov_b32 v28, 0 :: v_dual_add_nc_u32 v27, 0, v0      // 00000002D5EC: CA200080 1C1A0080
	v_add_co_u32 v31, s0, s0, v0                               // 00000002D5F4: D700001F 00020000
	v_dual_mov_b32 v35, 0 :: v_dual_lshlrev_b32 v36, 1, v3     // 00000002D5FC: CA220080 23240681
	v_dual_mov_b32 v24, 0 :: v_dual_lshlrev_b32 v37, 1, v1     // 00000002D604: CA220080 18240281
	v_dual_mov_b32 v29, 0 :: v_dual_add_nc_u32 v38, 0xa40, v4  // 00000002D60C: CA200080 1D2608FF 00000A40
	v_add_nc_u32_e32 v39, 0xa48, v4                            // 00000002D618: 4A4E08FF 00000A48
	v_add_nc_u32_e32 v40, 0xa50, v4                            // 00000002D620: 4A5008FF 00000A50
	v_add_nc_u32_e32 v41, 0xa58, v4                            // 00000002D628: 4A5208FF 00000A58
	v_add_nc_u32_e32 v9, v5, v2                                // 00000002D630: 4A120505
	v_add_nc_u32_e32 v42, 0xa40, v6                            // 00000002D634: 4A540CFF 00000A40
	v_add_nc_u32_e32 v43, 0xa48, v6                            // 00000002D63C: 4A560CFF 00000A48
	v_add_nc_u32_e32 v44, 0xa50, v6                            // 00000002D644: 4A580CFF 00000A50
	v_add_nc_u32_e32 v45, 0xa58, v6                            // 00000002D64C: 4A5A0CFF 00000A58
	v_add_nc_u32_e32 v46, 0xa40, v7                            // 00000002D654: 4A5C0EFF 00000A40
	v_add_nc_u32_e32 v47, 0xa48, v7                            // 00000002D65C: 4A5E0EFF 00000A48
	v_add_nc_u32_e32 v48, 0xa50, v7                            // 00000002D664: 4A600EFF 00000A50
	v_dual_mov_b32 v0, s8 :: v_dual_add_nc_u32 v49, 0xa58, v7  // 00000002D66C: CA200008 00300EFF 00000A58
	v_dual_mov_b32 v1, s9 :: v_dual_add_nc_u32 v22, s4, v21    // 00000002D678: CA200009 01162A04
	s_mul_i32 s2, s17, s29                                     // 00000002D680: 96021D11
	s_mul_i32 s5, s5, s24                                      // 00000002D684: 96051805
	v_add_co_ci_u32_e64 v33, null, s1, 0, s0                   // 00000002D688: D5207C21 00010001
	s_delay_alu instid0(VALU_DEP_2)                            // 00000002D690: BF870002
	v_dual_mov_b32 v30, 0 :: v_dual_add_nc_u32 v23, s4, v22    // 00000002D694: CA200080 1E162C04
	v_add_nc_u32_e32 v54, v11, v12                             // 00000002D69C: 4A6C190B
	v_dual_mov_b32 v2, s10 :: v_dual_mov_b32 v3, s11           // 00000002D6A0: CA10000A 0202000B
	v_dual_mov_b32 v4, s12 :: v_dual_mov_b32 v5, s13           // 00000002D6A8: CA10000C 0404000D
	v_add_nc_u32_e32 v50, 0xa40, v8                            // 00000002D6B0: 4A6410FF 00000A40
	v_add_nc_u32_e32 v51, 0xa48, v8                            // 00000002D6B8: 4A6610FF 00000A48
	v_add_nc_u32_e32 v52, 0xa50, v8                            // 00000002D6C0: 4A6810FF 00000A50
	v_dual_mov_b32 v6, s14 :: v_dual_add_nc_u32 v53, 0xa58, v8 // 00000002D6C8: CA20000E 063410FF 00000A58
	v_mov_b32_e32 v7, s15                                      // 00000002D6D4: 7E0E020F
	v_add_nc_u32_e32 v55, 0xb40, v26                           // 00000002D6D8: 4A6E34FF 00000B40
	v_add_nc_u32_e32 v56, 0xda0, v26                           // 00000002D6E0: 4A7034FF 00000DA0
	v_add_nc_u32_e32 v57, 0x1000, v26                          // 00000002D6E8: 4A7234FF 00001000
	v_add_nc_u32_e32 v58, 0x1260, v26                          // 00000002D6F0: 4A7434FF 00001260
	v_add_nc_u32_e32 v59, 0x14c0, v26                          // 00000002D6F8: 4A7634FF 000014C0
	v_add_nc_u32_e32 v60, 0x1720, v26                          // 00000002D700: 4A7834FF 00001720
	v_add_nc_u32_e32 v61, 0x1980, v26                          // 00000002D708: 4A7A34FF 00001980
	v_add_nc_u32_e32 v62, 0x1be0, v26                          // 00000002D710: 4A7C34FF 00001BE0
	v_add_nc_u32_e32 v63, 0xb48, v26                           // 00000002D718: 4A7E34FF 00000B48
	v_add_nc_u32_e32 v64, 0xda8, v26                           // 00000002D720: 4A8034FF 00000DA8
	v_add_nc_u32_e32 v65, 0x1008, v26                          // 00000002D728: 4A8234FF 00001008
	v_add_nc_u32_e32 v66, 0x1268, v26                          // 00000002D730: 4A8434FF 00001268
	v_add_nc_u32_e32 v67, 0x14c8, v26                          // 00000002D738: 4A8634FF 000014C8
	v_add_nc_u32_e32 v68, 0x1728, v26                          // 00000002D740: 4A8834FF 00001728
	v_add_nc_u32_e32 v69, 0x1988, v26                          // 00000002D748: 4A8A34FF 00001988
	v_add_nc_u32_e32 v70, 0x1be8, v26                          // 00000002D750: 4A8C34FF 00001BE8
	v_add_nc_u32_e32 v71, 0xb50, v26                           // 00000002D758: 4A8E34FF 00000B50
	v_add_nc_u32_e32 v72, 0xdb0, v26                           // 00000002D760: 4A9034FF 00000DB0
	v_add_nc_u32_e32 v73, 0x1010, v26                          // 00000002D768: 4A9234FF 00001010
	v_add_nc_u32_e32 v74, 0x1270, v26                          // 00000002D770: 4A9434FF 00001270
	v_add_nc_u32_e32 v75, 64, v9                               // 00000002D778: 4A9612C0
	v_add_nc_u32_e32 v76, 64, v27                              // 00000002D77C: 4A9836C0
	v_add_nc_u32_e32 v77, 0x14d0, v26                          // 00000002D780: 4A9A34FF 000014D0
	v_add_nc_u32_e32 v78, 0x1730, v26                          // 00000002D788: 4A9C34FF 00001730
	v_add_nc_u32_e32 v79, 0x1990, v26                          // 00000002D790: 4A9E34FF 00001990
	v_add_nc_u32_e32 v80, 0x1bf0, v26                          // 00000002D798: 4AA034FF 00001BF0
	v_add_nc_u32_e32 v81, 0xb58, v26                           // 00000002D7A0: 4AA234FF 00000B58
	v_add_nc_u32_e32 v82, 0xdb8, v26                           // 00000002D7A8: 4AA434FF 00000DB8
	v_add_nc_u32_e32 v83, 0x1018, v26                          // 00000002D7B0: 4AA634FF 00001018
	v_add_nc_u32_e32 v84, 0x1278, v26                          // 00000002D7B8: 4AA834FF 00001278
	s_add_i32 s2, s5, s2                                       // 00000002D7C0: 81020205
	s_mul_i32 s12, s18, 36                                     // 00000002D7C4: 960CA412
	s_add_i32 s7, s2, s3                                       // 00000002D7C8: 81070302
	s_mul_i32 s13, s18, 0x48                                   // 00000002D7CC: 960DFF12 00000048
	s_mul_i32 s0, s7, 0x62                                     // 00000002D7D4: 9600FF07 00000062
	s_mul_hi_i32 s1, s7, 0x62                                  // 00000002D7DC: 9701FF07 00000062
	s_add_u32 s0, s20, s0                                      // 00000002D7E4: 80000014
	s_addc_u32 s1, s21, s1                                     // 00000002D7E8: 82010115
	s_getpc_b64 s[10:11]                                       // 00000002D7EC: BE8A4700
	s_add_u32 s10, s10, 0xffff9210                             // 00000002D7F0: 800AFF0A FFFF9210
	s_addc_u32 s11, s11, lit(0xffffffff)                       // 00000002D7F8: 820BFF0B FFFFFFFF
	v_mad_i64_i32 v[8:9], null, 0x62, v20, s[0:1]              // 00000002D800: D6FF7C08 000228FF 00000062
	s_ashr_i32 s9, s8, 31                                      // 00000002D80C: 86099F08
	s_add_i32 s30, s30, -1                                     // 00000002D810: 811EC11E
	s_add_i32 s7, s7, 1                                        // 00000002D814: 81078107
	v_add_co_u32 v12, vcc_lo, v8, v36                          // 00000002D818: D7006A0C 00024908
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002D820: BF8700A1
	v_add_co_ci_u32_e64 v13, null, 0, v9, vcc_lo               // 00000002D824: D5207C0D 01AA1280
	v_add_co_u32 v14, vcc_lo, v8, v37                          // 00000002D82C: D7006A0E 00024B08
	v_add_co_ci_u32_e64 v15, null, 0, v9, vcc_lo               // 00000002D834: D5207C0F 01AA1280
	global_load_d16_b16 v85, v[8:9], off                       // 00000002D83C: DC820000 557C0008
	v_mad_i64_i32 v[8:9], null, 0x62, v21, s[0:1]              // 00000002D844: D6FF7C08 00022AFF 00000062
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002D850: BF870091
	v_add_co_u32 v10, vcc_lo, v8, v36                          // 00000002D854: D7006A0A 00024908
	v_add_co_ci_u32_e64 v11, null, 0, v9, vcc_lo               // 00000002D85C: D5207C0B 01AA1280
	s_clause 0x3                                               // 00000002D864: BF850003
	global_load_b64 v[10:11], v[10:11], off offset:2           // 00000002D868: DC560002 0A7C000A
	global_load_b32 v87, v[14:15], off offset:66               // 00000002D870: DC520042 577C000E
	global_load_b64 v[14:15], v[12:13], off offset:2           // 00000002D878: DC560002 0E7C000C
	global_load_d16_b16 v89, v[8:9], off                       // 00000002D880: DC820000 597C0008
	s_waitcnt vmcnt(4)                                         // 00000002D888: BF8913F7
	v_cvt_f32_f16_e32 v12, v85.l                               // 00000002D88C: 7E181755
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000002D890: BF8700B1
	v_mul_f32_e32 v12, 0.5, v12                                // 00000002D894: 101818F0
	s_waitcnt vmcnt(2)                                         // 00000002D898: BF890BF7
	v_lshrrev_b32_e32 v13, 28, v87                             // 00000002D89C: 321AAE9C
	v_cvt_f32_ubyte0_e32 v13, v13                              // 00000002D8A0: 7E1A230D
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002D8A4: BF8700A1
	v_fma_mix_f32 v93, v13, v85, v12 op_sel_hi:[0,1,0]         // 00000002D8A8: CC20005D 1432AB0D
	v_add_co_u32 v85, vcc_lo, v8, v37                          // 00000002D8B0: D7006A55 00024B08
	v_add_co_ci_u32_e64 v86, null, 0, v9, vcc_lo               // 00000002D8B8: D5207C56 01AA1280
	v_mad_i64_i32 v[8:9], null, 0x62, v22, s[0:1]              // 00000002D8C0: D6FF7C08 00022CFF 00000062
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002D8CC: BF870091
	v_add_co_u32 v12, vcc_lo, v8, v36                          // 00000002D8D0: D7006A0C 00024908
	v_add_co_ci_u32_e64 v13, null, 0, v9, vcc_lo               // 00000002D8D8: D5207C0D 01AA1280
	s_clause 0x1                                               // 00000002D8E0: BF850001
	global_load_b64 v[12:13], v[12:13], off offset:2           // 00000002D8E4: DC560002 0C7C000C
	global_load_b32 v88, v[85:86], off offset:66               // 00000002D8EC: DC520042 587C0055
	s_waitcnt vmcnt(2)                                         // 00000002D8F4: BF890BF7
	v_cvt_f32_f16_e32 v85, v89.l                               // 00000002D8F8: 7EAA1759
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000002D8FC: BF8700B1
	v_mul_f32_e32 v85, 0.5, v85                                // 00000002D900: 10AAAAF0
	s_waitcnt vmcnt(0)                                         // 00000002D904: BF8903F7
	v_lshrrev_b32_e32 v86, 28, v88                             // 00000002D908: 32ACB09C
	v_cvt_f32_ubyte0_e32 v86, v86                              // 00000002D90C: 7EAC2356
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002D910: BF8700A1
	v_fma_mix_f32 v94, v86, v89, v85 op_sel_hi:[0,1,0]         // 00000002D914: CC20005E 1556B356
	v_add_co_u32 v85, vcc_lo, v8, v37                          // 00000002D91C: D7006A55 00024B08
	v_add_co_ci_u32_e64 v86, null, 0, v9, vcc_lo               // 00000002D924: D5207C56 01AA1280
	s_clause 0x1                                               // 00000002D92C: BF850001
	global_load_d16_b16 v8, v[8:9], off                        // 00000002D930: DC820000 087C0008
	global_load_b32 v86, v[85:86], off offset:66               // 00000002D938: DC520042 567C0055
	s_waitcnt vmcnt(1)                                         // 00000002D940: BF8907F7
	v_cvt_f32_f16_e32 v9, v8.l                                 // 00000002D944: 7E121708
	s_waitcnt vmcnt(0)                                         // 00000002D948: BF8903F7
	v_lshrrev_b32_e32 v85, 28, v86                             // 00000002D94C: 32AAAC9C
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002D950: BF870112
	v_mul_f32_e32 v9, 0.5, v9                                  // 00000002D954: 101212F0
	v_cvt_f32_ubyte0_e32 v85, v85                              // 00000002D958: 7EAA2355
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002D95C: BF8700A1
	v_fma_mix_f32 v95, v85, v8, v9 op_sel_hi:[0,1,0]           // 00000002D960: CC20005F 14261155
	v_mad_i64_i32 v[8:9], null, 0x62, v23, s[0:1]              // 00000002D968: D6FF7C08 00022EFF 00000062
	v_add_co_u32 v89, vcc_lo, v8, v37                          // 00000002D974: D7006A59 00024B08
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002D97C: BF8700A1
	v_add_co_ci_u32_e64 v90, null, 0, v9, vcc_lo               // 00000002D980: D5207C5A 01AA1280
	v_add_co_u32 v91, vcc_lo, v8, v36                          // 00000002D988: D7006A5B 00024908
	v_add_co_ci_u32_e64 v92, null, 0, v9, vcc_lo               // 00000002D990: D5207C5C 01AA1280
	s_clause 0x2                                               // 00000002D998: BF850002
	global_load_d16_b16 v96, v[8:9], off                       // 00000002D99C: DC820000 607C0008
	global_load_b32 v85, v[89:90], off offset:66               // 00000002D9A4: DC520042 557C0059
	global_load_b64 v[8:9], v[91:92], off offset:2             // 00000002D9AC: DC560002 087C005B
	v_lshrrev_b32_e32 v92, 22, v14                             // 00000002D9B4: 32B81C96
	v_mul_f32_e32 v91, 0.5, v94                                // 00000002D9B8: 10B6BCF0
	v_lshrrev_b32_e32 v94, 6, v14                              // 00000002D9BC: 32BC1C86
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002D9C0: BF870113
	v_and_b32_e32 v92, 0x3fc, v92                              // 00000002D9C4: 36B8B8FF 000003FC
	v_and_b32_e32 v94, 0x3fc, v94                              // 00000002D9CC: 36BCBCFF 000003FC
	s_waitcnt vmcnt(2)                                         // 00000002D9D4: BF890BF7
	v_cvt_f32_f16_e32 v89, v96.l                               // 00000002D9D8: 7EB21760
	s_waitcnt vmcnt(1)                                         // 00000002D9DC: BF8907F7
	v_lshrrev_b32_e32 v90, 28, v85                             // 00000002D9E0: 32B4AA9C
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002D9E4: BF870112
	v_mul_f32_e32 v89, 0.5, v89                                // 00000002D9E8: 10B2B2F0
	v_cvt_f32_ubyte0_e32 v90, v90                              // 00000002D9EC: 7EB4235A
	s_delay_alu instid0(VALU_DEP_1)                            // 00000002D9F0: BF870001
	v_fma_mix_f32 v89, v90, v96, v89 op_sel_hi:[0,1,0]         // 00000002D9F4: CC200059 1566C15A
	v_mul_f32_e32 v90, 0.5, v93                                // 00000002D9FC: 10B4BAF0
	v_lshrrev_b32_e32 v93, 14, v14                             // 00000002DA00: 32BA1C8E
	ds_store_2addr_stride64_b32 v75, v90, v91 offset0:11 offset1:30// 00000002DA04: D83C1E0B 005B5A4B
	v_dual_mul_f32 v90, 0.5, v95 :: v_dual_and_b32 v95, 0xff, v14// 00000002DA0C: C8E4BEF0 5A5E1CFF 000000FF
	v_and_b32_e32 v14, 0xff, v87                               // 00000002DA18: 361CAEFF 000000FF
	v_and_b32_e32 v91, 0xff, v15                               // 00000002DA20: 36B61EFF 000000FF
	v_and_b32_e32 v93, 0x3fc, v93                              // 00000002DA28: 36BABAFF 000003FC
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002DA30: BF870214
	v_lshlrev_b32_e32 v95, 2, v95                              // 00000002DA34: 30BEBE82
	v_bcnt_u32_b32 v96, v14, 0                                 // 00000002DA38: D71E0060 0001010E
	v_mul_f32_e32 v89, 0.5, v89                                // 00000002DA40: 10B2B2F0
	v_lshlrev_b32_e32 v91, 2, v91                              // 00000002DA44: 30B6B682
	s_delay_alu instid0(VALU_DEP_3)                            // 00000002DA48: BF870003
	v_and_b32_e32 v96, 1, v96                                  // 00000002DA4C: 36C0C081
	ds_store_2addr_stride64_b32 v75, v90, v89 offset0:49 offset1:68// 00000002DA50: D83C4431 00595A4B
	v_lshrrev_b32_e32 v90, 6, v15                              // 00000002DA58: 32B41E86
	v_lshrrev_b32_e32 v89, 14, v15                             // 00000002DA5C: 32B21E8E
	v_lshrrev_b32_e32 v15, 22, v15                             // 00000002DA60: 321E1E96
	v_lshlrev_b32_e32 v96, 7, v96                              // 00000002DA64: 30C0C087
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002DA68: BF870214
	v_and_b32_e32 v90, 0x3fc, v90                              // 00000002DA6C: 36B4B4FF 000003FC
	v_and_b32_e32 v89, 0x3fc, v89                              // 00000002DA74: 36B2B2FF 000003FC
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002DA7C: BF870214
	v_and_b32_e32 v15, 0x3fc, v15                              // 00000002DA80: 361E1EFF 000003FC
	v_xor_b32_e32 v14, v96, v14                                // 00000002DA88: 3A1C1D60
	v_bfe_u32 v96, v87, 7, 8                                   // 00000002DA8C: D6100060 02210F57
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002DA94: BF870112
	v_mul_lo_u32 v100, 0x1010101, v14                          // 00000002DA98: D72C0064 00021CFF 01010101
	v_bcnt_u32_b32 v97, v96, 0                                 // 00000002DAA4: D71E0061 00010160
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002DAAC: BF870191
	v_and_b32_e32 v97, 1, v97                                  // 00000002DAB0: 36C2C281
	v_and_b32_e32 v101, 0x80402010, v100                       // 00000002DAB4: 36CAC8FF 80402010
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002DABC: BF870092
	v_lshlrev_b32_e32 v97, 7, v97                              // 00000002DAC0: 30C2C287
	v_xor_b32_e32 v96, v97, v96                                // 00000002DAC4: 3AC0C161
	v_and_b32_e32 v97, 0x8040201, v100                         // 00000002DAC8: 36C2C8FF 08040201
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002DAD0: BF870112
	v_mul_lo_u32 v105, 0x1010101, v96                          // 00000002DAD4: D72C0069 0002C0FF 01010101
	v_lshrrev_b16 v14.l, 8, v97.l                              // 00000002DAE0: D739000E 0002C288
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002DAE8: BF870211
	v_cmp_ne_u16_e64 s4, 0, v14.l                              // 00000002DAEC: D43D0004 00021C80
	v_lshrrev_b32_e32 v14, 24, v97                             // 00000002DAF4: 321CC298
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000002DAF8: BF8701A4
	v_and_b32_e32 v96, 0x8040201, v105                         // 00000002DAFC: 36C0D2FF 08040201
	v_bfe_i32 v97, v100, 0, 1                                  // 00000002DB04: D6110061 02050164
	v_cmp_ne_u16_e64 s5, 0, v14.l                              // 00000002DB0C: D43D0005 00021C80
	v_lshrrev_b16 v14.l, 8, v101.l                             // 00000002DB14: D739000E 0002CA88
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000002DB1C: BF8701A3
	v_mov_b16_e32 v99.l, v97.l                                 // 00000002DB20: 7EC63961
	v_cndmask_b32_e64 v97, 0, -1, s4                           // 00000002DB24: D5010061 00118280
	v_cmp_ne_u16_e64 s1, 0, v14.l                              // 00000002DB2C: D43D0001 00021C80
	v_lshrrev_b32_e32 v14, 24, v101                            // 00000002DB34: 321CCA98
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_4)// 00000002DB38: BF870233
	v_lshlrev_b16 v98.h, 8, v97.l op_sel:[0,0,1]               // 00000002DB3C: D7384062 0002C288
	v_and_b16 v97.l, 0xff, v99.l                               // 00000002DB44: D7620061 0002C6FF 000000FF
	v_lshrrev_b16 v101.l, 4, v101.l                            // 00000002DB50: D7390065 0002CA84
	v_cmp_ne_u16_e64 s6, 0, v14.l                              // 00000002DB58: D43D0006 00021C80
	v_lshrrev_b16 v14.l, 8, v96.l                              // 00000002DB60: D739000E 0002C088
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000002DB68: BF8701A4
	v_or_b16 v102.l, v97.l, v98.h op_sel:[0,1,0]               // 00000002DB6C: D7631066 0002C561
	v_lshrrev_b32_e32 v97, 22, v100                            // 00000002DB74: 32C2C896
	v_cmp_ne_u16_e64 s0, 0, v14.l                              // 00000002DB78: D43D0000 00021C80
	v_lshrrev_b32_e32 v14, 24, v96                             // 00000002DB80: 321CC098
	v_and_b32_e32 v96, 0x80402010, v105                        // 00000002DB84: 36C0D2FF 80402010
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002DB8C: BF870194
	v_bfe_i32 v97, v97, 0, 1                                   // 00000002DB90: D6110061 02050161
	v_cmp_ne_u16_e64 s3, 0, v14.l                              // 00000002DB98: D43D0003 00021C80
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002DBA0: BF870113
	v_lshrrev_b16 v14.l, 8, v96.l                              // 00000002DBA4: D739000E 0002C088
	v_cndmask_b32_e64 v103, 0, -1, s3                          // 00000002DBAC: D5010067 000D8280
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002DBB4: BF8700A2
	v_cmp_ne_u16_e32 vcc_lo, 0, v14.l                          // 00000002DBB8: 7C7A1C80
	v_lshrrev_b32_e32 v14, 24, v96                             // 00000002DBBC: 321CC098
	v_cmp_ne_u16_e64 s2, 0, v14.l                              // 00000002DBC0: D43D0002 00021C80
	v_lshrrev_b32_e32 v14, 18, v100                            // 00000002DBC8: 321CC892
	v_mov_b16_e32 v100.l, v97.l                                // 00000002DBCC: 7EC83961
	v_cndmask_b32_e64 v97, 0, -1, s6                           // 00000002DBD0: D5010061 00198280
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002DBD8: BF870113
	v_bfe_i32 v14, v14, 0, 1                                   // 00000002DBDC: D611000E 0205010E
	v_lshlrev_b16 v99.h, 8, v97.l op_sel:[0,0,1]               // 00000002DBE4: D7384063 0002C288
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002DBEC: BF8700A2
	v_mov_b16_e32 v98.l, v14.l                                 // 00000002DBF0: 7EC4390E
	v_cndmask_b32_e64 v14, 0, -1, s5                           // 00000002DBF4: D501000E 00158280
	v_lshlrev_b16 v96.h, 8, v14.l op_sel:[0,0,1]               // 00000002DBFC: D7384060 00021C88
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002DC04: BF870093
	v_and_b16 v14.l, 0xff, v98.l                               // 00000002DC08: D762000E 0002C4FF 000000FF
	v_or_b16 v14.h, v14.l, v96.h op_sel:[0,1,1]                // 00000002DC14: D763500E 0002C10E
	v_mov_b16_e32 v14.l, 0                                     // 00000002DC1C: 7E1C3880
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000002DC20: BF8701B1
	v_mov_b16_e32 v102.h, v14.l                                // 00000002DC24: 7FCC390E
	v_mov_b16_e32 v104.h, v14.l                                // 00000002DC28: 7FD0390E
	v_mov_b16_e32 v107.h, v14.l                                // 00000002DC2C: 7FD6390E
	v_or_b32_e32 v97, v102, v14                                // 00000002DC30: 38C21D66
	v_bfe_i32 v102, v101, 0, 1                                 // 00000002DC34: D6110066 02050165
	v_cndmask_b32_e64 v101, 0, -1, s1                          // 00000002DC3C: D5010065 00058280
	v_and_b16 v14.h, 0xff, v100.l op_sel:[0,0,1]               // 00000002DC44: D762400E 0002C8FF 000000FF
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002DC50: BF870212
	v_lshlrev_b16 v100.h, 8, v101.l op_sel:[0,0,1]             // 00000002DC54: D7384064 0002CA88
	v_and_b16 v101.l, 0xff, v102.l                             // 00000002DC5C: D7620065 0002CCFF 000000FF
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002DC68: BF870113
	v_or_b16 v14.h, v14.h, v99.h op_sel:[1,1,1]                // 00000002DC6C: D763580E 0002C70E
	v_or_b16 v104.l, v101.l, v100.h op_sel:[0,1,0]             // 00000002DC74: D7631068 0002C965
	v_lshrrev_b32_e32 v101, 18, v105                           // 00000002DC7C: 32CAD292
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002DC80: BF870112
	v_or_b32_e32 v106, v104, v14                               // 00000002DC84: 38D41D68
	v_bfe_i32 v101, v101, 0, 1                                 // 00000002DC88: D6110065 02050165
	v_lshlrev_b16 v101.h, 8, v103.l op_sel:[0,0,1]             // 00000002DC90: D7384065 0002CE88
	v_bfe_i32 v103, v105, 0, 1                                 // 00000002DC98: D6110067 02050169
	v_cndmask_b32_e64 v104, 0, -1, s0                          // 00000002DCA0: D5010068 00018280
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002DCA8: BF870194
	v_and_b16 v14.h, 0xff, v101.l op_sel:[0,0,1]               // 00000002DCAC: D762400E 0002CAFF 000000FF
	v_and_b16 v103.h, 0xff, v103.l op_sel:[0,0,1]              // 00000002DCB8: D7624067 0002CEFF 000000FF
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_4)// 00000002DCC4: BF870223
	v_lshlrev_b16 v102.h, 8, v104.l op_sel:[0,0,1]             // 00000002DCC8: D7384066 0002D088
	v_lshrrev_b32_e32 v104, 22, v105                           // 00000002DCD0: 32D0D296
	v_or_b16 v14.h, v14.h, v101.h op_sel:[1,1,1]               // 00000002DCD4: D763580E 0002CB0E
	v_cndmask_b32_e64 v105, 0, -1, s2                          // 00000002DCDC: D5010069 00098280
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002DCE4: BF870214
	v_or_b16 v107.l, v103.h, v102.h op_sel:[1,1,0]             // 00000002DCE8: D763186B 0002CD67
	v_bfe_i32 v104, v104, 0, 1                                 // 00000002DCF0: D6110068 02050168
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002DCF8: BF870193
	v_lshlrev_b16 v103.h, 8, v105.l op_sel:[0,0,1]             // 00000002DCFC: D7384067 0002D288
	v_or_b32_e32 v105, v107, v14                               // 00000002DD04: 38D21D6B
	s_clause 0x7                                               // 00000002DD08: BF850007
	global_load_b32 v95, v95, s[10:11]                         // 00000002DD0C: DC520000 5F0A005F
	global_load_b32 v94, v94, s[10:11]                         // 00000002DD14: DC520000 5E0A005E
	global_load_b32 v93, v93, s[10:11]                         // 00000002DD1C: DC520000 5D0A005D
	global_load_b32 v107, v92, s[10:11]                        // 00000002DD24: DC520000 6B0A005C
	global_load_b32 v91, v91, s[10:11]                         // 00000002DD2C: DC520000 5B0A005B
	global_load_b32 v90, v90, s[10:11]                         // 00000002DD34: DC520000 5A0A005A
	global_load_b32 v89, v89, s[10:11]                         // 00000002DD3C: DC520000 590A0059
	global_load_b32 v15, v15, s[10:11]                         // 00000002DD44: DC520000 0F0A000F
	v_lshrrev_b16 v92.l, 4, v96.l                              // 00000002DD4C: D739005C 0002C084
	v_and_b16 v14.h, 0xff, v104.l op_sel:[0,0,1]               // 00000002DD54: D762400E 0002D0FF 000000FF
	s_delay_alu instid0(VALU_DEP_1)                            // 00000002DD60: BF870001
	v_or_b16 v14.h, v14.h, v103.h op_sel:[1,1,1]               // 00000002DD64: D763580E 0002CF0E
	s_waitcnt vmcnt(7)                                         // 00000002DD6C: BF891FF7
	v_xor_b32_e32 v95, v95, v97                                // 00000002DD70: 3ABEC35F
	s_waitcnt vmcnt(6)                                         // 00000002DD74: BF891BF7
	v_xor_b32_e32 v94, v94, v106                               // 00000002DD78: 3ABCD55E
	s_waitcnt vmcnt(5)                                         // 00000002DD7C: BF8917F7
	v_xor_b32_e32 v97, v93, v105                               // 00000002DD80: 3AC2D35D
	v_bfe_i32 v93, v92, 0, 1                                   // 00000002DD84: D611005D 0205015C
	v_cndmask_b32_e64 v92, 0, -1, vcc_lo                       // 00000002DD8C: D501005C 01A98280
	v_mov_b16_e32 v105.h, v14.l                                // 00000002DD94: 7FD2390E
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002DD98: BF870193
	v_and_b16 v92.h, 0xff, v93.l op_sel:[0,0,1]                // 00000002DD9C: D762405C 0002BAFF 000000FF
	v_lshlrev_b16 v92.l, 8, v92.l                              // 00000002DDA8: D738005C 0002B888
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002DDB0: BF870121
	v_or_b16 v105.l, v92.h, v92.l op_sel:[1,0,0]               // 00000002DDB4: D7630869 0002B95C
	v_lshlrev_b16 v92.h, 8, v95.l op_sel:[0,0,1]               // 00000002DDBC: D738405C 0002BE88
	v_or_b32_e32 v105, v105, v14                               // 00000002DDC4: 38D21D69
	v_and_b16 v14.h, 0xff00, v95.l op_sel:[0,0,1]              // 00000002DDC8: D762400E 0002BEFF FFFFFF00
	s_waitcnt vmcnt(4)                                         // 00000002DDD4: BF8913F7
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002DDD8: BF870112
	v_xor_b32_e32 v105, v107, v105                             // 00000002DDDC: 3AD2D36B
	v_sub_nc_i16 v96.l, v14.h, v98.h op_sel:[1,1,0] clamp      // 00000002DDE0: D70E9860 0002C50E
	v_lshlrev_b16 v14.h, 8, v99.l op_sel:[0,0,1]               // 00000002DDE8: D738400E 0002C688
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000002DDF0: BF8701B1
	v_sub_nc_i16 v95.l, v92.h, v14.h op_sel:[1,1,0] clamp      // 00000002DDF4: D70E985F 00021D5C
	v_and_b16 v14.h, 0xff00, v95.h op_sel:[0,1,1]              // 00000002DDFC: D762500E 0002BEFF FFFFFF00
	v_lshlrev_b16 v92.h, 8, v95.h op_sel:[0,1,1]               // 00000002DE08: D738505C 0002BE88
	v_perm_b32 v95, v95, v96, 0xc0c0105                        // 00000002DE10: D644005F 03FEC15F 0C0C0105
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002DE1C: BF8700A3
	v_sub_nc_i16 v99.l, v14.h, v96.h op_sel:[1,1,0] clamp      // 00000002DE20: D70E9863 0002C10E
	v_lshlrev_b16 v14.h, 8, v98.l op_sel:[0,0,1]               // 00000002DE28: D738400E 0002C488
	v_sub_nc_i16 v98.l, v92.h, v14.h op_sel:[1,1,0] clamp      // 00000002DE30: D70E9862 00021D5C
	v_and_b16 v14.h, 0xff00, v94.l op_sel:[0,0,1]              // 00000002DE38: D762400E 0002BCFF FFFFFF00
	v_lshlrev_b16 v92.h, 8, v94.l op_sel:[0,0,1]               // 00000002DE44: D738405C 0002BC88
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002DE4C: BF870193
	v_perm_b32 v96, v98, v99, 0xc0c0105                        // 00000002DE50: D6440060 03FEC762 0C0C0105
	v_sub_nc_i16 v106.l, v14.h, v100.h op_sel:[1,1,0] clamp    // 00000002DE5C: D70E986A 0002C90E
	v_lshlrev_b16 v14.h, 8, v102.l op_sel:[0,0,1]              // 00000002DE64: D738400E 0002CC88
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002DE6C: BF870113
	v_lshl_or_b32 v95, v96, 16, v95                            // 00000002DE70: D656005F 057D2160
	v_sub_nc_i16 v94.l, v92.h, v14.h op_sel:[1,1,0] clamp      // 00000002DE78: D70E985E 00021D5C
	v_and_b16 v14.h, 0xff00, v94.h op_sel:[0,1,1]              // 00000002DE80: D762500E 0002BCFF FFFFFF00
	v_lshlrev_b16 v92.h, 8, v94.h op_sel:[0,1,1]               // 00000002DE8C: D738505C 0002BC88
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002DE94: BF870193
	v_perm_b32 v94, v94, v106, 0xc0c0105                       // 00000002DE98: D644005E 03FED55E 0C0C0105
	v_sub_nc_i16 v102.l, v14.h, v99.h op_sel:[1,1,0] clamp     // 00000002DEA4: D70E9866 0002C70E
	v_lshlrev_b16 v14.h, 8, v100.l op_sel:[0,0,1]              // 00000002DEAC: D738400E 0002C888
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000002DEB4: BF8701B1
	v_sub_nc_i16 v100.l, v92.h, v14.h op_sel:[1,1,0] clamp     // 00000002DEB8: D70E9864 00021D5C
	v_and_b16 v14.h, 0xff00, v97.l op_sel:[0,0,1]              // 00000002DEC0: D762400E 0002C2FF FFFFFF00
	v_lshlrev_b16 v92.h, 8, v97.l op_sel:[0,0,1]               // 00000002DECC: D738405C 0002C288
	v_perm_b32 v98, v100, v102, 0xc0c0105                      // 00000002DED4: D6440062 03FECD64 0C0C0105
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000002DEE0: BF8701A3
	v_sub_nc_i16 v107.l, v14.h, v102.h op_sel:[1,1,0] clamp    // 00000002DEE4: D70E986B 0002CD0E
	v_lshlrev_b16 v14.h, 8, v103.l op_sel:[0,0,1]              // 00000002DEEC: D738400E 0002CE88
	v_lshl_or_b32 v94, v98, 16, v94                            // 00000002DEF4: D656005E 05792162
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000002DEFC: BF8701B2
	v_sub_nc_i16 v97.l, v92.h, v14.h op_sel:[1,1,0] clamp      // 00000002DF00: D70E9861 00021D5C
	v_and_b16 v14.h, 0xff00, v97.h op_sel:[0,1,1]              // 00000002DF08: D762500E 0002C2FF FFFFFF00
	v_lshlrev_b16 v92.h, 8, v97.h op_sel:[0,1,1]               // 00000002DF14: D738505C 0002C288
	v_perm_b32 v97, v97, v107, 0xc0c0105                       // 00000002DF1C: D6440061 03FED761 0C0C0105
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002DF28: BF8700A3
	v_sub_nc_i16 v103.l, v14.h, v101.h op_sel:[1,1,0] clamp    // 00000002DF2C: D70E9867 0002CB0E
	v_lshlrev_b16 v14.h, 8, v101.l op_sel:[0,0,1]              // 00000002DF34: D738400E 0002CA88
	v_sub_nc_i16 v101.l, v92.h, v14.h op_sel:[1,1,0] clamp     // 00000002DF3C: D70E9865 00021D5C
	v_and_b16 v14.h, 0xff00, v105.l op_sel:[0,0,1]             // 00000002DF44: D762400E 0002D2FF FFFFFF00
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002DF50: BF870112
	v_perm_b32 v99, v101, v103, 0xc0c0105                      // 00000002DF54: D6440063 03FECF65 0C0C0105
	v_sub_nc_i16 v108.l, v14.h, v92.l op_sel:[1,0,0] clamp     // 00000002DF60: D70E886C 0002B90E
	v_lshlrev_b16 v14.h, 8, v93.l op_sel:[0,0,1]               // 00000002DF68: D738400E 0002BA88
	v_lshlrev_b16 v92.l, 8, v105.l                             // 00000002DF70: D738005C 0002D288
	v_lshrrev_b32_e32 v101, 22, v11                            // 00000002DF78: 32CA1696
	v_lshl_or_b32 v96, v99, 16, v97                            // 00000002DF7C: D6560060 05852163
	v_mov_b16_e32 v99.h, v14.l                                 // 00000002DF84: 7FC6390E
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_3) | instid1(VALU_DEP_4)// 00000002DF88: BF870244
	v_sub_nc_i16 v93.l, v92.l, v14.h op_sel:[0,1,0] clamp      // 00000002DF8C: D70E905D 00021D5C
	v_and_b16 v14.h, 0xff00, v105.h op_sel:[0,1,1]             // 00000002DF94: D762500E 0002D2FF FFFFFF00
	v_lshlrev_b16 v92.l, 8, v105.h op_sel:[0,1,0]              // 00000002DFA0: D738105C 0002D288
	v_and_b32_e32 v101, 0x3fc, v101                            // 00000002DFA8: 36CACAFF 000003FC
	v_perm_b32 v93, v93, v108, 0xc0c0105                       // 00000002DFB0: D644005D 03FED95D 0C0C0105
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002DFBC: BF8700A4
	v_sub_nc_i16 v105.l, v14.h, v103.h op_sel:[1,1,0] clamp    // 00000002DFC0: D70E9869 0002CF0E
	v_lshlrev_b16 v14.h, 8, v104.l op_sel:[0,0,1]              // 00000002DFC8: D738400E 0002D088
	v_sub_nc_i16 v92.l, v92.l, v14.h op_sel:[0,1,0] clamp      // 00000002DFD0: D70E905C 00021D5C
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002DFD8: BF870121
	v_perm_b32 v92, v92, v105, 0xc0c0105                       // 00000002DFDC: D644005C 03FED35C 0C0C0105
	v_mov_b16_e32 v105.h, v14.l                                // 00000002DFE8: 7FD2390E
	v_lshl_or_b32 v97, v92, 16, v93                            // 00000002DFEC: D6560061 0575215C
	v_bfe_u32 v92, v87, 14, 8                                  // 00000002DFF4: D610005C 02211D57
	ds_store_2addr_b32 v38, v95, v94 offset1:1                 // 00000002DFFC: D8380100 005E5F26
	v_bfe_u32 v87, v87, 21, 8                                  // 00000002E004: D6100057 02212B57
	ds_store_2addr_b32 v39, v96, v97 offset1:1                 // 00000002E00C: D8380100 00616027
	v_bcnt_u32_b32 v93, v92, 0                                 // 00000002E014: D71E005D 0001015C
	v_mov_b16_e32 v96.h, v14.l                                 // 00000002E01C: 7FC0390E
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002E020: BF870092
	v_and_b32_e32 v93, 1, v93                                  // 00000002E024: 36BABA81
	v_lshlrev_b32_e32 v93, 7, v93                              // 00000002E028: 30BABA87
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002E02C: BF870091
	v_xor_b32_e32 v92, v93, v92                                // 00000002E030: 3AB8B95D
	v_mul_lo_u32 v95, 0x1010101, v92                           // 00000002E034: D72C005F 0002B8FF 01010101
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002E040: BF870121
	v_and_b32_e32 v92, 0x8040201, v95                          // 00000002E044: 36B8BEFF 08040201
	v_and_b32_e32 v98, 0x80402010, v95                         // 00000002E04C: 36C4BEFF 80402010
	v_lshrrev_b16 v14.h, 8, v92.l op_sel:[0,0,1]               // 00000002E054: D739400E 0002B888
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002E05C: BF870113
	v_lshrrev_b32_e32 v92, 24, v92                             // 00000002E060: 32B8B898
	v_cmp_ne_u16_e32 vcc_lo, 0, v14.h                          // 00000002E064: 7C7B1C80
	s_delay_alu instid0(VALU_DEP_2)                            // 00000002E068: BF870002
	v_cmp_ne_u16_e64 s0, 0, v92.l                              // 00000002E06C: D43D0000 0002B880
	v_lshrrev_b32_e32 v92, 24, v98                             // 00000002E074: 32B8C498
	v_lshrrev_b16 v14.h, 8, v98.l op_sel:[0,0,1]               // 00000002E078: D739400E 0002C488
	v_mov_b16_e32 v98.h, v14.l                                 // 00000002E080: 7FC4390E
	v_cndmask_b32_e64 v94, 0, -1, vcc_lo                       // 00000002E084: D501005E 01A98280
	v_cndmask_b32_e64 v93, 0, -1, s0                           // 00000002E08C: D501005D 00018280
	v_cmp_ne_u16_e64 s2, 0, v92.l                              // 00000002E094: D43D0002 0002B880
	v_lshrrev_b32_e32 v92, 18, v95                             // 00000002E09C: 32B8BE92
	v_cmp_ne_u16_e64 s1, 0, v14.h op_sel:[0,1,0]               // 00000002E0A0: D43D1001 00021C80
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_4)// 00000002E0A8: BF870242
	v_bfe_i32 v92, v92, 0, 1                                   // 00000002E0AC: D611005C 0205015C
	v_lshlrev_b16 v92.h, 8, v93.l op_sel:[0,0,1]               // 00000002E0B4: D738405C 0002BA88
	v_bfe_i32 v93, v95, 0, 1                                   // 00000002E0BC: D611005D 0205015F
	v_lshlrev_b16 v93.h, 8, v94.l op_sel:[0,0,1]               // 00000002E0C4: D738405D 0002BC88
	v_and_b16 v14.h, 0xff, v92.l op_sel:[0,0,1]                // 00000002E0CC: D762400E 0002B8FF 000000FF
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002E0D8: BF870113
	v_and_b16 v94.l, 0xff, v93.l                               // 00000002E0DC: D762005E 0002BAFF 000000FF
	v_or_b16 v14.h, v14.h, v92.h op_sel:[1,1,1]                // 00000002E0E8: D763580E 0002B90E
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 00000002E0F0: BF870132
	v_or_b16 v99.l, v94.l, v93.h op_sel:[0,1,0]                // 00000002E0F4: D7631063 0002BB5E
	v_lshrrev_b32_e32 v94, 22, v95                             // 00000002E0FC: 32BCBE96
	v_cndmask_b32_e64 v95, 0, -1, s2                           // 00000002E100: D501005F 00098280
	v_bfe_i32 v94, v94, 0, 1                                   // 00000002E108: D611005E 0205015E
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000002E110: BF8701A2
	v_lshlrev_b16 v94.h, 8, v95.l op_sel:[0,0,1]               // 00000002E114: D738405E 0002BE88
	v_or_b32_e32 v95, v99, v14                                 // 00000002E11C: 38BE1D63
	v_and_b16 v14.h, 0xff, v94.l op_sel:[0,0,1]                // 00000002E120: D762400E 0002BCFF 000000FF
	s_waitcnt vmcnt(3)                                         // 00000002E12C: BF890FF7
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000002E130: BF8701A2
	v_xor_b32_e32 v99, v91, v95                                // 00000002E134: 3AC6BF5B
	v_lshrrev_b16 v91.l, 4, v98.l                              // 00000002E138: D739005B 0002C484
	v_or_b16 v14.h, v14.h, v94.h op_sel:[1,1,1]                // 00000002E140: D763580E 0002BD0E
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002E148: BF870122
	v_bfe_i32 v95, v91, 0, 1                                   // 00000002E14C: D611005F 0205015B
	v_cndmask_b32_e64 v91, 0, -1, s1                           // 00000002E154: D501005B 00058280
	v_and_b16 v91.h, 0xff, v95.l op_sel:[0,0,1]                // 00000002E15C: D762405B 0002BEFF 000000FF
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002E168: BF870092
	v_lshlrev_b16 v91.l, 8, v91.l                              // 00000002E16C: D738005B 0002B688
	v_or_b16 v98.l, v91.h, v91.l op_sel:[1,0,0]                // 00000002E174: D7630862 0002B75B
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 00000002E17C: BF870131
	v_or_b32_e32 v98, v98, v14                                 // 00000002E180: 38C41D62
	v_and_b16 v14.h, 0xff00, v99.l op_sel:[0,0,1]              // 00000002E184: D762400E 0002C6FF FFFFFF00
	s_waitcnt vmcnt(2)                                         // 00000002E190: BF890BF7
	v_xor_b32_e32 v98, v90, v98                                // 00000002E194: 3AC4C55A
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000002E198: BF8700B2
	v_sub_nc_i16 v100.l, v14.h, v93.h op_sel:[1,1,0] clamp     // 00000002E19C: D70E9864 0002BB0E
	v_lshlrev_b16 v14.h, 8, v93.l op_sel:[0,0,1]               // 00000002E1A4: D738400E 0002BA88
	v_lshlrev_b16 v90.l, 8, v99.l                              // 00000002E1AC: D738005A 0002C688
	v_sub_nc_i16 v93.l, v90.l, v14.h op_sel:[0,1,0] clamp      // 00000002E1B4: D70E905D 00021D5A
	v_and_b16 v14.h, 0xff00, v99.h op_sel:[0,1,1]              // 00000002E1BC: D762500E 0002C6FF FFFFFF00
	v_lshlrev_b16 v90.l, 8, v99.h op_sel:[0,1,0]               // 00000002E1C8: D738105A 0002C688
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002E1D0: BF870193
	v_perm_b32 v93, v93, v100, 0xc0c0105                       // 00000002E1D4: D644005D 03FEC95D 0C0C0105
	v_sub_nc_i16 v99.l, v14.h, v92.h op_sel:[1,1,0] clamp      // 00000002E1E0: D70E9863 0002B90E
	v_lshlrev_b16 v14.h, 8, v92.l op_sel:[0,0,1]               // 00000002E1E8: D738400E 0002B888
	v_lshrrev_b32_e32 v100, 14, v11                            // 00000002E1F0: 32C8168E
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_4)// 00000002E1F4: BF870232
	v_sub_nc_i16 v92.l, v90.l, v14.h op_sel:[0,1,0] clamp      // 00000002E1F8: D70E905C 00021D5A
	v_and_b16 v14.h, 0xff00, v98.l op_sel:[0,0,1]              // 00000002E200: D762400E 0002C4FF FFFFFF00
	v_lshlrev_b16 v90.l, 8, v98.l                              // 00000002E20C: D738005A 0002C488
	v_and_b32_e32 v100, 0x3fc, v100                            // 00000002E214: 36C8C8FF 000003FC
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002E21C: BF870214
	v_perm_b32 v92, v92, v99, 0xc0c0105                        // 00000002E220: D644005C 03FEC75C 0C0C0105
	v_sub_nc_i16 v91.l, v14.h, v91.l op_sel:[1,0,0] clamp      // 00000002E22C: D70E885B 0002B70E
	v_lshlrev_b16 v14.h, 8, v95.l op_sel:[0,0,1]               // 00000002E234: D738400E 0002BE88
	v_lshrrev_b32_e32 v99, 6, v11                              // 00000002E23C: 32C61686
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002E240: BF870194
	v_lshl_or_b32 v93, v92, 16, v93                            // 00000002E244: D656005D 0575215C
	v_sub_nc_i16 v95.l, v90.l, v14.h op_sel:[0,1,0] clamp      // 00000002E24C: D70E905F 00021D5A
	v_and_b16 v14.h, 0xff00, v98.h op_sel:[0,1,1]              // 00000002E254: D762500E 0002C4FF FFFFFF00
	v_lshlrev_b16 v90.l, 8, v98.h op_sel:[0,1,0]               // 00000002E260: D738105A 0002C488
	v_and_b32_e32 v99, 0x3fc, v99                              // 00000002E268: 36C6C6FF 000003FC
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002E270: BF870214
	v_perm_b32 v91, v95, v91, 0xc0c0105                        // 00000002E274: D644005B 03FEB75F 0C0C0105
	v_sub_nc_i16 v98.l, v14.h, v94.h op_sel:[1,1,0] clamp      // 00000002E280: D70E9862 0002BD0E
	v_lshlrev_b16 v14.h, 8, v94.l op_sel:[0,0,1]               // 00000002E288: D738400E 0002BC88
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002E290: BF870091
	v_sub_nc_i16 v90.l, v90.l, v14.h op_sel:[0,1,0] clamp      // 00000002E294: D70E905A 00021D5A
	v_perm_b32 v90, v90, v98, 0xc0c0105                        // 00000002E29C: D644005A 03FEC55A 0C0C0105
	v_and_b32_e32 v98, 0xff, v11                               // 00000002E2A8: 36C416FF 000000FF
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000002E2B0: BF8701A2
	v_lshl_or_b32 v94, v90, 16, v91                            // 00000002E2B4: D656005E 056D215A
	v_bcnt_u32_b32 v90, v87, 0                                 // 00000002E2BC: D71E005A 00010157
	v_lshlrev_b32_e32 v98, 2, v98                              // 00000002E2C4: 30C4C482
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002E2C8: BF870092
	v_and_b32_e32 v90, 1, v90                                  // 00000002E2CC: 36B4B481
	v_lshlrev_b32_e32 v90, 7, v90                              // 00000002E2D0: 30B4B487
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002E2D4: BF870091
	v_xor_b32_e32 v87, v90, v87                                // 00000002E2D8: 3AAEAF5A
	v_mul_lo_u32 v92, 0x1010101, v87                           // 00000002E2DC: D72C005C 0002AEFF 01010101
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002E2E8: BF870121
	v_and_b32_e32 v87, 0x8040201, v92                          // 00000002E2EC: 36AEB8FF 08040201
	v_and_b32_e32 v95, 0x80402010, v92                         // 00000002E2F4: 36BEB8FF 80402010
	v_lshrrev_b16 v14.h, 8, v87.l op_sel:[0,0,1]               // 00000002E2FC: D739400E 0002AE88
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002E304: BF870193
	v_lshrrev_b32_e32 v87, 24, v87                             // 00000002E308: 32AEAE98
	v_lshrrev_b32_e32 v90, 24, v95                             // 00000002E30C: 32B4BE98
	v_mov_b16_e32 v95.h, v14.l                                 // 00000002E310: 7FBE390E
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002E314: BF870214
	v_cmp_ne_u16_e32 vcc_lo, 0, v14.h                          // 00000002E318: 7C7B1C80
	v_cmp_ne_u16_e64 s2, 0, v87.l                              // 00000002E31C: D43D0002 0002AE80
	v_lshrrev_b32_e32 v87, 18, v92                             // 00000002E324: 32AEB892
	v_cmp_ne_u16_e64 s1, 0, v90.l                              // 00000002E328: D43D0001 0002B480
	v_lshrrev_b16 v14.h, 8, v95.l op_sel:[0,0,1]               // 00000002E330: D739400E 0002BE88
	v_cndmask_b32_e64 v91, 0, -1, vcc_lo                       // 00000002E338: D501005B 01A98280
	v_cndmask_b32_e64 v90, 0, -1, s2                           // 00000002E340: D501005A 00098280
	v_bfe_i32 v87, v87, 0, 1                                   // 00000002E348: D6110057 02050157
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002E350: BF870194
	v_cmp_ne_u16_e64 s0, 0, v14.h op_sel:[0,1,0]               // 00000002E354: D43D1000 00021C80
	v_lshlrev_b16 v87.h, 8, v90.l op_sel:[0,0,1]               // 00000002E35C: D7384057 0002B488
	v_bfe_i32 v90, v92, 0, 1                                   // 00000002E364: D611005A 0205015C
	v_lshlrev_b16 v90.h, 8, v91.l op_sel:[0,0,1]               // 00000002E36C: D738405A 0002B688
	v_and_b16 v14.h, 0xff, v87.l op_sel:[0,0,1]                // 00000002E374: D762400E 0002AEFF 000000FF
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002E380: BF870113
	v_and_b16 v91.l, 0xff, v90.l                               // 00000002E384: D762005B 0002B4FF 000000FF
	v_or_b16 v14.h, v14.h, v87.h op_sel:[1,1,1]                // 00000002E390: D763580E 0002AF0E
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 00000002E398: BF870132
	v_or_b16 v96.l, v91.l, v90.h op_sel:[0,1,0]                // 00000002E39C: D7631060 0002B55B
	v_lshrrev_b32_e32 v91, 22, v92                             // 00000002E3A4: 32B6B896
	v_cndmask_b32_e64 v92, 0, -1, s1                           // 00000002E3A8: D501005C 00058280
	v_bfe_i32 v91, v91, 0, 1                                   // 00000002E3B0: D611005B 0205015B
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000002E3B8: BF8701A2
	v_lshlrev_b16 v91.h, 8, v92.l op_sel:[0,0,1]               // 00000002E3BC: D738405B 0002B888
	v_or_b32_e32 v92, v96, v14                                 // 00000002E3C4: 38B81D60
	v_and_b16 v14.h, 0xff, v91.l op_sel:[0,0,1]                // 00000002E3C8: D762400E 0002B6FF 000000FF
	s_waitcnt vmcnt(1)                                         // 00000002E3D4: BF8907F7
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000002E3D8: BF8701A2
	v_xor_b32_e32 v96, v89, v92                                // 00000002E3DC: 3AC0B959
	v_lshrrev_b16 v89.l, 4, v95.l                              // 00000002E3E0: D7390059 0002BE84
	v_or_b16 v14.h, v14.h, v91.h op_sel:[1,1,1]                // 00000002E3E8: D763580E 0002B70E
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002E3F0: BF870122
	v_bfe_i32 v92, v89, 0, 1                                   // 00000002E3F4: D611005C 02050159
	v_cndmask_b32_e64 v89, 0, -1, s0                           // 00000002E3FC: D5010059 00018280
	v_and_b16 v89.h, 0xff, v92.l op_sel:[0,0,1]                // 00000002E404: D7624059 0002B8FF 000000FF
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002E410: BF870092
	v_lshlrev_b16 v89.l, 8, v89.l                              // 00000002E414: D7380059 0002B288
	v_or_b16 v95.l, v89.h, v89.l op_sel:[1,0,0]                // 00000002E41C: D763085F 0002B359
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 00000002E424: BF870131
	v_or_b32_e32 v95, v95, v14                                 // 00000002E428: 38BE1D5F
	v_and_b16 v14.h, 0xff00, v96.l op_sel:[0,0,1]              // 00000002E42C: D762400E 0002C0FF FFFFFF00
	s_waitcnt vmcnt(0)                                         // 00000002E438: BF8903F7
	v_xor_b32_e32 v95, v15, v95                                // 00000002E43C: 3ABEBF0F
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000002E440: BF8700B2
	v_sub_nc_i16 v97.l, v14.h, v90.h op_sel:[1,1,0] clamp      // 00000002E444: D70E9861 0002B50E
	v_lshlrev_b16 v14.h, 8, v90.l op_sel:[0,0,1]               // 00000002E44C: D738400E 0002B488
	v_lshlrev_b16 v15.l, 8, v96.l                              // 00000002E454: D738000F 0002C088
	v_sub_nc_i16 v90.l, v15.l, v14.h op_sel:[0,1,0] clamp      // 00000002E45C: D70E905A 00021D0F
	v_and_b16 v14.h, 0xff00, v96.h op_sel:[0,1,1]              // 00000002E464: D762500E 0002C0FF FFFFFF00
	v_lshlrev_b16 v15.l, 8, v96.h op_sel:[0,1,0]               // 00000002E470: D738100F 0002C088
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002E478: BF870193
	v_perm_b32 v90, v90, v97, 0xc0c0105                        // 00000002E47C: D644005A 03FEC35A 0C0C0105
	v_sub_nc_i16 v96.l, v14.h, v87.h op_sel:[1,1,0] clamp      // 00000002E488: D70E9860 0002AF0E
	v_lshlrev_b16 v14.h, 8, v87.l op_sel:[0,0,1]               // 00000002E490: D738400E 0002AE88
	v_lshrrev_b32_e32 v97, 22, v10                             // 00000002E498: 32C21496
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_4)// 00000002E49C: BF870232
	v_sub_nc_i16 v87.l, v15.l, v14.h op_sel:[0,1,0] clamp      // 00000002E4A0: D70E9057 00021D0F
	v_and_b16 v14.h, 0xff00, v95.l op_sel:[0,0,1]              // 00000002E4A8: D762400E 0002BEFF FFFFFF00
	v_lshlrev_b16 v15.l, 8, v95.l                              // 00000002E4B4: D738000F 0002BE88
	v_and_b32_e32 v97, 0x3fc, v97                              // 00000002E4BC: 36C2C2FF 000003FC
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002E4C4: BF870214
	v_perm_b32 v87, v87, v96, 0xc0c0105                        // 00000002E4C8: D6440057 03FEC157 0C0C0105
	v_sub_nc_i16 v89.l, v14.h, v89.l op_sel:[1,0,0] clamp      // 00000002E4D4: D70E8859 0002B30E
	v_lshlrev_b16 v14.h, 8, v92.l op_sel:[0,0,1]               // 00000002E4DC: D738400E 0002B888
	v_lshrrev_b32_e32 v96, 14, v10                             // 00000002E4E4: 32C0148E
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_4)// 00000002E4E8: BF870224
	v_lshl_or_b32 v87, v87, 16, v90                            // 00000002E4EC: D6560057 05692157
	v_mov_b16_e32 v90.h, v14.l                                 // 00000002E4F4: 7FB4390E
	v_sub_nc_i16 v92.l, v15.l, v14.h op_sel:[0,1,0] clamp      // 00000002E4F8: D70E905C 00021D0F
	v_and_b16 v14.h, 0xff00, v95.h op_sel:[0,1,1]              // 00000002E500: D762500E 0002BEFF FFFFFF00
	v_lshlrev_b16 v15.l, 8, v95.h op_sel:[0,1,0]               // 00000002E50C: D738100F 0002BE88
	v_and_b32_e32 v96, 0x3fc, v96                              // 00000002E514: 36C0C0FF 000003FC
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002E51C: BF870214
	v_perm_b32 v89, v92, v89, 0xc0c0105                        // 00000002E520: D6440059 03FEB35C 0C0C0105
	v_sub_nc_i16 v95.l, v14.h, v91.h op_sel:[1,1,0] clamp      // 00000002E52C: D70E985F 0002B70E
	v_lshlrev_b16 v14.h, 8, v91.l op_sel:[0,0,1]               // 00000002E534: D738400E 0002B688
	v_mov_b16_e32 v92.h, v14.l                                 // 00000002E53C: 7FB8390E
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002E540: BF870092
	v_sub_nc_i16 v15.l, v15.l, v14.h op_sel:[0,1,0] clamp      // 00000002E544: D70E900F 00021D0F
	v_perm_b32 v15, v15, v95, 0xc0c0105                        // 00000002E54C: D644000F 03FEBF0F 0C0C0105
	v_lshrrev_b32_e32 v95, 6, v10                              // 00000002E558: 32BE1486
	s_delay_alu instid0(VALU_DEP_2)                            // 00000002E55C: BF870002
	v_lshl_or_b32 v15, v15, 16, v89                            // 00000002E560: D656000F 0565210F
	ds_store_2addr_b32 v40, v93, v94 offset1:1                 // 00000002E568: D8380100 005E5D28
	ds_store_2addr_b32 v41, v87, v15 offset1:1                 // 00000002E570: D8380100 000F5729
	v_and_b32_e32 v94, 0xff, v10                               // 00000002E578: 36BC14FF 000000FF
	v_and_b32_e32 v95, 0x3fc, v95                              // 00000002E580: 36BEBEFF 000003FC
	v_and_b32_e32 v10, 0xff, v88                               // 00000002E588: 3614B0FF 000000FF
	s_delay_alu instid0(VALU_DEP_3)                            // 00000002E590: BF870003
	v_lshlrev_b32_e32 v94, 2, v94                              // 00000002E594: 30BCBC82
	s_clause 0x7                                               // 00000002E598: BF850007
	global_load_b32 v94, v94, s[10:11]                         // 00000002E59C: DC520000 5E0A005E
	global_load_b32 v95, v95, s[10:11]                         // 00000002E5A4: DC520000 5F0A005F
	global_load_b32 v96, v96, s[10:11]                         // 00000002E5AC: DC520000 600A0060
	global_load_b32 v97, v97, s[10:11]                         // 00000002E5B4: DC520000 610A0061
	global_load_b32 v98, v98, s[10:11]                         // 00000002E5BC: DC520000 620A0062
	global_load_b32 v99, v99, s[10:11]                         // 00000002E5C4: DC520000 630A0063
	global_load_b32 v100, v100, s[10:11]                       // 00000002E5CC: DC520000 640A0064
	global_load_b32 v101, v101, s[10:11]                       // 00000002E5D4: DC520000 650A0065
	v_bcnt_u32_b32 v11, v10, 0                                 // 00000002E5DC: D71E000B 0001010A
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002E5E4: BF870091
	v_and_b32_e32 v11, 1, v11                                  // 00000002E5E8: 36161681
	v_lshlrev_b32_e32 v11, 7, v11                              // 00000002E5EC: 30161687
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002E5F0: BF870121
	v_xor_b32_e32 v10, v11, v10                                // 00000002E5F4: 3A14150B
	v_bfe_u32 v11, v88, 7, 8                                   // 00000002E5F8: D610000B 02210F58
	v_mul_lo_u32 v87, 0x1010101, v10                           // 00000002E600: D72C0057 000214FF 01010101
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002E60C: BF870092
	v_bcnt_u32_b32 v15, v11, 0                                 // 00000002E610: D71E000F 0001010B
	v_and_b32_e32 v15, 1, v15                                  // 00000002E618: 361E1E81
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002E61C: BF870113
	v_and_b32_e32 v89, 0x80402010, v87                         // 00000002E620: 36B2AEFF 80402010
	v_lshlrev_b32_e32 v15, 7, v15                              // 00000002E628: 301E1E87
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002E62C: BF870121
	v_xor_b32_e32 v11, v15, v11                                // 00000002E630: 3A16170F
	v_and_b32_e32 v15, 0x8040201, v87                          // 00000002E634: 361EAEFF 08040201
	v_mul_lo_u32 v93, 0x1010101, v11                           // 00000002E63C: D72C005D 000216FF 01010101
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002E648: BF870092
	v_lshrrev_b16 v10.l, 8, v15.l                              // 00000002E64C: D739000A 00021E88
	v_cmp_ne_u16_e32 vcc_lo, 0, v10.l                          // 00000002E654: 7C7A1480
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002E658: BF870214
	v_lshrrev_b32_e32 v10, 24, v15                             // 00000002E65C: 32141E98
	v_and_b32_e32 v11, 0x8040201, v93                          // 00000002E660: 3616BAFF 08040201
	v_and_b32_e32 v102, 0x80402010, v93                        // 00000002E668: 36CCBAFF 80402010
	v_cndmask_b32_e64 v15, 0, -1, vcc_lo                       // 00000002E670: D501000F 01A98280
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002E678: BF8700A4
	v_cmp_ne_u16_e64 s0, 0, v10.l                              // 00000002E67C: D43D0000 00021480
	v_lshrrev_b16 v10.l, 8, v89.l                              // 00000002E684: D739000A 0002B288
	v_cmp_ne_u16_e64 s1, 0, v10.l                              // 00000002E68C: D43D0001 00021480
	v_lshrrev_b32_e32 v10, 24, v89                             // 00000002E694: 3214B298
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002E698: BF8700A1
	v_cmp_ne_u16_e64 s2, 0, v10.l                              // 00000002E69C: D43D0002 00021480
	v_lshrrev_b16 v10.l, 8, v11.l                              // 00000002E6A4: D739000A 00021688
	v_cmp_ne_u16_e64 s3, 0, v10.l                              // 00000002E6AC: D43D0003 00021480
	v_lshrrev_b32_e32 v10, 24, v11                             // 00000002E6B4: 32141698
	v_cndmask_b32_e64 v11, 0, -1, s0                           // 00000002E6B8: D501000B 00018280
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002E6C0: BF870122
	v_cmp_ne_u16_e64 s4, 0, v10.l                              // 00000002E6C4: D43D0004 00021480
	v_lshrrev_b16 v10.l, 8, v102.l                             // 00000002E6CC: D739000A 0002CC88
	v_cndmask_b32_e64 v91, 0, -1, s4                           // 00000002E6D4: D501005B 00118280
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002E6DC: BF8700A2
	v_cmp_ne_u16_e64 s5, 0, v10.l                              // 00000002E6E0: D43D0005 00021480
	v_lshrrev_b32_e32 v10, 24, v102                            // 00000002E6E8: 3214CC98
	v_cmp_ne_u16_e64 s6, 0, v10.l                              // 00000002E6EC: D43D0006 00021480
	v_lshrrev_b32_e32 v10, 18, v87                             // 00000002E6F4: 3214AE92
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002E6F8: BF870121
	v_bfe_i32 v10, v10, 0, 1                                   // 00000002E6FC: D611000A 0205010A
	v_lshlrev_b16 v10.h, 8, v11.l op_sel:[0,0,1]               // 00000002E704: D738400A 00021688
	v_and_b16 v11.l, 0xff, v10.l                               // 00000002E70C: D762000B 000214FF 000000FF
	v_lshlrev_b16 v10.l, 8, v10.l                              // 00000002E718: D738000A 00021488
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 00000002E720: BF870132
	v_or_b16 v14.h, v11.l, v10.h op_sel:[0,1,1]                // 00000002E724: D763500E 0002150B
	v_bfe_i32 v11, v87, 0, 1                                   // 00000002E72C: D611000B 02050157
	v_lshlrev_b16 v11.h, 8, v15.l op_sel:[0,0,1]               // 00000002E734: D738400B 00021E88
	v_and_b16 v15.l, 0xff, v11.l                               // 00000002E73C: D762000F 000216FF 000000FF
	v_lshlrev_b16 v11.l, 8, v11.l                              // 00000002E748: D738000B 00021688
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000002E750: BF8701B2
	v_or_b16 v90.l, v15.l, v11.h op_sel:[0,1,0]                // 00000002E754: D763105A 0002170F
	v_lshrrev_b32_e32 v15, 22, v87                             // 00000002E75C: 321EAE96
	v_cndmask_b32_e64 v87, 0, -1, s2                           // 00000002E760: D5010057 00098280
	v_or_b32_e32 v103, v90, v14                                // 00000002E768: 38CE1D5A
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002E76C: BF870193
	v_bfe_i32 v15, v15, 0, 1                                   // 00000002E770: D611000F 0205010F
	v_lshlrev_b16 v15.h, 8, v87.l op_sel:[0,0,1]               // 00000002E778: D738400F 0002AE88
	v_lshrrev_b16 v87.l, 4, v89.l                              // 00000002E780: D7390057 0002B284
	v_lshrrev_b32_e32 v90, 18, v93                             // 00000002E788: 32B4BA92
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002E78C: BF870194
	v_and_b16 v14.h, 0xff, v15.l op_sel:[0,0,1]                // 00000002E790: D762400E 00021EFF 000000FF
	v_bfe_i32 v89, v87, 0, 1                                   // 00000002E79C: D6110059 02050157
	v_cndmask_b32_e64 v87, 0, -1, s1                           // 00000002E7A4: D5010057 00058280
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002E7AC: BF870214
	v_bfe_i32 v90, v90, 0, 1                                   // 00000002E7B0: D611005A 0205015A
	v_or_b16 v14.h, v14.h, v15.h op_sel:[1,1,1]                // 00000002E7B8: D763580E 00021F0E
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002E7C0: BF870214
	v_and_b16 v87.h, 0xff, v89.l op_sel:[0,0,1]                // 00000002E7C4: D7624057 0002B2FF 000000FF
	v_lshlrev_b16 v87.l, 8, v87.l                              // 00000002E7D0: D7380057 0002AE88
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000002E7D8: BF8701B1
	v_or_b16 v92.l, v87.h, v87.l op_sel:[1,0,0]                // 00000002E7DC: D763085C 0002AF57
	v_lshlrev_b16 v87.h, 8, v91.l op_sel:[0,0,1]               // 00000002E7E4: D7384057 0002B688
	v_bfe_i32 v91, v93, 0, 1                                   // 00000002E7EC: D611005B 0205015D
	v_or_b32_e32 v104, v92, v14                                // 00000002E7F4: 38D01D5C
	v_cndmask_b32_e64 v92, 0, -1, s3                           // 00000002E7F8: D501005C 000D8280
	v_and_b16 v14.h, 0xff, v90.l op_sel:[0,0,1]                // 00000002E800: D762400E 0002B4FF 000000FF
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002E80C: BF870194
	v_and_b16 v90.h, 0xff, v91.l op_sel:[0,0,1]                // 00000002E810: D762405A 0002B6FF 000000FF
	v_lshlrev_b16 v89.h, 8, v92.l op_sel:[0,0,1]               // 00000002E81C: D7384059 0002B888
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_4)// 00000002E824: BF870233
	v_or_b16 v14.h, v14.h, v87.h op_sel:[1,1,1]                // 00000002E828: D763580E 0002AF0E
	v_lshrrev_b32_e32 v92, 22, v93                             // 00000002E830: 32B8BA96
	v_cndmask_b32_e64 v93, 0, -1, s6                           // 00000002E834: D501005D 00198280
	v_or_b16 v105.l, v90.h, v89.h op_sel:[1,1,0]               // 00000002E83C: D7631869 0002B35A
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002E844: BF870193
	v_bfe_i32 v92, v92, 0, 1                                   // 00000002E848: D611005C 0205015C
	v_lshlrev_b16 v90.h, 8, v93.l op_sel:[0,0,1]               // 00000002E850: D738405A 0002BA88
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002E858: BF870193
	v_or_b32_e32 v93, v105, v14                                // 00000002E85C: 38BA1D69
	v_and_b16 v14.h, 0xff, v92.l op_sel:[0,0,1]                // 00000002E860: D762400E 0002B8FF 000000FF
	s_delay_alu instid0(VALU_DEP_1)                            // 00000002E86C: BF870001
	v_or_b16 v14.h, v14.h, v90.h op_sel:[1,1,1]                // 00000002E870: D763580E 0002B50E
	s_waitcnt vmcnt(7)                                         // 00000002E878: BF891FF7
	v_xor_b32_e32 v103, v94, v103                              // 00000002E87C: 3ACECF5E
	s_waitcnt vmcnt(6)                                         // 00000002E880: BF891BF7
	v_xor_b32_e32 v95, v95, v104                               // 00000002E884: 3ABED15F
	s_waitcnt vmcnt(5)                                         // 00000002E888: BF8917F7
	v_xor_b32_e32 v96, v96, v93                                // 00000002E88C: 3AC0BB60
	v_lshrrev_b16 v93.l, 4, v102.l                             // 00000002E890: D739005D 0002CC84
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000002E898: BF8701B1
	v_bfe_i32 v94, v93, 0, 1                                   // 00000002E89C: D611005E 0205015D
	v_cndmask_b32_e64 v93, 0, -1, s5                           // 00000002E8A4: D501005D 00158280
	v_mov_b16_e32 v93.h, v14.l                                 // 00000002E8AC: 7FBA390E
	v_and_b16 v92.h, 0xff, v94.l op_sel:[0,0,1]                // 00000002E8B0: D762405C 0002BCFF 000000FF
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002E8BC: BF870093
	v_lshlrev_b16 v91.h, 8, v93.l op_sel:[0,0,1]               // 00000002E8C0: D738405B 0002BA88
	v_or_b16 v93.l, v92.h, v91.h op_sel:[1,1,0]                // 00000002E8C8: D763185D 0002B75C
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 00000002E8D0: BF870131
	v_or_b32_e32 v93, v93, v14                                 // 00000002E8D4: 38BA1D5D
	v_and_b16 v14.h, 0xff00, v103.l op_sel:[0,0,1]             // 00000002E8D8: D762400E 0002CEFF FFFFFF00
	s_waitcnt vmcnt(4)                                         // 00000002E8E4: BF8913F7
	v_xor_b32_e32 v93, v97, v93                                // 00000002E8E8: 3ABABB61
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002E8EC: BF8700A2
	v_sub_nc_i16 v97.l, v14.h, v11.h op_sel:[1,1,0] clamp      // 00000002E8F0: D70E9861 0002170E
	v_lshlrev_b16 v11.h, 8, v103.l op_sel:[0,0,1]              // 00000002E8F8: D738400B 0002CE88
	v_sub_nc_i16 v102.l, v11.h, v11.l op_sel:[1,0,0] clamp     // 00000002E900: D70E8866 0002170B
	v_and_b16 v11.l, 0xff00, v103.h op_sel:[0,1,0]             // 00000002E908: D762100B 0002CEFF FFFFFF00
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002E914: BF8700A1
	v_sub_nc_i16 v11.l, v11.l, v10.h op_sel:[0,1,0] clamp      // 00000002E918: D70E900B 0002150B
	v_lshlrev_b16 v10.h, 8, v103.h op_sel:[0,1,1]              // 00000002E920: D738500A 0002CE88
	v_sub_nc_i16 v103.l, v10.h, v10.l op_sel:[1,0,0] clamp     // 00000002E928: D70E8867 0002150A
	v_and_b16 v10.l, 0xff00, v95.l                             // 00000002E930: D762000A 0002BEFF FFFFFF00
	v_lshlrev_b16 v10.h, 8, v95.l op_sel:[0,0,1]               // 00000002E93C: D738400A 0002BE88
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002E944: BF870193
	v_perm_b32 v11, v103, v11, 0xc0c0105                       // 00000002E948: D644000B 03FE1767 0C0C0105
	v_sub_nc_i16 v87.l, v10.l, v87.l clamp                     // 00000002E954: D70E8057 0002AF0A
	v_lshlrev_b16 v10.l, 8, v89.l                              // 00000002E95C: D738000A 0002B288
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 00000002E964: BF870131
	v_sub_nc_i16 v89.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002E968: D70E8859 0002150A
	v_and_b16 v10.l, 0xff00, v95.h op_sel:[0,1,0]              // 00000002E970: D762100A 0002BEFF FFFFFF00
	v_lshlrev_b16 v10.h, 8, v95.h op_sel:[0,1,1]               // 00000002E97C: D738500A 0002BE88
	v_sub_nc_i16 v95.l, v10.l, v15.h op_sel:[0,1,0] clamp      // 00000002E984: D70E905F 00021F0A
	v_lshlrev_b16 v10.l, 8, v15.l                              // 00000002E98C: D738000A 00021E88
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000002E994: BF8701B1
	v_sub_nc_i16 v15.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002E998: D70E880F 0002150A
	v_and_b16 v10.l, 0xff00, v96.l                             // 00000002E9A0: D762000A 0002C0FF FFFFFF00
	v_lshlrev_b16 v10.h, 8, v96.l op_sel:[0,0,1]               // 00000002E9AC: D738400A 0002C088
	v_perm_b32 v15, v15, v95, 0xc0c0105                        // 00000002E9B4: D644000F 03FEBF0F 0C0C0105
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002E9C0: BF8700A3
	v_sub_nc_i16 v104.l, v10.l, v89.h op_sel:[0,1,0] clamp     // 00000002E9C4: D70E9068 0002B30A
	v_lshlrev_b16 v10.l, 8, v91.l                              // 00000002E9CC: D738000A 0002B688
	v_sub_nc_i16 v91.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002E9D4: D70E885B 0002150A
	v_and_b16 v10.l, 0xff00, v96.h op_sel:[0,1,0]              // 00000002E9DC: D762100A 0002C0FF FFFFFF00
	v_lshlrev_b16 v10.h, 8, v96.h op_sel:[0,1,1]               // 00000002E9E8: D738500A 0002C088
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_3)// 00000002E9F0: BF8701C2
	v_sub_nc_i16 v96.l, v10.l, v87.h op_sel:[0,1,0] clamp      // 00000002E9F4: D70E9060 0002AF0A
	v_lshlrev_b16 v10.l, 8, v90.l                              // 00000002E9FC: D738000A 0002B488
	v_perm_b32 v87, v89, v87, 0xc0c0105                        // 00000002EA04: D6440057 03FEAF59 0C0C0105
	v_perm_b32 v89, v91, v104, 0xc0c0105                       // 00000002EA10: D6440059 03FED15B 0C0C0105
	v_sub_nc_i16 v90.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002EA1C: D70E885A 0002150A
	v_and_b16 v10.l, 0xff00, v93.l                             // 00000002EA24: D762000A 0002BAFF FFFFFF00
	v_lshlrev_b16 v10.h, 8, v93.l op_sel:[0,0,1]               // 00000002EA30: D738400A 0002BA88
	v_lshl_or_b32 v15, v15, 16, v87                            // 00000002EA38: D656000F 055D210F
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002EA40: BF8700A3
	v_sub_nc_i16 v105.l, v10.l, v91.h op_sel:[0,1,0] clamp     // 00000002EA44: D70E9069 0002B70A
	v_lshlrev_b16 v10.l, 8, v94.l                              // 00000002EA4C: D738000A 0002BC88
	v_sub_nc_i16 v93.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002EA54: D70E885D 0002150A
	v_and_b16 v10.l, 0xff00, v93.h op_sel:[0,1,0]              // 00000002EA5C: D762100A 0002BAFF FFFFFF00
	v_lshlrev_b16 v10.h, 8, v93.h op_sel:[0,1,1]               // 00000002EA68: D738500A 0002BA88
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002EA70: BF870193
	v_perm_b32 v91, v93, v105, 0xc0c0105                       // 00000002EA74: D644005B 03FED35D 0C0C0105
	v_sub_nc_i16 v94.l, v10.l, v90.h op_sel:[0,1,0] clamp      // 00000002EA80: D70E905E 0002B50A
	v_lshlrev_b16 v10.l, 8, v92.l                              // 00000002EA88: D738000A 0002B888
	v_perm_b32 v92, v102, v97, 0xc0c0105                       // 00000002EA90: D644005C 03FEC366 0C0C0105
	v_perm_b32 v90, v90, v96, 0xc0c0105                        // 00000002EA9C: D644005A 03FEC15A 0C0C0105
	v_mov_b16_e32 v93.h, v14.l                                 // 00000002EAA8: 7FBA390E
	v_lshrrev_b32_e32 v96, 6, v13                              // 00000002EAAC: 32C01A86
	v_sub_nc_i16 v10.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002EAB0: D70E880A 0002150A
	v_lshl_or_b32 v11, v11, 16, v92                            // 00000002EAB8: D656000B 0571210B
	v_lshl_or_b32 v90, v90, 16, v89                            // 00000002EAC0: D656005A 0565215A
	v_mov_b16_e32 v92.h, v14.l                                 // 00000002EAC8: 7FB8390E
	v_lshrrev_b32_e32 v97, 14, v13                             // 00000002EACC: 32C21A8E
	v_perm_b32 v10, v10, v94, 0xc0c0105                        // 00000002EAD0: D644000A 03FEBD0A 0C0C0105
	v_and_b32_e32 v96, 0x3fc, v96                              // 00000002EADC: 36C0C0FF 000003FC
	v_mov_b16_e32 v102.h, v14.l                                // 00000002EAE4: 7FCC390E
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002EAE8: BF870214
	v_and_b32_e32 v97, 0x3fc, v97                              // 00000002EAEC: 36C2C2FF 000003FC
	v_lshl_or_b32 v91, v10, 16, v91                            // 00000002EAF4: D656005B 056D210A
	v_bfe_u32 v10, v88, 14, 8                                  // 00000002EAFC: D610000A 02211D58
	ds_store_2addr_b32 v42, v11, v15 offset1:1                 // 00000002EB04: D8380100 000F0B2A
	ds_store_2addr_b32 v43, v90, v91 offset1:1                 // 00000002EB0C: D8380100 005B5A2B
	v_bcnt_u32_b32 v11, v10, 0                                 // 00000002EB14: D71E000B 0001010A
	v_mov_b16_e32 v90.h, v14.l                                 // 00000002EB1C: 7FB4390E
	v_mov_b16_e32 v91.h, v14.l                                 // 00000002EB20: 7FB6390E
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002EB24: BF870093
	v_and_b32_e32 v11, 1, v11                                  // 00000002EB28: 36161681
	v_lshlrev_b32_e32 v11, 7, v11                              // 00000002EB2C: 30161687
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002EB30: BF870091
	v_xor_b32_e32 v10, v11, v10                                // 00000002EB34: 3A14150B
	v_mul_lo_u32 v87, 0x1010101, v10                           // 00000002EB38: D72C0057 000214FF 01010101
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002EB44: BF870121
	v_and_b32_e32 v11, 0x8040201, v87                          // 00000002EB48: 3616AEFF 08040201
	v_and_b32_e32 v89, 0x80402010, v87                         // 00000002EB50: 36B2AEFF 80402010
	v_lshrrev_b16 v10.l, 8, v11.l                              // 00000002EB58: D739000A 00021688
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002EB60: BF870211
	v_cmp_ne_u16_e32 vcc_lo, 0, v10.l                          // 00000002EB64: 7C7A1480
	v_lshrrev_b32_e32 v10, 24, v11                             // 00000002EB68: 32141698
	v_cndmask_b32_e64 v15, 0, -1, vcc_lo                       // 00000002EB6C: D501000F 01A98280
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002EB74: BF870122
	v_cmp_ne_u16_e64 s0, 0, v10.l                              // 00000002EB78: D43D0000 00021480
	v_lshrrev_b16 v10.l, 8, v89.l                              // 00000002EB80: D739000A 0002B288
	v_cndmask_b32_e64 v11, 0, -1, s0                           // 00000002EB88: D501000B 00018280
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002EB90: BF8700A2
	v_cmp_ne_u16_e64 s1, 0, v10.l                              // 00000002EB94: D43D0001 00021480
	v_lshrrev_b32_e32 v10, 24, v89                             // 00000002EB9C: 3214B298
	v_cmp_ne_u16_e64 s2, 0, v10.l                              // 00000002EBA0: D43D0002 00021480
	v_lshrrev_b32_e32 v10, 18, v87                             // 00000002EBA8: 3214AE92
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002EBAC: BF870121
	v_bfe_i32 v10, v10, 0, 1                                   // 00000002EBB0: D611000A 0205010A
	v_lshlrev_b16 v10.h, 8, v11.l op_sel:[0,0,1]               // 00000002EBB8: D738400A 00021688
	v_and_b16 v11.l, 0xff, v10.l                               // 00000002EBC0: D762000B 000214FF 000000FF
	v_lshlrev_b16 v10.l, 8, v10.l                              // 00000002EBCC: D738000A 00021488
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 00000002EBD4: BF870132
	v_or_b16 v14.h, v11.l, v10.h op_sel:[0,1,1]                // 00000002EBD8: D763500E 0002150B
	v_bfe_i32 v11, v87, 0, 1                                   // 00000002EBE0: D611000B 02050157
	v_lshlrev_b16 v11.h, 8, v15.l op_sel:[0,0,1]               // 00000002EBE8: D738400B 00021E88
	v_and_b16 v15.l, 0xff, v11.l                               // 00000002EBF0: D762000F 000216FF 000000FF
	v_lshlrev_b16 v11.l, 8, v11.l                              // 00000002EBFC: D738000B 00021688
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 00000002EC04: BF870132
	v_or_b16 v92.l, v15.l, v11.h op_sel:[0,1,0]                // 00000002EC08: D763105C 0002170F
	v_lshrrev_b32_e32 v15, 22, v87                             // 00000002EC10: 321EAE96
	v_cndmask_b32_e64 v87, 0, -1, s2                           // 00000002EC14: D5010057 00098280
	v_bfe_i32 v15, v15, 0, 1                                   // 00000002EC1C: D611000F 0205010F
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000002EC24: BF8701A2
	v_lshlrev_b16 v15.h, 8, v87.l op_sel:[0,0,1]               // 00000002EC28: D738400F 0002AE88
	v_or_b32_e32 v87, v92, v14                                 // 00000002EC30: 38AE1D5C
	v_and_b16 v14.h, 0xff, v15.l op_sel:[0,0,1]                // 00000002EC34: D762400E 00021EFF 000000FF
	s_waitcnt vmcnt(3)                                         // 00000002EC40: BF890FF7
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_3)// 00000002EC44: BF8701C2
	v_xor_b32_e32 v92, v98, v87                                // 00000002EC48: 3AB8AF62
	v_lshrrev_b16 v87.l, 4, v89.l                              // 00000002EC4C: D7390057 0002B284
	v_lshrrev_b32_e32 v98, 22, v13                             // 00000002EC54: 32C41A96
	v_or_b16 v14.h, v14.h, v15.h op_sel:[1,1,1]                // 00000002EC58: D763580E 00021F0E
	v_bfe_i32 v89, v87, 0, 1                                   // 00000002EC60: D6110059 02050157
	v_cndmask_b32_e64 v87, 0, -1, s1                           // 00000002EC68: D5010057 00058280
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002EC70: BF870194
	v_and_b32_e32 v98, 0x3fc, v98                              // 00000002EC74: 36C4C4FF 000003FC
	v_and_b16 v87.h, 0xff, v89.l op_sel:[0,0,1]                // 00000002EC7C: D7624057 0002B2FF 000000FF
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002EC88: BF870093
	v_lshlrev_b16 v87.l, 8, v87.l                              // 00000002EC8C: D7380057 0002AE88
	v_or_b16 v93.l, v87.h, v87.l op_sel:[1,0,0]                // 00000002EC94: D763085D 0002AF57
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 00000002EC9C: BF870131
	v_or_b32_e32 v93, v93, v14                                 // 00000002ECA0: 38BA1D5D
	v_and_b16 v14.h, 0xff00, v92.l op_sel:[0,0,1]              // 00000002ECA4: D762400E 0002B8FF FFFFFF00
	s_waitcnt vmcnt(2)                                         // 00000002ECB0: BF890BF7
	v_xor_b32_e32 v93, v99, v93                                // 00000002ECB4: 3ABABB63
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002ECB8: BF8700A2
	v_sub_nc_i16 v94.l, v14.h, v11.h op_sel:[1,1,0] clamp      // 00000002ECBC: D70E985E 0002170E
	v_lshlrev_b16 v11.h, 8, v92.l op_sel:[0,0,1]               // 00000002ECC4: D738400B 0002B888
	v_sub_nc_i16 v92.l, v11.h, v11.l op_sel:[1,0,0] clamp      // 00000002ECCC: D70E885C 0002170B
	v_and_b16 v11.l, 0xff00, v92.h op_sel:[0,1,0]              // 00000002ECD4: D762100B 0002B8FF FFFFFF00
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002ECE0: BF8700A1
	v_sub_nc_i16 v11.l, v11.l, v10.h op_sel:[0,1,0] clamp      // 00000002ECE4: D70E900B 0002150B
	v_lshlrev_b16 v10.h, 8, v92.h op_sel:[0,1,1]               // 00000002ECEC: D738500A 0002B888
	v_sub_nc_i16 v95.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002ECF4: D70E885F 0002150A
	v_and_b16 v10.l, 0xff00, v93.l                             // 00000002ECFC: D762000A 0002BAFF FFFFFF00
	v_lshlrev_b16 v10.h, 8, v93.l op_sel:[0,0,1]               // 00000002ED08: D738400A 0002BA88
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002ED10: BF870193
	v_perm_b32 v11, v95, v11, 0xc0c0105                        // 00000002ED14: D644000B 03FE175F 0C0C0105
	v_sub_nc_i16 v87.l, v10.l, v87.l clamp                     // 00000002ED20: D70E8057 0002AF0A
	v_lshlrev_b16 v10.l, 8, v89.l                              // 00000002ED28: D738000A 0002B288
	v_and_b32_e32 v95, 0xff, v13                               // 00000002ED30: 36BE1AFF 000000FF
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_4)// 00000002ED38: BF870232
	v_sub_nc_i16 v89.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002ED3C: D70E8859 0002150A
	v_and_b16 v10.l, 0xff00, v93.h op_sel:[0,1,0]              // 00000002ED44: D762100A 0002BAFF FFFFFF00
	v_lshlrev_b16 v10.h, 8, v93.h op_sel:[0,1,1]               // 00000002ED50: D738500A 0002BA88
	v_lshlrev_b32_e32 v95, 2, v95                              // 00000002ED58: 30BEBE82
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002ED5C: BF870214
	v_perm_b32 v87, v89, v87, 0xc0c0105                        // 00000002ED60: D6440057 03FEAF59 0C0C0105
	v_sub_nc_i16 v93.l, v10.l, v15.h op_sel:[0,1,0] clamp      // 00000002ED6C: D70E905D 00021F0A
	v_lshlrev_b16 v10.l, 8, v15.l                              // 00000002ED74: D738000A 00021E88
	v_perm_b32 v15, v92, v94, 0xc0c0105                        // 00000002ED7C: D644000F 03FEBD5C 0C0C0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002ED88: BF870112
	v_sub_nc_i16 v10.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002ED8C: D70E880A 0002150A
	v_lshl_or_b32 v89, v11, 16, v15                            // 00000002ED94: D6560059 043D210B
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002ED9C: BF870092
	v_perm_b32 v10, v10, v93, 0xc0c0105                        // 00000002EDA0: D644000A 03FEBB0A 0C0C0105
	v_lshl_or_b32 v92, v10, 16, v87                            // 00000002EDAC: D656005C 055D210A
	v_bfe_u32 v10, v88, 21, 8                                  // 00000002EDB4: D610000A 02212B58
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002EDBC: BF870091
	v_bcnt_u32_b32 v11, v10, 0                                 // 00000002EDC0: D71E000B 0001010A
	v_and_b32_e32 v11, 1, v11                                  // 00000002EDC8: 36161681
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002EDCC: BF870091
	v_lshlrev_b32_e32 v11, 7, v11                              // 00000002EDD0: 30161687
	v_xor_b32_e32 v10, v11, v10                                // 00000002EDD4: 3A14150B
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002EDD8: BF870091
	v_mul_lo_u32 v87, 0x1010101, v10                           // 00000002EDDC: D72C0057 000214FF 01010101
	v_and_b32_e32 v11, 0x8040201, v87                          // 00000002EDE8: 3616AEFF 08040201
	v_and_b32_e32 v88, 0x80402010, v87                         // 00000002EDF0: 36B0AEFF 80402010
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002EDF8: BF870092
	v_lshrrev_b16 v10.l, 8, v11.l                              // 00000002EDFC: D739000A 00021688
	v_cmp_ne_u16_e32 vcc_lo, 0, v10.l                          // 00000002EE04: 7C7A1480
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002EE08: BF870124
	v_lshrrev_b32_e32 v10, 24, v11                             // 00000002EE0C: 32141698
	v_cndmask_b32_e64 v15, 0, -1, vcc_lo                       // 00000002EE10: D501000F 01A98280
	v_cmp_ne_u16_e64 s0, 0, v10.l                              // 00000002EE18: D43D0000 00021480
	v_lshrrev_b16 v10.l, 8, v88.l                              // 00000002EE20: D739000A 0002B088
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002EE28: BF870112
	v_cndmask_b32_e64 v11, 0, -1, s0                           // 00000002EE2C: D501000B 00018280
	v_cmp_ne_u16_e64 s1, 0, v10.l                              // 00000002EE34: D43D0001 00021480
	v_lshrrev_b32_e32 v10, 24, v88                             // 00000002EE3C: 3214B098
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002EE40: BF8700A1
	v_cmp_ne_u16_e64 s2, 0, v10.l                              // 00000002EE44: D43D0002 00021480
	v_lshrrev_b32_e32 v10, 18, v87                             // 00000002EE4C: 3214AE92
	v_bfe_i32 v10, v10, 0, 1                                   // 00000002EE50: D611000A 0205010A
	v_lshlrev_b16 v10.h, 8, v11.l op_sel:[0,0,1]               // 00000002EE58: D738400A 00021688
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002EE60: BF870122
	v_and_b16 v11.l, 0xff, v10.l                               // 00000002EE64: D762000B 000214FF 000000FF
	v_lshlrev_b16 v10.l, 8, v10.l                              // 00000002EE70: D738000A 00021488
	v_or_b16 v14.h, v11.l, v10.h op_sel:[0,1,1]                // 00000002EE78: D763500E 0002150B
	v_bfe_i32 v11, v87, 0, 1                                   // 00000002EE80: D611000B 02050157
	v_lshlrev_b16 v11.h, 8, v15.l op_sel:[0,0,1]               // 00000002EE88: D738400B 00021E88
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002EE90: BF870122
	v_and_b16 v15.l, 0xff, v11.l                               // 00000002EE94: D762000F 000216FF 000000FF
	v_lshlrev_b16 v11.l, 8, v11.l                              // 00000002EEA0: D738000B 00021688
	v_or_b16 v90.l, v15.l, v11.h op_sel:[0,1,0]                // 00000002EEA8: D763105A 0002170F
	v_lshrrev_b32_e32 v15, 22, v87                             // 00000002EEB0: 321EAE96
	v_cndmask_b32_e64 v87, 0, -1, s2                           // 00000002EEB4: D5010057 00098280
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002EEBC: BF870112
	v_bfe_i32 v15, v15, 0, 1                                   // 00000002EEC0: D611000F 0205010F
	v_lshlrev_b16 v15.h, 8, v87.l op_sel:[0,0,1]               // 00000002EEC8: D738400F 0002AE88
	v_or_b32_e32 v87, v90, v14                                 // 00000002EED0: 38AE1D5A
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002EED4: BF870123
	v_and_b16 v14.h, 0xff, v15.l op_sel:[0,0,1]                // 00000002EED8: D762400E 00021EFF 000000FF
	s_waitcnt vmcnt(1)                                         // 00000002EEE4: BF8907F7
	v_xor_b32_e32 v90, v100, v87                               // 00000002EEE8: 3AB4AF64
	v_lshrrev_b16 v87.l, 4, v88.l                              // 00000002EEEC: D7390057 0002B084
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002EEF4: BF870113
	v_or_b16 v14.h, v14.h, v15.h op_sel:[1,1,1]                // 00000002EEF8: D763580E 00021F0E
	v_bfe_i32 v88, v87, 0, 1                                   // 00000002EF00: D6110058 02050157
	v_cndmask_b32_e64 v87, 0, -1, s1                           // 00000002EF08: D5010057 00058280
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002EF10: BF870112
	v_and_b16 v87.h, 0xff, v88.l op_sel:[0,0,1]                // 00000002EF14: D7624057 0002B0FF 000000FF
	v_lshlrev_b16 v87.l, 8, v87.l                              // 00000002EF20: D7380057 0002AE88
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002EF28: BF870091
	v_or_b16 v91.l, v87.h, v87.l op_sel:[1,0,0]                // 00000002EF2C: D763085B 0002AF57
	v_or_b32_e32 v91, v91, v14                                 // 00000002EF34: 38B61D5B
	v_and_b16 v14.h, 0xff00, v90.l op_sel:[0,0,1]              // 00000002EF38: D762400E 0002B4FF FFFFFF00
	s_waitcnt vmcnt(0)                                         // 00000002EF44: BF8903F7
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002EF48: BF870112
	v_xor_b32_e32 v91, v101, v91                               // 00000002EF4C: 3AB6B765
	v_sub_nc_i16 v93.l, v14.h, v11.h op_sel:[1,1,0] clamp      // 00000002EF50: D70E985D 0002170E
	v_lshlrev_b16 v11.h, 8, v90.l op_sel:[0,0,1]               // 00000002EF58: D738400B 0002B488
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002EF60: BF8700A1
	v_sub_nc_i16 v90.l, v11.h, v11.l op_sel:[1,0,0] clamp      // 00000002EF64: D70E885A 0002170B
	v_and_b16 v11.l, 0xff00, v90.h op_sel:[0,1,0]              // 00000002EF6C: D762100B 0002B4FF FFFFFF00
	v_sub_nc_i16 v11.l, v11.l, v10.h op_sel:[0,1,0] clamp      // 00000002EF78: D70E900B 0002150B
	v_lshlrev_b16 v10.h, 8, v90.h op_sel:[0,1,1]               // 00000002EF80: D738500A 0002B488
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000002EF88: BF8701B1
	v_sub_nc_i16 v94.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002EF8C: D70E885E 0002150A
	v_and_b16 v10.l, 0xff00, v91.l                             // 00000002EF94: D762000A 0002B6FF FFFFFF00
	v_lshlrev_b16 v10.h, 8, v91.l op_sel:[0,0,1]               // 00000002EFA0: D738400A 0002B688
	v_perm_b32 v11, v94, v11, 0xc0c0105                        // 00000002EFA8: D644000B 03FE175E 0C0C0105
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 00000002EFB4: BF870133
	v_sub_nc_i16 v87.l, v10.l, v87.l clamp                     // 00000002EFB8: D70E8057 0002AF0A
	v_lshlrev_b16 v10.l, 8, v88.l                              // 00000002EFC0: D738000A 0002B088
	v_lshrrev_b32_e32 v94, 22, v12                             // 00000002EFC8: 32BC1896
	v_sub_nc_i16 v88.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002EFCC: D70E8858 0002150A
	v_and_b16 v10.l, 0xff00, v91.h op_sel:[0,1,0]              // 00000002EFD4: D762100A 0002B6FF FFFFFF00
	v_lshlrev_b16 v10.h, 8, v91.h op_sel:[0,1,1]               // 00000002EFE0: D738500A 0002B688
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002EFE8: BF870214
	v_and_b32_e32 v94, 0x3fc, v94                              // 00000002EFEC: 36BCBCFF 000003FC
	v_perm_b32 v87, v88, v87, 0xc0c0105                        // 00000002EFF4: D6440057 03FEAF58 0C0C0105
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_3) | instid1(VALU_DEP_3)// 00000002F000: BF8701C4
	v_sub_nc_i16 v91.l, v10.l, v15.h op_sel:[0,1,0] clamp      // 00000002F004: D70E905B 00021F0A
	v_lshlrev_b16 v10.l, 8, v15.l                              // 00000002F00C: D738000A 00021E88
	v_perm_b32 v15, v90, v93, 0xc0c0105                        // 00000002F014: D644000F 03FEBB5A 0C0C0105
	v_lshrrev_b32_e32 v93, 14, v12                             // 00000002F020: 32BA188E
	v_sub_nc_i16 v10.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002F024: D70E880A 0002150A
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002F02C: BF870193
	v_lshl_or_b32 v11, v11, 16, v15                            // 00000002F030: D656000B 043D210B
	v_and_b32_e32 v93, 0x3fc, v93                              // 00000002F038: 36BABAFF 000003FC
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002F040: BF870123
	v_perm_b32 v10, v10, v91, 0xc0c0105                        // 00000002F044: D644000A 03FEB70A 0C0C0105
	v_and_b32_e32 v91, 0xff, v12                               // 00000002F050: 36B618FF 000000FF
	v_lshl_or_b32 v10, v10, 16, v87                            // 00000002F058: D656000A 055D210A
	ds_store_2addr_b32 v44, v89, v92 offset1:1                 // 00000002F060: D8380100 005C592C
	ds_store_2addr_b32 v45, v11, v10 offset1:1                 // 00000002F068: D8380100 000A0B2D
	v_lshrrev_b32_e32 v92, 6, v12                              // 00000002F070: 32B81886
	v_lshlrev_b32_e32 v91, 2, v91                              // 00000002F074: 30B6B682
	v_and_b32_e32 v10, 0xff, v86                               // 00000002F078: 3614ACFF 000000FF
	v_mov_b16_e32 v87.h, v14.l                                 // 00000002F080: 7FAE390E
	v_mov_b16_e32 v89.h, v14.l                                 // 00000002F084: 7FB2390E
	v_and_b32_e32 v92, 0x3fc, v92                              // 00000002F088: 36B8B8FF 000003FC
	s_clause 0x7                                               // 00000002F090: BF850007
	global_load_b32 v91, v91, s[10:11]                         // 00000002F094: DC520000 5B0A005B
	global_load_b32 v92, v92, s[10:11]                         // 00000002F09C: DC520000 5C0A005C
	global_load_b32 v93, v93, s[10:11]                         // 00000002F0A4: DC520000 5D0A005D
	global_load_b32 v94, v94, s[10:11]                         // 00000002F0AC: DC520000 5E0A005E
	global_load_b32 v95, v95, s[10:11]                         // 00000002F0B4: DC520000 5F0A005F
	global_load_b32 v96, v96, s[10:11]                         // 00000002F0BC: DC520000 600A0060
	global_load_b32 v97, v97, s[10:11]                         // 00000002F0C4: DC520000 610A0061
	global_load_b32 v98, v98, s[10:11]                         // 00000002F0CC: DC520000 620A0062
	v_bcnt_u32_b32 v11, v10, 0                                 // 00000002F0D4: D71E000B 0001010A
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002F0DC: BF870091
	v_and_b32_e32 v11, 1, v11                                  // 00000002F0E0: 36161681
	v_lshlrev_b32_e32 v11, 7, v11                              // 00000002F0E4: 30161687
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002F0E8: BF870121
	v_xor_b32_e32 v10, v11, v10                                // 00000002F0EC: 3A14150B
	v_bfe_u32 v11, v86, 7, 8                                   // 00000002F0F0: D610000B 02210F56
	v_mul_lo_u32 v13, 0x1010101, v10                           // 00000002F0F8: D72C000D 000214FF 01010101
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002F104: BF870092
	v_bcnt_u32_b32 v12, v11, 0                                 // 00000002F108: D71E000C 0001010B
	v_and_b32_e32 v12, 1, v12                                  // 00000002F110: 36181881
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002F114: BF870113
	v_and_b32_e32 v15, 0x80402010, v13                         // 00000002F118: 361E1AFF 80402010
	v_lshlrev_b32_e32 v12, 7, v12                              // 00000002F120: 30181887
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002F124: BF870121
	v_xor_b32_e32 v11, v12, v11                                // 00000002F128: 3A16170C
	v_and_b32_e32 v12, 0x8040201, v13                          // 00000002F12C: 36181AFF 08040201
	v_mul_lo_u32 v90, 0x1010101, v11                           // 00000002F134: D72C005A 000216FF 01010101
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002F140: BF870092
	v_lshrrev_b16 v10.l, 8, v12.l                              // 00000002F144: D739000A 00021888
	v_cmp_ne_u16_e32 vcc_lo, 0, v10.l                          // 00000002F14C: 7C7A1480
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002F150: BF870214
	v_lshrrev_b32_e32 v10, 24, v12                             // 00000002F154: 32141898
	v_and_b32_e32 v11, 0x8040201, v90                          // 00000002F158: 3616B4FF 08040201
	v_and_b32_e32 v99, 0x80402010, v90                         // 00000002F160: 36C6B4FF 80402010
	v_cndmask_b32_e64 v12, 0, -1, vcc_lo                       // 00000002F168: D501000C 01A98280
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002F170: BF8700A4
	v_cmp_ne_u16_e64 s0, 0, v10.l                              // 00000002F174: D43D0000 00021480
	v_lshrrev_b16 v10.l, 8, v15.l                              // 00000002F17C: D739000A 00021E88
	v_cmp_ne_u16_e64 s1, 0, v10.l                              // 00000002F184: D43D0001 00021480
	v_lshrrev_b32_e32 v10, 24, v15                             // 00000002F18C: 32141E98
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002F190: BF8700A1
	v_cmp_ne_u16_e64 s2, 0, v10.l                              // 00000002F194: D43D0002 00021480
	v_lshrrev_b16 v10.l, 8, v11.l                              // 00000002F19C: D739000A 00021688
	v_cmp_ne_u16_e64 s3, 0, v10.l                              // 00000002F1A4: D43D0003 00021480
	v_lshrrev_b32_e32 v10, 24, v11                             // 00000002F1AC: 32141698
	v_cndmask_b32_e64 v11, 0, -1, s0                           // 00000002F1B0: D501000B 00018280
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002F1B8: BF870122
	v_cmp_ne_u16_e64 s4, 0, v10.l                              // 00000002F1BC: D43D0004 00021480
	v_lshrrev_b16 v10.l, 8, v99.l                              // 00000002F1C4: D739000A 0002C688
	v_cndmask_b32_e64 v88, 0, -1, s4                           // 00000002F1CC: D5010058 00118280
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002F1D4: BF8700A2
	v_cmp_ne_u16_e64 s5, 0, v10.l                              // 00000002F1D8: D43D0005 00021480
	v_lshrrev_b32_e32 v10, 24, v99                             // 00000002F1E0: 3214C698
	v_cmp_ne_u16_e64 s6, 0, v10.l                              // 00000002F1E4: D43D0006 00021480
	v_lshrrev_b32_e32 v10, 18, v13                             // 00000002F1EC: 32141A92
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002F1F0: BF870121
	v_bfe_i32 v10, v10, 0, 1                                   // 00000002F1F4: D611000A 0205010A
	v_lshlrev_b16 v10.h, 8, v11.l op_sel:[0,0,1]               // 00000002F1FC: D738400A 00021688
	v_and_b16 v11.l, 0xff, v10.l                               // 00000002F204: D762000B 000214FF 000000FF
	v_lshlrev_b16 v10.l, 8, v10.l                              // 00000002F210: D738000A 00021488
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 00000002F218: BF870132
	v_or_b16 v14.h, v11.l, v10.h op_sel:[0,1,1]                // 00000002F21C: D763500E 0002150B
	v_bfe_i32 v11, v13, 0, 1                                   // 00000002F224: D611000B 0205010D
	v_lshlrev_b16 v11.h, 8, v12.l op_sel:[0,0,1]               // 00000002F22C: D738400B 00021888
	v_and_b16 v12.l, 0xff, v11.l                               // 00000002F234: D762000C 000216FF 000000FF
	v_lshlrev_b16 v11.l, 8, v11.l                              // 00000002F240: D738000B 00021688
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000002F248: BF8701B2
	v_or_b16 v87.l, v12.l, v11.h op_sel:[0,1,0]                // 00000002F24C: D7631057 0002170C
	v_lshrrev_b32_e32 v12, 22, v13                             // 00000002F254: 32181A96
	v_cndmask_b32_e64 v13, 0, -1, s2                           // 00000002F258: D501000D 00098280
	v_or_b32_e32 v100, v87, v14                                // 00000002F260: 38C81D57
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002F264: BF870193
	v_bfe_i32 v12, v12, 0, 1                                   // 00000002F268: D611000C 0205010C
	v_lshlrev_b16 v12.h, 8, v13.l op_sel:[0,0,1]               // 00000002F270: D738400C 00021A88
	v_lshrrev_b32_e32 v87, 18, v90                             // 00000002F278: 32AEB492
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002F27C: BF870113
	v_and_b16 v13.l, 0xff, v12.l                               // 00000002F280: D762000D 000218FF 000000FF
	v_bfe_i32 v87, v87, 0, 1                                   // 00000002F28C: D6110057 02050157
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002F294: BF8700A2
	v_or_b16 v14.h, v13.l, v12.h op_sel:[0,1,1]                // 00000002F298: D763500E 0002190D
	v_lshrrev_b16 v13.l, 4, v15.l                              // 00000002F2A0: D739000D 00021E84
	v_bfe_i32 v15, v13, 0, 1                                   // 00000002F2A8: D611000F 0205010D
	v_cndmask_b32_e64 v13, 0, -1, s1                           // 00000002F2B0: D501000D 00058280
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002F2B8: BF870112
	v_and_b16 v13.h, 0xff, v15.l op_sel:[0,0,1]                // 00000002F2BC: D762400D 00021EFF 000000FF
	v_lshlrev_b16 v13.l, 8, v13.l                              // 00000002F2C8: D738000D 00021A88
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000002F2D0: BF8701B1
	v_or_b16 v89.l, v13.h, v13.l op_sel:[1,0,0]                // 00000002F2D4: D7630859 00021B0D
	v_lshlrev_b16 v13.h, 8, v88.l op_sel:[0,0,1]               // 00000002F2DC: D738400D 0002B088
	v_bfe_i32 v88, v90, 0, 1                                   // 00000002F2E4: D6110058 0205015A
	v_or_b32_e32 v101, v89, v14                                // 00000002F2EC: 38CA1D59
	v_cndmask_b32_e64 v89, 0, -1, s3                           // 00000002F2F0: D5010059 000D8280
	v_and_b16 v14.h, 0xff, v87.l op_sel:[0,0,1]                // 00000002F2F8: D762400E 0002AEFF 000000FF
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002F304: BF870194
	v_and_b16 v87.h, 0xff, v88.l op_sel:[0,0,1]                // 00000002F308: D7624057 0002B0FF 000000FF
	v_lshlrev_b16 v15.h, 8, v89.l op_sel:[0,0,1]               // 00000002F314: D738400F 0002B288
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_4)// 00000002F31C: BF870233
	v_or_b16 v14.h, v14.h, v13.h op_sel:[1,1,1]                // 00000002F320: D763580E 00021B0E
	v_lshrrev_b32_e32 v89, 22, v90                             // 00000002F328: 32B2B496
	v_cndmask_b32_e64 v90, 0, -1, s6                           // 00000002F32C: D501005A 00198280
	v_or_b16 v102.l, v87.h, v15.h op_sel:[1,1,0]               // 00000002F334: D7631866 00021F57
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002F33C: BF870193
	v_bfe_i32 v89, v89, 0, 1                                   // 00000002F340: D6110059 02050159
	v_lshlrev_b16 v87.h, 8, v90.l op_sel:[0,0,1]               // 00000002F348: D7384057 0002B488
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002F350: BF870193
	v_or_b32_e32 v90, v102, v14                                // 00000002F354: 38B41D66
	v_and_b16 v14.h, 0xff, v89.l op_sel:[0,0,1]                // 00000002F358: D762400E 0002B2FF 000000FF
	s_delay_alu instid0(VALU_DEP_1)                            // 00000002F364: BF870001
	v_or_b16 v14.h, v14.h, v87.h op_sel:[1,1,1]                // 00000002F368: D763580E 0002AF0E
	s_waitcnt vmcnt(7)                                         // 00000002F370: BF891FF7
	v_xor_b32_e32 v100, v91, v100                              // 00000002F374: 3AC8C95B
	s_waitcnt vmcnt(6)                                         // 00000002F378: BF891BF7
	v_xor_b32_e32 v92, v92, v101                               // 00000002F37C: 3AB8CB5C
	s_waitcnt vmcnt(5)                                         // 00000002F380: BF8917F7
	v_xor_b32_e32 v93, v93, v90                                // 00000002F384: 3ABAB55D
	v_lshrrev_b16 v90.l, 4, v99.l                              // 00000002F388: D739005A 0002C684
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000002F390: BF8701B1
	v_bfe_i32 v91, v90, 0, 1                                   // 00000002F394: D611005B 0205015A
	v_cndmask_b32_e64 v90, 0, -1, s5                           // 00000002F39C: D501005A 00158280
	v_mov_b16_e32 v90.h, v14.l                                 // 00000002F3A4: 7FB4390E
	v_and_b16 v89.h, 0xff, v91.l op_sel:[0,0,1]                // 00000002F3A8: D7624059 0002B6FF 000000FF
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002F3B4: BF870093
	v_lshlrev_b16 v88.h, 8, v90.l op_sel:[0,0,1]               // 00000002F3B8: D7384058 0002B488
	v_or_b16 v90.l, v89.h, v88.h op_sel:[1,1,0]                // 00000002F3C0: D763185A 0002B159
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 00000002F3C8: BF870131
	v_or_b32_e32 v90, v90, v14                                 // 00000002F3CC: 38B41D5A
	v_and_b16 v14.h, 0xff00, v100.l op_sel:[0,0,1]             // 00000002F3D0: D762400E 0002C8FF FFFFFF00
	s_waitcnt vmcnt(4)                                         // 00000002F3DC: BF8913F7
	v_xor_b32_e32 v90, v94, v90                                // 00000002F3E0: 3AB4B55E
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002F3E4: BF8700A2
	v_sub_nc_i16 v94.l, v14.h, v11.h op_sel:[1,1,0] clamp      // 00000002F3E8: D70E985E 0002170E
	v_lshlrev_b16 v11.h, 8, v100.l op_sel:[0,0,1]              // 00000002F3F0: D738400B 0002C888
	v_sub_nc_i16 v99.l, v11.h, v11.l op_sel:[1,0,0] clamp      // 00000002F3F8: D70E8863 0002170B
	v_and_b16 v11.l, 0xff00, v100.h op_sel:[0,1,0]             // 00000002F400: D762100B 0002C8FF FFFFFF00
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002F40C: BF8700A1
	v_sub_nc_i16 v11.l, v11.l, v10.h op_sel:[0,1,0] clamp      // 00000002F410: D70E900B 0002150B
	v_lshlrev_b16 v10.h, 8, v100.h op_sel:[0,1,1]              // 00000002F418: D738500A 0002C888
	v_sub_nc_i16 v100.l, v10.h, v10.l op_sel:[1,0,0] clamp     // 00000002F420: D70E8864 0002150A
	v_and_b16 v10.l, 0xff00, v92.l                             // 00000002F428: D762000A 0002B8FF FFFFFF00
	v_lshlrev_b16 v10.h, 8, v92.l op_sel:[0,0,1]               // 00000002F434: D738400A 0002B888
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002F43C: BF870193
	v_perm_b32 v11, v100, v11, 0xc0c0105                       // 00000002F440: D644000B 03FE1764 0C0C0105
	v_sub_nc_i16 v13.l, v10.l, v13.l clamp                     // 00000002F44C: D70E800D 00021B0A
	v_lshlrev_b16 v10.l, 8, v15.l                              // 00000002F454: D738000A 00021E88
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 00000002F45C: BF870131
	v_sub_nc_i16 v15.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002F460: D70E880F 0002150A
	v_and_b16 v10.l, 0xff00, v92.h op_sel:[0,1,0]              // 00000002F468: D762100A 0002B8FF FFFFFF00
	v_lshlrev_b16 v10.h, 8, v92.h op_sel:[0,1,1]               // 00000002F474: D738500A 0002B888
	v_sub_nc_i16 v92.l, v10.l, v12.h op_sel:[0,1,0] clamp      // 00000002F47C: D70E905C 0002190A
	v_lshlrev_b16 v10.l, 8, v12.l                              // 00000002F484: D738000A 00021888
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000002F48C: BF8701B1
	v_sub_nc_i16 v12.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002F490: D70E880C 0002150A
	v_and_b16 v10.l, 0xff00, v93.l                             // 00000002F498: D762000A 0002BAFF FFFFFF00
	v_lshlrev_b16 v10.h, 8, v93.l op_sel:[0,0,1]               // 00000002F4A4: D738400A 0002BA88
	v_perm_b32 v12, v12, v92, 0xc0c0105                        // 00000002F4AC: D644000C 03FEB90C 0C0C0105
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002F4B8: BF8700A3
	v_sub_nc_i16 v101.l, v10.l, v15.h op_sel:[0,1,0] clamp     // 00000002F4BC: D70E9065 00021F0A
	v_lshlrev_b16 v10.l, 8, v88.l                              // 00000002F4C4: D738000A 0002B088
	v_sub_nc_i16 v88.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002F4CC: D70E8858 0002150A
	v_and_b16 v10.l, 0xff00, v93.h op_sel:[0,1,0]              // 00000002F4D4: D762100A 0002BAFF FFFFFF00
	v_lshlrev_b16 v10.h, 8, v93.h op_sel:[0,1,1]               // 00000002F4E0: D738500A 0002BA88
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_3)// 00000002F4E8: BF8701C2
	v_sub_nc_i16 v93.l, v10.l, v13.h op_sel:[0,1,0] clamp      // 00000002F4EC: D70E905D 00021B0A
	v_lshlrev_b16 v10.l, 8, v87.l                              // 00000002F4F4: D738000A 0002AE88
	v_perm_b32 v13, v15, v13, 0xc0c0105                        // 00000002F4FC: D644000D 03FE1B0F 0C0C0105
	v_perm_b32 v15, v88, v101, 0xc0c0105                       // 00000002F508: D644000F 03FECB58 0C0C0105
	v_sub_nc_i16 v87.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002F514: D70E8857 0002150A
	v_and_b16 v10.l, 0xff00, v90.l                             // 00000002F51C: D762000A 0002B4FF FFFFFF00
	v_lshlrev_b16 v10.h, 8, v90.l op_sel:[0,0,1]               // 00000002F528: D738400A 0002B488
	v_lshl_or_b32 v12, v12, 16, v13                            // 00000002F530: D656000C 0435210C
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002F538: BF8700A3
	v_sub_nc_i16 v102.l, v10.l, v88.h op_sel:[0,1,0] clamp     // 00000002F53C: D70E9066 0002B10A
	v_lshlrev_b16 v10.l, 8, v91.l                              // 00000002F544: D738000A 0002B688
	v_sub_nc_i16 v90.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002F54C: D70E885A 0002150A
	v_and_b16 v10.l, 0xff00, v90.h op_sel:[0,1,0]              // 00000002F554: D762100A 0002B4FF FFFFFF00
	v_lshlrev_b16 v10.h, 8, v90.h op_sel:[0,1,1]               // 00000002F560: D738500A 0002B488
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002F568: BF870193
	v_perm_b32 v88, v90, v102, 0xc0c0105                       // 00000002F56C: D6440058 03FECD5A 0C0C0105
	v_sub_nc_i16 v91.l, v10.l, v87.h op_sel:[0,1,0] clamp      // 00000002F578: D70E905B 0002AF0A
	v_lshlrev_b16 v10.l, 8, v89.l                              // 00000002F580: D738000A 0002B288
	v_perm_b32 v89, v99, v94, 0xc0c0105                        // 00000002F588: D6440059 03FEBD63 0C0C0105
	v_perm_b32 v87, v87, v93, 0xc0c0105                        // 00000002F594: D6440057 03FEBB57 0C0C0105
	v_mov_b16_e32 v90.h, v14.l                                 // 00000002F5A0: 7FB4390E
	v_lshrrev_b32_e32 v93, 6, v9                               // 00000002F5A4: 32BA1286
	v_sub_nc_i16 v10.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002F5A8: D70E880A 0002150A
	v_lshl_or_b32 v11, v11, 16, v89                            // 00000002F5B0: D656000B 0565210B
	v_lshl_or_b32 v87, v87, 16, v15                            // 00000002F5B8: D6560057 043D2157
	v_mov_b16_e32 v89.h, v14.l                                 // 00000002F5C0: 7FB2390E
	v_lshrrev_b32_e32 v94, 14, v9                              // 00000002F5C4: 32BC128E
	v_perm_b32 v10, v10, v91, 0xc0c0105                        // 00000002F5C8: D644000A 03FEB70A 0C0C0105
	v_and_b32_e32 v93, 0x3fc, v93                              // 00000002F5D4: 36BABAFF 000003FC
	v_mov_b16_e32 v99.h, v14.l                                 // 00000002F5DC: 7FC6390E
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002F5E0: BF870214
	v_and_b32_e32 v94, 0x3fc, v94                              // 00000002F5E4: 36BCBCFF 000003FC
	v_lshl_or_b32 v88, v10, 16, v88                            // 00000002F5EC: D6560058 0561210A
	v_bfe_u32 v10, v86, 14, 8                                  // 00000002F5F4: D610000A 02211D56
	ds_store_2addr_b32 v46, v11, v12 offset1:1                 // 00000002F5FC: D8380100 000C0B2E
	ds_store_2addr_b32 v47, v87, v88 offset1:1                 // 00000002F604: D8380100 0058572F
	v_bcnt_u32_b32 v11, v10, 0                                 // 00000002F60C: D71E000B 0001010A
	v_mov_b16_e32 v87.h, v14.l                                 // 00000002F614: 7FAE390E
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002F618: BF870092
	v_and_b32_e32 v11, 1, v11                                  // 00000002F61C: 36161681
	v_lshlrev_b32_e32 v11, 7, v11                              // 00000002F620: 30161687
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002F624: BF870091
	v_xor_b32_e32 v10, v11, v10                                // 00000002F628: 3A14150B
	v_mul_lo_u32 v13, 0x1010101, v10                           // 00000002F62C: D72C000D 000214FF 01010101
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002F638: BF870121
	v_and_b32_e32 v11, 0x8040201, v13                          // 00000002F63C: 36161AFF 08040201
	v_and_b32_e32 v15, 0x80402010, v13                         // 00000002F644: 361E1AFF 80402010
	v_lshrrev_b16 v10.l, 8, v11.l                              // 00000002F64C: D739000A 00021688
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002F654: BF870211
	v_cmp_ne_u16_e32 vcc_lo, 0, v10.l                          // 00000002F658: 7C7A1480
	v_lshrrev_b32_e32 v10, 24, v11                             // 00000002F65C: 32141698
	v_cndmask_b32_e64 v12, 0, -1, vcc_lo                       // 00000002F660: D501000C 01A98280
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002F668: BF870122
	v_cmp_ne_u16_e64 s0, 0, v10.l                              // 00000002F66C: D43D0000 00021480
	v_lshrrev_b16 v10.l, 8, v15.l                              // 00000002F674: D739000A 00021E88
	v_cndmask_b32_e64 v11, 0, -1, s0                           // 00000002F67C: D501000B 00018280
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002F684: BF8700A2
	v_cmp_ne_u16_e64 s1, 0, v10.l                              // 00000002F688: D43D0001 00021480
	v_lshrrev_b32_e32 v10, 24, v15                             // 00000002F690: 32141E98
	v_cmp_ne_u16_e64 s2, 0, v10.l                              // 00000002F694: D43D0002 00021480
	v_lshrrev_b32_e32 v10, 18, v13                             // 00000002F69C: 32141A92
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002F6A0: BF870121
	v_bfe_i32 v10, v10, 0, 1                                   // 00000002F6A4: D611000A 0205010A
	v_lshlrev_b16 v10.h, 8, v11.l op_sel:[0,0,1]               // 00000002F6AC: D738400A 00021688
	v_and_b16 v11.l, 0xff, v10.l                               // 00000002F6B4: D762000B 000214FF 000000FF
	v_lshlrev_b16 v10.l, 8, v10.l                              // 00000002F6C0: D738000A 00021488
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 00000002F6C8: BF870132
	v_or_b16 v14.h, v11.l, v10.h op_sel:[0,1,1]                // 00000002F6CC: D763500E 0002150B
	v_bfe_i32 v11, v13, 0, 1                                   // 00000002F6D4: D611000B 0205010D
	v_lshlrev_b16 v11.h, 8, v12.l op_sel:[0,0,1]               // 00000002F6DC: D738400B 00021888
	v_and_b16 v12.l, 0xff, v11.l                               // 00000002F6E4: D762000C 000216FF 000000FF
	v_lshlrev_b16 v11.l, 8, v11.l                              // 00000002F6F0: D738000B 00021688
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000002F6F8: BF8701B2
	v_or_b16 v89.l, v12.l, v11.h op_sel:[0,1,0]                // 00000002F6FC: D7631059 0002170C
	v_lshrrev_b32_e32 v12, 22, v13                             // 00000002F704: 32181A96
	v_cndmask_b32_e64 v13, 0, -1, s2                           // 00000002F708: D501000D 00098280
	v_or_b32_e32 v89, v89, v14                                 // 00000002F710: 38B21D59
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002F714: BF870193
	v_bfe_i32 v12, v12, 0, 1                                   // 00000002F718: D611000C 0205010C
	v_lshlrev_b16 v12.h, 8, v13.l op_sel:[0,0,1]               // 00000002F720: D738400C 00021A88
	s_waitcnt vmcnt(3)                                         // 00000002F728: BF890FF7
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002F72C: BF870193
	v_xor_b32_e32 v89, v95, v89                                // 00000002F730: 3AB2B35F
	v_and_b16 v13.l, 0xff, v12.l                               // 00000002F734: D762000D 000218FF 000000FF
	v_lshrrev_b32_e32 v95, 22, v9                              // 00000002F740: 32BE1296
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000002F744: BF8701A2
	v_or_b16 v14.h, v13.l, v12.h op_sel:[0,1,1]                // 00000002F748: D763500E 0002190D
	v_lshrrev_b16 v13.l, 4, v15.l                              // 00000002F750: D739000D 00021E84
	v_and_b32_e32 v95, 0x3fc, v95                              // 00000002F758: 36BEBEFF 000003FC
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002F760: BF870122
	v_bfe_i32 v15, v13, 0, 1                                   // 00000002F764: D611000F 0205010D
	v_cndmask_b32_e64 v13, 0, -1, s1                           // 00000002F76C: D501000D 00058280
	v_and_b16 v13.h, 0xff, v15.l op_sel:[0,0,1]                // 00000002F774: D762400D 00021EFF 000000FF
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002F780: BF870092
	v_lshlrev_b16 v13.l, 8, v13.l                              // 00000002F784: D738000D 00021A88
	v_or_b16 v90.l, v13.h, v13.l op_sel:[1,0,0]                // 00000002F78C: D763085A 00021B0D
	v_and_b16 v13.h, 0xff00, v89.l op_sel:[0,0,1]              // 00000002F794: D762400D 0002B2FF FFFFFF00
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002F7A0: BF870112
	v_or_b32_e32 v90, v90, v14                                 // 00000002F7A4: 38B41D5A
	v_sub_nc_i16 v91.l, v13.h, v11.h op_sel:[1,1,0] clamp      // 00000002F7A8: D70E985B 0002170D
	v_lshlrev_b16 v11.h, 8, v89.l op_sel:[0,0,1]               // 00000002F7B0: D738400B 0002B288
	s_waitcnt vmcnt(2)                                         // 00000002F7B8: BF890BF7
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002F7BC: BF870113
	v_xor_b32_e32 v90, v96, v90                                // 00000002F7C0: 3AB4B560
	v_sub_nc_i16 v89.l, v11.h, v11.l op_sel:[1,0,0] clamp      // 00000002F7C4: D70E8859 0002170B
	v_and_b16 v11.l, 0xff00, v89.h op_sel:[0,1,0]              // 00000002F7CC: D762100B 0002B2FF FFFFFF00
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002F7D8: BF8700A1
	v_sub_nc_i16 v11.l, v11.l, v10.h op_sel:[0,1,0] clamp      // 00000002F7DC: D70E900B 0002150B
	v_lshlrev_b16 v10.h, 8, v89.h op_sel:[0,1,1]               // 00000002F7E4: D738500A 0002B288
	v_sub_nc_i16 v92.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002F7EC: D70E885C 0002150A
	v_and_b16 v10.l, 0xff00, v90.l                             // 00000002F7F4: D762000A 0002B4FF FFFFFF00
	v_lshlrev_b16 v10.h, 8, v90.l op_sel:[0,0,1]               // 00000002F800: D738400A 0002B488
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002F808: BF870193
	v_perm_b32 v11, v92, v11, 0xc0c0105                        // 00000002F80C: D644000B 03FE175C 0C0C0105
	v_sub_nc_i16 v13.l, v10.l, v13.l clamp                     // 00000002F818: D70E800D 00021B0A
	v_lshlrev_b16 v10.l, 8, v15.l                              // 00000002F820: D738000A 00021E88
	v_and_b32_e32 v92, 0xff, v9                                // 00000002F828: 36B812FF 000000FF
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_4)// 00000002F830: BF870232
	v_sub_nc_i16 v15.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002F834: D70E880F 0002150A
	v_and_b16 v10.l, 0xff00, v90.h op_sel:[0,1,0]              // 00000002F83C: D762100A 0002B4FF FFFFFF00
	v_lshlrev_b16 v10.h, 8, v90.h op_sel:[0,1,1]               // 00000002F848: D738500A 0002B488
	v_lshlrev_b32_e32 v92, 2, v92                              // 00000002F850: 30B8B882
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002F854: BF870214
	v_perm_b32 v13, v15, v13, 0xc0c0105                        // 00000002F858: D644000D 03FE1B0F 0C0C0105
	v_sub_nc_i16 v90.l, v10.l, v12.h op_sel:[0,1,0] clamp      // 00000002F864: D70E905A 0002190A
	v_lshlrev_b16 v10.l, 8, v12.l                              // 00000002F86C: D738000A 00021888
	v_perm_b32 v12, v89, v91, 0xc0c0105                        // 00000002F874: D644000C 03FEB759 0C0C0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002F880: BF870112
	v_sub_nc_i16 v10.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002F884: D70E880A 0002150A
	v_lshl_or_b32 v89, v11, 16, v12                            // 00000002F88C: D6560059 0431210B
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002F894: BF870092
	v_perm_b32 v10, v10, v90, 0xc0c0105                        // 00000002F898: D644000A 03FEB50A 0C0C0105
	v_lshl_or_b32 v90, v10, 16, v13                            // 00000002F8A4: D656005A 0435210A
	v_bfe_u32 v10, v86, 21, 8                                  // 00000002F8AC: D610000A 02212B56
	v_mov_b16_e32 v86.h, v14.l                                 // 00000002F8B4: 7FAC390E
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002F8B8: BF870092
	v_bcnt_u32_b32 v11, v10, 0                                 // 00000002F8BC: D71E000B 0001010A
	v_and_b32_e32 v11, 1, v11                                  // 00000002F8C4: 36161681
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002F8C8: BF870091
	v_lshlrev_b32_e32 v11, 7, v11                              // 00000002F8CC: 30161687
	v_xor_b32_e32 v10, v11, v10                                // 00000002F8D0: 3A14150B
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002F8D4: BF870091
	v_mul_lo_u32 v13, 0x1010101, v10                           // 00000002F8D8: D72C000D 000214FF 01010101
	v_and_b32_e32 v11, 0x8040201, v13                          // 00000002F8E4: 36161AFF 08040201
	v_and_b32_e32 v15, 0x80402010, v13                         // 00000002F8EC: 361E1AFF 80402010
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002F8F4: BF870092
	v_lshrrev_b16 v10.l, 8, v11.l                              // 00000002F8F8: D739000A 00021688
	v_cmp_ne_u16_e32 vcc_lo, 0, v10.l                          // 00000002F900: 7C7A1480
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002F904: BF870124
	v_lshrrev_b32_e32 v10, 24, v11                             // 00000002F908: 32141698
	v_cndmask_b32_e64 v12, 0, -1, vcc_lo                       // 00000002F90C: D501000C 01A98280
	v_cmp_ne_u16_e64 s0, 0, v10.l                              // 00000002F914: D43D0000 00021480
	v_lshrrev_b16 v10.l, 8, v15.l                              // 00000002F91C: D739000A 00021E88
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002F924: BF870112
	v_cndmask_b32_e64 v11, 0, -1, s0                           // 00000002F928: D501000B 00018280
	v_cmp_ne_u16_e64 s1, 0, v10.l                              // 00000002F930: D43D0001 00021480
	v_lshrrev_b32_e32 v10, 24, v15                             // 00000002F938: 32141E98
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002F93C: BF8700A1
	v_cmp_ne_u16_e64 s2, 0, v10.l                              // 00000002F940: D43D0002 00021480
	v_lshrrev_b32_e32 v10, 18, v13                             // 00000002F948: 32141A92
	v_bfe_i32 v10, v10, 0, 1                                   // 00000002F94C: D611000A 0205010A
	v_lshlrev_b16 v10.h, 8, v11.l op_sel:[0,0,1]               // 00000002F954: D738400A 00021688
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002F95C: BF870122
	v_and_b16 v11.l, 0xff, v10.l                               // 00000002F960: D762000B 000214FF 000000FF
	v_lshlrev_b16 v10.l, 8, v10.l                              // 00000002F96C: D738000A 00021488
	v_or_b16 v14.h, v11.l, v10.h op_sel:[0,1,1]                // 00000002F974: D763500E 0002150B
	v_bfe_i32 v11, v13, 0, 1                                   // 00000002F97C: D611000B 0205010D
	v_lshlrev_b16 v11.h, 8, v12.l op_sel:[0,0,1]               // 00000002F984: D738400B 00021888
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002F98C: BF870122
	v_and_b16 v12.l, 0xff, v11.l                               // 00000002F990: D762000C 000216FF 000000FF
	v_lshlrev_b16 v11.l, 8, v11.l                              // 00000002F99C: D738000B 00021688
	v_or_b16 v86.l, v12.l, v11.h op_sel:[0,1,0]                // 00000002F9A4: D7631056 0002170C
	v_lshrrev_b32_e32 v12, 22, v13                             // 00000002F9AC: 32181A96
	v_cndmask_b32_e64 v13, 0, -1, s2                           // 00000002F9B0: D501000D 00098280
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002F9B8: BF870193
	v_or_b32_e32 v86, v86, v14                                 // 00000002F9BC: 38AC1D56
	v_bfe_i32 v12, v12, 0, 1                                   // 00000002F9C0: D611000C 0205010C
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000002F9C8: BF8701A3
	v_lshlrev_b16 v12.h, 8, v13.l op_sel:[0,0,1]               // 00000002F9CC: D738400C 00021A88
	s_waitcnt vmcnt(1)                                         // 00000002F9D4: BF8907F7
	v_xor_b32_e32 v86, v97, v86                                // 00000002F9D8: 3AACAD61
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002F9DC: BF870093
	v_and_b16 v13.l, 0xff, v12.l                               // 00000002F9E0: D762000D 000218FF 000000FF
	v_or_b16 v14.h, v13.l, v12.h op_sel:[0,1,1]                // 00000002F9EC: D763500E 0002190D
	v_lshrrev_b16 v13.l, 4, v15.l                              // 00000002F9F4: D739000D 00021E84
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002F9FC: BF870121
	v_bfe_i32 v15, v13, 0, 1                                   // 00000002FA00: D611000F 0205010D
	v_cndmask_b32_e64 v13, 0, -1, s1                           // 00000002FA08: D501000D 00058280
	v_and_b16 v13.h, 0xff, v15.l op_sel:[0,0,1]                // 00000002FA10: D762400D 00021EFF 000000FF
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002FA1C: BF870092
	v_lshlrev_b16 v13.l, 8, v13.l                              // 00000002FA20: D738000D 00021A88
	v_or_b16 v87.l, v13.h, v13.l op_sel:[1,0,0]                // 00000002FA28: D7630857 00021B0D
	v_and_b16 v13.h, 0xff00, v86.l op_sel:[0,0,1]              // 00000002FA30: D762400D 0002ACFF FFFFFF00
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002FA3C: BF870112
	v_or_b32_e32 v87, v87, v14                                 // 00000002FA40: 38AE1D57
	v_sub_nc_i16 v88.l, v13.h, v11.h op_sel:[1,1,0] clamp      // 00000002FA44: D70E9858 0002170D
	v_lshlrev_b16 v11.h, 8, v86.l op_sel:[0,0,1]               // 00000002FA4C: D738400B 0002AC88
	s_waitcnt vmcnt(0)                                         // 00000002FA54: BF8903F7
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002FA58: BF870113
	v_xor_b32_e32 v87, v98, v87                                // 00000002FA5C: 3AAEAF62
	v_sub_nc_i16 v86.l, v11.h, v11.l op_sel:[1,0,0] clamp      // 00000002FA60: D70E8856 0002170B
	v_and_b16 v11.l, 0xff00, v86.h op_sel:[0,1,0]              // 00000002FA68: D762100B 0002ACFF FFFFFF00
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002FA74: BF8700A1
	v_sub_nc_i16 v11.l, v11.l, v10.h op_sel:[0,1,0] clamp      // 00000002FA78: D70E900B 0002150B
	v_lshlrev_b16 v10.h, 8, v86.h op_sel:[0,1,1]               // 00000002FA80: D738500A 0002AC88
	v_sub_nc_i16 v91.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002FA88: D70E885B 0002150A
	v_and_b16 v10.l, 0xff00, v87.l                             // 00000002FA90: D762000A 0002AEFF FFFFFF00
	v_lshlrev_b16 v10.h, 8, v87.l op_sel:[0,0,1]               // 00000002FA9C: D738400A 0002AE88
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002FAA4: BF870193
	v_perm_b32 v11, v91, v11, 0xc0c0105                        // 00000002FAA8: D644000B 03FE175B 0C0C0105
	v_sub_nc_i16 v13.l, v10.l, v13.l clamp                     // 00000002FAB4: D70E800D 00021B0A
	v_lshlrev_b16 v10.l, 8, v15.l                              // 00000002FABC: D738000A 00021E88
	v_lshrrev_b32_e32 v91, 22, v8                              // 00000002FAC4: 32B61096
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_4)// 00000002FAC8: BF870232
	v_sub_nc_i16 v15.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002FACC: D70E880F 0002150A
	v_and_b16 v10.l, 0xff00, v87.h op_sel:[0,1,0]              // 00000002FAD4: D762100A 0002AEFF FFFFFF00
	v_lshlrev_b16 v10.h, 8, v87.h op_sel:[0,1,1]               // 00000002FAE0: D738500A 0002AE88
	v_and_b32_e32 v91, 0x3fc, v91                              // 00000002FAE8: 36B6B6FF 000003FC
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002FAF0: BF870214
	v_perm_b32 v13, v15, v13, 0xc0c0105                        // 00000002FAF4: D644000D 03FE1B0F 0C0C0105
	v_sub_nc_i16 v87.l, v10.l, v12.h op_sel:[0,1,0] clamp      // 00000002FB00: D70E9057 0002190A
	v_lshlrev_b16 v10.l, 8, v12.l                              // 00000002FB08: D738000A 00021888
	v_perm_b32 v12, v86, v88, 0xc0c0105                        // 00000002FB10: D644000C 03FEB156 0C0C0105
	v_and_b32_e32 v88, 0xff, v8                                // 00000002FB1C: 36B010FF 000000FF
	v_mov_b16_e32 v86.h, v14.l                                 // 00000002FB24: 7FAC390E
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002FB28: BF870214
	v_sub_nc_i16 v10.l, v10.h, v10.l op_sel:[1,0,0] clamp      // 00000002FB2C: D70E880A 0002150A
	v_lshl_or_b32 v11, v11, 16, v12                            // 00000002FB34: D656000B 0431210B
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002FB3C: BF870194
	v_lshlrev_b32_e32 v88, 2, v88                              // 00000002FB40: 30B0B082
	v_perm_b32 v10, v10, v87, 0xc0c0105                        // 00000002FB44: D644000A 03FEAF0A 0C0C0105
	s_delay_alu instid0(VALU_DEP_1)                            // 00000002FB50: BF870001
	v_lshl_or_b32 v10, v10, 16, v13                            // 00000002FB54: D656000A 0435210A
	ds_store_2addr_b32 v48, v89, v90 offset1:1                 // 00000002FB5C: D8380100 005A5930
	ds_store_2addr_b32 v49, v11, v10 offset1:1                 // 00000002FB64: D8380100 000A0B31
	v_lshrrev_b32_e32 v89, 6, v8                               // 00000002FB6C: 32B21086
	v_lshrrev_b32_e32 v90, 14, v8                              // 00000002FB70: 32B4108E
	v_and_b32_e32 v8, 0xff, v85                                // 00000002FB74: 3610AAFF 000000FF
	v_mov_b16_e32 v13.h, v14.l                                 // 00000002FB7C: 7F1A390E
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002FB80: BF870214
	v_and_b32_e32 v89, 0x3fc, v89                              // 00000002FB84: 36B2B2FF 000003FC
	v_and_b32_e32 v90, 0x3fc, v90                              // 00000002FB8C: 36B4B4FF 000003FC
	s_clause 0x7                                               // 00000002FB94: BF850007
	global_load_b32 v88, v88, s[10:11]                         // 00000002FB98: DC520000 580A0058
	global_load_b32 v89, v89, s[10:11]                         // 00000002FBA0: DC520000 590A0059
	global_load_b32 v90, v90, s[10:11]                         // 00000002FBA8: DC520000 5A0A005A
	global_load_b32 v91, v91, s[10:11]                         // 00000002FBB0: DC520000 5B0A005B
	global_load_b32 v92, v92, s[10:11]                         // 00000002FBB8: DC520000 5C0A005C
	global_load_b32 v93, v93, s[10:11]                         // 00000002FBC0: DC520000 5D0A005D
	global_load_b32 v94, v94, s[10:11]                         // 00000002FBC8: DC520000 5E0A005E
	global_load_b32 v95, v95, s[10:11]                         // 00000002FBD0: DC520000 5F0A005F
	v_bcnt_u32_b32 v9, v8, 0                                   // 00000002FBD8: D71E0009 00010108
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002FBE0: BF870091
	v_and_b32_e32 v9, 1, v9                                    // 00000002FBE4: 36121281
	v_lshlrev_b32_e32 v9, 7, v9                                // 00000002FBE8: 30121287
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002FBEC: BF870121
	v_xor_b32_e32 v8, v9, v8                                   // 00000002FBF0: 3A101109
	v_bfe_u32 v9, v85, 7, 8                                    // 00000002FBF4: D6100009 02210F55
	v_mul_lo_u32 v11, 0x1010101, v8                            // 00000002FBFC: D72C000B 000210FF 01010101
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002FC08: BF870092
	v_bcnt_u32_b32 v10, v9, 0                                  // 00000002FC0C: D71E000A 00010109
	v_and_b32_e32 v10, 1, v10                                  // 00000002FC14: 36141481
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002FC18: BF870113
	v_and_b32_e32 v12, 0x80402010, v11                         // 00000002FC1C: 361816FF 80402010
	v_lshlrev_b32_e32 v10, 7, v10                              // 00000002FC24: 30141487
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002FC28: BF870121
	v_xor_b32_e32 v9, v10, v9                                  // 00000002FC2C: 3A12130A
	v_and_b32_e32 v10, 0x8040201, v11                          // 00000002FC30: 361416FF 08040201
	v_mul_lo_u32 v87, 0x1010101, v9                            // 00000002FC38: D72C0057 000212FF 01010101
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002FC44: BF870092
	v_lshrrev_b16 v8.l, 8, v10.l                               // 00000002FC48: D7390008 00021488
	v_cmp_ne_u16_e32 vcc_lo, 0, v8.l                           // 00000002FC50: 7C7A1080
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002FC54: BF870214
	v_lshrrev_b32_e32 v8, 24, v10                              // 00000002FC58: 32101498
	v_and_b32_e32 v9, 0x8040201, v87                           // 00000002FC5C: 3612AEFF 08040201
	v_and_b32_e32 v96, 0x80402010, v87                         // 00000002FC64: 36C0AEFF 80402010
	v_cndmask_b32_e64 v10, 0, -1, vcc_lo                       // 00000002FC6C: D501000A 01A98280
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002FC74: BF8700A4
	v_cmp_ne_u16_e64 s0, 0, v8.l                               // 00000002FC78: D43D0000 00021080
	v_lshrrev_b16 v8.l, 8, v12.l                               // 00000002FC80: D7390008 00021888
	v_cmp_ne_u16_e64 s1, 0, v8.l                               // 00000002FC88: D43D0001 00021080
	v_lshrrev_b32_e32 v8, 24, v12                              // 00000002FC90: 32101898
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002FC94: BF8700A1
	v_cmp_ne_u16_e64 s2, 0, v8.l                               // 00000002FC98: D43D0002 00021080
	v_lshrrev_b16 v8.l, 8, v9.l                                // 00000002FCA0: D7390008 00021288
	v_cmp_ne_u16_e64 s3, 0, v8.l                               // 00000002FCA8: D43D0003 00021080
	v_lshrrev_b32_e32 v8, 24, v9                               // 00000002FCB0: 32101298
	v_cndmask_b32_e64 v9, 0, -1, s0                            // 00000002FCB4: D5010009 00018280
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002FCBC: BF870122
	v_cmp_ne_u16_e64 s4, 0, v8.l                               // 00000002FCC0: D43D0004 00021080
	v_lshrrev_b16 v8.l, 8, v96.l                               // 00000002FCC8: D7390008 0002C088
	v_cndmask_b32_e64 v15, 0, -1, s4                           // 00000002FCD0: D501000F 00118280
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002FCD8: BF8700A2
	v_cmp_ne_u16_e64 s5, 0, v8.l                               // 00000002FCDC: D43D0005 00021080
	v_lshrrev_b32_e32 v8, 24, v96                              // 00000002FCE4: 3210C098
	v_cmp_ne_u16_e64 s6, 0, v8.l                               // 00000002FCE8: D43D0006 00021080
	v_lshrrev_b32_e32 v8, 18, v11                              // 00000002FCF0: 32101692
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000002FCF4: BF870121
	v_bfe_i32 v8, v8, 0, 1                                     // 00000002FCF8: D6110008 02050108
	v_lshlrev_b16 v8.h, 8, v9.l op_sel:[0,0,1]                 // 00000002FD00: D7384008 00021288
	v_and_b16 v9.l, 0xff, v8.l                                 // 00000002FD08: D7620009 000210FF 000000FF
	v_lshlrev_b16 v8.l, 8, v8.l                                // 00000002FD14: D7380008 00021088
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 00000002FD1C: BF870132
	v_or_b16 v14.h, v9.l, v8.h op_sel:[0,1,1]                  // 00000002FD20: D763500E 00021109
	v_bfe_i32 v9, v11, 0, 1                                    // 00000002FD28: D6110009 0205010B
	v_lshlrev_b16 v9.h, 8, v10.l op_sel:[0,0,1]                // 00000002FD30: D7384009 00021488
	v_and_b16 v10.l, 0xff, v9.l                                // 00000002FD38: D762000A 000212FF 000000FF
	v_lshlrev_b16 v9.l, 8, v9.l                                // 00000002FD44: D7380009 00021288
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000002FD4C: BF8701B2
	v_or_b16 v13.l, v10.l, v9.h op_sel:[0,1,0]                 // 00000002FD50: D763100D 0002130A
	v_lshrrev_b32_e32 v10, 22, v11                             // 00000002FD58: 32141696
	v_cndmask_b32_e64 v11, 0, -1, s2                           // 00000002FD5C: D501000B 00098280
	v_or_b32_e32 v97, v13, v14                                 // 00000002FD64: 38C21D0D
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002FD68: BF870193
	v_bfe_i32 v10, v10, 0, 1                                   // 00000002FD6C: D611000A 0205010A
	v_lshlrev_b16 v10.h, 8, v11.l op_sel:[0,0,1]               // 00000002FD74: D738400A 00021688
	v_lshrrev_b32_e32 v13, 18, v87                             // 00000002FD7C: 321AAE92
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000002FD80: BF870113
	v_and_b16 v11.l, 0xff, v10.l                               // 00000002FD84: D762000B 000214FF 000000FF
	v_bfe_i32 v13, v13, 0, 1                                   // 00000002FD90: D611000D 0205010D
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002FD98: BF8700A2
	v_or_b16 v14.h, v11.l, v10.h op_sel:[0,1,1]                // 00000002FD9C: D763500E 0002150B
	v_lshrrev_b16 v11.l, 4, v12.l                              // 00000002FDA4: D739000B 00021884
	v_bfe_i32 v12, v11, 0, 1                                   // 00000002FDAC: D611000C 0205010B
	v_cndmask_b32_e64 v11, 0, -1, s1                           // 00000002FDB4: D501000B 00058280
	v_and_b16 v12.h, 0xff, v13.l op_sel:[0,0,1]                // 00000002FDBC: D762400C 00021AFF 000000FF
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002FDC8: BF870193
	v_and_b16 v11.h, 0xff, v12.l op_sel:[0,0,1]                // 00000002FDCC: D762400B 000218FF 000000FF
	v_lshlrev_b16 v11.l, 8, v11.l                              // 00000002FDD8: D738000B 00021688
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000002FDE0: BF8701B1
	v_or_b16 v86.l, v11.h, v11.l op_sel:[1,0,0]                // 00000002FDE4: D7630856 0002170B
	v_lshlrev_b16 v11.h, 8, v15.l op_sel:[0,0,1]               // 00000002FDEC: D738400B 00021E88
	v_bfe_i32 v15, v87, 0, 1                                   // 00000002FDF4: D611000F 02050157
	v_or_b32_e32 v98, v86, v14                                 // 00000002FDFC: 38C41D56
	v_cndmask_b32_e64 v86, 0, -1, s3                           // 00000002FE00: D5010056 000D8280
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000002FE08: BF870214
	v_or_b16 v14.h, v12.h, v11.h op_sel:[1,1,1]                // 00000002FE0C: D763580E 0002170C
	v_and_b16 v13.h, 0xff, v15.l op_sel:[0,0,1]                // 00000002FE14: D762400D 00021EFF 000000FF
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000002FE20: BF8701B3
	v_lshlrev_b16 v12.h, 8, v86.l op_sel:[0,0,1]               // 00000002FE24: D738400C 0002AC88
	v_lshrrev_b32_e32 v86, 22, v87                             // 00000002FE2C: 32ACAE96
	v_cndmask_b32_e64 v87, 0, -1, s6                           // 00000002FE30: D5010057 00198280
	v_or_b16 v99.l, v13.h, v12.h op_sel:[1,1,0]                // 00000002FE38: D7631863 0002190D
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002FE40: BF870193
	v_bfe_i32 v86, v86, 0, 1                                   // 00000002FE44: D6110056 02050156
	v_lshlrev_b16 v13.h, 8, v87.l op_sel:[0,0,1]               // 00000002FE4C: D738400D 0002AE88
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002FE54: BF870193
	v_or_b32_e32 v87, v99, v14                                 // 00000002FE58: 38AE1D63
	v_and_b16 v14.h, 0xff, v86.l op_sel:[0,0,1]                // 00000002FE5C: D762400E 0002ACFF 000000FF
	s_delay_alu instid0(VALU_DEP_1)                            // 00000002FE68: BF870001
	v_or_b16 v14.h, v14.h, v13.h op_sel:[1,1,1]                // 00000002FE6C: D763580E 00021B0E
	s_waitcnt vmcnt(7)                                         // 00000002FE74: BF891FF7
	v_xor_b32_e32 v97, v88, v97                                // 00000002FE78: 3AC2C358
	s_waitcnt vmcnt(6)                                         // 00000002FE7C: BF891BF7
	v_xor_b32_e32 v89, v89, v98                                // 00000002FE80: 3AB2C559
	s_waitcnt vmcnt(5)                                         // 00000002FE84: BF8917F7
	v_xor_b32_e32 v90, v90, v87                                // 00000002FE88: 3AB4AF5A
	v_lshrrev_b16 v87.l, 4, v96.l                              // 00000002FE8C: D7390057 0002C084
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000002FE94: BF8701B1
	v_bfe_i32 v88, v87, 0, 1                                   // 00000002FE98: D6110058 02050157
	v_cndmask_b32_e64 v87, 0, -1, s5                           // 00000002FEA0: D5010057 00158280
	v_mov_b16_e32 v87.h, v14.l                                 // 00000002FEA8: 7FAE390E
	v_and_b16 v86.h, 0xff, v88.l op_sel:[0,0,1]                // 00000002FEAC: D7624056 0002B0FF 000000FF
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000002FEB8: BF870093
	v_lshlrev_b16 v15.h, 8, v87.l op_sel:[0,0,1]               // 00000002FEBC: D738400F 0002AE88
	v_or_b16 v87.l, v86.h, v15.h op_sel:[1,1,0]                // 00000002FEC4: D7631857 00021F56
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 00000002FECC: BF870131
	v_or_b32_e32 v87, v87, v14                                 // 00000002FED0: 38AE1D57
	v_and_b16 v14.h, 0xff00, v97.l op_sel:[0,0,1]              // 00000002FED4: D762400E 0002C2FF FFFFFF00
	s_waitcnt vmcnt(4)                                         // 00000002FEE0: BF8913F7
	v_xor_b32_e32 v87, v91, v87                                // 00000002FEE4: 3AAEAF5B
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002FEE8: BF8700A2
	v_sub_nc_i16 v91.l, v14.h, v9.h op_sel:[1,1,0] clamp       // 00000002FEEC: D70E985B 0002130E
	v_lshlrev_b16 v9.h, 8, v97.l op_sel:[0,0,1]                // 00000002FEF4: D7384009 0002C288
	v_sub_nc_i16 v96.l, v9.h, v9.l op_sel:[1,0,0] clamp        // 00000002FEFC: D70E8860 00021309
	v_and_b16 v9.l, 0xff00, v97.h op_sel:[0,1,0]               // 00000002FF04: D7621009 0002C2FF FFFFFF00
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002FF10: BF8700A1
	v_sub_nc_i16 v9.l, v9.l, v8.h op_sel:[0,1,0] clamp         // 00000002FF14: D70E9009 00021109
	v_lshlrev_b16 v8.h, 8, v97.h op_sel:[0,1,1]                // 00000002FF1C: D7385008 0002C288
	v_sub_nc_i16 v97.l, v8.h, v8.l op_sel:[1,0,0] clamp        // 00000002FF24: D70E8861 00021108
	v_and_b16 v8.l, 0xff00, v89.l                              // 00000002FF2C: D7620008 0002B2FF FFFFFF00
	v_lshlrev_b16 v8.h, 8, v89.l op_sel:[0,0,1]                // 00000002FF38: D7384008 0002B288
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000002FF40: BF870193
	v_perm_b32 v9, v97, v9, 0xc0c0105                          // 00000002FF44: D6440009 03FE1361 0C0C0105
	v_sub_nc_i16 v11.l, v8.l, v11.l clamp                      // 00000002FF50: D70E800B 00021708
	v_lshlrev_b16 v8.l, 8, v12.l                               // 00000002FF58: D7380008 00021888
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 00000002FF60: BF870131
	v_sub_nc_i16 v12.l, v8.h, v8.l op_sel:[1,0,0] clamp        // 00000002FF64: D70E880C 00021108
	v_and_b16 v8.l, 0xff00, v89.h op_sel:[0,1,0]               // 00000002FF6C: D7621008 0002B2FF FFFFFF00
	v_lshlrev_b16 v8.h, 8, v89.h op_sel:[0,1,1]                // 00000002FF78: D7385008 0002B288
	v_sub_nc_i16 v89.l, v8.l, v10.h op_sel:[0,1,0] clamp       // 00000002FF80: D70E9059 00021508
	v_lshlrev_b16 v8.l, 8, v10.l                               // 00000002FF88: D7380008 00021488
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000002FF90: BF8701B1
	v_sub_nc_i16 v10.l, v8.h, v8.l op_sel:[1,0,0] clamp        // 00000002FF94: D70E880A 00021108
	v_and_b16 v8.l, 0xff00, v90.l                              // 00000002FF9C: D7620008 0002B4FF FFFFFF00
	v_lshlrev_b16 v8.h, 8, v90.l op_sel:[0,0,1]                // 00000002FFA8: D7384008 0002B488
	v_perm_b32 v10, v10, v89, 0xc0c0105                        // 00000002FFB0: D644000A 03FEB30A 0C0C0105
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000002FFBC: BF8700A3
	v_sub_nc_i16 v98.l, v8.l, v12.h op_sel:[0,1,0] clamp       // 00000002FFC0: D70E9062 00021908
	v_lshlrev_b16 v8.l, 8, v15.l                               // 00000002FFC8: D7380008 00021E88
	v_sub_nc_i16 v15.l, v8.h, v8.l op_sel:[1,0,0] clamp        // 00000002FFD0: D70E880F 00021108
	v_and_b16 v8.l, 0xff00, v90.h op_sel:[0,1,0]               // 00000002FFD8: D7621008 0002B4FF FFFFFF00
	v_lshlrev_b16 v8.h, 8, v90.h op_sel:[0,1,1]                // 00000002FFE4: D7385008 0002B488
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_3)// 00000002FFEC: BF8701C2
	v_sub_nc_i16 v90.l, v8.l, v11.h op_sel:[0,1,0] clamp       // 00000002FFF0: D70E905A 00021708
	v_lshlrev_b16 v8.l, 8, v13.l                               // 00000002FFF8: D7380008 00021A88
	v_perm_b32 v11, v12, v11, 0xc0c0105                        // 000000030000: D644000B 03FE170C 0C0C0105
	v_perm_b32 v12, v15, v98, 0xc0c0105                        // 00000003000C: D644000C 03FEC50F 0C0C0105
	v_sub_nc_i16 v13.l, v8.h, v8.l op_sel:[1,0,0] clamp        // 000000030018: D70E880D 00021108
	v_and_b16 v8.l, 0xff00, v87.l                              // 000000030020: D7620008 0002AEFF FFFFFF00
	v_lshlrev_b16 v8.h, 8, v87.l op_sel:[0,0,1]                // 00000003002C: D7384008 0002AE88
	v_lshl_or_b32 v10, v10, 16, v11                            // 000000030034: D656000A 042D210A
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000003003C: BF8700A3
	v_sub_nc_i16 v99.l, v8.l, v15.h op_sel:[0,1,0] clamp       // 000000030040: D70E9063 00021F08
	v_lshlrev_b16 v8.l, 8, v88.l                               // 000000030048: D7380008 0002B088
	v_sub_nc_i16 v87.l, v8.h, v8.l op_sel:[1,0,0] clamp        // 000000030050: D70E8857 00021108
	v_and_b16 v8.l, 0xff00, v87.h op_sel:[0,1,0]               // 000000030058: D7621008 0002AEFF FFFFFF00
	v_lshlrev_b16 v8.h, 8, v87.h op_sel:[0,1,1]                // 000000030064: D7385008 0002AE88
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000003006C: BF870193
	v_perm_b32 v15, v87, v99, 0xc0c0105                        // 000000030070: D644000F 03FEC757 0C0C0105
	v_sub_nc_i16 v88.l, v8.l, v13.h op_sel:[0,1,0] clamp       // 00000003007C: D70E9058 00021B08
	v_lshlrev_b16 v8.l, 8, v86.l                               // 000000030084: D7380008 0002AC88
	v_perm_b32 v86, v96, v91, 0xc0c0105                        // 00000003008C: D6440056 03FEB760 0C0C0105
	v_perm_b32 v13, v13, v90, 0xc0c0105                        // 000000030098: D644000D 03FEB50D 0C0C0105
	v_mov_b16_e32 v87.h, v14.l                                 // 0000000300A4: 7FAE390E
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 0000000300A8: BF870214
	v_sub_nc_i16 v8.l, v8.h, v8.l op_sel:[1,0,0] clamp         // 0000000300AC: D70E8808 00021108
	v_lshl_or_b32 v9, v9, 16, v86                              // 0000000300B4: D6560009 05592109
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_4)// 0000000300BC: BF870224
	v_lshl_or_b32 v13, v13, 16, v12                            // 0000000300C0: D656000D 0431210D
	v_mov_b16_e32 v86.h, v14.l                                 // 0000000300C8: 7FAC390E
	v_perm_b32 v8, v8, v88, 0xc0c0105                          // 0000000300CC: D6440008 03FEB108 0C0C0105
	s_delay_alu instid0(VALU_DEP_1)                            // 0000000300D8: BF870001
	v_lshl_or_b32 v15, v8, 16, v15                             // 0000000300DC: D656000F 043D2108
	v_bfe_u32 v8, v85, 14, 8                                   // 0000000300E4: D6100008 02211D55
	ds_store_2addr_b32 v50, v9, v10 offset1:1                  // 0000000300EC: D8380100 000A0932
	ds_store_2addr_b32 v51, v13, v15 offset1:1                 // 0000000300F4: D8380100 000F0D33
	v_bcnt_u32_b32 v9, v8, 0                                   // 0000000300FC: D71E0009 00010108
	v_mov_b16_e32 v13.h, v14.l                                 // 000000030104: 7F1A390E
	v_mov_b16_e32 v15.h, v14.l                                 // 000000030108: 7F1E390E
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000003010C: BF870093
	v_and_b32_e32 v9, 1, v9                                    // 000000030110: 36121281
	v_lshlrev_b32_e32 v9, 7, v9                                // 000000030114: 30121287
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000030118: BF870091
	v_xor_b32_e32 v8, v9, v8                                   // 00000003011C: 3A101109
	v_mul_lo_u32 v11, 0x1010101, v8                            // 000000030120: D72C000B 000210FF 01010101
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000003012C: BF870121
	v_and_b32_e32 v9, 0x8040201, v11                           // 000000030130: 361216FF 08040201
	v_and_b32_e32 v12, 0x80402010, v11                         // 000000030138: 361816FF 80402010
	v_lshrrev_b16 v8.l, 8, v9.l                                // 000000030140: D7390008 00021288
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_4)// 000000030148: BF870211
	v_cmp_ne_u16_e32 vcc_lo, 0, v8.l                           // 00000003014C: 7C7A1080
	v_lshrrev_b32_e32 v8, 24, v9                               // 000000030150: 32101298
	v_cndmask_b32_e64 v10, 0, -1, vcc_lo                       // 000000030154: D501000A 01A98280
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000003015C: BF870122
	v_cmp_ne_u16_e64 s0, 0, v8.l                               // 000000030160: D43D0000 00021080
	v_lshrrev_b16 v8.l, 8, v12.l                               // 000000030168: D7390008 00021888
	v_cndmask_b32_e64 v9, 0, -1, s0                            // 000000030170: D5010009 00018280
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 000000030178: BF8700A2
	v_cmp_ne_u16_e64 s1, 0, v8.l                               // 00000003017C: D43D0001 00021080
	v_lshrrev_b32_e32 v8, 24, v12                              // 000000030184: 32101898
	v_cmp_ne_u16_e64 s2, 0, v8.l                               // 000000030188: D43D0002 00021080
	v_lshrrev_b32_e32 v8, 18, v11                              // 000000030190: 32101692
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 000000030194: BF870121
	v_bfe_i32 v8, v8, 0, 1                                     // 000000030198: D6110008 02050108
	v_lshlrev_b16 v8.h, 8, v9.l op_sel:[0,0,1]                 // 0000000301A0: D7384008 00021288
	v_and_b16 v9.l, 0xff, v8.l                                 // 0000000301A8: D7620009 000210FF 000000FF
	v_lshlrev_b16 v8.l, 8, v8.l                                // 0000000301B4: D7380008 00021088
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 0000000301BC: BF870132
	v_or_b16 v14.h, v9.l, v8.h op_sel:[0,1,1]                  // 0000000301C0: D763500E 00021109
	v_bfe_i32 v9, v11, 0, 1                                    // 0000000301C8: D6110009 0205010B
	v_lshlrev_b16 v9.h, 8, v10.l op_sel:[0,0,1]                // 0000000301D0: D7384009 00021488
	v_and_b16 v10.l, 0xff, v9.l                                // 0000000301D8: D762000A 000212FF 000000FF
	v_lshlrev_b16 v9.l, 8, v9.l                                // 0000000301E4: D7380009 00021288
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 0000000301EC: BF8701B2
	v_or_b16 v86.l, v10.l, v9.h op_sel:[0,1,0]                 // 0000000301F0: D7631056 0002130A
	v_lshrrev_b32_e32 v10, 22, v11                             // 0000000301F8: 32141696
	v_cndmask_b32_e64 v11, 0, -1, s2                           // 0000000301FC: D501000B 00098280
	v_or_b32_e32 v86, v86, v14                                 // 000000030204: 38AC1D56
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 000000030208: BF870193
	v_bfe_i32 v10, v10, 0, 1                                   // 00000003020C: D611000A 0205010A
	v_lshlrev_b16 v10.h, 8, v11.l op_sel:[0,0,1]               // 000000030214: D738400A 00021688
	s_waitcnt vmcnt(3)                                         // 00000003021C: BF890FF7
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 000000030220: BF870193
	v_xor_b32_e32 v86, v92, v86                                // 000000030224: 3AACAD5C
	v_and_b16 v11.l, 0xff, v10.l                               // 000000030228: D762000B 000214FF 000000FF
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 000000030234: BF8700A1
	v_or_b16 v14.h, v11.l, v10.h op_sel:[0,1,1]                // 000000030238: D763500E 0002150B
	v_lshrrev_b16 v11.l, 4, v12.l                              // 000000030240: D739000B 00021884
	v_bfe_i32 v12, v11, 0, 1                                   // 000000030248: D611000C 0205010B
	v_cndmask_b32_e64 v11, 0, -1, s1                           // 000000030250: D501000B 00058280
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 000000030258: BF870112
	v_and_b16 v11.h, 0xff, v12.l op_sel:[0,0,1]                // 00000003025C: D762400B 000218FF 000000FF
	v_lshlrev_b16 v11.l, 8, v11.l                              // 000000030268: D738000B 00021688
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 000000030270: BF870121
	v_or_b16 v87.l, v11.h, v11.l op_sel:[1,0,0]                // 000000030274: D7630857 0002170B
	v_and_b16 v11.h, 0xff00, v86.l op_sel:[0,0,1]              // 00000003027C: D762400B 0002ACFF FFFFFF00
	v_or_b32_e32 v87, v87, v14                                 // 000000030288: 38AE1D57
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000003028C: BF8701B2
	v_sub_nc_i16 v88.l, v11.h, v9.h op_sel:[1,1,0] clamp       // 000000030290: D70E9858 0002130B
	v_lshlrev_b16 v9.h, 8, v86.l op_sel:[0,0,1]                // 000000030298: D7384009 0002AC88
	s_waitcnt vmcnt(2)                                         // 0000000302A0: BF890BF7
	v_xor_b32_e32 v87, v93, v87                                // 0000000302A4: 3AAEAF5D
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 0000000302A8: BF8700A2
	v_sub_nc_i16 v86.l, v9.h, v9.l op_sel:[1,0,0] clamp        // 0000000302AC: D70E8856 00021309
	v_and_b16 v9.l, 0xff00, v86.h op_sel:[0,1,0]               // 0000000302B4: D7621009 0002ACFF FFFFFF00
	v_sub_nc_i16 v9.l, v9.l, v8.h op_sel:[0,1,0] clamp         // 0000000302C0: D70E9009 00021109
	v_lshlrev_b16 v8.h, 8, v86.h op_sel:[0,1,1]                // 0000000302C8: D7385008 0002AC88
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 0000000302D0: BF8701B1
	v_sub_nc_i16 v89.l, v8.h, v8.l op_sel:[1,0,0] clamp        // 0000000302D4: D70E8859 00021108
	v_and_b16 v8.l, 0xff00, v87.l                              // 0000000302DC: D7620008 0002AEFF FFFFFF00
	v_lshlrev_b16 v8.h, 8, v87.l op_sel:[0,0,1]                // 0000000302E8: D7384008 0002AE88
	v_perm_b32 v9, v89, v9, 0xc0c0105                          // 0000000302F0: D6440009 03FE1359 0C0C0105
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 0000000302FC: BF8700A3
	v_sub_nc_i16 v11.l, v8.l, v11.l clamp                      // 000000030300: D70E800B 00021708
	v_lshlrev_b16 v8.l, 8, v12.l                               // 000000030308: D7380008 00021888
	v_sub_nc_i16 v12.l, v8.h, v8.l op_sel:[1,0,0] clamp        // 000000030310: D70E880C 00021108
	v_and_b16 v8.l, 0xff00, v87.h op_sel:[0,1,0]               // 000000030318: D7621008 0002AEFF FFFFFF00
	v_lshlrev_b16 v8.h, 8, v87.h op_sel:[0,1,1]                // 000000030324: D7385008 0002AE88
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000003032C: BF870193
	v_perm_b32 v11, v12, v11, 0xc0c0105                        // 000000030330: D644000B 03FE170C 0C0C0105
	v_sub_nc_i16 v87.l, v8.l, v10.h op_sel:[0,1,0] clamp       // 00000003033C: D70E9057 00021508
	v_lshlrev_b16 v8.l, 8, v10.l                               // 000000030344: D7380008 00021488
	v_perm_b32 v10, v86, v88, 0xc0c0105                        // 00000003034C: D644000A 03FEB156 0C0C0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 000000030358: BF870112
	v_sub_nc_i16 v8.l, v8.h, v8.l op_sel:[1,0,0] clamp         // 00000003035C: D70E8808 00021108
	v_lshl_or_b32 v86, v9, 16, v10                             // 000000030364: D6560056 04292109
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000003036C: BF870092
	v_perm_b32 v8, v8, v87, 0xc0c0105                          // 000000030370: D6440008 03FEAF08 0C0C0105
	v_lshl_or_b32 v87, v8, 16, v11                             // 00000003037C: D6560057 042D2108
	v_bfe_u32 v8, v85, 21, 8                                   // 000000030384: D6100008 02212B55
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000003038C: BF870091
	v_bcnt_u32_b32 v9, v8, 0                                   // 000000030390: D71E0009 00010108
	v_and_b32_e32 v9, 1, v9                                    // 000000030398: 36121281
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000003039C: BF870091
	v_lshlrev_b32_e32 v9, 7, v9                                // 0000000303A0: 30121287
	v_xor_b32_e32 v8, v9, v8                                   // 0000000303A4: 3A101109
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000303A8: BF870091
	v_mul_lo_u32 v11, 0x1010101, v8                            // 0000000303AC: D72C000B 000210FF 01010101
	v_and_b32_e32 v9, 0x8040201, v11                           // 0000000303B8: 361216FF 08040201
	v_and_b32_e32 v12, 0x80402010, v11                         // 0000000303C0: 361816FF 80402010
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000303C8: BF870092
	v_lshrrev_b16 v8.l, 8, v9.l                                // 0000000303CC: D7390008 00021288
	v_cmp_ne_u16_e32 vcc_lo, 0, v8.l                           // 0000000303D4: 7C7A1080
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 0000000303D8: BF870124
	v_lshrrev_b32_e32 v8, 24, v9                               // 0000000303DC: 32101298
	v_cndmask_b32_e64 v10, 0, -1, vcc_lo                       // 0000000303E0: D501000A 01A98280
	v_cmp_ne_u16_e64 s0, 0, v8.l                               // 0000000303E8: D43D0000 00021080
	v_lshrrev_b16 v8.l, 8, v12.l                               // 0000000303F0: D7390008 00021888
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 0000000303F8: BF870112
	v_cndmask_b32_e64 v9, 0, -1, s0                            // 0000000303FC: D5010009 00018280
	v_cmp_ne_u16_e64 s1, 0, v8.l                               // 000000030404: D43D0001 00021080
	v_lshrrev_b32_e32 v8, 24, v12                              // 00000003040C: 32101898
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 000000030410: BF8700A1
	v_cmp_ne_u16_e64 s2, 0, v8.l                               // 000000030414: D43D0002 00021080
	v_lshrrev_b32_e32 v8, 18, v11                              // 00000003041C: 32101692
	v_bfe_i32 v8, v8, 0, 1                                     // 000000030420: D6110008 02050108
	v_lshlrev_b16 v8.h, 8, v9.l op_sel:[0,0,1]                 // 000000030428: D7384008 00021288
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 000000030430: BF870122
	v_and_b16 v9.l, 0xff, v8.l                                 // 000000030434: D7620009 000210FF 000000FF
	v_lshlrev_b16 v8.l, 8, v8.l                                // 000000030440: D7380008 00021088
	v_or_b16 v14.h, v9.l, v8.h op_sel:[0,1,1]                  // 000000030448: D763500E 00021109
	v_bfe_i32 v9, v11, 0, 1                                    // 000000030450: D6110009 0205010B
	v_lshlrev_b16 v9.h, 8, v10.l op_sel:[0,0,1]                // 000000030458: D7384009 00021488
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 000000030460: BF870122
	v_and_b16 v10.l, 0xff, v9.l                                // 000000030464: D762000A 000212FF 000000FF
	v_lshlrev_b16 v9.l, 8, v9.l                                // 000000030470: D7380009 00021288
	v_or_b16 v13.l, v10.l, v9.h op_sel:[0,1,0]                 // 000000030478: D763100D 0002130A
	v_lshrrev_b32_e32 v10, 22, v11                             // 000000030480: 32141696
	v_cndmask_b32_e64 v11, 0, -1, s2                           // 000000030484: D501000B 00098280
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000003048C: BF870193
	v_or_b32_e32 v13, v13, v14                                 // 000000030490: 381A1D0D
	v_bfe_i32 v10, v10, 0, 1                                   // 000000030494: D611000A 0205010A
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000003049C: BF8701A3
	v_lshlrev_b16 v10.h, 8, v11.l op_sel:[0,0,1]               // 0000000304A0: D738400A 00021688
	s_waitcnt vmcnt(1)                                         // 0000000304A8: BF8907F7
	v_xor_b32_e32 v13, v94, v13                                // 0000000304AC: 3A1A1B5E
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000304B0: BF870093
	v_and_b16 v11.l, 0xff, v10.l                               // 0000000304B4: D762000B 000214FF 000000FF
	v_or_b16 v14.h, v11.l, v10.h op_sel:[0,1,1]                // 0000000304C0: D763500E 0002150B
	v_lshrrev_b16 v11.l, 4, v12.l                              // 0000000304C8: D739000B 00021884
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 0000000304D0: BF870131
	v_bfe_i32 v12, v11, 0, 1                                   // 0000000304D4: D611000C 0205010B
	v_cndmask_b32_e64 v11, 0, -1, s1                           // 0000000304DC: D501000B 00058280
	s_lshl_b64 s[0:1], s[8:9], 2                               // 0000000304E4: 84808208
	v_and_b16 v11.h, 0xff, v12.l op_sel:[0,0,1]                // 0000000304E8: D762400B 000218FF 000000FF
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000304F4: BF870092
	v_lshlrev_b16 v11.l, 8, v11.l                              // 0000000304F8: D738000B 00021688
	v_or_b16 v15.l, v11.h, v11.l op_sel:[1,0,0]                // 000000030500: D763080F 0002170B
	v_and_b16 v11.h, 0xff00, v13.l op_sel:[0,0,1]              // 000000030508: D762400B 00021AFF FFFFFF00
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 000000030514: BF870112
	v_or_b32_e32 v14, v15, v14                                 // 000000030518: 381C1D0F
	v_sub_nc_i16 v15.l, v11.h, v9.h op_sel:[1,1,0] clamp       // 00000003051C: D70E980F 0002130B
	v_lshlrev_b16 v9.h, 8, v13.l op_sel:[0,0,1]                // 000000030524: D7384009 00021A88
	s_waitcnt vmcnt(0)                                         // 00000003052C: BF8903F7
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 000000030530: BF870113
	v_xor_b32_e32 v14, v95, v14                                // 000000030534: 3A1C1D5F
	v_sub_nc_i16 v13.l, v9.h, v9.l op_sel:[1,0,0] clamp        // 000000030538: D70E880D 00021309
	v_and_b16 v9.l, 0xff00, v13.h op_sel:[0,1,0]               // 000000030540: D7621009 00021AFF FFFFFF00
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000003054C: BF8700A1
	v_sub_nc_i16 v9.l, v9.l, v8.h op_sel:[0,1,0] clamp         // 000000030550: D70E9009 00021109
	v_lshlrev_b16 v8.h, 8, v13.h op_sel:[0,1,1]                // 000000030558: D7385008 00021A88
	v_sub_nc_i16 v85.l, v8.h, v8.l op_sel:[1,0,0] clamp        // 000000030560: D70E8855 00021108
	v_and_b16 v8.l, 0xff00, v14.l                              // 000000030568: D7620008 00021CFF FFFFFF00
	v_lshlrev_b16 v8.h, 8, v14.l op_sel:[0,0,1]                // 000000030574: D7384008 00021C88
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000003057C: BF870193
	v_perm_b32 v9, v85, v9, 0xc0c0105                          // 000000030580: D6440009 03FE1355 0C0C0105
	v_sub_nc_i16 v11.l, v8.l, v11.l clamp                      // 00000003058C: D70E800B 00021708
	v_lshlrev_b16 v8.l, 8, v12.l                               // 000000030594: D7380008 00021888
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000003059C: BF8701B1
	v_sub_nc_i16 v12.l, v8.h, v8.l op_sel:[1,0,0] clamp        // 0000000305A0: D70E880C 00021108
	v_and_b16 v8.l, 0xff00, v14.h op_sel:[0,1,0]               // 0000000305A8: D7621008 00021CFF FFFFFF00
	v_lshlrev_b16 v8.h, 8, v14.h op_sel:[0,1,1]                // 0000000305B4: D7385008 00021C88
	v_perm_b32 v11, v12, v11, 0xc0c0105                        // 0000000305BC: D644000B 03FE170C 0C0C0105
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 0000000305C8: BF870133
	v_sub_nc_i16 v14.l, v8.l, v10.h op_sel:[0,1,0] clamp       // 0000000305CC: D70E900E 00021508
	v_lshlrev_b16 v8.l, 8, v10.l                               // 0000000305D4: D7380008 00021488
	v_perm_b32 v10, v13, v15, 0xc0c0105                        // 0000000305DC: D644000A 03FE1F0D 0C0C0105
	v_sub_nc_i16 v8.l, v8.h, v8.l op_sel:[1,0,0] clamp         // 0000000305E8: D70E8808 00021108
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 0000000305F0: BF870112
	v_lshl_or_b32 v9, v9, 16, v10                              // 0000000305F4: D6560009 04292109
	v_perm_b32 v8, v8, v14, 0xc0c0105                          // 0000000305FC: D6440008 03FE1D08 0C0C0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_1)// 000000030608: BF8700C1
	v_lshl_or_b32 v8, v8, 16, v11                              // 00000003060C: D6560008 042D2108
	ds_store_2addr_b32 v52, v86, v87 offset1:1                 // 000000030614: D8380100 00575634
	ds_store_2addr_b32 v53, v9, v8 offset1:1                   // 00000003061C: D8380100 00080935
	v_add_co_u32 v8, vcc_lo, v31, s0                           // 000000030624: D7006A08 0000011F
	v_add_co_ci_u32_e64 v9, null, s1, v33, vcc_lo              // 00000003062C: D5207C09 01AA4201
	s_clause 0x4                                               // 000000030634: BF850004
	global_load_b32 v10, v[8:9], off                           // 000000030638: DC520000 0A7C0008
	global_load_b32 v11, v[8:9], off offset:512                // 000000030640: DC520200 0B7C0008
	global_load_b32 v12, v[8:9], off offset:1024               // 000000030648: DC520400 0C7C0008
	global_load_b32 v13, v[8:9], off offset:1536               // 000000030650: DC520600 0D7C0008
	global_load_b32 v8, v[8:9], off offset:2048                // 000000030658: DC520800 087C0008
	s_add_i32 s0, s12, s8                                      // 000000030660: 8100080C
	s_add_i32 s8, s8, s13                                      // 000000030664: 81080D08
	s_ashr_i32 s1, s0, 31                                      // 000000030668: 86019F00
	s_waitcnt vmcnt(3)                                         // 00000003066C: BF890FF7
	ds_store_2addr_b32 v27, v10, v11 offset0:16 offset1:144    // 000000030670: D8389010 000B0A1B
	s_waitcnt vmcnt(1)                                         // 000000030678: BF8907F7
	ds_store_2addr_stride64_b32 v76, v12, v13 offset0:4 offset1:6// 00000003067C: D83C0604 000D0C4C
	s_waitcnt vmcnt(0)                                         // 000000030684: BF8903F7
	ds_store_b32 v27, v8 offset:2112                           // 000000030688: D8340840 0000081B
	s_waitcnt lgkmcnt(0)                                       // 000000030690: BF89FC07
	s_barrier                                                  // 000000030694: BFBD0000
	buffer_gl0_inv                                             // 000000030698: E0AC0000 00000000
	ds_load_b128 v[85:88], v25 offset:80                       // 0000000306A0: DBFC0050 55000019
	ds_load_b128 v[89:92], v54 offset:2624                     // 0000000306A8: DBFC0A40 59000036
	ds_load_b128 v[93:96], v54 offset:2640                     // 0000000306B0: DBFC0A50 5D000036
	ds_load_b128 v[97:100], v25 offset:96                      // 0000000306B8: DBFC0060 61000019
	s_lshl_b64 s[0:1], s[0:1], 2                               // 0000000306C0: 84808200
	s_cmp_eq_u32 s30, 0                                        // 0000000306C4: BF06801E
	s_waitcnt lgkmcnt(2)                                       // 0000000306C8: BF89FC27
	v_wmma_i32_16x16x16_iu8 v[8:15], v[89:92], v[85:88], v[0:7] neg_lo:[1,1,0] clamp// 0000000306CC: CC44C008 7C02AB59
	s_waitcnt lgkmcnt(0)                                       // 0000000306D4: BF89FC07
	s_delay_alu instid0(VALU_DEP_1)                            // 0000000306D8: BF870001
	v_wmma_i32_16x16x16_iu8 v[8:15], v[93:96], v[97:100], v[8:15] neg_lo:[1,1,0] clamp// 0000000306DC: CC44C008 7C22C35D
	ds_load_b128 v[93:96], v25 offset:112                      // 0000000306E4: DBFC0070 5D000019
	ds_load_b128 v[97:100], v54 offset:2656                    // 0000000306EC: DBFC0A60 61000036
	ds_load_b128 v[101:104], v54 offset:2672                   // 0000000306F4: DBFC0A70 65000036
	ds_load_b128 v[105:108], v25 offset:128                    // 0000000306FC: DBFC0080 69000019
	v_cvt_f32_i32_e32 v8, v8                                   // 000000030704: 7E100B08
	v_cvt_f32_i32_e32 v9, v9                                   // 000000030708: 7E120B09
	v_cvt_f32_i32_e32 v10, v10                                 // 00000003070C: 7E140B0A
	v_cvt_f32_i32_e32 v11, v11                                 // 000000030710: 7E160B0B
	v_cvt_f32_i32_e32 v12, v12                                 // 000000030714: 7E180B0C
	v_cvt_f32_i32_e32 v14, v14                                 // 000000030718: 7E1C0B0E
	v_cvt_f32_i32_e32 v13, v13                                 // 00000003071C: 7E1A0B0D
	v_cvt_f32_i32_e32 v15, v15                                 // 000000030720: 7E1E0B0F
	s_waitcnt lgkmcnt(2)                                       // 000000030724: BF89FC27
	v_wmma_i32_16x16x16_iu8 v[85:92], v[97:100], v[93:96], v[0:7] neg_lo:[1,1,0] clamp// 000000030728: CC44C055 7C02BB61
	s_waitcnt lgkmcnt(0)                                       // 000000030730: BF89FC07
	s_delay_alu instid0(VALU_DEP_1)                            // 000000030734: BF870001
	v_wmma_i32_16x16x16_iu8 v[85:92], v[101:104], v[105:108], v[85:92] neg_lo:[1,1,0] clamp// 000000030738: CC44C055 7D56D365
	ds_load_b128 v[101:104], v25 offset:144                    // 000000030740: DBFC0090 65000019
	ds_load_b128 v[105:108], v54 offset:2688                   // 000000030748: DBFC0A80 69000036
	ds_load_b128 v[109:112], v54 offset:2704                   // 000000030750: DBFC0A90 6D000036
	ds_load_b128 v[113:116], v25 offset:160                    // 000000030758: DBFC00A0 71000019
	v_cvt_f32_i32_e32 v85, v85                                 // 000000030760: 7EAA0B55
	v_cvt_f32_i32_e32 v86, v86                                 // 000000030764: 7EAC0B56
	v_cvt_f32_i32_e32 v87, v87                                 // 000000030768: 7EAE0B57
	v_cvt_f32_i32_e32 v88, v88                                 // 00000003076C: 7EB00B58
	v_cvt_f32_i32_e32 v89, v89                                 // 000000030770: 7EB20B59
	v_cvt_f32_i32_e32 v90, v90                                 // 000000030774: 7EB40B5A
	v_cvt_f32_i32_e32 v91, v91                                 // 000000030778: 7EB60B5B
	v_cvt_f32_i32_e32 v92, v92                                 // 00000003077C: 7EB80B5C
	s_waitcnt lgkmcnt(2)                                       // 000000030780: BF89FC27
	v_wmma_i32_16x16x16_iu8 v[93:100], v[105:108], v[101:104], v[0:7] neg_lo:[1,1,0] clamp// 000000030784: CC44C05D 7C02CB69
	s_waitcnt lgkmcnt(0)                                       // 00000003078C: BF89FC07
	s_delay_alu instid0(VALU_DEP_1)                            // 000000030790: BF870001
	v_wmma_i32_16x16x16_iu8 v[93:100], v[109:112], v[113:116], v[93:100] neg_lo:[1,1,0] clamp// 000000030794: CC44C05D 7D76E36D
	ds_load_b128 v[109:112], v25 offset:176                    // 00000003079C: DBFC00B0 6D000019
	ds_load_b128 v[113:116], v54 offset:2720                   // 0000000307A4: DBFC0AA0 71000036
	ds_load_b128 v[117:120], v54 offset:2736                   // 0000000307AC: DBFC0AB0 75000036
	ds_load_b128 v[121:124], v25 offset:192                    // 0000000307B4: DBFC00C0 79000019
	ds_load_2addr_b32 v[157:158], v55 offset1:1                // 0000000307BC: D8DC0100 9D000037
	ds_load_2addr_b32 v[159:160], v56 offset1:1                // 0000000307C4: D8DC0100 9F000038
	ds_load_2addr_b32 v[161:162], v57 offset1:1                // 0000000307CC: D8DC0100 A1000039
	ds_load_2addr_b32 v[163:164], v58 offset1:1                // 0000000307D4: D8DC0100 A300003A
	ds_load_2addr_b32 v[165:166], v59 offset1:1                // 0000000307DC: D8DC0100 A500003B
	ds_load_2addr_b32 v[167:168], v60 offset1:1                // 0000000307E4: D8DC0100 A700003C
	ds_load_2addr_b32 v[169:170], v61 offset1:1                // 0000000307EC: D8DC0100 A900003D
	ds_load_2addr_b32 v[171:172], v62 offset1:1                // 0000000307F4: D8DC0100 AB00003E
	ds_load_2addr_b32 v[173:174], v25 offset0:16 offset1:17    // 0000000307FC: D8DC1110 AD000019
	ds_load_2addr_b32 v[175:176], v25 offset0:18 offset1:19    // 000000030804: D8DC1312 AF000019
	ds_load_2addr_b32 v[177:178], v63 offset1:1                // 00000003080C: D8DC0100 B100003F
	ds_load_2addr_b32 v[179:180], v64 offset1:1                // 000000030814: D8DC0100 B3000040
	ds_load_2addr_b32 v[181:182], v65 offset1:1                // 00000003081C: D8DC0100 B5000041
	ds_load_2addr_b32 v[183:184], v66 offset1:1                // 000000030824: D8DC0100 B7000042
	ds_load_2addr_b32 v[185:186], v67 offset1:1                // 00000003082C: D8DC0100 B9000043
	ds_load_2addr_b32 v[187:188], v68 offset1:1                // 000000030834: D8DC0100 BB000044
	ds_load_2addr_b32 v[189:190], v69 offset1:1                // 00000003083C: D8DC0100 BD000045
	ds_load_2addr_b32 v[191:192], v70 offset1:1                // 000000030844: D8DC0100 BF000046
	s_waitcnt lgkmcnt(0)                                       // 00000003084C: BF89FC07
	s_barrier                                                  // 000000030850: BFBD0000
	buffer_gl0_inv                                             // 000000030854: E0AC0000 00000000
	v_dual_mul_f32 v8, v157, v8 :: v_dual_mul_f32 v9, v159, v9 // 00000003085C: C8C6119D 0808139F
	v_dual_mul_f32 v10, v161, v10 :: v_dual_mul_f32 v11, v163, v11// 000000030864: C8C615A1 0A0A17A3
	v_cvt_f32_i32_e32 v93, v93                                 // 00000003086C: 7EBA0B5D
	v_cvt_f32_i32_e32 v94, v94                                 // 000000030870: 7EBC0B5E
	v_cvt_f32_i32_e32 v95, v95                                 // 000000030874: 7EBE0B5F
	v_cvt_f32_i32_e32 v96, v96                                 // 000000030878: 7EC00B60
	v_dual_mul_f32 v85, v158, v85 :: v_dual_mul_f32 v86, v160, v86// 00000003087C: C8C6AB9E 5556ADA0
	v_dual_mul_f32 v87, v162, v87 :: v_dual_mul_f32 v88, v164, v88// 000000030884: C8C6AFA2 5758B1A4
	v_mul_f32_e32 v12, v165, v12                               // 00000003088C: 101819A5
	v_wmma_i32_16x16x16_iu8 v[101:108], v[113:116], v[109:112], v[0:7] neg_lo:[1,1,0] clamp// 000000030890: CC44C065 7C02DB71
	v_add_co_u32 v109, vcc_lo, v31, s0                         // 000000030898: D7006A6D 0000011F
	s_delay_alu instid0(VALU_DEP_1)                            // 0000000308A0: BF870001
	v_add_co_ci_u32_e64 v110, null, s1, v33, vcc_lo            // 0000000308A4: D5207C6E 01AA4201
	s_clause 0x4                                               // 0000000308AC: BF850004
	global_load_b32 v111, v[109:110], off                      // 0000000308B0: DC520000 6F7C006D
	global_load_b32 v112, v[109:110], off offset:512           // 0000000308B8: DC520200 707C006D
	global_load_b32 v113, v[109:110], off offset:1024          // 0000000308C0: DC520400 717C006D
	global_load_b32 v114, v[109:110], off offset:1536          // 0000000308C8: DC520600 727C006D
	global_load_b32 v109, v[109:110], off offset:2048          // 0000000308D0: DC520800 6D7C006D
	v_wmma_i32_16x16x16_iu8 v[101:108], v[117:120], v[121:124], v[101:108] neg_lo:[1,1,0] clamp// 0000000308D8: CC44C065 7D96F375
	v_mul_f32_e32 v14, v169, v14                               // 0000000308E0: 101C1DA9
	v_fmac_f32_e32 v19, v173, v8                               // 0000000308E4: 562611AD
	v_fmac_f32_e32 v35, v173, v9                               // 0000000308E8: 564613AD
	v_fmac_f32_e32 v34, v173, v10                              // 0000000308EC: 564415AD
	v_fmac_f32_e32 v32, v173, v11                              // 0000000308F0: 564017AD
	v_cvt_f32_i32_e32 v101, v101                               // 0000000308F4: 7ECA0B65
	v_cvt_f32_i32_e32 v102, v102                               // 0000000308F8: 7ECC0B66
	v_cvt_f32_i32_e32 v103, v103                               // 0000000308FC: 7ECE0B67
	v_cvt_f32_i32_e32 v104, v104                               // 000000030900: 7ED00B68
	v_mul_f32_e32 v13, v167, v13                               // 000000030904: 101A1BA7
	v_dual_mul_f32 v15, v171, v15 :: v_dual_fmac_f32 v30, v173, v12// 000000030908: C8C01FAB 0F1E19AD
	v_dual_fmac_f32 v28, v173, v14 :: v_dual_fmac_f32 v19, v174, v85// 000000030910: C8001DAD 1C12ABAE
	v_fmac_f32_e32 v35, v174, v86                              // 000000030918: 5646ADAE
	v_fmac_f32_e32 v34, v174, v87                              // 00000003091C: 5644AFAE
	v_fmac_f32_e32 v32, v174, v88                              // 000000030920: 5640B1AE
	v_mul_f32_e32 v8, v177, v93                                // 000000030924: 1010BBB1
	v_mul_f32_e32 v10, v179, v94                               // 000000030928: 1014BDB3
	v_mul_f32_e32 v12, v181, v95                               // 00000003092C: 1018BFB5
	v_dual_mul_f32 v14, v183, v96 :: v_dual_fmac_f32 v29, v173, v13// 000000030930: C8C0C1B7 0E1C1BAD
	v_dual_fmac_f32 v24, v173, v15 :: v_dual_mul_f32 v9, v178, v101// 000000030938: C8061FAD 1808CBB2
	v_mul_f32_e32 v11, v180, v102                              // 000000030940: 1016CDB4
	v_mul_f32_e32 v13, v182, v103                              // 000000030944: 101ACFB6
	v_mul_f32_e32 v15, v184, v104                              // 000000030948: 101ED1B8
	v_fmac_f32_e32 v19, v175, v8                               // 00000003094C: 562611AF
	v_fmac_f32_e32 v35, v175, v10                              // 000000030950: 564615AF
	v_fmac_f32_e32 v34, v175, v12                              // 000000030954: 564419AF
	v_fmac_f32_e32 v32, v175, v14                              // 000000030958: 56401DAF
	v_cvt_f32_i32_e32 v97, v97                                 // 00000003095C: 7EC20B61
	v_fmac_f32_e32 v19, v176, v9                               // 000000030960: 562613B0
	v_fmac_f32_e32 v35, v176, v11                              // 000000030964: 564617B0
	v_fmac_f32_e32 v34, v176, v13                              // 000000030968: 56441BB0
	v_fmac_f32_e32 v32, v176, v15                              // 00000003096C: 56401FB0
	v_cvt_f32_i32_e32 v98, v98                                 // 000000030970: 7EC40B62
	v_cvt_f32_i32_e32 v99, v99                                 // 000000030974: 7EC60B63
	v_cvt_f32_i32_e32 v100, v100                               // 000000030978: 7EC80B64
	v_dual_mul_f32 v89, v166, v89 :: v_dual_mul_f32 v90, v168, v90// 00000003097C: C8C6B3A6 595AB5A8
	v_dual_mul_f32 v91, v170, v91 :: v_dual_mul_f32 v92, v172, v92// 000000030984: C8C6B7AA 5B5CB9AC
	v_cvt_f32_i32_e32 v105, v105                               // 00000003098C: 7ED20B69
	v_cvt_f32_i32_e32 v106, v106                               // 000000030990: 7ED40B6A
	v_cvt_f32_i32_e32 v107, v107                               // 000000030994: 7ED60B6B
	v_cvt_f32_i32_e32 v108, v108                               // 000000030998: 7ED80B6C
	v_fmac_f32_e32 v30, v174, v89                              // 00000003099C: 563CB3AE
	v_fmac_f32_e32 v29, v174, v90                              // 0000000309A0: 563AB5AE
	v_fmac_f32_e32 v28, v174, v91                              // 0000000309A4: 5638B7AE
	v_dual_fmac_f32 v24, v174, v92 :: v_dual_mul_f32 v85, v185, v97// 0000000309A8: C806B9AE 1854C3B9
	v_mul_f32_e32 v87, v187, v98                               // 0000000309B0: 10AEC5BB
	v_mul_f32_e32 v89, v189, v99                               // 0000000309B4: 10B2C7BD
	v_dual_mul_f32 v91, v191, v100 :: v_dual_mul_f32 v86, v186, v105// 0000000309B8: C8C6C9BF 5B56D3BA
	v_mul_f32_e32 v88, v188, v106                              // 0000000309C0: 10B0D5BC
	v_mul_f32_e32 v90, v190, v107                              // 0000000309C4: 10B4D7BE
	s_waitcnt vmcnt(3)                                         // 0000000309C8: BF890FF7
	ds_store_2addr_b32 v27, v111, v112 offset0:16 offset1:144  // 0000000309CC: D8389010 00706F1B
	s_waitcnt vmcnt(1)                                         // 0000000309D4: BF8907F7
	ds_store_2addr_stride64_b32 v76, v113, v114 offset0:4 offset1:6// 0000000309D8: D83C0604 0072714C
	s_waitcnt vmcnt(0)                                         // 0000000309E0: BF8903F7
	ds_store_b32 v27, v109 offset:2112                         // 0000000309E4: D8340840 00006D1B
	s_waitcnt lgkmcnt(0)                                       // 0000000309EC: BF89FC07
	s_barrier                                                  // 0000000309F0: BFBD0000
	buffer_gl0_inv                                             // 0000000309F4: E0AC0000 00000000
	ds_load_b128 v[117:120], v25 offset:80                     // 0000000309FC: DBFC0050 75000019
	ds_load_b128 v[121:124], v54 offset:2752                   // 000000030A04: DBFC0AC0 79000036
	ds_load_b128 v[125:128], v54 offset:2768                   // 000000030A0C: DBFC0AD0 7D000036
	ds_load_b128 v[129:132], v25 offset:96                     // 000000030A14: DBFC0060 81000019
	v_mul_f32_e32 v92, v192, v108                              // 000000030A1C: 10B8D9C0
	v_fmac_f32_e32 v30, v175, v85                              // 000000030A20: 563CABAF
	v_fmac_f32_e32 v29, v175, v87                              // 000000030A24: 563AAFAF
	v_fmac_f32_e32 v28, v175, v89                              // 000000030A28: 5638B3AF
	v_fmac_f32_e32 v24, v175, v91                              // 000000030A2C: 5630B7AF
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 000000030A30: BF870214
	v_fmac_f32_e32 v30, v176, v86                              // 000000030A34: 563CADB0
	v_fmac_f32_e32 v29, v176, v88                              // 000000030A38: 563AB1B0
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 000000030A3C: BF870214
	v_fmac_f32_e32 v28, v176, v90                              // 000000030A40: 5638B5B0
	v_fmac_f32_e32 v24, v176, v92                              // 000000030A44: 5630B9B0
	s_waitcnt lgkmcnt(2)                                       // 000000030A48: BF89FC27
	v_wmma_i32_16x16x16_iu8 v[109:116], v[121:124], v[117:120], v[0:7] neg_lo:[1,1,0] clamp// 000000030A4C: CC44C06D 7C02EB79
	s_waitcnt lgkmcnt(0)                                       // 000000030A54: BF89FC07
	s_delay_alu instid0(VALU_DEP_1)                            // 000000030A58: BF870001
	v_wmma_i32_16x16x16_iu8 v[109:116], v[125:128], v[129:132], v[109:116] neg_lo:[1,1,0] clamp// 000000030A5C: CC44C06D 7DB7037D
	ds_load_b128 v[125:128], v25 offset:112                    // 000000030A64: DBFC0070 7D000019
	ds_load_b128 v[129:132], v54 offset:2784                   // 000000030A6C: DBFC0AE0 81000036
	ds_load_b128 v[133:136], v54 offset:2800                   // 000000030A74: DBFC0AF0 85000036
	ds_load_b128 v[137:140], v25 offset:128                    // 000000030A7C: DBFC0080 89000019
	v_cvt_f32_i32_e32 v109, v109                               // 000000030A84: 7EDA0B6D
	v_cvt_f32_i32_e32 v110, v110                               // 000000030A88: 7EDC0B6E
	v_cvt_f32_i32_e32 v111, v111                               // 000000030A8C: 7EDE0B6F
	v_cvt_f32_i32_e32 v112, v112                               // 000000030A90: 7EE00B70
	v_cvt_f32_i32_e32 v113, v113                               // 000000030A94: 7EE20B71
	v_cvt_f32_i32_e32 v114, v114                               // 000000030A98: 7EE40B72
	v_cvt_f32_i32_e32 v115, v115                               // 000000030A9C: 7EE60B73
	v_cvt_f32_i32_e32 v116, v116                               // 000000030AA0: 7EE80B74
	s_waitcnt lgkmcnt(2)                                       // 000000030AA4: BF89FC27
	v_wmma_i32_16x16x16_iu8 v[117:124], v[129:132], v[125:128], v[0:7] neg_lo:[1,1,0] clamp// 000000030AA8: CC44C075 7C02FB81
	s_waitcnt lgkmcnt(0)                                       // 000000030AB0: BF89FC07
	s_delay_alu instid0(VALU_DEP_1)                            // 000000030AB4: BF870001
	v_wmma_i32_16x16x16_iu8 v[117:124], v[133:136], v[137:140], v[117:124] neg_lo:[1,1,0] clamp// 000000030AB8: CC44C075 7DD71385
	ds_load_b128 v[133:136], v25 offset:144                    // 000000030AC0: DBFC0090 85000019
	ds_load_b128 v[137:140], v54 offset:2816                   // 000000030AC8: DBFC0B00 89000036
	ds_load_b128 v[141:144], v54 offset:2832                   // 000000030AD0: DBFC0B10 8D000036
	ds_load_b128 v[145:148], v25 offset:160                    // 000000030AD8: DBFC00A0 91000019
	v_cvt_f32_i32_e32 v117, v117                               // 000000030AE0: 7EEA0B75
	v_cvt_f32_i32_e32 v118, v118                               // 000000030AE4: 7EEC0B76
	v_cvt_f32_i32_e32 v119, v119                               // 000000030AE8: 7EEE0B77
	v_cvt_f32_i32_e32 v120, v120                               // 000000030AEC: 7EF00B78
	v_cvt_f32_i32_e32 v121, v121                               // 000000030AF0: 7EF20B79
	v_cvt_f32_i32_e32 v122, v122                               // 000000030AF4: 7EF40B7A
	v_cvt_f32_i32_e32 v123, v123                               // 000000030AF8: 7EF60B7B
	v_cvt_f32_i32_e32 v124, v124                               // 000000030AFC: 7EF80B7C
	s_waitcnt lgkmcnt(2)                                       // 000000030B00: BF89FC27
	v_wmma_i32_16x16x16_iu8 v[125:132], v[137:140], v[133:136], v[0:7] neg_lo:[1,1,0] clamp// 000000030B04: CC44C07D 7C030B89
	s_waitcnt lgkmcnt(0)                                       // 000000030B0C: BF89FC07
	s_delay_alu instid0(VALU_DEP_1)                            // 000000030B10: BF870001
	v_wmma_i32_16x16x16_iu8 v[125:132], v[141:144], v[145:148], v[125:132] neg_lo:[1,1,0] clamp// 000000030B14: CC44C07D 7DF7238D
	ds_load_b128 v[141:144], v25 offset:176                    // 000000030B1C: DBFC00B0 8D000019
	ds_load_b128 v[145:148], v54 offset:2848                   // 000000030B24: DBFC0B20 91000036
	ds_load_b128 v[149:152], v54 offset:2864                   // 000000030B2C: DBFC0B30 95000036
	ds_load_b128 v[153:156], v25 offset:192                    // 000000030B34: DBFC00C0 99000019
	ds_load_2addr_b32 v[8:9], v71 offset1:1                    // 000000030B3C: D8DC0100 08000047
	ds_load_2addr_b32 v[10:11], v72 offset1:1                  // 000000030B44: D8DC0100 0A000048
	ds_load_2addr_b32 v[12:13], v73 offset1:1                  // 000000030B4C: D8DC0100 0C000049
	ds_load_2addr_b32 v[14:15], v74 offset1:1                  // 000000030B54: D8DC0100 0E00004A
	v_cvt_f32_i32_e32 v127, v127                               // 000000030B5C: 7EFE0B7F
	v_cvt_f32_i32_e32 v125, v125                               // 000000030B60: 7EFA0B7D
	v_cvt_f32_i32_e32 v126, v126                               // 000000030B64: 7EFC0B7E
	v_cvt_f32_i32_e32 v128, v128                               // 000000030B68: 7F000B80
	v_cvt_f32_i32_e32 v131, v131                               // 000000030B6C: 7F060B83
	v_cvt_f32_i32_e32 v129, v129                               // 000000030B70: 7F020B81
	v_cvt_f32_i32_e32 v130, v130                               // 000000030B74: 7F040B82
	v_cvt_f32_i32_e32 v132, v132                               // 000000030B78: 7F080B84
	s_waitcnt lgkmcnt(3)                                       // 000000030B7C: BF89FC37
	v_mul_f32_e32 v85, v8, v109                                // 000000030B80: 10AADB08
	s_waitcnt lgkmcnt(2)                                       // 000000030B84: BF89FC27
	v_dual_mul_f32 v86, v9, v117 :: v_dual_mul_f32 v87, v10, v110// 000000030B88: C8C6EB09 5656DD0A
	s_waitcnt lgkmcnt(1)                                       // 000000030B90: BF89FC17
	v_dual_mul_f32 v88, v11, v118 :: v_dual_mul_f32 v89, v12, v111// 000000030B94: C8C6ED0B 5858DF0C
	s_waitcnt lgkmcnt(0)                                       // 000000030B9C: BF89FC07
	v_dual_mul_f32 v90, v13, v119 :: v_dual_mul_f32 v91, v14, v112// 000000030BA0: C8C6EF0D 5A5AE10E
	v_mul_f32_e32 v92, v15, v120                               // 000000030BA8: 10B8F10F
	ds_load_2addr_b32 v[8:9], v77 offset1:1                    // 000000030BAC: D8DC0100 0800004D
	ds_load_2addr_b32 v[10:11], v78 offset1:1                  // 000000030BB4: D8DC0100 0A00004E
	ds_load_2addr_b32 v[12:13], v79 offset1:1                  // 000000030BBC: D8DC0100 0C00004F
	ds_load_2addr_b32 v[14:15], v80 offset1:1                  // 000000030BC4: D8DC0100 0E000050
	v_wmma_i32_16x16x16_iu8 v[133:140], v[145:148], v[141:144], v[0:7] neg_lo:[1,1,0] clamp// 000000030BCC: CC44C085 7C031B91
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000030BD4: BF870091
	v_wmma_i32_16x16x16_iu8 v[133:140], v[149:152], v[153:156], v[133:140] neg_lo:[1,1,0] clamp// 000000030BD8: CC44C085 7E173395
	v_cvt_f32_i32_e32 v135, v135                               // 000000030BE0: 7F0E0B87
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_3)// 000000030BE4: BF870192
	v_cvt_f32_i32_e32 v133, v133                               // 000000030BE8: 7F0A0B85
	v_cvt_f32_i32_e32 v134, v134                               // 000000030BEC: 7F0C0B86
	s_delay_alu instid0(VALU_DEP_4)                            // 000000030BF0: BF870004
	v_cvt_f32_i32_e32 v136, v136                               // 000000030BF4: 7F100B88
	v_cvt_f32_i32_e32 v139, v139                               // 000000030BF8: 7F160B8B
	v_cvt_f32_i32_e32 v137, v137                               // 000000030BFC: 7F120B89
	s_waitcnt lgkmcnt(3)                                       // 000000030C00: BF89FC37
	v_mul_f32_e32 v93, v8, v113                                // 000000030C04: 10BAE308
	s_waitcnt lgkmcnt(2)                                       // 000000030C08: BF89FC27
	v_dual_mul_f32 v94, v9, v121 :: v_dual_mul_f32 v95, v10, v114// 000000030C0C: C8C6F309 5E5EE50A
	v_mul_f32_e32 v96, v11, v122                               // 000000030C14: 10C0F50B
	ds_load_2addr_b32 v[8:9], v25 offset0:16 offset1:17        // 000000030C18: D8DC1110 08000019
	ds_load_2addr_b32 v[10:11], v25 offset0:18 offset1:19      // 000000030C20: D8DC1312 0A000019
	s_waitcnt lgkmcnt(3)                                       // 000000030C28: BF89FC37
	v_mul_f32_e32 v12, v12, v115                               // 000000030C2C: 1018E70C
	s_waitcnt lgkmcnt(2)                                       // 000000030C30: BF89FC27
	v_dual_mul_f32 v14, v14, v116 :: v_dual_mul_f32 v13, v13, v123// 000000030C34: C8C6E90E 0E0CF70D
	v_mul_f32_e32 v15, v15, v124                               // 000000030C3C: 101EF90F
	v_cvt_f32_i32_e32 v138, v138                               // 000000030C40: 7F140B8A
	v_cvt_f32_i32_e32 v140, v140                               // 000000030C44: 7F180B8C
	s_waitcnt lgkmcnt(1)                                       // 000000030C48: BF89FC17
	v_fmac_f32_e32 v19, v8, v85                                // 000000030C4C: 5626AB08
	v_fmac_f32_e32 v35, v8, v87                                // 000000030C50: 5646AF08
	v_fmac_f32_e32 v34, v8, v89                                // 000000030C54: 5644B308
	v_fmac_f32_e32 v32, v8, v91                                // 000000030C58: 5640B708
	v_fmac_f32_e32 v30, v8, v93                                // 000000030C5C: 563CBB08
	v_fmac_f32_e32 v29, v8, v95                                // 000000030C60: 563ABF08
	v_fmac_f32_e32 v28, v8, v12                                // 000000030C64: 56381908
	v_fmac_f32_e32 v24, v8, v14                                // 000000030C68: 56301D08
	v_fmac_f32_e32 v19, v9, v86                                // 000000030C6C: 5626AD09
	v_fmac_f32_e32 v35, v9, v88                                // 000000030C70: 5646B109
	v_fmac_f32_e32 v34, v9, v90                                // 000000030C74: 5644B509
	v_fmac_f32_e32 v32, v9, v92                                // 000000030C78: 5640B909
	v_fmac_f32_e32 v30, v9, v94                                // 000000030C7C: 563CBD09
	v_fmac_f32_e32 v29, v9, v96                                // 000000030C80: 563AC109
	v_fmac_f32_e32 v28, v9, v13                                // 000000030C84: 56381B09
	v_fmac_f32_e32 v24, v9, v15                                // 000000030C88: 56301F09
	ds_load_2addr_b32 v[8:9], v81 offset1:1                    // 000000030C8C: D8DC0100 08000051
	ds_load_2addr_b32 v[12:13], v82 offset1:1                  // 000000030C94: D8DC0100 0C000052
	ds_load_2addr_b32 v[14:15], v83 offset1:1                  // 000000030C9C: D8DC0100 0E000053
	ds_load_2addr_b32 v[85:86], v84 offset1:1                  // 000000030CA4: D8DC0100 55000054
	s_waitcnt lgkmcnt(3)                                       // 000000030CAC: BF89FC37
	v_dual_mul_f32 v87, v8, v125 :: v_dual_add_nc_u32 v8, 0x14d8, v26// 000000030CB0: C8E0FB08 570834FF 000014D8
	s_waitcnt lgkmcnt(1)                                       // 000000030CBC: BF89FC17
	v_dual_mul_f32 v91, v14, v127 :: v_dual_add_nc_u32 v14, 0x1998, v26// 000000030CC0: C8E0FF0E 5B0E34FF 00001998
	v_dual_mul_f32 v92, v15, v135 :: v_dual_mul_f32 v89, v12, v126// 000000030CCC: C8C70F0F 5C58FD0C
	v_add_nc_u32_e32 v12, 0x1738, v26                          // 000000030CD4: 4A1834FF 00001738
	s_waitcnt lgkmcnt(0)                                       // 000000030CDC: BF89FC07
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_3) | instid1(VALU_DEP_4)// 000000030CE0: BF870243
	v_dual_fmac_f32 v34, v10, v91 :: v_dual_mul_f32 v93, v85, v128// 000000030CE4: C806B70A 225D0155
	v_dual_mul_f32 v88, v9, v133 :: v_dual_add_nc_u32 v85, 0x1bf8, v26// 000000030CEC: C8E10B09 585434FF 00001BF8
	v_mul_f32_e32 v90, v13, v134                               // 000000030CF8: 10B50D0D
	v_mul_f32_e32 v94, v86, v136                               // 000000030CFC: 10BD1156
	v_fmac_f32_e32 v34, v11, v92                               // 000000030D00: 5644B90B
	ds_load_2addr_b32 v[8:9], v8 offset1:1                     // 000000030D04: D8DC0100 08000008
	ds_load_2addr_b32 v[12:13], v12 offset1:1                  // 000000030D0C: D8DC0100 0C00000C
	ds_load_2addr_b32 v[14:15], v14 offset1:1                  // 000000030D14: D8DC0100 0E00000E
	ds_load_2addr_b32 v[85:86], v85 offset1:1                  // 000000030D1C: D8DC0100 55000055
	s_waitcnt lgkmcnt(0)                                       // 000000030D24: BF89FC07
	s_barrier                                                  // 000000030D28: BFBD0000
	buffer_gl0_inv                                             // 000000030D2C: E0AC0000 00000000
	v_mul_f32_e32 v8, v8, v129                                 // 000000030D34: 10110308
	v_mul_f32_e32 v12, v12, v130                               // 000000030D38: 1019050C
	v_mul_f32_e32 v14, v14, v131                               // 000000030D3C: 101D070E
	v_dual_mul_f32 v15, v15, v139 :: v_dual_mul_f32 v86, v86, v140// 000000030D40: C8C7170F 0F571956
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 000000030D48: BF870214
	v_fmac_f32_e32 v30, v10, v8                                // 000000030D4C: 563C110A
	v_fmac_f32_e32 v29, v10, v12                               // 000000030D50: 563A190A
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 000000030D54: BF870124
	v_dual_fmac_f32 v28, v10, v14 :: v_dual_mul_f32 v85, v85, v132// 000000030D58: C8061D0A 1C550955
	v_fmac_f32_e32 v32, v10, v93                               // 000000030D60: 5640BB0A
	v_dual_mul_f32 v9, v9, v137 :: v_dual_fmac_f32 v28, v11, v15// 000000030D64: C8C11309 091C1F0B
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_4)// 000000030D6C: BF870223
	v_fmac_f32_e32 v24, v10, v85                               // 000000030D70: 5630AB0A
	v_fmac_f32_e32 v19, v10, v87                               // 000000030D74: 5626AF0A
	v_dual_fmac_f32 v35, v10, v89 :: v_dual_fmac_f32 v32, v11, v94// 000000030D78: C800B30A 2320BD0B
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 000000030D80: BF870214
	v_dual_mul_f32 v13, v13, v138 :: v_dual_fmac_f32 v30, v11, v9// 000000030D84: C8C1150D 0D1E130B
	v_fmac_f32_e32 v24, v11, v86                               // 000000030D8C: 5630AD0B
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 000000030D90: BF870214
	v_fmac_f32_e32 v19, v11, v88                               // 000000030D94: 5626B10B
	v_fmac_f32_e32 v35, v11, v90                               // 000000030D98: 5646B50B
	s_delay_alu instid0(VALU_DEP_4)                            // 000000030D9C: BF870004
	v_fmac_f32_e32 v29, v11, v13                               // 000000030DA0: 563A1B0B
	s_cbranch_scc0 62091                                       // 000000030DA4: BFA1F28B <_ZL9mul_mat_qIL9ggml_type18ELi16ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x4d4>
	v_mov_b32_e32 v2, v18                                      // 000000030DA8: 7E040312
	s_not_b32 s0, s28                                          // 000000030DAC: BE801E1C
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000030DB0: BF870009
	s_add_i32 s0, s16, s0                                      // 000000030DB4: 81000010
	s_delay_alu instid0(VALU_DEP_1) | instid1(SALU_CYCLE_1)    // 000000030DB8: BF870481
	v_cmp_ge_i32_e32 vcc_lo, s0, v2                            // 000000030DBC: 7C8C0400
	s_and_saveexec_b32 s0, vcc_lo                              // 000000030DC0: BE80206A
	s_cbranch_execz 61868                                      // 000000030DC4: BFA5F1AC <_ZL9mul_mat_qIL9ggml_type18ELi16ELb0EEvPKcPKiS4_S4_PfS5_PKf15HIP_vector_typeIjLj3EEiiiiiS9_S9_iiiS9_S9_iiiS9_+0x178>
	v_lshl_add_u32 v0, v2, 2, 0                                // 000000030DC8: D6460000 02010502
	v_lshlrev_b32_e32 v1, 4, v16                               // 000000030DD0: 30022084
	s_add_i32 s0, s25, s29                                     // 000000030DD4: 81001D19
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000030DD8: BF870009
	s_ashr_i32 s1, s0, 31                                      // 000000030DDC: 86019F00
	ds_load_b32 v0, v0                                         // 000000030DE0: D8D80000 00000000
	s_lshl_b64 s[0:1], s[0:1], 2                               // 000000030DE8: 84808200
	s_waitcnt lgkmcnt(0)                                       // 000000030DEC: BF89FC07
	s_add_u32 s0, s26, s0                                      // 000000030DF0: 8000001A
	s_addc_u32 s1, s27, s1                                     // 000000030DF4: 8201011B
	v_mul_lo_u32 v0, v0, s19                                   // 000000030DF8: D72C0000 00002700
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000030E00: BF870091
	v_add3_u32 v0, v1, v17, v0                                 // 000000030E04: D6550000 04022301
	v_ashrrev_i32_e32 v1, 31, v0                               // 000000030E0C: 3402009F
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000030E10: BF870091
	v_lshlrev_b64 v[0:1], 2, v[0:1]                            // 000000030E14: D73C0000 00020082
	v_add_co_u32 v0, vcc_lo, s0, v0                            // 000000030E1C: D7006A00 00020000
	s_delay_alu instid0(VALU_DEP_1)                            // 000000030E24: BF870001
	v_add_co_ci_u32_e64 v1, null, s1, v1, vcc_lo               // 000000030E28: D5207C01 01AA0201
	s_clause 0x7                                               // 000000030E30: BF850007
	global_store_b32 v[0:1], v19, off                          // 000000030E34: DC6A0000 007C1300
	global_store_b32 v[0:1], v35, off offset:8                 // 000000030E3C: DC6A0008 007C2300
	global_store_b32 v[0:1], v34, off offset:16                // 000000030E44: DC6A0010 007C2200
	global_store_b32 v[0:1], v32, off offset:24                // 000000030E4C: DC6A0018 007C2000
	global_store_b32 v[0:1], v30, off offset:32                // 000000030E54: DC6A0020 007C1E00
	global_store_b32 v[0:1], v29, off offset:40                // 000000030E5C: DC6A0028 007C1D00
	global_store_b32 v[0:1], v28, off offset:48                // 000000030E64: DC6A0030 007C1C00
	global_store_b32 v[0:1], v24, off offset:56                // 000000030E6C: DC6A0038 007C1800
	s_nop 0                                                    // 000000030E74: BF800000
	s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)                       // 000000030E78: BFB60003
	s_endpgm                                                   // 000000030E7C: BFB00000
		...
