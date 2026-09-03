
obj_mmvq.elf:	file format elf64-amdgpu

Disassembly of section .text:

00000000000cf200 <_ZL13mul_mat_vec_qIL9ggml_type8ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj>:
	s_clause 0x1                                               // 0000000CF200: BF850001
	s_load_b64 s[8:9], s[0:1], 0x10                            // 0000000CF204: F4040200 F8000010
	s_load_b128 s[16:19], s[0:1], 0x50                         // 0000000CF20C: F4080400 F8000050
	s_mov_b32 s6, s3                                           // 0000000CF214: BE860003
	s_waitcnt lgkmcnt(0)                                       // 0000000CF218: BF89FC07
	s_cmp_lg_u64 s[8:9], 0                                     // 0000000CF21C: BF118008
	s_cselect_b32 s5, -1, 0                                    // 0000000CF220: 980580C1
	s_cmp_eq_u64 s[8:9], 0                                     // 0000000CF224: BF108008
	s_cbranch_scc1 32                                          // 0000000CF228: BFA20020 <_ZL13mul_mat_vec_qIL9ggml_type8ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0xac>
	s_mov_b32 s7, 0                                            // 0000000CF22C: BE870080
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 0000000CF230: BF870499
	s_lshl_b64 s[10:11], s[6:7], 2                             // 0000000CF234: 848A8206
	s_add_u32 s8, s8, s10                                      // 0000000CF238: 80080A08
	s_addc_u32 s9, s9, s11                                     // 0000000CF23C: 82090B09
	s_load_b32 s3, s[8:9], null                                // 0000000CF240: F40000C4 F8000000
	s_clause 0x1                                               // 0000000CF248: BF850001
	s_load_b128 s[8:11], s[0:1], 0x78                          // 0000000CF24C: F4080200 F8000078
	s_load_b32 s20, s[0:1], 0x60                               // 0000000CF254: F4000500 F8000060
	s_cbranch_execnz 7                                         // 0000000CF25C: BFA60007 <_ZL13mul_mat_vec_qIL9ggml_type8ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0x7c>
	s_load_b64 s[12:13], s[0:1], 0x6c                          // 0000000CF260: F4040300 F800006C
	s_waitcnt lgkmcnt(0)                                       // 0000000CF268: BF89FC07
	s_mul_hi_u32 s3, s12, s6                                   // 0000000CF26C: 9683060C
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 0000000CF270: BF870499
	s_add_i32 s3, s6, s3                                       // 0000000CF274: 81030306
	s_lshr_b32 s3, s3, s13                                     // 0000000CF278: 85030D03
	s_load_b32 s21, s[0:1], 0x88                               // 0000000CF27C: F4000540 F8000088
	s_and_not1_b32 vcc_lo, exec_lo, s5                         // 0000000CF284: 916A057E
	s_cbranch_vccnz 14                                         // 0000000CF288: BFA4000E <_ZL13mul_mat_vec_qIL9ggml_type8ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0xc4>
	s_mul_hi_u32 s5, s17, s6                                   // 0000000CF28C: 96850611
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 0000000CF290: BF870499
	s_add_i32 s5, s6, s5                                       // 0000000CF294: 81050506
	s_lshr_b32 s5, s5, s18                                     // 0000000CF298: 85051205
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 0000000CF29C: BF870499
	s_mul_i32 s5, s5, s19                                      // 0000000CF2A0: 96051305
	s_sub_i32 s22, s6, s5                                      // 0000000CF2A4: 81960506
	s_branch 7                                                 // 0000000CF2A8: BFA00007 <_ZL13mul_mat_vec_qIL9ggml_type8ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0xc8>
	s_clause 0x1                                               // 0000000CF2AC: BF850001
	s_load_b128 s[8:11], s[0:1], 0x78                          // 0000000CF2B0: F4080200 F8000078
	s_load_b32 s20, s[0:1], 0x60                               // 0000000CF2B8: F4000500 F8000060
	s_branch 65511                                             // 0000000CF2C0: BFA0FFE7 <_ZL13mul_mat_vec_qIL9ggml_type8ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0x60>
	s_mov_b32 s22, s6                                          // 0000000CF2C4: BE960006
	s_load_b128 s[12:15], s[0:1], 0x90                         // 0000000CF2C8: F4080300 F8000090
	v_bfe_u32 v4, v0, 10, 10                                   // 0000000CF2D0: D6100004 02291500
	v_dual_mov_b32 v5, 0 :: v_dual_and_b32 v2, 0x3ff, v0       // 0000000CF2D8: CA240080 050200FF 000003FF
	s_lshr_b32 s5, s16, 5                                      // 0000000CF2E4: 85058510
	s_mov_b32 s7, exec_lo                                      // 0000000CF2E8: BE87007E
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 0000000CF2EC: BF870121
	v_lshl_add_u32 v0, v4, 5, v2                               // 0000000CF2F0: D6460000 04090B04
	v_lshlrev_b32_e32 v3, 2, v2                                // 0000000CF2F8: 30060482
	v_lshrrev_b32_e32 v6, 2, v0                                // 0000000CF2FC: 320C0082
	s_delay_alu instid0(VALU_DEP_1)                            // 0000000CF300: BF870001
	v_cmpx_gt_u32_e64 s5, v6                                   // 0000000CF304: D4CC007E 00020C05
	s_cbranch_execz 93                                         // 0000000CF30C: BFA5005D <_ZL13mul_mat_vec_qIL9ggml_type8ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0x284>
	s_load_b128 s[16:19], s[0:1], null                         // 0000000CF310: F4080400 F8000000
	s_waitcnt lgkmcnt(0)                                       // 0000000CF318: BF89FC07
	s_mul_hi_u32 s11, s11, s4                                  // 0000000CF31C: 968B040B
	s_mul_i32 s20, s20, s2                                     // 0000000CF320: 96140214
	s_add_i32 s11, s4, s11                                     // 0000000CF324: 810B0B04
	s_mul_i32 s13, s13, s4                                     // 0000000CF328: 960D040D
	s_lshr_b32 s11, s11, s21                                   // 0000000CF32C: 850B150B
	s_mul_i32 s8, s3, s8                                       // 0000000CF330: 96080803
	s_mul_i32 s11, s11, s12                                    // 0000000CF334: 960B0C0B
	s_mul_i32 s3, s22, s9                                      // 0000000CF338: 96030916
	s_add_i32 s11, s11, s20                                    // 0000000CF33C: 810B140B
	s_mul_hi_u32 s12, s13, 36                                  // 0000000CF340: 968CA40D
	s_add_i32 s8, s8, s11                                      // 0000000CF344: 81080B08
	s_mul_i32 s11, s13, 36                                     // 0000000CF348: 960BA40D
	v_lshrrev_b32_e32 v5, 2, v0                                // 0000000CF34C: 320A0082
	s_mul_hi_u32 s9, s3, 36                                    // 0000000CF350: 9689A403
	s_mul_i32 s3, s3, 36                                       // 0000000CF354: 9603A403
	v_and_b32_e32 v8, 12, v3                                   // 0000000CF358: 3610068C
	v_and_b32_e32 v7, 3, v2                                    // 0000000CF35C: 360E0483
	s_add_u32 s11, s18, s11                                    // 0000000CF360: 800B0B12
	s_addc_u32 s13, s19, s12                                   // 0000000CF364: 820D0C13
	s_add_u32 s12, s11, s3                                     // 0000000CF368: 800C030B
	s_addc_u32 s13, s13, s9                                    // 0000000CF36C: 820D090D
	v_lshlrev_b32_e32 v7, 3, v7                                // 0000000CF370: 300E0E83
	v_mad_u64_u32 v[0:1], null, v5, 36, s[12:13]               // 0000000CF374: D6FE7C00 00314905
	v_dual_mov_b32 v5, 0 :: v_dual_lshlrev_b32 v8, 1, v8       // 0000000CF37C: CA220080 05081081
	s_mov_b32 s9, 0                                            // 0000000CF384: BE890080
	s_set_inst_prefetch_distance 0x1                           // 0000000CF388: BF840001
	s_nop 0                                                    // 0000000CF38C: BF800000
	s_nop 0                                                    // 0000000CF390: BF800000
	s_nop 0                                                    // 0000000CF394: BF800000
	s_nop 0                                                    // 0000000CF398: BF800000
	s_nop 0                                                    // 0000000CF39C: BF800000
	s_nop 0                                                    // 0000000CF3A0: BF800000
	s_nop 0                                                    // 0000000CF3A4: BF800000
	s_nop 0                                                    // 0000000CF3A8: BF800000
	s_nop 0                                                    // 0000000CF3AC: BF800000
	s_nop 0                                                    // 0000000CF3B0: BF800000
	s_nop 0                                                    // 0000000CF3B4: BF800000
	s_nop 0                                                    // 0000000CF3B8: BF800000
	s_nop 0                                                    // 0000000CF3BC: BF800000
	v_add_nc_u32_e32 v13, s8, v6                               // 0000000CF3C0: 4A1A0C08
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000CF3C4: BF870093
	v_add_co_u32 v9, vcc_lo, v0, v7                            // 0000000CF3C8: D7006A09 00020F00
	v_add_co_ci_u32_e64 v10, null, 0, v1, vcc_lo               // 0000000CF3D0: D5207C0A 01AA0280
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_3) | instid1(VALU_DEP_1)// 0000000CF3D8: BF8700C3
	v_mad_i64_i32 v[11:12], null, v13, 34, s[16:17]            // 0000000CF3DC: D6FF7C0B 0041450D
	v_add_nc_u32_e32 v6, 64, v6                                // 0000000CF3E4: 4A0C0CC0
	global_load_b64 v[13:14], v[9:10], off offset:4            // 0000000CF3E8: DC560004 0D7C0009
	v_add_co_u32 v9, vcc_lo, v11, v8                           // 0000000CF3F0: D7006A09 0002110B
	v_add_co_ci_u32_e64 v10, null, 0, v12, vcc_lo              // 0000000CF3F8: D5207C0A 01AA1880
	v_cmp_le_u32_e32 vcc_lo, s5, v6                            // 0000000CF400: 7C960C05
	global_load_b32 v17, v[0:1], off                           // 0000000CF404: DC520000 117C0000
	s_clause 0x1                                               // 0000000CF40C: BF850001
	global_load_b64 v[15:16], v[9:10], off offset:2            // 0000000CF410: DC560002 0F7C0009
	global_load_d16_b16 v9, v[11:12], off                      // 0000000CF418: DC820000 097C000B
	v_add_co_u32 v0, s3, 0x900, v0                             // 0000000CF420: D7000300 000200FF 00000900
	s_delay_alu instid0(VALU_DEP_1)                            // 0000000CF42C: BF870001
	v_add_co_ci_u32_e64 v1, null, 0, v1, s3                    // 0000000CF430: D5207C01 000E0280
	s_or_b32 s9, vcc_lo, s9                                    // 0000000CF438: 8C09096A
	s_waitcnt vmcnt(2)                                         // 0000000CF43C: BF890BF7
	v_cvt_f32_f16_e32 v10, v17.l                               // 0000000CF440: 7E141711
	s_waitcnt vmcnt(1)                                         // 0000000CF444: BF8907F7
	v_dot4_i32_iu8 v11, v15, v13, 0 neg_lo:[1,1,0]             // 0000000CF448: CC16400B 7A021B0F
	s_waitcnt vmcnt(0)                                         // 0000000CF450: BF8903F7
	v_cvt_f32_f16_e32 v9, v9.l                                 // 0000000CF454: 7E121709
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 0000000CF458: BF870112
	v_dot4_i32_iu8 v11, v16, v14, v11 neg_lo:[1,1,0]           // 0000000CF45C: CC16400B 7C2E1D10
	v_mul_f32_e32 v9, v9, v10                                  // 0000000CF464: 10121509
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000CF468: BF870092
	v_cvt_f32_i32_e32 v10, v11                                 // 0000000CF46C: 7E140B0B
	v_fmac_f32_e32 v5, v9, v10                                 // 0000000CF470: 560A1509
	s_and_not1_b32 exec_lo, exec_lo, s9                        // 0000000CF474: 917E097E
	s_cbranch_execnz 65489                                     // 0000000CF478: BFA6FFD1 <_ZL13mul_mat_vec_qIL9ggml_type8ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0x1c0>
	s_set_inst_prefetch_distance 0x2                           // 0000000CF47C: BF840002
	s_or_b32 exec_lo, exec_lo, s9                              // 0000000CF480: 8C7E097E
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 0000000CF484: BF870499
	s_or_b32 exec_lo, exec_lo, s7                              // 0000000CF488: 8C7E077E
	s_mov_b32 s5, exec_lo                                      // 0000000CF48C: BE85007E
	v_cmp_eq_u32_e32 vcc_lo, 0, v4                             // 0000000CF490: 7C940880
	v_cmpx_ne_u32_e32 0, v4                                    // 0000000CF494: 7D9A0880
	v_lshlrev_b32_e32 v0, 7, v4                                // 0000000CF498: 30000887
	s_delay_alu instid0(VALU_DEP_1)                            // 0000000CF49C: BF870001
	v_add3_u32 v0, v0, v3, 0xffffff80                          // 0000000CF4A0: D6550000 03FE0700 FFFFFF80
	ds_store_b32 v0, v5                                        // 0000000CF4AC: D8340000 00000500
	s_or_b32 exec_lo, exec_lo, s5                              // 0000000CF4B4: 8C7E057E
	s_waitcnt lgkmcnt(0)                                       // 0000000CF4B8: BF89FC07
	s_barrier                                                  // 0000000CF4BC: BFBD0000
	buffer_gl0_inv                                             // 0000000CF4C0: E0AC0000 00000000
	s_and_saveexec_b32 s3, vcc_lo                              // 0000000CF4C8: BE83206A
	s_cbranch_execz 85                                         // 0000000CF4CC: BFA50055 <_ZL13mul_mat_vec_qIL9ggml_type8ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0x424>
	ds_load_2addr_b32 v[0:1], v3 offset1:32                    // 0000000CF4D0: D8DC2000 00000003
	ds_load_2addr_b32 v[6:7], v3 offset0:64 offset1:96         // 0000000CF4D8: D8DC6040 06000003
	ds_load_2addr_b32 v[8:9], v3 offset0:128 offset1:160       // 0000000CF4E0: D8DCA080 08000003
	s_mov_b32 s3, 0                                            // 0000000CF4E8: BE830080
	s_waitcnt lgkmcnt(2)                                       // 0000000CF4EC: BF89FC27
	v_add_f32_e32 v0, v5, v0                                   // 0000000CF4F0: 06000105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_4) | instid1(VALU_DEP_2)// 0000000CF4F4: BF870151
	v_add_f32_e32 v0, v0, v1                                   // 0000000CF4F8: 06000300
	ds_load_b32 v1, v3 offset:768                              // 0000000CF4FC: D8D80300 01000003
	v_mbcnt_lo_u32_b32 v3, -1, 0                               // 0000000CF504: D71F0003 000100C1
	s_waitcnt lgkmcnt(2)                                       // 0000000CF50C: BF89FC27
	v_add_f32_e32 v0, v0, v6                                   // 0000000CF510: 06000D00
	v_xor_b32_e32 v4, 16, v3                                   // 0000000CF514: 3A080690
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 0000000CF518: BF870112
	v_add_f32_e32 v0, v0, v7                                   // 0000000CF51C: 06000F00
	v_cmp_gt_i32_e32 vcc_lo, 32, v4                            // 0000000CF520: 7C8808A0
	s_waitcnt lgkmcnt(1)                                       // 0000000CF524: BF89FC17
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 0000000CF528: BF870122
	v_add_f32_e32 v0, v0, v8                                   // 0000000CF52C: 06001100
	v_cndmask_b32_e32 v4, v3, v4, vcc_lo                       // 0000000CF530: 02080903
	v_add_f32_e32 v0, v0, v9                                   // 0000000CF534: 06001300
	s_waitcnt lgkmcnt(0)                                       // 0000000CF538: BF89FC07
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_4) | instid1(VALU_DEP_1)// 0000000CF53C: BF8700D1
	v_dual_add_f32 v0, v0, v1 :: v_dual_lshlrev_b32 v1, 2, v4  // 0000000CF540: C9220300 00000882
	v_xor_b32_e32 v4, 8, v3                                    // 0000000CF548: 3A080688
	ds_bpermute_b32 v1, v1, v0                                 // 0000000CF54C: DACC0000 01000001
	v_cmp_gt_i32_e32 vcc_lo, 32, v4                            // 0000000CF554: 7C8808A0
	v_cndmask_b32_e32 v4, v3, v4, vcc_lo                       // 0000000CF558: 02080903
	v_lshlrev_b32_e32 v4, 2, v4                                // 0000000CF55C: 30080882
	s_waitcnt lgkmcnt(0)                                       // 0000000CF560: BF89FC07
	v_add_f32_e32 v0, v0, v1                                   // 0000000CF564: 06000300
	ds_bpermute_b32 v1, v4, v0                                 // 0000000CF568: DACC0000 01000004
	v_xor_b32_e32 v4, 4, v3                                    // 0000000CF570: 3A080684
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 0000000CF574: BF8700A1
	v_cmp_gt_i32_e32 vcc_lo, 32, v4                            // 0000000CF578: 7C8808A0
	v_cndmask_b32_e32 v4, v3, v4, vcc_lo                       // 0000000CF57C: 02080903
	v_lshlrev_b32_e32 v4, 2, v4                                // 0000000CF580: 30080882
	s_waitcnt lgkmcnt(0)                                       // 0000000CF584: BF89FC07
	v_add_f32_e32 v0, v0, v1                                   // 0000000CF588: 06000300
	ds_bpermute_b32 v1, v4, v0                                 // 0000000CF58C: DACC0000 01000004
	v_xor_b32_e32 v4, 2, v3                                    // 0000000CF594: 3A080682
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 0000000CF598: BF8700A1
	v_cmp_gt_i32_e32 vcc_lo, 32, v4                            // 0000000CF59C: 7C8808A0
	v_cndmask_b32_e32 v4, v3, v4, vcc_lo                       // 0000000CF5A0: 02080903
	v_lshlrev_b32_e32 v4, 2, v4                                // 0000000CF5A4: 30080882
	s_waitcnt lgkmcnt(0)                                       // 0000000CF5A8: BF89FC07
	v_add_f32_e32 v0, v0, v1                                   // 0000000CF5AC: 06000300
	ds_bpermute_b32 v1, v4, v0                                 // 0000000CF5B0: DACC0000 01000004
	v_xor_b32_e32 v4, 1, v3                                    // 0000000CF5B8: 3A080681
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_2)// 0000000CF5BC: BF870141
	v_cmp_gt_i32_e32 vcc_lo, 32, v4                            // 0000000CF5C0: 7C8808A0
	v_cndmask_b32_e32 v3, v3, v4, vcc_lo                       // 0000000CF5C4: 02060903
	v_cmp_eq_u32_e32 vcc_lo, 0, v2                             // 0000000CF5C8: 7C940480
	s_waitcnt lgkmcnt(0)                                       // 0000000CF5CC: BF89FC07
	v_dual_add_f32 v0, v0, v1 :: v_dual_lshlrev_b32 v3, 2, v3  // 0000000CF5D0: C9220300 00020682
	ds_bpermute_b32 v1, v3, v0                                 // 0000000CF5D8: DACC0000 01000003
	s_and_b32 exec_lo, exec_lo, vcc_lo                         // 0000000CF5E0: 8B7E6A7E
	s_cbranch_execz 15                                         // 0000000CF5E4: BFA5000F <_ZL13mul_mat_vec_qIL9ggml_type8ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0x424>
	s_load_b64 s[0:1], s[0:1], 0x48                            // 0000000CF5E8: F4040000 F8000048
	s_mul_i32 s5, s10, s6                                      // 0000000CF5F0: 9605060A
	s_mul_i32 s4, s14, s4                                      // 0000000CF5F4: 9604040E
	s_add_i32 s2, s5, s2                                       // 0000000CF5F8: 81020205
	v_mov_b32_e32 v2, 0                                        // 0000000CF5FC: 7E040280
	s_add_i32 s2, s2, s4                                       // 0000000CF600: 81020402
	s_waitcnt lgkmcnt(0)                                       // 0000000CF604: BF89FC07
	v_add_f32_e32 v0, v0, v1                                   // 0000000CF608: 06000300
	s_lshl_b64 s[2:3], s[2:3], 2                               // 0000000CF60C: 84828202
	s_delay_alu instid0(SALU_CYCLE_1)                          // 0000000CF610: BF870009
	s_add_u32 s0, s0, s2                                       // 0000000CF614: 80000200
	s_addc_u32 s1, s1, s3                                      // 0000000CF618: 82010301
	global_store_b32 v2, v0, s[0:1]                            // 0000000CF61C: DC6A0000 00000002
	s_endpgm                                                   // 0000000CF624: BFB00000
		...
