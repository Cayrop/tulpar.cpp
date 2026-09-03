
obj_mmvq.elf:	file format elf64-amdgpu

Disassembly of section .text:

00000000000b1200 <_ZL13mul_mat_vec_qIL9ggml_type2ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj>:
	s_clause 0x1                                               // 0000000B1200: BF850001
	s_load_b64 s[8:9], s[0:1], 0x10                            // 0000000B1204: F4040200 F8000010
	s_load_b128 s[16:19], s[0:1], 0x50                         // 0000000B120C: F4080400 F8000050
	s_mov_b32 s6, s3                                           // 0000000B1214: BE860003
	s_waitcnt lgkmcnt(0)                                       // 0000000B1218: BF89FC07
	s_cmp_lg_u64 s[8:9], 0                                     // 0000000B121C: BF118008
	s_cselect_b32 s5, -1, 0                                    // 0000000B1220: 980580C1
	s_cmp_eq_u64 s[8:9], 0                                     // 0000000B1224: BF108008
	s_cbranch_scc1 32                                          // 0000000B1228: BFA20020 <_ZL13mul_mat_vec_qIL9ggml_type2ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0xac>
	s_mov_b32 s7, 0                                            // 0000000B122C: BE870080
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 0000000B1230: BF870499
	s_lshl_b64 s[10:11], s[6:7], 2                             // 0000000B1234: 848A8206
	s_add_u32 s8, s8, s10                                      // 0000000B1238: 80080A08
	s_addc_u32 s9, s9, s11                                     // 0000000B123C: 82090B09
	s_load_b32 s3, s[8:9], null                                // 0000000B1240: F40000C4 F8000000
	s_clause 0x1                                               // 0000000B1248: BF850001
	s_load_b128 s[8:11], s[0:1], 0x78                          // 0000000B124C: F4080200 F8000078
	s_load_b32 s20, s[0:1], 0x60                               // 0000000B1254: F4000500 F8000060
	s_cbranch_execnz 7                                         // 0000000B125C: BFA60007 <_ZL13mul_mat_vec_qIL9ggml_type2ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0x7c>
	s_load_b64 s[12:13], s[0:1], 0x6c                          // 0000000B1260: F4040300 F800006C
	s_waitcnt lgkmcnt(0)                                       // 0000000B1268: BF89FC07
	s_mul_hi_u32 s3, s12, s6                                   // 0000000B126C: 9683060C
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 0000000B1270: BF870499
	s_add_i32 s3, s6, s3                                       // 0000000B1274: 81030306
	s_lshr_b32 s3, s3, s13                                     // 0000000B1278: 85030D03
	s_load_b32 s21, s[0:1], 0x88                               // 0000000B127C: F4000540 F8000088
	s_and_not1_b32 vcc_lo, exec_lo, s5                         // 0000000B1284: 916A057E
	s_cbranch_vccnz 14                                         // 0000000B1288: BFA4000E <_ZL13mul_mat_vec_qIL9ggml_type2ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0xc4>
	s_mul_hi_u32 s5, s17, s6                                   // 0000000B128C: 96850611
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 0000000B1290: BF870499
	s_add_i32 s5, s6, s5                                       // 0000000B1294: 81050506
	s_lshr_b32 s5, s5, s18                                     // 0000000B1298: 85051205
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 0000000B129C: BF870499
	s_mul_i32 s5, s5, s19                                      // 0000000B12A0: 96051305
	s_sub_i32 s22, s6, s5                                      // 0000000B12A4: 81960506
	s_branch 7                                                 // 0000000B12A8: BFA00007 <_ZL13mul_mat_vec_qIL9ggml_type2ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0xc8>
	s_clause 0x1                                               // 0000000B12AC: BF850001
	s_load_b128 s[8:11], s[0:1], 0x78                          // 0000000B12B0: F4080200 F8000078
	s_load_b32 s20, s[0:1], 0x60                               // 0000000B12B8: F4000500 F8000060
	s_branch 65511                                             // 0000000B12C0: BFA0FFE7 <_ZL13mul_mat_vec_qIL9ggml_type2ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0x60>
	s_mov_b32 s22, s6                                          // 0000000B12C4: BE960006
	v_bfe_u32 v4, v0, 10, 10                                   // 0000000B12C8: D6100004 02291500
	s_load_b128 s[12:15], s[0:1], 0x90                         // 0000000B12D0: F4080300 F8000090
	v_dual_mov_b32 v5, 0 :: v_dual_and_b32 v2, 0x3ff, v0       // 0000000B12D8: CA240080 050200FF 000003FF
	v_mov_b16_e32 v6.h, 0                                      // 0000000B12E4: 7F0C3880
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 0000000B12E8: BF8701A3
	v_lshlrev_b32_e32 v0, 5, v4                                // 0000000B12EC: 30000885
	s_lshr_b32 s5, s16, 5                                      // 0000000B12F0: 85058510
	v_lshlrev_b32_e32 v3, 2, v2                                // 0000000B12F4: 30060482
	s_mov_b32 s7, exec_lo                                      // 0000000B12F8: BE87007E
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000B12FC: BF870092
	v_add_nc_u16 v1.l, v0.l, v2.l                              // 0000000B1300: D7030001 00020500
	v_lshrrev_b16 v6.l, 1, v1.l                                // 0000000B1308: D7390006 00020281
	s_delay_alu instid0(VALU_DEP_1)                            // 0000000B1310: BF870001
	v_cmpx_gt_u32_e64 s5, v6                                   // 0000000B1314: D4CC007E 00020C05
	s_cbranch_execz 103                                        // 0000000B131C: BFA50067 <_ZL13mul_mat_vec_qIL9ggml_type2ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0x2bc>
	s_load_b128 s[16:19], s[0:1], null                         // 0000000B1320: F4080400 F8000000
	s_waitcnt lgkmcnt(0)                                       // 0000000B1328: BF89FC07
	s_mul_hi_u32 s11, s11, s4                                  // 0000000B132C: 968B040B
	s_mul_i32 s20, s20, s2                                     // 0000000B1330: 96140214
	s_add_i32 s11, s4, s11                                     // 0000000B1334: 810B0B04
	v_add_nc_u32_e32 v0, v0, v2                                // 0000000B1338: 4A000500
	s_lshr_b32 s11, s11, s21                                   // 0000000B133C: 850B150B
	s_mul_i32 s13, s13, s4                                     // 0000000B1340: 960D040D
	s_mul_i32 s11, s11, s12                                    // 0000000B1344: 960B0C0B
	s_mul_i32 s8, s3, s8                                       // 0000000B1348: 96080803
	s_add_i32 s11, s11, s20                                    // 0000000B134C: 810B140B
	s_mul_i32 s3, s22, s9                                      // 0000000B1350: 96030916
	s_add_i32 s8, s8, s11                                      // 0000000B1354: 81080B08
	s_mul_i32 s11, s13, 36                                     // 0000000B1358: 960BA40D
	s_mul_hi_u32 s12, s13, 36                                  // 0000000B135C: 968CA40D
	v_lshrrev_b32_e32 v5, 1, v0                                // 0000000B1360: 320A0081
	s_mul_hi_u32 s9, s3, 36                                    // 0000000B1364: 9689A403
	s_mul_i32 s3, s3, 36                                       // 0000000B1368: 9603A403
	v_and_b32_e32 v8, 4, v3                                    // 0000000B136C: 36100684
	v_and_b32_e32 v7, 1, v2                                    // 0000000B1370: 360E0481
	s_add_u32 s11, s18, s11                                    // 0000000B1374: 800B0B12
	s_addc_u32 s13, s19, s12                                   // 0000000B1378: 820D0C13
	s_add_u32 s12, s11, s3                                     // 0000000B137C: 800C030B
	s_addc_u32 s13, s13, s9                                    // 0000000B1380: 820D090D
	v_lshlrev_b32_e32 v7, 3, v7                                // 0000000B1384: 300E0E83
	v_mad_u64_u32 v[0:1], null, v5, 36, s[12:13]               // 0000000B1388: D6FE7C00 00314905
	v_dual_mov_b32 v5, 0 :: v_dual_lshlrev_b32 v8, 1, v8       // 0000000B1390: CA220080 05081081
	s_mov_b32 s9, 0                                            // 0000000B1398: BE890080
	v_add_nc_u32_e32 v11, s8, v6                               // 0000000B139C: 4A160C08
	v_add_nc_u32_e32 v6, 0x80, v6                              // 0000000B13A0: 4A0C0CFF 00000080
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 0000000B13A8: BF8700A2
	v_mad_i64_i32 v[9:10], null, v11, 18, s[16:17]             // 0000000B13AC: D6FF7C09 0041250B
	v_add_co_u32 v11, vcc_lo, v0, v7                           // 0000000B13B4: D7006A0B 00020F00
	v_add_co_ci_u32_e64 v12, null, 0, v1, vcc_lo               // 0000000B13BC: D5207C0C 01AA0280
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 0000000B13C4: BF870214
	v_cmp_le_u32_e32 vcc_lo, s5, v6                            // 0000000B13C8: 7C960C05
	v_add_co_u32 v13, s3, v9, v8                               // 0000000B13CC: D700030D 00021109
	s_delay_alu instid0(VALU_DEP_1)                            // 0000000B13D4: BF870001
	v_add_co_ci_u32_e64 v14, null, 0, v10, s3                  // 0000000B13D8: D5207C0E 000E1480
	s_or_b32 s9, vcc_lo, s9                                    // 0000000B13E0: 8C09096A
	global_load_b64 v[13:14], v[13:14], off offset:2           // 0000000B13E4: DC560002 0D7C000D
	s_clause 0x2                                               // 0000000B13EC: BF850002
	global_load_b64 v[15:16], v[11:12], off offset:4           // 0000000B13F0: DC560004 0F7C000B
	global_load_b64 v[11:12], v[11:12], off offset:20          // 0000000B13F8: DC560014 0B7C000B
	global_load_b32 v17, v[0:1], off                           // 0000000B1400: DC520000 117C0000
	global_load_d16_b16 v9, v[9:10], off                       // 0000000B1408: DC820000 097C0009
	v_add_co_u32 v0, s3, 0x1200, v0                            // 0000000B1410: D7000300 000200FF 00001200
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_2)// 0000000B141C: BF870141
	v_add_co_ci_u32_e64 v1, null, 0, v1, s3                    // 0000000B1420: D5207C01 000E0280
	s_waitcnt vmcnt(4)                                         // 0000000B1428: BF8913F7
	v_lshrrev_b32_e32 v10, 4, v13                              // 0000000B142C: 32141A84
	v_and_b32_e32 v13, 0xf0f0f0f, v13                          // 0000000B1430: 361A1AFF 0F0F0F0F
	v_and_b32_e32 v10, 0xf0f0f0f, v10                          // 0000000B1438: 361414FF 0F0F0F0F
	s_waitcnt vmcnt(3)                                         // 0000000B1440: BF890FF7
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_3)// 0000000B1444: BF8701C2
	v_dot4_i32_iu8 v13, v13, v15, 0 neg_lo:[1,1,0]             // 0000000B1448: CC16400D 7A021F0D
	v_and_b32_e32 v15, 0xf0f0f0f, v14                          // 0000000B1450: 361E1CFF 0F0F0F0F
	v_lshrrev_b32_e32 v14, 4, v14                              // 0000000B1458: 321C1C84
	s_waitcnt vmcnt(2)                                         // 0000000B145C: BF890BF7
	v_dot4_i32_iu8 v10, v10, v11, v13 neg_lo:[1,1,0]           // 0000000B1460: CC16400A 7C36170A
	s_waitcnt vmcnt(1)                                         // 0000000B1468: BF8907F7
	v_cvt_f32_f16_e32 v13, v17.h                               // 0000000B146C: 7E1A1791
	v_and_b32_e32 v11, 0xf0f0f0f, v14                          // 0000000B1470: 36161CFF 0F0F0F0F
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000B1478: BF870093
	v_dot4_i32_iu8 v10, v15, v16, v10 neg_lo:[1,1,0]           // 0000000B147C: CC16400A 7C2A210F
	v_dot4_i32_iu8 v10, v11, v12, v10 neg_lo:[1,1,0]           // 0000000B1484: CC16400A 7C2A190B
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_2)// 0000000B148C: BF870114
	v_mul_f32_e32 v11, -4.0, v13                               // 0000000B1490: 10161AF7
	v_cvt_f32_i32_e32 v10, v10                                 // 0000000B1494: 7E140B0A
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 0000000B1498: BF8700A1
	v_fma_mix_f32 v10, v10, v17, v11 op_sel_hi:[0,1,0]         // 0000000B149C: CC20000A 142E230A
	s_waitcnt vmcnt(0)                                         // 0000000B14A4: BF8903F7
	v_fma_mix_f32 v5, v10, v9, v5 op_sel_hi:[0,1,0]            // 0000000B14A8: CC200005 1416130A
	s_and_not1_b32 exec_lo, exec_lo, s9                        // 0000000B14B0: 917E097E
	s_cbranch_execnz 65465                                     // 0000000B14B4: BFA6FFB9 <_ZL13mul_mat_vec_qIL9ggml_type2ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0x19c>
	s_or_b32 exec_lo, exec_lo, s9                              // 0000000B14B8: 8C7E097E
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 0000000B14BC: BF870499
	s_or_b32 exec_lo, exec_lo, s7                              // 0000000B14C0: 8C7E077E
	s_mov_b32 s5, exec_lo                                      // 0000000B14C4: BE85007E
	v_cmp_eq_u32_e32 vcc_lo, 0, v4                             // 0000000B14C8: 7C940880
	v_cmpx_ne_u32_e32 0, v4                                    // 0000000B14CC: 7D9A0880
	v_lshlrev_b32_e32 v0, 7, v4                                // 0000000B14D0: 30000887
	s_delay_alu instid0(VALU_DEP_1)                            // 0000000B14D4: BF870001
	v_add3_u32 v0, v0, v3, 0xffffff80                          // 0000000B14D8: D6550000 03FE0700 FFFFFF80
	ds_store_b32 v0, v5                                        // 0000000B14E4: D8340000 00000500
	s_or_b32 exec_lo, exec_lo, s5                              // 0000000B14EC: 8C7E057E
	s_waitcnt lgkmcnt(0)                                       // 0000000B14F0: BF89FC07
	s_barrier                                                  // 0000000B14F4: BFBD0000
	buffer_gl0_inv                                             // 0000000B14F8: E0AC0000 00000000
	s_and_saveexec_b32 s3, vcc_lo                              // 0000000B1500: BE83206A
	s_cbranch_execz 85                                         // 0000000B1504: BFA50055 <_ZL13mul_mat_vec_qIL9ggml_type2ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0x45c>
	ds_load_2addr_b32 v[0:1], v3 offset1:32                    // 0000000B1508: D8DC2000 00000003
	ds_load_2addr_b32 v[6:7], v3 offset0:64 offset1:96         // 0000000B1510: D8DC6040 06000003
	ds_load_2addr_b32 v[8:9], v3 offset0:128 offset1:160       // 0000000B1518: D8DCA080 08000003
	s_mov_b32 s3, 0                                            // 0000000B1520: BE830080
	s_waitcnt lgkmcnt(2)                                       // 0000000B1524: BF89FC27
	v_add_f32_e32 v0, v5, v0                                   // 0000000B1528: 06000105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_4) | instid1(VALU_DEP_2)// 0000000B152C: BF870151
	v_add_f32_e32 v0, v0, v1                                   // 0000000B1530: 06000300
	ds_load_b32 v1, v3 offset:768                              // 0000000B1534: D8D80300 01000003
	v_mbcnt_lo_u32_b32 v3, -1, 0                               // 0000000B153C: D71F0003 000100C1
	s_waitcnt lgkmcnt(2)                                       // 0000000B1544: BF89FC27
	v_add_f32_e32 v0, v0, v6                                   // 0000000B1548: 06000D00
	v_xor_b32_e32 v4, 16, v3                                   // 0000000B154C: 3A080690
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 0000000B1550: BF870112
	v_add_f32_e32 v0, v0, v7                                   // 0000000B1554: 06000F00
	v_cmp_gt_i32_e32 vcc_lo, 32, v4                            // 0000000B1558: 7C8808A0
	s_waitcnt lgkmcnt(1)                                       // 0000000B155C: BF89FC17
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 0000000B1560: BF870122
	v_add_f32_e32 v0, v0, v8                                   // 0000000B1564: 06001100
	v_cndmask_b32_e32 v4, v3, v4, vcc_lo                       // 0000000B1568: 02080903
	v_add_f32_e32 v0, v0, v9                                   // 0000000B156C: 06001300
	s_waitcnt lgkmcnt(0)                                       // 0000000B1570: BF89FC07
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_4) | instid1(VALU_DEP_1)// 0000000B1574: BF8700D1
	v_dual_add_f32 v0, v0, v1 :: v_dual_lshlrev_b32 v1, 2, v4  // 0000000B1578: C9220300 00000882
	v_xor_b32_e32 v4, 8, v3                                    // 0000000B1580: 3A080688
	ds_bpermute_b32 v1, v1, v0                                 // 0000000B1584: DACC0000 01000001
	v_cmp_gt_i32_e32 vcc_lo, 32, v4                            // 0000000B158C: 7C8808A0
	v_cndmask_b32_e32 v4, v3, v4, vcc_lo                       // 0000000B1590: 02080903
	v_lshlrev_b32_e32 v4, 2, v4                                // 0000000B1594: 30080882
	s_waitcnt lgkmcnt(0)                                       // 0000000B1598: BF89FC07
	v_add_f32_e32 v0, v0, v1                                   // 0000000B159C: 06000300
	ds_bpermute_b32 v1, v4, v0                                 // 0000000B15A0: DACC0000 01000004
	v_xor_b32_e32 v4, 4, v3                                    // 0000000B15A8: 3A080684
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 0000000B15AC: BF8700A1
	v_cmp_gt_i32_e32 vcc_lo, 32, v4                            // 0000000B15B0: 7C8808A0
	v_cndmask_b32_e32 v4, v3, v4, vcc_lo                       // 0000000B15B4: 02080903
	v_lshlrev_b32_e32 v4, 2, v4                                // 0000000B15B8: 30080882
	s_waitcnt lgkmcnt(0)                                       // 0000000B15BC: BF89FC07
	v_add_f32_e32 v0, v0, v1                                   // 0000000B15C0: 06000300
	ds_bpermute_b32 v1, v4, v0                                 // 0000000B15C4: DACC0000 01000004
	v_xor_b32_e32 v4, 2, v3                                    // 0000000B15CC: 3A080682
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 0000000B15D0: BF8700A1
	v_cmp_gt_i32_e32 vcc_lo, 32, v4                            // 0000000B15D4: 7C8808A0
	v_cndmask_b32_e32 v4, v3, v4, vcc_lo                       // 0000000B15D8: 02080903
	v_lshlrev_b32_e32 v4, 2, v4                                // 0000000B15DC: 30080882
	s_waitcnt lgkmcnt(0)                                       // 0000000B15E0: BF89FC07
	v_add_f32_e32 v0, v0, v1                                   // 0000000B15E4: 06000300
	ds_bpermute_b32 v1, v4, v0                                 // 0000000B15E8: DACC0000 01000004
	v_xor_b32_e32 v4, 1, v3                                    // 0000000B15F0: 3A080681
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_2)// 0000000B15F4: BF870141
	v_cmp_gt_i32_e32 vcc_lo, 32, v4                            // 0000000B15F8: 7C8808A0
	v_cndmask_b32_e32 v3, v3, v4, vcc_lo                       // 0000000B15FC: 02060903
	v_cmp_eq_u32_e32 vcc_lo, 0, v2                             // 0000000B1600: 7C940480
	s_waitcnt lgkmcnt(0)                                       // 0000000B1604: BF89FC07
	v_dual_add_f32 v0, v0, v1 :: v_dual_lshlrev_b32 v3, 2, v3  // 0000000B1608: C9220300 00020682
	ds_bpermute_b32 v1, v3, v0                                 // 0000000B1610: DACC0000 01000003
	s_and_b32 exec_lo, exec_lo, vcc_lo                         // 0000000B1618: 8B7E6A7E
	s_cbranch_execz 15                                         // 0000000B161C: BFA5000F <_ZL13mul_mat_vec_qIL9ggml_type2ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj+0x45c>
	s_load_b64 s[0:1], s[0:1], 0x48                            // 0000000B1620: F4040000 F8000048
	s_mul_i32 s5, s10, s6                                      // 0000000B1628: 9605060A
	s_mul_i32 s4, s14, s4                                      // 0000000B162C: 9604040E
	s_add_i32 s2, s5, s2                                       // 0000000B1630: 81020205
	v_mov_b32_e32 v2, 0                                        // 0000000B1634: 7E040280
	s_add_i32 s2, s2, s4                                       // 0000000B1638: 81020402
	s_waitcnt lgkmcnt(0)                                       // 0000000B163C: BF89FC07
	v_add_f32_e32 v0, v0, v1                                   // 0000000B1640: 06000300
	s_lshl_b64 s[2:3], s[2:3], 2                               // 0000000B1644: 84828202
	s_delay_alu instid0(SALU_CYCLE_1)                          // 0000000B1648: BF870009
	s_add_u32 s0, s0, s2                                       // 0000000B164C: 80000200
	s_addc_u32 s1, s1, s3                                      // 0000000B1650: 82010301
	global_store_b32 v2, v0, s[0:1]                            // 0000000B1654: DC6A0000 00000002
	s_endpgm                                                   // 0000000B165C: BFB00000
		...
