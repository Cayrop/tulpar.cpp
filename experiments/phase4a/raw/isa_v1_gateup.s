_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj
0000000000007700 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj>:
	v_bfe_u32 v14, v0, 10, 10                                  // 000000007700: D610000E 02291500
	v_and_b32_e32 v12, 0x3ff, v0                               // 000000007708: 361800FF 000003FF
	s_mov_b32 s6, exec_lo                                      // 000000007710: BE86007E
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000007714: BF870091
	v_lshl_or_b32 v2, v14, 5, v12                              // 000000007718: D6560002 04310B0E
	v_cmpx_gt_u32_e32 0x100, v2                                // 000000007720: 7D9804FF 00000100
	s_cbranch_execz 89                                         // 000000007728: BFA50059 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x190>
	v_lshlrev_b32_e32 v3, 2, v2                                // 00000000772C: 30060482
	s_getpc_b64 s[4:5]                                         // 000000007730: BE844700
	s_add_u32 s4, s4, 0xffffeb4c                               // 000000007734: 8004FF04 FFFFEB4C
	s_addc_u32 s5, s5, lit(0xffffffff)                         // 00000000773C: 8205FF05 FFFFFFFF
	v_cmp_gt_u32_e32 vcc_lo, 0xe0, v2                          // 000000007744: 7C9804FF 000000E0
	global_load_b32 v0, v3, s[4:5]                             // 00000000774C: DC520000 00040003
	s_waitcnt vmcnt(0)                                         // 000000007754: BF8903F7
	ds_store_b32 v3, v0                                        // 000000007758: D8340000 00000003
	s_and_b32 exec_lo, exec_lo, vcc_lo                         // 000000007760: 8B7E6A7E
	s_cbranch_execz 74                                         // 000000007764: BFA5004A <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x190>
	v_add_co_u32 v0, s4, s4, v3                                // 000000007768: D7000400 00020604
	s_delay_alu instid0(VALU_DEP_1)                            // 000000007770: BF870001
	v_add_co_ci_u32_e64 v1, null, s5, 0, s4                    // 000000007774: D5207C01 00110005
	s_mov_b32 s4, exec_lo                                      // 00000000777C: BE84007E
	global_load_b32 v4, v[0:1], off offset:128                 // 000000007780: DC520080 047C0000
	s_waitcnt vmcnt(0)                                         // 000000007788: BF8903F7
	ds_store_b32 v3, v4 offset:128                             // 00000000778C: D8340080 00000403
	v_cmpx_gt_u32_e32 0xc0, v2                                 // 000000007794: 7D9804FF 000000C0
	s_xor_b32 s4, exec_lo, s4                                  // 00000000779C: 8D04047E
	s_cbranch_execz 59                                         // 0000000077A0: BFA5003B <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x190>
	global_load_b32 v4, v[0:1], off offset:256                 // 0000000077A4: DC520100 047C0000
	s_mov_b32 s4, exec_lo                                      // 0000000077AC: BE84007E
	s_waitcnt vmcnt(0)                                         // 0000000077B0: BF8903F7
	ds_store_b32 v3, v4 offset:256                             // 0000000077B4: D8340100 00000403
	v_cmpx_gt_u32_e32 0xa0, v2                                 // 0000000077BC: 7D9804FF 000000A0
	s_xor_b32 s4, exec_lo, s4                                  // 0000000077C4: 8D04047E
	s_cbranch_execz 49                                         // 0000000077C8: BFA50031 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x190>
	global_load_b32 v4, v[0:1], off offset:384                 // 0000000077CC: DC520180 047C0000
	s_mov_b32 s4, exec_lo                                      // 0000000077D4: BE84007E
	s_waitcnt vmcnt(0)                                         // 0000000077D8: BF8903F7
	ds_store_b32 v3, v4 offset:384                             // 0000000077DC: D8340180 00000403
	v_cmpx_gt_u32_e32 0x80, v2                                 // 0000000077E4: 7D9804FF 00000080
	s_xor_b32 s4, exec_lo, s4                                  // 0000000077EC: 8D04047E
	s_cbranch_execz 39                                         // 0000000077F0: BFA50027 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x190>
	global_load_b32 v4, v[0:1], off offset:512                 // 0000000077F4: DC520200 047C0000
	s_mov_b32 s4, exec_lo                                      // 0000000077FC: BE84007E
	s_waitcnt vmcnt(0)                                         // 000000007800: BF8903F7
	ds_store_b32 v3, v4 offset:512                             // 000000007804: D8340200 00000403
	v_cmpx_gt_u32_e32 0x60, v2                                 // 00000000780C: 7D9804FF 00000060
	s_xor_b32 s4, exec_lo, s4                                  // 000000007814: 8D04047E
	s_cbranch_execz 29                                         // 000000007818: BFA5001D <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x190>
	global_load_b32 v4, v[0:1], off offset:640                 // 00000000781C: DC520280 047C0000
	s_mov_b32 s4, exec_lo                                      // 000000007824: BE84007E
	s_waitcnt vmcnt(0)                                         // 000000007828: BF8903F7
	ds_store_b32 v3, v4 offset:640                             // 00000000782C: D8340280 00000403
	v_cmpx_gt_u32_e32 64, v2                                   // 000000007834: 7D9804C0
	s_xor_b32 s4, exec_lo, s4                                  // 000000007838: 8D04047E
	s_cbranch_execz 20                                         // 00000000783C: BFA50014 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x190>
	global_load_b32 v0, v[0:1], off offset:768                 // 000000007840: DC520300 007C0000
	s_mov_b32 s4, exec_lo                                      // 000000007848: BE84007E
	s_waitcnt vmcnt(0)                                         // 00000000784C: BF8903F7
	ds_store_b32 v3, v0 offset:768                             // 000000007850: D8340300 00000003
	v_cmpx_gt_u32_e32 32, v2                                   // 000000007858: 7D9804A0
	s_xor_b32 s4, exec_lo, s4                                  // 00000000785C: 8D04047E
	s_cbranch_execz 11                                         // 000000007860: BFA5000B <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x190>
	v_lshlrev_b32_e32 v0, 2, v12                               // 000000007864: 30001882
	s_getpc_b64 s[4:5]                                         // 000000007868: BE844700
	s_add_u32 s4, s4, 0xffffed94                               // 00000000786C: 8004FF04 FFFFED94
	s_addc_u32 s5, s5, lit(0xffffffff)                         // 000000007874: 8205FF05 FFFFFFFF
	global_load_b32 v1, v0, s[4:5]                             // 00000000787C: DC520000 01040000
	s_waitcnt vmcnt(0)                                         // 000000007884: BF8903F7
	ds_store_b32 v0, v1 offset:896                             // 000000007888: D8340380 00000100
	s_or_b32 exec_lo, exec_lo, s6                              // 000000007890: 8C7E067E
	s_clause 0x1                                               // 000000007894: BF850001
	s_load_b128 s[20:23], s[0:1], 0x20                         // 000000007898: F4080500 F8000020
	s_load_b256 s[24:31], s[0:1], null                         // 0000000078A0: F40C0600 F8000000
	v_lshrrev_b32_e32 v16, 3, v2                               // 0000000078A8: 32200483
	v_mov_b32_e32 v13, 0                                       // 0000000078AC: 7E1A0280
	v_mov_b32_e32 v15, 0                                       // 0000000078B0: 7E1E0280
	s_mov_b32 s34, exec_lo                                     // 0000000078B4: BEA2007E
	s_waitcnt lgkmcnt(0)                                       // 0000000078B8: BF89FC07
	buffer_gl0_inv                                             // 0000000078BC: E0AC0000 00000000
	s_lshr_b32 s33, s20, 8                                     // 0000000078C4: 85218814
	s_delay_alu instid0(SALU_CYCLE_1)                          // 0000000078C8: BF870009
	v_cmpx_gt_u32_e64 s33, v16                                 // 0000000078CC: D4CC007E 00022021
	s_cbranch_execz 1458                                       // 0000000078D4: BFA505B2 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x18a0>
	v_lshl_add_u32 v0, v14, 5, v12                             // 0000000078D8: D6460000 04310B0E
	s_mul_i32 s0, s22, s3                                      // 0000000078E0: 96000316
	v_dual_mov_b32 v15, 0 :: v_dual_and_b32 v4, 7, v12         // 0000000078E4: CA240080 0F041887
	s_mul_hi_u32 s1, s0, 36                                    // 0000000078EC: 9681A400
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 0000000078F0: BF870132
	v_lshrrev_b32_e32 v2, 3, v0                                // 0000000078F4: 32040083
	s_mul_i32 s0, s0, 36                                       // 0000000078F8: 9600A400
	v_mov_b32_e32 v13, 0                                       // 0000000078FC: 7E1A0280
	v_mad_u64_u32 v[0:1], null, 0x120, v2, s[0:1]              // 000000007900: D6FE7C00 000204FF 00000120
	v_lshlrev_b32_e32 v2, 1, v12                               // 00000000790C: 30041881
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)// 000000007910: BF870191
	v_and_b32_e32 v5, 14, v2                                   // 000000007914: 360A048E
	v_mad_u64_u32 v[2:3], null, v4, 36, v[0:1]                 // 000000007918: D6FE7C02 04014904
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 000000007920: BF8701A2
	v_lshlrev_b32_e32 v0, 1, v5                                // 000000007924: 30000A81
	v_lshlrev_b32_e32 v17, 1, v5                               // 000000007928: 30220A81
	v_add_co_u32 v1, vcc_lo, s28, v2                           // 00000000792C: D7006A01 0002041C
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_4)// 000000007934: BF870211
	v_add_co_ci_u32_e64 v2, null, s29, v3, vcc_lo              // 000000007938: D5207C02 01AA061D
	v_lshlrev_b32_e32 v18, 1, v0                               // 000000007940: 30240081
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000007944: BF870093
	v_add_co_u32 v8, vcc_lo, v1, 32                            // 000000007948: D7006A08 00014101
	v_add_co_ci_u32_e64 v9, null, 0, v2, vcc_lo                // 000000007950: D5207C09 01AA0480
	s_mul_i32 s29, s21, s2                                     // 000000007958: 961D0215
	s_mov_b32 s28, 0                                           // 00000000795C: BE9C0080
	v_add_nc_u32_e32 v29, s29, v16                             // 000000007960: 4A3A201D
	s_clause 0x2                                               // 000000007964: BF850002
	global_load_b32 v20, v[8:9], off                           // 000000007968: DC520000 147C0008
	global_load_b128 v[0:3], v[8:9], off offset:-32            // 000000007970: DC5E1FE0 007C0008
	global_load_b128 v[4:7], v[8:9], off offset:-16            // 000000007978: DC5E1FF0 047C0008
	v_mov_b16_e32 v19.l, 0                                     // 000000007980: 7E263880
	v_add_nc_u32_e32 v16, 4, v16                               // 000000007984: 4A202084
	v_mad_i64_i32 v[10:11], null, 0x42, v29, s[24:25]          // 000000007988: D6FF7C0A 00623AFF 00000042
	v_mad_i64_i32 v[36:37], null, 0x42, v29, s[26:27]          // 000000007994: D6FF7C24 006A3AFF 00000042
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_4) | instid1(VALU_DEP_1)// 0000000079A0: BF8700D4
	v_mov_b16_e32 v29.h, v19.l                                 // 0000000079A4: 7F3A3913
	v_mov_b16_e32 v30.h, v19.l                                 // 0000000079A8: 7F3C3913
	v_mov_b16_e32 v33.h, v19.l                                 // 0000000079AC: 7F423913
	v_mov_b16_e32 v35.h, v19.l                                 // 0000000079B0: 7F463913
	v_add_co_u32 v31, vcc_lo, v10, v18                         // 0000000079B4: D7006A1F 0002250A
	v_add_co_ci_u32_e64 v32, null, 0, v11, vcc_lo              // 0000000079BC: D5207C20 01AA1680
	v_add_co_u32 v38, vcc_lo, v10, v17                         // 0000000079C4: D7006A26 0002230A
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 0000000079CC: BF8700A1
	v_add_co_ci_u32_e64 v39, null, 0, v11, vcc_lo              // 0000000079D0: D5207C27 01AA1680
	v_add_co_u32 v40, vcc_lo, v36, v18                         // 0000000079D8: D7006A28 00022524
	v_add_co_ci_u32_e64 v41, null, 0, v37, vcc_lo              // 0000000079E0: D5207C29 01AA4A80
	v_add_co_u32 v42, vcc_lo, v36, v17                         // 0000000079E8: D7006A2A 00022324
	s_delay_alu instid0(VALU_DEP_1)                            // 0000000079F0: BF870001
	v_add_co_ci_u32_e64 v43, null, 0, v37, vcc_lo              // 0000000079F4: D5207C2B 01AA4A80
	s_clause 0x1                                               // 0000000079FC: BF850001
	global_load_b64 v[44:45], v[31:32], off                    // 000000007A00: DC560000 2C7C001F
	global_load_b32 v32, v[38:39], off offset:64               // 000000007A08: DC520040 207C0026
	s_clause 0x1                                               // 000000007A10: BF850001
	global_load_b64 v[38:39], v[40:41], off                    // 000000007A14: DC560000 267C0028
	global_load_b32 v31, v[42:43], off offset:64               // 000000007A1C: DC520040 1F7C002A
	global_load_d16_hi_b16 v0, v[10:11], off offset:64         // 000000007A24: DC8E0040 007C000A
	global_load_d16_b16 v10, v[36:37], off offset:64           // 000000007A2C: DC820040 0A7C0024
	v_mov_b16_e32 v34.h, v19.l                                 // 000000007A34: 7F443913
	v_mov_b16_e32 v21.h, v19.l                                 // 000000007A38: 7F2A3913
	v_mov_b16_e32 v22.h, v19.l                                 // 000000007A3C: 7F2C3913
	v_mov_b16_e32 v23.h, v19.l                                 // 000000007A40: 7F2E3913
	v_mov_b16_e32 v24.h, v19.l                                 // 000000007A44: 7F303913
	v_mov_b16_e32 v26.h, v19.l                                 // 000000007A48: 7F343913
	v_mov_b16_e32 v25.h, v19.l                                 // 000000007A4C: 7F323913
	v_mov_b16_e32 v27.h, v19.l                                 // 000000007A50: 7F363913
	v_mov_b16_e32 v28.h, v19.l                                 // 000000007A54: 7F383913
	s_waitcnt vmcnt(5)                                         // 000000007A58: BF8917F7
	v_and_b32_e32 v11, 0xff, v44                               // 000000007A5C: 361658FF 000000FF
	s_waitcnt vmcnt(4)                                         // 000000007A64: BF8913F7
	v_and_b32_e32 v37, 0xff, v32                               // 000000007A68: 364A40FF 000000FF
	v_lshrrev_b32_e32 v36, 6, v44                              // 000000007A70: 32485886
	v_lshrrev_b32_e32 v40, 14, v44                             // 000000007A74: 3250588E
	v_lshrrev_b32_e32 v41, 22, v44                             // 000000007A78: 32525896
	v_bfe_u32 v48, v32, 21, 8                                  // 000000007A7C: D6100030 02212B20
	v_bcnt_u32_b32 v51, v37, 0                                 // 000000007A84: D71E0033 00010125
	v_and_b32_e32 v43, 0xff, v45                               // 000000007A8C: 36565AFF 000000FF
	v_lshrrev_b32_e32 v44, 6, v45                              // 000000007A94: 32585A86
	v_bfe_u32 v42, v32, 7, 8                                   // 000000007A98: D610002A 02210F20
	v_bfe_u32 v46, v32, 14, 8                                  // 000000007AA0: D610002E 02211D20
	v_lshrrev_b32_e32 v47, 14, v45                             // 000000007AA8: 325E5A8E
	v_lshrrev_b32_e32 v45, 22, v45                             // 000000007AAC: 325A5A96
	v_lshlrev_b32_e32 v11, 2, v11                              // 000000007AB0: 30161682
	v_and_b32_e32 v51, 1, v51                                  // 000000007AB4: 36666681
	v_and_b32_e32 v36, 0x3fc, v36                              // 000000007AB8: 364848FF 000003FC
	v_and_b32_e32 v40, 0x3fc, v40                              // 000000007AC0: 365050FF 000003FC
	v_and_b32_e32 v41, 0x3fc, v41                              // 000000007AC8: 365252FF 000003FC
	v_bcnt_u32_b32 v62, v48, 0                                 // 000000007AD0: D71E003E 00010130
	v_lshlrev_b32_e32 v43, 2, v43                              // 000000007AD8: 30565682
	v_and_b32_e32 v44, 0x3fc, v44                              // 000000007ADC: 365858FF 000003FC
	s_waitcnt vmcnt(3)                                         // 000000007AE4: BF890FF7
	v_and_b32_e32 v52, 0xff, v38                               // 000000007AE8: 36684CFF 000000FF
	v_lshrrev_b32_e32 v53, 6, v38                              // 000000007AF0: 326A4C86
	v_lshrrev_b32_e32 v54, 14, v38                             // 000000007AF4: 326C4C8E
	v_lshrrev_b32_e32 v55, 22, v38                             // 000000007AF8: 326E4C96
	s_waitcnt vmcnt(2)                                         // 000000007AFC: BF890BF7
	v_bfe_u32 v38, v31, 7, 8                                   // 000000007B00: D6100026 02210F1F
	v_bfe_u32 v50, v31, 14, 8                                  // 000000007B08: D6100032 02211D1F
	v_bcnt_u32_b32 v60, v42, 0                                 // 000000007B10: D71E003C 0001012A
	v_bcnt_u32_b32 v61, v46, 0                                 // 000000007B18: D71E003D 0001012E
	v_and_b32_e32 v47, 0x3fc, v47                              // 000000007B20: 365E5EFF 000003FC
	v_and_b32_e32 v45, 0x3fc, v45                              // 000000007B28: 365A5AFF 000003FC
	ds_load_b32 v67, v11                                       // 000000007B30: D8D80000 4300000B
	ds_load_b32 v68, v36                                       // 000000007B38: D8D80000 44000024
	ds_load_b32 v69, v40                                       // 000000007B40: D8D80000 45000028
	ds_load_b32 v70, v41                                       // 000000007B48: D8D80000 46000029
	ds_load_b32 v71, v43                                       // 000000007B50: D8D80000 4700002B
	ds_load_b32 v72, v44                                       // 000000007B58: D8D80000 4800002C
	ds_load_b32 v73, v47                                       // 000000007B60: D8D80000 4900002F
	ds_load_b32 v74, v45                                       // 000000007B68: D8D80000 4A00002D
	v_lshlrev_b32_e32 v44, 7, v51                              // 000000007B70: 30586687
	v_and_b32_e32 v49, 0xff, v31                               // 000000007B74: 36623EFF 000000FF
	v_and_b32_e32 v56, 0xff, v39                               // 000000007B7C: 36704EFF 000000FF
	v_lshrrev_b32_e32 v57, 6, v39                              // 000000007B84: 32724E86
	v_lshrrev_b32_e32 v58, 14, v39                             // 000000007B88: 32744E8E
	v_lshrrev_b32_e32 v59, 22, v39                             // 000000007B8C: 32764E96
	v_bfe_u32 v39, v31, 21, 8                                  // 000000007B90: D6100027 02212B1F
	v_and_b32_e32 v11, 1, v62                                  // 000000007B98: 36167C81
	v_bcnt_u32_b32 v64, v38, 0                                 // 000000007B9C: D71E0040 00010126
	v_bcnt_u32_b32 v65, v50, 0                                 // 000000007BA4: D71E0041 00010132
	v_and_b32_e32 v60, 1, v60                                  // 000000007BAC: 36787881
	v_and_b32_e32 v61, 1, v61                                  // 000000007BB0: 367A7A81
	v_xor_b32_e32 v37, v44, v37                                // 000000007BB4: 3A4A4B2C
	v_bcnt_u32_b32 v63, v49, 0                                 // 000000007BB8: D71E003F 00010131
	v_bcnt_u32_b32 v66, v39, 0                                 // 000000007BC0: D71E0042 00010127
	v_lshlrev_b32_e32 v11, 7, v11                              // 000000007BC8: 30161687
	v_and_b32_e32 v40, 1, v64                                  // 000000007BCC: 36508081
	v_and_b32_e32 v41, 1, v65                                  // 000000007BD0: 36528281
	v_lshlrev_b32_e32 v45, 7, v60                              // 000000007BD4: 305A7887
	v_lshlrev_b32_e32 v47, 7, v61                              // 000000007BD8: 305E7A87
	v_mul_lo_u32 v37, 0x1010101, v37                           // 000000007BDC: D72C0025 00024AFF 01010101
	v_and_b32_e32 v36, 1, v63                                  // 000000007BE8: 36487E81
	v_and_b32_e32 v43, 1, v66                                  // 000000007BEC: 36568481
	v_xor_b32_e32 v11, v11, v48                                // 000000007BF0: 3A16610B
	v_lshlrev_b32_e32 v40, 7, v40                              // 000000007BF4: 30505087
	v_lshlrev_b32_e32 v41, 7, v41                              // 000000007BF8: 30525287
	v_xor_b32_e32 v42, v45, v42                                // 000000007BFC: 3A54552D
	v_xor_b32_e32 v44, v47, v46                                // 000000007C00: 3A585D2F
	v_lshlrev_b32_e32 v36, 7, v36                              // 000000007C04: 30484887
	v_lshlrev_b32_e32 v43, 7, v43                              // 000000007C08: 30565687
	v_mul_lo_u32 v61, 0x1010101, v11                           // 000000007C0C: D72C003D 000216FF 01010101
	v_and_b32_e32 v11, 0x8040201, v37                          // 000000007C18: 36164AFF 08040201
	v_xor_b32_e32 v38, v40, v38                                // 000000007C20: 3A4C4D28
	v_xor_b32_e32 v40, v41, v50                                // 000000007C24: 3A506529
	v_mul_lo_u32 v41, 0x1010101, v42                           // 000000007C28: D72C0029 000254FF 01010101
	v_mul_lo_u32 v60, 0x1010101, v44                           // 000000007C34: D72C003C 000258FF 01010101
	v_xor_b32_e32 v36, v36, v49                                // 000000007C40: 3A486324
	v_xor_b32_e32 v39, v43, v39                                // 000000007C44: 3A4E4F2B
	v_lshrrev_b32_e32 v85, 24, v11                             // 000000007C48: 32AA1698
	v_mul_lo_u32 v63, 0x1010101, v38                           // 000000007C4C: D72C003F 00024CFF 01010101
	v_bfe_i32 v38, v37, 0, 1                                   // 000000007C58: D6110026 02050125
	v_mul_lo_u32 v62, 0x1010101, v36                           // 000000007C60: D72C003E 000248FF 01010101
	v_mul_lo_u32 v65, 0x1010101, v39                           // 000000007C6C: D72C0041 00024EFF 01010101
	v_lshrrev_b32_e32 v36, 18, v37                             // 000000007C78: 32484A92
	v_and_b32_e32 v39, 0x80402010, v37                         // 000000007C7C: 364E4AFF 80402010
	v_lshrrev_b32_e32 v37, 22, v37                             // 000000007C84: 324A4A96
	v_and_b32_e32 v44, 0x80402010, v41                         // 000000007C88: 365852FF 80402010
	v_bfe_i32 v47, v60, 0, 1                                   // 000000007C90: D611002F 0205013C
	s_waitcnt vmcnt(0)                                         // 000000007C98: BF8903F7
	v_lshrrev_b16 v10.h, 8, v11.l op_sel:[0,0,1]               // 000000007C9C: D739400A 00021688
	v_cmp_ne_u16_e64 s7, 0, v85.l                              // 000000007CA4: D43D0007 0002AA80
	v_mul_lo_u32 v64, 0x1010101, v40                           // 000000007CAC: D72C0040 000250FF 01010101
	v_and_b32_e32 v40, 0x8040201, v41                          // 000000007CB8: 365052FF 08040201
	v_and_b32_e32 v49, 0x8040201, v61                          // 000000007CC0: 36627AFF 08040201
	v_lshrrev_b32_e32 v87, 24, v39                             // 000000007CC8: 32AE4E98
	v_lshrrev_b16 v11.h, 8, v39.l op_sel:[0,0,1]               // 000000007CCC: D739400B 00024E88
	v_lshrrev_b16 v29.l, 4, v39.l                              // 000000007CD4: D739001D 00024E84
	v_bfe_i32 v88, v37, 0, 1                                   // 000000007CDC: D6110058 02050125
	v_lshrrev_b32_e32 v39, 24, v44                             // 000000007CE4: 324E5898
	v_mov_b16_e32 v37.l, v47.l                                 // 000000007CE8: 7E4A392F
	v_cndmask_b32_e64 v47, 0, -1, s7                           // 000000007CEC: D501002F 001D8280
	v_cmp_ne_u16_e64 s7, 0, v10.h op_sel:[0,1,0]               // 000000007CF4: D43D1007 00021480
	v_lshrrev_b32_e32 v42, 18, v41                             // 000000007CFC: 32545292
	v_bfe_i32 v43, v41, 0, 1                                   // 000000007D00: D611002B 02050129
	v_lshrrev_b32_e32 v41, 22, v41                             // 000000007D08: 32525296
	v_and_b32_e32 v45, 0x8040201, v60                          // 000000007D0C: 365A78FF 08040201
	v_and_b32_e32 v48, 0x80402010, v60                         // 000000007D14: 366078FF 80402010
	v_bfe_i32 v50, v61, 0, 1                                   // 000000007D1C: D6110032 0205013D
	v_and_b32_e32 v66, 0x8040201, v62                          // 000000007D24: 36847CFF 08040201
	v_and_b32_e32 v82, 0x80402010, v64                         // 000000007D2C: 36A480FF 80402010
	v_mov_b16_e32 v11.l, v38.l                                 // 000000007D34: 7E163926
	v_lshrrev_b32_e32 v38, 24, v40                             // 000000007D38: 324C5098
	v_lshrrev_b16 v19.h, 8, v40.l op_sel:[0,0,1]               // 000000007D3C: D7394013 00025088
	v_cmp_ne_u16_e64 s12, 0, v39.l                             // 000000007D44: D43D000C 00024E80
	v_lshrrev_b32_e32 v39, 24, v49                             // 000000007D4C: 324E6298
	v_lshrrev_b16 v24.l, 8, v49.l                              // 000000007D50: D7390018 00026288
	v_cndmask_b32_e64 v49, 0, -1, s7                           // 000000007D58: D5010031 001D8280
	v_cmp_ne_u16_e64 s7, 0, v87.l                              // 000000007D60: D43D0007 0002AE80
	v_and_b32_e32 v76, 0x80402010, v62                         // 000000007D68: 36987CFF 80402010
	v_lshrrev_b16 v21.l, 8, v44.l                              // 000000007D70: D7390015 00025888
	v_bfe_i32 v90, v41, 0, 1                                   // 000000007D78: D611005A 02050129
	v_lshrrev_b32_e32 v40, 24, v45                             // 000000007D80: 32505A98
	v_lshrrev_b16 v22.l, 8, v45.l                              // 000000007D84: D7390016 00025A88
	v_lshrrev_b32_e32 v41, 24, v48                             // 000000007D8C: 32526098
	v_cmp_ne_u16_e64 s11, 0, v38.l                             // 000000007D90: D43D000B 00024C80
	v_mov_b16_e32 v38.l, v50.l                                 // 000000007D98: 7E4C3932
	v_lshrrev_b16 v26.l, 8, v66.l                              // 000000007D9C: D739001A 00028488
	v_lshrrev_b32_e32 v45, 24, v82                             // 000000007DA4: 325AA498
	v_cndmask_b32_e64 v50, 0, -1, s7                           // 000000007DA8: D5010032 001D8280
	v_cmp_ne_u16_e64 s7, 0, v11.h op_sel:[0,1,0]               // 000000007DB0: D43D1007 00021680
	v_cmp_ne_u16_e64 s8, 0, v19.h op_sel:[0,1,0]               // 000000007DB8: D43D1008 00022680
	v_and_b32_e32 v51, 0x80402010, v61                         // 000000007DC0: 36667AFF 80402010
	v_and_b32_e32 v77, 0x8040201, v63                          // 000000007DC8: 369A7EFF 08040201
	v_and_b32_e32 v79, 0x80402010, v63                         // 000000007DD0: 369E7EFF 80402010
	v_cmp_ne_u16_e64 s14, 0, v41.l                             // 000000007DD8: D43D000E 00025280
	v_lshrrev_b32_e32 v41, 24, v66                             // 000000007DE0: 32528498
	v_cmp_ne_u16_e64 s15, 0, v26.l                             // 000000007DE4: D43D000F 00023480
	v_lshrrev_b16 v26.l, 8, v76.l                              // 000000007DEC: D739001A 00029888
	v_cndmask_b32_e64 v66, 0, -1, s7                           // 000000007DF4: D5010042 001D8280
	v_cmp_ne_u16_e64 s7, 0, v45.l                              // 000000007DFC: D43D0007 00025A80
	v_cndmask_b32_e64 v45, 0, -1, s8                           // 000000007E04: D501002D 00218280
	v_cmp_ne_u16_e64 s8, 0, v21.l                              // 000000007E0C: D43D0008 00022A80
	v_bfe_i32 v75, v62, 0, 1                                   // 000000007E14: D611004B 0205013E
	v_bfe_i32 v78, v63, 0, 1                                   // 000000007E1C: D611004E 0205013F
	v_and_b32_e32 v83, 0x8040201, v65                          // 000000007E24: 36A682FF 08040201
	v_bfe_i32 v89, v42, 0, 1                                   // 000000007E2C: D6110059 0205012A
	v_lshrrev_b16 v30.l, 4, v44.l                              // 000000007E34: D739001E 00025884
	v_lshrrev_b16 v23.l, 8, v48.l                              // 000000007E3C: D7390017 00026088
	v_cmp_ne_u16_e64 s13, 0, v40.l                             // 000000007E44: D43D000D 00025080
	v_lshrrev_b32_e32 v40, 24, v51                             // 000000007E4C: 32506698
	v_lshrrev_b32_e32 v42, 24, v76                             // 000000007E50: 32549898
	v_lshrrev_b16 v35.l, 4, v76.l                              // 000000007E54: D7390023 00029884
	v_lshrrev_b16 v27.l, 8, v77.l                              // 000000007E5C: D739001B 00029A88
	v_cmp_ne_u16_e64 s16, 0, v26.l                             // 000000007E64: D43D0010 00023480
	v_lshrrev_b32_e32 v44, 24, v79                             // 000000007E6C: 32589E98
	v_cndmask_b32_e64 v76, 0, -1, s8                           // 000000007E70: D501004C 00218280
	v_cmp_ne_u16_e64 s8, 0, v22.l                              // 000000007E78: D43D0008 00022C80
	v_mov_b16_e32 v21.l, v47.l                                 // 000000007E80: 7E2A392F
	v_and_b32_e32 v80, 0x8040201, v64                          // 000000007E84: 36A080FF 08040201
	v_bfe_i32 v86, v36, 0, 1                                   // 000000007E8C: D6110056 02050124
	v_mov_b16_e32 v36.l, v43.l                                 // 000000007E94: 7E48392B
	v_lshrrev_b16 v33.l, 4, v48.l                              // 000000007E98: D7390021 00026084
	v_cmp_ne_u16_e64 s10, 0, v39.l                             // 000000007EA0: D43D000A 00024E80
	v_mov_b16_e32 v39.l, v75.l                                 // 000000007EA8: 7E4E394B
	v_cmp_ne_u16_e64 s5, 0, v40.l                              // 000000007EAC: D43D0005 00025080
	v_lshrrev_b32_e32 v43, 24, v77                             // 000000007EB4: 32569A98
	v_mov_b16_e32 v40.l, v78.l                                 // 000000007EB8: 7E50394E
	v_lshrrev_b16 v26.l, 8, v79.l                              // 000000007EBC: D739001A 00029E88
	v_cmp_ne_u16_e64 s17, 0, v27.l                             // 000000007EC4: D43D0011 00023680
	v_cmp_ne_u16_e64 s6, 0, v44.l                              // 000000007ECC: D43D0006 00025880
	v_lshrrev_b32_e32 v44, 24, v83                             // 000000007ED4: 3258A698
	v_bfe_i32 v75, v29, 0, 1                                   // 000000007ED8: D611004B 0205011D
	v_bfe_i32 v77, v30, 0, 1                                   // 000000007EE0: D611004D 0205011E
	v_cndmask_b32_e64 v78, 0, -1, s8                           // 000000007EE8: D501004E 00218280
	v_cmp_ne_u16_e64 s8, 0, v23.l                              // 000000007EF0: D43D0008 00022E80
	v_lshlrev_b16 v36.h, 8, v21.l op_sel:[0,0,1]               // 000000007EF8: D7384024 00022A88
	v_mov_b16_e32 v21.l, v49.l                                 // 000000007F00: 7E2A3931
	v_cndmask_b32_e64 v49, 0, -1, s16                          // 000000007F04: D5010031 00418280
	v_mov_b16_e32 v23.l, v45.l                                 // 000000007F0C: 7E2E392D
	v_cmp_ne_u16_e64 s0, 0, v42.l                              // 000000007F10: D43D0000 00025480
	v_lshrrev_b16 v48.l, 4, v79.l                              // 000000007F18: D7390030 00029E84
	v_lshrrev_b32_e32 v42, 24, v80                             // 000000007F20: 3254A098
	v_lshrrev_b16 v27.l, 8, v80.l                              // 000000007F24: D739001B 0002A088
	v_cmp_ne_u16_e64 s18, 0, v26.l                             // 000000007F2C: D43D0012 00023480
	v_and_b16 v10.h, 0xff, v36.l op_sel:[0,0,1]                // 000000007F34: D762400A 000248FF 000000FF
	v_cndmask_b32_e64 v79, 0, -1, s8                           // 000000007F40: D501004F 00218280
	v_bfe_i32 v80, v33, 0, 1                                   // 000000007F48: D6110050 02050121
	v_cmp_ne_u16_e64 s8, 0, v44.l                              // 000000007F50: D43D0008 00025880
	v_cmp_ne_u16_e64 s9, 0, v24.l                              // 000000007F58: D43D0009 00023080
	v_mov_b16_e32 v44.l, v75.l                                 // 000000007F60: 7E58394B
	v_mov_b16_e32 v24.l, v76.l                                 // 000000007F64: 7E30394C
	v_mov_b16_e32 v45.l, v77.l                                 // 000000007F68: 7E5A394D
	v_lshlrev_b16 v39.h, 8, v23.l op_sel:[0,0,1]               // 000000007F6C: D7384027 00022E88
	v_cndmask_b32_e64 v75, 0, -1, s17                          // 000000007F74: D501004B 00458280
	v_mov_b16_e32 v33.l, v49.l                                 // 000000007F7C: 7E423931
	v_lshrrev_b32_e32 v46, 18, v60                             // 000000007F80: 325C7892
	v_and_b32_e32 v84, 0x80402010, v65                         // 000000007F84: 36A882FF 80402010
	v_lshrrev_b16 v34.l, 4, v51.l                              // 000000007F8C: D7390022 00026684
	v_cmp_ne_u16_e64 s19, 0, v27.l                             // 000000007F94: D43D0013 00023680
	v_mov_b16_e32 v22.l, v66.l                                 // 000000007F9C: 7E2C3942
	v_bfe_i32 v66, v35, 0, 1                                   // 000000007FA0: D6110042 02050123
	v_lshlrev_b16 v40.h, 8, v24.l op_sel:[0,0,1]               // 000000007FA8: D7384028 00023088
	v_or_b16 v23.l, v10.h, v39.h op_sel:[1,1,0]                // 000000007FB0: D7631817 00024F0A
	v_and_b16 v10.h, 0xff, v45.l op_sel:[0,0,1]                // 000000007FB8: D762400A 00025AFF 000000FF
	v_cndmask_b32_e64 v76, 0, -1, s18                          // 000000007FC4: D501004C 00498280
	v_bfe_i32 v77, v48, 0, 1                                   // 000000007FCC: D611004D 02050130
	v_lshlrev_b16 v45.h, 8, v33.l op_sel:[0,0,1]               // 000000007FD4: D738402D 00024288
	v_mov_b16_e32 v33.l, v75.l                                 // 000000007FDC: 7E42394B
	v_bfe_i32 v91, v46, 0, 1                                   // 000000007FE0: D611005B 0205012E
	v_lshrrev_b32_e32 v46, 24, v84                             // 000000007FE8: 325CA898
	v_bfe_i32 v81, v64, 0, 1                                   // 000000007FEC: D6110051 02050140
	v_lshrrev_b16 v26.l, 8, v82.l                              // 000000007FF4: D739001A 0002A488
	v_lshrrev_b16 v28.l, 8, v83.l                              // 000000007FFC: D739001C 0002A688
	v_cmp_ne_u16_e64 s1, 0, v42.l                              // 000000008004: D43D0001 00025480
	v_mov_b16_e32 v42.l, v86.l                                 // 00000000800C: 7E543956
	v_bfe_i32 v83, v34, 0, 1                                   // 000000008010: D6110053 02050122
	v_or_b16 v24.l, v10.h, v40.h op_sel:[1,1,0]                // 000000008018: D7631818 0002510A
	v_and_b16 v10.h, 0xff, v40.l op_sel:[0,0,1]                // 000000008020: D762400A 000250FF 000000FF
	v_mov_b16_e32 v48.l, v66.l                                 // 00000000802C: 7E603942
	v_cndmask_b32_e64 v66, 0, -1, s19                          // 000000008030: D5010042 004D8280
	v_mov_b16_e32 v34.l, v76.l                                 // 000000008038: 7E44394C
	v_mov_b16_e32 v49.l, v77.l                                 // 00000000803C: 7E62394D
	v_lshlrev_b16 v46.h, 8, v33.l op_sel:[0,0,1]               // 000000008040: D738402E 00024288
	v_cmp_ne_u16_e32 vcc_lo, 0, v41.l                          // 000000008048: 7C7A5280
	v_mov_b16_e32 v41.l, v81.l                                 // 00000000804C: 7E523951
	v_cmp_ne_u16_e64 s20, 0, v26.l                             // 000000008050: D43D0014 00023480
	v_and_b16 v26.l, 0xff, v11.l                               // 000000008058: D762001A 000216FF 000000FF
	v_and_b16 v19.h, 0xff, v42.l op_sel:[0,0,1]                // 000000008064: D7624013 000254FF 000000FF
	v_lshlrev_b16 v37.h, 8, v21.l op_sel:[0,0,1]               // 000000008070: D7384025 00022A88
	v_lshlrev_b16 v47.h, 8, v34.l op_sel:[0,0,1]               // 000000008078: D738402F 00024488
	v_or_b16 v33.l, v10.h, v46.h op_sel:[1,1,0]                // 000000008080: D7631821 00025D0A
	v_and_b16 v10.h, 0xff, v49.l op_sel:[0,0,1]                // 000000008088: D762400A 000262FF 000000FF
	v_mov_b16_e32 v35.l, v66.l                                 // 000000008094: 7E463942
	v_cmp_ne_u16_e64 s4, 0, v43.l                              // 000000008098: D43D0004 00025680
	v_mov_b16_e32 v43.l, v88.l                                 // 0000000080A0: 7E563958
	v_or_b16 v19.h, v19.h, v36.h op_sel:[1,1,1]                // 0000000080A4: D7635813 00024913
	v_or_b16 v21.l, v26.l, v37.h op_sel:[0,1,0]                // 0000000080AC: D7631015 00024B1A
	v_or_b16 v34.l, v10.h, v47.h op_sel:[1,1,0]                // 0000000080B4: D7631822 00025F0A
	v_and_b16 v10.h, 0xff, v41.l op_sel:[0,0,1]                // 0000000080BC: D762400A 000252FF 000000FF
	v_lshlrev_b16 v48.h, 8, v35.l op_sel:[0,0,1]               // 0000000080C8: D7384030 00024688
	v_lshlrev_b16 v38.h, 8, v22.l op_sel:[0,0,1]               // 0000000080D0: D7384026 00022C88
	v_and_b16 v22.l, 0xff, v44.l                               // 0000000080D8: D7620016 000258FF 000000FF
	v_lshlrev_b16 v49.h, 8, v50.l op_sel:[0,0,1]               // 0000000080E4: D7384031 00026488
	v_or_b32_e32 v66, v21, v19                                 // 0000000080EC: 38842715
	v_or_b16 v35.l, v10.h, v48.h op_sel:[1,1,0]                // 0000000080F0: D7631823 0002610A
	v_and_b16 v10.h, 0xff, v43.l op_sel:[0,0,1]                // 0000000080F8: D762400A 000256FF 000000FF
	v_cndmask_b32_e64 v50, 0, -1, s11                          // 000000008104: D5010032 002D8280
	v_mov_b16_e32 v21.l, v89.l                                 // 00000000810C: 7E2A3959
	v_or_b16 v22.l, v22.l, v38.h op_sel:[0,1,0]                // 000000008110: D7631016 00024D16
	s_waitcnt lgkmcnt(7)                                       // 000000008118: BF89FC77
	v_xor_b32_e32 v66, v67, v66                                // 00000000811C: 3A848543
	v_or_b16 v19.h, v10.h, v49.h op_sel:[1,1,1]                // 000000008120: D7635813 0002630A
	v_lshlrev_b16 v21.h, 8, v50.l op_sel:[0,0,1]               // 000000008128: D7384015 00026488
	v_and_b16 v10.h, 0xff, v21.l op_sel:[0,0,1]                // 000000008130: D762400A 00022AFF 000000FF
	v_cndmask_b32_e64 v50, 0, -1, s12                          // 00000000813C: D5010032 00318280
	v_lshrrev_b16 v25.l, 8, v51.l                              // 000000008144: D7390019 00026688
	v_or_b32_e32 v67, v22, v19                                 // 00000000814C: 38862716
	v_lshrrev_b16 v51.l, 4, v82.l                              // 000000008150: D7390033 0002A484
	v_or_b16 v19.h, v10.h, v21.h op_sel:[1,1,1]                // 000000008158: D7635813 00022B0A
	v_lshlrev_b16 v10.h, 8, v11.l op_sel:[0,0,1]               // 000000008160: D738400A 00021688
	v_mov_b16_e32 v11.l, v90.l                                 // 000000008168: 7E16395A
	v_lshlrev_b16 v50.l, 8, v50.l                              // 00000000816C: D7380032 00026488
	s_waitcnt lgkmcnt(6)                                       // 000000008174: BF89FC67
	v_xor_b32_e32 v67, v68, v67                                // 000000008178: 3A868744
	v_or_b32_e32 v68, v23, v19                                 // 00000000817C: 38882717
	v_cndmask_b32_e64 v81, 0, -1, s9                           // 000000008180: D5010051 00258280
	v_and_b16 v22.h, 0xff, v11.l op_sel:[0,0,1]                // 000000008188: D7624016 000216FF 000000FF
	v_cmp_ne_u16_e64 s9, 0, v25.l                              // 000000008194: D43D0009 00023280
	v_mov_b16_e32 v25.l, v78.l                                 // 00000000819C: 7E32394E
	v_mov_b16_e32 v22.l, v91.l                                 // 0000000081A0: 7E2C395B
	v_cndmask_b32_e64 v23, 0, -1, s13                          // 0000000081A4: D5010017 00358280
	v_or_b16 v19.h, v22.h, v50.l op_sel:[1,0,1]                // 0000000081AC: D7634813 00026516
	v_and_b16 v22.h, 0xff00, v66.l op_sel:[0,0,1]              // 0000000081B4: D7624016 000284FF FFFFFF00
	v_cndmask_b32_e64 v78, 0, -1, s20                          // 0000000081C0: D501004E 00518280
	v_bfe_i32 v51, v51, 0, 1                                   // 0000000081C8: D6110033 02050133
	v_cmp_ne_u16_e64 s21, 0, v28.l                             // 0000000081D0: D43D0015 00023880
	v_and_b16 v11.h, 0xff, v37.l op_sel:[0,0,1]                // 0000000081D8: D762400B 00024AFF 000000FF
	v_sub_nc_i16 v75.l, v22.h, v37.h op_sel:[1,1,0] clamp      // 0000000081E4: D70E984B 00024B16
	v_lshlrev_b16 v22.h, 8, v66.l op_sel:[0,0,1]               // 0000000081EC: D7384016 00028488
	v_mov_b16_e32 v26.l, v79.l                                 // 0000000081F4: 7E34394F
	v_lshlrev_b16 v41.h, 8, v25.l op_sel:[0,0,1]               // 0000000081F8: D7384029 00023288
	s_waitcnt lgkmcnt(5)                                       // 000000008200: BF89FC57
	v_xor_b32_e32 v68, v69, v68                                // 000000008204: 3A888945
	v_or_b32_e32 v69, v24, v19                                 // 000000008208: 388A2718
	v_sub_nc_i16 v66.l, v22.h, v10.h op_sel:[1,1,0] clamp      // 00000000820C: D70E9842 00021516
	v_and_b16 v10.h, 0xff00, v66.h op_sel:[0,1,1]              // 000000008214: D762500A 000284FF FFFFFF00
	v_lshlrev_b16 v22.h, 8, v66.h op_sel:[0,1,1]               // 000000008220: D7385016 00028488
	v_and_b16 v23.h, 0xff00, v67.l op_sel:[0,0,1]              // 000000008228: D7624017 000286FF FFFFFF00
	v_lshlrev_b16 v42.h, 8, v26.l op_sel:[0,0,1]               // 000000008234: D738402A 00023488
	v_or_b16 v26.l, v11.h, v41.h op_sel:[1,1,0]                // 00000000823C: D763181A 0002530B
	v_sub_nc_i16 v76.l, v10.h, v36.h op_sel:[1,1,0] clamp      // 000000008244: D70E984C 0002490A
	v_lshlrev_b16 v10.h, 8, v42.l op_sel:[0,0,1]               // 00000000824C: D738400A 00025488
	v_mov_b16_e32 v42.l, v78.l                                 // 000000008254: 7E54394E
	v_lshrrev_b32_e32 v24, 22, v60                             // 000000008258: 32307896
	v_perm_b32 v60, v66, v75, 0xc0c0105                        // 00000000825C: D644003C 03FE9742 0C0C0105
	v_bfe_i32 v66, v65, 0, 1                                   // 000000008268: D6110042 02050141
	v_sub_nc_i16 v77.l, v22.h, v10.h op_sel:[1,1,0] clamp      // 000000008270: D70E984D 00021516
	v_and_b16 v10.h, 0xff, v22.l op_sel:[0,0,1]                // 000000008278: D762400A 00022CFF 000000FF
	v_lshlrev_b16 v22.h, 8, v23.l op_sel:[0,0,1]               // 000000008284: D7384016 00022E88
	v_lshlrev_b16 v23.l, 8, v42.l                              // 00000000828C: D7380017 00025488
	v_cndmask_b32_e64 v79, 0, -1, s21                          // 000000008294: D501004F 00558280
	v_lshrrev_b16 v27.l, 8, v84.l                              // 00000000829C: D739001B 0002A888
	v_bfe_i32 v75, v24, 0, 1                                   // 0000000082A4: D611004B 02050118
	v_or_b16 v19.h, v10.h, v22.h op_sel:[1,1,1]                // 0000000082AC: D7635813 00022D0A
	v_and_b16 v10.h, 0xff, v51.l op_sel:[0,0,1]                // 0000000082B4: D762400A 000266FF 000000FF
	v_mov_b16_e32 v24.l, v66.l                                 // 0000000082C0: 7E303942
	v_perm_b32 v66, v77, v76, 0xc0c0105                        // 0000000082C4: D6440042 03FE994D 0C0C0105
	v_cndmask_b32_e64 v76, 0, -1, s14                          // 0000000082D0: D501004C 00398280
	s_waitcnt lgkmcnt(4)                                       // 0000000082D8: BF89FC47
	v_xor_b32_e32 v69, v70, v69                                // 0000000082DC: 3A8A8B46
	v_or_b16 v78.l, v10.h, v23.l op_sel:[1,0,0]                // 0000000082E0: D763084E 00022F0A
	v_lshlrev_b16 v10.h, 8, v44.l op_sel:[0,0,1]               // 0000000082E8: D738400A 00025888
	v_sub_nc_i16 v44.l, v23.h, v38.h op_sel:[1,1,0] clamp      // 0000000082F0: D70E982C 00024D17
	v_lshlrev_b16 v23.h, 8, v67.l op_sel:[0,0,1]               // 0000000082F8: D7384017 00028688
	v_or_b32_e32 v70, v26, v19                                 // 000000008300: 388C271A
	v_mov_b16_e32 v26.l, v79.l                                 // 000000008304: 7E34394F
	v_cndmask_b32_e64 v82, 0, -1, s9                           // 000000008308: D5010052 00258280
	v_cmp_ne_u16_e64 s22, 0, v27.l                             // 000000008310: D43D0016 00023680
	v_sub_nc_i16 v67.l, v23.h, v10.h op_sel:[1,1,0] clamp      // 000000008318: D70E9843 00021517
	v_and_b16 v10.h, 0xff00, v67.h op_sel:[0,1,1]              // 000000008320: D762500A 000286FF FFFFFF00
	v_mov_b16_e32 v42.l, v75.l                                 // 00000000832C: 7E54394B
	v_lshlrev_b16 v23.h, 8, v67.h op_sel:[0,1,1]               // 000000008330: D7385017 00028688
	v_lshlrev_b16 v24.h, 8, v26.l op_sel:[0,0,1]               // 000000008338: D7384018 00023488
	v_lshrrev_b16 v26.l, 4, v84.l                              // 000000008340: D739001A 0002A884
	v_sub_nc_i16 v75.l, v10.h, v49.h op_sel:[1,1,0] clamp      // 000000008348: D70E984B 0002630A
	v_lshlrev_b16 v10.h, 8, v43.l op_sel:[0,0,1]               // 000000008350: D738400A 00025688
	v_mov_b16_e32 v43.l, v76.l                                 // 000000008358: 7E56394C
	v_cndmask_b32_e64 v85, 0, -1, s15                          // 00000000835C: D5010055 003D8280
	v_mov_b16_e32 v30.l, v82.l                                 // 000000008364: 7E3C3952
	v_lshl_or_b32 v60, v66, 16, v60                            // 000000008368: D656003C 04F12142
	v_sub_nc_i16 v77.l, v23.h, v10.h op_sel:[1,1,0] clamp      // 000000008370: D70E984D 00021517
	v_and_b16 v10.h, 0xff, v42.l op_sel:[0,0,1]                // 000000008378: D762400A 000254FF 000000FF
	v_lshlrev_b16 v23.h, 8, v43.l op_sel:[0,0,1]               // 000000008384: D7384017 00025688
	v_cndmask_b32_e64 v66, 0, -1, s22                          // 00000000838C: D5010042 00598280
	v_bfe_i32 v79, v26, 0, 1                                   // 000000008394: D611004F 0205011A
	v_lshlrev_b16 v43.h, 8, v30.l op_sel:[0,0,1]               // 00000000839C: D738402B 00023C88
	v_mov_b16_e32 v30.l, v85.l                                 // 0000000083A4: 7E3C3955
	v_or_b16 v19.h, v10.h, v23.h op_sel:[1,1,1]                // 0000000083A8: D7635813 00022F0A
	v_and_b16 v10.h, 0xff, v24.l op_sel:[0,0,1]                // 0000000083B0: D762400A 000230FF 000000FF
	v_mov_b16_e32 v26.l, v66.l                                 // 0000000083BC: 7E343942
	v_mov_b16_e32 v43.l, v79.l                                 // 0000000083C0: 7E56394F
	v_lshlrev_b16 v44.h, 8, v30.l op_sel:[0,0,1]               // 0000000083C4: D738402C 00023C88
	v_cmp_ne_u16_e64 s9, 0, v46.l                              // 0000000083CC: D43D0009 00025C80
	v_or_b16 v76.l, v10.h, v24.h op_sel:[1,1,0]                // 0000000083D4: D763184C 0002310A
	v_lshlrev_b16 v10.h, 8, v26.l op_sel:[0,0,1]               // 0000000083DC: D738400A 00023488
	v_and_b16 v26.l, 0xff, v43.l                               // 0000000083E4: D762001A 000256FF 000000FF
	v_perm_b32 v66, v67, v44, 0xc0c0105                        // 0000000083F0: D6440042 03FE5943 0C0C0105
	v_mov_b16_e32 v46.l, v80.l                                 // 0000000083FC: 7E5C3950
	v_lshlrev_b16 v21.l, 8, v21.l                              // 000000008400: D7380015 00022A88
	v_cndmask_b32_e64 v79, 0, -1, s10                          // 000000008408: D501004F 00298280
	v_or_b16 v67.l, v26.l, v10.h op_sel:[0,1,0]                // 000000008410: D7631043 0002151A
	v_lshlrev_b32_e32 v26, 2, v52                              // 000000008418: 30346882
	v_and_b32_e32 v52, 0x3fc, v53                              // 00000000841C: 36686AFF 000003FC
	v_and_b32_e32 v53, 0x3fc, v54                              // 000000008424: 366A6CFF 000003FC
	v_and_b32_e32 v54, 0x3fc, v55                              // 00000000842C: 366C6EFF 000003FC
	v_lshlrev_b32_e32 v55, 2, v56                              // 000000008434: 306E7082
	v_and_b32_e32 v56, 0x3fc, v57                              // 000000008438: 367072FF 000003FC
	v_and_b32_e32 v57, 0x3fc, v58                              // 000000008440: 367274FF 000003FC
	v_and_b32_e32 v58, 0x3fc, v59                              // 000000008448: 367476FF 000003FC
	ds_load_b32 v59, v26                                       // 000000008450: D8D80000 3B00001A
	ds_load_b32 v52, v52                                       // 000000008458: D8D80000 34000034
	ds_load_b32 v53, v53                                       // 000000008460: D8D80000 35000035
	ds_load_b32 v54, v54                                       // 000000008468: D8D80000 36000036
	ds_load_b32 v55, v55                                       // 000000008470: D8D80000 37000037
	ds_load_b32 v56, v56                                       // 000000008478: D8D80000 38000038
	ds_load_b32 v57, v57                                       // 000000008480: D8D80000 39000039
	ds_load_b32 v58, v58                                       // 000000008488: D8D80000 3A00003A
	v_and_b16 v26.h, 0xff00, v68.l op_sel:[0,0,1]              // 000000008490: D762401A 000288FF FFFFFF00
	v_lshlrev_b16 v26.l, 8, v36.l                              // 00000000849C: D738001A 00024888
	v_perm_b32 v36, v77, v75, 0xc0c0105                        // 0000000084A4: D6440024 03FE974D 0C0C0105
	v_and_b16 v11.h, 0xff, v46.l op_sel:[0,0,1]                // 0000000084B0: D762400B 00025CFF 000000FF
	s_waitcnt lgkmcnt(11)                                      // 0000000084BC: BF89FCB7
	v_xor_b32_e32 v70, v71, v70                                // 0000000084C0: 3A8C8D47
	v_sub_nc_i16 v44.l, v26.h, v39.h op_sel:[1,1,0] clamp      // 0000000084C4: D70E982C 00024F1A
	v_lshlrev_b16 v26.h, 8, v68.l op_sel:[0,0,1]               // 0000000084CC: D738401A 00028888
	v_lshl_or_b32 v66, v36, 16, v66                            // 0000000084D4: D6560042 05092124
	v_or_b16 v25.l, v11.h, v42.h op_sel:[1,1,0]                // 0000000084DC: D7631819 0002550B
	v_lshrrev_b32_e32 v36, 18, v63                             // 0000000084E4: 32487E92
	v_lshrrev_b32_e32 v63, 22, v63                             // 0000000084E8: 327E7E96
	v_sub_nc_i16 v68.l, v26.h, v26.l op_sel:[1,0,0] clamp      // 0000000084EC: D70E8844 0002351A
	v_and_b16 v26.l, 0xff00, v68.h op_sel:[0,1,0]              // 0000000084F4: D762101A 000288FF FFFFFF00
	v_or_b32_e32 v71, v25, v19                                 // 000000008500: 388E2719
	v_and_b16 v25.l, 0xff00, v69.l                             // 000000008504: D7620019 00028AFF FFFFFF00
	v_bfe_i32 v63, v63, 0, 1                                   // 000000008510: D611003F 0205013F
	v_lshlrev_b16 v11.l, 8, v11.l                              // 000000008518: D738000B 00021688
	v_sub_nc_i16 v75.l, v26.l, v21.h op_sel:[0,1,0] clamp      // 000000008520: D70E904B 00022B1A
	v_lshrrev_b32_e32 v26, 18, v61                             // 000000008528: 32347A92
	v_lshlrev_b16 v21.h, 8, v68.h op_sel:[0,1,1]               // 00000000852C: D7385015 00028888
	v_perm_b32 v68, v68, v44, 0xc0c0105                        // 000000008534: D6440044 03FE5944 0C0C0105
	v_sub_nc_i16 v44.l, v25.l, v40.h op_sel:[0,1,0] clamp      // 000000008540: D70E902C 00025119
	v_lshlrev_b16 v25.l, 8, v69.l                              // 000000008548: D7380019 00028A88
	v_bfe_i32 v26, v26, 0, 1                                   // 000000008550: D611001A 0205011A
	v_sub_nc_i16 v77.l, v21.h, v21.l op_sel:[1,0,0] clamp      // 000000008558: D70E884D 00022B15
	v_lshrrev_b32_e32 v61, 22, v61                             // 000000008560: 327A7A96
	v_and_b16 v28.l, 0xff, v38.l                               // 000000008564: D762001C 00024CFF 000000FF
	v_mov_b16_e32 v27.l, v81.l                                 // 000000008570: 7E363951
	v_mov_b16_e32 v21.l, v26.l                                 // 000000008574: 7E2A391A
	v_mov_b16_e32 v26.l, v79.l                                 // 000000008578: 7E34394F
	v_lshrrev_b32_e32 v79, 18, v62                             // 00000000857C: 329E7C92
	v_perm_b32 v75, v77, v75, 0xc0c0105                        // 000000008580: D644004B 03FE974D 0C0C0105
	v_bfe_i32 v61, v61, 0, 1                                   // 00000000858C: D611003D 0205013D
	v_and_b16 v21.h, 0xff, v21.l op_sel:[0,0,1]                // 000000008594: D7624015 00022AFF 000000FF
	v_lshlrev_b16 v26.l, 8, v26.l                              // 0000000085A0: D738001A 00023488
	v_bfe_i32 v77, v79, 0, 1                                   // 0000000085A8: D611004D 0205014F
	v_bfe_i32 v79, v36, 0, 1                                   // 0000000085B0: D611004F 02050124
	v_and_b16 v36.h, 0xff00, v70.l op_sel:[0,0,1]              // 0000000085B8: D7624024 00028CFF FFFFFF00
	v_cndmask_b32_e64 v82, 0, -1, s5                           // 0000000085C4: D5010052 00158280
	v_or_b16 v19.h, v21.h, v26.l op_sel:[1,0,1]                // 0000000085CC: D7634813 00023515
	v_lshlrev_b16 v21.h, 8, v45.l op_sel:[0,0,1]               // 0000000085D4: D7384015 00025A88
	v_mov_b16_e32 v47.l, v83.l                                 // 0000000085DC: 7E5E3953
	v_lshlrev_b16 v11.h, 8, v27.l op_sel:[0,0,1]               // 0000000085E0: D738400B 00023688
	v_lshrrev_b32_e32 v80, 18, v64                             // 0000000085E8: 32A08092
	v_lshrrev_b32_e32 v64, 22, v64                             // 0000000085EC: 32808096
	v_sub_nc_i16 v45.l, v25.l, v21.h op_sel:[0,1,0] clamp      // 0000000085F0: D70E902D 00022B19
	v_and_b16 v21.h, 0xff00, v69.h op_sel:[0,1,1]              // 0000000085F8: D7625015 00028AFF FFFFFF00
	v_lshrrev_b32_e32 v25, 18, v65                             // 000000008604: 32328292
	v_or_b16 v27.l, v28.l, v11.h op_sel:[0,1,0]                // 000000008608: D763101B 0002171C
	v_and_b16 v28.l, 0xff, v47.l                               // 000000008610: D762001C 00025EFF 000000FF
	v_lshrrev_b32_e32 v65, 22, v65                             // 00000000861C: 32828296
	v_sub_nc_i16 v50.l, v21.h, v50.l op_sel:[1,0,0] clamp      // 000000008620: D70E8832 00026515
	v_lshlrev_b16 v21.h, 8, v69.h op_sel:[0,1,1]               // 000000008628: D7385015 00028A88
	v_bfe_i32 v81, v25, 0, 1                                   // 000000008630: D6110051 02050119
	v_mov_b16_e32 v25.l, v61.l                                 // 000000008638: 7E32393D
	s_waitcnt lgkmcnt(10)                                      // 00000000863C: BF89FCA7
	v_xor_b32_e32 v61, v72, v71                                // 000000008640: 3A7A8F48
	v_cndmask_b32_e64 v72, 0, -1, vcc_lo                       // 000000008644: D5010048 01A98280
	v_sub_nc_i16 v69.l, v21.h, v11.l op_sel:[1,0,0] clamp      // 00000000864C: D70E8845 00021715
	v_lshlrev_b16 v11.l, 8, v37.l                              // 000000008654: D738000B 00024A88
	v_lshlrev_b16 v21.h, 8, v38.l op_sel:[0,0,1]               // 00000000865C: D7384015 00024C88
	v_mov_b16_e32 v38.l, v63.l                                 // 000000008664: 7E4C393F
	v_perm_b32 v63, v45, v44, 0xc0c0105                        // 000000008668: D644003F 03FE592D 0C0C0105
	v_sub_nc_i16 v44.l, v36.h, v41.h op_sel:[1,1,0] clamp      // 000000008674: D70E982C 00025324
	v_lshlrev_b16 v36.h, 8, v70.l op_sel:[0,0,1]               // 00000000867C: D7384024 00028C88
	v_mov_b16_e32 v37.l, v82.l                                 // 000000008684: 7E4A3952
	v_bfe_i32 v64, v64, 0, 1                                   // 000000008688: D6110040 02050140
	v_mov_b16_e32 v36.l, v77.l                                 // 000000008690: 7E48394D
	v_and_b16 v25.h, 0xff, v25.l op_sel:[0,0,1]                // 000000008694: D7624019 000232FF 000000FF
	v_sub_nc_i16 v45.l, v36.h, v11.l op_sel:[1,0,0] clamp      // 0000000086A0: D70E882D 00021724
	v_and_b16 v11.l, 0xff00, v70.h op_sel:[0,1,0]              // 0000000086A8: D762100B 00028CFF FFFFFF00
	v_lshlrev_b16 v26.h, 8, v37.l op_sel:[0,0,1]               // 0000000086B4: D738401A 00024A88
	v_perm_b32 v50, v69, v50, 0xc0c0105                        // 0000000086BC: D6440032 03FE6545 0C0C0105
	v_lshlrev_b16 v22.l, 8, v22.l                              // 0000000086C8: D7380016 00022C88
	v_or_b16 v28.l, v28.l, v43.h op_sel:[0,1,0]                // 0000000086D0: D763101C 0002571C
	v_sub_nc_i16 v69.l, v11.l, v22.h op_sel:[0,1,0] clamp      // 0000000086D8: D70E9045 00022D0B
	v_lshlrev_b16 v11.l, 8, v41.l                              // 0000000086E0: D738000B 00025288
	v_lshlrev_b16 v22.h, 8, v70.h op_sel:[0,1,1]               // 0000000086E8: D7385016 00028C88
	v_mov_b16_e32 v41.l, v72.l                                 // 0000000086F0: 7E523948
	v_lshrrev_b32_e32 v62, 22, v62                             // 0000000086F4: 327C7C96
	v_bfe_i32 v65, v65, 0, 1                                   // 0000000086F8: D6110041 02050141
	v_or_b32_e32 v71, v27, v19                                 // 000000008700: 388E271B
	v_or_b16 v19.h, v25.h, v26.h op_sel:[1,1,1]                // 000000008704: D7635813 00023519
	v_lshlrev_b16 v27.h, 8, v40.l op_sel:[0,0,1]               // 00000000870C: D738401B 00025088
	v_mov_b16_e32 v40.l, v64.l                                 // 000000008714: 7E503940
	v_sub_nc_i16 v64.l, v22.h, v22.l op_sel:[1,0,0] clamp      // 000000008718: D70E8840 00022D16
	v_and_b16 v22.h, 0xff, v36.l op_sel:[0,0,1]                // 000000008720: D7624016 000248FF 000000FF
	v_lshlrev_b16 v36.h, 8, v41.l op_sel:[0,0,1]               // 00000000872C: D7384024 00025288
	v_and_b16 v39.h, 0xff00, v61.l op_sel:[0,0,1]              // 000000008734: D7624027 00027AFF FFFFFF00
	v_bfe_i32 v62, v62, 0, 1                                   // 000000008740: D611003E 0205013E
	v_dot4_i32_iu8 v37, v60, v1, 0 neg_lo:[1,1,0]              // 000000008748: CC164025 7A02033C
	v_or_b32_e32 v72, v28, v19                                 // 000000008750: 3890271C
	v_or_b16 v19.h, v22.h, v36.h op_sel:[1,1,1]                // 000000008754: D7635813 00024916
	v_lshlrev_b16 v22.h, 8, v24.l op_sel:[0,0,1]               // 00000000875C: D7384016 00023088
	v_mov_b16_e32 v24.l, v65.l                                 // 000000008764: 7E303941
	v_lshlrev_b16 v38.h, 8, v46.l op_sel:[0,0,1]               // 000000008768: D7384026 00025C88
	v_sub_nc_i16 v65.l, v39.h, v42.h op_sel:[1,1,0] clamp      // 000000008770: D70E9841 00025527
	v_lshlrev_b16 v39.h, 8, v61.l op_sel:[0,0,1]               // 000000008778: D7384027 00027A88
	v_bfe_i32 v80, v80, 0, 1                                   // 000000008780: D6110050 02050150
	v_mov_b16_e32 v27.l, v62.l                                 // 000000008788: 7E36393E
	v_dot4_i32_iu8 v60, v66, v2, v37 neg_lo:[1,1,0]            // 00000000878C: CC16403C 7C960542
	v_cndmask_b32_e64 v62, 0, -1, s0                           // 000000008794: D501003E 00018280
	v_lshl_or_b32 v66, v75, 16, v68                            // 00000000879C: D6560042 0511214B
	v_sub_nc_i16 v61.l, v39.h, v38.h op_sel:[1,1,0] clamp      // 0000000087A4: D70E983D 00024D27
	v_and_b16 v38.h, 0xff00, v61.h op_sel:[0,1,1]              // 0000000087AC: D7625026 00027AFF FFFFFF00
	v_and_b16 v29.l, 0xff, v39.l                               // 0000000087B8: D762001D 00024EFF 000000FF
	v_lshlrev_b16 v25.h, 8, v39.l op_sel:[0,0,1]               // 0000000087C4: D7384019 00024E88
	v_cndmask_b32_e64 v68, 0, -1, s4                           // 0000000087CC: D5010044 00118280
	v_cndmask_b32_e64 v75, 0, -1, s6                           // 0000000087D4: D501004B 00198280
	v_mov_b16_e32 v39.l, v80.l                                 // 0000000087DC: 7E4E3950
	v_lshlrev_b16 v28.l, 8, v42.l                              // 0000000087E0: D738001C 00025488
	v_dot4_i32_iu8 v60, v66, v3, v60 neg_lo:[1,1,0]            // 0000000087E8: CC16403C 7CF20742
	v_mov_b16_e32 v41.l, v62.l                                 // 0000000087F0: 7E52393E
	v_sub_nc_i16 v66.l, v38.h, v23.h op_sel:[1,1,0] clamp      // 0000000087F4: D70E9842 00022F26
	v_lshlrev_b16 v38.h, 8, v61.h op_sel:[0,1,1]               // 0000000087FC: D7385026 00027A88
	v_or_b16 v29.l, v29.l, v44.h op_sel:[0,1,0]                // 000000008804: D763101D 0002591D
	v_and_b16 v30.l, 0xff, v48.l                               // 00000000880C: D762001E 000260FF 000000FF
	v_mov_b16_e32 v37.l, v79.l                                 // 000000008818: 7E4A394F
	v_cndmask_b32_e64 v70, 0, -1, s7                           // 00000000881C: D5010046 001D8280
	s_waitcnt lgkmcnt(9)                                       // 000000008824: BF89FC97
	v_xor_b32_e32 v71, v73, v71                                // 000000008828: 3A8E8F49
	v_lshl_or_b32 v50, v50, 16, v63                            // 00000000882C: D6560032 04FD2132
	v_lshlrev_b16 v28.h, 8, v36.l op_sel:[0,0,1]               // 000000008834: D738401C 00024888
	v_and_b16 v36.l, 0xff, v27.l                               // 00000000883C: D7620024 000236FF 000000FF
	v_perm_b32 v62, v45, v44, 0xc0c0105                        // 000000008848: D644003E 03FE592D 0C0C0105
	v_mov_b16_e32 v42.l, v68.l                                 // 000000008854: 7E543944
	v_mov_b16_e32 v44.l, v75.l                                 // 000000008858: 7E58394B
	v_sub_nc_i16 v68.l, v38.h, v28.l op_sel:[1,0,0] clamp      // 00000000885C: D70E8844 00023926
	v_and_b16 v28.l, 0xff, v39.l                               // 000000008864: D762001C 00024EFF 000000FF
	v_lshlrev_b16 v38.h, 8, v39.l op_sel:[0,0,1]               // 000000008870: D7384026 00024E88
	v_and_b16 v39.l, 0xff, v40.l                               // 000000008878: D7620027 000250FF 000000FF
	v_lshlrev_b16 v39.h, 8, v40.l op_sel:[0,0,1]               // 000000008884: D7384027 00025088
	v_lshlrev_b16 v40.l, 8, v41.l                              // 00000000888C: D7380028 00025288
	v_or_b16 v30.l, v30.l, v45.h op_sel:[0,1,0]                // 000000008894: D763101E 00025B1E
	v_cndmask_b32_e64 v77, 0, -1, s1                           // 00000000889C: D501004D 00058280
	v_cndmask_b32_e64 v63, 0, -1, s9                           // 0000000088A4: D501003F 00258280
	v_lshlrev_b16 v21.l, 8, v21.l                              // 0000000088AC: D7380015 00022A88
	v_and_b16 v37.h, 0xff, v37.l op_sel:[0,0,1]                // 0000000088B4: D7624025 00024AFF 000000FF
	v_perm_b32 v64, v64, v69, 0xc0c0105                        // 0000000088C0: D6440040 03FE8B40 0C0C0105
	s_waitcnt lgkmcnt(8)                                       // 0000000088CC: BF89FC87
	v_xor_b32_e32 v69, v74, v72                                // 0000000088D0: 3A8A914A
	v_mov_b16_e32 v46.l, v70.l                                 // 0000000088D4: 7E5C3946
	v_or_b32_e32 v70, v29, v19                                 // 0000000088D8: 388C271D
	v_or_b16 v19.h, v36.l, v40.l op_sel:[0,0,1]                // 0000000088DC: D7634013 00025124
	v_dot4_i32_iu8 v60, v50, v4, v60 neg_lo:[1,1,0]            // 0000000088E4: CC16403C 7CF20932
	v_lshlrev_b16 v41.h, 8, v48.l op_sel:[0,0,1]               // 0000000088EC: D7384029 00026088
	v_lshlrev_b16 v42.l, 8, v42.l                              // 0000000088F4: D738002A 00025488
	v_lshlrev_b16 v42.h, 8, v44.l op_sel:[0,0,1]               // 0000000088FC: D738402A 00025888
	v_lshlrev_b16 v44.l, 8, v49.l                              // 000000008904: D738002C 00026288
	v_and_b16 v48.l, 0xff00, v71.l                             // 00000000890C: D7620030 00028EFF FFFFFF00
	v_lshlrev_b16 v49.l, 8, v71.l                              // 000000008918: D7380031 00028E88
	v_and_b16 v49.h, 0xff00, v71.h op_sel:[0,1,1]              // 000000008920: D7625031 00028EFF FFFFFF00
	v_lshlrev_b16 v50.l, 8, v71.h op_sel:[0,1,0]               // 00000000892C: D7381032 00028E88
	v_lshlrev_b16 v25.l, 8, v25.l                              // 000000008934: D7380019 00023288
	v_and_b16 v23.h, 0xff, v38.l op_sel:[0,0,1]                // 00000000893C: D7624017 00024CFF 000000FF
	v_mov_b16_e32 v45.l, v77.l                                 // 000000008948: 7E5A394D
	v_mov_b16_e32 v41.l, v63.l                                 // 00000000894C: 7E52393F
	v_lshlrev_b16 v40.h, 8, v47.l op_sel:[0,0,1]               // 000000008950: D7384028 00025E88
	v_lshlrev_b16 v47.l, 8, v51.l                              // 000000008958: D738002F 00026688
	v_lshl_or_b32 v51, v64, 16, v62                            // 000000008960: D6560033 04F92140
	v_perm_b32 v61, v61, v65, 0xc0c0105                        // 000000008968: D644003D 03FE833D 0C0C0105
	v_perm_b32 v62, v68, v66, 0xc0c0105                        // 000000008974: D644003E 03FE8544 0C0C0105
	v_sub_nc_i16 v48.l, v48.l, v11.h op_sel:[0,1,0] clamp      // 000000008980: D70E9030 00021730
	v_sub_nc_i16 v49.l, v49.l, v21.h op_sel:[0,1,0] clamp      // 000000008988: D70E9031 00022B31
	v_sub_nc_i16 v63.l, v49.h, v26.l op_sel:[1,0,0] clamp      // 000000008990: D70E883F 00023531
	v_sub_nc_i16 v50.l, v50.l, v21.l clamp                     // 000000008998: D70E8032 00022B32
	v_and_b16 v11.h, 0xff00, v69.l op_sel:[0,0,1]              // 0000000089A0: D762400B 00028AFF FFFFFF00
	v_lshlrev_b16 v21.l, 8, v69.l                              // 0000000089AC: D7380015 00028A88
	v_and_b16 v21.h, 0xff00, v69.h op_sel:[0,1,1]              // 0000000089B4: D7625015 00028AFF FFFFFF00
	v_lshlrev_b16 v26.l, 8, v69.h op_sel:[0,1,0]               // 0000000089C0: D738101A 00028A88
	s_waitcnt lgkmcnt(7)                                       // 0000000089C8: BF89FC77
	v_xor_b32_e32 v59, v59, v70                                // 0000000089CC: 3A768D3B
	v_or_b32_e32 v30, v30, v19                                 // 0000000089D0: 383C271E
	v_or_b16 v19.h, v37.h, v42.l op_sel:[1,0,1]                // 0000000089D4: D7634813 00025525
	v_cndmask_b32_e64 v73, 0, -1, s8                           // 0000000089DC: D5010049 00218280
	v_lshlrev_b16 v45.l, 8, v45.l                              // 0000000089E4: D738002D 00025A88
	v_lshl_or_b32 v61, v62, 16, v61                            // 0000000089EC: D656003D 04F5213E
	v_dot4_i32_iu8 v51, v51, v5, v60 neg_lo:[1,1,0]            // 0000000089F4: CC164033 7CF20B33
	v_perm_b32 v49, v49, v48, 0xc0c0105                        // 0000000089FC: D6440031 03FE6131 0C0C0105
	v_perm_b32 v50, v50, v63, 0xc0c0105                        // 000000008A08: D6440032 03FE7F32 0C0C0105
	v_sub_nc_i16 v48.l, v11.h, v43.h op_sel:[1,1,0] clamp      // 000000008A14: D70E9830 0002570B
	v_sub_nc_i16 v60.l, v21.l, v40.h op_sel:[0,1,0] clamp      // 000000008A1C: D70E903C 00025115
	v_sub_nc_i16 v62.l, v21.h, v26.h op_sel:[1,1,0] clamp      // 000000008A24: D70E983E 00023515
	v_sub_nc_i16 v26.l, v26.l, v25.l clamp                     // 000000008A2C: D70E801A 0002331A
	v_and_b16 v11.h, 0xff00, v59.l op_sel:[0,0,1]              // 000000008A34: D762400B 000276FF FFFFFF00
	v_lshlrev_b16 v21.l, 8, v59.l                              // 000000008A40: D7380015 00027688
	v_and_b16 v21.h, 0xff00, v59.h op_sel:[0,1,1]              // 000000008A48: D7625015 000276FF FFFFFF00
	v_lshlrev_b16 v25.l, 8, v59.h op_sel:[0,1,0]               // 000000008A54: D7381019 00027688
	s_waitcnt lgkmcnt(6)                                       // 000000008A5C: BF89FC67
	v_xor_b32_e32 v30, v52, v30                                // 000000008A60: 3A3C3D34
	v_or_b32_e32 v33, v33, v19                                 // 000000008A64: 38422721
	v_or_b16 v19.h, v23.h, v42.h op_sel:[1,1,1]                // 000000008A68: D7635813 00025517
	v_mov_b16_e32 v22.l, v81.l                                 // 000000008A70: 7E2C3951
	v_lshlrev_b16 v27.l, 8, v27.l                              // 000000008A74: D738001B 00023688
	v_mov_b16_e32 v36.l, v73.l                                 // 000000008A7C: 7E483949
	v_lshlrev_b16 v46.l, 8, v46.l                              // 000000008A80: D738002E 00025C88
	v_lshl_or_b32 v49, v50, 16, v49                            // 000000008A88: D6560031 04C52132
	v_perm_b32 v50, v60, v48, 0xc0c0105                        // 000000008A90: D6440032 03FE613C 0C0C0105
	v_sub_nc_i16 v48.l, v11.h, v44.h op_sel:[1,1,0] clamp      // 000000008A9C: D70E9830 0002590B
	v_sub_nc_i16 v52.l, v21.l, v25.h op_sel:[0,1,0] clamp      // 000000008AA4: D70E9034 00023315
	v_sub_nc_i16 v59.l, v21.h, v36.h op_sel:[1,1,0] clamp      // 000000008AAC: D70E983B 00024915
	v_sub_nc_i16 v25.l, v25.l, v28.h op_sel:[0,1,0] clamp      // 000000008AB4: D70E9019 00023919
	v_and_b16 v11.h, 0xff00, v30.l op_sel:[0,0,1]              // 000000008ABC: D762400B 00023CFF FFFFFF00
	v_lshlrev_b16 v21.l, 8, v30.l                              // 000000008AC8: D7380015 00023C88
	v_and_b16 v21.h, 0xff00, v30.h op_sel:[0,1,1]              // 000000008AD0: D7625015 00023CFF FFFFFF00
	v_lshlrev_b16 v23.h, 8, v30.h op_sel:[0,1,1]               // 000000008ADC: D7385017 00023C88
	s_waitcnt lgkmcnt(5)                                       // 000000008AE4: BF89FC57
	v_xor_b32_e32 v30, v53, v33                                // 000000008AE8: 3A3C4335
	v_or_b32_e32 v33, v34, v19                                 // 000000008AEC: 38422722
	v_or_b16 v19.h, v28.l, v45.l op_sel:[0,0,1]                // 000000008AF0: D7634013 00025B1C
	v_mov_b16_e32 v78.h, v19.l                                 // 000000008AF8: 7F9C3913
	v_lshlrev_b16 v37.l, 8, v37.l                              // 000000008AFC: D7380025 00024A88
	v_and_b16 v29.l, 0xff, v22.l                               // 000000008B04: D762001D 00022CFF 000000FF
	v_lshlrev_b16 v36.l, 8, v36.l                              // 000000008B10: D7380024 00024888
	v_perm_b32 v28, v52, v48, 0xc0c0105                        // 000000008B18: D644001C 03FE6134 0C0C0105
	v_perm_b32 v25, v25, v59, 0xc0c0105                        // 000000008B24: D6440019 03FE7719 0C0C0105
	v_sub_nc_i16 v34.l, v11.h, v45.h op_sel:[1,1,0] clamp      // 000000008B30: D70E9822 00025B0B
	v_sub_nc_i16 v48.l, v21.l, v41.h op_sel:[0,1,0] clamp      // 000000008B38: D70E9030 00025315
	v_sub_nc_i16 v40.l, v21.h, v40.l op_sel:[1,0,0] clamp      // 000000008B40: D70E8828 00025115
	v_sub_nc_i16 v27.l, v23.h, v27.l op_sel:[1,0,0] clamp      // 000000008B48: D70E881B 00023717
	v_and_b16 v11.h, 0xff00, v30.l op_sel:[0,0,1]              // 000000008B50: D762400B 00023CFF FFFFFF00
	v_lshlrev_b16 v21.l, 8, v30.l                              // 000000008B5C: D7380015 00023C88
	v_and_b16 v21.h, 0xff00, v30.h op_sel:[0,1,1]              // 000000008B64: D7625015 00023CFF FFFFFF00
	v_lshlrev_b16 v23.h, 8, v30.h op_sel:[0,1,1]               // 000000008B70: D7385017 00023C88
	s_waitcnt lgkmcnt(4)                                       // 000000008B78: BF89FC47
	v_xor_b32_e32 v30, v54, v33                                // 000000008B7C: 3A3C4336
	v_or_b32_e32 v33, v35, v19                                 // 000000008B80: 38422723
	v_or_b16 v19.h, v39.l, v46.l op_sel:[0,0,1]                // 000000008B84: D7634013 00025D27
	v_mov_b16_e32 v76.h, v19.l                                 // 000000008B8C: 7F983913
	v_lshlrev_b16 v38.l, 8, v38.l                              // 000000008B90: D7380026 00024C88
	v_and_b16 v29.h, 0xff, v24.l op_sel:[0,0,1]                // 000000008B98: D762401D 000230FF 000000FF
	v_lshlrev_b16 v41.l, 8, v41.l                              // 000000008BA4: D7380029 00025288
	v_lshl_or_b32 v25, v25, 16, v28                            // 000000008BAC: D6560019 04712119
	v_perm_b32 v28, v48, v34, 0xc0c0105                        // 000000008BB4: D644001C 03FE4530 0C0C0105
	v_perm_b32 v34, v27, v40, 0xc0c0105                        // 000000008BC0: D6440022 03FE511B 0C0C0105
	v_sub_nc_i16 v27.l, v11.h, v46.h op_sel:[1,1,0] clamp      // 000000008BCC: D70E981B 00025D0B
	v_sub_nc_i16 v35.l, v21.l, v27.h op_sel:[0,1,0] clamp      // 000000008BD4: D70E9023 00023715
	v_sub_nc_i16 v39.l, v21.h, v42.l op_sel:[1,0,0] clamp      // 000000008BDC: D70E8827 00025515
	v_sub_nc_i16 v37.l, v23.h, v37.l op_sel:[1,0,0] clamp      // 000000008BE4: D70E8825 00024B17
	v_and_b16 v11.h, 0xff00, v30.l op_sel:[0,0,1]              // 000000008BEC: D762400B 00023CFF FFFFFF00
	v_lshlrev_b16 v21.l, 8, v30.l                              // 000000008BF8: D7380015 00023C88
	v_and_b16 v21.h, 0xff00, v30.h op_sel:[0,1,1]              // 000000008C00: D7625015 00023CFF FFFFFF00
	v_lshlrev_b16 v23.h, 8, v30.h op_sel:[0,1,1]               // 000000008C0C: D7385017 00023C88
	s_waitcnt lgkmcnt(3)                                       // 000000008C14: BF89FC37
	v_xor_b32_e32 v30, v55, v33                                // 000000008C18: 3A3C4337
	v_or_b32_e32 v33, v78, v19                                 // 000000008C1C: 3842274E
	v_or_b16 v19.h, v29.l, v36.l op_sel:[0,0,1]                // 000000008C20: D7634013 0002491D
	v_mov_b16_e32 v67.h, v19.l                                 // 000000008C28: 7F863913
	v_lshl_or_b32 v28, v34, 16, v28                            // 000000008C2C: D656001C 04712122
	v_dot4_i32_iu8 v25, v25, v1, 0 neg_lo:[1,1,0]              // 000000008C34: CC164019 7A020319
	v_perm_b32 v27, v35, v27, 0xc0c0105                        // 000000008C3C: D644001B 03FE3723 0C0C0105
	v_perm_b32 v34, v37, v39, 0xc0c0105                        // 000000008C48: D6440022 03FE4F25 0C0C0105
	v_sub_nc_i16 v29.l, v11.h, v47.h op_sel:[1,1,0] clamp      // 000000008C54: D70E981D 00025F0B
	v_sub_nc_i16 v35.l, v21.l, v44.l clamp                     // 000000008C5C: D70E8023 00025915
	v_sub_nc_i16 v37.l, v21.h, v42.h op_sel:[1,1,0] clamp      // 000000008C64: D70E9825 00025515
	v_sub_nc_i16 v38.l, v23.h, v38.l op_sel:[1,0,0] clamp      // 000000008C6C: D70E8826 00024D17
	v_and_b16 v1.l, 0xff00, v30.l                              // 000000008C74: D7620001 00023CFF FFFFFF00
	v_lshlrev_b16 v1.h, 8, v30.l op_sel:[0,0,1]                // 000000008C80: D7384001 00023C88
	v_and_b16 v11.h, 0xff00, v30.h op_sel:[0,1,1]              // 000000008C88: D762500B 00023CFF FFFFFF00
	v_lshlrev_b16 v21.l, 8, v30.h op_sel:[0,1,0]               // 000000008C94: D7381015 00023C88
	s_waitcnt lgkmcnt(2)                                       // 000000008C9C: BF89FC27
	v_xor_b32_e32 v30, v56, v33                                // 000000008CA0: 3A3C4338
	v_or_b32_e32 v33, v76, v19                                 // 000000008CA4: 3842274C
	v_or_b16 v19.h, v29.h, v41.l op_sel:[1,0,1]                // 000000008CA8: D7634813 0002531D
	v_dot4_i32_iu8 v25, v28, v2, v25 neg_lo:[1,1,0]            // 000000008CB0: CC164019 7C66051C
	v_lshl_or_b32 v27, v34, 16, v27                            // 000000008CB8: D656001B 046D2122
	v_perm_b32 v28, v35, v29, 0xc0c0105                        // 000000008CC0: D644001C 03FE3B23 0C0C0105
	v_perm_b32 v29, v38, v37, 0xc0c0105                        // 000000008CCC: D644001D 03FE4B26 0C0C0105
	v_sub_nc_i16 v34.l, v1.l, v48.h op_sel:[0,1,0] clamp       // 000000008CD8: D70E9022 00026101
	v_sub_nc_i16 v11.l, v1.h, v11.l op_sel:[1,0,0] clamp       // 000000008CE0: D70E880B 00021701
	v_sub_nc_i16 v35.l, v11.h, v45.l op_sel:[1,0,0] clamp      // 000000008CE8: D70E8823 00025B0B
	v_sub_nc_i16 v21.l, v21.l, v38.h op_sel:[0,1,0] clamp      // 000000008CF0: D70E9015 00024D15
	v_and_b16 v1.l, 0xff00, v30.l                              // 000000008CF8: D7620001 00023CFF FFFFFF00
	v_lshlrev_b16 v1.h, 8, v30.l op_sel:[0,0,1]                // 000000008D04: D7384001 00023C88
	v_and_b16 v2.l, 0xff00, v30.h op_sel:[0,1,0]               // 000000008D0C: D7621002 00023CFF FFFFFF00
	v_lshlrev_b16 v2.h, 8, v30.h op_sel:[0,1,1]                // 000000008D18: D7385002 00023C88
	s_waitcnt lgkmcnt(1)                                       // 000000008D20: BF89FC17
	v_xor_b32_e32 v30, v57, v33                                // 000000008D24: 3A3C4339
	v_or_b32_e32 v19, v67, v19                                 // 000000008D28: 38262743
	v_lshlrev_b16 v22.l, 8, v22.l                              // 000000008D2C: D7380016 00022C88
	v_lshl_or_b32 v28, v29, 16, v28                            // 000000008D34: D656001C 0471211D
	v_dot4_i32_iu8 v3, v27, v3, v25 neg_lo:[1,1,0]             // 000000008D3C: CC164003 7C66071B
	v_perm_b32 v11, v11, v34, 0xc0c0105                        // 000000008D44: D644000B 03FE450B 0C0C0105
	v_perm_b32 v21, v21, v35, 0xc0c0105                        // 000000008D50: D6440015 03FE4715 0C0C0105
	v_sub_nc_i16 v23.l, v1.l, v23.l clamp                      // 000000008D5C: D70E8017 00022F01
	v_sub_nc_i16 v25.l, v1.h, v47.l op_sel:[1,0,0] clamp       // 000000008D64: D70E8819 00025F01
	v_sub_nc_i16 v27.l, v2.l, v46.l clamp                      // 000000008D6C: D70E801B 00025D02
	v_sub_nc_i16 v29.l, v2.h, v39.h op_sel:[1,1,0] clamp       // 000000008D74: D70E981D 00024F02
	v_and_b16 v1.l, 0xff00, v30.l                              // 000000008D7C: D7620001 00023CFF FFFFFF00
	v_lshlrev_b16 v1.h, 8, v30.l op_sel:[0,0,1]                // 000000008D88: D7384001 00023C88
	v_and_b16 v2.l, 0xff00, v30.h op_sel:[0,1,0]               // 000000008D90: D7621002 00023CFF FFFFFF00
	v_lshlrev_b16 v2.h, 8, v30.h op_sel:[0,1,1]                // 000000008D9C: D7385002 00023C88
	s_waitcnt lgkmcnt(0)                                       // 000000008DA4: BF89FC07
	v_xor_b32_e32 v19, v58, v19                                // 000000008DA8: 3A26273A
	v_lshlrev_b16 v24.l, 8, v24.l                              // 000000008DAC: D7380018 00023088
	v_lshlrev_b16 v43.l, 8, v43.l                              // 000000008DB4: D738002B 00025688
	v_dot4_i32_iu8 v3, v28, v4, v3 neg_lo:[1,1,0]              // 000000008DBC: CC164003 7C0E091C
	v_lshl_or_b32 v4, v21, 16, v11                             // 000000008DC4: D6560004 042D2115
	v_perm_b32 v11, v25, v23, 0xc0c0105                        // 000000008DCC: D644000B 03FE2F19 0C0C0105
	v_perm_b32 v21, v29, v27, 0xc0c0105                        // 000000008DD8: D6440015 03FE371D 0C0C0105
	v_sub_nc_i16 v23.l, v1.l, v24.h op_sel:[0,1,0] clamp       // 000000008DE4: D70E9017 00023101
	v_sub_nc_i16 v25.l, v1.h, v22.h op_sel:[1,1,0] clamp       // 000000008DEC: D70E9819 00022D01
	v_sub_nc_i16 v27.l, v2.l, v36.l clamp                      // 000000008DF4: D70E801B 00024902
	v_sub_nc_i16 v22.l, v2.h, v22.l op_sel:[1,0,0] clamp       // 000000008DFC: D70E8816 00022D02
	v_and_b16 v1.l, 0xff00, v19.l                              // 000000008E04: D7620001 000226FF FFFFFF00
	v_lshlrev_b16 v1.h, 8, v19.l op_sel:[0,0,1]                // 000000008E10: D7384001 00022688
	v_and_b16 v2.l, 0xff00, v19.h op_sel:[0,1,0]               // 000000008E18: D7621002 000226FF FFFFFF00
	v_lshlrev_b16 v2.h, 8, v19.h op_sel:[0,1,1]                // 000000008E24: D7385002 00022688
	v_lshl_or_b32 v11, v21, 16, v11                            // 000000008E2C: D656000B 042D2115
	v_dot4_i32_iu8 v3, v4, v5, v3 neg_lo:[1,1,0]               // 000000008E34: CC164003 7C0E0B04
	v_perm_b32 v4, v25, v23, 0xc0c0105                         // 000000008E3C: D6440004 03FE2F19 0C0C0105
	v_sub_nc_i16 v1.l, v1.l, v10.h op_sel:[0,1,0] clamp        // 000000008E48: D70E9001 00021501
	v_sub_nc_i16 v5.l, v1.h, v43.l op_sel:[1,0,0] clamp        // 000000008E50: D70E8805 00025701
	v_sub_nc_i16 v2.l, v2.l, v41.l clamp                       // 000000008E58: D70E8002 00025302
	v_sub_nc_i16 v19.l, v2.h, v24.l op_sel:[1,0,0] clamp       // 000000008E60: D70E8813 00023102
	v_perm_b32 v21, v22, v27, 0xc0c0105                        // 000000008E68: D6440015 03FE3716 0C0C0105
	v_dot4_i32_iu8 v51, v61, v6, v51 neg_lo:[1,1,0]            // 000000008E74: CC164033 7CCE0D3D
	v_perm_b32 v26, v26, v62, 0xc0c0105                        // 000000008E7C: D644001A 03FE7D1A 0C0C0105
	v_dot4_i32_iu8 v3, v11, v6, v3 neg_lo:[1,1,0]              // 000000008E88: CC164003 7C0E0D0B
	v_perm_b32 v1, v5, v1, 0xc0c0105                           // 000000008E90: D6440001 03FE0305 0C0C0105
	v_perm_b32 v2, v19, v2, 0xc0c0105                          // 000000008E9C: D6440002 03FE0513 0C0C0105
	v_lshl_or_b32 v4, v21, 16, v4                              // 000000008EA8: D6560004 04112115
	v_lshl_or_b32 v5, v26, 16, v50                             // 000000008EB0: D6560005 04C9211A
	v_dot4_i32_iu8 v6, v49, v7, v51 neg_lo:[1,1,0]             // 000000008EB8: CC164006 7CCE0F31
	v_lshrrev_b32_e32 v11, 28, v31                             // 000000008EC0: 32163E9C
	v_lshl_or_b32 v1, v2, 16, v1                               // 000000008EC4: D6560001 04052102
	v_dot4_i32_iu8 v2, v4, v7, v3 neg_lo:[1,1,0]               // 000000008ECC: CC164002 7C0E0F04
	v_lshrrev_b32_e32 v7, 28, v32                              // 000000008ED4: 320E409C
	v_dot4_i32_iu8 v5, v5, v20, v6 neg_lo:[1,1,0]              // 000000008ED8: CC164005 7C1A2905
	v_add_co_u32 v8, vcc_lo, 0x480, v8                         // 000000008EE0: D7006A08 000210FF 00000480
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_4)// 000000008EEC: BF870224
	v_dot4_i32_iu8 v6, v1, v20, v2 neg_lo:[1,1,0]              // 000000008EF0: CC164006 7C0A2901
	v_cmp_le_u32_e64 s0, s33, v16                              // 000000008EF8: D44B0000 00022021
	v_lshrrev_b32_e32 v1, 31, v5                               // 000000008F00: 32020A9F
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo                // 000000008F04: D5207C09 01AA1280
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 000000008F0C: BF870214
	v_lshrrev_b32_e32 v2, 31, v6                               // 000000008F10: 32040C9F
	s_or_b32 s28, s0, s28                                      // 000000008F14: 8C1C1C00
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 000000008F18: BF870113
	v_add_nc_u32_e32 v1, v5, v1                                // 000000008F1C: 4A020305
	v_add_nc_u32_e32 v2, v6, v2                                // 000000008F20: 4A040506
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 000000008F24: BF870112
	v_ashrrev_i32_e32 v1, 1, v1                                // 000000008F28: 34020281
	v_ashrrev_i32_e32 v2, 1, v2                                // 000000008F2C: 34040481
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000008F30: BF870091
	v_mad_u64_u32 v[3:4], null, v5, v7, v[1:2]                 // 000000008F34: D6FE7C03 04060F05
	v_mad_u64_u32 v[4:5], null, v6, v11, v[2:3]                // 000000008F3C: D6FE7C04 040A1706
	v_lshrrev_b32_e32 v1, 31, v3                               // 000000008F44: 3202069F
	v_cvt_f32_f16_e32 v5, v0.l                                 // 000000008F48: 7E0A1700
	v_cvt_f32_f16_e32 v0, v0.h                                 // 000000008F4C: 7E001780
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_4)// 000000008F50: BF870233
	v_add_nc_u32_e32 v1, v3, v1                                // 000000008F54: 4A020303
	v_lshrrev_b32_e32 v2, 31, v4                               // 000000008F58: 3204089F
	v_cvt_f32_f16_e32 v3, v10.l                                // 000000008F5C: 7E06170A
	v_mul_f32_e32 v0, v0, v5                                   // 000000008F60: 10000B00
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)// 000000008F64: BF870194
	v_ashrrev_i32_e32 v1, 1, v1                                // 000000008F68: 34020281
	v_dual_mul_f32 v3, v5, v3 :: v_dual_add_nc_u32 v2, v4, v2  // 000000008F6C: C8E00705 03020504
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 000000008F74: BF870112
	v_cvt_f32_i32_e32 v1, v1                                   // 000000008F78: 7E020B01
	v_ashrrev_i32_e32 v2, 1, v2                                // 000000008F7C: 34040481
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 000000008F80: BF870112
	v_fmac_f32_e32 v15, v0, v1                                 // 000000008F84: 561E0300
	v_cvt_f32_i32_e32 v2, v2                                   // 000000008F88: 7E040B02
	s_delay_alu instid0(VALU_DEP_1)                            // 000000008F8C: BF870001
	v_fmac_f32_e32 v13, v3, v2                                 // 000000008F90: 561A0503
	s_and_not1_b32 exec_lo, exec_lo, s28                       // 000000008F94: 917E1C7E
	s_cbranch_execnz 64113                                     // 000000008F98: BFA6FA71 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x260>
	s_or_b32 exec_lo, exec_lo, s28                             // 000000008F9C: 8C7E1C7E
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 000000008FA0: BF870499
	s_or_b32 exec_lo, exec_lo, s34                             // 000000008FA4: 8C7E227E
	s_mov_b32 s1, exec_lo                                      // 000000008FA8: BE81007E
	v_cmp_eq_u32_e32 vcc_lo, 0, v14                            // 000000008FAC: 7C941C80
	v_cmpx_ne_u32_e32 0, v14                                   // 000000008FB0: 7D9A1C80
	s_cbranch_execz 8                                          // 000000008FB4: BFA50008 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x18d8>
	v_lshlrev_b32_e32 v0, 7, v14                               // 000000008FB8: 30001C87
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000008FBC: BF870091
	v_lshl_add_u32 v0, v12, 2, v0                              // 000000008FC0: D6460000 0401050C
	v_add_nc_u32_e32 v0, 0x200, v0                             // 000000008FC8: 4A0000FF 00000200
	ds_store_2addr_b32 v0, v15, v13 offset0:96 offset1:128     // 000000008FD0: D8388060 000D0F00
	s_or_b32 exec_lo, exec_lo, s1                              // 000000008FD8: 8C7E017E
	s_waitcnt lgkmcnt(0)                                       // 000000008FDC: BF89FC07
	buffer_gl0_inv                                             // 000000008FE0: E0AC0000 00000000
	s_and_saveexec_b32 s0, vcc_lo                              // 000000008FE8: BE80206A
	s_cbranch_execz 283                                        // 000000008FEC: BFA5011B <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1d5c>
	s_cmp_eq_u32 exec_lo, 0                                    // 000000008FF0: BF06807E
	s_mov_b32 s4, 0                                            // 000000008FF4: BE840080
	s_cselect_b32 s1, -1, 0                                    // 000000008FF8: 980180C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000008FFC: BF870009
	s_and_b32 vcc_lo, exec_lo, s1                              // 000000009000: 8B6A017E
	s_cbranch_vccnz 7                                          // 000000009004: BFA40007 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1924>
	s_cmp_eq_u32 exec_lo, -1                                   // 000000009008: BF06C17E
	s_mov_b32 s0, -1                                           // 00000000900C: BE8000C1
	s_cselect_b32 s1, -1, 0                                    // 000000009010: 980180C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000009014: BF870009
	s_and_not1_b32 vcc_lo, exec_lo, s1                         // 000000009018: 916A017E
	s_cbranch_vccz 4                                           // 00000000901C: BFA30004 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1930>
	s_branch 91                                                // 000000009020: BFA0005B <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1a90>
	s_mov_b32 s0, 0                                            // 000000009024: BE800080
	s_and_not1_b32 vcc_lo, exec_lo, s1                         // 000000009028: 916A017E
	s_cbranch_vccnz 65532                                      // 00000000902C: BFA4FFFC <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1920>
	v_mbcnt_lo_u32_b32 v0, -1, 0                               // 000000009030: D71F0000 000100C1
	s_cmp_eq_u32 exec_lo, 0                                    // 000000009038: BF06807E
	s_mov_b32 s0, -1                                           // 00000000903C: BE8000C1
	s_cselect_b32 s1, -1, 0                                    // 000000009040: 980180C1
	s_cmp_lg_u32 exec_lo, 0                                    // 000000009044: BF07807E
	v_xor_b32_e32 v1, 16, v0                                   // 000000009048: 3A020090
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000904C: BF8700A1
	v_cmp_gt_i32_e32 vcc_lo, 32, v1                            // 000000009050: 7C8802A0
	v_cndmask_b32_e32 v1, v0, v1, vcc_lo                       // 000000009054: 02020300
	v_dual_mov_b32 v1, 32 :: v_dual_lshlrev_b32 v2, 2, v1      // 000000009058: CA2200A0 01020282
	ds_bpermute_b32 v3, v2, v15                                // 000000009060: DACC0000 03000F02
	s_cbranch_scc0 6                                           // 000000009068: BFA10006 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1984>
	s_cmp_eq_u32 exec_lo, -1                                   // 00000000906C: BF06C17E
	s_cselect_b32 s1, -1, 0                                    // 000000009070: 980180C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000009074: BF870009
	s_and_not1_b32 vcc_lo, exec_lo, s1                         // 000000009078: 916A017E
	s_cbranch_vccz 4                                           // 00000000907C: BFA30004 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1990>
	s_branch 67                                                // 000000009080: BFA00043 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1a90>
	s_mov_b32 s0, 0                                            // 000000009084: BE800080
	s_and_not1_b32 vcc_lo, exec_lo, s1                         // 000000009088: 916A017E
	s_cbranch_vccnz 65532                                      // 00000000908C: BFA4FFFC <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1980>
	v_xor_b32_e32 v4, 8, v0                                    // 000000009090: 3A080088
	s_cmp_eq_u32 exec_lo, 0                                    // 000000009094: BF06807E
	s_cselect_b32 s1, -1, 0                                    // 000000009098: 980180C1
	s_cmp_lg_u32 exec_lo, 0                                    // 00000000909C: BF07807E
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 0000000090A0: BF8700B1
	v_cmp_gt_i32_e32 vcc_lo, 32, v4                            // 0000000090A4: 7C8808A0
	s_waitcnt lgkmcnt(0)                                       // 0000000090A8: BF89FC07
	v_dual_cndmask_b32 v5, v0, v4 :: v_dual_add_f32 v4, v15, v3// 0000000090AC: CA480900 0504070F
	v_lshlrev_b32_e32 v3, 2, v5                                // 0000000090B4: 30060A82
	ds_bpermute_b32 v5, v3, v4                                 // 0000000090B8: DACC0000 05000403
	s_cbranch_scc0 7                                           // 0000000090C0: BFA10007 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x19e0>
	s_cmp_eq_u32 exec_lo, -1                                   // 0000000090C4: BF06C17E
	s_mov_b32 s0, -1                                           // 0000000090C8: BE8000C1
	s_cselect_b32 s1, -1, 0                                    // 0000000090CC: 980180C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 0000000090D0: BF870009
	s_and_not1_b32 vcc_lo, exec_lo, s1                         // 0000000090D4: 916A017E
	s_cbranch_vccz 4                                           // 0000000090D8: BFA30004 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x19ec>
	s_branch 44                                                // 0000000090DC: BFA0002C <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1a90>
	s_mov_b32 s0, 0                                            // 0000000090E0: BE800080
	s_and_not1_b32 vcc_lo, exec_lo, s1                         // 0000000090E4: 916A017E
	s_cbranch_vccnz 65532                                      // 0000000090E8: BFA4FFFC <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x19dc>
	v_xor_b32_e32 v6, 4, v0                                    // 0000000090EC: 3A0C0084
	s_cmp_eq_u32 exec_lo, 0                                    // 0000000090F0: BF06807E
	s_cselect_b32 s1, -1, 0                                    // 0000000090F4: 980180C1
	s_cmp_lg_u32 exec_lo, 0                                    // 0000000090F8: BF07807E
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 0000000090FC: BF8700B1
	v_cmp_gt_i32_e32 vcc_lo, 32, v6                            // 000000009100: 7C880CA0
	v_cndmask_b32_e32 v6, v0, v6, vcc_lo                       // 000000009104: 020C0D00
	s_waitcnt lgkmcnt(0)                                       // 000000009108: BF89FC07
	v_dual_add_f32 v5, v4, v5 :: v_dual_lshlrev_b32 v4, 2, v6  // 00000000910C: C9220B04 05040C82
	ds_bpermute_b32 v6, v4, v5                                 // 000000009114: DACC0000 06000504
	s_cbranch_scc0 7                                           // 00000000911C: BFA10007 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1a3c>
	s_cmp_eq_u32 exec_lo, -1                                   // 000000009120: BF06C17E
	s_mov_b32 s0, -1                                           // 000000009124: BE8000C1
	s_cselect_b32 s1, -1, 0                                    // 000000009128: 980180C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000912C: BF870009
	s_and_not1_b32 vcc_lo, exec_lo, s1                         // 000000009130: 916A017E
	s_cbranch_vccz 4                                           // 000000009134: BFA30004 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1a48>
	s_branch 21                                                // 000000009138: BFA00015 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1a90>
	s_mov_b32 s0, 0                                            // 00000000913C: BE800080
	s_and_not1_b32 vcc_lo, exec_lo, s1                         // 000000009140: 916A017E
	s_cbranch_vccnz 65532                                      // 000000009144: BFA4FFFC <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1a38>
	v_xor_b32_e32 v7, 2, v0                                    // 000000009148: 3A0E0082
	s_cmp_lg_u32 exec_lo, 0                                    // 00000000914C: BF07807E
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 000000009150: BF8700B1
	v_cmp_gt_i32_e32 vcc_lo, 32, v7                            // 000000009154: 7C880EA0
	s_waitcnt lgkmcnt(0)                                       // 000000009158: BF89FC07
	v_dual_cndmask_b32 v8, v0, v7 :: v_dual_add_f32 v7, v5, v6 // 00000000915C: CA480F00 08060D05
	v_lshlrev_b32_e32 v5, 2, v8                                // 000000009164: 300A1082
	ds_bpermute_b32 v6, v5, v7                                 // 000000009168: DACC0000 06000705
	s_cbranch_scc0 5                                           // 000000009170: BFA10005 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1a88>
	s_cmp_eq_u32 exec_lo, -1                                   // 000000009174: BF06C17E
	s_cselect_b32 s4, -1, 0                                    // 000000009178: 980480C1
	s_cmp_lg_u32 exec_lo, -1                                   // 00000000917C: BF07C17E
	s_cselect_b32 s0, -1, 0                                    // 000000009180: 980080C1
	s_branch 2                                                 // 000000009184: BFA00002 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1a90>
	s_mov_b32 s0, 0                                            // 000000009188: BE800080
	s_mov_b32 s4, -1                                           // 00000000918C: BE8400C1
	s_mov_b32 s1, 0                                            // 000000009190: BE810080
	s_and_b32 vcc_lo, exec_lo, s0                              // 000000009194: 8B6A007E
	s_mov_b32 s0, 0                                            // 000000009198: BE800080
	s_cbranch_vccnz 71                                         // 00000000919C: BFA40047 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1bbc>
	s_and_not1_b32 vcc_lo, exec_lo, s4                         // 0000000091A0: 916A047E
	s_cbranch_vccnz 73                                         // 0000000091A4: BFA40049 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1bcc>
	v_xor_b32_e32 v8, 1, v0                                    // 0000000091A8: 3A100081
	s_cmp_eq_u32 exec_lo, 0                                    // 0000000091AC: BF06807E
	s_cselect_b32 s5, -1, 0                                    // 0000000091B0: 980580C1
	s_cmp_lg_u32 exec_lo, 0                                    // 0000000091B4: BF07807E
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 0000000091B8: BF8700B1
	v_cmp_lt_i32_e32 vcc_lo, v8, v1                            // 0000000091BC: 7C820308
	s_waitcnt lgkmcnt(0)                                       // 0000000091C0: BF89FC07
	v_dual_add_f32 v1, v7, v6 :: v_dual_cndmask_b32 v0, v0, v8 // 0000000091C4: C9120D07 01001100
	v_lshlrev_b32_e32 v6, 2, v0                                // 0000000091CC: 300C0082
	ds_bpermute_b32 v0, v6, v1                                 // 0000000091D0: DACC0000 00000106
	s_cbranch_scc0 7                                           // 0000000091D8: BFA10007 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1af8>
	s_cmp_eq_u32 exec_lo, -1                                   // 0000000091DC: BF06C17E
	s_mov_b32 s4, -1                                           // 0000000091E0: BE8400C1
	s_cselect_b32 s5, -1, 0                                    // 0000000091E4: 980580C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 0000000091E8: BF870009
	s_and_not1_b32 vcc_lo, exec_lo, s5                         // 0000000091EC: 916A057E
	s_cbranch_vccz 4                                           // 0000000091F0: BFA30004 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1b04>
	s_branch 73                                                // 0000000091F4: BFA00049 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1c1c>
	s_mov_b32 s4, 0                                            // 0000000091F8: BE840080
	s_and_not1_b32 vcc_lo, exec_lo, s5                         // 0000000091FC: 916A057E
	s_cbranch_vccnz 70                                         // 000000009200: BFA40046 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1c1c>
	ds_bpermute_b32 v2, v2, v13                                // 000000009204: DACC0000 02000D02
	s_cmp_eq_u32 exec_lo, 0                                    // 00000000920C: BF06807E
	s_cselect_b32 s5, -1, 0                                    // 000000009210: 980580C1
	s_cmp_lg_u32 exec_lo, 0                                    // 000000009214: BF07807E
	s_cbranch_scc0 7                                           // 000000009218: BFA10007 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1b38>
	s_cmp_eq_u32 exec_lo, -1                                   // 00000000921C: BF06C17E
	s_mov_b32 s4, -1                                           // 000000009220: BE8400C1
	s_cselect_b32 s5, -1, 0                                    // 000000009224: 980580C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000009228: BF870009
	s_and_not1_b32 vcc_lo, exec_lo, s5                         // 00000000922C: 916A057E
	s_cbranch_vccz 4                                           // 000000009230: BFA30004 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1b44>
	s_branch 57                                                // 000000009234: BFA00039 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1c1c>
	s_mov_b32 s4, 0                                            // 000000009238: BE840080
	s_and_not1_b32 vcc_lo, exec_lo, s5                         // 00000000923C: 916A057E
	s_cbranch_vccnz 54                                         // 000000009240: BFA40036 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1c1c>
	s_waitcnt lgkmcnt(0)                                       // 000000009244: BF89FC07
	v_add_f32_e32 v2, v13, v2                                  // 000000009248: 0604050D
	s_cmp_eq_u32 exec_lo, 0                                    // 00000000924C: BF06807E
	s_cselect_b32 s5, -1, 0                                    // 000000009250: 980580C1
	s_cmp_lg_u32 exec_lo, 0                                    // 000000009254: BF07807E
	ds_bpermute_b32 v3, v3, v2                                 // 000000009258: DACC0000 03000203
	s_cbranch_scc0 7                                           // 000000009260: BFA10007 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1b80>
	s_cmp_eq_u32 exec_lo, -1                                   // 000000009264: BF06C17E
	s_mov_b32 s4, -1                                           // 000000009268: BE8400C1
	s_cselect_b32 s5, -1, 0                                    // 00000000926C: 980580C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 000000009270: BF870009
	s_and_not1_b32 vcc_lo, exec_lo, s5                         // 000000009274: 916A057E
	s_cbranch_vccz 4                                           // 000000009278: BFA30004 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1b8c>
	s_branch 39                                                // 00000000927C: BFA00027 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1c1c>
	s_mov_b32 s4, 0                                            // 000000009280: BE840080
	s_and_not1_b32 vcc_lo, exec_lo, s5                         // 000000009284: 916A057E
	s_cbranch_vccnz 36                                         // 000000009288: BFA40024 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1c1c>
	s_waitcnt lgkmcnt(0)                                       // 00000000928C: BF89FC07
	v_add_f32_e32 v2, v2, v3                                   // 000000009290: 06040702
	s_cmp_eq_u32 exec_lo, 0                                    // 000000009294: BF06807E
	s_cselect_b32 s5, -1, 0                                    // 000000009298: 980580C1
	s_cmp_lg_u32 exec_lo, 0                                    // 00000000929C: BF07807E
	ds_bpermute_b32 v3, v4, v2                                 // 0000000092A0: DACC0000 03000204
	s_cbranch_scc0 11                                          // 0000000092A8: BFA1000B <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1bd8>
	s_cmp_eq_u32 exec_lo, -1                                   // 0000000092AC: BF06C17E
	s_mov_b32 s4, -1                                           // 0000000092B0: BE8400C1
	s_cselect_b32 s5, -1, 0                                    // 0000000092B4: 980580C1
	s_branch 8                                                 // 0000000092B8: BFA00008 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1bdc>
	s_cbranch_execnz 104                                       // 0000000092BC: BFA60068 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1d60>
	s_mov_b32 s0, -1                                           // 0000000092C0: BE8000C1
	s_and_not1_b32 vcc_lo, exec_lo, s4                         // 0000000092C4: 916A047E
	s_cbranch_vccz 65463                                       // 0000000092C8: BFA3FFB7 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1aa8>
	s_and_b32 vcc_lo, exec_lo, s0                              // 0000000092CC: 8B6A007E
	s_cbranch_vccnz 22                                         // 0000000092D0: BFA40016 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1c2c>
	s_branch 21                                                // 0000000092D4: BFA00015 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1c2c>
	s_mov_b32 s4, 0                                            // 0000000092D8: BE840080
	s_and_not1_b32 vcc_lo, exec_lo, s5                         // 0000000092DC: 916A057E
	s_cbranch_vccnz 14                                         // 0000000092E0: BFA4000E <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1c1c>
	s_waitcnt lgkmcnt(0)                                       // 0000000092E4: BF89FC07
	v_add_f32_e32 v3, v2, v3                                   // 0000000092E8: 06060702
	s_cmp_lg_u32 exec_lo, 0                                    // 0000000092EC: BF07807E
	ds_bpermute_b32 v2, v5, v3                                 // 0000000092F0: DACC0000 02000305
	s_cbranch_scc0 102                                         // 0000000092F8: BFA10066 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1d94>
	s_cmp_eq_u32 exec_lo, -1                                   // 0000000092FC: BF06C17E
	s_cselect_b32 s1, -1, 0                                    // 000000009300: 980180C1
	s_cmp_lg_u32 exec_lo, -1                                   // 000000009304: BF07C17E
	s_cselect_b32 s4, -1, 0                                    // 000000009308: 980480C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000930C: BF870009
	s_and_b32 vcc_lo, exec_lo, s4                              // 000000009310: 8B6A047E
	s_cbranch_vccz 3                                           // 000000009314: BFA30003 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1c24>
	s_branch 96                                                // 000000009318: BFA00060 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1d9c>
	s_and_b32 vcc_lo, exec_lo, s4                              // 00000000931C: 8B6A047E
	s_cbranch_vccnz 94                                         // 000000009320: BFA4005E <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1d9c>
	s_and_b32 vcc_lo, exec_lo, s0                              // 000000009324: 8B6A007E
	s_cbranch_vccz 0                                           // 000000009328: BFA30000 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1c2c>
	s_and_not1_b32 vcc_lo, exec_lo, s1                         // 00000000932C: 916A017E
	s_cbranch_vccnz 74                                         // 000000009330: BFA4004A <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1d5c>
	s_waitcnt lgkmcnt(0)                                       // 000000009334: BF89FC07
	v_add_f32_e32 v2, v3, v2                                   // 000000009338: 06040503
	v_cmp_eq_u32_e32 vcc_lo, 0, v12                            // 00000000933C: 7C941880
	s_mov_b32 s1, 0                                            // 000000009340: BE810080
	ds_bpermute_b32 v3, v6, v2                                 // 000000009344: DACC0000 03000206
	s_and_b32 exec_lo, exec_lo, vcc_lo                         // 00000000934C: 8B7E6A7E
	s_cbranch_execz 66                                         // 000000009350: BFA50042 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1d5c>
	s_waitcnt lgkmcnt(0)                                       // 000000009354: BF89FC07
	v_add_f32_e32 v2, v2, v3                                   // 000000009358: 06040702
	s_mul_i32 s0, s23, s3                                      // 00000000935C: 96000317
	v_add_f32_e32 v0, v1, v0                                   // 000000009360: 06000101
	s_lshl_b64 s[0:1], s[0:1], 2                               // 000000009364: 84808200
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)// 000000009368: BF8704C2
	v_mul_f32_e32 v3, 0xbfb8aa3b, v2                           // 00000000936C: 100604FF BFB8AA3B
	s_add_u32 s4, s30, s0                                      // 000000009374: 8004001E
	s_addc_u32 s5, s31, s1                                     // 000000009378: 8205011F
	s_ashr_i32 s3, s2, 31                                      // 00000000937C: 86039F02
	s_lshl_b64 s[0:1], s[2:3], 2                               // 000000009380: 84808202
	v_fma_f32 v4, 0xbfb8aa3b, v2, -v3                          // 000000009384: D6130004 840E04FF BFB8AA3B
	v_rndne_f32_e32 v5, v3                                     // 000000009390: 7E0A4703
	s_add_u32 s0, s4, s0                                       // 000000009394: 80000004
	s_addc_u32 s1, s5, s1                                      // 000000009398: 82010105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000000939C: BF8700B1
	v_sub_f32_e32 v3, v3, v5                                   // 0000000093A0: 08060B03
	v_cmp_nlt_f32_e32 vcc_lo, 0x42ce8ed0, v2                   // 0000000093A4: 7C3C04FF 42CE8ED0
	v_fmamk_f32 v4, v2, 0xb2a5705f, v4                         // 0000000093AC: 58080902 B2A5705F
	v_add_f32_e32 v3, v3, v4                                   // 0000000093B4: 06060903
	v_cvt_i32_f32_e32 v4, v5                                   // 0000000093B8: 7E081105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 0000000093BC: BF8700B2
	v_exp_f32_e32 v3, v3                                       // 0000000093C0: 7E064B03
	s_waitcnt_depctr 0xfff                                     // 0000000093C4: BF880FFF
	v_ldexp_f32 v3, v3, v4                                     // 0000000093C8: D71C0003 00020903
	v_cndmask_b32_e32 v3, 0, v3, vcc_lo                        // 0000000093D0: 02060680
	v_cmp_ngt_f32_e32 vcc_lo, 0xc2b17218, v2                   // 0000000093D4: 7C3604FF C2B17218
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000093DC: BF870092
	v_cndmask_b32_e32 v3, 0x7f800000, v3, vcc_lo               // 0000000093E0: 020606FF 7F800000
	v_add_f32_e32 v3, 1.0, v3                                  // 0000000093E8: 060606F2
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 0000000093EC: BF870091
	v_div_scale_f32 v4, null, v3, v3, v2                       // 0000000093F0: D6FC7C04 040A0703
	v_rcp_f32_e32 v5, v4                                       // 0000000093F8: 7E0A5504
	s_waitcnt_depctr 0xfff                                     // 0000000093FC: BF880FFF
	v_fma_f32 v6, -v4, v5, 1.0                                 // 000000009400: D6130006 23CA0B04
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 000000009408: BF8700A1
	v_fmac_f32_e32 v5, v6, v5                                  // 00000000940C: 560A0B06
	v_div_scale_f32 v6, vcc_lo, v2, v3, v2                     // 000000009410: D6FC6A06 040A0702
	v_mul_f32_e32 v7, v6, v5                                   // 000000009418: 100E0B06
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000941C: BF870091
	v_fma_f32 v8, -v4, v7, v6                                  // 000000009420: D6130008 241A0F04
	v_fmac_f32_e32 v7, v8, v5                                  // 000000009428: 560E0B08
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000942C: BF870091
	v_fma_f32 v4, -v4, v7, v6                                  // 000000009430: D6130004 241A0F04
	v_div_fmas_f32 v4, v4, v5, v7                              // 000000009438: D6370004 041E0B04
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 000000009440: BF870121
	v_div_fixup_f32 v1, v4, v3, v2                             // 000000009444: D6270001 040A0704
	v_mov_b32_e32 v2, 0                                        // 00000000944C: 7E040280
	v_mul_f32_e32 v0, v0, v1                                   // 000000009450: 10000300
	global_store_b32 v2, v0, s[0:1]                            // 000000009454: DC6A0000 00000002
	s_endpgm                                                   // 00000000945C: BFB00000
	s_trap 2                                                   // 000000009460: BF900002
	s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)        // 000000009464: BE804C80
	s_mov_b32 ttmp2, m0                                        // 000000009468: BEEE007D
	s_waitcnt lgkmcnt(0)                                       // 00000000946C: BF89FC07
	s_and_b32 s0, s0, 0x3ff                                    // 000000009470: 8B00FF00 000003FF
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 000000009478: BF870499
	s_bitset1_b32 s0, 10                                       // 00000000947C: BE80128A
	s_mov_b32 m0, s0                                           // 000000009480: BEFD0000
	s_sendmsg sendmsg(MSG_INTERRUPT)                           // 000000009484: BFB60001
	s_mov_b32 m0, ttmp2                                        // 000000009488: BEFD006E
	s_sethalt 5                                                // 00000000948C: BF820005
	s_branch 65534                                             // 000000009490: BFA0FFFE <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1d8c>
	s_mov_b32 s1, -1                                           // 000000009494: BE8100C1
	s_branch 65442                                             // 000000009498: BFA0FFA2 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1c24>
	s_cbranch_execnz 2                                         // 00000000949C: BFA60002 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1da8>
	s_cbranch_execnz 65442                                     // 0000000094A0: BFA6FFA2 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1c2c>
	s_branch 65441                                             // 0000000094A4: BFA0FFA1 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1c2c>
	s_trap 2                                                   // 0000000094A8: BF900002
	s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)        // 0000000094AC: BE804C80
	s_mov_b32 ttmp2, m0                                        // 0000000094B0: BEEE007D
	s_waitcnt lgkmcnt(0)                                       // 0000000094B4: BF89FC07
	s_and_b32 s0, s0, 0x3ff                                    // 0000000094B8: 8B00FF00 000003FF
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 0000000094C0: BF870499
	s_bitset1_b32 s0, 10                                       // 0000000094C4: BE80128A
	s_mov_b32 m0, s0                                           // 0000000094C8: BEFD0000
	s_sendmsg sendmsg(MSG_INTERRUPT)                           // 0000000094CC: BFB60001
	s_mov_b32 m0, ttmp2                                        // 0000000094D0: BEFD006E
	s_sethalt 5                                                // 0000000094D4: BF820005
	s_branch 65534                                             // 0000000094D8: BFA0FFFE <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1dd4>
		...

