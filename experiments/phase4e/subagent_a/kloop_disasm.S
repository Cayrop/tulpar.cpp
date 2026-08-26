
co_033.o:	file format elf64-amdgpu

Disassembly of section .text:

0000000000148400 <_ZL13mul_mat_vec_qIL9ggml_type18ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj>:
	s_clause 0x1                                               // 000000148400: BF850001
	s_load_b64 s[8:9], s[0:1], 0x10                            // 000000148404: F4040200 F8000010
	s_load_b128 s[16:19], s[0:1], 0x50                         // 00000014840C: F4080400 F8000050
	s_mov_b32 s6, s3                                           // 000000148414: BE860003
	s_waitcnt lgkmcnt(0)                                       // 000000148418: BF89FC07
	s_cmp_lg_u64 s[8:9], 0                                     // 00000014841C: BF118008
	s_cselect_b32 s5, -1, 0                                    // 000000148420: 980580C1
	s_cmp_eq_u64 s[8:9], 0                                     // 000000148424: BF108008
	s_cbranch_scc1 32                                          // 000000148428: BFA20020 <_ZL13mul_mat_vec_qIL9ggml_type18ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0xac>
	s_mov_b32 s7, 0                                            // 00000014842C: BE870080
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 000000148430: BF870499
	s_lshl_b64 s[10:11], s[6:7], 2                             // 000000148434: 848A8206
	s_add_u32 s8, s8, s10                                      // 000000148438: 80080A08
	s_addc_u32 s9, s9, s11                                     // 00000014843C: 82090B09
	s_load_b32 s3, s[8:9], null                                // 000000148440: F40000C4 F8000000
	s_clause 0x1                                               // 000000148448: BF850001
	s_load_b128 s[8:11], s[0:1], 0x78                          // 00000014844C: F4080200 F8000078
	s_load_b32 s20, s[0:1], 0x60                               // 000000148454: F4000500 F8000060
	s_cbranch_execnz 7                                         // 00000014845C: BFA60007 <_ZL13mul_mat_vec_qIL9ggml_type18ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0x7c>
	s_load_b64 s[12:13], s[0:1], 0x6c                          // 000000148460: F4040300 F800006C
	s_waitcnt lgkmcnt(0)                                       // 000000148468: BF89FC07
	s_mul_hi_u32 s3, s12, s6                                   // 00000014846C: 9683060C
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 000000148470: BF870499
	s_add_i32 s3, s6, s3                                       // 000000148474: 81030306
	s_lshr_b32 s3, s3, s13                                     // 000000148478: 85030D03
	s_load_b32 s21, s[0:1], 0x88                               // 00000014847C: F4000540 F8000088
	s_and_not1_b32 vcc_lo, exec_lo, s5                         // 000000148484: 916A057E
	s_cbranch_vccnz 14                                         // 000000148488: BFA4000E <_ZL13mul_mat_vec_qIL9ggml_type18ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0xc4>
	s_mul_hi_u32 s5, s17, s6                                   // 00000014848C: 96850611
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 000000148490: BF870499
	s_add_i32 s5, s6, s5                                       // 000000148494: 81050506
	s_lshr_b32 s5, s5, s18                                     // 000000148498: 85051205
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 00000014849C: BF870499
	s_mul_i32 s5, s5, s19                                      // 0000001484A0: 96051305
	s_sub_i32 s17, s6, s5                                      // 0000001484A4: 81910506
	s_branch 7                                                 // 0000001484A8: BFA00007 <_ZL13mul_mat_vec_qIL9ggml_type18ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0xc8>
	s_clause 0x1                                               // 0000001484AC: BF850001
	s_load_b128 s[8:11], s[0:1], 0x78                          // 0000001484B0: F4080200 F8000078
	s_load_b32 s20, s[0:1], 0x60                               // 0000001484B8: F4000500 F8000060
	s_branch 65511                                             // 0000001484C0: BFA0FFE7 <_ZL13mul_mat_vec_qIL9ggml_type18ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0x60>
	s_mov_b32 s17, s6                                          // 0000001484C4: BE910006
	s_load_b128 s[12:15], s[0:1], 0x90                         // 0000001484C8: F4080300 F8000090
	v_bfe_u32 v11, v0, 10, 10                                  // 0000001484D0: D610000B 02291500
	v_and_b32_e32 v10, 0x3ff, v0                               // 0000001484D8: 361400FF 000003FF
	v_mov_b32_e32 v12, 0                                       // 0000001484E0: 7E180280
	s_lshr_b32 s7, s16, 8                                      // 0000001484E4: 85078810
	s_mov_b32 s5, exec_lo                                      // 0000001484E8: BE85007E
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000001484EC: BF870092
	v_lshl_or_b32 v0, v11, 5, v10                              // 0000001484F0: D6560000 04290B0B
	v_lshrrev_b32_e32 v13, 3, v0                               // 0000001484F8: 321A0083
	s_delay_alu instid0(VALU_DEP_1)                            // 0000001484FC: BF870001
	v_cmpx_gt_u32_e64 s7, v13                                  // 000000148500: D4CC007E 00021A07
	s_cbranch_execz 773                                        // 000000148508: BFA50305 <_ZL13mul_mat_vec_qIL9ggml_type18ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0xd20>
	v_lshrrev_b32_e32 v2, 3, v0                                // 00000014850C: 32040083
	s_waitcnt lgkmcnt(0)                                       // 000000148510: BF89FC07
	s_mul_i32 s9, s17, s9                                      // 000000148514: 96090911
	v_dual_mov_b32 v12, 0 :: v_dual_and_b32 v5, 7, v10         // 000000148518: CA240080 0C041487
	s_mul_hi_u32 s17, s9, 36                                   // 000000148520: 9691A409
	s_mul_i32 s16, s9, 36                                      // 000000148524: 9610A409
	s_mul_i32 s9, s13, s4                                      // 000000148528: 9609040D
	v_mad_u64_u32 v[0:1], null, 0x120, v2, s[16:17]            // 00000014852C: D6FE7C00 004204FF 00000120
	s_load_b128 s[16:19], s[0:1], null                         // 000000148538: F4080400 F8000000
	v_lshlrev_b32_e32 v4, 1, v10                               // 000000148540: 30081481
	s_mul_i32 s20, s20, s2                                     // 000000148544: 96140214
	s_mul_i32 s3, s3, s8                                       // 000000148548: 96030803
	v_mad_u64_u32 v[2:3], null, s9, 36, v[0:1]                 // 00000014854C: D6FE7C02 04014809
	s_mul_hi_u32 s9, s11, s4                                   // 000000148554: 9689040B
	s_mov_b32 s11, 0                                           // 000000148558: BE8B0080
	s_add_i32 s9, s4, s9                                       // 00000014855C: 81090904
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)// 000000148560: BF8704C9
	s_lshr_b32 s9, s9, s21                                     // 000000148564: 85091509
	v_mad_u64_u32 v[0:1], null, v5, 36, v[2:3]                 // 000000148568: D6FE7C00 04094905
	v_and_b32_e32 v2, 14, v4                                   // 000000148570: 3604088E
	s_mul_i32 s8, s9, s12                                      // 000000148574: 96080C09
	s_add_i32 s8, s8, s20                                      // 000000148578: 81081408
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000014857C: BF8701A1
	v_lshlrev_b32_e32 v3, 1, v2                                // 000000148580: 30060481
	s_waitcnt lgkmcnt(0)                                       // 000000148584: BF89FC07
	v_add_co_u32 v0, vcc_lo, s18, v0                           // 000000148588: D7006A00 00020012
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)// 000000148590: BF870191
	v_add_co_ci_u32_e64 v1, null, s19, v1, vcc_lo              // 000000148594: D5207C01 01AA0213
	v_lshlrev_b32_e32 v14, 1, v3                               // 00000014859C: 301C0681
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000001485A0: BF870093
	v_add_co_u32 v8, vcc_lo, v0, 32                            // 0000001485A4: D7006A08 00014100
	v_add_co_ci_u32_e64 v9, null, 0, v1, vcc_lo                // 0000001485AC: D5207C09 01AA0280
	v_lshlrev_b32_e32 v15, 1, v2                               // 0000001485B4: 301E0481
	s_add_i32 s12, s3, s8                                      // 0000001485B8: 810C0803
	s_delay_alu instid0(SALU_CYCLE_1)                          // 0000001485BC: BF870009
	v_add_nc_u32_e32 v18, s12, v13                             // 0000001485C0: 4A241A0C
	s_clause 0x2                                               // 0000001485C4: BF850002
	global_load_b32 v16, v[8:9], off                           // 0000001485C8: DC520000 107C0008
	global_load_b128 v[0:3], v[8:9], off offset:-32            // 0000001485D0: DC5E1FE0 007C0008
	global_load_b128 v[4:7], v[8:9], off offset:-16            // 0000001485D8: DC5E1FF0 047C0008
	s_getpc_b64 s[8:9]                                         // 0000001485E0: BE884700
	s_add_u32 s8, s8, 0xfff4099c                               // 0000001485E4: 8008FF08 FFF4099C
	s_addc_u32 s9, s9, lit(0xffffffff)                         // 0000001485EC: 8209FF09 FFFFFFFF
	v_mov_b16_e32 v17.l, 0                                     // 0000001485F4: 7E223880
	v_add_nc_u32_e32 v13, 4, v13                               // 0000001485F8: 4A1A1A84
	v_mad_i64_i32 v[21:22], null, 0x62, v18, s[16:17]          // 0000001485FC: D6FF7C15 004224FF 00000062
	s_delay_alu instid0(VALU_DEP_3)                            // 000000148608: BF870003
	v_mov_b16_e32 v18.h, v17.l                                 // 00000014860C: 7F243911
	v_mov_b16_e32 v19.h, v17.l                                 // 000000148610: 7F263911
	v_mov_b16_e32 v20.h, v17.l                                 // 000000148614: 7F283911
	v_mov_b16_e32 v45.h, v17.l                                 // 000000148618: 7F5A3911
	v_mov_b16_e32 v46.h, v17.l                                 // 00000014861C: 7F5C3911
	v_add_co_u32 v23, vcc_lo, v21, v14                         // 000000148620: D7006A17 00021D15
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 000000148628: BF8700A1
	v_add_co_ci_u32_e64 v24, null, 0, v22, vcc_lo              // 00000014862C: D5207C18 01AA2C80
	v_add_co_u32 v25, vcc_lo, v21, v15                         // 000000148634: D7006A19 00021F15
	v_add_co_ci_u32_e64 v26, null, 0, v22, vcc_lo              // 00000014863C: D5207C1A 01AA2C80
	s_clause 0x2                                               // 000000148644: BF850002
	global_load_b64 v[23:24], v[23:24], off offset:2           // 000000148648: DC560002 177C0017
	global_load_b32 v50, v[25:26], off offset:66               // 000000148650: DC520042 327C0019
	global_load_d16_hi_b16 v0, v[21:22], off                   // 000000148658: DC8E0000 007C0015
	v_mov_b16_e32 v47.h, v17.l                                 // 000000148660: 7F5E3911
	v_mov_b16_e32 v48.h, v17.l                                 // 000000148664: 7F603911
	v_mov_b16_e32 v49.h, v17.l                                 // 000000148668: 7F623911
	v_cmp_le_u32_e64 s3, s7, v13                               // 00000014866C: D44B0003 00021A07
	s_or_b32 s11, s3, s11                                      // 000000148674: 8C0B0B03
	s_waitcnt vmcnt(2)                                         // 000000148678: BF890BF7
	v_and_b32_e32 v21, 0xff, v23                               // 00000014867C: 362A2EFF 000000FF
	v_lshrrev_b32_e32 v22, 6, v23                              // 000000148684: 322C2E86
	v_lshrrev_b32_e32 v26, 14, v23                             // 000000148688: 32342E8E
	v_lshrrev_b32_e32 v23, 22, v23                             // 00000014868C: 322E2E96
	v_and_b32_e32 v28, 0xff, v24                               // 000000148690: 363830FF 000000FF
	v_lshrrev_b32_e32 v29, 6, v24                              // 000000148698: 323A3086
	v_lshrrev_b32_e32 v31, 14, v24                             // 00000014869C: 323E308E
	v_lshrrev_b32_e32 v24, 22, v24                             // 0000001486A0: 32303096
	v_lshlrev_b32_e32 v21, 2, v21                              // 0000001486A4: 302A2A82
	v_and_b32_e32 v22, 0x3fc, v22                              // 0000001486A8: 362C2CFF 000003FC
	v_and_b32_e32 v26, 0x3fc, v26                              // 0000001486B0: 363434FF 000003FC
	v_and_b32_e32 v23, 0x3fc, v23                              // 0000001486B8: 362E2EFF 000003FC
	v_lshlrev_b32_e32 v28, 2, v28                              // 0000001486C0: 30383882
	v_and_b32_e32 v29, 0x3fc, v29                              // 0000001486C4: 363A3AFF 000003FC
	v_and_b32_e32 v31, 0x3fc, v31                              // 0000001486CC: 363E3EFF 000003FC
	v_and_b32_e32 v24, 0x3fc, v24                              // 0000001486D4: 363030FF 000003FC
	s_clause 0x7                                               // 0000001486DC: BF850007
	global_load_b32 v51, v21, s[8:9]                           // 0000001486E0: DC520000 33080015
	global_load_b32 v52, v22, s[8:9]                           // 0000001486E8: DC520000 34080016
	global_load_b32 v53, v26, s[8:9]                           // 0000001486F0: DC520000 3508001A
	global_load_b32 v54, v23, s[8:9]                           // 0000001486F8: DC520000 36080017
	global_load_b32 v55, v28, s[8:9]                           // 000000148700: DC520000 3708001C
	global_load_b32 v56, v29, s[8:9]                           // 000000148708: DC520000 3808001D
	global_load_b32 v57, v31, s[8:9]                           // 000000148710: DC520000 3908001F
	global_load_b32 v58, v24, s[8:9]                           // 000000148718: DC520000 3A080018
	s_waitcnt vmcnt(9)                                         // 000000148720: BF8927F7
	v_and_b32_e32 v25, 0xff, v50                               // 000000148724: 363264FF 000000FF
	v_bfe_u32 v27, v50, 7, 8                                   // 00000014872C: D610001B 02210F32
	v_bfe_u32 v30, v50, 14, 8                                  // 000000148734: D610001E 02211D32
	v_bfe_u32 v32, v50, 21, 8                                  // 00000014873C: D6100020 02212B32
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 000000148744: BF870214
	v_bcnt_u32_b32 v33, v25, 0                                 // 000000148748: D71E0021 00010119
	v_bcnt_u32_b32 v34, v27, 0                                 // 000000148750: D71E0022 0001011B
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 000000148758: BF870214
	v_bcnt_u32_b32 v35, v30, 0                                 // 00000014875C: D71E0023 0001011E
	v_bcnt_u32_b32 v36, v32, 0                                 // 000000148764: D71E0024 00010120
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000014876C: BF870214
	v_and_b32_e32 v21, 1, v33                                  // 000000148770: 362A4281
	v_and_b32_e32 v22, 1, v34                                  // 000000148774: 362C4481
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 000000148778: BF870214
	v_and_b32_e32 v23, 1, v35                                  // 00000014877C: 362E4681
	v_and_b32_e32 v24, 1, v36                                  // 000000148780: 36304881
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 000000148784: BF870214
	v_lshlrev_b32_e32 v21, 7, v21                              // 000000148788: 302A2A87
	v_lshlrev_b32_e32 v22, 7, v22                              // 00000014878C: 302C2C87
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 000000148790: BF870214
	v_lshlrev_b32_e32 v23, 7, v23                              // 000000148794: 302E2E87
	v_lshlrev_b32_e32 v24, 7, v24                              // 000000148798: 30303087
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000014879C: BF870214
	v_xor_b32_e32 v21, v21, v25                                // 0000001487A0: 3A2A3315
	v_xor_b32_e32 v22, v22, v27                                // 0000001487A4: 3A2C3716
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 0000001487A8: BF870214
	v_xor_b32_e32 v23, v23, v30                                // 0000001487AC: 3A2E3D17
	v_xor_b32_e32 v24, v24, v32                                // 0000001487B0: 3A304118
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 0000001487B4: BF870214
	v_mul_lo_u32 v21, 0x1010101, v21                           // 0000001487B8: D72C0015 00022AFF 01010101
	v_mul_lo_u32 v22, 0x1010101, v22                           // 0000001487C4: D72C0016 00022CFF 01010101
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 0000001487D0: BF870214
	v_mul_lo_u32 v23, 0x1010101, v23                           // 0000001487D4: D72C0017 00022EFF 01010101
	v_mul_lo_u32 v24, 0x1010101, v24                           // 0000001487E0: D72C0018 000230FF 01010101
	s_delay_alu instid0(VALU_DEP_4)                            // 0000001487EC: BF870004
	v_and_b32_e32 v25, 0x8040201, v21                          // 0000001487F0: 36322AFF 08040201
	v_lshrrev_b32_e32 v26, 18, v21                             // 0000001487F8: 32342A92
	v_bfe_i32 v27, v21, 0, 1                                   // 0000001487FC: D611001B 02050115
	v_and_b32_e32 v28, 0x80402010, v21                         // 000000148804: 36382AFF 80402010
	v_lshrrev_b32_e32 v21, 22, v21                             // 00000014880C: 322A2A96
	v_lshrrev_b32_e32 v43, 24, v25                             // 000000148810: 32563298
	v_and_b32_e32 v29, 0x8040201, v22                          // 000000148814: 363A2CFF 08040201
	v_lshrrev_b32_e32 v30, 18, v22                             // 00000014881C: 323C2C92
	v_bfe_i32 v31, v22, 0, 1                                   // 000000148820: D611001F 02050116
	v_and_b32_e32 v32, 0x80402010, v22                         // 000000148828: 36402CFF 80402010
	v_lshrrev_b32_e32 v22, 22, v22                             // 000000148830: 322C2C96
	v_and_b32_e32 v33, 0x8040201, v23                          // 000000148834: 36422EFF 08040201
	v_lshrrev_b32_e32 v34, 18, v23                             // 00000014883C: 32442E92
	v_bfe_i32 v35, v23, 0, 1                                   // 000000148840: D6110023 02050117
	v_and_b32_e32 v36, 0x80402010, v23                         // 000000148848: 36482EFF 80402010
	v_lshrrev_b32_e32 v37, 22, v23                             // 000000148850: 324A2E96
	v_and_b32_e32 v38, 0x8040201, v24                          // 000000148854: 364C30FF 08040201
	v_lshrrev_b32_e32 v39, 18, v24                             // 00000014885C: 324E3092
	v_bfe_i32 v40, v24, 0, 1                                   // 000000148860: D6110028 02050118
	v_and_b32_e32 v41, 0x80402010, v24                         // 000000148868: 365230FF 80402010
	v_lshrrev_b32_e32 v42, 22, v24                             // 000000148870: 32543096
	v_lshrrev_b16 v17.h, 8, v25.l op_sel:[0,0,1]               // 000000148874: D7394011 00023288
	v_cmp_ne_u16_e32 vcc_lo, 0, v43.l                          // 00000014887C: 7C7A5680
	v_mov_b16_e32 v18.l, v27.l                                 // 000000148880: 7E24391B
	v_lshrrev_b32_e32 v27, 24, v28                             // 000000148884: 32363898
	v_bfe_i32 v44, v21, 0, 1                                   // 000000148888: D611002C 02050115
	v_lshrrev_b32_e32 v59, 24, v29                             // 000000148890: 32763A98
	v_lshrrev_b16 v20.l, 8, v29.l                              // 000000148894: D7390014 00023A88
	v_bfe_i32 v29, v30, 0, 1                                   // 00000014889C: D611001D 0205011E
	v_mov_b16_e32 v21.l, v31.l                                 // 0000001488A4: 7E2A391F
	v_lshrrev_b32_e32 v30, 24, v32                             // 0000001488A8: 323C4098
	v_lshrrev_b16 v21.h, 8, v32.l op_sel:[0,0,1]               // 0000001488AC: D7394015 00024088
	v_lshrrev_b16 v31.l, 4, v32.l                              // 0000001488B4: D739001F 00024084
	v_bfe_i32 v32, v22, 0, 1                                   // 0000001488BC: D6110020 02050116
	v_lshrrev_b32_e32 v60, 24, v33                             // 0000001488C4: 32784298
	v_lshrrev_b16 v22.l, 8, v33.l                              // 0000001488C8: D7390016 00024288
	v_bfe_i32 v33, v34, 0, 1                                   // 0000001488D0: D6110021 02050122
	v_mov_b16_e32 v23.l, v35.l                                 // 0000001488D8: 7E2E3923
	v_lshrrev_b32_e32 v34, 24, v36                             // 0000001488DC: 32444898
	v_lshrrev_b16 v22.h, 8, v36.l op_sel:[0,0,1]               // 0000001488E0: D7394016 00024888
	v_lshrrev_b16 v35.l, 4, v36.l                              // 0000001488E8: D7390023 00024884
	v_bfe_i32 v36, v37, 0, 1                                   // 0000001488F0: D6110024 02050125
	v_lshrrev_b32_e32 v37, 24, v38                             // 0000001488F8: 324A4C98
	v_lshrrev_b16 v23.h, 8, v38.l op_sel:[0,0,1]               // 0000001488FC: D7394017 00024C88
	v_bfe_i32 v38, v39, 0, 1                                   // 000000148904: D6110026 02050127
	v_mov_b16_e32 v24.l, v40.l                                 // 00000014890C: 7E303928
	v_lshrrev_b32_e32 v39, 24, v41                             // 000000148910: 324E5298
	v_lshrrev_b16 v24.h, 8, v41.l op_sel:[0,0,1]               // 000000148914: D7394018 00025288
	v_lshrrev_b16 v40.l, 4, v41.l                              // 00000014891C: D7390028 00025284
	v_bfe_i32 v41, v42, 0, 1                                   // 000000148924: D6110029 0205012A
	v_cndmask_b32_e64 v42, 0, -1, vcc_lo                       // 00000014892C: D501002A 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v17.h                          // 000000148934: 7C7B2280
	v_lshrrev_b16 v19.l, 8, v28.l                              // 000000148938: D7390013 00023888
	v_bfe_i32 v25, v26, 0, 1                                   // 000000148940: D6110019 0205011A
	v_and_b16 v25.h, 0xff, v18.l op_sel:[0,0,1]                // 000000148948: D7624019 000224FF 000000FF
	v_lshlrev_b16 v26.l, 8, v18.l                              // 000000148954: D738001A 00022488
	v_cndmask_b32_e64 v43, 0, -1, vcc_lo                       // 00000014895C: D501002B 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v27.l                          // 000000148964: 7C7A3680
	v_mov_b16_e32 v18.l, v44.l                                 // 000000148968: 7E24392C
	v_lshrrev_b16 v28.l, 4, v28.l                              // 00000014896C: D739001C 00023884
	v_bfe_i32 v66, v31, 0, 1                                   // 000000148974: D6110042 0205011F
	v_mov_b16_e32 v27.l, v33.l                                 // 00000014897C: 7E363921
	v_cndmask_b32_e64 v44, 0, -1, vcc_lo                       // 000000148980: D501002C 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v19.l                          // 000000148988: 7C7A2680
	v_bfe_i32 v62, v28, 0, 1                                   // 00000014898C: D611003E 0205011C
	v_mov_b16_e32 v19.l, v29.l                                 // 000000148994: 7E26391D
	v_mov_b16_e32 v29.l, v42.l                                 // 000000148998: 7E3A392A
	v_and_b16 v17.h, 0xff, v25.l op_sel:[0,0,1]                // 00000014899C: D7624011 000232FF 000000FF
	v_cndmask_b32_e64 v61, 0, -1, vcc_lo                       // 0000001489A8: D501003D 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v59.l                          // 0000001489B0: 7C7A7680
	v_mov_b16_e32 v31.l, v44.l                                 // 0000001489B4: 7E3E392C
	v_mov_b16_e32 v33.l, v62.l                                 // 0000001489B8: 7E42393E
	v_lshlrev_b16 v27.h, 8, v18.l op_sel:[0,0,1]               // 0000001489BC: D738401B 00022488
	v_lshlrev_b16 v29.l, 8, v29.l                              // 0000001489C4: D738001D 00023A88
	v_cndmask_b32_e64 v59, 0, -1, vcc_lo                       // 0000001489CC: D501003B 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v20.l                          // 0000001489D4: 7C7A2880
	v_mov_b16_e32 v20.l, v32.l                                 // 0000001489D8: 7E283920
	v_mov_b16_e32 v32.l, v61.l                                 // 0000001489DC: 7E40393D
	v_and_b16 v28.h, 0xff, v19.l op_sel:[0,0,1]                // 0000001489E0: D762401C 000226FF 000000FF
	v_lshlrev_b16 v29.h, 8, v19.l op_sel:[0,0,1]               // 0000001489EC: D738401D 00022688
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo                       // 0000001489F4: D501003F 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v30.l                          // 0000001489FC: 7C7A3C80
	v_mov_b16_e32 v30.l, v43.l                                 // 000000148A00: 7E3C392B
	v_lshlrev_b16 v31.l, 8, v31.l                              // 000000148A04: D738001F 00023E88
	v_lshlrev_b16 v32.l, 8, v32.l                              // 000000148A0C: D7380020 00024088
	v_and_b16 v36.h, 0xff, v33.l op_sel:[0,0,1]                // 000000148A14: D7624024 000242FF 000000FF
	v_cndmask_b32_e64 v64, 0, -1, vcc_lo                       // 000000148A20: D5010040 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.h                          // 000000148A28: 7C7B2A80
	v_lshlrev_b16 v30.l, 8, v30.l                              // 000000148A2C: D738001E 00023C88
	v_or_b16 v17.h, v17.h, v29.l op_sel:[1,0,1]                // 000000148A34: D7634811 00023B11
	v_and_b16 v26.h, 0xff, v21.l op_sel:[0,0,1]                // 000000148A3C: D762401A 00022AFF 000000FF
	v_mov_b16_e32 v19.l, v64.l                                 // 000000148A48: 7E263940
	v_cndmask_b32_e64 v65, 0, -1, vcc_lo                       // 000000148A4C: D5010041 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v60.l                          // 000000148A54: 7C7A7880
	v_and_b16 v21.h, 0xff, v23.l op_sel:[0,0,1]                // 000000148A58: D7624015 00022EFF 000000FF
	v_bfe_i32 v70, v35, 0, 1                                   // 000000148A64: D6110046 02050123
	v_bfe_i32 v75, v40, 0, 1                                   // 000000148A6C: D611004B 02050128
	v_and_b16 v30.h, 0xff, v20.l op_sel:[0,0,1]                // 000000148A74: D762401E 000228FF 000000FF
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo                       // 000000148A80: D501003C 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v22.l                          // 000000148A88: 7C7A2C80
	v_lshlrev_b16 v22.l, 8, v23.l                              // 000000148A8C: D7380016 00022E88
	v_mov_b16_e32 v23.l, v36.l                                 // 000000148A94: 7E2E3924
	v_mov_b16_e32 v35.l, v65.l                                 // 000000148A98: 7E463941
	v_mov_b16_e32 v36.l, v66.l                                 // 000000148A9C: 7E483942
	v_cndmask_b32_e64 v67, 0, -1, vcc_lo                       // 000000148AA0: D5010043 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v34.l                          // 000000148AA8: 7C7A4480
	v_mov_b16_e32 v34.l, v63.l                                 // 000000148AAC: 7E44393F
	v_lshlrev_b16 v31.h, 8, v20.l op_sel:[0,0,1]               // 000000148AB0: D738401F 00022888
	v_mov_b16_e32 v20.l, v60.l                                 // 000000148AB8: 7E28393C
	v_lshlrev_b16 v38.h, 8, v19.l op_sel:[0,0,1]               // 000000148ABC: D7384026 00022688
	v_cndmask_b32_e64 v68, 0, -1, vcc_lo                       // 000000148AC4: D5010044 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v22.h                          // 000000148ACC: 7C7B2C80
	v_lshlrev_b16 v34.l, 8, v34.l                              // 000000148AD0: D7380022 00024488
	v_or_b16 v19.l, v36.h, v32.l op_sel:[1,0,0]                // 000000148AD8: D7630813 00024124
	v_mov_b16_e32 v45.l, v75.l                                 // 000000148AE0: 7E5A394B
	v_lshlrev_b16 v35.l, 8, v35.l                              // 000000148AE4: D7380023 00024688
	v_cndmask_b32_e64 v69, 0, -1, vcc_lo                       // 000000148AEC: D5010045 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v37.l                          // 000000148AF4: 7C7A4A80
	v_mov_b16_e32 v37.l, v67.l                                 // 000000148AF8: 7E4A3943
	v_and_b16 v39.h, 0xff, v36.l op_sel:[0,0,1]                // 000000148AFC: D7624027 000248FF 000000FF
	v_lshlrev_b16 v40.h, 8, v20.l op_sel:[0,0,1]               // 000000148B08: D7384028 00022888
	v_or_b16 v20.l, v26.h, v34.l op_sel:[1,0,0]                // 000000148B10: D7630814 0002451A
	v_cndmask_b32_e64 v71, 0, -1, vcc_lo                       // 000000148B18: D5010047 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v23.h                          // 000000148B20: 7C7B2E80
	v_mov_b16_e32 v28.l, v38.l                                 // 000000148B24: 7E383926
	v_and_b16 v32.h, 0xff, v27.l op_sel:[0,0,1]                // 000000148B28: D7624020 000236FF 000000FF
	v_mov_b16_e32 v38.l, v68.l                                 // 000000148B34: 7E4C3944
	v_mov_b16_e32 v40.l, v70.l                                 // 000000148B38: 7E503946
	v_cndmask_b32_e64 v72, 0, -1, vcc_lo                       // 000000148B3C: D5010048 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v39.l                          // 000000148B44: 7C7A4E80
	v_mov_b16_e32 v39.l, v69.l                                 // 000000148B48: 7E4E3945
	v_lshlrev_b16 v37.l, 8, v37.l                              // 000000148B4C: D7380025 00024A88
	v_and_b16 v43.h, 0xff, v45.l op_sel:[0,0,1]                // 000000148B54: D762402B 00025AFF 000000FF
	v_and_b16 v22.h, 0xff, v24.l op_sel:[0,0,1]                // 000000148B60: D7624016 000230FF 000000FF
	v_cndmask_b32_e64 v73, 0, -1, vcc_lo                       // 000000148B6C: D5010049 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v24.h                          // 000000148B74: 7C7B3080
	v_lshlrev_b16 v24.h, 8, v25.l op_sel:[0,0,1]               // 000000148B78: D7384018 00023288
	v_and_b16 v25.l, 0xff, v18.l                               // 000000148B80: D7620019 000224FF 000000FF
	v_mov_b16_e32 v18.l, v59.l                                 // 000000148B8C: 7E24393B
	v_mov_b16_e32 v43.l, v73.l                                 // 000000148B90: 7E563949
	v_cndmask_b32_e64 v74, 0, -1, vcc_lo                       // 000000148B94: D501004A 01A98280
	v_lshlrev_b16 v23.h, 8, v24.l op_sel:[0,0,1]               // 000000148B9C: D7384017 00023088
	v_mov_b16_e32 v24.l, v41.l                                 // 000000148BA4: 7E303929
	v_lshlrev_b16 v37.h, 8, v18.l op_sel:[0,0,1]               // 000000148BA8: D7384025 00022488
	v_or_b16 v18.l, v25.h, v30.l op_sel:[1,0,0]                // 000000148BB0: D7630812 00023D19
	v_mov_b16_e32 v44.l, v74.l                                 // 000000148BB8: 7E58394A
	v_lshlrev_b16 v42.h, 8, v43.l op_sel:[0,0,1]               // 000000148BBC: D738402A 00025688
	v_and_b16 v33.h, 0xff, v23.l op_sel:[0,0,1]                // 000000148BC4: D7624021 00022EFF 000000FF
	v_mov_b16_e32 v41.l, v71.l                                 // 000000148BD0: 7E523947
	v_or_b32_e32 v18, v18, v17                                 // 000000148BD4: 38242312
	v_or_b16 v17.h, v25.l, v31.l op_sel:[0,0,1]                // 000000148BD8: D7634011 00023F19
	v_lshlrev_b16 v43.l, 8, v44.l                              // 000000148BE0: D738002B 00025888
	v_lshlrev_b16 v44.l, 8, v45.l                              // 000000148BE8: D738002C 00025A88
	v_or_b16 v45.l, v39.h, v35.l op_sel:[1,0,0]                // 000000148BF0: D763082D 00024727
	v_mov_b16_e32 v42.l, v72.l                                 // 000000148BF8: 7E543948
	v_or_b32_e32 v19, v19, v17                                 // 000000148BFC: 38262313
	v_or_b16 v17.h, v28.h, v37.h op_sel:[1,1,1]                // 000000148C00: D7635811 00024B1C
	v_lshlrev_b16 v38.l, 8, v38.l                              // 000000148C08: D7380026 00024C88
	v_lshlrev_b16 v39.l, 8, v39.l                              // 000000148C10: D7380027 00024E88
	v_and_b16 v41.h, 0xff, v40.l op_sel:[0,0,1]                // 000000148C18: D7624029 000250FF 000000FF
	v_or_b16 v46.l, v21.h, v37.l op_sel:[1,0,0]                // 000000148C24: D763082E 00024B15
	v_or_b32_e32 v20, v20, v17                                 // 000000148C2C: 38282314
	v_or_b16 v17.h, v30.h, v38.h op_sel:[1,1,1]                // 000000148C30: D7635811 00024D1E
	v_and_b16 v34.h, 0xff, v28.l op_sel:[0,0,1]                // 000000148C38: D7624022 000238FF 000000FF
	v_lshlrev_b16 v41.l, 8, v41.l                              // 000000148C44: D7380029 00025288
	v_lshlrev_b16 v42.l, 8, v42.l                              // 000000148C4C: D738002A 00025488
	v_or_b16 v47.l, v41.h, v39.l op_sel:[1,0,0]                // 000000148C54: D763082F 00024F29
	v_or_b32_e32 v25, v45, v17                                 // 000000148C5C: 3832232D
	v_or_b16 v17.h, v32.h, v40.h op_sel:[1,1,1]                // 000000148C60: D7635811 00025120
	v_and_b16 v35.h, 0xff, v24.l op_sel:[0,0,1]                // 000000148C68: D7624023 000230FF 000000FF
	v_or_b16 v48.l, v22.h, v42.l op_sel:[1,0,0]                // 000000148C74: D7630830 00025516
	v_or_b16 v49.l, v43.h, v43.l op_sel:[1,0,0]                // 000000148C7C: D7630831 0002572B
	v_lshlrev_b16 v33.l, 8, v33.l                              // 000000148C84: D7380021 00024288
	v_or_b32_e32 v45, v46, v17                                 // 000000148C8C: 385A232E
	v_or_b16 v17.h, v33.h, v38.l op_sel:[1,0,1]                // 000000148C90: D7634811 00024D21
	v_lshlrev_b16 v21.l, 8, v21.l                              // 000000148C98: D7380015 00022A88
	v_lshlrev_b16 v36.l, 8, v36.l                              // 000000148CA0: D7380024 00024888
	v_lshlrev_b16 v27.l, 8, v27.l                              // 000000148CA8: D738001B 00023688
	v_lshlrev_b16 v23.l, 8, v23.l                              // 000000148CB0: D7380017 00022E88
	v_or_b32_e32 v46, v47, v17                                 // 000000148CB8: 385C232F
	v_or_b16 v17.h, v34.h, v41.l op_sel:[1,0,1]                // 000000148CBC: D7634811 00025322
	v_lshlrev_b16 v40.l, 8, v40.l                              // 000000148CC4: D7380028 00025088
	v_lshlrev_b16 v28.l, 8, v28.l                              // 000000148CCC: D738001C 00023888
	v_lshlrev_b16 v24.l, 8, v24.l                              // 000000148CD4: D7380018 00023088
	v_add_co_u32 v8, vcc_lo, 0x480, v8                         // 000000148CDC: D7006A08 000210FF 00000480
	v_or_b32_e32 v47, v48, v17                                 // 000000148CE8: 385E2330
	v_or_b16 v17.h, v35.h, v42.h op_sel:[1,1,1]                // 000000148CEC: D7635811 00025523
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo                // 000000148CF4: D5207C09 01AA1280
	s_delay_alu instid0(VALU_DEP_2)                            // 000000148CFC: BF870002
	v_or_b32_e32 v17, v49, v17                                 // 000000148D00: 38222331
	s_waitcnt vmcnt(7)                                         // 000000148D04: BF891FF7
	v_xor_b32_e32 v18, v51, v18                                // 000000148D08: 3A242533
	s_waitcnt vmcnt(6)                                         // 000000148D0C: BF891BF7
	v_xor_b32_e32 v48, v52, v19                                // 000000148D10: 3A602734
	s_waitcnt vmcnt(5)                                         // 000000148D14: BF8917F7
	v_xor_b32_e32 v49, v53, v20                                // 000000148D18: 3A622935
	s_waitcnt vmcnt(4)                                         // 000000148D1C: BF8913F7
	v_xor_b32_e32 v51, v54, v25                                // 000000148D20: 3A663336
	s_waitcnt vmcnt(3)                                         // 000000148D24: BF890FF7
	v_xor_b32_e32 v45, v55, v45                                // 000000148D28: 3A5A5B37
	s_waitcnt vmcnt(2)                                         // 000000148D2C: BF890BF7
	v_xor_b32_e32 v46, v56, v46                                // 000000148D30: 3A5C5D38
	v_and_b16 v19.l, 0xff00, v48.l                             // 000000148D34: D7620013 000260FF FFFFFF00
	s_waitcnt vmcnt(0)                                         // 000000148D40: BF8903F7
	v_xor_b32_e32 v52, v58, v17                                // 000000148D44: 3A68233A
	v_and_b16 v17.l, 0xff00, v18.l                             // 000000148D48: D7620011 000224FF FFFFFF00
	v_lshlrev_b16 v17.h, 8, v18.l op_sel:[0,0,1]               // 000000148D54: D7384011 00022488
	v_and_b16 v18.l, 0xff00, v18.h op_sel:[0,1,0]              // 000000148D5C: D7621012 000224FF FFFFFF00
	v_lshlrev_b16 v18.h, 8, v18.h op_sel:[0,1,1]               // 000000148D68: D7385012 00022488
	v_lshlrev_b16 v19.h, 8, v48.l op_sel:[0,0,1]               // 000000148D70: D7384013 00026088
	v_and_b16 v20.l, 0xff00, v48.h op_sel:[0,1,0]              // 000000148D78: D7621014 000260FF FFFFFF00
	v_lshlrev_b16 v20.h, 8, v48.h op_sel:[0,1,1]               // 000000148D84: D7385014 00026088
	v_and_b16 v26.h, 0xff00, v51.l op_sel:[0,0,1]              // 000000148D8C: D762401A 000266FF FFFFFF00
	v_sub_nc_i16 v17.l, v17.l, v30.l clamp                     // 000000148D98: D70E8011 00023D11
	v_sub_nc_i16 v26.l, v17.h, v26.l op_sel:[1,0,0] clamp      // 000000148DA0: D70E881A 00023511
	v_sub_nc_i16 v18.l, v18.l, v29.l clamp                     // 000000148DA8: D70E8012 00023B12
	v_sub_nc_i16 v29.l, v18.h, v24.h op_sel:[1,1,0] clamp      // 000000148DB0: D70E981D 00023112
	v_and_b16 v21.h, 0xff00, v49.l op_sel:[0,0,1]              // 000000148DB8: D7624015 000262FF FFFFFF00
	v_lshlrev_b16 v22.h, 8, v49.l op_sel:[0,0,1]               // 000000148DC4: D7384016 00026288
	v_and_b16 v25.l, 0xff00, v49.h op_sel:[0,1,0]              // 000000148DCC: D7621019 000262FF FFFFFF00
	v_lshlrev_b16 v25.h, 8, v49.h op_sel:[0,1,1]               // 000000148DD8: D7385019 00026288
	v_and_b16 v30.h, 0xff00, v51.h op_sel:[0,1,1]              // 000000148DE0: D762501E 000266FF FFFFFF00
	v_sub_nc_i16 v19.l, v19.l, v32.l clamp                     // 000000148DEC: D70E8013 00024113
	v_sub_nc_i16 v30.l, v19.h, v33.l op_sel:[1,0,0] clamp      // 000000148DF4: D70E881E 00024313
	v_sub_nc_i16 v20.l, v20.l, v31.l clamp                     // 000000148DFC: D70E8014 00023F14
	v_sub_nc_i16 v31.l, v20.h, v27.h op_sel:[1,1,0] clamp      // 000000148E04: D70E981F 00023714
	v_perm_b32 v17, v26, v17, 0xc0c0105                        // 000000148E0C: D6440011 03FE231A 0C0C0105
	v_perm_b32 v18, v29, v18, 0xc0c0105                        // 000000148E18: D6440012 03FE251D 0C0C0105
	v_lshlrev_b16 v28.h, 8, v51.l op_sel:[0,0,1]               // 000000148E24: D738401C 00026688
	v_lshlrev_b16 v32.h, 8, v51.h op_sel:[0,1,1]               // 000000148E2C: D7385020 00026688
	v_and_b16 v33.h, 0xff00, v45.l op_sel:[0,0,1]              // 000000148E34: D7624021 00025AFF FFFFFF00
	v_sub_nc_i16 v32.l, v21.h, v34.l op_sel:[1,0,0] clamp      // 000000148E40: D70E8820 00024515
	v_sub_nc_i16 v21.l, v22.h, v21.l op_sel:[1,0,0] clamp      // 000000148E48: D70E8815 00022B16
	v_sub_nc_i16 v25.l, v25.l, v37.h op_sel:[0,1,0] clamp      // 000000148E50: D70E9019 00024B19
	v_sub_nc_i16 v33.l, v25.h, v29.h op_sel:[1,1,0] clamp      // 000000148E58: D70E9821 00023B19
	v_perm_b32 v19, v30, v19, 0xc0c0105                        // 000000148E60: D6440013 03FE271E 0C0C0105
	v_perm_b32 v20, v31, v20, 0xc0c0105                        // 000000148E6C: D6440014 03FE291F 0C0C0105
	v_lshl_or_b32 v17, v18, 16, v17                            // 000000148E78: D6560011 04452112
	v_lshlrev_b16 v34.h, 8, v45.l op_sel:[0,0,1]               // 000000148E80: D7384022 00025A88
	v_and_b16 v35.h, 0xff00, v45.h op_sel:[0,1,1]              // 000000148E88: D7625023 00025AFF FFFFFF00
	v_lshlrev_b16 v36.h, 8, v45.h op_sel:[0,1,1]               // 000000148E94: D7385024 00025A88
	v_sub_nc_i16 v34.l, v26.h, v35.l op_sel:[1,0,0] clamp      // 000000148E9C: D70E8822 0002471A
	v_sub_nc_i16 v35.l, v28.h, v36.l op_sel:[1,0,0] clamp      // 000000148EA4: D70E8823 0002491C
	v_sub_nc_i16 v36.l, v30.h, v38.h op_sel:[1,1,0] clamp      // 000000148EAC: D70E9824 00024D1E
	v_sub_nc_i16 v49.l, v32.h, v31.h op_sel:[1,1,0] clamp      // 000000148EB4: D70E9831 00023F20
	v_perm_b32 v18, v21, v32, 0xc0c0105                        // 000000148EBC: D6440012 03FE4115 0C0C0105
	v_perm_b32 v21, v33, v25, 0xc0c0105                        // 000000148EC8: D6440015 03FE3321 0C0C0105
	v_lshl_or_b32 v19, v20, 16, v19                            // 000000148ED4: D6560013 044D2114
	v_dot4_i32_iu8 v1, v17, v1, 0 neg_lo:[1,1,0]               // 000000148EDC: CC164001 7A020311
	v_xor_b32_e32 v47, v57, v47                                // 000000148EE4: 3A5E5F39
	v_and_b16 v39.h, 0xff00, v46.l op_sel:[0,0,1]              // 000000148EE8: D7624027 00025CFF FFFFFF00
	v_lshlrev_b16 v41.h, 8, v46.l op_sel:[0,0,1]               // 000000148EF4: D7384029 00025C88
	v_and_b16 v43.h, 0xff00, v46.h op_sel:[0,1,1]              // 000000148EFC: D762502B 00025CFF FFFFFF00
	v_lshlrev_b16 v44.h, 8, v46.h op_sel:[0,1,1]               // 000000148F08: D738502C 00025C88
	v_sub_nc_i16 v37.l, v33.h, v37.l op_sel:[1,0,0] clamp      // 000000148F10: D70E8825 00024B21
	v_sub_nc_i16 v22.l, v34.h, v22.l op_sel:[1,0,0] clamp      // 000000148F18: D70E8816 00022D22
	v_sub_nc_i16 v51.l, v35.h, v40.h op_sel:[1,1,0] clamp      // 000000148F20: D70E9833 00025123
	v_sub_nc_i16 v27.l, v36.h, v27.l op_sel:[1,0,0] clamp      // 000000148F28: D70E881B 00023724
	v_perm_b32 v17, v35, v34, 0xc0c0105                        // 000000148F30: D6440011 03FE4523 0C0C0105
	v_perm_b32 v20, v49, v36, 0xc0c0105                        // 000000148F3C: D6440014 03FE4931 0C0C0105
	v_lshl_or_b32 v18, v21, 16, v18                            // 000000148F48: D6560012 04492115
	v_dot4_i32_iu8 v1, v19, v2, v1 neg_lo:[1,1,0]              // 000000148F50: CC164001 7C060513
	v_and_b16 v45.l, 0xff00, v47.l                             // 000000148F58: D762002D 00025EFF FFFFFF00
	v_lshlrev_b16 v45.h, 8, v47.l op_sel:[0,0,1]               // 000000148F64: D738402D 00025E88
	v_and_b16 v46.l, 0xff00, v47.h op_sel:[0,1,0]              // 000000148F6C: D762102E 00025EFF FFFFFF00
	v_lshlrev_b16 v46.h, 8, v47.h op_sel:[0,1,1]               // 000000148F78: D738502E 00025E88
	v_sub_nc_i16 v39.l, v39.h, v39.l op_sel:[1,0,0] clamp      // 000000148F80: D70E8827 00024F27
	v_sub_nc_i16 v40.l, v41.h, v40.l op_sel:[1,0,0] clamp      // 000000148F88: D70E8828 00025129
	v_sub_nc_i16 v38.l, v43.h, v38.l op_sel:[1,0,0] clamp      // 000000148F90: D70E8826 00024D2B
	v_sub_nc_i16 v23.l, v44.h, v23.l op_sel:[1,0,0] clamp      // 000000148F98: D70E8817 00022F2C
	v_perm_b32 v2, v22, v37, 0xc0c0105                         // 000000148FA0: D6440002 03FE4B16 0C0C0105
	v_perm_b32 v19, v27, v51, 0xc0c0105                        // 000000148FAC: D6440013 03FE671B 0C0C0105
	v_lshl_or_b32 v17, v20, 16, v17                            // 000000148FB8: D6560011 04452114
	v_dot4_i32_iu8 v1, v18, v3, v1 neg_lo:[1,1,0]              // 000000148FC0: CC164001 7C060712
	v_and_b16 v47.l, 0xff00, v52.l                             // 000000148FC8: D762002F 000268FF FFFFFF00
	v_lshlrev_b16 v47.h, 8, v52.l op_sel:[0,0,1]               // 000000148FD4: D738402F 00026888
	v_and_b16 v48.l, 0xff00, v52.h op_sel:[0,1,0]              // 000000148FDC: D7621030 000268FF FFFFFF00
	v_lshlrev_b16 v48.h, 8, v52.h op_sel:[0,1,1]               // 000000148FE8: D7385030 00026888
	v_sub_nc_i16 v42.l, v45.l, v42.l clamp                     // 000000148FF0: D70E802A 0002552D
	v_sub_nc_i16 v45.l, v45.h, v23.h op_sel:[1,1,0] clamp      // 000000148FF8: D70E982D 00022F2D
	v_sub_nc_i16 v41.l, v46.l, v41.l clamp                     // 000000149000: D70E8029 0002532E
	v_sub_nc_i16 v28.l, v46.h, v28.l op_sel:[1,0,0] clamp      // 000000149008: D70E881C 0002392E
	v_perm_b32 v3, v40, v39, 0xc0c0105                         // 000000149010: D6440003 03FE4F28 0C0C0105
	v_perm_b32 v18, v23, v38, 0xc0c0105                        // 00000014901C: D6440012 03FE4D17 0C0C0105
	v_lshl_or_b32 v2, v19, 16, v2                              // 000000149028: D6560002 04092113
	v_dot4_i32_iu8 v1, v17, v4, v1 neg_lo:[1,1,0]              // 000000149030: CC164001 7C060911
	v_sub_nc_i16 v43.l, v47.l, v43.l clamp                     // 000000149038: D70E802B 0002572F
	v_sub_nc_i16 v44.l, v47.h, v44.l op_sel:[1,0,0] clamp      // 000000149040: D70E882C 0002592F
	v_sub_nc_i16 v46.l, v48.l, v42.h op_sel:[0,1,0] clamp      // 000000149048: D70E902E 00025530
	v_sub_nc_i16 v24.l, v48.h, v24.l op_sel:[1,0,0] clamp      // 000000149050: D70E8818 00023130
	v_perm_b32 v4, v45, v42, 0xc0c0105                         // 000000149058: D6440004 03FE552D 0C0C0105
	v_perm_b32 v17, v28, v41, 0xc0c0105                        // 000000149064: D6440011 03FE531C 0C0C0105
	v_lshl_or_b32 v3, v18, 16, v3                              // 000000149070: D6560003 040D2112
	v_dot4_i32_iu8 v1, v2, v5, v1 neg_lo:[1,1,0]               // 000000149078: CC164001 7C060B02
	v_perm_b32 v2, v44, v43, 0xc0c0105                         // 000000149080: D6440002 03FE572C 0C0C0105
	v_perm_b32 v5, v24, v46, 0xc0c0105                         // 00000014908C: D6440005 03FE5D18 0C0C0105
	v_lshl_or_b32 v4, v17, 16, v4                              // 000000149098: D6560004 04112111
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)// 0000001490A0: BF870194
	v_dot4_i32_iu8 v1, v3, v6, v1 neg_lo:[1,1,0]               // 0000001490A4: CC164001 7C060D03
	v_lshl_or_b32 v2, v5, 16, v2                               // 0000001490AC: D6560002 04092105
	v_lshrrev_b32_e32 v5, 28, v50                              // 0000001490B4: 320A649C
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000001490B8: BF870093
	v_dot4_i32_iu8 v1, v4, v7, v1 neg_lo:[1,1,0]               // 0000001490BC: CC164001 7C060F04
	v_dot4_i32_iu8 v4, v2, v16, v1 neg_lo:[1,1,0]              // 0000001490C4: CC164004 7C062102
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000001490CC: BF870091
	v_lshrrev_b32_e32 v1, 31, v4                               // 0000001490D0: 3202089F
	v_add_nc_u32_e32 v1, v4, v1                                // 0000001490D4: 4A020304
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000001490D8: BF870091
	v_ashrrev_i32_e32 v1, 1, v1                                // 0000001490DC: 34020281
	v_mad_u64_u32 v[2:3], null, v4, v5, v[1:2]                 // 0000001490E0: D6FE7C02 04060B04
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000001490E8: BF870091
	v_lshrrev_b32_e32 v1, 31, v2                               // 0000001490EC: 3202049F
	v_add_nc_u32_e32 v1, v2, v1                                // 0000001490F0: 4A020302
	v_cvt_f32_f16_e32 v2, v0.l                                 // 0000001490F4: 7E041700
	v_cvt_f32_f16_e32 v0, v0.h                                 // 0000001490F8: 7E001780
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 0000001490FC: BF870113
	v_ashrrev_i32_e32 v1, 1, v1                                // 000000149100: 34020281
	v_mul_f32_e32 v0, v0, v2                                   // 000000149104: 10000500
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000149108: BF870092
	v_cvt_f32_i32_e32 v1, v1                                   // 00000014910C: 7E020B01
	v_fmac_f32_e32 v12, v0, v1                                 // 000000149110: 56180300
	s_and_not1_b32 exec_lo, exec_lo, s11                       // 000000149114: 917E0B7E
	s_cbranch_execnz 64808                                     // 000000149118: BFA6FD28 <_ZL13mul_mat_vec_qIL9ggml_type18ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0x1bc>
	s_or_b32 exec_lo, exec_lo, s11                             // 00000014911C: 8C7E0B7E
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000149120: BF870009
	s_or_b32 exec_lo, exec_lo, s5                              // 000000149124: 8C7E057E
	s_waitcnt lgkmcnt(0)                                       // 000000149128: BF89FC07
	buffer_gl0_inv                                             // 00000014912C: E0AC0000 00000000
	s_mov_b32 s3, exec_lo                                      // 000000149134: BE83007E
	v_cmpx_eq_u32_e32 0, v11                                   // 000000149138: 7D941680
	s_cbranch_execz 65                                         // 00000014913C: BFA50041 <_ZL13mul_mat_vec_qIL9ggml_type18ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0xe44>
	v_mbcnt_lo_u32_b32 v0, -1, 0                               // 000000149140: D71F0000 000100C1
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 000000149148: BF8701B1
	v_xor_b32_e32 v1, 16, v0                                   // 00000014914C: 3A020090
	v_xor_b32_e32 v2, 8, v0                                    // 000000149150: 3A040088
	v_xor_b32_e32 v3, 4, v0                                    // 000000149154: 3A060084
	v_cmp_gt_i32_e32 vcc_lo, 32, v1                            // 000000149158: 7C8802A0
	v_cndmask_b32_e32 v1, v0, v1, vcc_lo                       // 00000014915C: 02020300
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_3) | instid1(VALU_DEP_1)// 000000149160: BF8700C4
	v_cmp_gt_i32_e32 vcc_lo, 32, v2                            // 000000149164: 7C8804A0
	v_cndmask_b32_e32 v2, v0, v2, vcc_lo                       // 000000149168: 02040500
	v_cmp_gt_i32_e32 vcc_lo, 32, v3                            // 00000014916C: 7C8806A0
	v_cndmask_b32_e32 v3, v0, v3, vcc_lo                       // 000000149170: 02060700
	v_lshlrev_b32_e32 v3, 2, v3                                // 000000149174: 30060682
	s_delay_alu instid0(VALU_DEP_4)                            // 000000149178: BF870004
	v_lshlrev_b32_e32 v2, 2, v2                                // 00000014917C: 30040482
	v_lshlrev_b32_e32 v1, 2, v1                                // 000000149180: 30020282
	ds_bpermute_b32 v1, v1, v12                                // 000000149184: DACC0000 01000C01
	s_waitcnt lgkmcnt(0)                                       // 00000014918C: BF89FC07
	v_add_f32_e32 v1, v12, v1                                  // 000000149190: 0602030C
	ds_bpermute_b32 v2, v2, v1                                 // 000000149194: DACC0000 02000102
	s_waitcnt lgkmcnt(0)                                       // 00000014919C: BF89FC07
	v_add_f32_e32 v1, v1, v2                                   // 0000001491A0: 06020501
	ds_bpermute_b32 v2, v3, v1                                 // 0000001491A4: DACC0000 02000103
	v_xor_b32_e32 v3, 2, v0                                    // 0000001491AC: 3A060082
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 0000001491B0: BF8700A1
	v_cmp_gt_i32_e32 vcc_lo, 32, v3                            // 0000001491B4: 7C8806A0
	v_cndmask_b32_e32 v3, v0, v3, vcc_lo                       // 0000001491B8: 02060700
	v_lshlrev_b32_e32 v3, 2, v3                                // 0000001491BC: 30060682
	s_waitcnt lgkmcnt(0)                                       // 0000001491C0: BF89FC07
	v_add_f32_e32 v1, v1, v2                                   // 0000001491C4: 06020501
	ds_bpermute_b32 v2, v3, v1                                 // 0000001491C8: DACC0000 02000103
	v_xor_b32_e32 v3, 1, v0                                    // 0000001491D0: 3A060081
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_2)// 0000001491D4: BF870141
	v_cmp_gt_i32_e32 vcc_lo, 32, v3                            // 0000001491D8: 7C8806A0
	v_cndmask_b32_e32 v0, v0, v3, vcc_lo                       // 0000001491DC: 02000700
	v_cmp_eq_u32_e32 vcc_lo, 0, v10                            // 0000001491E0: 7C941480
	s_waitcnt lgkmcnt(0)                                       // 0000001491E4: BF89FC07
	v_dual_add_f32 v0, v1, v2 :: v_dual_lshlrev_b32 v3, 2, v0  // 0000001491E8: C9220501 00020082
	ds_bpermute_b32 v1, v3, v0                                 // 0000001491F0: DACC0000 01000003
	s_and_b32 exec_lo, exec_lo, vcc_lo                         // 0000001491F8: 8B7E6A7E
	s_cbranch_execz 17                                         // 0000001491FC: BFA50011 <_ZL13mul_mat_vec_qIL9ggml_type18ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0xe44>
	s_load_b64 s[0:1], s[0:1], 0x48                            // 000000149200: F4040000 F8000048
	s_mul_i32 s3, s10, s6                                      // 000000149208: 9603060A
	s_waitcnt lgkmcnt(0)                                       // 00000014920C: BF89FC07
	v_dual_add_f32 v0, v0, v1 :: v_dual_mov_b32 v1, 0          // 000000149210: C9100300 00000080
	s_add_i32 s2, s3, s2                                       // 000000149218: 81020203
	s_mul_i32 s3, s14, s4                                      // 00000014921C: 9603040E
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)// 000000149220: BF8704A9
	s_add_i32 s2, s2, s3                                       // 000000149224: 81020302
	s_mov_b32 s3, 0                                            // 000000149228: BE830080
	s_lshl_b64 s[2:3], s[2:3], 2                               // 00000014922C: 84828202
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000149230: BF870009
	s_add_u32 s0, s0, s2                                       // 000000149234: 80000200
	s_addc_u32 s1, s1, s3                                      // 000000149238: 82010301
	global_store_b32 v1, v0, s[0:1]                            // 00000014923C: DC6A0000 00000001
	s_endpgm                                                   // 000000149244: BFB00000
		...
