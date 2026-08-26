_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
000000000000c500 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj>:
	s_load_b256 s[4:11], s[0:1], 0x10                          // 00000000C500: F40C0100 F8000010
	v_bfe_u32 v12, v0, 10, 10                                  // 00000000C508: D610000C 02291500
	v_dual_mov_b32 v11, 0 :: v_dual_and_b32 v10, 0x3ff, v0     // 00000000C510: CA240080 0B0A00FF 000003FF
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000C51C: BF870091
	v_lshl_or_b32 v0, v12, 5, v10                              // 00000000C520: D6560000 04290B0C
	v_lshrrev_b32_e32 v13, 3, v0                               // 00000000C528: 321A0083
	s_waitcnt lgkmcnt(0)                                       // 00000000C52C: BF89FC07
	s_lshr_b32 s14, s8, 8                                      // 00000000C530: 850E8808
	s_mov_b32 s8, exec_lo                                      // 00000000C534: BE88007E
	s_delay_alu instid0(VALU_DEP_1)                            // 00000000C538: BF870001
	v_cmpx_gt_u32_e64 s14, v13                                 // 00000000C53C: D4CC007E 00021A0E
	s_cbranch_execz 759                                        // 00000000C544: BFA502F7 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xc24>
	v_lshl_add_u32 v0, v12, 5, v10                             // 00000000C548: D6460000 04290B0C
	s_mul_i32 s10, s10, s3                                     // 00000000C550: 960A030A
	v_dual_mov_b32 v11, 0 :: v_dual_and_b32 v4, 7, v10         // 00000000C554: CA240080 0B041487
	s_mul_hi_u32 s13, s10, 36                                  // 00000000C55C: 968DA40A
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)// 00000000C560: BF870132
	v_lshrrev_b32_e32 v2, 3, v0                                // 00000000C564: 32040083
	s_mul_i32 s12, s10, 36                                     // 00000000C568: 960CA40A
	v_lshlrev_b32_e32 v5, 1, v10                               // 00000000C56C: 300A1481
	v_mad_u64_u32 v[0:1], null, 0x120, v2, s[12:13]            // 00000000C570: D6FE7C00 003204FF 00000120
	s_load_b64 s[12:13], s[0:1], null                          // 00000000C57C: F4040300 F8000000
	v_mad_u64_u32 v[2:3], null, v4, 36, v[0:1]                 // 00000000C584: D6FE7C02 04014904
	v_and_b32_e32 v0, 14, v5                                   // 00000000C58C: 36000A8E
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000000C590: BF870191
	v_lshlrev_b32_e32 v1, 1, v0                                // 00000000C594: 30020081
	v_add_co_u32 v2, vcc_lo, s4, v2                            // 00000000C598: D7006A02 00020404
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000000C5A0: BF870191
	v_add_co_ci_u32_e64 v3, null, s5, v3, vcc_lo               // 00000000C5A4: D5207C03 01AA0605
	v_lshlrev_b32_e32 v14, 1, v1                               // 00000000C5AC: 301C0281
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000C5B0: BF870093
	v_add_co_u32 v8, vcc_lo, v2, 32                            // 00000000C5B4: D7006A08 00014102
	v_add_co_ci_u32_e64 v9, null, 0, v3, vcc_lo                // 00000000C5BC: D5207C09 01AA0680
	v_lshlrev_b32_e32 v15, 1, v0                               // 00000000C5C4: 301E0081
	s_mul_i32 s5, s9, s2                                       // 00000000C5C8: 96050209
	s_mov_b32 s4, 0                                            // 00000000C5CC: BE840080
	v_add_nc_u32_e32 v18, s5, v13                              // 00000000C5D0: 4A241A05
	s_clause 0x2                                               // 00000000C5D4: BF850002
	global_load_b32 v16, v[8:9], off                           // 00000000C5D8: DC520000 107C0008
	global_load_b128 v[0:3], v[8:9], off offset:-32            // 00000000C5E0: DC5E1FE0 007C0008
	global_load_b128 v[4:7], v[8:9], off offset:-16            // 00000000C5E8: DC5E1FF0 047C0008
	s_getpc_b64 s[0:1]                                         // 00000000C5F0: BE804700
	s_add_u32 s0, s0, 0xffff9c8c                               // 00000000C5F4: 8000FF00 FFFF9C8C
	s_addc_u32 s1, s1, lit(0xffffffff)                         // 00000000C5FC: 8201FF01 FFFFFFFF
	v_mov_b16_e32 v17.l, 0                                     // 00000000C604: 7E223880
	v_add_nc_u32_e32 v13, 4, v13                               // 00000000C608: 4A1A1A84
	s_waitcnt lgkmcnt(0)                                       // 00000000C60C: BF89FC07
	v_mad_i64_i32 v[21:22], null, 0x42, v18, s[12:13]          // 00000000C610: D6FF7C15 003224FF 00000042
	s_delay_alu instid0(VALU_DEP_3)                            // 00000000C61C: BF870003
	v_mov_b16_e32 v18.h, v17.l                                 // 00000000C620: 7F243911
	v_mov_b16_e32 v19.h, v17.l                                 // 00000000C624: 7F263911
	v_mov_b16_e32 v20.h, v17.l                                 // 00000000C628: 7F283911
	v_mov_b16_e32 v45.h, v17.l                                 // 00000000C62C: 7F5A3911
	v_mov_b16_e32 v46.h, v17.l                                 // 00000000C630: 7F5C3911
	v_add_co_u32 v23, vcc_lo, v21, v14                         // 00000000C634: D7006A17 00021D15
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000C63C: BF8700A1
	v_add_co_ci_u32_e64 v24, null, 0, v22, vcc_lo              // 00000000C640: D5207C18 01AA2C80
	v_add_co_u32 v25, vcc_lo, v21, v15                         // 00000000C648: D7006A19 00021F15
	v_add_co_ci_u32_e64 v26, null, 0, v22, vcc_lo              // 00000000C650: D5207C1A 01AA2C80
	s_clause 0x2                                               // 00000000C658: BF850002
	global_load_b64 v[23:24], v[23:24], off                    // 00000000C65C: DC560000 177C0017
	global_load_b32 v50, v[25:26], off offset:64               // 00000000C664: DC520040 327C0019
	global_load_d16_hi_b16 v0, v[21:22], off offset:64         // 00000000C66C: DC8E0040 007C0015
	v_mov_b16_e32 v47.h, v17.l                                 // 00000000C674: 7F5E3911
	v_mov_b16_e32 v48.h, v17.l                                 // 00000000C678: 7F603911
	v_mov_b16_e32 v49.h, v17.l                                 // 00000000C67C: 7F623911
	s_waitcnt vmcnt(2)                                         // 00000000C680: BF890BF7
	v_and_b32_e32 v21, 0xff, v23                               // 00000000C684: 362A2EFF 000000FF
	v_lshrrev_b32_e32 v22, 6, v23                              // 00000000C68C: 322C2E86
	v_lshrrev_b32_e32 v26, 14, v23                             // 00000000C690: 32342E8E
	v_lshrrev_b32_e32 v23, 22, v23                             // 00000000C694: 322E2E96
	v_and_b32_e32 v28, 0xff, v24                               // 00000000C698: 363830FF 000000FF
	v_lshrrev_b32_e32 v29, 6, v24                              // 00000000C6A0: 323A3086
	v_lshrrev_b32_e32 v31, 14, v24                             // 00000000C6A4: 323E308E
	v_lshrrev_b32_e32 v24, 22, v24                             // 00000000C6A8: 32303096
	v_lshlrev_b32_e32 v21, 2, v21                              // 00000000C6AC: 302A2A82
	v_and_b32_e32 v22, 0x3fc, v22                              // 00000000C6B0: 362C2CFF 000003FC
	v_and_b32_e32 v26, 0x3fc, v26                              // 00000000C6B8: 363434FF 000003FC
	v_and_b32_e32 v23, 0x3fc, v23                              // 00000000C6C0: 362E2EFF 000003FC
	v_lshlrev_b32_e32 v28, 2, v28                              // 00000000C6C8: 30383882
	v_and_b32_e32 v29, 0x3fc, v29                              // 00000000C6CC: 363A3AFF 000003FC
	v_and_b32_e32 v31, 0x3fc, v31                              // 00000000C6D4: 363E3EFF 000003FC
	v_and_b32_e32 v24, 0x3fc, v24                              // 00000000C6DC: 363030FF 000003FC
	s_clause 0x7                                               // 00000000C6E4: BF850007
	global_load_b32 v51, v21, s[0:1]                           // 00000000C6E8: DC520000 33000015
	global_load_b32 v52, v22, s[0:1]                           // 00000000C6F0: DC520000 34000016
	global_load_b32 v53, v26, s[0:1]                           // 00000000C6F8: DC520000 3500001A
	global_load_b32 v54, v23, s[0:1]                           // 00000000C700: DC520000 36000017
	global_load_b32 v55, v28, s[0:1]                           // 00000000C708: DC520000 3700001C
	global_load_b32 v56, v29, s[0:1]                           // 00000000C710: DC520000 3800001D
	global_load_b32 v57, v31, s[0:1]                           // 00000000C718: DC520000 3900001F
	global_load_b32 v58, v24, s[0:1]                           // 00000000C720: DC520000 3A000018
	s_waitcnt vmcnt(9)                                         // 00000000C728: BF8927F7
	v_and_b32_e32 v25, 0xff, v50                               // 00000000C72C: 363264FF 000000FF
	v_bfe_u32 v27, v50, 7, 8                                   // 00000000C734: D610001B 02210F32
	v_bfe_u32 v30, v50, 14, 8                                  // 00000000C73C: D610001E 02211D32
	v_bfe_u32 v32, v50, 21, 8                                  // 00000000C744: D6100020 02212B32
	v_cmp_le_u32_e64 s0, s14, v13                              // 00000000C74C: D44B0000 00021A0E
	v_bcnt_u32_b32 v33, v25, 0                                 // 00000000C754: D71E0021 00010119
	v_bcnt_u32_b32 v34, v27, 0                                 // 00000000C75C: D71E0022 0001011B
	v_bcnt_u32_b32 v35, v30, 0                                 // 00000000C764: D71E0023 0001011E
	v_bcnt_u32_b32 v36, v32, 0                                 // 00000000C76C: D71E0024 00010120
	s_or_b32 s4, s0, s4                                        // 00000000C774: 8C040400
	v_and_b32_e32 v21, 1, v33                                  // 00000000C778: 362A4281
	v_and_b32_e32 v22, 1, v34                                  // 00000000C77C: 362C4481
	v_and_b32_e32 v23, 1, v35                                  // 00000000C780: 362E4681
	v_and_b32_e32 v24, 1, v36                                  // 00000000C784: 36304881
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000000C788: BF870214
	v_lshlrev_b32_e32 v21, 7, v21                              // 00000000C78C: 302A2A87
	v_lshlrev_b32_e32 v22, 7, v22                              // 00000000C790: 302C2C87
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000000C794: BF870214
	v_lshlrev_b32_e32 v23, 7, v23                              // 00000000C798: 302E2E87
	v_lshlrev_b32_e32 v24, 7, v24                              // 00000000C79C: 30303087
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000000C7A0: BF870214
	v_xor_b32_e32 v21, v21, v25                                // 00000000C7A4: 3A2A3315
	v_xor_b32_e32 v22, v22, v27                                // 00000000C7A8: 3A2C3716
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000000C7AC: BF870214
	v_xor_b32_e32 v23, v23, v30                                // 00000000C7B0: 3A2E3D17
	v_xor_b32_e32 v24, v24, v32                                // 00000000C7B4: 3A304118
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000000C7B8: BF870214
	v_mul_lo_u32 v21, 0x1010101, v21                           // 00000000C7BC: D72C0015 00022AFF 01010101
	v_mul_lo_u32 v22, 0x1010101, v22                           // 00000000C7C8: D72C0016 00022CFF 01010101
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)// 00000000C7D4: BF870214
	v_mul_lo_u32 v23, 0x1010101, v23                           // 00000000C7D8: D72C0017 00022EFF 01010101
	v_mul_lo_u32 v24, 0x1010101, v24                           // 00000000C7E4: D72C0018 000230FF 01010101
	s_delay_alu instid0(VALU_DEP_4)                            // 00000000C7F0: BF870004
	v_and_b32_e32 v25, 0x8040201, v21                          // 00000000C7F4: 36322AFF 08040201
	v_lshrrev_b32_e32 v26, 18, v21                             // 00000000C7FC: 32342A92
	v_bfe_i32 v27, v21, 0, 1                                   // 00000000C800: D611001B 02050115
	v_and_b32_e32 v28, 0x80402010, v21                         // 00000000C808: 36382AFF 80402010
	v_lshrrev_b32_e32 v21, 22, v21                             // 00000000C810: 322A2A96
	v_lshrrev_b32_e32 v43, 24, v25                             // 00000000C814: 32563298
	v_and_b32_e32 v29, 0x8040201, v22                          // 00000000C818: 363A2CFF 08040201
	v_lshrrev_b32_e32 v30, 18, v22                             // 00000000C820: 323C2C92
	v_bfe_i32 v31, v22, 0, 1                                   // 00000000C824: D611001F 02050116
	v_and_b32_e32 v32, 0x80402010, v22                         // 00000000C82C: 36402CFF 80402010
	v_lshrrev_b32_e32 v22, 22, v22                             // 00000000C834: 322C2C96
	v_and_b32_e32 v33, 0x8040201, v23                          // 00000000C838: 36422EFF 08040201
	v_lshrrev_b32_e32 v34, 18, v23                             // 00000000C840: 32442E92
	v_bfe_i32 v35, v23, 0, 1                                   // 00000000C844: D6110023 02050117
	v_and_b32_e32 v36, 0x80402010, v23                         // 00000000C84C: 36482EFF 80402010
	v_lshrrev_b32_e32 v37, 22, v23                             // 00000000C854: 324A2E96
	v_and_b32_e32 v38, 0x8040201, v24                          // 00000000C858: 364C30FF 08040201
	v_lshrrev_b32_e32 v39, 18, v24                             // 00000000C860: 324E3092
	v_bfe_i32 v40, v24, 0, 1                                   // 00000000C864: D6110028 02050118
	v_and_b32_e32 v41, 0x80402010, v24                         // 00000000C86C: 365230FF 80402010
	v_lshrrev_b32_e32 v42, 22, v24                             // 00000000C874: 32543096
	v_lshrrev_b16 v17.h, 8, v25.l op_sel:[0,0,1]               // 00000000C878: D7394011 00023288
	v_cmp_ne_u16_e32 vcc_lo, 0, v43.l                          // 00000000C880: 7C7A5680
	v_mov_b16_e32 v18.l, v27.l                                 // 00000000C884: 7E24391B
	v_lshrrev_b32_e32 v27, 24, v28                             // 00000000C888: 32363898
	v_bfe_i32 v44, v21, 0, 1                                   // 00000000C88C: D611002C 02050115
	v_lshrrev_b32_e32 v59, 24, v29                             // 00000000C894: 32763A98
	v_lshrrev_b16 v20.l, 8, v29.l                              // 00000000C898: D7390014 00023A88
	v_bfe_i32 v29, v30, 0, 1                                   // 00000000C8A0: D611001D 0205011E
	v_mov_b16_e32 v21.l, v31.l                                 // 00000000C8A8: 7E2A391F
	v_lshrrev_b32_e32 v30, 24, v32                             // 00000000C8AC: 323C4098
	v_lshrrev_b16 v21.h, 8, v32.l op_sel:[0,0,1]               // 00000000C8B0: D7394015 00024088
	v_lshrrev_b16 v31.l, 4, v32.l                              // 00000000C8B8: D739001F 00024084
	v_bfe_i32 v32, v22, 0, 1                                   // 00000000C8C0: D6110020 02050116
	v_lshrrev_b32_e32 v60, 24, v33                             // 00000000C8C8: 32784298
	v_lshrrev_b16 v22.l, 8, v33.l                              // 00000000C8CC: D7390016 00024288
	v_bfe_i32 v33, v34, 0, 1                                   // 00000000C8D4: D6110021 02050122
	v_mov_b16_e32 v23.l, v35.l                                 // 00000000C8DC: 7E2E3923
	v_lshrrev_b32_e32 v34, 24, v36                             // 00000000C8E0: 32444898
	v_lshrrev_b16 v22.h, 8, v36.l op_sel:[0,0,1]               // 00000000C8E4: D7394016 00024888
	v_lshrrev_b16 v35.l, 4, v36.l                              // 00000000C8EC: D7390023 00024884
	v_bfe_i32 v36, v37, 0, 1                                   // 00000000C8F4: D6110024 02050125
	v_lshrrev_b32_e32 v37, 24, v38                             // 00000000C8FC: 324A4C98
	v_lshrrev_b16 v23.h, 8, v38.l op_sel:[0,0,1]               // 00000000C900: D7394017 00024C88
	v_bfe_i32 v38, v39, 0, 1                                   // 00000000C908: D6110026 02050127
	v_mov_b16_e32 v24.l, v40.l                                 // 00000000C910: 7E303928
	v_lshrrev_b32_e32 v39, 24, v41                             // 00000000C914: 324E5298
	v_lshrrev_b16 v24.h, 8, v41.l op_sel:[0,0,1]               // 00000000C918: D7394018 00025288
	v_lshrrev_b16 v40.l, 4, v41.l                              // 00000000C920: D7390028 00025284
	v_bfe_i32 v41, v42, 0, 1                                   // 00000000C928: D6110029 0205012A
	v_cndmask_b32_e64 v42, 0, -1, vcc_lo                       // 00000000C930: D501002A 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v17.h                          // 00000000C938: 7C7B2280
	v_lshrrev_b16 v19.l, 8, v28.l                              // 00000000C93C: D7390013 00023888
	v_bfe_i32 v25, v26, 0, 1                                   // 00000000C944: D6110019 0205011A
	v_and_b16 v25.h, 0xff, v18.l op_sel:[0,0,1]                // 00000000C94C: D7624019 000224FF 000000FF
	v_lshlrev_b16 v26.l, 8, v18.l                              // 00000000C958: D738001A 00022488
	v_cndmask_b32_e64 v43, 0, -1, vcc_lo                       // 00000000C960: D501002B 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v27.l                          // 00000000C968: 7C7A3680
	v_mov_b16_e32 v18.l, v44.l                                 // 00000000C96C: 7E24392C
	v_lshrrev_b16 v28.l, 4, v28.l                              // 00000000C970: D739001C 00023884
	v_bfe_i32 v66, v31, 0, 1                                   // 00000000C978: D6110042 0205011F
	v_mov_b16_e32 v27.l, v33.l                                 // 00000000C980: 7E363921
	v_cndmask_b32_e64 v44, 0, -1, vcc_lo                       // 00000000C984: D501002C 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v19.l                          // 00000000C98C: 7C7A2680
	v_bfe_i32 v62, v28, 0, 1                                   // 00000000C990: D611003E 0205011C
	v_mov_b16_e32 v19.l, v29.l                                 // 00000000C998: 7E26391D
	v_mov_b16_e32 v29.l, v42.l                                 // 00000000C99C: 7E3A392A
	v_and_b16 v17.h, 0xff, v25.l op_sel:[0,0,1]                // 00000000C9A0: D7624011 000232FF 000000FF
	v_cndmask_b32_e64 v61, 0, -1, vcc_lo                       // 00000000C9AC: D501003D 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v59.l                          // 00000000C9B4: 7C7A7680
	v_mov_b16_e32 v31.l, v44.l                                 // 00000000C9B8: 7E3E392C
	v_mov_b16_e32 v33.l, v62.l                                 // 00000000C9BC: 7E42393E
	v_lshlrev_b16 v27.h, 8, v18.l op_sel:[0,0,1]               // 00000000C9C0: D738401B 00022488
	v_lshlrev_b16 v29.l, 8, v29.l                              // 00000000C9C8: D738001D 00023A88
	v_cndmask_b32_e64 v59, 0, -1, vcc_lo                       // 00000000C9D0: D501003B 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v20.l                          // 00000000C9D8: 7C7A2880
	v_mov_b16_e32 v20.l, v32.l                                 // 00000000C9DC: 7E283920
	v_mov_b16_e32 v32.l, v61.l                                 // 00000000C9E0: 7E40393D
	v_and_b16 v28.h, 0xff, v19.l op_sel:[0,0,1]                // 00000000C9E4: D762401C 000226FF 000000FF
	v_lshlrev_b16 v29.h, 8, v19.l op_sel:[0,0,1]               // 00000000C9F0: D738401D 00022688
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo                       // 00000000C9F8: D501003F 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v30.l                          // 00000000CA00: 7C7A3C80
	v_mov_b16_e32 v30.l, v43.l                                 // 00000000CA04: 7E3C392B
	v_lshlrev_b16 v31.l, 8, v31.l                              // 00000000CA08: D738001F 00023E88
	v_lshlrev_b16 v32.l, 8, v32.l                              // 00000000CA10: D7380020 00024088
	v_and_b16 v36.h, 0xff, v33.l op_sel:[0,0,1]                // 00000000CA18: D7624024 000242FF 000000FF
	v_cndmask_b32_e64 v64, 0, -1, vcc_lo                       // 00000000CA24: D5010040 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.h                          // 00000000CA2C: 7C7B2A80
	v_lshlrev_b16 v30.l, 8, v30.l                              // 00000000CA30: D738001E 00023C88
	v_or_b16 v17.h, v17.h, v29.l op_sel:[1,0,1]                // 00000000CA38: D7634811 00023B11
	v_and_b16 v26.h, 0xff, v21.l op_sel:[0,0,1]                // 00000000CA40: D762401A 00022AFF 000000FF
	v_mov_b16_e32 v19.l, v64.l                                 // 00000000CA4C: 7E263940
	v_cndmask_b32_e64 v65, 0, -1, vcc_lo                       // 00000000CA50: D5010041 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v60.l                          // 00000000CA58: 7C7A7880
	v_and_b16 v21.h, 0xff, v23.l op_sel:[0,0,1]                // 00000000CA5C: D7624015 00022EFF 000000FF
	v_bfe_i32 v70, v35, 0, 1                                   // 00000000CA68: D6110046 02050123
	v_bfe_i32 v75, v40, 0, 1                                   // 00000000CA70: D611004B 02050128
	v_and_b16 v30.h, 0xff, v20.l op_sel:[0,0,1]                // 00000000CA78: D762401E 000228FF 000000FF
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo                       // 00000000CA84: D501003C 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v22.l                          // 00000000CA8C: 7C7A2C80
	v_lshlrev_b16 v22.l, 8, v23.l                              // 00000000CA90: D7380016 00022E88
	v_mov_b16_e32 v23.l, v36.l                                 // 00000000CA98: 7E2E3924
	v_mov_b16_e32 v35.l, v65.l                                 // 00000000CA9C: 7E463941
	v_mov_b16_e32 v36.l, v66.l                                 // 00000000CAA0: 7E483942
	v_cndmask_b32_e64 v67, 0, -1, vcc_lo                       // 00000000CAA4: D5010043 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v34.l                          // 00000000CAAC: 7C7A4480
	v_mov_b16_e32 v34.l, v63.l                                 // 00000000CAB0: 7E44393F
	v_lshlrev_b16 v31.h, 8, v20.l op_sel:[0,0,1]               // 00000000CAB4: D738401F 00022888
	v_mov_b16_e32 v20.l, v60.l                                 // 00000000CABC: 7E28393C
	v_lshlrev_b16 v38.h, 8, v19.l op_sel:[0,0,1]               // 00000000CAC0: D7384026 00022688
	v_cndmask_b32_e64 v68, 0, -1, vcc_lo                       // 00000000CAC8: D5010044 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v22.h                          // 00000000CAD0: 7C7B2C80
	v_lshlrev_b16 v34.l, 8, v34.l                              // 00000000CAD4: D7380022 00024488
	v_or_b16 v19.l, v36.h, v32.l op_sel:[1,0,0]                // 00000000CADC: D7630813 00024124
	v_mov_b16_e32 v45.l, v75.l                                 // 00000000CAE4: 7E5A394B
	v_lshlrev_b16 v35.l, 8, v35.l                              // 00000000CAE8: D7380023 00024688
	v_cndmask_b32_e64 v69, 0, -1, vcc_lo                       // 00000000CAF0: D5010045 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v37.l                          // 00000000CAF8: 7C7A4A80
	v_mov_b16_e32 v37.l, v67.l                                 // 00000000CAFC: 7E4A3943
	v_and_b16 v39.h, 0xff, v36.l op_sel:[0,0,1]                // 00000000CB00: D7624027 000248FF 000000FF
	v_lshlrev_b16 v40.h, 8, v20.l op_sel:[0,0,1]               // 00000000CB0C: D7384028 00022888
	v_or_b16 v20.l, v26.h, v34.l op_sel:[1,0,0]                // 00000000CB14: D7630814 0002451A
	v_cndmask_b32_e64 v71, 0, -1, vcc_lo                       // 00000000CB1C: D5010047 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v23.h                          // 00000000CB24: 7C7B2E80
	v_mov_b16_e32 v28.l, v38.l                                 // 00000000CB28: 7E383926
	v_and_b16 v32.h, 0xff, v27.l op_sel:[0,0,1]                // 00000000CB2C: D7624020 000236FF 000000FF
	v_mov_b16_e32 v38.l, v68.l                                 // 00000000CB38: 7E4C3944
	v_mov_b16_e32 v40.l, v70.l                                 // 00000000CB3C: 7E503946
	v_cndmask_b32_e64 v72, 0, -1, vcc_lo                       // 00000000CB40: D5010048 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v39.l                          // 00000000CB48: 7C7A4E80
	v_mov_b16_e32 v39.l, v69.l                                 // 00000000CB4C: 7E4E3945
	v_lshlrev_b16 v37.l, 8, v37.l                              // 00000000CB50: D7380025 00024A88
	v_and_b16 v43.h, 0xff, v45.l op_sel:[0,0,1]                // 00000000CB58: D762402B 00025AFF 000000FF
	v_and_b16 v22.h, 0xff, v24.l op_sel:[0,0,1]                // 00000000CB64: D7624016 000230FF 000000FF
	v_cndmask_b32_e64 v73, 0, -1, vcc_lo                       // 00000000CB70: D5010049 01A98280
	v_cmp_ne_u16_e32 vcc_lo, 0, v24.h                          // 00000000CB78: 7C7B3080
	v_lshlrev_b16 v24.h, 8, v25.l op_sel:[0,0,1]               // 00000000CB7C: D7384018 00023288
	v_and_b16 v25.l, 0xff, v18.l                               // 00000000CB84: D7620019 000224FF 000000FF
	v_mov_b16_e32 v18.l, v59.l                                 // 00000000CB90: 7E24393B
	v_mov_b16_e32 v43.l, v73.l                                 // 00000000CB94: 7E563949
	v_cndmask_b32_e64 v74, 0, -1, vcc_lo                       // 00000000CB98: D501004A 01A98280
	v_lshlrev_b16 v23.h, 8, v24.l op_sel:[0,0,1]               // 00000000CBA0: D7384017 00023088
	v_mov_b16_e32 v24.l, v41.l                                 // 00000000CBA8: 7E303929
	v_lshlrev_b16 v37.h, 8, v18.l op_sel:[0,0,1]               // 00000000CBAC: D7384025 00022488
	v_or_b16 v18.l, v25.h, v30.l op_sel:[1,0,0]                // 00000000CBB4: D7630812 00023D19
	v_mov_b16_e32 v44.l, v74.l                                 // 00000000CBBC: 7E58394A
	v_lshlrev_b16 v42.h, 8, v43.l op_sel:[0,0,1]               // 00000000CBC0: D738402A 00025688
	v_and_b16 v33.h, 0xff, v23.l op_sel:[0,0,1]                // 00000000CBC8: D7624021 00022EFF 000000FF
	v_mov_b16_e32 v41.l, v71.l                                 // 00000000CBD4: 7E523947
	v_or_b32_e32 v18, v18, v17                                 // 00000000CBD8: 38242312
	v_or_b16 v17.h, v25.l, v31.l op_sel:[0,0,1]                // 00000000CBDC: D7634011 00023F19
	v_lshlrev_b16 v43.l, 8, v44.l                              // 00000000CBE4: D738002B 00025888
	v_lshlrev_b16 v44.l, 8, v45.l                              // 00000000CBEC: D738002C 00025A88
	v_or_b16 v45.l, v39.h, v35.l op_sel:[1,0,0]                // 00000000CBF4: D763082D 00024727
	v_mov_b16_e32 v42.l, v72.l                                 // 00000000CBFC: 7E543948
	v_or_b32_e32 v19, v19, v17                                 // 00000000CC00: 38262313
	v_or_b16 v17.h, v28.h, v37.h op_sel:[1,1,1]                // 00000000CC04: D7635811 00024B1C
	v_lshlrev_b16 v38.l, 8, v38.l                              // 00000000CC0C: D7380026 00024C88
	v_lshlrev_b16 v39.l, 8, v39.l                              // 00000000CC14: D7380027 00024E88
	v_and_b16 v41.h, 0xff, v40.l op_sel:[0,0,1]                // 00000000CC1C: D7624029 000250FF 000000FF
	v_or_b16 v46.l, v21.h, v37.l op_sel:[1,0,0]                // 00000000CC28: D763082E 00024B15
	v_or_b32_e32 v20, v20, v17                                 // 00000000CC30: 38282314
	v_or_b16 v17.h, v30.h, v38.h op_sel:[1,1,1]                // 00000000CC34: D7635811 00024D1E
	v_and_b16 v34.h, 0xff, v28.l op_sel:[0,0,1]                // 00000000CC3C: D7624022 000238FF 000000FF
	v_lshlrev_b16 v41.l, 8, v41.l                              // 00000000CC48: D7380029 00025288
	v_lshlrev_b16 v42.l, 8, v42.l                              // 00000000CC50: D738002A 00025488
	v_or_b16 v47.l, v41.h, v39.l op_sel:[1,0,0]                // 00000000CC58: D763082F 00024F29
	v_or_b32_e32 v25, v45, v17                                 // 00000000CC60: 3832232D
	v_or_b16 v17.h, v32.h, v40.h op_sel:[1,1,1]                // 00000000CC64: D7635811 00025120
	v_and_b16 v35.h, 0xff, v24.l op_sel:[0,0,1]                // 00000000CC6C: D7624023 000230FF 000000FF
	v_or_b16 v48.l, v22.h, v42.l op_sel:[1,0,0]                // 00000000CC78: D7630830 00025516
	v_or_b16 v49.l, v43.h, v43.l op_sel:[1,0,0]                // 00000000CC80: D7630831 0002572B
	v_lshlrev_b16 v33.l, 8, v33.l                              // 00000000CC88: D7380021 00024288
	v_or_b32_e32 v45, v46, v17                                 // 00000000CC90: 385A232E
	v_or_b16 v17.h, v33.h, v38.l op_sel:[1,0,1]                // 00000000CC94: D7634811 00024D21
	v_lshlrev_b16 v21.l, 8, v21.l                              // 00000000CC9C: D7380015 00022A88
	v_lshlrev_b16 v36.l, 8, v36.l                              // 00000000CCA4: D7380024 00024888
	v_lshlrev_b16 v27.l, 8, v27.l                              // 00000000CCAC: D738001B 00023688
	v_lshlrev_b16 v23.l, 8, v23.l                              // 00000000CCB4: D7380017 00022E88
	v_or_b32_e32 v46, v47, v17                                 // 00000000CCBC: 385C232F
	v_or_b16 v17.h, v34.h, v41.l op_sel:[1,0,1]                // 00000000CCC0: D7634811 00025322
	v_lshlrev_b16 v40.l, 8, v40.l                              // 00000000CCC8: D7380028 00025088
	v_lshlrev_b16 v28.l, 8, v28.l                              // 00000000CCD0: D738001C 00023888
	v_lshlrev_b16 v24.l, 8, v24.l                              // 00000000CCD8: D7380018 00023088
	v_add_co_u32 v8, vcc_lo, 0x480, v8                         // 00000000CCE0: D7006A08 000210FF 00000480
	v_or_b32_e32 v47, v48, v17                                 // 00000000CCEC: 385E2330
	v_or_b16 v17.h, v35.h, v42.h op_sel:[1,1,1]                // 00000000CCF0: D7635811 00025523
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo                // 00000000CCF8: D5207C09 01AA1280
	s_delay_alu instid0(VALU_DEP_2)                            // 00000000CD00: BF870002
	v_or_b32_e32 v17, v49, v17                                 // 00000000CD04: 38222331
	s_waitcnt vmcnt(7)                                         // 00000000CD08: BF891FF7
	v_xor_b32_e32 v18, v51, v18                                // 00000000CD0C: 3A242533
	s_waitcnt vmcnt(6)                                         // 00000000CD10: BF891BF7
	v_xor_b32_e32 v48, v52, v19                                // 00000000CD14: 3A602734
	s_waitcnt vmcnt(5)                                         // 00000000CD18: BF8917F7
	v_xor_b32_e32 v49, v53, v20                                // 00000000CD1C: 3A622935
	s_waitcnt vmcnt(4)                                         // 00000000CD20: BF8913F7
	v_xor_b32_e32 v51, v54, v25                                // 00000000CD24: 3A663336
	s_waitcnt vmcnt(3)                                         // 00000000CD28: BF890FF7
	v_xor_b32_e32 v45, v55, v45                                // 00000000CD2C: 3A5A5B37
	s_waitcnt vmcnt(2)                                         // 00000000CD30: BF890BF7
	v_xor_b32_e32 v46, v56, v46                                // 00000000CD34: 3A5C5D38
	v_and_b16 v19.l, 0xff00, v48.l                             // 00000000CD38: D7620013 000260FF FFFFFF00
	s_waitcnt vmcnt(0)                                         // 00000000CD44: BF8903F7
	v_xor_b32_e32 v52, v58, v17                                // 00000000CD48: 3A68233A
	v_and_b16 v17.l, 0xff00, v18.l                             // 00000000CD4C: D7620011 000224FF FFFFFF00
	v_lshlrev_b16 v17.h, 8, v18.l op_sel:[0,0,1]               // 00000000CD58: D7384011 00022488
	v_and_b16 v18.l, 0xff00, v18.h op_sel:[0,1,0]              // 00000000CD60: D7621012 000224FF FFFFFF00
	v_lshlrev_b16 v18.h, 8, v18.h op_sel:[0,1,1]               // 00000000CD6C: D7385012 00022488
	v_lshlrev_b16 v19.h, 8, v48.l op_sel:[0,0,1]               // 00000000CD74: D7384013 00026088
	v_and_b16 v20.l, 0xff00, v48.h op_sel:[0,1,0]              // 00000000CD7C: D7621014 000260FF FFFFFF00
	v_lshlrev_b16 v20.h, 8, v48.h op_sel:[0,1,1]               // 00000000CD88: D7385014 00026088
	v_and_b16 v26.h, 0xff00, v51.l op_sel:[0,0,1]              // 00000000CD90: D762401A 000266FF FFFFFF00
	v_sub_nc_i16 v17.l, v17.l, v30.l clamp                     // 00000000CD9C: D70E8011 00023D11
	v_sub_nc_i16 v26.l, v17.h, v26.l op_sel:[1,0,0] clamp      // 00000000CDA4: D70E881A 00023511
	v_sub_nc_i16 v18.l, v18.l, v29.l clamp                     // 00000000CDAC: D70E8012 00023B12
	v_sub_nc_i16 v29.l, v18.h, v24.h op_sel:[1,1,0] clamp      // 00000000CDB4: D70E981D 00023112
	v_and_b16 v21.h, 0xff00, v49.l op_sel:[0,0,1]              // 00000000CDBC: D7624015 000262FF FFFFFF00
	v_lshlrev_b16 v22.h, 8, v49.l op_sel:[0,0,1]               // 00000000CDC8: D7384016 00026288
	v_and_b16 v25.l, 0xff00, v49.h op_sel:[0,1,0]              // 00000000CDD0: D7621019 000262FF FFFFFF00
	v_lshlrev_b16 v25.h, 8, v49.h op_sel:[0,1,1]               // 00000000CDDC: D7385019 00026288
	v_and_b16 v30.h, 0xff00, v51.h op_sel:[0,1,1]              // 00000000CDE4: D762501E 000266FF FFFFFF00
	v_sub_nc_i16 v19.l, v19.l, v32.l clamp                     // 00000000CDF0: D70E8013 00024113
	v_sub_nc_i16 v30.l, v19.h, v33.l op_sel:[1,0,0] clamp      // 00000000CDF8: D70E881E 00024313
	v_sub_nc_i16 v20.l, v20.l, v31.l clamp                     // 00000000CE00: D70E8014 00023F14
	v_sub_nc_i16 v31.l, v20.h, v27.h op_sel:[1,1,0] clamp      // 00000000CE08: D70E981F 00023714
	v_perm_b32 v17, v26, v17, 0xc0c0105                        // 00000000CE10: D6440011 03FE231A 0C0C0105
	v_perm_b32 v18, v29, v18, 0xc0c0105                        // 00000000CE1C: D6440012 03FE251D 0C0C0105
	v_lshlrev_b16 v28.h, 8, v51.l op_sel:[0,0,1]               // 00000000CE28: D738401C 00026688
	v_lshlrev_b16 v32.h, 8, v51.h op_sel:[0,1,1]               // 00000000CE30: D7385020 00026688
	v_and_b16 v33.h, 0xff00, v45.l op_sel:[0,0,1]              // 00000000CE38: D7624021 00025AFF FFFFFF00
	v_sub_nc_i16 v32.l, v21.h, v34.l op_sel:[1,0,0] clamp      // 00000000CE44: D70E8820 00024515
	v_sub_nc_i16 v21.l, v22.h, v21.l op_sel:[1,0,0] clamp      // 00000000CE4C: D70E8815 00022B16
	v_sub_nc_i16 v25.l, v25.l, v37.h op_sel:[0,1,0] clamp      // 00000000CE54: D70E9019 00024B19
	v_sub_nc_i16 v33.l, v25.h, v29.h op_sel:[1,1,0] clamp      // 00000000CE5C: D70E9821 00023B19
	v_perm_b32 v19, v30, v19, 0xc0c0105                        // 00000000CE64: D6440013 03FE271E 0C0C0105
	v_perm_b32 v20, v31, v20, 0xc0c0105                        // 00000000CE70: D6440014 03FE291F 0C0C0105
	v_lshl_or_b32 v17, v18, 16, v17                            // 00000000CE7C: D6560011 04452112
	v_lshlrev_b16 v34.h, 8, v45.l op_sel:[0,0,1]               // 00000000CE84: D7384022 00025A88
	v_and_b16 v35.h, 0xff00, v45.h op_sel:[0,1,1]              // 00000000CE8C: D7625023 00025AFF FFFFFF00
	v_lshlrev_b16 v36.h, 8, v45.h op_sel:[0,1,1]               // 00000000CE98: D7385024 00025A88
	v_sub_nc_i16 v34.l, v26.h, v35.l op_sel:[1,0,0] clamp      // 00000000CEA0: D70E8822 0002471A
	v_sub_nc_i16 v35.l, v28.h, v36.l op_sel:[1,0,0] clamp      // 00000000CEA8: D70E8823 0002491C
	v_sub_nc_i16 v36.l, v30.h, v38.h op_sel:[1,1,0] clamp      // 00000000CEB0: D70E9824 00024D1E
	v_sub_nc_i16 v49.l, v32.h, v31.h op_sel:[1,1,0] clamp      // 00000000CEB8: D70E9831 00023F20
	v_perm_b32 v18, v21, v32, 0xc0c0105                        // 00000000CEC0: D6440012 03FE4115 0C0C0105
	v_perm_b32 v21, v33, v25, 0xc0c0105                        // 00000000CECC: D6440015 03FE3321 0C0C0105
	v_lshl_or_b32 v19, v20, 16, v19                            // 00000000CED8: D6560013 044D2114
	v_dot4_i32_iu8 v1, v17, v1, 0 neg_lo:[1,1,0]               // 00000000CEE0: CC164001 7A020311
	v_xor_b32_e32 v47, v57, v47                                // 00000000CEE8: 3A5E5F39
	v_and_b16 v39.h, 0xff00, v46.l op_sel:[0,0,1]              // 00000000CEEC: D7624027 00025CFF FFFFFF00
	v_lshlrev_b16 v41.h, 8, v46.l op_sel:[0,0,1]               // 00000000CEF8: D7384029 00025C88
	v_and_b16 v43.h, 0xff00, v46.h op_sel:[0,1,1]              // 00000000CF00: D762502B 00025CFF FFFFFF00
	v_lshlrev_b16 v44.h, 8, v46.h op_sel:[0,1,1]               // 00000000CF0C: D738502C 00025C88
	v_sub_nc_i16 v37.l, v33.h, v37.l op_sel:[1,0,0] clamp      // 00000000CF14: D70E8825 00024B21
	v_sub_nc_i16 v22.l, v34.h, v22.l op_sel:[1,0,0] clamp      // 00000000CF1C: D70E8816 00022D22
	v_sub_nc_i16 v51.l, v35.h, v40.h op_sel:[1,1,0] clamp      // 00000000CF24: D70E9833 00025123
	v_sub_nc_i16 v27.l, v36.h, v27.l op_sel:[1,0,0] clamp      // 00000000CF2C: D70E881B 00023724
	v_perm_b32 v17, v35, v34, 0xc0c0105                        // 00000000CF34: D6440011 03FE4523 0C0C0105
	v_perm_b32 v20, v49, v36, 0xc0c0105                        // 00000000CF40: D6440014 03FE4931 0C0C0105
	v_lshl_or_b32 v18, v21, 16, v18                            // 00000000CF4C: D6560012 04492115
	v_dot4_i32_iu8 v1, v19, v2, v1 neg_lo:[1,1,0]              // 00000000CF54: CC164001 7C060513
	v_and_b16 v45.l, 0xff00, v47.l                             // 00000000CF5C: D762002D 00025EFF FFFFFF00
	v_lshlrev_b16 v45.h, 8, v47.l op_sel:[0,0,1]               // 00000000CF68: D738402D 00025E88
	v_and_b16 v46.l, 0xff00, v47.h op_sel:[0,1,0]              // 00000000CF70: D762102E 00025EFF FFFFFF00
	v_lshlrev_b16 v46.h, 8, v47.h op_sel:[0,1,1]               // 00000000CF7C: D738502E 00025E88
	v_sub_nc_i16 v39.l, v39.h, v39.l op_sel:[1,0,0] clamp      // 00000000CF84: D70E8827 00024F27
	v_sub_nc_i16 v40.l, v41.h, v40.l op_sel:[1,0,0] clamp      // 00000000CF8C: D70E8828 00025129
	v_sub_nc_i16 v38.l, v43.h, v38.l op_sel:[1,0,0] clamp      // 00000000CF94: D70E8826 00024D2B
	v_sub_nc_i16 v23.l, v44.h, v23.l op_sel:[1,0,0] clamp      // 00000000CF9C: D70E8817 00022F2C
	v_perm_b32 v2, v22, v37, 0xc0c0105                         // 00000000CFA4: D6440002 03FE4B16 0C0C0105
	v_perm_b32 v19, v27, v51, 0xc0c0105                        // 00000000CFB0: D6440013 03FE671B 0C0C0105
	v_lshl_or_b32 v17, v20, 16, v17                            // 00000000CFBC: D6560011 04452114
	v_dot4_i32_iu8 v1, v18, v3, v1 neg_lo:[1,1,0]              // 00000000CFC4: CC164001 7C060712
	v_and_b16 v47.l, 0xff00, v52.l                             // 00000000CFCC: D762002F 000268FF FFFFFF00
	v_lshlrev_b16 v47.h, 8, v52.l op_sel:[0,0,1]               // 00000000CFD8: D738402F 00026888
	v_and_b16 v48.l, 0xff00, v52.h op_sel:[0,1,0]              // 00000000CFE0: D7621030 000268FF FFFFFF00
	v_lshlrev_b16 v48.h, 8, v52.h op_sel:[0,1,1]               // 00000000CFEC: D7385030 00026888
	v_sub_nc_i16 v42.l, v45.l, v42.l clamp                     // 00000000CFF4: D70E802A 0002552D
	v_sub_nc_i16 v45.l, v45.h, v23.h op_sel:[1,1,0] clamp      // 00000000CFFC: D70E982D 00022F2D
	v_sub_nc_i16 v41.l, v46.l, v41.l clamp                     // 00000000D004: D70E8029 0002532E
	v_sub_nc_i16 v28.l, v46.h, v28.l op_sel:[1,0,0] clamp      // 00000000D00C: D70E881C 0002392E
	v_perm_b32 v3, v40, v39, 0xc0c0105                         // 00000000D014: D6440003 03FE4F28 0C0C0105
	v_perm_b32 v18, v23, v38, 0xc0c0105                        // 00000000D020: D6440012 03FE4D17 0C0C0105
	v_lshl_or_b32 v2, v19, 16, v2                              // 00000000D02C: D6560002 04092113
	v_dot4_i32_iu8 v1, v17, v4, v1 neg_lo:[1,1,0]              // 00000000D034: CC164001 7C060911
	v_sub_nc_i16 v43.l, v47.l, v43.l clamp                     // 00000000D03C: D70E802B 0002572F
	v_sub_nc_i16 v44.l, v47.h, v44.l op_sel:[1,0,0] clamp      // 00000000D044: D70E882C 0002592F
	v_sub_nc_i16 v46.l, v48.l, v42.h op_sel:[0,1,0] clamp      // 00000000D04C: D70E902E 00025530
	v_sub_nc_i16 v24.l, v48.h, v24.l op_sel:[1,0,0] clamp      // 00000000D054: D70E8818 00023130
	v_perm_b32 v4, v45, v42, 0xc0c0105                         // 00000000D05C: D6440004 03FE552D 0C0C0105
	v_perm_b32 v17, v28, v41, 0xc0c0105                        // 00000000D068: D6440011 03FE531C 0C0C0105
	v_lshl_or_b32 v3, v18, 16, v3                              // 00000000D074: D6560003 040D2112
	v_dot4_i32_iu8 v1, v2, v5, v1 neg_lo:[1,1,0]               // 00000000D07C: CC164001 7C060B02
	v_perm_b32 v2, v44, v43, 0xc0c0105                         // 00000000D084: D6440002 03FE572C 0C0C0105
	v_perm_b32 v5, v24, v46, 0xc0c0105                         // 00000000D090: D6440005 03FE5D18 0C0C0105
	v_lshl_or_b32 v4, v17, 16, v4                              // 00000000D09C: D6560004 04112111
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)// 00000000D0A4: BF870194
	v_dot4_i32_iu8 v1, v3, v6, v1 neg_lo:[1,1,0]               // 00000000D0A8: CC164001 7C060D03
	v_lshl_or_b32 v2, v5, 16, v2                               // 00000000D0B0: D6560002 04092105
	v_lshrrev_b32_e32 v5, 28, v50                              // 00000000D0B8: 320A649C
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000D0BC: BF870093
	v_dot4_i32_iu8 v1, v4, v7, v1 neg_lo:[1,1,0]               // 00000000D0C0: CC164001 7C060F04
	v_dot4_i32_iu8 v4, v2, v16, v1 neg_lo:[1,1,0]              // 00000000D0C8: CC164004 7C062102
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000D0D0: BF870091
	v_lshrrev_b32_e32 v1, 31, v4                               // 00000000D0D4: 3202089F
	v_add_nc_u32_e32 v1, v4, v1                                // 00000000D0D8: 4A020304
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000D0DC: BF870091
	v_ashrrev_i32_e32 v1, 1, v1                                // 00000000D0E0: 34020281
	v_mad_u64_u32 v[2:3], null, v4, v5, v[1:2]                 // 00000000D0E4: D6FE7C02 04060B04
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000D0EC: BF870091
	v_lshrrev_b32_e32 v1, 31, v2                               // 00000000D0F0: 3202049F
	v_add_nc_u32_e32 v1, v2, v1                                // 00000000D0F4: 4A020302
	v_cvt_f32_f16_e32 v2, v0.l                                 // 00000000D0F8: 7E041700
	v_cvt_f32_f16_e32 v0, v0.h                                 // 00000000D0FC: 7E001780
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)// 00000000D100: BF870113
	v_ashrrev_i32_e32 v1, 1, v1                                // 00000000D104: 34020281
	v_mul_f32_e32 v0, v0, v2                                   // 00000000D108: 10000500
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)// 00000000D10C: BF870092
	v_cvt_f32_i32_e32 v1, v1                                   // 00000000D110: 7E020B01
	v_fmac_f32_e32 v11, v0, v1                                 // 00000000D114: 56160300
	s_and_not1_b32 exec_lo, exec_lo, s4                        // 00000000D118: 917E047E
	s_cbranch_execnz 64812                                     // 00000000D11C: BFA6FD2C <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xd0>
	s_or_b32 exec_lo, exec_lo, s4                              // 00000000D120: 8C7E047E
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 00000000D124: BF870499
	s_or_b32 exec_lo, exec_lo, s8                              // 00000000D128: 8C7E087E
	s_mov_b32 s1, exec_lo                                      // 00000000D12C: BE81007E
	v_cmp_eq_u32_e32 vcc_lo, 0, v12                            // 00000000D130: 7C941880
	v_cmpx_ne_u32_e32 0, v12                                   // 00000000D134: 7D9A1880
	s_cbranch_execz 8                                          // 00000000D138: BFA50008 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xc5c>
	v_lshlrev_b32_e32 v0, 7, v12                               // 00000000D13C: 30001887
	v_lshlrev_b32_e32 v1, 2, v10                               // 00000000D140: 30021482
	s_delay_alu instid0(VALU_DEP_1)                            // 00000000D144: BF870001
	v_add3_u32 v0, v0, v1, 0xffffff80                          // 00000000D148: D6550000 03FE0300 FFFFFF80
	ds_store_b32 v0, v11                                       // 00000000D154: D8340000 00000B00
	s_or_b32 exec_lo, exec_lo, s1                              // 00000000D15C: 8C7E017E
	s_waitcnt lgkmcnt(0)                                       // 00000000D160: BF89FC07
	buffer_gl0_inv                                             // 00000000D164: E0AC0000 00000000
	s_and_saveexec_b32 s0, vcc_lo                              // 00000000D16C: BE80206A
	s_cbranch_execz 113                                        // 00000000D170: BFA50071 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xe38>
	s_cmp_eq_u32 exec_lo, 0                                    // 00000000D174: BF06807E
	s_mov_b32 s0, 0                                            // 00000000D178: BE800080
	s_cselect_b32 s4, -1, 0                                    // 00000000D17C: 980480C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000D180: BF870009
	s_and_b32 vcc_lo, exec_lo, s4                              // 00000000D184: 8B6A047E
	s_cbranch_vccnz 7                                          // 00000000D188: BFA40007 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xca8>
	s_cmp_eq_u32 exec_lo, -1                                   // 00000000D18C: BF06C17E
	s_mov_b32 s1, -1                                           // 00000000D190: BE8100C1
	s_cselect_b32 s4, -1, 0                                    // 00000000D194: 980480C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000D198: BF870009
	s_and_not1_b32 vcc_lo, exec_lo, s4                         // 00000000D19C: 916A047E
	s_cbranch_vccz 4                                           // 00000000D1A0: BFA30004 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xcb4>
	s_branch 69                                                // 00000000D1A4: BFA00045 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xdbc>
	s_mov_b32 s1, 0                                            // 00000000D1A8: BE810080
	s_and_not1_b32 vcc_lo, exec_lo, s4                         // 00000000D1AC: 916A047E
	s_cbranch_vccnz 65532                                      // 00000000D1B0: BFA4FFFC <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xca4>
	v_mbcnt_lo_u32_b32 v0, -1, 0                               // 00000000D1B4: D71F0000 000100C1
	s_cmp_eq_u32 exec_lo, 0                                    // 00000000D1BC: BF06807E
	s_mov_b32 s1, -1                                           // 00000000D1C0: BE8100C1
	s_cselect_b32 s4, -1, 0                                    // 00000000D1C4: 980480C1
	s_cmp_lg_u32 exec_lo, 0                                    // 00000000D1C8: BF07807E
	v_xor_b32_e32 v1, 16, v0                                   // 00000000D1CC: 3A020090
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000D1D0: BF8700A1
	v_cmp_gt_i32_e32 vcc_lo, 32, v1                            // 00000000D1D4: 7C8802A0
	v_cndmask_b32_e32 v1, v0, v1, vcc_lo                       // 00000000D1D8: 02020300
	v_lshlrev_b32_e32 v1, 2, v1                                // 00000000D1DC: 30020282
	ds_bpermute_b32 v2, v1, v11                                // 00000000D1E0: DACC0000 02000B01
	v_mov_b32_e32 v1, 32                                       // 00000000D1E8: 7E0202A0
	s_cbranch_scc0 6                                           // 00000000D1EC: BFA10006 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xd08>
	s_cmp_eq_u32 exec_lo, -1                                   // 00000000D1F0: BF06C17E
	s_cselect_b32 s4, -1, 0                                    // 00000000D1F4: 980480C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000D1F8: BF870009
	s_and_not1_b32 vcc_lo, exec_lo, s4                         // 00000000D1FC: 916A047E
	s_cbranch_vccz 4                                           // 00000000D200: BFA30004 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xd14>
	s_branch 45                                                // 00000000D204: BFA0002D <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xdbc>
	s_mov_b32 s1, 0                                            // 00000000D208: BE810080
	s_and_not1_b32 vcc_lo, exec_lo, s4                         // 00000000D20C: 916A047E
	s_cbranch_vccnz 42                                         // 00000000D210: BFA4002A <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xdbc>
	v_xor_b32_e32 v3, 8, v0                                    // 00000000D214: 3A060088
	s_cmp_eq_u32 exec_lo, 0                                    // 00000000D218: BF06807E
	s_waitcnt lgkmcnt(0)                                       // 00000000D21C: BF89FC07
	v_add_f32_e32 v2, v11, v2                                  // 00000000D220: 0604050B
	s_cselect_b32 s4, -1, 0                                    // 00000000D224: 980480C1
	s_cmp_lg_u32 exec_lo, 0                                    // 00000000D228: BF07807E
	v_cmp_gt_i32_e32 vcc_lo, 32, v3                            // 00000000D22C: 7C8806A0
	v_cndmask_b32_e32 v3, v0, v3, vcc_lo                       // 00000000D230: 02060700
	s_delay_alu instid0(VALU_DEP_1)                            // 00000000D234: BF870001
	v_lshlrev_b32_e32 v3, 2, v3                                // 00000000D238: 30060682
	ds_bpermute_b32 v3, v3, v2                                 // 00000000D23C: DACC0000 03000203
	s_cbranch_scc0 7                                           // 00000000D244: BFA10007 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xd64>
	s_cmp_eq_u32 exec_lo, -1                                   // 00000000D248: BF06C17E
	s_mov_b32 s1, -1                                           // 00000000D24C: BE8100C1
	s_cselect_b32 s4, -1, 0                                    // 00000000D250: 980480C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000D254: BF870009
	s_and_not1_b32 vcc_lo, exec_lo, s4                         // 00000000D258: 916A047E
	s_cbranch_vccz 4                                           // 00000000D25C: BFA30004 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xd70>
	s_branch 22                                                // 00000000D260: BFA00016 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xdbc>
	s_mov_b32 s1, 0                                            // 00000000D264: BE810080
	s_and_not1_b32 vcc_lo, exec_lo, s4                         // 00000000D268: 916A047E
	s_cbranch_vccnz 19                                         // 00000000D26C: BFA40013 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xdbc>
	v_xor_b32_e32 v4, 4, v0                                    // 00000000D270: 3A080084
	s_cmp_eq_u32 exec_lo, 0                                    // 00000000D274: BF06807E
	s_cselect_b32 s4, -1, 0                                    // 00000000D278: 980480C1
	s_cmp_lg_u32 exec_lo, 0                                    // 00000000D27C: BF07807E
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)// 00000000D280: BF8700B1
	v_cmp_gt_i32_e32 vcc_lo, 32, v4                            // 00000000D284: 7C8808A0
	v_cndmask_b32_e32 v4, v0, v4, vcc_lo                       // 00000000D288: 02080900
	s_waitcnt lgkmcnt(0)                                       // 00000000D28C: BF89FC07
	v_dual_add_f32 v2, v2, v3 :: v_dual_lshlrev_b32 v3, 2, v4  // 00000000D290: C9220702 02020882
	ds_bpermute_b32 v3, v3, v2                                 // 00000000D298: DACC0000 03000203
	s_cbranch_scc0 38                                          // 00000000D2A0: BFA10026 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xe3c>
	s_cmp_eq_u32 exec_lo, -1                                   // 00000000D2A4: BF06C17E
	s_mov_b32 s1, -1                                           // 00000000D2A8: BE8100C1
	s_cselect_b32 s4, -1, 0                                    // 00000000D2AC: 980480C1
	s_delay_alu instid0(SALU_CYCLE_1)                          // 00000000D2B0: BF870009
	s_and_not1_b32 vcc_lo, exec_lo, s4                         // 00000000D2B4: 916A047E
	s_cbranch_vccz 35                                          // 00000000D2B8: BFA30023 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xe48>
	s_and_b32 vcc_lo, exec_lo, s1                              // 00000000D2BC: 8B6A017E
	s_cbranch_vccnz 49                                         // 00000000D2C0: BFA40031 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xe88>
	s_and_not1_b32 vcc_lo, exec_lo, s0                         // 00000000D2C4: 916A007E
	s_cbranch_vccnz 27                                         // 00000000D2C8: BFA4001B <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xe38>
	v_xor_b32_e32 v4, 1, v0                                    // 00000000D2CC: 3A080081
	s_mov_b32 s1, 0                                            // 00000000D2D0: BE810080
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_2)// 00000000D2D4: BF870141
	v_cmp_lt_i32_e32 vcc_lo, v4, v1                            // 00000000D2D8: 7C820304
	s_waitcnt lgkmcnt(0)                                       // 00000000D2DC: BF89FC07
	v_dual_cndmask_b32 v1, v0, v4 :: v_dual_add_f32 v0, v3, v2 // 00000000D2E0: CA480900 01000503
	v_cmp_eq_u32_e32 vcc_lo, 0, v10                            // 00000000D2E8: 7C941480
	v_lshlrev_b32_e32 v1, 2, v1                                // 00000000D2EC: 30020282
	ds_bpermute_b32 v1, v1, v0                                 // 00000000D2F0: DACC0000 01000001
	s_and_b32 exec_lo, exec_lo, vcc_lo                         // 00000000D2F8: 8B7E6A7E
	s_cbranch_execz 14                                         // 00000000D2FC: BFA5000E <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xe38>
	s_mul_i32 s0, s11, s3                                      // 00000000D300: 9600030B
	v_mov_b32_e32 v2, 0                                        // 00000000D304: 7E040280
	s_lshl_b64 s[0:1], s[0:1], 2                               // 00000000D308: 84808200
	s_waitcnt lgkmcnt(0)                                       // 00000000D30C: BF89FC07
	v_add_f32_e32 v0, v0, v1                                   // 00000000D310: 06000300
	s_add_u32 s4, s6, s0                                       // 00000000D314: 80040006
	s_addc_u32 s5, s7, s1                                      // 00000000D318: 82050107
	s_ashr_i32 s3, s2, 31                                      // 00000000D31C: 86039F02
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 00000000D320: BF870499
	s_lshl_b64 s[0:1], s[2:3], 2                               // 00000000D324: 84808202
	s_add_u32 s0, s4, s0                                       // 00000000D328: 80000004
	s_addc_u32 s1, s5, s1                                      // 00000000D32C: 82010105
	global_store_b32 v2, v0, s[0:1]                            // 00000000D330: DC6A0000 00000002
	s_endpgm                                                   // 00000000D338: BFB00000
	s_mov_b32 s1, 0                                            // 00000000D33C: BE810080
	s_and_not1_b32 vcc_lo, exec_lo, s4                         // 00000000D340: 916A047E
	s_cbranch_vccnz 65501                                      // 00000000D344: BFA4FFDD <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xdbc>
	v_xor_b32_e32 v4, 2, v0                                    // 00000000D348: 3A080082
	s_cmp_lg_u32 exec_lo, 0                                    // 00000000D34C: BF07807E
	s_waitcnt lgkmcnt(0)                                       // 00000000D350: BF89FC07
	v_add_f32_e32 v3, v2, v3                                   // 00000000D354: 06060702
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)// 00000000D358: BF8700A2
	v_cmp_gt_i32_e32 vcc_lo, 32, v4                            // 00000000D35C: 7C8808A0
	v_cndmask_b32_e32 v4, v0, v4, vcc_lo                       // 00000000D360: 02080900
	v_lshlrev_b32_e32 v2, 2, v4                                // 00000000D364: 30040882
	ds_bpermute_b32 v2, v2, v3                                 // 00000000D368: DACC0000 02000302
	s_cbranch_scc0 22                                          // 00000000D370: BFA10016 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xecc>
	s_cmp_eq_u32 exec_lo, -1                                   // 00000000D374: BF06C17E
	s_cselect_b32 s0, -1, 0                                    // 00000000D378: 980080C1
	s_cmp_lg_u32 exec_lo, -1                                   // 00000000D37C: BF07C17E
	s_cselect_b32 s1, -1, 0                                    // 00000000D380: 980180C1
	s_branch 65485                                             // 00000000D384: BFA0FFCD <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xdbc>
	s_cbranch_execnz 3                                         // 00000000D388: BFA60003 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xe98>
	s_and_not1_b32 vcc_lo, exec_lo, s0                         // 00000000D38C: 916A007E
	s_cbranch_vccz 65486                                       // 00000000D390: BFA3FFCE <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xdcc>
	s_branch 65512                                             // 00000000D394: BFA0FFE8 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xe38>
	s_trap 2                                                   // 00000000D398: BF900002
	s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)        // 00000000D39C: BE804C80
	s_mov_b32 ttmp2, m0                                        // 00000000D3A0: BEEE007D
	s_waitcnt lgkmcnt(0)                                       // 00000000D3A4: BF89FC07
	s_and_b32 s0, s0, 0x3ff                                    // 00000000D3A8: 8B00FF00 000003FF
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)// 00000000D3B0: BF870499
	s_bitset1_b32 s0, 10                                       // 00000000D3B4: BE80128A
	s_mov_b32 m0, s0                                           // 00000000D3B8: BEFD0000
	s_sendmsg sendmsg(MSG_INTERRUPT)                           // 00000000D3BC: BFB60001
	s_mov_b32 m0, ttmp2                                        // 00000000D3C0: BEFD006E
	s_sethalt 5                                                // 00000000D3C4: BF820005
	s_branch 65534                                             // 00000000D3C8: BFA0FFFE <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xec4>
	s_mov_b32 s1, 0                                            // 00000000D3CC: BE810080
	s_mov_b32 s0, -1                                           // 00000000D3D0: BE8000C1
	s_branch 65465                                             // 00000000D3D4: BFA0FFB9 <_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj+0xdbc>
		...

