_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj
0000000000009500 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj>:
	v_bfe_u32 v11, v0, 10, 10                                  // 000000009500: D610000B 02291500
	v_and_b32_e32 v10, 0x3ff, v0                               // 000000009508: 361400FF 000003FF
	s_mov_b32 s6, exec_lo                                      // 000000009510: BE86007E
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000009514: BF870091
	v_lshl_or_b32 v2, v11, 5, v10                              // 000000009518: D6560002 04290B0B
	v_cmpx_gt_u32_e32 0x100, v2                                // 000000009520: 7D9804FF 00000100
	s_cbranch_execz 89                                         // 000000009528: BFA50059 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x190>
	v_lshlrev_b32_e32 v3, 2, v2                                // 00000000952C: 30060482
	s_getpc_b64 s[4:5]                                         // 000000009530: BE844700
	s_add_u32 s4, s4, 0xffffcd4c                               // 000000009534: 8004FF04 FFFFCD4C
	s_addc_u32 s5, s5, lit(0xffffffff)                         // 00000000953C: 8205FF05 FFFFFFFF
	v_cmp_gt_u32_e32 vcc_lo, 0xe0, v2                          // 000000009544: 7C9804FF 000000E0
	global_load_b32 v0, v3, s[4:5]                             // 00000000954C: DC520000 00040003
	s_waitcnt vmcnt(0)                                         // 000000009554: BF8903F7
	ds_store_b32 v3, v0                                        // 000000009558: D8340000 00000003
	s_and_b32 exec_lo, exec_lo, vcc_lo                         // 000000009560: 8B7E6A7E
	s_cbranch_execz 74                                         // 000000009564: BFA5004A <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x190>
	v_add_co_u32 v0, s4, s4, v3                                // 000000009568: D7000400 00020604
	s_delay_alu instid0(VALU_DEP_1)                            // 000000009570: BF870001
	v_add_co_ci_u32_e64 v1, null, s5, 0, s4                    // 000000009574: D5207C01 00110005
	s_mov_b32 s4, exec_lo                                      // 00000000957C: BE84007E
	global_load_b32 v4, v[0:1], off offset:128                 // 000000009580: DC520080 047C0000
	s_waitcnt vmcnt(0)                                         // 000000009588: BF8903F7
	ds_store_b32 v3, v4 offset:128                             // 00000000958C: D8340080 00000403
	v_cmpx_gt_u32_e32 0xc0, v2                                 // 000000009594: 7D9804FF 000000C0
	s_xor_b32 s4, exec_lo, s4                                  // 00000000959C: 8D04047E
	s_cbranch_execz 59                                         // 0000000095A0: BFA5003B <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x190>
	global_load_b32 v4, v[0:1], off offset:256                 // 0000000095A4: DC520100 047C0000
	s_mov_b32 s4, exec_lo                                      // 0000000095AC: BE84007E
	s_waitcnt vmcnt(0)                                         // 0000000095B0: BF8903F7
	ds_store_b32 v3, v4 offset:256                             // 0000000095B4: D8340100 00000403
	v_cmpx_gt_u32_e32 0xa0, v2                                 // 0000000095BC: 7D9804FF 000000A0
	s_xor_b32 s4, exec_lo, s4                                  // 0000000095C4: 8D04047E
	s_cbranch_execz 49                                         // 0000000095C8: BFA50031 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x190>
	global_load_b32 v4, v[0:1], off offset:384                 // 0000000095CC: DC520180 047C0000
	s_mov_b32 s4, exec_lo                                      // 0000000095D4: BE84007E
	s_waitcnt vmcnt(0)                                         // 0000000095D8: BF8903F7
	ds_store_b32 v3, v4 offset:384                             // 0000000095DC: D8340180 00000403
	v_cmpx_gt_u32_e32 0x80, v2                                 // 0000000095E4: 7D9804FF 00000080
	s_xor_b32 s4, exec_lo, s4                                  // 0000000095EC: 8D04047E
	s_cbranch_execz 39                                         // 0000000095F0: BFA50027 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x190>
	global_load_b32 v4, v[0:1], off offset:512                 // 0000000095F4: DC520200 047C0000
	s_mov_b32 s4, exec_lo                                      // 0000000095FC: BE84007E
	s_waitcnt vmcnt(0)                                         // 000000009600: BF8903F7
	ds_store_b32 v3, v4 offset:512                             // 000000009604: D8340200 00000403
	v_cmpx_gt_u32_e32 0x60, v2                                 // 00000000960C: 7D9804FF 00000060
	s_xor_b32 s4, exec_lo, s4                                  // 000000009614: 8D04047E
	s_cbranch_execz 29                                         // 000000009618: BFA5001D <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x190>
	global_load_b32 v4, v[0:1], off offset:640                 // 00000000961C: DC520280 047C0000
	s_mov_b32 s4, exec_lo                                      // 000000009624: BE84007E
	s_waitcnt vmcnt(0)                                         // 000000009628: BF8903F7
	ds_store_b32 v3, v4 offset:640                             // 00000000962C: D8340280 00000403
	v_cmpx_gt_u32_e32 64, v2                                   // 000000009634: 7D9804C0
	s_xor_b32 s4, exec_lo, s4                                  // 000000009638: 8D04047E
	s_cbranch_execz 20                                         // 00000000963C: BFA50014 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x190>
	global_load_b32 v0, v[0:1], off offset:768                 // 000000009640: DC520300 007C0000
	s_mov_b32 s4, exec_lo                                      // 000000009648: BE84007E
	s_waitcnt vmcnt(0)                                         // 00000000964C: BF8903F7
	ds_store_b32 v3, v0 offset:768                             // 000000009650: D8340300 00000003
	v_cmpx_gt_u32_e32 32, v2                                   // 000000009658: 7D9804A0
	s_xor_b32 s4, exec_lo, s4                                  // 00000000965C: 8D04047E
	s_cbranch_execz 11                                         // 000000009660: BFA5000B <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x190>
	v_lshlrev_b32_e32 v0, 2, v10                               // 000000009664: 30001482
	s_getpc_b64 s[4:5]                                         // 000000009668: BE844700
	s_add_u32 s4, s4, 0xffffcf94                               // 00000000966C: 8004FF04 FFFFCF94
	s_addc_u32 s5, s5, lit(0xffffffff)                         // 000000009674: 8205FF05 FFFFFFFF
	global_load_b32 v1, v0, s[4:5]                             // 00000000967C: DC520000 01040000
	s_waitcnt vmcnt(0)                                         // 000000009684: BF8903F7
	ds_store_b32 v0, v1 offset:896                             // 000000009688: D8340380 00000100
	s_or_b32 exec_lo, exec_lo, s6                              // 000000009690: 8C7E067E
	s_load_b256 s[4:11], s[0:1], 0x10                          // 000000009694: F40C0100 F8000010
	v_lshrrev_b32_e32 v13, 3, v2                               // 00000000969C: 321A0483
	v_mov_b32_e32 v12, 0                                       // 0000000096A0: 7E180280
	s_mov_b32 s14, exec_lo                                     // 0000000096A4: BE8E007E
	s_waitcnt lgkmcnt(0)                                       // 0000000096A8: BF89FC07
	buffer_gl0_inv                                             // 0000000096AC: E0AC0000 00000000
	s_lshr_b32 s8, s8, 8                                       // 0000000096B4: 85088808
	s_delay_alu instid0(SALU_CYCLE_1)                          // 0000000096B8: BF870009
	v_cmpx_gt_u32_e64 s8, v13                                  // 0000000096BC: D4CC007E 00021A08
	s_cbranch_execz 756                                        // 0000000096C4: BFA502F4 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xd98>
	v_lshl_add_u32 v0, v11, 5, v10                             // 0000000096C8: D6460000 04290B0B
	s_mul_i32 s10, s10, s3                                     // 0000000096D0: 960A030A
	v_and_b32_e32 v4, 7, v10                                   // 0000000096D4: 36081487
	s_mul_hi_u32 s13, s10, 36                                  // 0000000096D8: 968DA40A
	s_mul_i32 s12, s10, 36                                     // 0000000096DC: 960CA40A
	v_lshrrev_b32_e32 v2, 3, v0                                // 0000000096E0: 32040083
	v_dual_mov_b32 v12, 0 :: v_dual_lshlrev_b32 v5, 1, v10     // 0000000096E4: CA220080 0C041481
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_4) | instid1(VALU_DEP_1)// 0000000096EC: BF8700D2
	v_mad_u64_u32 v[0:1], null, 0x120, v2, s[12:13]            // 0000000096F0: D6FE7C00 003204FF 00000120
	s_load_b64 s[12:13], s[0:1], null                          // 0000000096FC: F4040300 F8000000
	s_mov_b32 s1, 0                                            // 000000009704: BE810080
	v_mad_u64_u32 v[2:3], null, v4, 36, v[0:1]                 // 000000009708: D6FE7C02 04014904
	v_and_b32_e32 v0, 14, v5                                   // 000000009710: 36000A8E
	v_lshlrev_b32_e32 v1, 1, v0                                // 000000009714: 30020081
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)// 000000009718: BF870093
	v_add_co_u32 v2, vcc_lo, s4, v2                            // 00000000971C: D7006A02 00020404
	v_add_co_ci_u32_e64 v3, null, s5, v3, vcc_lo               // 000000009724: D5207C03 01AA0605
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000000972C: BF870193
	v_lshlrev_b32_e32 v14, 1, v1                               // 000000009730: 301C0281
	v_add_co_u32 v8, vcc_lo, v2, 32                            // 000000009734: D7006A08 00014102
	s_delay_alu instid0(VALU_DEP_1)                            // 00000000973C: BF870001
	v_add_co_ci_u32_e64 v9, null, 0, v3, vcc_lo                // 000000009740: D5207C09 01AA0680
	v_lshlrev_b32_e32 v15, 1, v0                               // 000000009748: 301E0081
	s_mul_i32 s4, s9, s2                                       // 00000000974C: 96040209
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_3) | instid1(VALU_DEP_3)// 000000009750: BF8701C9
	v_add_nc_u32_e32 v0, s4, v13                               // 000000009754: 4A001A04
	v_mov_b16_e32 v18.l, 0                                     // 000000009758: 7E243880
	v_add_nc_u32_e32 v13, 4, v13                               // 00000000975C: 4A1A1A84
	s_waitcnt lgkmcnt(0)                                       // 000000009760: BF89FC07
	v_mad_i64_i32 v[22:23], null, 0x42, v0, s[12:13]           // 000000009764: D6FF7C16 003200FF 00000042
	s_delay_alu instid0(VALU_DEP_3)                            // 000000009770: BF870003
	v_mov_b16_e32 v19.h, v18.l                                 // 000000009774: 7F263912
	v_mov_b16_e32 v20.h, v18.l                                 // 000000009778: 7F283912
	v_mov_b16_e32 v21.h, v18.l                                 // 00000000977C: 7F2A3912
	v_mov_b16_e32 v46.h, v18.l                                 // 000000009780: 7F5C3912
	v_mov_b16_e32 v47.h, v18.l                                 // 000000009784: 7F5E3912
	v_mov_b16_e32 v48.h, v18.l                                 // 000000009788: 7F603912
	v_add_co_u32 v0, vcc_lo, v22, v14                          // 00000000978C: D7006A00 00021D16
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 000000009794: BF8700A1
	v_add_co_ci_u32_e64 v1, null, 0, v23, vcc_lo               // 000000009798: D5207C01 01AA2E80
	v_add_co_u32 v2, vcc_lo, v22, v15                          // 0000000097A0: D7006A02 00021F16
	v_add_co_ci_u32_e64 v3, null, 0, v23, vcc_lo               // 0000000097A8: D5207C03 01AA2E80
	s_clause 0x1                                               // 0000000097B0: BF850001
	global_load_b64 v[24:25], v[0:1], off                      // 0000000097B4: DC560000 187C0000
	global_load_b32 v16, v[2:3], off offset:64                 // 0000000097BC: DC520040 107C0002
	s_clause 0x2                                               // 0000000097C4: BF850002
	global_load_b128 v[0:3], v[8:9], off offset:-32            // 0000000097C8: DC5E1FE0 007C0008
	global_load_b32 v17, v[8:9], off                           // 0000000097D0: DC520000 117C0008
	global_load_b128 v[4:7], v[8:9], off offset:-16            // 0000000097D8: DC5E1FF0 047C0008
	global_load_d16_hi_b16 v0, v[22:23], off offset:64         // 0000000097E0: DC8E0040 007C0016
	v_mov_b16_e32 v49.h, v18.l                                 // 0000000097E8: 7F623912
	v_mov_b16_e32 v50.h, v18.l                                 // 0000000097EC: 7F643912
	v_cmp_le_u32_e64 s0, s8, v13                               // 0000000097F0: D44B0000 00021A08
	s_or_b32 s1, s0, s1                                        // 0000000097F8: 8C010100
	s_waitcnt vmcnt(5)                                         // 0000000097FC: BF8917F7
	v_and_b32_e32 v22, 0xff, v24                               // 000000009800: 362C30FF 000000FF
	s_waitcnt vmcnt(4)                                         // 000000009808: BF8913F7
	v_and_b32_e32 v26, 0xff, v16                               // 00000000980C: 363420FF 000000FF
	v_lshrrev_b32_e32 v23, 6, v24                              // 000000009814: 322E3086
	v_lshrrev_b32_e32 v27, 14, v24                             // 000000009818: 3236308E
	v_lshrrev_b32_e32 v24, 22, v24                             // 00000000981C: 32303096
	v_and_b32_e32 v29, 0xff, v25                               // 000000009820: 363A32FF 000000FF
	v_bcnt_u32_b32 v34, v26, 0                                 // 000000009828: D71E0022 0001011A
	v_bfe_u32 v28, v16, 7, 8                                   // 000000009830: D610001C 02210F10
	v_lshrrev_b32_e32 v30, 6, v25                              // 000000009838: 323C3286
	v_bfe_u32 v31, v16, 14, 8                                  // 00000000983C: D610001F 02211D10
	v_lshrrev_b32_e32 v32, 14, v25                             // 000000009844: 3240328E
	v_lshrrev_b32_e32 v25, 22, v25                             // 000000009848: 32323296
	v_bfe_u32 v33, v16, 21, 8                                  // 00000000984C: D6100021 02212B10
	v_lshlrev_b32_e32 v22, 2, v22                              // 000000009854: 302C2C82
	v_and_b32_e32 v34, 1, v34                                  // 000000009858: 36444481
	v_and_b32_e32 v23, 0x3fc, v23                              // 00000000985C: 362E2EFF 000003FC
	v_and_b32_e32 v27, 0x3fc, v27                              // 000000009864: 363636FF 000003FC
	v_and_b32_e32 v24, 0x3fc, v24                              // 00000000986C: 363030FF 000003FC
	v_lshlrev_b32_e32 v29, 2, v29                              // 000000009874: 303A3A82
	v_bcnt_u32_b32 v35, v28, 0                                 // 000000009878: D71E0023 0001011C
	v_and_b32_e32 v30, 0x3fc, v30                              // 000000009880: 363C3CFF 000003FC
	v_bcnt_u32_b32 v36, v31, 0                                 // 000000009888: D71E0024 0001011F
	v_and_b32_e32 v32, 0x3fc, v32                              // 000000009890: 364040FF 000003FC
	v_and_b32_e32 v25, 0x3fc, v25                              // 000000009898: 363232FF 000003FC
	v_bcnt_u32_b32 v37, v33, 0                                 // 0000000098A0: D71E0025 00010121
	ds_load_b32 v51, v22                                       // 0000000098A8: D8D80000 33000016
	ds_load_b32 v52, v23                                       // 0000000098B0: D8D80000 34000017
	ds_load_b32 v53, v27                                       // 0000000098B8: D8D80000 3500001B
	ds_load_b32 v54, v24                                       // 0000000098C0: D8D80000 36000018
	ds_load_b32 v55, v29                                       // 0000000098C8: D8D80000 3700001D
	ds_load_b32 v56, v30                                       // 0000000098D0: D8D80000 3800001E
	ds_load_b32 v57, v32                                       // 0000000098D8: D8D80000 39000020
	ds_load_b32 v58, v25                                       // 0000000098E0: D8D80000 3A000019
	v_lshlrev_b32_e32 v23, 7, v34                              // 0000000098E8: 302E4487
	v_and_b32_e32 v35, 1, v35                                  // 0000000098EC: 36464681
	v_and_b32_e32 v36, 1, v36                                  // 0000000098F0: 36484881
	v_and_b32_e32 v22, 1, v37                                  // 0000000098F4: 362C4A81
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 0000000098F8: BF870214
	v_xor_b32_e32 v23, v23, v26                                // 0000000098FC: 3A2E3517
	v_lshlrev_b32_e32 v24, 7, v35                              // 000000009900: 30304687
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 000000009904: BF870214
	v_lshlrev_b32_e32 v25, 7, v36                              // 000000009908: 30324887
	v_lshlrev_b32_e32 v22, 7, v22                              // 00000000990C: 302C2C87
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 000000009910: BF870214
	v_mul_lo_u32 v23, 0x1010101, v23                           // 000000009914: D72C0017 00022EFF 01010101
	v_xor_b32_e32 v24, v24, v28                                // 000000009920: 3A303918
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 000000009924: BF870214
	v_xor_b32_e32 v25, v25, v31                                // 000000009928: 3A323F19
	v_xor_b32_e32 v22, v22, v33                                // 00000000992C: 3A2C4316
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)// 000000009930: BF870193
	v_mul_lo_u32 v24, 0x1010101, v24                           // 000000009934: D72C0018 000230FF 01010101
	v_mul_lo_u32 v25, 0x1010101, v25                           // 000000009940: D72C0019 000232FF 01010101
	v_and_b32_e32 v26, 0x8040201, v23                          // 00000000994C: 36342EFF 08040201
	s_delay_alu instid0(VALU_DEP_4)                            // 000000009954: BF870004
	v_mul_lo_u32 v22, 0x1010101, v22                           // 000000009958: D72C0016 00022CFF 01010101
	v_lshrrev_b32_e32 v27, 18, v23                             // 000000009964: 32362E92
	v_bfe_i32 v28, v23, 0, 1                                   // 000000009968: D611001C 02050117
	v_and_b32_e32 v29, 0x80402010, v23                         // 000000009970: 363A2EFF 80402010
	v_lshrrev_b32_e32 v43, 24, v26                             // 000000009978: 32563498
	v_lshrrev_b32_e32 v23, 22, v23                             // 00000000997C: 322E2E96
	v_and_b32_e32 v30, 0x8040201, v24                          // 000000009980: 363C30FF 08040201
	v_lshrrev_b32_e32 v31, 18, v24                             // 000000009988: 323E3092
	v_bfe_i32 v32, v24, 0, 1                                   // 00000000998C: D6110020 02050118
	v_and_b32_e32 v33, 0x80402010, v24                         // 000000009994: 364230FF 80402010
	v_lshrrev_b32_e32 v24, 22, v24                             // 00000000999C: 32303096
	v_and_b32_e32 v34, 0x8040201, v25                          // 0000000099A0: 364432FF 08040201
	v_lshrrev_b32_e32 v35, 18, v25                             // 0000000099A8: 32463292
	v_bfe_i32 v36, v25, 0, 1                                   // 0000000099AC: D6110024 02050119
	v_and_b32_e32 v37, 0x80402010, v25                         // 0000000099B4: 364A32FF 80402010
	v_lshrrev_b32_e32 v25, 22, v25                             // 0000000099BC: 32323296
	v_and_b32_e32 v38, 0x8040201, v22                          // 0000000099C0: 364C2CFF 08040201
	v_lshrrev_b32_e32 v39, 18, v22                             // 0000000099C8: 324E2C92
	v_bfe_i32 v40, v22, 0, 1                                   // 0000000099CC: D6110028 02050116
	v_and_b32_e32 v41, 0x80402010, v22                         // 0000000099D4: 36522CFF 80402010
	v_lshrrev_b32_e32 v42, 22, v22                             // 0000000099DC: 32542C96
	v_lshrrev_b16 v18.h, 8, v26.l op_sel:[0,0,1]               // 0000000099E0: D7394012 00023488
	v_cmp_ne_u16_e32 vcc_lo, 0, v43.l                          // 0000000099E8: 7C7A5680
	v_mov_b16_e32 v19.l, v28.l                                 // 0000000099EC: 7E26391C
	v_lshrrev_b32_e32 v28, 24, v29                             // 0000000099F0: 32383A98
	v_bfe_i32 v44, v23, 0, 1                                   // 0000000099F4: D611002C 02050117
	v_lshrrev_b32_e32 v45, 24, v30                             // 0000000099FC: 325A3C98
	v_lshrrev_b16 v21.l, 8, v30.l                              // 000000009A00: D7390015 00023C88
	v_bfe_i32 v30, v31, 0, 1                                   // 000000009A08: D611001E 0205011F
	v_mov_b16_e32 v22.l, v32.l                                 // 000000009A10: 7E2C3920
	v_lshrrev_b32_e32 v31, 24, v33                             // 000000009A14: 323E4298
	v_lshrrev_b16 v22.h, 8, v33.l op_sel:[0,0,1]               // 000000009A18: D7394016 00024288
	v_lshrrev_b16 v32.l, 4, v33.l                              // 000000009A20: D7390020 00024284
	v_bfe_i32 v33, v24, 0, 1                                   // 000000009A28: D6110021 02050118
	v_lshrrev_b32_e32 v59, 24, v34                             // 000000009A30: 32764498
	v_lshrrev_b16 v23.l, 8, v34.l                              // 000000009A34: D7390017 00024488
	v_bfe_i32 v34, v35, 0, 1                                   // 000000009A3C: D6110022 02050123
	v_mov_b16_e32 v24.l, v36.l                                 // 000000009A44: 7E303924
	v_lshrrev_b32_e32 v35, 24, v37                             // 000000009A48: 32464A98
	v_lshrrev_b16 v23.h, 8, v37.l op_sel:[0,0,1]               // 000000009A4C: D7394017 00024A88
	v_lshrrev_b16 v36.l, 4, v37.l                              // 000000009A54: D7390024 00024A84
	v_bfe_i32 v37, v25, 0, 1                                   // 000000009A5C: D6110025 02050119
	v_lshrrev_b32_e32 v60, 24, v38                             // 000000009A64: 32784C98
	v_lshrrev_b16 v24.h, 8, v38.l op_sel:[0,0,1]               // 000000009A68: D7394018 00024C88
	v_bfe_i32 v38, v39, 0, 1                                   // 000000009A70: D6110026 02050127
	v_mov_b16_e32 v25.l, v40.l                                 // 000000009A78: 7E323928
	v_lshrrev_b32_e32 v39, 24, v41                             // 000000009A7C: 324E5298
	v_lshrrev_b16 v25.h, 8, v41.l op_sel:[0,0,1]               // 000000009A80: D7394019 00025288
	v_lshrrev_b16 v40.l, 4, v41.l                              // 000000009A88: D7390028 00025284
	v_bfe_i32 v41, v42, 0, 1                                   // 000000009A90: D6110029 0205012A
	v_cndmask_b32_e64 v42, 0, -1, vcc_lo                       // 000000009A98: D501002A 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v18.h                          // 000000009AA0: 7C7B2480
	v_lshrrev_b16 v20.l, 8, v29.l                              // 000000009AA4: D7390014 00023A88
	v_bfe_i32 v26, v27, 0, 1                                   // 000000009AAC: D611001A 0205011B
	v_and_b16 v26.h, 0xff, v19.l op_sel:[0,0,1]                // 000000009AB4: D762401A 000226FF 000000FF
	v_lshlrev_b16 v27.l, 8, v19.l                              // 000000009AC0: D738001B 00022688
	v_cndmask_b32_e64 v43, 0, -1, vcc_lo                       // 000000009AC8: D501002B 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v28.l                          // 000000009AD0: 7C7A3880
	v_mov_b16_e32 v19.l, v44.l                                 // 000000009AD4: 7E26392C
	v_lshrrev_b16 v29.l, 4, v29.l                              // 000000009AD8: D739001D 00023A84
	v_bfe_i32 v66, v32, 0, 1                                   // 000000009AE0: D6110042 02050120
	v_mov_b16_e32 v28.l, v34.l                                 // 000000009AE8: 7E383922
	v_cndmask_b32_e64 v44, 0, -1, vcc_lo                       // 000000009AEC: D501002C 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v20.l                          // 000000009AF4: 7C7A2880
	v_bfe_i32 v62, v29, 0, 1                                   // 000000009AF8: D611003E 0205011D
	v_mov_b16_e32 v20.l, v30.l                                 // 000000009B00: 7E28391E
	v_mov_b16_e32 v30.l, v42.l                                 // 000000009B04: 7E3C392A
	v_and_b16 v18.h, 0xff, v26.l op_sel:[0,0,1]                // 000000009B08: D7624012 000234FF 000000FF
	v_cndmask_b32_e64 v61, 0, -1, vcc_lo                       // 000000009B14: D501003D 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v45.l                          // 000000009B1C: 7C7A5A80
	v_mov_b16_e32 v32.l, v44.l                                 // 000000009B20: 7E40392C
	v_mov_b16_e32 v34.l, v62.l                                 // 000000009B24: 7E44393E
	v_lshlrev_b16 v28.h, 8, v19.l op_sel:[0,0,1]               // 000000009B28: D738401C 00022688
	v_lshlrev_b16 v30.l, 8, v30.l                              // 000000009B30: D738001E 00023C88
	v_cndmask_b32_e64 v45, 0, -1, vcc_lo                       // 000000009B38: D501002D 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.l                          // 000000009B40: 7C7A2A80
	v_mov_b16_e32 v21.l, v33.l                                 // 000000009B44: 7E2A3921
	v_mov_b16_e32 v33.l, v61.l                                 // 000000009B48: 7E42393D
	v_and_b16 v29.h, 0xff, v20.l op_sel:[0,0,1]                // 000000009B4C: D762401D 000228FF 000000FF
	v_lshlrev_b16 v30.h, 8, v20.l op_sel:[0,0,1]               // 000000009B58: D738401E 00022888
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo                       // 000000009B60: D501003F 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v31.l                          // 000000009B68: 7C7A3E80
	v_mov_b16_e32 v31.l, v43.l                                 // 000000009B6C: 7E3E392B
	v_lshlrev_b16 v32.l, 8, v32.l                              // 000000009B70: D7380020 00024088
	v_lshlrev_b16 v33.l, 8, v33.l                              // 000000009B78: D7380021 00024288
	v_and_b16 v37.h, 0xff, v34.l op_sel:[0,0,1]                // 000000009B80: D7624025 000244FF 000000FF
	v_cndmask_b32_e64 v64, 0, -1, vcc_lo                       // 000000009B8C: D5010040 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v22.h                          // 000000009B94: 7C7B2C80
	v_lshlrev_b16 v31.l, 8, v31.l                              // 000000009B98: D738001F 00023E88
	v_or_b16 v18.h, v18.h, v30.l op_sel:[1,0,1]                // 000000009BA0: D7634812 00023D12
	v_and_b16 v27.h, 0xff, v22.l op_sel:[0,0,1]                // 000000009BA8: D762401B 00022CFF 000000FF
	v_mov_b16_e32 v20.l, v64.l                                 // 000000009BB4: 7E283940
	v_cndmask_b32_e64 v65, 0, -1, vcc_lo                       // 000000009BB8: D5010041 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v59.l                          // 000000009BC0: 7C7A7680
	v_and_b16 v22.h, 0xff, v24.l op_sel:[0,0,1]                // 000000009BC4: D7624016 000230FF 000000FF
	v_bfe_i32 v70, v36, 0, 1                                   // 000000009BD0: D6110046 02050124
	v_bfe_i32 v74, v40, 0, 1                                   // 000000009BD8: D611004A 02050128
	v_and_b16 v31.h, 0xff, v21.l op_sel:[0,0,1]                // 000000009BE0: D762401F 00022AFF 000000FF
	v_cndmask_b32_e64 v59, 0, -1, vcc_lo                       // 000000009BEC: D501003B 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v23.l                          // 000000009BF4: 7C7A2E80
	v_lshlrev_b16 v23.l, 8, v24.l                              // 000000009BF8: D7380017 00023088
	v_mov_b16_e32 v24.l, v37.l                                 // 000000009C00: 7E303925
	v_mov_b16_e32 v36.l, v65.l                                 // 000000009C04: 7E483941
	v_mov_b16_e32 v37.l, v66.l                                 // 000000009C08: 7E4A3942
	v_cndmask_b32_e64 v67, 0, -1, vcc_lo                       // 000000009C0C: D5010043 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v35.l                          // 000000009C14: 7C7A4680
	v_mov_b16_e32 v35.l, v63.l                                 // 000000009C18: 7E46393F
	v_lshlrev_b16 v32.h, 8, v21.l op_sel:[0,0,1]               // 000000009C1C: D7384020 00022A88
	v_mov_b16_e32 v21.l, v59.l                                 // 000000009C24: 7E2A393B
	v_lshlrev_b16 v39.h, 8, v20.l op_sel:[0,0,1]               // 000000009C28: D7384027 00022888
	v_cndmask_b32_e64 v68, 0, -1, vcc_lo                       // 000000009C30: D5010044 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v23.h                          // 000000009C38: 7C7B2E80
	v_lshlrev_b16 v35.l, 8, v35.l                              // 000000009C3C: D7380023 00024688
	v_or_b16 v20.l, v37.h, v33.l op_sel:[1,0,0]                // 000000009C44: D7630814 00024325
	v_mov_b16_e32 v29.l, v38.l                                 // 000000009C4C: 7E3A3926
	v_mov_b16_e32 v38.l, v67.l                                 // 000000009C50: 7E4C3943
	v_cndmask_b32_e64 v69, 0, -1, vcc_lo                       // 000000009C54: D5010045 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v60.l                          // 000000009C5C: 7C7A7880
	v_mov_b16_e32 v46.l, v74.l                                 // 000000009C60: 7E5C394A
	v_lshlrev_b16 v36.l, 8, v36.l                              // 000000009C64: D7380024 00024888
	v_and_b16 v40.h, 0xff, v37.l op_sel:[0,0,1]                // 000000009C6C: D7624028 00024AFF 000000FF
	v_lshlrev_b16 v41.h, 8, v21.l op_sel:[0,0,1]               // 000000009C78: D7384029 00022A88
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo                       // 000000009C80: D501003C 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v24.h                          // 000000009C88: 7C7B3080
	v_or_b16 v21.l, v27.h, v35.l op_sel:[1,0,0]                // 000000009C8C: D7630815 0002471B
	v_and_b16 v23.h, 0xff, v25.l op_sel:[0,0,1]                // 000000009C94: D7624017 000232FF 000000FF
	v_lshlrev_b16 v24.h, 8, v25.l op_sel:[0,0,1]               // 000000009CA0: D7384018 00023288
	v_mov_b16_e32 v25.l, v41.l                                 // 000000009CA8: 7E323929
	v_cndmask_b32_e64 v71, 0, -1, vcc_lo                       // 000000009CAC: D5010047 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v39.l                          // 000000009CB4: 7C7A4E80
	v_and_b16 v33.h, 0xff, v28.l op_sel:[0,0,1]                // 000000009CB8: D7624021 000238FF 000000FF
	v_mov_b16_e32 v39.l, v68.l                                 // 000000009CC4: 7E4E3944
	v_mov_b16_e32 v40.l, v69.l                                 // 000000009CC8: 7E503945
	v_mov_b16_e32 v41.l, v70.l                                 // 000000009CCC: 7E523946
	v_cndmask_b32_e64 v72, 0, -1, vcc_lo                       // 000000009CD0: D5010048 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v25.h                          // 000000009CD8: 7C7B3280
	v_lshlrev_b16 v25.h, 8, v26.l op_sel:[0,0,1]               // 000000009CDC: D7384019 00023488
	v_and_b16 v26.l, 0xff, v19.l                               // 000000009CE4: D762001A 000226FF 000000FF
	v_mov_b16_e32 v19.l, v45.l                                 // 000000009CF0: 7E26392D
	v_mov_b16_e32 v44.l, v72.l                                 // 000000009CF4: 7E583948
	v_cndmask_b32_e64 v73, 0, -1, vcc_lo                       // 000000009CF8: D5010049 01A98280
	v_lshlrev_b16 v38.l, 8, v38.l                              // 000000009D00: D7380026 00024C88
	v_and_b16 v44.h, 0xff, v46.l op_sel:[0,0,1]                // 000000009D08: D762402C 00025CFF 000000FF
	v_lshlrev_b16 v38.h, 8, v19.l op_sel:[0,0,1]               // 000000009D14: D7384026 00022688
	v_or_b16 v19.l, v26.h, v31.l op_sel:[1,0,0]                // 000000009D1C: D7630813 00023F1A
	v_mov_b16_e32 v45.l, v73.l                                 // 000000009D24: 7E5A3949
	v_lshlrev_b16 v43.h, 8, v44.l op_sel:[0,0,1]               // 000000009D28: D738402B 00025888
	v_and_b16 v34.h, 0xff, v24.l op_sel:[0,0,1]                // 000000009D30: D7624022 000230FF 000000FF
	v_mov_b16_e32 v42.l, v60.l                                 // 000000009D3C: 7E54393C
	v_or_b32_e32 v19, v19, v18                                 // 000000009D40: 38262513
	v_or_b16 v18.h, v26.l, v32.l op_sel:[0,0,1]                // 000000009D44: D7634012 0002411A
	v_lshlrev_b16 v44.l, 8, v45.l                              // 000000009D4C: D738002C 00025A88
	v_lshlrev_b16 v45.l, 8, v46.l                              // 000000009D54: D738002D 00025C88
	v_or_b16 v46.l, v40.h, v36.l op_sel:[1,0,0]                // 000000009D5C: D763082E 00024928
	s_waitcnt lgkmcnt(7)                                       // 000000009D64: BF89FC77
	v_xor_b32_e32 v26, v51, v19                                // 000000009D68: 3A342733
	v_or_b32_e32 v51, v20, v18                                 // 000000009D6C: 38662514
	v_or_b16 v18.h, v29.h, v38.h op_sel:[1,1,1]                // 000000009D70: D7635812 00024D1D
	v_mov_b16_e32 v43.l, v71.l                                 // 000000009D78: 7E563947
	v_lshlrev_b16 v34.l, 8, v34.l                              // 000000009D7C: D7380022 00024488
	v_and_b16 v19.l, 0xff00, v26.l                             // 000000009D84: D7620013 000234FF FFFFFF00
	v_lshlrev_b16 v19.h, 8, v26.l op_sel:[0,0,1]               // 000000009D90: D7384013 00023488
	v_and_b16 v20.l, 0xff00, v26.h op_sel:[0,1,0]              // 000000009D98: D7621014 000234FF FFFFFF00
	v_lshlrev_b16 v20.h, 8, v26.h op_sel:[0,1,1]               // 000000009DA4: D7385014 00023488
	s_waitcnt lgkmcnt(6)                                       // 000000009DAC: BF89FC67
	v_xor_b32_e32 v26, v52, v51                                // 000000009DB0: 3A346734
	v_or_b32_e32 v21, v21, v18                                 // 000000009DB4: 382A2515
	v_or_b16 v18.h, v31.h, v39.h op_sel:[1,1,1]                // 000000009DB8: D7635812 00024F1F
	v_lshlrev_b16 v39.l, 8, v39.l                              // 000000009DC0: D7380027 00024E88
	v_lshlrev_b16 v40.l, 8, v40.l                              // 000000009DC8: D7380028 00025088
	v_and_b16 v42.h, 0xff, v41.l op_sel:[0,0,1]                // 000000009DD0: D762402A 000252FF 000000FF
	v_or_b16 v47.l, v22.h, v38.l op_sel:[1,0,0]                // 000000009DDC: D763082F 00024D16
	v_sub_nc_i16 v31.l, v19.l, v31.l clamp                     // 000000009DE4: D70E801F 00023F13
	v_sub_nc_i16 v27.l, v19.h, v27.l op_sel:[1,0,0] clamp      // 000000009DEC: D70E881B 00023713
	v_sub_nc_i16 v30.l, v20.l, v30.l clamp                     // 000000009DF4: D70E801E 00023D14
	v_sub_nc_i16 v51.l, v20.h, v25.h op_sel:[1,1,0] clamp      // 000000009DFC: D70E9833 00023314
	v_and_b16 v19.l, 0xff00, v26.l                             // 000000009E04: D7620013 000234FF FFFFFF00
	v_lshlrev_b16 v19.h, 8, v26.l op_sel:[0,0,1]               // 000000009E10: D7384013 00023488
	v_and_b16 v20.l, 0xff00, v26.h op_sel:[0,1,0]              // 000000009E18: D7621014 000234FF FFFFFF00
	v_lshlrev_b16 v20.h, 8, v26.h op_sel:[0,1,1]               // 000000009E24: D7385014 00023488
	s_waitcnt lgkmcnt(5)                                       // 000000009E2C: BF89FC57
	v_xor_b32_e32 v21, v53, v21                                // 000000009E30: 3A2A2B35
	v_or_b32_e32 v26, v46, v18                                 // 000000009E34: 3834252E
	v_or_b16 v18.h, v33.h, v41.h op_sel:[1,1,1]                // 000000009E38: D7635812 00025321
	v_lshlrev_b16 v22.l, 8, v22.l                              // 000000009E40: D7380016 00022C88
	v_and_b16 v35.h, 0xff, v29.l op_sel:[0,0,1]                // 000000009E48: D7624023 00023AFF 000000FF
	v_lshlrev_b16 v42.l, 8, v42.l                              // 000000009E54: D738002A 00025488
	v_lshlrev_b16 v43.l, 8, v43.l                              // 000000009E5C: D738002B 00025688
	v_or_b16 v48.l, v42.h, v40.l op_sel:[1,0,0]                // 000000009E64: D7630830 0002512A
	v_perm_b32 v27, v27, v31, 0xc0c0105                        // 000000009E6C: D644001B 03FE3F1B 0C0C0105
	v_perm_b32 v31, v51, v30, 0xc0c0105                        // 000000009E78: D644001F 03FE3D33 0C0C0105
	v_sub_nc_i16 v30.l, v19.l, v33.l clamp                     // 000000009E84: D70E801E 00024313
	v_sub_nc_i16 v33.l, v19.h, v34.l op_sel:[1,0,0] clamp      // 000000009E8C: D70E8821 00024513
	v_sub_nc_i16 v32.l, v20.l, v32.l clamp                     // 000000009E94: D70E8020 00024114
	v_sub_nc_i16 v34.l, v20.h, v28.h op_sel:[1,1,0] clamp      // 000000009E9C: D70E9822 00023914
	v_and_b16 v19.l, 0xff00, v21.l                             // 000000009EA4: D7620013 00022AFF FFFFFF00
	v_lshlrev_b16 v19.h, 8, v21.l op_sel:[0,0,1]               // 000000009EB0: D7384013 00022A88
	v_and_b16 v20.l, 0xff00, v21.h op_sel:[0,1,0]              // 000000009EB8: D7621014 00022AFF FFFFFF00
	v_lshlrev_b16 v20.h, 8, v21.h op_sel:[0,1,1]               // 000000009EC4: D7385014 00022A88
	s_waitcnt lgkmcnt(4)                                       // 000000009ECC: BF89FC47
	v_xor_b32_e32 v21, v54, v26                                // 000000009ED0: 3A2A3536
	v_or_b32_e32 v26, v47, v18                                 // 000000009ED4: 3834252F
	v_or_b16 v18.h, v34.h, v39.l op_sel:[1,0,1]                // 000000009ED8: D7634812 00024F22
	v_and_b16 v36.h, 0xff, v25.l op_sel:[0,0,1]                // 000000009EE0: D7624024 000232FF 000000FF
	v_lshlrev_b16 v37.l, 8, v37.l                              // 000000009EEC: D7380025 00024A88
	v_or_b16 v49.l, v23.h, v43.l op_sel:[1,0,0]                // 000000009EF4: D7630831 00025717
	v_lshl_or_b32 v27, v31, 16, v27                            // 000000009EFC: D656001B 046D211F
	v_perm_b32 v31, v33, v30, 0xc0c0105                        // 000000009F04: D644001F 03FE3D21 0C0C0105
	v_perm_b32 v33, v34, v32, 0xc0c0105                        // 000000009F10: D6440021 03FE4122 0C0C0105
	v_sub_nc_i16 v30.l, v19.l, v35.l clamp                     // 000000009F1C: D70E801E 00024713
	v_sub_nc_i16 v22.l, v19.h, v22.l op_sel:[1,0,0] clamp      // 000000009F24: D70E8816 00022D13
	v_sub_nc_i16 v32.l, v20.l, v38.h op_sel:[0,1,0] clamp      // 000000009F2C: D70E9020 00024D14
	v_sub_nc_i16 v34.l, v20.h, v30.h op_sel:[1,1,0] clamp      // 000000009F34: D70E9822 00023D14
	v_and_b16 v19.l, 0xff00, v21.l                             // 000000009F3C: D7620013 00022AFF FFFFFF00
	v_lshlrev_b16 v19.h, 8, v21.l op_sel:[0,0,1]               // 000000009F48: D7384013 00022A88
	v_and_b16 v20.l, 0xff00, v21.h op_sel:[0,1,0]              // 000000009F50: D7621014 00022AFF FFFFFF00
	v_lshlrev_b16 v20.h, 8, v21.h op_sel:[0,1,1]               // 000000009F5C: D7385014 00022A88
	s_waitcnt lgkmcnt(3)                                       // 000000009F64: BF89FC37
	v_xor_b32_e32 v21, v55, v26                                // 000000009F68: 3A2A3537
	v_or_b32_e32 v26, v48, v18                                 // 000000009F6C: 38342530
	v_or_b16 v18.h, v35.h, v42.l op_sel:[1,0,1]                // 000000009F70: D7634812 00025523
	v_lshlrev_b16 v28.l, 8, v28.l                              // 000000009F78: D738001C 00023888
	v_or_b16 v50.l, v44.h, v44.l op_sel:[1,0,0]                // 000000009F80: D7630832 0002592C
	v_lshl_or_b32 v31, v33, 16, v31                            // 000000009F88: D656001F 047D2121
	s_waitcnt vmcnt(3)                                         // 000000009F90: BF890FF7
	v_dot4_i32_iu8 v27, v27, v1, 0 neg_lo:[1,1,0]              // 000000009F94: CC16401B 7A02031B
	v_perm_b32 v22, v22, v30, 0xc0c0105                        // 000000009F9C: D6440016 03FE3D16 0C0C0105
	v_perm_b32 v30, v34, v32, 0xc0c0105                        // 000000009FA8: D644001E 03FE4122 0C0C0105
	v_sub_nc_i16 v32.l, v19.l, v36.l clamp                     // 000000009FB4: D70E8020 00024913
	v_sub_nc_i16 v33.l, v19.h, v37.l op_sel:[1,0,0] clamp      // 000000009FBC: D70E8821 00024B13
	v_sub_nc_i16 v20.l, v20.l, v39.h op_sel:[0,1,0] clamp      // 000000009FC4: D70E9014 00024F14
	v_sub_nc_i16 v34.l, v20.h, v32.h op_sel:[1,1,0] clamp      // 000000009FCC: D70E9822 00024114
	v_and_b16 v1.l, 0xff00, v21.l                              // 000000009FD4: D7620001 00022AFF FFFFFF00
	v_lshlrev_b16 v1.h, 8, v21.l op_sel:[0,0,1]                // 000000009FE0: D7384001 00022A88
	v_and_b16 v19.l, 0xff00, v21.h op_sel:[0,1,0]              // 000000009FE8: D7621013 00022AFF FFFFFF00
	v_lshlrev_b16 v19.h, 8, v21.h op_sel:[0,1,1]               // 000000009FF4: D7385013 00022A88
	s_waitcnt lgkmcnt(2)                                       // 000000009FFC: BF89FC27
	v_xor_b32_e32 v21, v56, v26                                // 00000000A000: 3A2A3538
	v_or_b32_e32 v26, v49, v18                                 // 00000000A004: 38342531
	v_or_b16 v18.h, v36.h, v43.h op_sel:[1,1,1]                // 00000000A008: D7635812 00025724
	v_lshlrev_b16 v24.l, 8, v24.l                              // 00000000A010: D7380018 00023088
	v_lshlrev_b16 v41.l, 8, v41.l                              // 00000000A018: D7380029 00025288
	v_dot4_i32_iu8 v27, v31, v2, v27 neg_lo:[1,1,0]            // 00000000A020: CC16401B 7C6E051F
	v_lshl_or_b32 v22, v30, 16, v22                            // 00000000A028: D6560016 0459211E
	v_perm_b32 v30, v33, v32, 0xc0c0105                        // 00000000A030: D644001E 03FE4121 0C0C0105
	v_perm_b32 v20, v34, v20, 0xc0c0105                        // 00000000A03C: D6440014 03FE2922 0C0C0105
	v_sub_nc_i16 v31.l, v1.l, v38.l clamp                      // 00000000A048: D70E801F 00024D01
	v_sub_nc_i16 v23.l, v1.h, v23.l op_sel:[1,0,0] clamp       // 00000000A050: D70E8817 00022F01
	v_sub_nc_i16 v19.l, v19.l, v41.h op_sel:[0,1,0] clamp      // 00000000A058: D70E9013 00025313
	v_sub_nc_i16 v28.l, v19.h, v28.l op_sel:[1,0,0] clamp      // 00000000A060: D70E881C 00023913
	v_and_b16 v1.l, 0xff00, v21.l                              // 00000000A068: D7620001 00022AFF FFFFFF00
	v_lshlrev_b16 v1.h, 8, v21.l op_sel:[0,0,1]                // 00000000A074: D7384001 00022A88
	v_and_b16 v2.l, 0xff00, v21.h op_sel:[0,1,0]               // 00000000A07C: D7621002 00022AFF FFFFFF00
	v_lshlrev_b16 v2.h, 8, v21.h op_sel:[0,1,1]                // 00000000A088: D7385002 00022A88
	s_waitcnt lgkmcnt(1)                                       // 00000000A090: BF89FC17
	v_xor_b32_e32 v21, v57, v26                                // 00000000A094: 3A2A3539
	v_or_b32_e32 v18, v50, v18                                 // 00000000A098: 38242532
	v_lshlrev_b16 v29.l, 8, v29.l                              // 00000000A09C: D738001D 00023A88
	v_lshl_or_b32 v20, v20, 16, v30                            // 00000000A0A4: D6560014 04792114
	v_dot4_i32_iu8 v3, v22, v3, v27 neg_lo:[1,1,0]             // 00000000A0AC: CC164003 7C6E0716
	v_perm_b32 v22, v23, v31, 0xc0c0105                        // 00000000A0B4: D6440016 03FE3F17 0C0C0105
	v_perm_b32 v19, v28, v19, 0xc0c0105                        // 00000000A0C0: D6440013 03FE271C 0C0C0105
	v_sub_nc_i16 v23.l, v1.l, v40.l clamp                      // 00000000A0CC: D70E8017 00025101
	v_sub_nc_i16 v26.l, v1.h, v41.l op_sel:[1,0,0] clamp       // 00000000A0D4: D70E881A 00025301
	v_sub_nc_i16 v27.l, v2.l, v39.l clamp                      // 00000000A0DC: D70E801B 00024F02
	v_sub_nc_i16 v24.l, v2.h, v24.l op_sel:[1,0,0] clamp       // 00000000A0E4: D70E8818 00023102
	v_and_b16 v1.l, 0xff00, v21.l                              // 00000000A0EC: D7620001 00022AFF FFFFFF00
	v_lshlrev_b16 v1.h, 8, v21.l op_sel:[0,0,1]                // 00000000A0F8: D7384001 00022A88
	v_and_b16 v2.l, 0xff00, v21.h op_sel:[0,1,0]               // 00000000A100: D7621002 00022AFF FFFFFF00
	v_lshlrev_b16 v2.h, 8, v21.h op_sel:[0,1,1]                // 00000000A10C: D7385002 00022A88
	s_waitcnt lgkmcnt(0)                                       // 00000000A114: BF89FC07
	v_xor_b32_e32 v18, v58, v18                                // 00000000A118: 3A24253A
	v_lshlrev_b16 v25.l, 8, v25.l                              // 00000000A11C: D7380019 00023288
	s_waitcnt vmcnt(1)                                         // 00000000A124: BF8907F7
	v_dot4_i32_iu8 v3, v20, v4, v3 neg_lo:[1,1,0]              // 00000000A128: CC164003 7C0E0914
	v_lshl_or_b32 v4, v19, 16, v22                             // 00000000A130: D6560004 04592113
	v_perm_b32 v19, v26, v23, 0xc0c0105                        // 00000000A138: D6440013 03FE2F1A 0C0C0105
	v_perm_b32 v20, v24, v27, 0xc0c0105                        // 00000000A144: D6440014 03FE3718 0C0C0105
	v_sub_nc_i16 v21.l, v1.l, v43.l clamp                      // 00000000A150: D70E8015 00025701
	v_sub_nc_i16 v22.l, v1.h, v24.h op_sel:[1,1,0] clamp       // 00000000A158: D70E9816 00023101
	v_sub_nc_i16 v23.l, v2.l, v42.l clamp                      // 00000000A160: D70E8017 00025502
	v_sub_nc_i16 v24.l, v2.h, v29.l op_sel:[1,0,0] clamp       // 00000000A168: D70E8818 00023B02
	v_and_b16 v1.l, 0xff00, v18.l                              // 00000000A170: D7620001 000224FF FFFFFF00
	v_lshlrev_b16 v1.h, 8, v18.l op_sel:[0,0,1]                // 00000000A17C: D7384001 00022488
	v_and_b16 v2.l, 0xff00, v18.h op_sel:[0,1,0]               // 00000000A184: D7621002 000224FF FFFFFF00
	v_lshlrev_b16 v2.h, 8, v18.h op_sel:[0,1,1]                // 00000000A190: D7385002 00022488
	v_lshl_or_b32 v18, v20, 16, v19                            // 00000000A198: D6560012 044D2114
	v_dot4_i32_iu8 v3, v4, v5, v3 neg_lo:[1,1,0]               // 00000000A1A0: CC164003 7C0E0B04
	v_perm_b32 v4, v22, v21, 0xc0c0105                         // 00000000A1A8: D6440004 03FE2B16 0C0C0105
	v_sub_nc_i16 v1.l, v1.l, v44.l clamp                       // 00000000A1B4: D70E8001 00025901
	v_sub_nc_i16 v5.l, v1.h, v45.l op_sel:[1,0,0] clamp        // 00000000A1BC: D70E8805 00025B01
	v_sub_nc_i16 v2.l, v2.l, v43.h op_sel:[0,1,0] clamp        // 00000000A1C4: D70E9002 00025702
	v_sub_nc_i16 v19.l, v2.h, v25.l op_sel:[1,0,0] clamp       // 00000000A1CC: D70E8813 00023302
	v_perm_b32 v20, v24, v23, 0xc0c0105                        // 00000000A1D4: D6440014 03FE2F18 0C0C0105
	v_dot4_i32_iu8 v3, v18, v6, v3 neg_lo:[1,1,0]              // 00000000A1E0: CC164003 7C0E0D12
	v_perm_b32 v1, v5, v1, 0xc0c0105                           // 00000000A1E8: D6440001 03FE0305 0C0C0105
	v_lshrrev_b32_e32 v5, 28, v16                              // 00000000A1F4: 320A209C
	v_perm_b32 v2, v19, v2, 0xc0c0105                          // 00000000A1F8: D6440002 03FE0513 0C0C0105
	v_lshl_or_b32 v4, v20, 16, v4                              // 00000000A204: D6560004 04112114
	v_add_co_u32 v8, vcc_lo, 0x480, v8                         // 00000000A20C: D7006A08 000210FF 00000480
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000000A218: BF870211
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo                // 00000000A21C: D5207C09 01AA1280
	v_lshl_or_b32 v1, v2, 16, v1                               // 00000000A224: D6560001 04052102
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000A22C: BF870094
	v_dot4_i32_iu8 v2, v4, v7, v3 neg_lo:[1,1,0]               // 00000000A230: CC164002 7C0E0F04
	v_dot4_i32_iu8 v4, v1, v17, v2 neg_lo:[1,1,0]              // 00000000A238: CC164004 7C0A2301
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000A240: BF870091
	v_lshrrev_b32_e32 v1, 31, v4                               // 00000000A244: 3202089F
	v_add_nc_u32_e32 v1, v4, v1                                // 00000000A248: 4A020304
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000A24C: BF870091
	v_ashrrev_i32_e32 v1, 1, v1                                // 00000000A250: 34020281
	v_mad_u64_u32 v[2:3], null, v4, v5, v[1:2]                 // 00000000A254: D6FE7C02 04060B04
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000A25C: BF870091
	v_lshrrev_b32_e32 v1, 31, v2                               // 00000000A260: 3202049F
	v_add_nc_u32_e32 v1, v2, v1                                // 00000000A264: 4A020302
	s_waitcnt vmcnt(0)                                         // 00000000A268: BF8903F7
	v_cvt_f32_f16_e32 v2, v0.l                                 // 00000000A26C: 7E041700
	v_cvt_f32_f16_e32 v0, v0.h                                 // 00000000A270: 7E001780
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000000A274: BF870113
	v_ashrrev_i32_e32 v1, 1, v1                                // 00000000A278: 34020281
	v_mul_f32_e32 v0, v0, v2                                   // 00000000A27C: 10000500
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000A280: BF870092
	v_cvt_f32_i32_e32 v1, v1                                   // 00000000A284: 7E020B01
	v_fmac_f32_e32 v12, v0, v1                                 // 00000000A288: 56180300
	s_and_not1_b32 exec_lo, exec_lo, s1                        // 00000000A28C: 917E017E
	s_cbranch_execnz 64815                                     // 00000000A290: BFA6FD2F <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x250>
	s_or_b32 exec_lo, exec_lo, s1                              // 00000000A294: 8C7E017E
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 00000000A298: BF870499
	s_or_b32 exec_lo, exec_lo, s14                             // 00000000A29C: 8C7E0E7E
	s_mov_b32 s1, exec_lo                                      // 00000000A2A0: BE81007E
	v_cmp_eq_u32_e32 vcc_lo, 0, v11                            // 00000000A2A4: 7C941680
	v_cmpx_ne_u32_e32 0, v11                                   // 00000000A2A8: 7D9A1680
	v_lshlrev_b32_e32 v0, 2, v10                               // 00000000A2AC: 30001482
	s_delay_alu instid0(VALU_DEP_1)                            // 00000000A2B0: BF870001
	v_lshl_add_u32 v0, v11, 7, v0                              // 00000000A2B4: D6460000 04010F0B
	ds_store_b32 v0, v12 offset:896                            // 00000000A2BC: D8340380 00000C00
	s_or_b32 exec_lo, exec_lo, s1                              // 00000000A2C4: 8C7E017E
	s_waitcnt lgkmcnt(0)                                       // 00000000A2C8: BF89FC07
	buffer_gl0_inv                                             // 00000000A2CC: E0AC0000 00000000
	s_and_saveexec_b32 s0, vcc_lo                              // 00000000A2D4: BE80206A
	s_cbranch_execz 113                                        // 00000000A2D8: BFA50071 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xfa0>
	s_cmp_eq_u32 exec_lo, 0                                    // 00000000A2DC: BF06807E
	s_mov_b32 s0, 0                                            // 00000000A2E0: BE800080
	s_cselect_b32 s4, -1, 0                                    // 00000000A2E4: 980480C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000A2E8: BF870009
	s_and_b32 vcc_lo, exec_lo, s4                              // 00000000A2EC: 8B6A047E
	s_cbranch_vccnz 7                                          // 00000000A2F0: BFA40007 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xe10>
	s_cmp_eq_u32 exec_lo, -1                                   // 00000000A2F4: BF06C17E
	s_mov_b32 s1, -1                                           // 00000000A2F8: BE8100C1
	s_cselect_b32 s4, -1, 0                                    // 00000000A2FC: 980480C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000A300: BF870009
	s_and_not1_b32 vcc_lo, exec_lo, s4                         // 00000000A304: 916A047E
	s_cbranch_vccz 4                                           // 00000000A308: BFA30004 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xe1c>
	s_branch 69                                                // 00000000A30C: BFA00045 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xf24>
	s_mov_b32 s1, 0                                            // 00000000A310: BE810080
	s_and_not1_b32 vcc_lo, exec_lo, s4                         // 00000000A314: 916A047E
	s_cbranch_vccnz 65532                                      // 00000000A318: BFA4FFFC <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xe0c>
	v_mbcnt_lo_u32_b32 v0, -1, 0                               // 00000000A31C: D71F0000 000100C1
	s_cmp_eq_u32 exec_lo, 0                                    // 00000000A324: BF06807E
	s_mov_b32 s1, -1                                           // 00000000A328: BE8100C1
	s_cselect_b32 s4, -1, 0                                    // 00000000A32C: 980480C1
	s_cmp_lg_u32 exec_lo, 0                                    // 00000000A330: BF07807E
	v_xor_b32_e32 v1, 16, v0                                   // 00000000A334: 3A020090
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000A338: BF8700A1
	v_cmp_gt_i32_e32 vcc_lo, 32, v1                            // 00000000A33C: 7C8802A0
	v_cndmask_b32_e32 v1, v0, v1, vcc_lo                       // 00000000A340: 02020300
	v_lshlrev_b32_e32 v1, 2, v1                                // 00000000A344: 30020282
	ds_bpermute_b32 v2, v1, v12                                // 00000000A348: DACC0000 02000C01
	v_mov_b32_e32 v1, 32                                       // 00000000A350: 7E0202A0
	s_cbranch_scc0 6                                           // 00000000A354: BFA10006 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xe70>
	s_cmp_eq_u32 exec_lo, -1                                   // 00000000A358: BF06C17E
	s_cselect_b32 s4, -1, 0                                    // 00000000A35C: 980480C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000A360: BF870009
	s_and_not1_b32 vcc_lo, exec_lo, s4                         // 00000000A364: 916A047E
	s_cbranch_vccz 4                                           // 00000000A368: BFA30004 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xe7c>
	s_branch 45                                                // 00000000A36C: BFA0002D <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xf24>
	s_mov_b32 s1, 0                                            // 00000000A370: BE810080
	s_and_not1_b32 vcc_lo, exec_lo, s4                         // 00000000A374: 916A047E
	s_cbranch_vccnz 42                                         // 00000000A378: BFA4002A <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xf24>
	v_xor_b32_e32 v3, 8, v0                                    // 00000000A37C: 3A060088
	s_cmp_eq_u32 exec_lo, 0                                    // 00000000A380: BF06807E
	s_cselect_b32 s4, -1, 0                                    // 00000000A384: 980480C1
	s_cmp_lg_u32 exec_lo, 0                                    // 00000000A388: BF07807E
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000000A38C: BF8700B1
	v_cmp_gt_i32_e32 vcc_lo, 32, v3                            // 00000000A390: 7C8806A0
	v_cndmask_b32_e32 v3, v0, v3, vcc_lo                       // 00000000A394: 02060700
	s_waitcnt lgkmcnt(0)                                       // 00000000A398: BF89FC07
	v_dual_add_f32 v2, v12, v2 :: v_dual_lshlrev_b32 v3, 2, v3 // 00000000A39C: C922050C 02020682
	ds_bpermute_b32 v3, v3, v2                                 // 00000000A3A4: DACC0000 03000203
	s_cbranch_scc0 7                                           // 00000000A3AC: BFA10007 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xecc>
	s_cmp_eq_u32 exec_lo, -1                                   // 00000000A3B0: BF06C17E
	s_mov_b32 s1, -1                                           // 00000000A3B4: BE8100C1
	s_cselect_b32 s4, -1, 0                                    // 00000000A3B8: 980480C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000A3BC: BF870009
	s_and_not1_b32 vcc_lo, exec_lo, s4                         // 00000000A3C0: 916A047E
	s_cbranch_vccz 4                                           // 00000000A3C4: BFA30004 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xed8>
	s_branch 22                                                // 00000000A3C8: BFA00016 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xf24>
	s_mov_b32 s1, 0                                            // 00000000A3CC: BE810080
	s_and_not1_b32 vcc_lo, exec_lo, s4                         // 00000000A3D0: 916A047E
	s_cbranch_vccnz 19                                         // 00000000A3D4: BFA40013 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xf24>
	v_xor_b32_e32 v4, 4, v0                                    // 00000000A3D8: 3A080084
	s_cmp_eq_u32 exec_lo, 0                                    // 00000000A3DC: BF06807E
	s_cselect_b32 s4, -1, 0                                    // 00000000A3E0: 980480C1
	s_cmp_lg_u32 exec_lo, 0                                    // 00000000A3E4: BF07807E
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000000A3E8: BF8700B1
	v_cmp_gt_i32_e32 vcc_lo, 32, v4                            // 00000000A3EC: 7C8808A0
	v_cndmask_b32_e32 v4, v0, v4, vcc_lo                       // 00000000A3F0: 02080900
	s_waitcnt lgkmcnt(0)                                       // 00000000A3F4: BF89FC07
	v_dual_add_f32 v2, v2, v3 :: v_dual_lshlrev_b32 v3, 2, v4  // 00000000A3F8: C9220702 02020882
	ds_bpermute_b32 v3, v3, v2                                 // 00000000A400: DACC0000 03000203
	s_cbranch_scc0 38                                          // 00000000A408: BFA10026 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xfa4>
	s_cmp_eq_u32 exec_lo, -1                                   // 00000000A40C: BF06C17E
	s_mov_b32 s1, -1                                           // 00000000A410: BE8100C1
	s_cselect_b32 s4, -1, 0                                    // 00000000A414: 980480C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000A418: BF870009
	s_and_not1_b32 vcc_lo, exec_lo, s4                         // 00000000A41C: 916A047E
	s_cbranch_vccz 35                                          // 00000000A420: BFA30023 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xfb0>
	s_and_b32 vcc_lo, exec_lo, s1                              // 00000000A424: 8B6A017E
	s_cbranch_vccnz 49                                         // 00000000A428: BFA40031 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xff0>
	s_and_not1_b32 vcc_lo, exec_lo, s0                         // 00000000A42C: 916A007E
	s_cbranch_vccnz 27                                         // 00000000A430: BFA4001B <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xfa0>
	v_xor_b32_e32 v4, 1, v0                                    // 00000000A434: 3A080081
	s_mov_b32 s1, 0                                            // 00000000A438: BE810080
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_2)// 00000000A43C: BF870141
	v_cmp_lt_i32_e32 vcc_lo, v4, v1                            // 00000000A440: 7C820304
	s_waitcnt lgkmcnt(0)                                       // 00000000A444: BF89FC07
	v_dual_cndmask_b32 v1, v0, v4 :: v_dual_add_f32 v0, v3, v2 // 00000000A448: CA480900 01000503
	v_cmp_eq_u32_e32 vcc_lo, 0, v10                            // 00000000A450: 7C941480
	v_lshlrev_b32_e32 v1, 2, v1                                // 00000000A454: 30020282
	ds_bpermute_b32 v1, v1, v0                                 // 00000000A458: DACC0000 01000001
	s_and_b32 exec_lo, exec_lo, vcc_lo                         // 00000000A460: 8B7E6A7E
	s_cbranch_execz 14                                         // 00000000A464: BFA5000E <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xfa0>
	s_mul_i32 s0, s11, s3                                      // 00000000A468: 9600030B
	v_mov_b32_e32 v2, 0                                        // 00000000A46C: 7E040280
	s_lshl_b64 s[0:1], s[0:1], 2                               // 00000000A470: 84808200
	s_waitcnt lgkmcnt(0)                                       // 00000000A474: BF89FC07
	v_add_f32_e32 v0, v0, v1                                   // 00000000A478: 06000300
	s_add_u32 s4, s6, s0                                       // 00000000A47C: 80040006
	s_addc_u32 s5, s7, s1                                      // 00000000A480: 82050107
	s_ashr_i32 s3, s2, 31                                      // 00000000A484: 86039F02
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 00000000A488: BF870499
	s_lshl_b64 s[0:1], s[2:3], 2                               // 00000000A48C: 84808202
	s_add_u32 s0, s4, s0                                       // 00000000A490: 80000004
	s_addc_u32 s1, s5, s1                                      // 00000000A494: 82010105
	global_store_b32 v2, v0, s[0:1]                            // 00000000A498: DC6A0000 00000002
	s_endpgm                                                   // 00000000A4A0: BFB00000
	s_mov_b32 s1, 0                                            // 00000000A4A4: BE810080
	s_and_not1_b32 vcc_lo, exec_lo, s4                         // 00000000A4A8: 916A047E
	s_cbranch_vccnz 65501                                      // 00000000A4AC: BFA4FFDD <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xf24>
	v_xor_b32_e32 v4, 2, v0                                    // 00000000A4B0: 3A080082
	s_cmp_lg_u32 exec_lo, 0                                    // 00000000A4B4: BF07807E
	s_waitcnt lgkmcnt(0)                                       // 00000000A4B8: BF89FC07
	v_add_f32_e32 v3, v2, v3                                   // 00000000A4BC: 06060702
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000A4C0: BF8700A2
	v_cmp_gt_i32_e32 vcc_lo, 32, v4                            // 00000000A4C4: 7C8808A0
	v_cndmask_b32_e32 v4, v0, v4, vcc_lo                       // 00000000A4C8: 02080900
	v_lshlrev_b32_e32 v2, 2, v4                                // 00000000A4CC: 30040882
	ds_bpermute_b32 v2, v2, v3                                 // 00000000A4D0: DACC0000 02000302
	s_cbranch_scc0 22                                          // 00000000A4D8: BFA10016 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1034>
	s_cmp_eq_u32 exec_lo, -1                                   // 00000000A4DC: BF06C17E
	s_cselect_b32 s0, -1, 0                                    // 00000000A4E0: 980080C1
	s_cmp_lg_u32 exec_lo, -1                                   // 00000000A4E4: BF07C17E
	s_cselect_b32 s1, -1, 0                                    // 00000000A4E8: 980180C1
	s_branch 65485                                             // 00000000A4EC: BFA0FFCD <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xf24>
	s_cbranch_execnz 3                                         // 00000000A4F0: BFA60003 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x1000>
	s_and_not1_b32 vcc_lo, exec_lo, s0                         // 00000000A4F4: 916A007E
	s_cbranch_vccz 65486                                       // 00000000A4F8: BFA3FFCE <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xf34>
	s_branch 65512                                             // 00000000A4FC: BFA0FFE8 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xfa0>
	s_trap 2                                                   // 00000000A500: BF900002
	s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)        // 00000000A504: BE804C80
	s_mov_b32 ttmp2, m0                                        // 00000000A508: BEEE007D
	s_waitcnt lgkmcnt(0)                                       // 00000000A50C: BF89FC07
	s_and_b32 s0, s0, 0x3ff                                    // 00000000A510: 8B00FF00 000003FF
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 00000000A518: BF870499
	s_bitset1_b32 s0, 10                                       // 00000000A51C: BE80128A
	s_mov_b32 m0, s0                                           // 00000000A520: BEFD0000
	s_sendmsg sendmsg(MSG_INTERRUPT)                           // 00000000A524: BFB60001
	s_mov_b32 m0, ttmp2                                        // 00000000A528: BEFD006E
	s_sethalt 5                                                // 00000000A52C: BF820005
	s_branch 65534                                             // 00000000A530: BFA0FFFE <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0x102c>
	s_mov_b32 s1, 0                                            // 00000000A534: BE810080
	s_mov_b32 s0, -1                                           // 00000000A538: BE8000C1
	s_branch 65465                                             // 00000000A53C: BFA0FFB9 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj+0xf24>
		...

