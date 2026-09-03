_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj
000000000000a600 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj>:
	s_clause 0x1                                               // 00000000A600: BF850001
	s_load_b128 s[12:15], s[0:1], 0x20                         // 00000000A604: F4080300 F8000020
	s_load_b256 s[4:11], s[0:1], null                          // 00000000A60C: F40C0100 F8000000
	v_bfe_u32 v17, v0, 10, 10                                  // 00000000A614: D6100011 02291500
	v_dual_mov_b32 v15, 0 :: v_dual_and_b32 v14, 0x3ff, v0     // 00000000A61C: CA240080 0F0E00FF 000003FF
	v_mov_b32_e32 v16, 0                                       // 00000000A628: 7E200280
	s_mov_b32 s1, exec_lo                                      // 00000000A62C: BE81007E
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000A630: BF870092
	v_lshl_or_b32 v0, v17, 5, v14                              // 00000000A634: D6560000 04390B11
	v_lshrrev_b32_e32 v18, 3, v0                               // 00000000A63C: 32240083
	s_waitcnt lgkmcnt(0)                                       // 00000000A640: BF89FC07
	s_lshr_b32 s12, s12, 8                                     // 00000000A644: 850C880C
	s_delay_alu instid0(VALU_DEP_1) | instid1(SALU_CYCLE_1)    // 00000000A648: BF870481
	v_cmpx_gt_u32_e64 s12, v18                                 // 00000000A64C: D4CC007E 0002240C
	s_cbranch_execz 1581                                       // 00000000A654: BFA5062D <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x190c>
	v_lshl_add_u32 v0, v17, 5, v14                             // 00000000A658: D6460000 04390B11
	s_mul_i32 s0, s14, s3                                      // 00000000A660: 9600030E
	v_and_b32_e32 v4, 7, v14                                   // 00000000A664: 36081C87
	s_mul_hi_u32 s17, s0, 36                                   // 00000000A668: 9691A400
	s_mul_i32 s16, s0, 36                                      // 00000000A66C: 9610A400
	v_lshrrev_b32_e32 v2, 3, v0                                // 00000000A670: 32040083
	s_mul_i32 s14, s13, s2                                     // 00000000A674: 960E020D
	s_mov_b32 s13, 0                                           // 00000000A678: BE8D0080
	v_dual_mov_b32 v15, 0 :: v_dual_mov_b32 v16, 0             // 00000000A67C: CA100080 0F100080
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000A684: BF8700A2
	v_mad_u64_u32 v[0:1], null, 0x120, v2, s[16:17]            // 00000000A688: D6FE7C00 004204FF 00000120
	v_lshlrev_b32_e32 v2, 1, v14                               // 00000000A694: 30041C81
	v_and_b32_e32 v5, 14, v2                                   // 00000000A698: 360A048E
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000000A69C: BF870113
	v_mad_u64_u32 v[2:3], null, v4, 36, v[0:1]                 // 00000000A6A0: D6FE7C02 04014904
	v_lshlrev_b32_e32 v0, 1, v5                                // 00000000A6A8: 30000A81
	v_lshlrev_b32_e32 v19, 1, v5                               // 00000000A6AC: 30260A81
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000A6B0: BF870093
	v_add_co_u32 v1, vcc_lo, s8, v2                            // 00000000A6B4: D7006A01 00020408
	v_add_co_ci_u32_e64 v2, null, s9, v3, vcc_lo               // 00000000A6BC: D5207C02 01AA0609
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000000A6C4: BF870194
	v_lshlrev_b32_e32 v20, 1, v0                               // 00000000A6C8: 30280081
	v_add_co_u32 v8, vcc_lo, v1, 32                            // 00000000A6CC: D7006A08 00014101
	s_delay_alu instid0(VALU_DEP_1)                            // 00000000A6D4: BF870001
	v_add_co_ci_u32_e64 v9, null, 0, v2, vcc_lo                // 00000000A6D8: D5207C09 01AA0480
	v_add_nc_u32_e32 v23, s14, v18                             // 00000000A6E0: 4A2E240E
	s_getpc_b64 s[8:9]                                         // 00000000A6E4: BE884700
	s_add_u32 s8, s8, 0xffffbb98                               // 00000000A6E8: 8008FF08 FFFFBB98
	s_addc_u32 s9, s9, lit(0xffffffff)                         // 00000000A6F0: 8209FF09 FFFFFFFF
	v_mov_b16_e32 v21.l, 0                                     // 00000000A6F8: 7E2A3880
	v_add_nc_u32_e32 v18, 4, v18                               // 00000000A6FC: 4A242484
	v_mad_i64_i32 v[10:11], null, 0x42, v23, s[4:5]            // 00000000A700: D6FF7C0A 00122EFF 00000042
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000000A70C: BF870113
	v_mov_b16_e32 v32.h, v21.l                                 // 00000000A710: 7F403915
	v_add_co_u32 v0, vcc_lo, v10, v20                          // 00000000A714: D7006A00 0002290A
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000000A71C: BF8700B1
	v_add_co_ci_u32_e64 v1, null, 0, v11, vcc_lo               // 00000000A720: D5207C01 01AA1680
	global_load_b64 v[12:13], v[0:1], off                      // 00000000A728: DC560000 0C7C0000
	v_add_co_u32 v0, vcc_lo, v10, v19                          // 00000000A730: D7006A00 0002270A
	v_add_co_ci_u32_e64 v1, null, 0, v11, vcc_lo               // 00000000A738: D5207C01 01AA1680
	global_load_b32 v24, v[0:1], off offset:64                 // 00000000A740: DC520040 187C0000
	s_waitcnt vmcnt(1)                                         // 00000000A748: BF8907F7
	v_and_b32_e32 v0, 0xff, v12                                // 00000000A74C: 360018FF 000000FF
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000000A754: BF8700B1
	v_lshlrev_b32_e32 v0, 2, v0                                // 00000000A758: 30000082
	global_load_b32 v4, v0, s[8:9]                             // 00000000A75C: DC520000 04080000
	v_lshrrev_b32_e32 v0, 6, v12                               // 00000000A764: 32001886
	v_and_b32_e32 v0, 0x3fc, v0                                // 00000000A768: 360000FF 000003FC
	global_load_b32 v27, v0, s[8:9]                            // 00000000A770: DC520000 1B080000
	s_waitcnt vmcnt(2)                                         // 00000000A778: BF890BF7
	v_and_b32_e32 v0, 0xff, v24                                // 00000000A77C: 360030FF 000000FF
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000A784: BF870091
	v_bcnt_u32_b32 v1, v0, 0                                   // 00000000A788: D71E0001 00010100
	v_and_b32_e32 v1, 1, v1                                    // 00000000A790: 36020281
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000A794: BF870091
	v_lshlrev_b32_e32 v1, 7, v1                                // 00000000A798: 30020287
	v_xor_b32_e32 v0, v1, v0                                   // 00000000A79C: 3A000101
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000A7A0: BF870091
	v_mul_lo_u32 v25, 0x1010101, v0                            // 00000000A7A4: D72C0019 000200FF 01010101
	v_and_b32_e32 v0, 0x8040201, v25                           // 00000000A7B0: 360032FF 08040201
	v_bfe_i32 v2, v25, 0, 1                                    // 00000000A7B8: D6110002 02050119
	v_and_b32_e32 v26, 0x80402010, v25                         // 00000000A7C0: 363432FF 80402010
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000000A7C8: BF8701A3
	v_lshrrev_b32_e32 v1, 24, v0                               // 00000000A7CC: 32020098
	v_lshrrev_b16 v0.l, 8, v0.l                                // 00000000A7D0: D7390000 00020088
	v_lshrrev_b32_e32 v29, 24, v26                             // 00000000A7D8: 323A3498
	v_lshrrev_b16 v30.l, 4, v26.l                              // 00000000A7DC: D739001E 00023484
	v_mov_b16_e32 v29.h, v21.l                                 // 00000000A7E4: 7F3A3915
	v_cmp_ne_u16_e64 s0, 0, v1.l                               // 00000000A7E8: D43D0000 00020280
	v_cmp_ne_u16_e32 vcc_lo, 0, v0.l                           // 00000000A7F0: 7C7A0080
	v_lshrrev_b32_e32 v0, 18, v25                              // 00000000A7F4: 32003292
	v_lshrrev_b32_e32 v25, 22, v25                             // 00000000A7F8: 32323296
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_4)// 00000000A7FC: BF870224
	v_cndmask_b32_e64 v1, 0, -1, s0                            // 00000000A800: D5010001 00018280
	v_cndmask_b32_e64 v3, 0, -1, vcc_lo                        // 00000000A808: D5010003 01A98280
	v_bfe_i32 v0, v0, 0, 1                                     // 00000000A810: D6110000 02050100
	v_mov_b16_e32 v3.h, v21.l                                  // 00000000A818: 7F063915
	v_cmp_ne_u16_e64 s0, 0, v29.l                              // 00000000A81C: D43D0000 00023A80
	v_lshlrev_b16 v1.l, 8, v1.l                                // 00000000A824: D7380001 00020288
	v_lshlrev_b16 v1.h, 8, v3.l op_sel:[0,0,1]                 // 00000000A82C: D7384001 00020688
	v_and_b16 v0.h, 0xff, v0.l op_sel:[0,0,1]                  // 00000000A834: D7624000 000200FF 000000FF
	v_lshlrev_b16 v0.l, 8, v0.l                                // 00000000A840: D7380000 00020088
	v_bfe_i32 v25, v25, 0, 1                                   // 00000000A848: D6110019 02050119
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000A850: BF8700A3
	v_or_b16 v21.h, v0.h, v1.l op_sel:[1,0,1]                  // 00000000A854: D7634815 00020300
	v_and_b16 v0.h, 0xff, v2.l op_sel:[0,0,1]                  // 00000000A85C: D7624000 000204FF 000000FF
	v_or_b16 v3.l, v0.h, v1.h op_sel:[1,1,0]                   // 00000000A868: D7631803 00020300
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000A870: BF8700A1
	v_or_b32_e32 v3, v3, v21                                   // 00000000A874: 38062B03
	s_waitcnt vmcnt(1)                                         // 00000000A878: BF8907F7
	v_xor_b32_e32 v3, v4, v3                                   // 00000000A87C: 3A060704
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000A880: BF870091
	v_and_b16 v0.h, 0xff00, v3.l op_sel:[0,0,1]                // 00000000A884: D7624000 000206FF FFFFFF00
	v_sub_nc_i16 v4.l, v0.h, v1.h op_sel:[1,1,0] clamp         // 00000000A890: D70E9804 00020300
	v_lshlrev_b16 v0.h, 8, v3.l op_sel:[0,0,1]                 // 00000000A898: D7384000 00020688
	v_lshlrev_b16 v1.h, 8, v2.l op_sel:[0,0,1]                 // 00000000A8A0: D7384001 00020488
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000000A8A8: BF870121
	v_sub_nc_i16 v2.l, v0.h, v1.h op_sel:[1,1,0] clamp         // 00000000A8AC: D70E9802 00020300
	v_and_b16 v0.h, 0xff00, v3.h op_sel:[0,1,1]                // 00000000A8B4: D7625000 000206FF FFFFFF00
	v_perm_b32 v2, v2, v4, 0xc0c0105                           // 00000000A8C0: D6440002 03FE0902 0C0C0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000A8CC: BF8700A2
	v_sub_nc_i16 v1.l, v0.h, v1.l op_sel:[1,0,0] clamp         // 00000000A8D0: D70E8801 00020300
	v_lshlrev_b16 v0.h, 8, v3.h op_sel:[0,1,1]                 // 00000000A8D8: D7385000 00020688
	v_sub_nc_i16 v0.l, v0.h, v0.l op_sel:[1,0,0] clamp         // 00000000A8E0: D70E8800 00020100
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000A8E8: BF870091
	v_perm_b32 v0, v0, v1, 0xc0c0105                           // 00000000A8EC: D6440000 03FE0300 0C0C0105
	v_lshl_or_b32 v28, v0, 16, v2                              // 00000000A8F8: D656001C 04092100
	s_clause 0x2                                               // 00000000A900: BF850002
	global_load_b128 v[4:7], v[8:9], off offset:-32            // 00000000A904: DC5E1FE0 047C0008
	global_load_b32 v22, v[8:9], off                           // 00000000A90C: DC520000 167C0008
	global_load_b128 v[0:3], v[8:9], off offset:-16            // 00000000A914: DC5E1FF0 007C0008
	s_waitcnt vmcnt(2)                                         // 00000000A91C: BF890BF7
	v_lshrrev_b16 v4.h, 8, v26.l op_sel:[0,0,1]                // 00000000A920: D7394004 00023488
	v_cndmask_b32_e64 v26, 0, -1, s0                           // 00000000A928: D501001A 00018280
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000000A930: BF8701A2
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h                           // 00000000A934: 7C7B0880
	v_and_b16 v4.h, 0xff, v25.l op_sel:[0,0,1]                 // 00000000A938: D7624004 000232FF 000000FF
	v_lshlrev_b16 v25.h, 8, v26.l op_sel:[0,0,1]               // 00000000A944: D7384019 00023488
	v_cndmask_b32_e64 v26, 0, -1, vcc_lo                       // 00000000A94C: D501001A 01A98280
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000000A954: BF870112
	v_or_b16 v21.h, v4.h, v25.h op_sel:[1,1,1]                 // 00000000A958: D7635815 00023304
	v_lshlrev_b16 v4.h, 8, v26.l op_sel:[0,0,1]                // 00000000A960: D7384004 00023488
	v_bfe_i32 v26, v30, 0, 1                                   // 00000000A968: D611001A 0205011E
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000A970: BF870091
	v_and_b16 v26.h, 0xff, v26.l op_sel:[0,0,1]                // 00000000A974: D762401A 000234FF 000000FF
	v_or_b16 v29.l, v26.h, v4.h op_sel:[1,1,0]                 // 00000000A980: D763181D 0002091A
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000A988: BF870091
	v_or_b32_e32 v29, v29, v21                                 // 00000000A98C: 383A2B1D
	v_xor_b32_e32 v27, v27, v29                                // 00000000A990: 3A363B1B
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000A994: BF870091
	v_and_b16 v21.h, 0xff00, v27.l op_sel:[0,0,1]              // 00000000A998: D7624015 000236FF FFFFFF00
	v_sub_nc_i16 v29.l, v21.h, v4.h op_sel:[1,1,0] clamp       // 00000000A9A4: D70E981D 00020915
	v_lshlrev_b16 v4.h, 8, v27.l op_sel:[0,0,1]                // 00000000A9AC: D7384004 00023688
	v_lshlrev_b16 v21.h, 8, v26.l op_sel:[0,0,1]               // 00000000A9B4: D7384015 00023488
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000000A9BC: BF8701B1
	v_sub_nc_i16 v26.l, v4.h, v21.h op_sel:[1,1,0] clamp       // 00000000A9C0: D70E981A 00022B04
	v_and_b16 v4.h, 0xff00, v27.h op_sel:[0,1,1]               // 00000000A9C8: D7625004 000236FF FFFFFF00
	v_lshlrev_b16 v21.h, 8, v25.l op_sel:[0,0,1]               // 00000000A9D4: D7384015 00023288
	v_perm_b32 v26, v26, v29, 0xc0c0105                        // 00000000A9DC: D644001A 03FE3B1A 0C0C0105
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000A9E8: BF8700A3
	v_sub_nc_i16 v27.l, v4.h, v25.h op_sel:[1,1,0] clamp       // 00000000A9EC: D70E981B 00023304
	v_lshlrev_b16 v4.h, 8, v27.h op_sel:[0,1,1]                // 00000000A9F4: D7385004 00023688
	v_sub_nc_i16 v25.l, v4.h, v21.h op_sel:[1,1,0] clamp       // 00000000A9FC: D70E9819 00022B04
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000AA04: BF870091
	v_perm_b32 v25, v25, v27, 0xc0c0105                        // 00000000AA08: D6440019 03FE3719 0C0C0105
	v_lshl_or_b32 v25, v25, 16, v26                            // 00000000AA14: D6560019 04692119
	v_dot4_i32_iu8 v26, v28, v5, 0 neg_lo:[1,1,0]              // 00000000AA1C: CC16401A 7A020B1C
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 00000000AA24: BF870131
	v_dot4_i32_iu8 v27, v25, v6, v26 neg_lo:[1,1,0]            // 00000000AA28: CC16401B 7C6A0D19
	v_lshrrev_b32_e32 v25, 14, v12                             // 00000000AA30: 3232188E
	v_lshrrev_b32_e32 v12, 22, v12                             // 00000000AA34: 32181896
	v_and_b32_e32 v25, 0x3fc, v25                              // 00000000AA38: 363232FF 000003FC
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_4) | instid1(VALU_DEP_1)// 00000000AA40: BF8700D2
	v_and_b32_e32 v12, 0x3fc, v12                              // 00000000AA44: 361818FF 000003FC
	s_clause 0x1                                               // 00000000AA4C: BF850001
	global_load_b32 v28, v25, s[8:9]                           // 00000000AA50: DC520000 1C080019
	global_load_b32 v29, v12, s[8:9]                           // 00000000AA58: DC520000 1D08000C
	v_bfe_u32 v12, v24, 7, 8                                   // 00000000AA60: D610000C 02210F18
	v_bcnt_u32_b32 v25, v12, 0                                 // 00000000AA68: D71E0019 0001010C
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000AA70: BF870091
	v_and_b32_e32 v25, 1, v25                                  // 00000000AA74: 36323281
	v_lshlrev_b32_e32 v25, 7, v25                              // 00000000AA78: 30323287
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000AA7C: BF870091
	v_xor_b32_e32 v12, v25, v12                                // 00000000AA80: 3A181919
	v_mul_lo_u32 v30, 0x1010101, v12                           // 00000000AA84: D72C001E 000218FF 01010101
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000AA90: BF870091
	v_and_b32_e32 v12, 0x8040201, v30                          // 00000000AA94: 36183CFF 08040201
	v_lshrrev_b32_e32 v25, 24, v12                             // 00000000AA9C: 32321898
	v_lshrrev_b16 v4.h, 8, v12.l op_sel:[0,0,1]                // 00000000AAA0: D7394004 00021888
	v_lshrrev_b32_e32 v12, 18, v30                             // 00000000AAA8: 32183C92
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000000AAAC: BF870193
	v_cmp_ne_u16_e64 s0, 0, v25.l                              // 00000000AAB0: D43D0000 00023280
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h                           // 00000000AAB8: 7C7B0880
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000000AABC: BF870193
	v_bfe_i32 v12, v12, 0, 1                                   // 00000000AAC0: D611000C 0205010C
	v_cndmask_b32_e64 v25, 0, -1, s0                           // 00000000AAC8: D5010019 00018280
	v_cndmask_b32_e64 v26, 0, -1, vcc_lo                       // 00000000AAD0: D501001A 01A98280
	s_delay_alu instid0(VALU_DEP_3)                            // 00000000AAD8: BF870003
	v_and_b16 v4.h, 0xff, v12.l op_sel:[0,0,1]                 // 00000000AADC: D7624004 000218FF 000000FF
	v_mov_b16_e32 v26.h, v21.l                                 // 00000000AAE8: 7F343915
	v_lshlrev_b16 v12.l, 8, v12.l                              // 00000000AAEC: D738000C 00021888
	v_lshlrev_b16 v12.h, 8, v25.l op_sel:[0,0,1]               // 00000000AAF4: D738400C 00023288
	v_bfe_i32 v25, v30, 0, 1                                   // 00000000AAFC: D6110019 0205011E
	v_lshlrev_b16 v25.h, 8, v26.l op_sel:[0,0,1]               // 00000000AB04: D7384019 00023488
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000000AB0C: BF870193
	v_or_b16 v21.h, v4.h, v12.h op_sel:[1,1,1]                 // 00000000AB10: D7635815 00021904
	v_and_b16 v4.h, 0xff, v25.l op_sel:[0,0,1]                 // 00000000AB18: D7624004 000232FF 000000FF
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000AB24: BF870091
	v_or_b16 v26.l, v4.h, v25.h op_sel:[1,1,0]                 // 00000000AB28: D763181A 00023304
	v_or_b32_e32 v26, v26, v21                                 // 00000000AB30: 38342B1A
	v_lshlrev_b16 v21.h, 8, v25.l op_sel:[0,0,1]               // 00000000AB34: D7384015 00023288
	s_waitcnt vmcnt(1)                                         // 00000000AB3C: BF8907F7
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000AB40: BF870092
	v_xor_b32_e32 v26, v28, v26                                // 00000000AB44: 3A34351C
	v_and_b16 v4.h, 0xff00, v26.l op_sel:[0,0,1]               // 00000000AB48: D7624004 000234FF FFFFFF00
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000AB54: BF8700A1
	v_sub_nc_i16 v28.l, v4.h, v25.h op_sel:[1,1,0] clamp       // 00000000AB58: D70E981C 00023304
	v_lshlrev_b16 v4.h, 8, v26.l op_sel:[0,0,1]                // 00000000AB60: D7384004 00023488
	v_sub_nc_i16 v25.l, v4.h, v21.h op_sel:[1,1,0] clamp       // 00000000AB68: D70E9819 00022B04
	v_and_b16 v4.h, 0xff00, v26.h op_sel:[0,1,1]               // 00000000AB70: D7625004 000234FF FFFFFF00
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000000AB7C: BF870112
	v_perm_b32 v25, v25, v28, 0xc0c0105                        // 00000000AB80: D6440019 03FE3919 0C0C0105
	v_sub_nc_i16 v26.l, v4.h, v12.h op_sel:[1,1,0] clamp       // 00000000AB8C: D70E981A 00021904
	v_lshlrev_b16 v4.h, 8, v26.h op_sel:[0,1,1]                // 00000000AB94: D7385004 00023488
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000AB9C: BF870091
	v_sub_nc_i16 v12.l, v4.h, v12.l op_sel:[1,0,0] clamp       // 00000000ABA0: D70E880C 00021904
	v_perm_b32 v12, v12, v26, 0xc0c0105                        // 00000000ABA8: D644000C 03FE350C 0C0C0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000ABB4: BF8700A1
	v_lshl_or_b32 v26, v12, 16, v25                            // 00000000ABB8: D656001A 0465210C
	v_and_b32_e32 v12, 0x80402010, v30                         // 00000000ABC0: 36183CFF 80402010
	v_lshrrev_b32_e32 v25, 24, v12                             // 00000000ABC8: 32321898
	v_lshrrev_b16 v4.h, 8, v12.l op_sel:[0,0,1]                // 00000000ABCC: D7394004 00021888
	v_lshrrev_b16 v28.l, 4, v12.l                              // 00000000ABD4: D739001C 00021884
	v_lshrrev_b32_e32 v12, 22, v30                             // 00000000ABDC: 32183C96
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000000ABE0: BF870214
	v_cmp_ne_u16_e64 s0, 0, v25.l                              // 00000000ABE4: D43D0000 00023280
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h                           // 00000000ABEC: 7C7B0880
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000000ABF0: BF870193
	v_bfe_i32 v12, v12, 0, 1                                   // 00000000ABF4: D611000C 0205010C
	v_cndmask_b32_e64 v25, 0, -1, s0                           // 00000000ABFC: D5010019 00018280
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000000AC04: BF8701A2
	v_and_b16 v4.h, 0xff, v12.l op_sel:[0,0,1]                 // 00000000AC08: D7624004 000218FF 000000FF
	v_lshlrev_b16 v12.l, 8, v12.l                              // 00000000AC14: D738000C 00021888
	v_lshlrev_b16 v12.h, 8, v25.l op_sel:[0,0,1]               // 00000000AC1C: D738400C 00023288
	v_cndmask_b32_e64 v25, 0, -1, vcc_lo                       // 00000000AC24: D5010019 01A98280
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000000AC2C: BF870112
	v_or_b16 v21.h, v4.h, v12.h op_sel:[1,1,1]                 // 00000000AC30: D7635815 00021904
	v_lshlrev_b16 v4.h, 8, v25.l op_sel:[0,0,1]                // 00000000AC38: D7384004 00023288
	v_bfe_i32 v25, v28, 0, 1                                   // 00000000AC40: D6110019 0205011C
	v_mov_b16_e32 v28.h, v21.l                                 // 00000000AC48: 7F383915
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000AC4C: BF870092
	v_and_b16 v25.h, 0xff, v25.l op_sel:[0,0,1]                // 00000000AC50: D7624019 000232FF 000000FF
	v_or_b16 v28.l, v25.h, v4.h op_sel:[1,1,0]                 // 00000000AC5C: D763181C 00020919
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000AC64: BF8700A1
	v_or_b32_e32 v28, v28, v21                                 // 00000000AC68: 38382B1C
	s_waitcnt vmcnt(0)                                         // 00000000AC6C: BF8903F7
	v_xor_b32_e32 v28, v29, v28                                // 00000000AC70: 3A38391D
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000AC74: BF870091
	v_and_b16 v21.h, 0xff00, v28.l op_sel:[0,0,1]              // 00000000AC78: D7624015 000238FF FFFFFF00
	v_sub_nc_i16 v29.l, v21.h, v4.h op_sel:[1,1,0] clamp       // 00000000AC84: D70E981D 00020915
	v_lshlrev_b16 v4.h, 8, v28.l op_sel:[0,0,1]                // 00000000AC8C: D7384004 00023888
	v_lshlrev_b16 v21.h, 8, v25.l op_sel:[0,0,1]               // 00000000AC94: D7384015 00023288
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000000AC9C: BF870121
	v_sub_nc_i16 v25.l, v4.h, v21.h op_sel:[1,1,0] clamp       // 00000000ACA0: D70E9819 00022B04
	v_and_b16 v4.h, 0xff00, v28.h op_sel:[0,1,1]               // 00000000ACA8: D7625004 000238FF FFFFFF00
	v_perm_b32 v25, v25, v29, 0xc0c0105                        // 00000000ACB4: D6440019 03FE3B19 0C0C0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000ACC0: BF8700A2
	v_sub_nc_i16 v28.l, v4.h, v12.h op_sel:[1,1,0] clamp       // 00000000ACC4: D70E981C 00021904
	v_lshlrev_b16 v4.h, 8, v28.h op_sel:[0,1,1]                // 00000000ACCC: D7385004 00023888
	v_sub_nc_i16 v12.l, v4.h, v12.l op_sel:[1,0,0] clamp       // 00000000ACD4: D70E880C 00021904
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000ACDC: BF870091
	v_perm_b32 v12, v12, v28, 0xc0c0105                        // 00000000ACE0: D644000C 03FE390C 0C0C0105
	v_lshl_or_b32 v12, v12, 16, v25                            // 00000000ACEC: D656000C 0465210C
	v_dot4_i32_iu8 v25, v26, v7, v27 neg_lo:[1,1,0]            // 00000000ACF4: CC164019 7C6E0F1A
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000ACFC: BF8700A1
	v_dot4_i32_iu8 v27, v12, v0, v25 neg_lo:[1,1,0]            // 00000000AD00: CC16401B 7C66010C
	v_and_b32_e32 v12, 0xff, v13                               // 00000000AD08: 36181AFF 000000FF
	v_lshlrev_b32_e32 v12, 2, v12                              // 00000000AD10: 30181882
	global_load_b32 v28, v12, s[8:9]                           // 00000000AD14: DC520000 1C08000C
	v_lshrrev_b32_e32 v12, 6, v13                              // 00000000AD1C: 32181A86
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000000AD20: BF8700B1
	v_and_b32_e32 v12, 0x3fc, v12                              // 00000000AD24: 361818FF 000003FC
	global_load_b32 v29, v12, s[8:9]                           // 00000000AD2C: DC520000 1D08000C
	v_bfe_u32 v12, v24, 14, 8                                  // 00000000AD34: D610000C 02211D18
	v_bcnt_u32_b32 v25, v12, 0                                 // 00000000AD3C: D71E0019 0001010C
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000AD44: BF870091
	v_and_b32_e32 v25, 1, v25                                  // 00000000AD48: 36323281
	v_lshlrev_b32_e32 v25, 7, v25                              // 00000000AD4C: 30323287
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000AD50: BF870091
	v_xor_b32_e32 v12, v25, v12                                // 00000000AD54: 3A181919
	v_mul_lo_u32 v30, 0x1010101, v12                           // 00000000AD58: D72C001E 000218FF 01010101
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000AD64: BF870091
	v_and_b32_e32 v12, 0x8040201, v30                          // 00000000AD68: 36183CFF 08040201
	v_lshrrev_b32_e32 v25, 24, v12                             // 00000000AD70: 32321898
	v_lshrrev_b16 v4.h, 8, v12.l op_sel:[0,0,1]                // 00000000AD74: D7394004 00021888
	v_lshrrev_b32_e32 v12, 18, v30                             // 00000000AD7C: 32183C92
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000000AD80: BF870193
	v_cmp_ne_u16_e64 s0, 0, v25.l                              // 00000000AD84: D43D0000 00023280
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h                           // 00000000AD8C: 7C7B0880
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000000AD90: BF870193
	v_bfe_i32 v12, v12, 0, 1                                   // 00000000AD94: D611000C 0205010C
	v_cndmask_b32_e64 v25, 0, -1, s0                           // 00000000AD9C: D5010019 00018280
	v_cndmask_b32_e64 v26, 0, -1, vcc_lo                       // 00000000ADA4: D501001A 01A98280
	s_delay_alu instid0(VALU_DEP_3)                            // 00000000ADAC: BF870003
	v_and_b16 v4.h, 0xff, v12.l op_sel:[0,0,1]                 // 00000000ADB0: D7624004 000218FF 000000FF
	v_mov_b16_e32 v26.h, v21.l                                 // 00000000ADBC: 7F343915
	v_lshlrev_b16 v12.l, 8, v12.l                              // 00000000ADC0: D738000C 00021888
	v_lshlrev_b16 v12.h, 8, v25.l op_sel:[0,0,1]               // 00000000ADC8: D738400C 00023288
	v_bfe_i32 v25, v30, 0, 1                                   // 00000000ADD0: D6110019 0205011E
	v_lshlrev_b16 v25.h, 8, v26.l op_sel:[0,0,1]               // 00000000ADD8: D7384019 00023488
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000000ADE0: BF870193
	v_or_b16 v21.h, v4.h, v12.h op_sel:[1,1,1]                 // 00000000ADE4: D7635815 00021904
	v_and_b16 v4.h, 0xff, v25.l op_sel:[0,0,1]                 // 00000000ADEC: D7624004 000232FF 000000FF
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000ADF8: BF870091
	v_or_b16 v26.l, v4.h, v25.h op_sel:[1,1,0]                 // 00000000ADFC: D763181A 00023304
	v_or_b32_e32 v26, v26, v21                                 // 00000000AE04: 38342B1A
	v_lshlrev_b16 v21.h, 8, v25.l op_sel:[0,0,1]               // 00000000AE08: D7384015 00023288
	s_waitcnt vmcnt(1)                                         // 00000000AE10: BF8907F7
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000AE14: BF870092
	v_xor_b32_e32 v26, v28, v26                                // 00000000AE18: 3A34351C
	v_and_b16 v4.h, 0xff00, v26.l op_sel:[0,0,1]               // 00000000AE1C: D7624004 000234FF FFFFFF00
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000AE28: BF8700A1
	v_sub_nc_i16 v28.l, v4.h, v25.h op_sel:[1,1,0] clamp       // 00000000AE2C: D70E981C 00023304
	v_lshlrev_b16 v4.h, 8, v26.l op_sel:[0,0,1]                // 00000000AE34: D7384004 00023488
	v_sub_nc_i16 v25.l, v4.h, v21.h op_sel:[1,1,0] clamp       // 00000000AE3C: D70E9819 00022B04
	v_and_b16 v4.h, 0xff00, v26.h op_sel:[0,1,1]               // 00000000AE44: D7625004 000234FF FFFFFF00
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000000AE50: BF870112
	v_perm_b32 v25, v25, v28, 0xc0c0105                        // 00000000AE54: D6440019 03FE3919 0C0C0105
	v_sub_nc_i16 v26.l, v4.h, v12.h op_sel:[1,1,0] clamp       // 00000000AE60: D70E981A 00021904
	v_lshlrev_b16 v4.h, 8, v26.h op_sel:[0,1,1]                // 00000000AE68: D7385004 00023488
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000AE70: BF870091
	v_sub_nc_i16 v12.l, v4.h, v12.l op_sel:[1,0,0] clamp       // 00000000AE74: D70E880C 00021904
	v_perm_b32 v12, v12, v26, 0xc0c0105                        // 00000000AE7C: D644000C 03FE350C 0C0C0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000AE88: BF8700A1
	v_lshl_or_b32 v26, v12, 16, v25                            // 00000000AE8C: D656001A 0465210C
	v_and_b32_e32 v12, 0x80402010, v30                         // 00000000AE94: 36183CFF 80402010
	v_lshrrev_b32_e32 v25, 24, v12                             // 00000000AE9C: 32321898
	v_lshrrev_b16 v4.h, 8, v12.l op_sel:[0,0,1]                // 00000000AEA0: D7394004 00021888
	v_lshrrev_b16 v28.l, 4, v12.l                              // 00000000AEA8: D739001C 00021884
	v_lshrrev_b32_e32 v12, 22, v30                             // 00000000AEB0: 32183C96
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000000AEB4: BF870214
	v_cmp_ne_u16_e64 s0, 0, v25.l                              // 00000000AEB8: D43D0000 00023280
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h                           // 00000000AEC0: 7C7B0880
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000000AEC4: BF870193
	v_bfe_i32 v12, v12, 0, 1                                   // 00000000AEC8: D611000C 0205010C
	v_cndmask_b32_e64 v25, 0, -1, s0                           // 00000000AED0: D5010019 00018280
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000000AED8: BF8701A2
	v_and_b16 v4.h, 0xff, v12.l op_sel:[0,0,1]                 // 00000000AEDC: D7624004 000218FF 000000FF
	v_lshlrev_b16 v12.l, 8, v12.l                              // 00000000AEE8: D738000C 00021888
	v_lshlrev_b16 v12.h, 8, v25.l op_sel:[0,0,1]               // 00000000AEF0: D738400C 00023288
	v_cndmask_b32_e64 v25, 0, -1, vcc_lo                       // 00000000AEF8: D5010019 01A98280
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000000AF00: BF870112
	v_or_b16 v21.h, v4.h, v12.h op_sel:[1,1,1]                 // 00000000AF04: D7635815 00021904
	v_lshlrev_b16 v4.h, 8, v25.l op_sel:[0,0,1]                // 00000000AF0C: D7384004 00023288
	v_bfe_i32 v25, v28, 0, 1                                   // 00000000AF14: D6110019 0205011C
	v_mov_b16_e32 v28.h, v21.l                                 // 00000000AF1C: 7F383915
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000AF20: BF870092
	v_and_b16 v25.h, 0xff, v25.l op_sel:[0,0,1]                // 00000000AF24: D7624019 000232FF 000000FF
	v_or_b16 v28.l, v25.h, v4.h op_sel:[1,1,0]                 // 00000000AF30: D763181C 00020919
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000AF38: BF8700A1
	v_or_b32_e32 v28, v28, v21                                 // 00000000AF3C: 38382B1C
	s_waitcnt vmcnt(0)                                         // 00000000AF40: BF8903F7
	v_xor_b32_e32 v28, v29, v28                                // 00000000AF44: 3A38391D
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000AF48: BF870091
	v_and_b16 v21.h, 0xff00, v28.l op_sel:[0,0,1]              // 00000000AF4C: D7624015 000238FF FFFFFF00
	v_sub_nc_i16 v29.l, v21.h, v4.h op_sel:[1,1,0] clamp       // 00000000AF58: D70E981D 00020915
	v_lshlrev_b16 v4.h, 8, v28.l op_sel:[0,0,1]                // 00000000AF60: D7384004 00023888
	v_lshlrev_b16 v21.h, 8, v25.l op_sel:[0,0,1]               // 00000000AF68: D7384015 00023288
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000000AF70: BF870121
	v_sub_nc_i16 v25.l, v4.h, v21.h op_sel:[1,1,0] clamp       // 00000000AF74: D70E9819 00022B04
	v_and_b16 v4.h, 0xff00, v28.h op_sel:[0,1,1]               // 00000000AF7C: D7625004 000238FF FFFFFF00
	v_perm_b32 v25, v25, v29, 0xc0c0105                        // 00000000AF88: D6440019 03FE3B19 0C0C0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000AF94: BF8700A2
	v_sub_nc_i16 v28.l, v4.h, v12.h op_sel:[1,1,0] clamp       // 00000000AF98: D70E981C 00021904
	v_lshlrev_b16 v4.h, 8, v28.h op_sel:[0,1,1]                // 00000000AFA0: D7385004 00023888
	v_sub_nc_i16 v12.l, v4.h, v12.l op_sel:[1,0,0] clamp       // 00000000AFA8: D70E880C 00021904
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000AFB0: BF870091
	v_perm_b32 v12, v12, v28, 0xc0c0105                        // 00000000AFB4: D644000C 03FE390C 0C0C0105
	v_lshl_or_b32 v12, v12, 16, v25                            // 00000000AFC0: D656000C 0465210C
	v_dot4_i32_iu8 v25, v26, v1, v27 neg_lo:[1,1,0]            // 00000000AFC8: CC164019 7C6E031A
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000AFD0: BF8700A1
	v_dot4_i32_iu8 v26, v12, v2, v25 neg_lo:[1,1,0]            // 00000000AFD4: CC16401A 7C66050C
	v_lshrrev_b32_e32 v12, 14, v13                             // 00000000AFDC: 32181A8E
	v_and_b32_e32 v12, 0x3fc, v12                              // 00000000AFE0: 361818FF 000003FC
	global_load_b32 v27, v12, s[8:9]                           // 00000000AFE8: DC520000 1B08000C
	v_lshrrev_b32_e32 v12, 22, v13                             // 00000000AFF0: 32181A96
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000000AFF4: BF8700B1
	v_and_b32_e32 v12, 0x3fc, v12                              // 00000000AFF8: 361818FF 000003FC
	global_load_b32 v28, v12, s[8:9]                           // 00000000B000: DC520000 1C08000C
	v_bfe_u32 v12, v24, 21, 8                                  // 00000000B008: D610000C 02212B18
	v_bcnt_u32_b32 v13, v12, 0                                 // 00000000B010: D71E000D 0001010C
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B018: BF870091
	v_and_b32_e32 v13, 1, v13                                  // 00000000B01C: 361A1A81
	v_lshlrev_b32_e32 v13, 7, v13                              // 00000000B020: 301A1A87
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B024: BF870091
	v_xor_b32_e32 v12, v13, v12                                // 00000000B028: 3A18190D
	v_mul_lo_u32 v29, 0x1010101, v12                           // 00000000B02C: D72C001D 000218FF 01010101
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B038: BF870091
	v_and_b32_e32 v12, 0x8040201, v29                          // 00000000B03C: 36183AFF 08040201
	v_lshrrev_b32_e32 v13, 24, v12                             // 00000000B044: 321A1898
	v_lshrrev_b16 v4.h, 8, v12.l op_sel:[0,0,1]                // 00000000B048: D7394004 00021888
	v_lshrrev_b32_e32 v12, 18, v29                             // 00000000B050: 32183A92
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000000B054: BF870193
	v_cmp_ne_u16_e64 s0, 0, v13.l                              // 00000000B058: D43D0000 00021A80
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h                           // 00000000B060: 7C7B0880
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000000B064: BF870193
	v_bfe_i32 v12, v12, 0, 1                                   // 00000000B068: D611000C 0205010C
	v_cndmask_b32_e64 v13, 0, -1, s0                           // 00000000B070: D501000D 00018280
	v_cndmask_b32_e64 v25, 0, -1, vcc_lo                       // 00000000B078: D5010019 01A98280
	s_delay_alu instid0(VALU_DEP_3)                            // 00000000B080: BF870003
	v_and_b16 v4.h, 0xff, v12.l op_sel:[0,0,1]                 // 00000000B084: D7624004 000218FF 000000FF
	v_mov_b16_e32 v25.h, v21.l                                 // 00000000B090: 7F323915
	v_lshlrev_b16 v12.l, 8, v12.l                              // 00000000B094: D738000C 00021888
	v_lshlrev_b16 v12.h, 8, v13.l op_sel:[0,0,1]               // 00000000B09C: D738400C 00021A88
	v_bfe_i32 v13, v29, 0, 1                                   // 00000000B0A4: D611000D 0205011D
	v_lshlrev_b16 v13.h, 8, v25.l op_sel:[0,0,1]               // 00000000B0AC: D738400D 00023288
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000000B0B4: BF870193
	v_or_b16 v21.h, v4.h, v12.h op_sel:[1,1,1]                 // 00000000B0B8: D7635815 00021904
	v_and_b16 v4.h, 0xff, v13.l op_sel:[0,0,1]                 // 00000000B0C0: D7624004 00021AFF 000000FF
	v_lshlrev_b16 v13.l, 8, v13.l                              // 00000000B0CC: D738000D 00021A88
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B0D4: BF870092
	v_or_b16 v25.l, v4.h, v13.h op_sel:[1,1,0]                 // 00000000B0D8: D7631819 00021B04
	v_or_b32_e32 v25, v25, v21                                 // 00000000B0E0: 38322B19
	s_waitcnt vmcnt(1)                                         // 00000000B0E4: BF8907F7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B0E8: BF870091
	v_xor_b32_e32 v25, v27, v25                                // 00000000B0EC: 3A32331B
	v_and_b16 v4.h, 0xff00, v25.l op_sel:[0,0,1]               // 00000000B0F0: D7624004 000232FF FFFFFF00
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000B0FC: BF8700A1
	v_sub_nc_i16 v27.l, v4.h, v13.h op_sel:[1,1,0] clamp       // 00000000B100: D70E981B 00021B04
	v_lshlrev_b16 v4.h, 8, v25.l op_sel:[0,0,1]                // 00000000B108: D7384004 00023288
	v_sub_nc_i16 v13.l, v4.h, v13.l op_sel:[1,0,0] clamp       // 00000000B110: D70E880D 00021B04
	v_and_b16 v4.h, 0xff00, v25.h op_sel:[0,1,1]               // 00000000B118: D7625004 000232FF FFFFFF00
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000000B124: BF870112
	v_perm_b32 v13, v13, v27, 0xc0c0105                        // 00000000B128: D644000D 03FE370D 0C0C0105
	v_sub_nc_i16 v25.l, v4.h, v12.h op_sel:[1,1,0] clamp       // 00000000B134: D70E9819 00021904
	v_lshlrev_b16 v4.h, 8, v25.h op_sel:[0,1,1]                // 00000000B13C: D7385004 00023288
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B144: BF870091
	v_sub_nc_i16 v12.l, v4.h, v12.l op_sel:[1,0,0] clamp       // 00000000B148: D70E880C 00021904
	v_perm_b32 v12, v12, v25, 0xc0c0105                        // 00000000B150: D644000C 03FE330C 0C0C0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000B15C: BF8700A1
	v_lshl_or_b32 v25, v12, 16, v13                            // 00000000B160: D6560019 0435210C
	v_and_b32_e32 v12, 0x80402010, v29                         // 00000000B168: 36183AFF 80402010
	v_lshrrev_b32_e32 v13, 24, v12                             // 00000000B170: 321A1898
	v_lshrrev_b16 v4.h, 8, v12.l op_sel:[0,0,1]                // 00000000B174: D7394004 00021888
	v_lshrrev_b16 v27.l, 4, v12.l                              // 00000000B17C: D739001B 00021884
	v_lshrrev_b32_e32 v12, 22, v29                             // 00000000B184: 32183A96
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000000B188: BF870214
	v_cmp_ne_u16_e64 s0, 0, v13.l                              // 00000000B18C: D43D0000 00021A80
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h                           // 00000000B194: 7C7B0880
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000000B198: BF870193
	v_bfe_i32 v12, v12, 0, 1                                   // 00000000B19C: D611000C 0205010C
	v_cndmask_b32_e64 v13, 0, -1, s0                           // 00000000B1A4: D501000D 00018280
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000000B1AC: BF8701A2
	v_and_b16 v4.h, 0xff, v12.l op_sel:[0,0,1]                 // 00000000B1B0: D7624004 000218FF 000000FF
	v_lshlrev_b16 v12.l, 8, v12.l                              // 00000000B1BC: D738000C 00021888
	v_lshlrev_b16 v12.h, 8, v13.l op_sel:[0,0,1]               // 00000000B1C4: D738400C 00021A88
	v_cndmask_b32_e64 v13, 0, -1, vcc_lo                       // 00000000B1CC: D501000D 01A98280
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000000B1D4: BF870112
	v_or_b16 v21.h, v4.h, v12.h op_sel:[1,1,1]                 // 00000000B1D8: D7635815 00021904
	v_lshlrev_b16 v4.h, 8, v13.l op_sel:[0,0,1]                // 00000000B1E0: D7384004 00021A88
	v_bfe_i32 v13, v27, 0, 1                                   // 00000000B1E8: D611000D 0205011B
	v_mov_b16_e32 v27.h, v21.l                                 // 00000000B1F0: 7F363915
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000000B1F4: BF870122
	v_and_b16 v13.h, 0xff, v13.l op_sel:[0,0,1]                // 00000000B1F8: D762400D 00021AFF 000000FF
	v_lshlrev_b16 v13.l, 8, v13.l                              // 00000000B204: D738000D 00021A88
	v_or_b16 v27.l, v13.h, v4.h op_sel:[1,1,0]                 // 00000000B20C: D763181B 0002090D
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000B214: BF8700A1
	v_or_b32_e32 v27, v27, v21                                 // 00000000B218: 38362B1B
	s_waitcnt vmcnt(0)                                         // 00000000B21C: BF8903F7
	v_xor_b32_e32 v27, v28, v27                                // 00000000B220: 3A36371C
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B224: BF870091
	v_and_b16 v13.h, 0xff00, v27.l op_sel:[0,0,1]              // 00000000B228: D762400D 000236FF FFFFFF00
	v_sub_nc_i16 v28.l, v13.h, v4.h op_sel:[1,1,0] clamp       // 00000000B234: D70E981C 0002090D
	v_lshlrev_b16 v4.h, 8, v27.l op_sel:[0,0,1]                // 00000000B23C: D7384004 00023688
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000000B244: BF870121
	v_sub_nc_i16 v13.l, v4.h, v13.l op_sel:[1,0,0] clamp       // 00000000B248: D70E880D 00021B04
	v_and_b16 v4.h, 0xff00, v27.h op_sel:[0,1,1]               // 00000000B250: D7625004 000236FF FFFFFF00
	v_perm_b32 v13, v13, v28, 0xc0c0105                        // 00000000B25C: D644000D 03FE390D 0C0C0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000B268: BF8700A2
	v_sub_nc_i16 v27.l, v4.h, v12.h op_sel:[1,1,0] clamp       // 00000000B26C: D70E981B 00021904
	v_lshlrev_b16 v4.h, 8, v27.h op_sel:[0,1,1]                // 00000000B274: D7385004 00023688
	v_sub_nc_i16 v12.l, v4.h, v12.l op_sel:[1,0,0] clamp       // 00000000B27C: D70E880C 00021904
	global_load_d16_hi_b16 v4, v[10:11], off offset:64         // 00000000B284: DC8E0040 047C000A
	v_perm_b32 v12, v12, v27, 0xc0c0105                        // 00000000B28C: D644000C 03FE370C 0C0C0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 00000000B298: BF870131
	v_lshl_or_b32 v12, v12, 16, v13                            // 00000000B29C: D656000C 0435210C
	v_dot4_i32_iu8 v13, v25, v3, v26 neg_lo:[1,1,0]            // 00000000B2A4: CC16400D 7C6A0719
	v_lshrrev_b32_e32 v26, 28, v24                             // 00000000B2AC: 3234309C
	v_dot4_i32_iu8 v13, v12, v22, v13 neg_lo:[1,1,0]           // 00000000B2B0: CC16400D 7C362D0C
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B2B8: BF870091
	v_lshrrev_b32_e32 v12, 31, v13                             // 00000000B2BC: 32181A9F
	v_add_nc_u32_e32 v12, v13, v12                             // 00000000B2C0: 4A18190D
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B2C4: BF870091
	v_ashrrev_i32_e32 v12, 1, v12                              // 00000000B2C8: 34181881
	v_mad_u64_u32 v[24:25], null, v13, v26, v[12:13]           // 00000000B2CC: D6FE7C18 0432350D
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B2D4: BF870091
	v_lshrrev_b32_e32 v12, 31, v24                             // 00000000B2D8: 3218309F
	v_add_nc_u32_e32 v12, v24, v12                             // 00000000B2DC: 4A181918
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 00000000B2E0: BF870131
	v_ashrrev_i32_e32 v13, 1, v12                              // 00000000B2E4: 341A1881
	s_waitcnt vmcnt(0)                                         // 00000000B2E8: BF8903F7
	v_cvt_f32_f16_e32 v12, v4.l                                // 00000000B2EC: 7E181704
	v_cvt_f32_i32_e32 v13, v13                                 // 00000000B2F0: 7E1A0B0D
	v_cvt_f32_f16_e32 v10, v4.h                                // 00000000B2F4: 7E141784
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000000B2F8: BF870121
	v_mul_f32_e32 v4, v10, v12                                 // 00000000B2FC: 1008190A
	v_mad_i64_i32 v[10:11], null, 0x42, v23, s[6:7]            // 00000000B300: D6FF7C0A 001A2EFF 00000042
	v_fmac_f32_e32 v16, v4, v13                                // 00000000B30C: 56201B04
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B310: BF870092
	v_add_co_u32 v23, vcc_lo, v10, v20                         // 00000000B314: D7006A17 0002290A
	v_add_co_ci_u32_e64 v24, null, 0, v11, vcc_lo              // 00000000B31C: D5207C18 01AA1680
	global_load_b64 v[26:27], v[23:24], off                    // 00000000B324: DC560000 1A7C0017
	v_add_co_u32 v23, vcc_lo, v10, v19                         // 00000000B32C: D7006A17 0002270A
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_1)// 00000000B334: BF8700C1
	v_add_co_ci_u32_e64 v24, null, 0, v11, vcc_lo              // 00000000B338: D5207C18 01AA1680
	global_load_b32 v28, v[23:24], off offset:64               // 00000000B340: DC520040 1C7C0017
	s_waitcnt vmcnt(1)                                         // 00000000B348: BF8907F7
	v_and_b32_e32 v23, 0xff, v26                               // 00000000B34C: 362E34FF 000000FF
	v_lshlrev_b32_e32 v23, 2, v23                              // 00000000B354: 302E2E82
	global_load_b32 v29, v23, s[8:9]                           // 00000000B358: DC520000 1D080017
	v_lshrrev_b32_e32 v23, 6, v26                              // 00000000B360: 322E3486
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_1)// 00000000B364: BF8700C1
	v_and_b32_e32 v23, 0x3fc, v23                              // 00000000B368: 362E2EFF 000003FC
	global_load_b32 v30, v23, s[8:9]                           // 00000000B370: DC520000 1E080017
	s_waitcnt vmcnt(2)                                         // 00000000B378: BF890BF7
	v_and_b32_e32 v23, 0xff, v28                               // 00000000B37C: 362E38FF 000000FF
	v_bcnt_u32_b32 v24, v23, 0                                 // 00000000B384: D71E0018 00010117
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B38C: BF870091
	v_and_b32_e32 v24, 1, v24                                  // 00000000B390: 36303081
	v_lshlrev_b32_e32 v24, 7, v24                              // 00000000B394: 30303087
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B398: BF870091
	v_xor_b32_e32 v23, v24, v23                                // 00000000B39C: 3A2E2F18
	v_mul_lo_u32 v31, 0x1010101, v23                           // 00000000B3A0: D72C001F 00022EFF 01010101
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B3AC: BF870091
	v_and_b32_e32 v23, 0x8040201, v31                          // 00000000B3B0: 362E3EFF 08040201
	v_lshrrev_b32_e32 v24, 24, v23                             // 00000000B3B8: 32302E98
	v_lshrrev_b16 v21.h, 8, v23.l op_sel:[0,0,1]               // 00000000B3BC: D7394015 00022E88
	v_lshrrev_b32_e32 v23, 18, v31                             // 00000000B3C4: 322E3E92
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000000B3C8: BF870193
	v_cmp_ne_u16_e64 s0, 0, v24.l                              // 00000000B3CC: D43D0000 00023080
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.h                          // 00000000B3D4: 7C7B2A80
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000000B3D8: BF870193
	v_bfe_i32 v23, v23, 0, 1                                   // 00000000B3DC: D6110017 02050117
	v_cndmask_b32_e64 v24, 0, -1, s0                           // 00000000B3E4: D5010018 00018280
	v_cndmask_b32_e64 v25, 0, -1, vcc_lo                       // 00000000B3EC: D5010019 01A98280
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_4)// 00000000B3F4: BF870223
	v_and_b16 v21.h, 0xff, v23.l op_sel:[0,0,1]                // 00000000B3F8: D7624015 00022EFF 000000FF
	v_lshlrev_b16 v23.l, 8, v23.l                              // 00000000B404: D7380017 00022E88
	v_lshlrev_b16 v23.h, 8, v24.l op_sel:[0,0,1]               // 00000000B40C: D7384017 00023088
	v_bfe_i32 v24, v31, 0, 1                                   // 00000000B414: D6110018 0205011F
	v_lshlrev_b16 v25.l, 8, v25.l                              // 00000000B41C: D7380019 00023288
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000000B424: BF870193
	v_or_b16 v21.h, v21.h, v23.h op_sel:[1,1,1]                // 00000000B428: D7635815 00022F15
	v_and_b16 v24.h, 0xff, v24.l op_sel:[0,0,1]                // 00000000B430: D7624018 000230FF 000000FF
	v_lshlrev_b16 v24.l, 8, v24.l                              // 00000000B43C: D7380018 00023088
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B444: BF870092
	v_or_b16 v32.l, v24.h, v25.l op_sel:[1,0,0]                // 00000000B448: D7630820 00023318
	v_or_b32_e32 v32, v32, v21                                 // 00000000B450: 38402B20
	s_waitcnt vmcnt(1)                                         // 00000000B454: BF8907F7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B458: BF870091
	v_xor_b32_e32 v29, v29, v32                                // 00000000B45C: 3A3A411D
	v_and_b16 v21.h, 0xff00, v29.l op_sel:[0,0,1]              // 00000000B460: D7624015 00023AFF FFFFFF00
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000B46C: BF8700A1
	v_sub_nc_i16 v25.l, v21.h, v25.l op_sel:[1,0,0] clamp      // 00000000B470: D70E8819 00023315
	v_lshlrev_b16 v21.h, 8, v29.l op_sel:[0,0,1]               // 00000000B478: D7384015 00023A88
	v_sub_nc_i16 v24.l, v21.h, v24.l op_sel:[1,0,0] clamp      // 00000000B480: D70E8818 00023115
	v_and_b16 v21.h, 0xff00, v29.h op_sel:[0,1,1]              // 00000000B488: D7625015 00023AFF FFFFFF00
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000000B494: BF870112
	v_perm_b32 v24, v24, v25, 0xc0c0105                        // 00000000B498: D6440018 03FE3318 0C0C0105
	v_sub_nc_i16 v25.l, v21.h, v23.h op_sel:[1,1,0] clamp      // 00000000B4A4: D70E9819 00022F15
	v_lshlrev_b16 v21.h, 8, v29.h op_sel:[0,1,1]               // 00000000B4AC: D7385015 00023A88
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B4B4: BF870091
	v_sub_nc_i16 v23.l, v21.h, v23.l op_sel:[1,0,0] clamp      // 00000000B4B8: D70E8817 00022F15
	v_perm_b32 v23, v23, v25, 0xc0c0105                        // 00000000B4C0: D6440017 03FE3317 0C0C0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000000B4CC: BF870121
	v_lshl_or_b32 v29, v23, 16, v24                            // 00000000B4D0: D656001D 04612117
	v_and_b32_e32 v23, 0x80402010, v31                         // 00000000B4D8: 362E3EFF 80402010
	v_dot4_i32_iu8 v5, v29, v5, 0 neg_lo:[1,1,0]               // 00000000B4E0: CC164005 7A020B1D
	s_delay_alu instid0(VALU_DEP_2)                            // 00000000B4E8: BF870002
	v_lshrrev_b32_e32 v24, 24, v23                             // 00000000B4EC: 32302E98
	v_lshrrev_b16 v21.h, 8, v23.l op_sel:[0,0,1]               // 00000000B4F0: D7394015 00022E88
	v_lshrrev_b16 v25.l, 4, v23.l                              // 00000000B4F8: D7390019 00022E84
	v_lshrrev_b32_e32 v23, 22, v31                             // 00000000B500: 322E3E96
	v_mov_b16_e32 v31.h, v21.l                                 // 00000000B504: 7F3E3915
	v_cmp_ne_u16_e64 s0, 0, v24.l                              // 00000000B508: D43D0000 00023080
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.h                          // 00000000B510: 7C7B2A80
	v_bfe_i32 v25, v25, 0, 1                                   // 00000000B514: D6110019 02050119
	v_bfe_i32 v23, v23, 0, 1                                   // 00000000B51C: D6110017 02050117
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000000B524: BF870114
	v_cndmask_b32_e64 v24, 0, -1, s0                           // 00000000B528: D5010018 00018280
	v_and_b16 v21.h, 0xff, v23.l op_sel:[0,0,1]                // 00000000B530: D7624015 00022EFF 000000FF
	v_lshlrev_b16 v23.l, 8, v23.l                              // 00000000B53C: D7380017 00022E88
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000000B544: BF8701B3
	v_lshlrev_b16 v23.h, 8, v24.l op_sel:[0,0,1]               // 00000000B548: D7384017 00023088
	v_cndmask_b32_e64 v24, 0, -1, vcc_lo                       // 00000000B550: D5010018 01A98280
	v_and_b16 v24.h, 0xff, v25.l op_sel:[0,0,1]                // 00000000B558: D7624018 000232FF 000000FF
	v_or_b16 v21.h, v21.h, v23.h op_sel:[1,1,1]                // 00000000B564: D7635815 00022F15
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B56C: BF870093
	v_lshlrev_b16 v24.l, 8, v24.l                              // 00000000B570: D7380018 00023088
	v_or_b16 v31.l, v24.h, v24.l op_sel:[1,0,0]                // 00000000B578: D763081F 00023118
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000B580: BF8700A1
	v_or_b32_e32 v31, v31, v21                                 // 00000000B584: 383E2B1F
	s_waitcnt vmcnt(0)                                         // 00000000B588: BF8903F7
	v_xor_b32_e32 v30, v30, v31                                // 00000000B58C: 3A3C3F1E
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B590: BF870091
	v_and_b16 v21.h, 0xff00, v30.l op_sel:[0,0,1]              // 00000000B594: D7624015 00023CFF FFFFFF00
	v_sub_nc_i16 v31.l, v21.h, v24.l op_sel:[1,0,0] clamp      // 00000000B5A0: D70E881F 00023115
	v_lshlrev_b16 v21.h, 8, v30.l op_sel:[0,0,1]               // 00000000B5A8: D7384015 00023C88
	v_lshlrev_b16 v24.l, 8, v25.l                              // 00000000B5B0: D7380018 00023288
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000000B5B8: BF870121
	v_sub_nc_i16 v24.l, v21.h, v24.l op_sel:[1,0,0] clamp      // 00000000B5BC: D70E8818 00023115
	v_and_b16 v21.h, 0xff00, v30.h op_sel:[0,1,1]              // 00000000B5C4: D7625015 00023CFF FFFFFF00
	v_perm_b32 v24, v24, v31, 0xc0c0105                        // 00000000B5D0: D6440018 03FE3F18 0C0C0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000B5DC: BF8700A2
	v_sub_nc_i16 v25.l, v21.h, v23.h op_sel:[1,1,0] clamp      // 00000000B5E0: D70E9819 00022F15
	v_lshlrev_b16 v21.h, 8, v30.h op_sel:[0,1,1]               // 00000000B5E8: D7385015 00023C88
	v_sub_nc_i16 v23.l, v21.h, v23.l op_sel:[1,0,0] clamp      // 00000000B5F0: D70E8817 00022F15
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B5F8: BF870091
	v_perm_b32 v23, v23, v25, 0xc0c0105                        // 00000000B5FC: D6440017 03FE3317 0C0C0105
	v_lshl_or_b32 v23, v23, 16, v24                            // 00000000B608: D6560017 04612117
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000B610: BF8700A1
	v_dot4_i32_iu8 v25, v23, v6, v5 neg_lo:[1,1,0]             // 00000000B614: CC164019 7C160D17
	v_lshrrev_b32_e32 v5, 14, v26                              // 00000000B61C: 320A348E
	v_and_b32_e32 v5, 0x3fc, v5                                // 00000000B620: 360A0AFF 000003FC
	global_load_b32 v29, v5, s[8:9]                            // 00000000B628: DC520000 1D080005
	v_lshrrev_b32_e32 v5, 22, v26                              // 00000000B630: 320A3496
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000000B634: BF8700B1
	v_and_b32_e32 v5, 0x3fc, v5                                // 00000000B638: 360A0AFF 000003FC
	global_load_b32 v26, v5, s[8:9]                            // 00000000B640: DC520000 1A080005
	v_bfe_u32 v5, v28, 7, 8                                    // 00000000B648: D6100005 02210F1C
	v_bcnt_u32_b32 v6, v5, 0                                   // 00000000B650: D71E0006 00010105
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B658: BF870091
	v_and_b32_e32 v6, 1, v6                                    // 00000000B65C: 360C0C81
	v_lshlrev_b32_e32 v6, 7, v6                                // 00000000B660: 300C0C87
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B664: BF870091
	v_xor_b32_e32 v5, v6, v5                                   // 00000000B668: 3A0A0B06
	v_mul_lo_u32 v30, 0x1010101, v5                            // 00000000B66C: D72C001E 00020AFF 01010101
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000000B678: BF870121
	v_and_b32_e32 v5, 0x8040201, v30                           // 00000000B67C: 360A3CFF 08040201
	v_bfe_i32 v23, v30, 0, 1                                   // 00000000B684: D6110017 0205011E
	v_lshrrev_b32_e32 v6, 24, v5                               // 00000000B68C: 320C0A98
	v_lshrrev_b16 v5.l, 8, v5.l                                // 00000000B690: D7390005 00020A88
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000000B698: BF870112
	v_cmp_ne_u16_e64 s0, 0, v6.l                               // 00000000B69C: D43D0000 00020C80
	v_cmp_ne_u16_e32 vcc_lo, 0, v5.l                           // 00000000B6A4: 7C7A0A80
	v_lshrrev_b32_e32 v5, 18, v30                              // 00000000B6A8: 320A3C92
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000000B6AC: BF8701A3
	v_cndmask_b32_e64 v6, 0, -1, s0                            // 00000000B6B0: D5010006 00018280
	v_cndmask_b32_e64 v24, 0, -1, vcc_lo                       // 00000000B6B8: D5010018 01A98280
	v_bfe_i32 v5, v5, 0, 1                                     // 00000000B6C0: D6110005 02050105
	v_mov_b16_e32 v24.h, v21.l                                 // 00000000B6C8: 7F303915
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000000B6CC: BF870214
	v_lshlrev_b16 v6.l, 8, v6.l                                // 00000000B6D0: D7380006 00020C88
	v_lshlrev_b16 v6.h, 8, v24.l op_sel:[0,0,1]                // 00000000B6D8: D7384006 00023088
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000000B6E0: BF870124
	v_and_b16 v5.h, 0xff, v5.l op_sel:[0,0,1]                  // 00000000B6E4: D7624005 00020AFF 000000FF
	v_lshlrev_b16 v5.l, 8, v5.l                                // 00000000B6F0: D7380005 00020A88
	v_or_b16 v21.h, v5.h, v6.l op_sel:[1,0,1]                  // 00000000B6F8: D7634815 00020D05
	v_and_b16 v5.h, 0xff, v23.l op_sel:[0,0,1]                 // 00000000B700: D7624005 00022EFF 000000FF
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B70C: BF870091
	v_or_b16 v24.l, v5.h, v6.h op_sel:[1,1,0]                  // 00000000B710: D7631818 00020D05
	v_or_b32_e32 v24, v24, v21                                 // 00000000B718: 38302B18
	s_waitcnt vmcnt(1)                                         // 00000000B71C: BF8907F7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B720: BF870091
	v_xor_b32_e32 v24, v29, v24                                // 00000000B724: 3A30311D
	v_and_b16 v5.h, 0xff00, v24.l op_sel:[0,0,1]               // 00000000B728: D7624005 000230FF FFFFFF00
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000000B734: BF8700B1
	v_sub_nc_i16 v29.l, v5.h, v6.h op_sel:[1,1,0] clamp        // 00000000B738: D70E981D 00020D05
	v_lshlrev_b16 v5.h, 8, v24.l op_sel:[0,0,1]                // 00000000B740: D7384005 00023088
	v_lshlrev_b16 v6.h, 8, v23.l op_sel:[0,0,1]                // 00000000B748: D7384006 00022E88
	v_sub_nc_i16 v23.l, v5.h, v6.h op_sel:[1,1,0] clamp        // 00000000B750: D70E9817 00020D05
	v_and_b16 v5.h, 0xff00, v24.h op_sel:[0,1,1]               // 00000000B758: D7625005 000230FF FFFFFF00
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000000B764: BF870112
	v_perm_b32 v23, v23, v29, 0xc0c0105                        // 00000000B768: D6440017 03FE3B17 0C0C0105
	v_sub_nc_i16 v6.l, v5.h, v6.l op_sel:[1,0,0] clamp         // 00000000B774: D70E8806 00020D05
	v_lshlrev_b16 v5.h, 8, v24.h op_sel:[0,1,1]                // 00000000B77C: D7385005 00023088
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B784: BF870091
	v_sub_nc_i16 v5.l, v5.h, v5.l op_sel:[1,0,0] clamp         // 00000000B788: D70E8805 00020B05
	v_perm_b32 v5, v5, v6, 0xc0c0105                           // 00000000B790: D6440005 03FE0D05 0C0C0105
	v_and_b32_e32 v6, 0x80402010, v30                          // 00000000B79C: 360C3CFF 80402010
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000000B7A4: BF870112
	v_lshl_or_b32 v24, v5, 16, v23                             // 00000000B7A8: D6560018 045D2105
	v_lshrrev_b32_e32 v23, 24, v6                              // 00000000B7B0: 322E0C98
	v_lshrrev_b16 v5.l, 8, v6.l                                // 00000000B7B4: D7390005 00020C88
	v_lshrrev_b16 v29.l, 4, v6.l                               // 00000000B7BC: D739001D 00020C84
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000000B7C4: BF870193
	v_cmp_ne_u16_e64 s0, 0, v23.l                              // 00000000B7C8: D43D0000 00022E80
	v_cmp_ne_u16_e32 vcc_lo, 0, v5.l                           // 00000000B7D0: 7C7A0A80
	v_lshrrev_b32_e32 v5, 22, v30                              // 00000000B7D4: 320A3C96
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000000B7D8: BF8701A3
	v_cndmask_b32_e64 v6, 0, -1, s0                            // 00000000B7DC: D5010006 00018280
	v_cndmask_b32_e64 v23, 0, -1, vcc_lo                       // 00000000B7E4: D5010017 01A98280
	v_bfe_i32 v5, v5, 0, 1                                     // 00000000B7EC: D6110005 02050105
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000000B7F4: BF870113
	v_lshlrev_b16 v6.l, 8, v6.l                                // 00000000B7F8: D7380006 00020C88
	v_and_b16 v5.h, 0xff, v5.l op_sel:[0,0,1]                  // 00000000B800: D7624005 00020AFF 000000FF
	v_lshlrev_b16 v5.l, 8, v5.l                                // 00000000B80C: D7380005 00020A88
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_2)// 00000000B814: BF870142
	v_or_b16 v21.h, v5.h, v6.l op_sel:[1,0,1]                  // 00000000B818: D7634815 00020D05
	v_lshlrev_b16 v5.h, 8, v23.l op_sel:[0,0,1]                // 00000000B820: D7384005 00022E88
	v_bfe_i32 v23, v29, 0, 1                                   // 00000000B828: D6110017 0205011D
	v_mov_b16_e32 v29.h, v21.l                                 // 00000000B830: 7F3A3915
	v_and_b16 v6.h, 0xff, v23.l op_sel:[0,0,1]                 // 00000000B834: D7624006 00022EFF 000000FF
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B840: BF870091
	v_or_b16 v29.l, v6.h, v5.h op_sel:[1,1,0]                  // 00000000B844: D763181D 00020B06
	v_or_b32_e32 v29, v29, v21                                 // 00000000B84C: 383A2B1D
	s_waitcnt vmcnt(0)                                         // 00000000B850: BF8903F7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B854: BF870091
	v_xor_b32_e32 v26, v26, v29                                // 00000000B858: 3A343B1A
	v_and_b16 v6.h, 0xff00, v26.l op_sel:[0,0,1]               // 00000000B85C: D7624006 000234FF FFFFFF00
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000000B868: BF8700B1
	v_sub_nc_i16 v29.l, v6.h, v5.h op_sel:[1,1,0] clamp        // 00000000B86C: D70E981D 00020B06
	v_lshlrev_b16 v5.h, 8, v26.l op_sel:[0,0,1]                // 00000000B874: D7384005 00023488
	v_lshlrev_b16 v6.h, 8, v23.l op_sel:[0,0,1]                // 00000000B87C: D7384006 00022E88
	v_sub_nc_i16 v23.l, v5.h, v6.h op_sel:[1,1,0] clamp        // 00000000B884: D70E9817 00020D05
	v_and_b16 v5.h, 0xff00, v26.h op_sel:[0,1,1]               // 00000000B88C: D7625005 000234FF FFFFFF00
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000000B898: BF870112
	v_perm_b32 v23, v23, v29, 0xc0c0105                        // 00000000B89C: D6440017 03FE3B17 0C0C0105
	v_sub_nc_i16 v6.l, v5.h, v6.l op_sel:[1,0,0] clamp         // 00000000B8A8: D70E8806 00020D05
	v_lshlrev_b16 v5.h, 8, v26.h op_sel:[0,1,1]                // 00000000B8B0: D7385005 00023488
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B8B8: BF870091
	v_sub_nc_i16 v5.l, v5.h, v5.l op_sel:[1,0,0] clamp         // 00000000B8BC: D70E8805 00020B05
	v_perm_b32 v5, v5, v6, 0xc0c0105                           // 00000000B8C4: D6440005 03FE0D05 0C0C0105
	v_dot4_i32_iu8 v6, v24, v7, v25 neg_lo:[1,1,0]             // 00000000B8D0: CC164006 7C660F18
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B8D8: BF870092
	v_lshl_or_b32 v5, v5, 16, v23                              // 00000000B8DC: D6560005 045D2105
	v_dot4_i32_iu8 v23, v5, v0, v6 neg_lo:[1,1,0]              // 00000000B8E4: CC164017 7C1A0105
	v_and_b32_e32 v0, 0xff, v27                                // 00000000B8EC: 360036FF 000000FF
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000000B8F4: BF8700B1
	v_lshlrev_b32_e32 v0, 2, v0                                // 00000000B8F8: 30000082
	global_load_b32 v24, v0, s[8:9]                            // 00000000B8FC: DC520000 18080000
	v_lshrrev_b32_e32 v0, 6, v27                               // 00000000B904: 32003686
	v_and_b32_e32 v0, 0x3fc, v0                                // 00000000B908: 360000FF 000003FC
	global_load_b32 v25, v0, s[8:9]                            // 00000000B910: DC520000 19080000
	v_bfe_u32 v0, v28, 14, 8                                   // 00000000B918: D6100000 02211D1C
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B920: BF870091
	v_bcnt_u32_b32 v5, v0, 0                                   // 00000000B924: D71E0005 00010100
	v_and_b32_e32 v5, 1, v5                                    // 00000000B92C: 360A0A81
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B930: BF870091
	v_lshlrev_b32_e32 v5, 7, v5                                // 00000000B934: 300A0A87
	v_xor_b32_e32 v0, v5, v0                                   // 00000000B938: 3A000105
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B93C: BF870091
	v_mul_lo_u32 v26, 0x1010101, v0                            // 00000000B940: D72C001A 000200FF 01010101
	v_and_b32_e32 v0, 0x8040201, v26                           // 00000000B94C: 360034FF 08040201
	v_bfe_i32 v6, v26, 0, 1                                    // 00000000B954: D6110006 0205011A
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000000B95C: BF870122
	v_lshrrev_b32_e32 v5, 24, v0                               // 00000000B960: 320A0098
	v_lshrrev_b16 v0.l, 8, v0.l                                // 00000000B964: D7390000 00020088
	v_cmp_ne_u16_e64 s0, 0, v5.l                               // 00000000B96C: D43D0000 00020A80
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000000B974: BF8701A2
	v_cmp_ne_u16_e32 vcc_lo, 0, v0.l                           // 00000000B978: 7C7A0080
	v_lshrrev_b32_e32 v0, 18, v26                              // 00000000B97C: 32003492
	v_cndmask_b32_e64 v5, 0, -1, s0                            // 00000000B980: D5010005 00018280
	v_cndmask_b32_e64 v7, 0, -1, vcc_lo                        // 00000000B988: D5010007 01A98280
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_4)// 00000000B990: BF870223
	v_bfe_i32 v0, v0, 0, 1                                     // 00000000B994: D6110000 02050100
	v_mov_b16_e32 v7.h, v21.l                                  // 00000000B99C: 7F0E3915
	v_lshlrev_b16 v5.l, 8, v5.l                                // 00000000B9A0: D7380005 00020A88
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000000B9A8: BF870214
	v_lshlrev_b16 v5.h, 8, v7.l op_sel:[0,0,1]                 // 00000000B9AC: D7384005 00020E88
	v_and_b16 v0.h, 0xff, v0.l op_sel:[0,0,1]                  // 00000000B9B4: D7624000 000200FF 000000FF
	v_lshlrev_b16 v0.l, 8, v0.l                                // 00000000B9C0: D7380000 00020088
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000B9C8: BF8700A2
	v_or_b16 v21.h, v0.h, v5.l op_sel:[1,0,1]                  // 00000000B9CC: D7634815 00020B00
	v_and_b16 v0.h, 0xff, v6.l op_sel:[0,0,1]                  // 00000000B9D4: D7624000 00020CFF 000000FF
	v_or_b16 v7.l, v0.h, v5.h op_sel:[1,1,0]                   // 00000000B9E0: D7631807 00020B00
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000B9E8: BF8700A1
	v_or_b32_e32 v7, v7, v21                                   // 00000000B9EC: 380E2B07
	s_waitcnt vmcnt(1)                                         // 00000000B9F0: BF8907F7
	v_xor_b32_e32 v7, v24, v7                                  // 00000000B9F4: 3A0E0F18
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000B9F8: BF870091
	v_and_b16 v0.h, 0xff00, v7.l op_sel:[0,0,1]                // 00000000B9FC: D7624000 00020EFF FFFFFF00
	v_sub_nc_i16 v24.l, v0.h, v5.h op_sel:[1,1,0] clamp        // 00000000BA08: D70E9818 00020B00
	v_lshlrev_b16 v0.h, 8, v7.l op_sel:[0,0,1]                 // 00000000BA10: D7384000 00020E88
	v_lshlrev_b16 v5.h, 8, v6.l op_sel:[0,0,1]                 // 00000000BA18: D7384005 00020C88
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000000BA20: BF870121
	v_sub_nc_i16 v6.l, v0.h, v5.h op_sel:[1,1,0] clamp         // 00000000BA24: D70E9806 00020B00
	v_and_b16 v0.h, 0xff00, v7.h op_sel:[0,1,1]                // 00000000BA2C: D7625000 00020EFF FFFFFF00
	v_perm_b32 v6, v6, v24, 0xc0c0105                          // 00000000BA38: D6440006 03FE3106 0C0C0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000BA44: BF8700A2
	v_sub_nc_i16 v5.l, v0.h, v5.l op_sel:[1,0,0] clamp         // 00000000BA48: D70E8805 00020B00
	v_lshlrev_b16 v0.h, 8, v7.h op_sel:[0,1,1]                 // 00000000BA50: D7385000 00020E88
	v_sub_nc_i16 v0.l, v0.h, v0.l op_sel:[1,0,0] clamp         // 00000000BA58: D70E8800 00020100
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000000BA60: BF870121
	v_perm_b32 v0, v0, v5, 0xc0c0105                           // 00000000BA64: D6440000 03FE0B00 0C0C0105
	v_and_b32_e32 v5, 0x80402010, v26                          // 00000000BA70: 360A34FF 80402010
	v_lshl_or_b32 v7, v0, 16, v6                               // 00000000BA78: D6560007 04192100
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_4)// 00000000BA80: BF870232
	v_lshrrev_b32_e32 v6, 24, v5                               // 00000000BA84: 320C0A98
	v_lshrrev_b16 v0.l, 8, v5.l                                // 00000000BA88: D7390000 00020A88
	v_lshrrev_b16 v24.l, 4, v5.l                               // 00000000BA90: D7390018 00020A84
	v_dot4_i32_iu8 v1, v7, v1, v23 neg_lo:[1,1,0]              // 00000000BA98: CC164001 7C5E0307
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000000BAA0: BF870214
	v_cmp_ne_u16_e64 s0, 0, v6.l                               // 00000000BAA4: D43D0000 00020C80
	v_cmp_ne_u16_e32 vcc_lo, 0, v0.l                           // 00000000BAAC: 7C7A0080
	v_lshrrev_b32_e32 v0, 22, v26                              // 00000000BAB0: 32003496
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000000BAB4: BF8701A3
	v_cndmask_b32_e64 v5, 0, -1, s0                            // 00000000BAB8: D5010005 00018280
	v_cndmask_b32_e64 v6, 0, -1, vcc_lo                        // 00000000BAC0: D5010006 01A98280
	v_bfe_i32 v0, v0, 0, 1                                     // 00000000BAC8: D6110000 02050100
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000000BAD0: BF870113
	v_lshlrev_b16 v5.l, 8, v5.l                                // 00000000BAD4: D7380005 00020A88
	v_and_b16 v0.h, 0xff, v0.l op_sel:[0,0,1]                  // 00000000BADC: D7624000 000200FF 000000FF
	v_lshlrev_b16 v0.l, 8, v0.l                                // 00000000BAE8: D7380000 00020088
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_2)// 00000000BAF0: BF870142
	v_or_b16 v21.h, v0.h, v5.l op_sel:[1,0,1]                  // 00000000BAF4: D7634815 00020B00
	v_lshlrev_b16 v0.h, 8, v6.l op_sel:[0,0,1]                 // 00000000BAFC: D7384000 00020C88
	v_bfe_i32 v6, v24, 0, 1                                    // 00000000BB04: D6110006 02050118
	v_mov_b16_e32 v24.h, v21.l                                 // 00000000BB0C: 7F303915
	v_and_b16 v5.h, 0xff, v6.l op_sel:[0,0,1]                  // 00000000BB10: D7624005 00020CFF 000000FF
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000BB1C: BF870091
	v_or_b16 v24.l, v5.h, v0.h op_sel:[1,1,0]                  // 00000000BB20: D7631818 00020105
	v_or_b32_e32 v24, v24, v21                                 // 00000000BB28: 38302B18
	s_waitcnt vmcnt(0)                                         // 00000000BB2C: BF8903F7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000BB30: BF870091
	v_xor_b32_e32 v24, v25, v24                                // 00000000BB34: 3A303119
	v_and_b16 v5.h, 0xff00, v24.l op_sel:[0,0,1]               // 00000000BB38: D7624005 000230FF FFFFFF00
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000000BB44: BF8700B1
	v_sub_nc_i16 v25.l, v5.h, v0.h op_sel:[1,1,0] clamp        // 00000000BB48: D70E9819 00020105
	v_lshlrev_b16 v0.h, 8, v24.l op_sel:[0,0,1]                // 00000000BB50: D7384000 00023088
	v_lshlrev_b16 v5.h, 8, v6.l op_sel:[0,0,1]                 // 00000000BB58: D7384005 00020C88
	v_sub_nc_i16 v6.l, v0.h, v5.h op_sel:[1,1,0] clamp         // 00000000BB60: D70E9806 00020B00
	v_and_b16 v0.h, 0xff00, v24.h op_sel:[0,1,1]               // 00000000BB68: D7625000 000230FF FFFFFF00
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000000BB74: BF870112
	v_perm_b32 v6, v6, v25, 0xc0c0105                          // 00000000BB78: D6440006 03FE3306 0C0C0105
	v_sub_nc_i16 v5.l, v0.h, v5.l op_sel:[1,0,0] clamp         // 00000000BB84: D70E8805 00020B00
	v_lshlrev_b16 v0.h, 8, v24.h op_sel:[0,1,1]                // 00000000BB8C: D7385000 00023088
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000BB94: BF870091
	v_sub_nc_i16 v0.l, v0.h, v0.l op_sel:[1,0,0] clamp         // 00000000BB98: D70E8800 00020100
	v_perm_b32 v0, v0, v5, 0xc0c0105                           // 00000000BBA0: D6440000 03FE0B00 0C0C0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000BBAC: BF870091
	v_lshl_or_b32 v0, v0, 16, v6                               // 00000000BBB0: D6560000 04192100
	v_dot4_i32_iu8 v6, v0, v2, v1 neg_lo:[1,1,0]               // 00000000BBB8: CC164006 7C060500
	v_lshrrev_b32_e32 v0, 14, v27                              // 00000000BBC0: 3200368E
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000000BBC4: BF8700B1
	v_and_b32_e32 v0, 0x3fc, v0                                // 00000000BBC8: 360000FF 000003FC
	global_load_b32 v7, v0, s[8:9]                             // 00000000BBD0: DC520000 07080000
	v_lshrrev_b32_e32 v0, 22, v27                              // 00000000BBD8: 32003696
	v_and_b32_e32 v0, 0x3fc, v0                                // 00000000BBDC: 360000FF 000003FC
	global_load_b32 v23, v0, s[8:9]                            // 00000000BBE4: DC520000 17080000
	v_bfe_u32 v0, v28, 21, 8                                   // 00000000BBEC: D6100000 02212B1C
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000BBF4: BF870091
	v_bcnt_u32_b32 v1, v0, 0                                   // 00000000BBF8: D71E0001 00010100
	v_and_b32_e32 v1, 1, v1                                    // 00000000BC00: 36020281
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000BC04: BF870091
	v_lshlrev_b32_e32 v1, 7, v1                                // 00000000BC08: 30020287
	v_xor_b32_e32 v0, v1, v0                                   // 00000000BC0C: 3A000101
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000BC10: BF870091
	v_mul_lo_u32 v24, 0x1010101, v0                            // 00000000BC14: D72C0018 000200FF 01010101
	v_and_b32_e32 v0, 0x8040201, v24                           // 00000000BC20: 360030FF 08040201
	v_bfe_i32 v2, v24, 0, 1                                    // 00000000BC28: D6110002 02050118
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000000BC30: BF870122
	v_lshrrev_b32_e32 v1, 24, v0                               // 00000000BC34: 32020098
	v_lshrrev_b16 v0.l, 8, v0.l                                // 00000000BC38: D7390000 00020088
	v_cmp_ne_u16_e64 s0, 0, v1.l                               // 00000000BC40: D43D0000 00020280
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000000BC48: BF8701A2
	v_cmp_ne_u16_e32 vcc_lo, 0, v0.l                           // 00000000BC4C: 7C7A0080
	v_lshrrev_b32_e32 v0, 18, v24                              // 00000000BC50: 32003092
	v_cndmask_b32_e64 v1, 0, -1, s0                            // 00000000BC54: D5010001 00018280
	v_cndmask_b32_e64 v5, 0, -1, vcc_lo                        // 00000000BC5C: D5010005 01A98280
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_4)// 00000000BC64: BF870223
	v_bfe_i32 v0, v0, 0, 1                                     // 00000000BC68: D6110000 02050100
	v_mov_b16_e32 v5.h, v21.l                                  // 00000000BC70: 7F0A3915
	v_lshlrev_b16 v1.l, 8, v1.l                                // 00000000BC74: D7380001 00020288
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000000BC7C: BF870214
	v_lshlrev_b16 v1.h, 8, v5.l op_sel:[0,0,1]                 // 00000000BC80: D7384001 00020A88
	v_and_b16 v0.h, 0xff, v0.l op_sel:[0,0,1]                  // 00000000BC88: D7624000 000200FF 000000FF
	v_lshlrev_b16 v0.l, 8, v0.l                                // 00000000BC94: D7380000 00020088
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000BC9C: BF8700A2
	v_or_b16 v21.h, v0.h, v1.l op_sel:[1,0,1]                  // 00000000BCA0: D7634815 00020300
	v_and_b16 v0.h, 0xff, v2.l op_sel:[0,0,1]                  // 00000000BCA8: D7624000 000204FF 000000FF
	v_or_b16 v5.l, v0.h, v1.h op_sel:[1,1,0]                   // 00000000BCB4: D7631805 00020300
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000BCBC: BF8700A1
	v_or_b32_e32 v5, v5, v21                                   // 00000000BCC0: 380A2B05
	s_waitcnt vmcnt(1)                                         // 00000000BCC4: BF8907F7
	v_xor_b32_e32 v5, v7, v5                                   // 00000000BCC8: 3A0A0B07
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000BCCC: BF870091
	v_and_b16 v0.h, 0xff00, v5.l op_sel:[0,0,1]                // 00000000BCD0: D7624000 00020AFF FFFFFF00
	v_sub_nc_i16 v7.l, v0.h, v1.h op_sel:[1,1,0] clamp         // 00000000BCDC: D70E9807 00020300
	v_lshlrev_b16 v0.h, 8, v5.l op_sel:[0,0,1]                 // 00000000BCE4: D7384000 00020A88
	v_lshlrev_b16 v1.h, 8, v2.l op_sel:[0,0,1]                 // 00000000BCEC: D7384001 00020488
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000000BCF4: BF870121
	v_sub_nc_i16 v2.l, v0.h, v1.h op_sel:[1,1,0] clamp         // 00000000BCF8: D70E9802 00020300
	v_and_b16 v0.h, 0xff00, v5.h op_sel:[0,1,1]                // 00000000BD00: D7625000 00020AFF FFFFFF00
	v_perm_b32 v2, v2, v7, 0xc0c0105                           // 00000000BD0C: D6440002 03FE0F02 0C0C0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000BD18: BF8700A2
	v_sub_nc_i16 v1.l, v0.h, v1.l op_sel:[1,0,0] clamp         // 00000000BD1C: D70E8801 00020300
	v_lshlrev_b16 v0.h, 8, v5.h op_sel:[0,1,1]                 // 00000000BD24: D7385000 00020A88
	v_sub_nc_i16 v0.l, v0.h, v0.l op_sel:[1,0,0] clamp         // 00000000BD2C: D70E8800 00020100
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000000BD34: BF870121
	v_perm_b32 v0, v0, v1, 0xc0c0105                           // 00000000BD38: D6440000 03FE0300 0C0C0105
	v_and_b32_e32 v1, 0x80402010, v24                          // 00000000BD44: 360230FF 80402010
	v_lshl_or_b32 v5, v0, 16, v2                               // 00000000BD4C: D6560005 04092100
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000000BD54: BF8701B2
	v_lshrrev_b32_e32 v2, 24, v1                               // 00000000BD58: 32040298
	v_lshrrev_b16 v0.l, 8, v1.l                                // 00000000BD5C: D7390000 00020288
	v_lshrrev_b16 v7.l, 4, v1.l                                // 00000000BD64: D7390007 00020284
	v_cmp_ne_u16_e64 s0, 0, v2.l                               // 00000000BD6C: D43D0000 00020480
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)// 00000000BD74: BF8701A3
	v_cmp_ne_u16_e32 vcc_lo, 0, v0.l                           // 00000000BD78: 7C7A0080
	v_lshrrev_b32_e32 v0, 22, v24                              // 00000000BD7C: 32003096
	v_cndmask_b32_e64 v1, 0, -1, s0                            // 00000000BD80: D5010001 00018280
	v_cndmask_b32_e64 v2, 0, -1, vcc_lo                        // 00000000BD88: D5010002 01A98280
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_4)// 00000000BD90: BF870223
	v_bfe_i32 v0, v0, 0, 1                                     // 00000000BD94: D6110000 02050100
	v_add_co_u32 v8, vcc_lo, 0x480, v8                         // 00000000BD9C: D7006A08 000210FF 00000480
	v_lshlrev_b16 v1.l, 8, v1.l                                // 00000000BDA8: D7380001 00020288
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo                // 00000000BDB0: D5207C09 01AA1280
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000000BDB8: BF8701B4
	v_and_b16 v0.h, 0xff, v0.l op_sel:[0,0,1]                  // 00000000BDBC: D7624000 000200FF 000000FF
	v_lshlrev_b16 v0.l, 8, v0.l                                // 00000000BDC8: D7380000 00020088
	v_cmp_le_u32_e32 vcc_lo, s12, v18                          // 00000000BDD0: 7C96240C
	v_or_b16 v21.h, v0.h, v1.l op_sel:[1,0,1]                  // 00000000BDD4: D7634815 00020300
	v_lshlrev_b16 v0.h, 8, v2.l op_sel:[0,0,1]                 // 00000000BDDC: D7384000 00020488
	v_bfe_i32 v2, v7, 0, 1                                     // 00000000BDE4: D6110002 02050107
	v_mov_b16_e32 v7.h, v21.l                                  // 00000000BDEC: 7F0E3915
	s_or_b32 s13, vcc_lo, s13                                  // 00000000BDF0: 8C0D0D6A
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000BDF4: BF870092
	v_and_b16 v1.h, 0xff, v2.l op_sel:[0,0,1]                  // 00000000BDF8: D7624001 000204FF 000000FF
	v_or_b16 v7.l, v1.h, v0.h op_sel:[1,1,0]                   // 00000000BE04: D7631807 00020101
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000BE0C: BF8700A1
	v_or_b32_e32 v7, v7, v21                                   // 00000000BE10: 380E2B07
	s_waitcnt vmcnt(0)                                         // 00000000BE14: BF8903F7
	v_xor_b32_e32 v7, v23, v7                                  // 00000000BE18: 3A0E0F17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000BE1C: BF870091
	v_and_b16 v1.h, 0xff00, v7.l op_sel:[0,0,1]                // 00000000BE20: D7624001 00020EFF FFFFFF00
	v_sub_nc_i16 v21.l, v1.h, v0.h op_sel:[1,1,0] clamp        // 00000000BE2C: D70E9815 00020101
	v_lshlrev_b16 v0.h, 8, v7.l op_sel:[0,0,1]                 // 00000000BE34: D7384000 00020E88
	v_lshlrev_b16 v1.h, 8, v2.l op_sel:[0,0,1]                 // 00000000BE3C: D7384001 00020488
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000000BE44: BF870121
	v_sub_nc_i16 v2.l, v0.h, v1.h op_sel:[1,1,0] clamp         // 00000000BE48: D70E9802 00020300
	v_and_b16 v0.h, 0xff00, v7.h op_sel:[0,1,1]                // 00000000BE50: D7625000 00020EFF FFFFFF00
	v_perm_b32 v2, v2, v21, 0xc0c0105                          // 00000000BE5C: D6440002 03FE2B02 0C0C0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000BE68: BF8700A2
	v_sub_nc_i16 v1.l, v0.h, v1.l op_sel:[1,0,0] clamp         // 00000000BE6C: D70E8801 00020300
	v_lshlrev_b16 v0.h, 8, v7.h op_sel:[0,1,1]                 // 00000000BE74: D7385000 00020E88
	v_sub_nc_i16 v0.l, v0.h, v0.l op_sel:[1,0,0] clamp         // 00000000BE7C: D70E8800 00020100
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)// 00000000BE84: BF8701B1
	v_perm_b32 v0, v0, v1, 0xc0c0105                           // 00000000BE88: D6440000 03FE0300 0C0C0105
	v_dot4_i32_iu8 v1, v5, v3, v6 neg_lo:[1,1,0]               // 00000000BE94: CC164001 7C1A0705
	v_lshrrev_b32_e32 v5, 28, v28                              // 00000000BE9C: 320A389C
	v_lshl_or_b32 v0, v0, 16, v2                               // 00000000BEA0: D6560000 04092100
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000BEA8: BF870091
	v_dot4_i32_iu8 v3, v0, v22, v1 neg_lo:[1,1,0]              // 00000000BEAC: CC164003 7C062D00
	v_lshrrev_b32_e32 v0, 31, v3                               // 00000000BEB4: 3200069F
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000BEB8: BF870091
	v_add_nc_u32_e32 v0, v3, v0                                // 00000000BEBC: 4A000103
	v_ashrrev_i32_e32 v0, 1, v0                                // 00000000BEC0: 34000081
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000BEC4: BF870091
	v_mad_u64_u32 v[1:2], null, v3, v5, v[0:1]                 // 00000000BEC8: D6FE7C01 04020B03
	v_lshrrev_b32_e32 v0, 31, v1                               // 00000000BED0: 3200029F
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000BED4: BF870091
	v_add_nc_u32_e32 v0, v1, v0                                // 00000000BED8: 4A000101
	v_ashrrev_i32_e32 v1, 1, v0                                // 00000000BEDC: 34020081
	global_load_d16_b16 v0, v[10:11], off offset:64            // 00000000BEE0: DC820040 007C000A
	v_cvt_f32_i32_e32 v1, v1                                   // 00000000BEE8: 7E020B01
	s_waitcnt vmcnt(0)                                         // 00000000BEEC: BF8903F7
	v_cvt_f32_f16_e32 v0, v0.l                                 // 00000000BEF0: 7E001700
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000BEF4: BF870091
	v_mul_f32_e32 v0, v12, v0                                  // 00000000BEF8: 1000010C
	v_fmac_f32_e32 v15, v0, v1                                 // 00000000BEFC: 561E0300
	s_and_not1_b32 exec_lo, exec_lo, s13                       // 00000000BF00: 917E0D7E
	s_cbranch_execnz 63990                                     // 00000000BF04: BFA6F9F6 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xe0>
	s_or_b32 exec_lo, exec_lo, s13                             // 00000000BF08: 8C7E0D7E
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 00000000BF0C: BF870499
	s_or_b32 exec_lo, exec_lo, s1                              // 00000000BF10: 8C7E017E
	s_mov_b32 s1, exec_lo                                      // 00000000BF14: BE81007E
	v_cmp_eq_u32_e32 vcc_lo, 0, v17                            // 00000000BF18: 7C942280
	v_cmpx_ne_u32_e32 0, v17                                   // 00000000BF1C: 7D9A2280
	s_cbranch_execz 10                                         // 00000000BF20: BFA5000A <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x194c>
	v_lshlrev_b32_e32 v0, 7, v17                               // 00000000BF24: 30002287
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000BF28: BF870091
	v_lshl_add_u32 v0, v14, 2, v0                              // 00000000BF2C: D6460000 0401050E
	v_add_nc_u32_e32 v1, 0xffffff80, v0                        // 00000000BF34: 4A0200FF FFFFFF80
	ds_store_b32 v1, v16                                       // 00000000BF3C: D8340000 00001001
	ds_store_b32 v0, v15                                       // 00000000BF44: D8340000 00000F00
	s_or_b32 exec_lo, exec_lo, s1                              // 00000000BF4C: 8C7E017E
	s_waitcnt lgkmcnt(0)                                       // 00000000BF50: BF89FC07
	buffer_gl0_inv                                             // 00000000BF54: E0AC0000 00000000
	s_and_saveexec_b32 s0, vcc_lo                              // 00000000BF5C: BE80206A
	s_cbranch_execz 283                                        // 00000000BF60: BFA5011B <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1dd0>
	s_cmp_eq_u32 exec_lo, 0                                    // 00000000BF64: BF06807E
	s_mov_b32 s4, 0                                            // 00000000BF68: BE840080
	s_cselect_b32 s1, -1, 0                                    // 00000000BF6C: 980180C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000BF70: BF870009
	s_and_b32 vcc_lo, exec_lo, s1                              // 00000000BF74: 8B6A017E
	s_cbranch_vccnz 7                                          // 00000000BF78: BFA40007 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1998>
	s_cmp_eq_u32 exec_lo, -1                                   // 00000000BF7C: BF06C17E
	s_mov_b32 s0, -1                                           // 00000000BF80: BE8000C1
	s_cselect_b32 s1, -1, 0                                    // 00000000BF84: 980180C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000BF88: BF870009
	s_and_not1_b32 vcc_lo, exec_lo, s1                         // 00000000BF8C: 916A017E
	s_cbranch_vccz 4                                           // 00000000BF90: BFA30004 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x19a4>
	s_branch 91                                                // 00000000BF94: BFA0005B <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1b04>
	s_mov_b32 s0, 0                                            // 00000000BF98: BE800080
	s_and_not1_b32 vcc_lo, exec_lo, s1                         // 00000000BF9C: 916A017E
	s_cbranch_vccnz 65532                                      // 00000000BFA0: BFA4FFFC <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1994>
	v_mbcnt_lo_u32_b32 v0, -1, 0                               // 00000000BFA4: D71F0000 000100C1
	s_cmp_eq_u32 exec_lo, 0                                    // 00000000BFAC: BF06807E
	s_mov_b32 s0, -1                                           // 00000000BFB0: BE8000C1
	s_cselect_b32 s1, -1, 0                                    // 00000000BFB4: 980180C1
	s_cmp_lg_u32 exec_lo, 0                                    // 00000000BFB8: BF07807E
	v_xor_b32_e32 v1, 16, v0                                   // 00000000BFBC: 3A020090
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000BFC0: BF8700A1
	v_cmp_gt_i32_e32 vcc_lo, 32, v1                            // 00000000BFC4: 7C8802A0
	v_cndmask_b32_e32 v1, v0, v1, vcc_lo                       // 00000000BFC8: 02020300
	v_dual_mov_b32 v1, 32 :: v_dual_lshlrev_b32 v2, 2, v1      // 00000000BFCC: CA2200A0 01020282
	ds_bpermute_b32 v3, v2, v16                                // 00000000BFD4: DACC0000 03001002
	s_cbranch_scc0 6                                           // 00000000BFDC: BFA10006 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x19f8>
	s_cmp_eq_u32 exec_lo, -1                                   // 00000000BFE0: BF06C17E
	s_cselect_b32 s1, -1, 0                                    // 00000000BFE4: 980180C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000BFE8: BF870009
	s_and_not1_b32 vcc_lo, exec_lo, s1                         // 00000000BFEC: 916A017E
	s_cbranch_vccz 4                                           // 00000000BFF0: BFA30004 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1a04>
	s_branch 67                                                // 00000000BFF4: BFA00043 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1b04>
	s_mov_b32 s0, 0                                            // 00000000BFF8: BE800080
	s_and_not1_b32 vcc_lo, exec_lo, s1                         // 00000000BFFC: 916A017E
	s_cbranch_vccnz 65532                                      // 00000000C000: BFA4FFFC <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x19f4>
	v_xor_b32_e32 v4, 8, v0                                    // 00000000C004: 3A080088
	s_cmp_eq_u32 exec_lo, 0                                    // 00000000C008: BF06807E
	s_cselect_b32 s1, -1, 0                                    // 00000000C00C: 980180C1
	s_cmp_lg_u32 exec_lo, 0                                    // 00000000C010: BF07807E
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000000C014: BF8700B1
	v_cmp_gt_i32_e32 vcc_lo, 32, v4                            // 00000000C018: 7C8808A0
	v_cndmask_b32_e32 v5, v0, v4, vcc_lo                       // 00000000C01C: 020A0900
	s_waitcnt lgkmcnt(0)                                       // 00000000C020: BF89FC07
	v_dual_add_f32 v4, v16, v3 :: v_dual_lshlrev_b32 v3, 2, v5 // 00000000C024: C9220710 04020A82
	ds_bpermute_b32 v5, v3, v4                                 // 00000000C02C: DACC0000 05000403
	s_cbranch_scc0 7                                           // 00000000C034: BFA10007 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1a54>
	s_cmp_eq_u32 exec_lo, -1                                   // 00000000C038: BF06C17E
	s_mov_b32 s0, -1                                           // 00000000C03C: BE8000C1
	s_cselect_b32 s1, -1, 0                                    // 00000000C040: 980180C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000C044: BF870009
	s_and_not1_b32 vcc_lo, exec_lo, s1                         // 00000000C048: 916A017E
	s_cbranch_vccz 4                                           // 00000000C04C: BFA30004 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1a60>
	s_branch 44                                                // 00000000C050: BFA0002C <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1b04>
	s_mov_b32 s0, 0                                            // 00000000C054: BE800080
	s_and_not1_b32 vcc_lo, exec_lo, s1                         // 00000000C058: 916A017E
	s_cbranch_vccnz 65532                                      // 00000000C05C: BFA4FFFC <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1a50>
	v_xor_b32_e32 v6, 4, v0                                    // 00000000C060: 3A0C0084
	s_cmp_eq_u32 exec_lo, 0                                    // 00000000C064: BF06807E
	s_cselect_b32 s1, -1, 0                                    // 00000000C068: 980180C1
	s_cmp_lg_u32 exec_lo, 0                                    // 00000000C06C: BF07807E
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000000C070: BF8700B1
	v_cmp_gt_i32_e32 vcc_lo, 32, v6                            // 00000000C074: 7C880CA0
	v_cndmask_b32_e32 v6, v0, v6, vcc_lo                       // 00000000C078: 020C0D00
	s_waitcnt lgkmcnt(0)                                       // 00000000C07C: BF89FC07
	v_dual_add_f32 v5, v4, v5 :: v_dual_lshlrev_b32 v4, 2, v6  // 00000000C080: C9220B04 05040C82
	ds_bpermute_b32 v6, v4, v5                                 // 00000000C088: DACC0000 06000504
	s_cbranch_scc0 7                                           // 00000000C090: BFA10007 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1ab0>
	s_cmp_eq_u32 exec_lo, -1                                   // 00000000C094: BF06C17E
	s_mov_b32 s0, -1                                           // 00000000C098: BE8000C1
	s_cselect_b32 s1, -1, 0                                    // 00000000C09C: 980180C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000C0A0: BF870009
	s_and_not1_b32 vcc_lo, exec_lo, s1                         // 00000000C0A4: 916A017E
	s_cbranch_vccz 4                                           // 00000000C0A8: BFA30004 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1abc>
	s_branch 21                                                // 00000000C0AC: BFA00015 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1b04>
	s_mov_b32 s0, 0                                            // 00000000C0B0: BE800080
	s_and_not1_b32 vcc_lo, exec_lo, s1                         // 00000000C0B4: 916A017E
	s_cbranch_vccnz 65532                                      // 00000000C0B8: BFA4FFFC <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1aac>
	v_xor_b32_e32 v7, 2, v0                                    // 00000000C0BC: 3A0E0082
	s_cmp_lg_u32 exec_lo, 0                                    // 00000000C0C0: BF07807E
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000000C0C4: BF8700B1
	v_cmp_gt_i32_e32 vcc_lo, 32, v7                            // 00000000C0C8: 7C880EA0
	s_waitcnt lgkmcnt(0)                                       // 00000000C0CC: BF89FC07
	v_dual_cndmask_b32 v8, v0, v7 :: v_dual_add_f32 v7, v5, v6 // 00000000C0D0: CA480F00 08060D05
	v_lshlrev_b32_e32 v5, 2, v8                                // 00000000C0D8: 300A1082
	ds_bpermute_b32 v6, v5, v7                                 // 00000000C0DC: DACC0000 06000705
	s_cbranch_scc0 5                                           // 00000000C0E4: BFA10005 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1afc>
	s_cmp_eq_u32 exec_lo, -1                                   // 00000000C0E8: BF06C17E
	s_cselect_b32 s4, -1, 0                                    // 00000000C0EC: 980480C1
	s_cmp_lg_u32 exec_lo, -1                                   // 00000000C0F0: BF07C17E
	s_cselect_b32 s0, -1, 0                                    // 00000000C0F4: 980080C1
	s_branch 2                                                 // 00000000C0F8: BFA00002 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1b04>
	s_mov_b32 s0, 0                                            // 00000000C0FC: BE800080
	s_mov_b32 s4, -1                                           // 00000000C100: BE8400C1
	s_mov_b32 s1, 0                                            // 00000000C104: BE810080
	s_and_b32 vcc_lo, exec_lo, s0                              // 00000000C108: 8B6A007E
	s_mov_b32 s0, 0                                            // 00000000C10C: BE800080
	s_cbranch_vccnz 71                                         // 00000000C110: BFA40047 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1c30>
	s_and_not1_b32 vcc_lo, exec_lo, s4                         // 00000000C114: 916A047E
	s_cbranch_vccnz 73                                         // 00000000C118: BFA40049 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1c40>
	v_xor_b32_e32 v8, 1, v0                                    // 00000000C11C: 3A100081
	s_cmp_eq_u32 exec_lo, 0                                    // 00000000C120: BF06807E
	s_cselect_b32 s5, -1, 0                                    // 00000000C124: 980580C1
	s_cmp_lg_u32 exec_lo, 0                                    // 00000000C128: BF07807E
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000000C12C: BF8700B1
	v_cmp_lt_i32_e32 vcc_lo, v8, v1                            // 00000000C130: 7C820308
	s_waitcnt lgkmcnt(0)                                       // 00000000C134: BF89FC07
	v_dual_add_f32 v1, v7, v6 :: v_dual_cndmask_b32 v0, v0, v8 // 00000000C138: C9120D07 01001100
	v_lshlrev_b32_e32 v6, 2, v0                                // 00000000C140: 300C0082
	ds_bpermute_b32 v0, v6, v1                                 // 00000000C144: DACC0000 00000106
	s_cbranch_scc0 7                                           // 00000000C14C: BFA10007 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1b6c>
	s_cmp_eq_u32 exec_lo, -1                                   // 00000000C150: BF06C17E
	s_mov_b32 s4, -1                                           // 00000000C154: BE8400C1
	s_cselect_b32 s5, -1, 0                                    // 00000000C158: 980580C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000C15C: BF870009
	s_and_not1_b32 vcc_lo, exec_lo, s5                         // 00000000C160: 916A057E
	s_cbranch_vccz 4                                           // 00000000C164: BFA30004 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1b78>
	s_branch 73                                                // 00000000C168: BFA00049 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1c90>
	s_mov_b32 s4, 0                                            // 00000000C16C: BE840080
	s_and_not1_b32 vcc_lo, exec_lo, s5                         // 00000000C170: 916A057E
	s_cbranch_vccnz 70                                         // 00000000C174: BFA40046 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1c90>
	ds_bpermute_b32 v2, v2, v15                                // 00000000C178: DACC0000 02000F02
	s_cmp_eq_u32 exec_lo, 0                                    // 00000000C180: BF06807E
	s_cselect_b32 s5, -1, 0                                    // 00000000C184: 980580C1
	s_cmp_lg_u32 exec_lo, 0                                    // 00000000C188: BF07807E
	s_cbranch_scc0 7                                           // 00000000C18C: BFA10007 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1bac>
	s_cmp_eq_u32 exec_lo, -1                                   // 00000000C190: BF06C17E
	s_mov_b32 s4, -1                                           // 00000000C194: BE8400C1
	s_cselect_b32 s5, -1, 0                                    // 00000000C198: 980580C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000C19C: BF870009
	s_and_not1_b32 vcc_lo, exec_lo, s5                         // 00000000C1A0: 916A057E
	s_cbranch_vccz 4                                           // 00000000C1A4: BFA30004 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1bb8>
	s_branch 57                                                // 00000000C1A8: BFA00039 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1c90>
	s_mov_b32 s4, 0                                            // 00000000C1AC: BE840080
	s_and_not1_b32 vcc_lo, exec_lo, s5                         // 00000000C1B0: 916A057E
	s_cbranch_vccnz 54                                         // 00000000C1B4: BFA40036 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1c90>
	s_waitcnt lgkmcnt(0)                                       // 00000000C1B8: BF89FC07
	v_add_f32_e32 v2, v15, v2                                  // 00000000C1BC: 0604050F
	s_cmp_eq_u32 exec_lo, 0                                    // 00000000C1C0: BF06807E
	s_cselect_b32 s5, -1, 0                                    // 00000000C1C4: 980580C1
	s_cmp_lg_u32 exec_lo, 0                                    // 00000000C1C8: BF07807E
	ds_bpermute_b32 v3, v3, v2                                 // 00000000C1CC: DACC0000 03000203
	s_cbranch_scc0 7                                           // 00000000C1D4: BFA10007 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1bf4>
	s_cmp_eq_u32 exec_lo, -1                                   // 00000000C1D8: BF06C17E
	s_mov_b32 s4, -1                                           // 00000000C1DC: BE8400C1
	s_cselect_b32 s5, -1, 0                                    // 00000000C1E0: 980580C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000C1E4: BF870009
	s_and_not1_b32 vcc_lo, exec_lo, s5                         // 00000000C1E8: 916A057E
	s_cbranch_vccz 4                                           // 00000000C1EC: BFA30004 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1c00>
	s_branch 39                                                // 00000000C1F0: BFA00027 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1c90>
	s_mov_b32 s4, 0                                            // 00000000C1F4: BE840080
	s_and_not1_b32 vcc_lo, exec_lo, s5                         // 00000000C1F8: 916A057E
	s_cbranch_vccnz 36                                         // 00000000C1FC: BFA40024 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1c90>
	s_waitcnt lgkmcnt(0)                                       // 00000000C200: BF89FC07
	v_add_f32_e32 v2, v2, v3                                   // 00000000C204: 06040702
	s_cmp_eq_u32 exec_lo, 0                                    // 00000000C208: BF06807E
	s_cselect_b32 s5, -1, 0                                    // 00000000C20C: 980580C1
	s_cmp_lg_u32 exec_lo, 0                                    // 00000000C210: BF07807E
	ds_bpermute_b32 v3, v4, v2                                 // 00000000C214: DACC0000 03000204
	s_cbranch_scc0 11                                          // 00000000C21C: BFA1000B <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1c4c>
	s_cmp_eq_u32 exec_lo, -1                                   // 00000000C220: BF06C17E
	s_mov_b32 s4, -1                                           // 00000000C224: BE8400C1
	s_cselect_b32 s5, -1, 0                                    // 00000000C228: 980580C1
	s_branch 8                                                 // 00000000C22C: BFA00008 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1c50>
	s_cbranch_execnz 104                                       // 00000000C230: BFA60068 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1dd4>
	s_mov_b32 s0, -1                                           // 00000000C234: BE8000C1
	s_and_not1_b32 vcc_lo, exec_lo, s4                         // 00000000C238: 916A047E
	s_cbranch_vccz 65463                                       // 00000000C23C: BFA3FFB7 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1b1c>
	s_and_b32 vcc_lo, exec_lo, s0                              // 00000000C240: 8B6A007E
	s_cbranch_vccnz 22                                         // 00000000C244: BFA40016 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1ca0>
	s_branch 21                                                // 00000000C248: BFA00015 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1ca0>
	s_mov_b32 s4, 0                                            // 00000000C24C: BE840080
	s_and_not1_b32 vcc_lo, exec_lo, s5                         // 00000000C250: 916A057E
	s_cbranch_vccnz 14                                         // 00000000C254: BFA4000E <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1c90>
	s_waitcnt lgkmcnt(0)                                       // 00000000C258: BF89FC07
	v_add_f32_e32 v3, v2, v3                                   // 00000000C25C: 06060702
	s_cmp_lg_u32 exec_lo, 0                                    // 00000000C260: BF07807E
	ds_bpermute_b32 v2, v5, v3                                 // 00000000C264: DACC0000 02000305
	s_cbranch_scc0 102                                         // 00000000C26C: BFA10066 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1e08>
	s_cmp_eq_u32 exec_lo, -1                                   // 00000000C270: BF06C17E
	s_cselect_b32 s1, -1, 0                                    // 00000000C274: 980180C1
	s_cmp_lg_u32 exec_lo, -1                                   // 00000000C278: BF07C17E
	s_cselect_b32 s4, -1, 0                                    // 00000000C27C: 980480C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000C280: BF870009
	s_and_b32 vcc_lo, exec_lo, s4                              // 00000000C284: 8B6A047E
	s_cbranch_vccz 3                                           // 00000000C288: BFA30003 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1c98>
	s_branch 96                                                // 00000000C28C: BFA00060 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1e10>
	s_and_b32 vcc_lo, exec_lo, s4                              // 00000000C290: 8B6A047E
	s_cbranch_vccnz 94                                         // 00000000C294: BFA4005E <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1e10>
	s_and_b32 vcc_lo, exec_lo, s0                              // 00000000C298: 8B6A007E
	s_cbranch_vccz 0                                           // 00000000C29C: BFA30000 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1ca0>
	s_and_not1_b32 vcc_lo, exec_lo, s1                         // 00000000C2A0: 916A017E
	s_cbranch_vccnz 74                                         // 00000000C2A4: BFA4004A <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1dd0>
	s_waitcnt lgkmcnt(0)                                       // 00000000C2A8: BF89FC07
	v_add_f32_e32 v2, v3, v2                                   // 00000000C2AC: 06040503
	v_cmp_eq_u32_e32 vcc_lo, 0, v14                            // 00000000C2B0: 7C941C80
	s_mov_b32 s1, 0                                            // 00000000C2B4: BE810080
	ds_bpermute_b32 v3, v6, v2                                 // 00000000C2B8: DACC0000 03000206
	s_and_b32 exec_lo, exec_lo, vcc_lo                         // 00000000C2C0: 8B7E6A7E
	s_cbranch_execz 66                                         // 00000000C2C4: BFA50042 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1dd0>
	s_waitcnt lgkmcnt(0)                                       // 00000000C2C8: BF89FC07
	v_add_f32_e32 v2, v2, v3                                   // 00000000C2CC: 06040702
	s_mul_i32 s0, s15, s3                                      // 00000000C2D0: 9600030F
	v_add_f32_e32 v0, v1, v0                                   // 00000000C2D4: 06000101
	s_lshl_b64 s[0:1], s[0:1], 2                               // 00000000C2D8: 84808200
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)// 00000000C2DC: BF8704C2
	v_mul_f32_e32 v3, 0xbfb8aa3b, v2                           // 00000000C2E0: 100604FF BFB8AA3B
	s_add_u32 s4, s10, s0                                      // 00000000C2E8: 8004000A
	s_addc_u32 s5, s11, s1                                     // 00000000C2EC: 8205010B
	s_ashr_i32 s3, s2, 31                                      // 00000000C2F0: 86039F02
	s_lshl_b64 s[0:1], s[2:3], 2                               // 00000000C2F4: 84808202
	v_fma_f32 v4, 0xbfb8aa3b, v2, -v3                          // 00000000C2F8: D6130004 840E04FF BFB8AA3B
	v_rndne_f32_e32 v5, v3                                     // 00000000C304: 7E0A4703
	s_add_u32 s0, s4, s0                                       // 00000000C308: 80000004
	s_addc_u32 s1, s5, s1                                      // 00000000C30C: 82010105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000000C310: BF8700B1
	v_sub_f32_e32 v3, v3, v5                                   // 00000000C314: 08060B03
	v_cmp_nlt_f32_e32 vcc_lo, 0x42ce8ed0, v2                   // 00000000C318: 7C3C04FF 42CE8ED0
	v_fmamk_f32 v4, v2, 0xb2a5705f, v4                         // 00000000C320: 58080902 B2A5705F
	v_add_f32_e32 v3, v3, v4                                   // 00000000C328: 06060903
	v_cvt_i32_f32_e32 v4, v5                                   // 00000000C32C: 7E081105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000000C330: BF8700B2
	v_exp_f32_e32 v3, v3                                       // 00000000C334: 7E064B03
	s_waitcnt_depctr 0xfff                                     // 00000000C338: BF880FFF
	v_ldexp_f32 v3, v3, v4                                     // 00000000C33C: D71C0003 00020903
	v_cndmask_b32_e32 v3, 0, v3, vcc_lo                        // 00000000C344: 02060680
	v_cmp_ngt_f32_e32 vcc_lo, 0xc2b17218, v2                   // 00000000C348: 7C3604FF C2B17218
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000C350: BF870092
	v_cndmask_b32_e32 v3, 0x7f800000, v3, vcc_lo               // 00000000C354: 020606FF 7F800000
	v_add_f32_e32 v3, 1.0, v3                                  // 00000000C35C: 060606F2
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000C360: BF870091
	v_div_scale_f32 v4, null, v3, v3, v2                       // 00000000C364: D6FC7C04 040A0703
	v_rcp_f32_e32 v5, v4                                       // 00000000C36C: 7E0A5504
	s_waitcnt_depctr 0xfff                                     // 00000000C370: BF880FFF
	v_fma_f32 v6, -v4, v5, 1.0                                 // 00000000C374: D6130006 23CA0B04
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000C37C: BF8700A1
	v_fmac_f32_e32 v5, v6, v5                                  // 00000000C380: 560A0B06
	v_div_scale_f32 v6, vcc_lo, v2, v3, v2                     // 00000000C384: D6FC6A06 040A0702
	v_mul_f32_e32 v7, v6, v5                                   // 00000000C38C: 100E0B06
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000C390: BF870091
	v_fma_f32 v8, -v4, v7, v6                                  // 00000000C394: D6130008 241A0F04
	v_fmac_f32_e32 v7, v8, v5                                  // 00000000C39C: 560E0B08
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000C3A0: BF870091
	v_fma_f32 v4, -v4, v7, v6                                  // 00000000C3A4: D6130004 241A0F04
	v_div_fmas_f32 v4, v4, v5, v7                              // 00000000C3AC: D6370004 041E0B04
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)// 00000000C3B4: BF870121
	v_div_fixup_f32 v1, v4, v3, v2                             // 00000000C3B8: D6270001 040A0704
	v_mov_b32_e32 v2, 0                                        // 00000000C3C0: 7E040280
	v_mul_f32_e32 v0, v0, v1                                   // 00000000C3C4: 10000300
	global_store_b32 v2, v0, s[0:1]                            // 00000000C3C8: DC6A0000 00000002
	s_endpgm                                                   // 00000000C3D0: BFB00000
	s_trap 2                                                   // 00000000C3D4: BF900002
	s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)        // 00000000C3D8: BE804C80
	s_mov_b32 ttmp2, m0                                        // 00000000C3DC: BEEE007D
	s_waitcnt lgkmcnt(0)                                       // 00000000C3E0: BF89FC07
	s_and_b32 s0, s0, 0x3ff                                    // 00000000C3E4: 8B00FF00 000003FF
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 00000000C3EC: BF870499
	s_bitset1_b32 s0, 10                                       // 00000000C3F0: BE80128A
	s_mov_b32 m0, s0                                           // 00000000C3F4: BEFD0000
	s_sendmsg sendmsg(MSG_INTERRUPT)                           // 00000000C3F8: BFB60001
	s_mov_b32 m0, ttmp2                                        // 00000000C3FC: BEFD006E
	s_sethalt 5                                                // 00000000C400: BF820005
	s_branch 65534                                             // 00000000C404: BFA0FFFE <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1e00>
	s_mov_b32 s1, -1                                           // 00000000C408: BE8100C1
	s_branch 65442                                             // 00000000C40C: BFA0FFA2 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1c98>
	s_cbranch_execnz 2                                         // 00000000C410: BFA60002 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1e1c>
	s_cbranch_execnz 65442                                     // 00000000C414: BFA6FFA2 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1ca0>
	s_branch 65441                                             // 00000000C418: BFA0FFA1 <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1ca0>
	s_trap 2                                                   // 00000000C41C: BF900002
	s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)        // 00000000C420: BE804C80
	s_mov_b32 ttmp2, m0                                        // 00000000C424: BEEE007D
	s_waitcnt lgkmcnt(0)                                       // 00000000C428: BF89FC07
	s_and_b32 s0, s0, 0x3ff                                    // 00000000C42C: 8B00FF00 000003FF
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 00000000C434: BF870499
	s_bitset1_b32 s0, 10                                       // 00000000C438: BE80128A
	s_mov_b32 m0, s0                                           // 00000000C43C: BEFD0000
	s_sendmsg sendmsg(MSG_INTERRUPT)                           // 00000000C440: BFB60001
	s_mov_b32 m0, ttmp2                                        // 00000000C444: BEFD006E
	s_sethalt 5                                                // 00000000C448: BF820005
	s_branch 65534                                             // 00000000C44C: BFA0FFFE <_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj+0x1e48>
		...

