
# __CLANG_OFFLOAD_BUNDLE____START__ hip-amdgcn-amd-amdhsa--gfx1101
	.amdgcn_target "amdgcn-amd-amdhsa--gfx1101"
	.amdhsa_code_object_version 6
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_clause 0x1
	s_load_b128 s[12:15], s[0:1], 0x20
	s_load_b256 s[4:11], s[0:1], 0x0
	v_bfe_u32 v17, v0, 10, 10
	v_dual_mov_b32 v15, 0 :: v_dual_and_b32 v14, 0x3ff, v0
	v_mov_b32_e32 v16, 0
	s_mov_b32 s1, exec_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v0, v17, 5, v14
	v_lshrrev_b32_e32 v18, 3, v0
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s12, s12, 8
	s_delay_alu instid0(VALU_DEP_1) | instid1(SALU_CYCLE_1)
	v_cmpx_gt_u32_e64 s12, v18
	s_cbranch_execz .LBB0_4
; %bb.1:
	v_lshl_add_u32 v0, v17, 5, v14
	s_mul_i32 s0, s14, s3
	v_and_b32_e32 v4, 7, v14
	s_mul_hi_u32 s17, s0, 36
	s_mul_i32 s16, s0, 36
	v_lshrrev_b32_e32 v2, 3, v0
	s_mul_i32 s14, s13, s2
	s_mov_b32 s13, 0
	v_dual_mov_b32 v15, 0 :: v_dual_mov_b32 v16, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mad_u64_u32 v[0:1], null, 0x120, v2, s[16:17]
	v_lshlrev_b32_e32 v2, 1, v14
	v_and_b32_e32 v5, 14, v2
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mad_u64_u32 v[2:3], null, v4, 36, v[0:1]
	v_lshlrev_b32_e32 v0, 1, v5
	v_lshlrev_b32_e32 v19, 1, v5
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v1, vcc_lo, s8, v2
	v_add_co_ci_u32_e64 v2, null, s9, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_lshlrev_b32_e32 v20, 1, v0
	v_add_co_u32 v8, vcc_lo, v1, 32
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v9, null, 0, v2, vcc_lo
.LBB0_2:                                ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v23, s14, v18
	s_getpc_b64 s[8:9]
	s_add_u32 s8, s8, _ZL11iq3xxs_grid@rel32@lo+4
	s_addc_u32 s9, s9, _ZL11iq3xxs_grid@rel32@hi+12
	v_mov_b16_e32 v21.l, 0
	v_add_nc_u32_e32 v18, 4, v18
	v_mad_i64_i32 v[10:11], null, 0x42, v23, s[4:5]
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mov_b16_e32 v32.h, v21.l
	v_add_co_u32 v0, vcc_lo, v10, v20
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v1, null, 0, v11, vcc_lo
	global_load_b64 v[12:13], v[0:1], off
	v_add_co_u32 v0, vcc_lo, v10, v19
	v_add_co_ci_u32_e64 v1, null, 0, v11, vcc_lo
	global_load_b32 v24, v[0:1], off offset:64
	s_waitcnt vmcnt(1)
	v_and_b32_e32 v0, 0xff, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v0, 2, v0
	global_load_b32 v4, v0, s[8:9]
	v_lshrrev_b32_e32 v0, 6, v12
	v_and_b32_e32 v0, 0x3fc, v0
	global_load_b32 v27, v0, s[8:9]
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v0, 0xff, v24
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_bcnt_u32_b32 v1, v0, 0
	v_and_b32_e32 v1, 1, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v1, 7, v1
	v_xor_b32_e32 v0, v1, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v25, 0x1010101, v0
	v_and_b32_e32 v0, 0x8040201, v25
	v_bfe_i32 v2, v25, 0, 1
	v_and_b32_e32 v26, 0x80402010, v25
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_lshrrev_b32_e32 v1, 24, v0
	v_lshrrev_b16 v0.l, 8, v0.l
	v_lshrrev_b32_e32 v29, 24, v26
	v_lshrrev_b16 v30.l, 4, v26.l
	v_mov_b16_e32 v29.h, v21.l
	v_cmp_ne_u16_e64 s0, 0, v1.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v0.l
	v_lshrrev_b32_e32 v0, 18, v25
	v_lshrrev_b32_e32 v25, 22, v25
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_4)
	v_cndmask_b32_e64 v1, 0, -1, s0
	v_cndmask_b32_e64 v3, 0, -1, vcc_lo
	v_bfe_i32 v0, v0, 0, 1
	v_mov_b16_e32 v3.h, v21.l
	v_cmp_ne_u16_e64 s0, 0, v29.l
	v_lshlrev_b16 v1.l, 8, v1.l
	v_lshlrev_b16 v1.h, 8, v3.l
	v_and_b16 v0.h, 0xff, v0.l
	v_lshlrev_b16 v0.l, 8, v0.l
	v_bfe_i32 v25, v25, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b16 v21.h, v0.h, v1.l
	v_and_b16 v0.h, 0xff, v2.l
	v_or_b16 v3.l, v0.h, v1.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v3, v3, v21
	s_waitcnt vmcnt(1)
	v_xor_b32_e32 v3, v4, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v0.h, 0xff00, v3.l
	v_sub_nc_i16 v4.l, v0.h, v1.h clamp
	v_lshlrev_b16 v0.h, 8, v3.l
	v_lshlrev_b16 v1.h, 8, v2.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v2.l, v0.h, v1.h clamp
	v_and_b16 v0.h, 0xff00, v3.h
	v_perm_b32 v2, v2, v4, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v1.l, v0.h, v1.l clamp
	v_lshlrev_b16 v0.h, 8, v3.h
	v_sub_nc_i16 v0.l, v0.h, v0.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v0, v0, v1, 0xc0c0105
	v_lshl_or_b32 v28, v0, 16, v2
	s_clause 0x2
	global_load_b128 v[4:7], v[8:9], off offset:-32
	global_load_b32 v22, v[8:9], off
	global_load_b128 v[0:3], v[8:9], off offset:-16
	s_waitcnt vmcnt(2)
	v_lshrrev_b16 v4.h, 8, v26.l
	v_cndmask_b32_e64 v26, 0, -1, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	v_and_b16 v4.h, 0xff, v25.l
	v_lshlrev_b16 v25.h, 8, v26.l
	v_cndmask_b32_e64 v26, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_or_b16 v21.h, v4.h, v25.h
	v_lshlrev_b16 v4.h, 8, v26.l
	v_bfe_i32 v26, v30, 0, 1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v26.h, 0xff, v26.l
	v_or_b16 v29.l, v26.h, v4.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v29, v29, v21
	v_xor_b32_e32 v27, v27, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v21.h, 0xff00, v27.l
	v_sub_nc_i16 v29.l, v21.h, v4.h clamp
	v_lshlrev_b16 v4.h, 8, v27.l
	v_lshlrev_b16 v21.h, 8, v26.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_sub_nc_i16 v26.l, v4.h, v21.h clamp
	v_and_b16 v4.h, 0xff00, v27.h
	v_lshlrev_b16 v21.h, 8, v25.l
	v_perm_b32 v26, v26, v29, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v27.l, v4.h, v25.h clamp
	v_lshlrev_b16 v4.h, 8, v27.h
	v_sub_nc_i16 v25.l, v4.h, v21.h clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v25, v25, v27, 0xc0c0105
	v_lshl_or_b32 v25, v25, 16, v26
	v_dot4_i32_iu8 v26, v28, v5, 0 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_dot4_i32_iu8 v27, v25, v6, v26 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v25, 14, v12
	v_lshrrev_b32_e32 v12, 22, v12
	v_and_b32_e32 v25, 0x3fc, v25
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_4) | instid1(VALU_DEP_1)
	v_and_b32_e32 v12, 0x3fc, v12
	s_clause 0x1
	global_load_b32 v28, v25, s[8:9]
	global_load_b32 v29, v12, s[8:9]
	v_bfe_u32 v12, v24, 7, 8
	v_bcnt_u32_b32 v25, v12, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v25, 1, v25
	v_lshlrev_b32_e32 v25, 7, v25
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v12, v25, v12
	v_mul_lo_u32 v30, 0x1010101, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v12, 0x8040201, v30
	v_lshrrev_b32_e32 v25, 24, v12
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b32_e32 v12, 18, v30
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e64 s0, 0, v25.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_bfe_i32 v12, v12, 0, 1
	v_cndmask_b32_e64 v25, 0, -1, s0
	v_cndmask_b32_e64 v26, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_3)
	v_and_b16 v4.h, 0xff, v12.l
	v_mov_b16_e32 v26.h, v21.l
	v_lshlrev_b16 v12.l, 8, v12.l
	v_lshlrev_b16 v12.h, 8, v25.l
	v_bfe_i32 v25, v30, 0, 1
	v_lshlrev_b16 v25.h, 8, v26.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_or_b16 v21.h, v4.h, v12.h
	v_and_b16 v4.h, 0xff, v25.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v26.l, v4.h, v25.h
	v_or_b32_e32 v26, v26, v21
	v_lshlrev_b16 v21.h, 8, v25.l
	s_waitcnt vmcnt(1)
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v26, v28, v26
	v_and_b16 v4.h, 0xff00, v26.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v28.l, v4.h, v25.h clamp
	v_lshlrev_b16 v4.h, 8, v26.l
	v_sub_nc_i16 v25.l, v4.h, v21.h clamp
	v_and_b16 v4.h, 0xff00, v26.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v25, v25, v28, 0xc0c0105
	v_sub_nc_i16 v26.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v26.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	v_perm_b32 v12, v12, v26, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v26, v12, 16, v25
	v_and_b32_e32 v12, 0x80402010, v30
	v_lshrrev_b32_e32 v25, 24, v12
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b16 v28.l, 4, v12.l
	v_lshrrev_b32_e32 v12, 22, v30
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_cmp_ne_u16_e64 s0, 0, v25.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_bfe_i32 v12, v12, 0, 1
	v_cndmask_b32_e64 v25, 0, -1, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_and_b16 v4.h, 0xff, v12.l
	v_lshlrev_b16 v12.l, 8, v12.l
	v_lshlrev_b16 v12.h, 8, v25.l
	v_cndmask_b32_e64 v25, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_or_b16 v21.h, v4.h, v12.h
	v_lshlrev_b16 v4.h, 8, v25.l
	v_bfe_i32 v25, v28, 0, 1
	v_mov_b16_e32 v28.h, v21.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v25.h, 0xff, v25.l
	v_or_b16 v28.l, v25.h, v4.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v28, v28, v21
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v28, v29, v28
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v21.h, 0xff00, v28.l
	v_sub_nc_i16 v29.l, v21.h, v4.h clamp
	v_lshlrev_b16 v4.h, 8, v28.l
	v_lshlrev_b16 v21.h, 8, v25.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v25.l, v4.h, v21.h clamp
	v_and_b16 v4.h, 0xff00, v28.h
	v_perm_b32 v25, v25, v29, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v28.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v28.h
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v12, v12, v28, 0xc0c0105
	v_lshl_or_b32 v12, v12, 16, v25
	v_dot4_i32_iu8 v25, v26, v7, v27 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v27, v12, v0, v25 neg_lo:[1,1,0]
	v_and_b32_e32 v12, 0xff, v13
	v_lshlrev_b32_e32 v12, 2, v12
	global_load_b32 v28, v12, s[8:9]
	v_lshrrev_b32_e32 v12, 6, v13
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_and_b32_e32 v12, 0x3fc, v12
	global_load_b32 v29, v12, s[8:9]
	v_bfe_u32 v12, v24, 14, 8
	v_bcnt_u32_b32 v25, v12, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v25, 1, v25
	v_lshlrev_b32_e32 v25, 7, v25
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v12, v25, v12
	v_mul_lo_u32 v30, 0x1010101, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v12, 0x8040201, v30
	v_lshrrev_b32_e32 v25, 24, v12
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b32_e32 v12, 18, v30
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e64 s0, 0, v25.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_bfe_i32 v12, v12, 0, 1
	v_cndmask_b32_e64 v25, 0, -1, s0
	v_cndmask_b32_e64 v26, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_3)
	v_and_b16 v4.h, 0xff, v12.l
	v_mov_b16_e32 v26.h, v21.l
	v_lshlrev_b16 v12.l, 8, v12.l
	v_lshlrev_b16 v12.h, 8, v25.l
	v_bfe_i32 v25, v30, 0, 1
	v_lshlrev_b16 v25.h, 8, v26.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_or_b16 v21.h, v4.h, v12.h
	v_and_b16 v4.h, 0xff, v25.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v26.l, v4.h, v25.h
	v_or_b32_e32 v26, v26, v21
	v_lshlrev_b16 v21.h, 8, v25.l
	s_waitcnt vmcnt(1)
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v26, v28, v26
	v_and_b16 v4.h, 0xff00, v26.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v28.l, v4.h, v25.h clamp
	v_lshlrev_b16 v4.h, 8, v26.l
	v_sub_nc_i16 v25.l, v4.h, v21.h clamp
	v_and_b16 v4.h, 0xff00, v26.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v25, v25, v28, 0xc0c0105
	v_sub_nc_i16 v26.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v26.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	v_perm_b32 v12, v12, v26, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v26, v12, 16, v25
	v_and_b32_e32 v12, 0x80402010, v30
	v_lshrrev_b32_e32 v25, 24, v12
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b16 v28.l, 4, v12.l
	v_lshrrev_b32_e32 v12, 22, v30
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_cmp_ne_u16_e64 s0, 0, v25.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_bfe_i32 v12, v12, 0, 1
	v_cndmask_b32_e64 v25, 0, -1, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_and_b16 v4.h, 0xff, v12.l
	v_lshlrev_b16 v12.l, 8, v12.l
	v_lshlrev_b16 v12.h, 8, v25.l
	v_cndmask_b32_e64 v25, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_or_b16 v21.h, v4.h, v12.h
	v_lshlrev_b16 v4.h, 8, v25.l
	v_bfe_i32 v25, v28, 0, 1
	v_mov_b16_e32 v28.h, v21.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v25.h, 0xff, v25.l
	v_or_b16 v28.l, v25.h, v4.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v28, v28, v21
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v28, v29, v28
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v21.h, 0xff00, v28.l
	v_sub_nc_i16 v29.l, v21.h, v4.h clamp
	v_lshlrev_b16 v4.h, 8, v28.l
	v_lshlrev_b16 v21.h, 8, v25.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v25.l, v4.h, v21.h clamp
	v_and_b16 v4.h, 0xff00, v28.h
	v_perm_b32 v25, v25, v29, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v28.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v28.h
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v12, v12, v28, 0xc0c0105
	v_lshl_or_b32 v12, v12, 16, v25
	v_dot4_i32_iu8 v25, v26, v1, v27 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v26, v12, v2, v25 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v12, 14, v13
	v_and_b32_e32 v12, 0x3fc, v12
	global_load_b32 v27, v12, s[8:9]
	v_lshrrev_b32_e32 v12, 22, v13
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_and_b32_e32 v12, 0x3fc, v12
	global_load_b32 v28, v12, s[8:9]
	v_bfe_u32 v12, v24, 21, 8
	v_bcnt_u32_b32 v13, v12, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v13, 1, v13
	v_lshlrev_b32_e32 v13, 7, v13
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v12, v13, v12
	v_mul_lo_u32 v29, 0x1010101, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v12, 0x8040201, v29
	v_lshrrev_b32_e32 v13, 24, v12
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b32_e32 v12, 18, v29
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e64 s0, 0, v13.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_bfe_i32 v12, v12, 0, 1
	v_cndmask_b32_e64 v13, 0, -1, s0
	v_cndmask_b32_e64 v25, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_3)
	v_and_b16 v4.h, 0xff, v12.l
	v_mov_b16_e32 v25.h, v21.l
	v_lshlrev_b16 v12.l, 8, v12.l
	v_lshlrev_b16 v12.h, 8, v13.l
	v_bfe_i32 v13, v29, 0, 1
	v_lshlrev_b16 v13.h, 8, v25.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_or_b16 v21.h, v4.h, v12.h
	v_and_b16 v4.h, 0xff, v13.l
	v_lshlrev_b16 v13.l, 8, v13.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v25.l, v4.h, v13.h
	v_or_b32_e32 v25, v25, v21
	s_waitcnt vmcnt(1)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v25, v27, v25
	v_and_b16 v4.h, 0xff00, v25.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v27.l, v4.h, v13.h clamp
	v_lshlrev_b16 v4.h, 8, v25.l
	v_sub_nc_i16 v13.l, v4.h, v13.l clamp
	v_and_b16 v4.h, 0xff00, v25.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v13, v13, v27, 0xc0c0105
	v_sub_nc_i16 v25.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v25.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	v_perm_b32 v12, v12, v25, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v25, v12, 16, v13
	v_and_b32_e32 v12, 0x80402010, v29
	v_lshrrev_b32_e32 v13, 24, v12
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b16 v27.l, 4, v12.l
	v_lshrrev_b32_e32 v12, 22, v29
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_cmp_ne_u16_e64 s0, 0, v13.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_bfe_i32 v12, v12, 0, 1
	v_cndmask_b32_e64 v13, 0, -1, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_and_b16 v4.h, 0xff, v12.l
	v_lshlrev_b16 v12.l, 8, v12.l
	v_lshlrev_b16 v12.h, 8, v13.l
	v_cndmask_b32_e64 v13, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_or_b16 v21.h, v4.h, v12.h
	v_lshlrev_b16 v4.h, 8, v13.l
	v_bfe_i32 v13, v27, 0, 1
	v_mov_b16_e32 v27.h, v21.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b16 v13.h, 0xff, v13.l
	v_lshlrev_b16 v13.l, 8, v13.l
	v_or_b16 v27.l, v13.h, v4.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v27, v27, v21
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v27, v28, v27
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v13.h, 0xff00, v27.l
	v_sub_nc_i16 v28.l, v13.h, v4.h clamp
	v_lshlrev_b16 v4.h, 8, v27.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v13.l, v4.h, v13.l clamp
	v_and_b16 v4.h, 0xff00, v27.h
	v_perm_b32 v13, v13, v28, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v27.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v27.h
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	global_load_d16_hi_b16 v4, v[10:11], off offset:64
	v_perm_b32 v12, v12, v27, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_lshl_or_b32 v12, v12, 16, v13
	v_dot4_i32_iu8 v13, v25, v3, v26 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v26, 28, v24
	v_dot4_i32_iu8 v13, v12, v22, v13 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v12, 31, v13
	v_add_nc_u32_e32 v12, v13, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v12, 1, v12
	v_mad_u64_u32 v[24:25], null, v13, v26, v[12:13]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v12, 31, v24
	v_add_nc_u32_e32 v12, v24, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_ashrrev_i32_e32 v13, 1, v12
	s_waitcnt vmcnt(0)
	v_cvt_f32_f16_e32 v12, v4.l
	v_cvt_f32_i32_e32 v13, v13
	v_cvt_f32_f16_e32 v10, v4.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mul_f32_e32 v4, v10, v12
	v_mad_i64_i32 v[10:11], null, 0x42, v23, s[6:7]
	v_fmac_f32_e32 v16, v4, v13
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v23, vcc_lo, v10, v20
	v_add_co_ci_u32_e64 v24, null, 0, v11, vcc_lo
	global_load_b64 v[26:27], v[23:24], off
	v_add_co_u32 v23, vcc_lo, v10, v19
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v24, null, 0, v11, vcc_lo
	global_load_b32 v28, v[23:24], off offset:64
	s_waitcnt vmcnt(1)
	v_and_b32_e32 v23, 0xff, v26
	v_lshlrev_b32_e32 v23, 2, v23
	global_load_b32 v29, v23, s[8:9]
	v_lshrrev_b32_e32 v23, 6, v26
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	v_and_b32_e32 v23, 0x3fc, v23
	global_load_b32 v30, v23, s[8:9]
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v23, 0xff, v28
	v_bcnt_u32_b32 v24, v23, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v24, 1, v24
	v_lshlrev_b32_e32 v24, 7, v24
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v23, v24, v23
	v_mul_lo_u32 v31, 0x1010101, v23
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v23, 0x8040201, v31
	v_lshrrev_b32_e32 v24, 24, v23
	v_lshrrev_b16 v21.h, 8, v23.l
	v_lshrrev_b32_e32 v23, 18, v31
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e64 s0, 0, v24.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_bfe_i32 v23, v23, 0, 1
	v_cndmask_b32_e64 v24, 0, -1, s0
	v_cndmask_b32_e64 v25, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_4)
	v_and_b16 v21.h, 0xff, v23.l
	v_lshlrev_b16 v23.l, 8, v23.l
	v_lshlrev_b16 v23.h, 8, v24.l
	v_bfe_i32 v24, v31, 0, 1
	v_lshlrev_b16 v25.l, 8, v25.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_or_b16 v21.h, v21.h, v23.h
	v_and_b16 v24.h, 0xff, v24.l
	v_lshlrev_b16 v24.l, 8, v24.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v32.l, v24.h, v25.l
	v_or_b32_e32 v32, v32, v21
	s_waitcnt vmcnt(1)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v29, v29, v32
	v_and_b16 v21.h, 0xff00, v29.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v25.l, v21.h, v25.l clamp
	v_lshlrev_b16 v21.h, 8, v29.l
	v_sub_nc_i16 v24.l, v21.h, v24.l clamp
	v_and_b16 v21.h, 0xff00, v29.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v24, v24, v25, 0xc0c0105
	v_sub_nc_i16 v25.l, v21.h, v23.h clamp
	v_lshlrev_b16 v21.h, 8, v29.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v23.l, v21.h, v23.l clamp
	v_perm_b32 v23, v23, v25, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_lshl_or_b32 v29, v23, 16, v24
	v_and_b32_e32 v23, 0x80402010, v31
	v_dot4_i32_iu8 v5, v29, v5, 0 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_2)
	v_lshrrev_b32_e32 v24, 24, v23
	v_lshrrev_b16 v21.h, 8, v23.l
	v_lshrrev_b16 v25.l, 4, v23.l
	v_lshrrev_b32_e32 v23, 22, v31
	v_mov_b16_e32 v31.h, v21.l
	v_cmp_ne_u16_e64 s0, 0, v24.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.h
	v_bfe_i32 v25, v25, 0, 1
	v_bfe_i32 v23, v23, 0, 1
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cndmask_b32_e64 v24, 0, -1, s0
	v_and_b16 v21.h, 0xff, v23.l
	v_lshlrev_b16 v23.l, 8, v23.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshlrev_b16 v23.h, 8, v24.l
	v_cndmask_b32_e64 v24, 0, -1, vcc_lo
	v_and_b16 v24.h, 0xff, v25.l
	v_or_b16 v21.h, v21.h, v23.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b16 v24.l, 8, v24.l
	v_or_b16 v31.l, v24.h, v24.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v31, v31, v21
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v30, v30, v31
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v21.h, 0xff00, v30.l
	v_sub_nc_i16 v31.l, v21.h, v24.l clamp
	v_lshlrev_b16 v21.h, 8, v30.l
	v_lshlrev_b16 v24.l, 8, v25.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v24.l, v21.h, v24.l clamp
	v_and_b16 v21.h, 0xff00, v30.h
	v_perm_b32 v24, v24, v31, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v25.l, v21.h, v23.h clamp
	v_lshlrev_b16 v21.h, 8, v30.h
	v_sub_nc_i16 v23.l, v21.h, v23.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v23, v23, v25, 0xc0c0105
	v_lshl_or_b32 v23, v23, 16, v24
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v25, v23, v6, v5 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v5, 14, v26
	v_and_b32_e32 v5, 0x3fc, v5
	global_load_b32 v29, v5, s[8:9]
	v_lshrrev_b32_e32 v5, 22, v26
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_and_b32_e32 v5, 0x3fc, v5
	global_load_b32 v26, v5, s[8:9]
	v_bfe_u32 v5, v28, 7, 8
	v_bcnt_u32_b32 v6, v5, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v6, 1, v6
	v_lshlrev_b32_e32 v6, 7, v6
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v5, v6, v5
	v_mul_lo_u32 v30, 0x1010101, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b32_e32 v5, 0x8040201, v30
	v_bfe_i32 v23, v30, 0, 1
	v_lshrrev_b32_e32 v6, 24, v5
	v_lshrrev_b16 v5.l, 8, v5.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cmp_ne_u16_e64 s0, 0, v6.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v5.l
	v_lshrrev_b32_e32 v5, 18, v30
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v6, 0, -1, s0
	v_cndmask_b32_e64 v24, 0, -1, vcc_lo
	v_bfe_i32 v5, v5, 0, 1
	v_mov_b16_e32 v24.h, v21.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b16 v6.l, 8, v6.l
	v_lshlrev_b16 v6.h, 8, v24.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b16 v5.h, 0xff, v5.l
	v_lshlrev_b16 v5.l, 8, v5.l
	v_or_b16 v21.h, v5.h, v6.l
	v_and_b16 v5.h, 0xff, v23.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v24.l, v5.h, v6.h
	v_or_b32_e32 v24, v24, v21
	s_waitcnt vmcnt(1)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v24, v29, v24
	v_and_b16 v5.h, 0xff00, v24.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v29.l, v5.h, v6.h clamp
	v_lshlrev_b16 v5.h, 8, v24.l
	v_lshlrev_b16 v6.h, 8, v23.l
	v_sub_nc_i16 v23.l, v5.h, v6.h clamp
	v_and_b16 v5.h, 0xff00, v24.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v23, v23, v29, 0xc0c0105
	v_sub_nc_i16 v6.l, v5.h, v6.l clamp
	v_lshlrev_b16 v5.h, 8, v24.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v5.l, v5.h, v5.l clamp
	v_perm_b32 v5, v5, v6, 0xc0c0105
	v_and_b32_e32 v6, 0x80402010, v30
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshl_or_b32 v24, v5, 16, v23
	v_lshrrev_b32_e32 v23, 24, v6
	v_lshrrev_b16 v5.l, 8, v6.l
	v_lshrrev_b16 v29.l, 4, v6.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e64 s0, 0, v23.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v5.l
	v_lshrrev_b32_e32 v5, 22, v30
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v6, 0, -1, s0
	v_cndmask_b32_e64 v23, 0, -1, vcc_lo
	v_bfe_i32 v5, v5, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshlrev_b16 v6.l, 8, v6.l
	v_and_b16 v5.h, 0xff, v5.l
	v_lshlrev_b16 v5.l, 8, v5.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_or_b16 v21.h, v5.h, v6.l
	v_lshlrev_b16 v5.h, 8, v23.l
	v_bfe_i32 v23, v29, 0, 1
	v_mov_b16_e32 v29.h, v21.l
	v_and_b16 v6.h, 0xff, v23.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v29.l, v6.h, v5.h
	v_or_b32_e32 v29, v29, v21
	s_waitcnt vmcnt(0)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v26, v26, v29
	v_and_b16 v6.h, 0xff00, v26.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v29.l, v6.h, v5.h clamp
	v_lshlrev_b16 v5.h, 8, v26.l
	v_lshlrev_b16 v6.h, 8, v23.l
	v_sub_nc_i16 v23.l, v5.h, v6.h clamp
	v_and_b16 v5.h, 0xff00, v26.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v23, v23, v29, 0xc0c0105
	v_sub_nc_i16 v6.l, v5.h, v6.l clamp
	v_lshlrev_b16 v5.h, 8, v26.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v5.l, v5.h, v5.l clamp
	v_perm_b32 v5, v5, v6, 0xc0c0105
	v_dot4_i32_iu8 v6, v24, v7, v25 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v5, v5, 16, v23
	v_dot4_i32_iu8 v23, v5, v0, v6 neg_lo:[1,1,0]
	v_and_b32_e32 v0, 0xff, v27
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v0, 2, v0
	global_load_b32 v24, v0, s[8:9]
	v_lshrrev_b32_e32 v0, 6, v27
	v_and_b32_e32 v0, 0x3fc, v0
	global_load_b32 v25, v0, s[8:9]
	v_bfe_u32 v0, v28, 14, 8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_bcnt_u32_b32 v5, v0, 0
	v_and_b32_e32 v5, 1, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v5, 7, v5
	v_xor_b32_e32 v0, v5, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v26, 0x1010101, v0
	v_and_b32_e32 v0, 0x8040201, v26
	v_bfe_i32 v6, v26, 0, 1
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_lshrrev_b32_e32 v5, 24, v0
	v_lshrrev_b16 v0.l, 8, v0.l
	v_cmp_ne_u16_e64 s0, 0, v5.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v0.l
	v_lshrrev_b32_e32 v0, 18, v26
	v_cndmask_b32_e64 v5, 0, -1, s0
	v_cndmask_b32_e64 v7, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_4)
	v_bfe_i32 v0, v0, 0, 1
	v_mov_b16_e32 v7.h, v21.l
	v_lshlrev_b16 v5.l, 8, v5.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b16 v5.h, 8, v7.l
	v_and_b16 v0.h, 0xff, v0.l
	v_lshlrev_b16 v0.l, 8, v0.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b16 v21.h, v0.h, v5.l
	v_and_b16 v0.h, 0xff, v6.l
	v_or_b16 v7.l, v0.h, v5.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v7, v7, v21
	s_waitcnt vmcnt(1)
	v_xor_b32_e32 v7, v24, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v0.h, 0xff00, v7.l
	v_sub_nc_i16 v24.l, v0.h, v5.h clamp
	v_lshlrev_b16 v0.h, 8, v7.l
	v_lshlrev_b16 v5.h, 8, v6.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v6.l, v0.h, v5.h clamp
	v_and_b16 v0.h, 0xff00, v7.h
	v_perm_b32 v6, v6, v24, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v5.l, v0.h, v5.l clamp
	v_lshlrev_b16 v0.h, 8, v7.h
	v_sub_nc_i16 v0.l, v0.h, v0.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_perm_b32 v0, v0, v5, 0xc0c0105
	v_and_b32_e32 v5, 0x80402010, v26
	v_lshl_or_b32 v7, v0, 16, v6
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_4)
	v_lshrrev_b32_e32 v6, 24, v5
	v_lshrrev_b16 v0.l, 8, v5.l
	v_lshrrev_b16 v24.l, 4, v5.l
	v_dot4_i32_iu8 v1, v7, v1, v23 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_cmp_ne_u16_e64 s0, 0, v6.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v0.l
	v_lshrrev_b32_e32 v0, 22, v26
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v5, 0, -1, s0
	v_cndmask_b32_e64 v6, 0, -1, vcc_lo
	v_bfe_i32 v0, v0, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshlrev_b16 v5.l, 8, v5.l
	v_and_b16 v0.h, 0xff, v0.l
	v_lshlrev_b16 v0.l, 8, v0.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_or_b16 v21.h, v0.h, v5.l
	v_lshlrev_b16 v0.h, 8, v6.l
	v_bfe_i32 v6, v24, 0, 1
	v_mov_b16_e32 v24.h, v21.l
	v_and_b16 v5.h, 0xff, v6.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v24.l, v5.h, v0.h
	v_or_b32_e32 v24, v24, v21
	s_waitcnt vmcnt(0)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v24, v25, v24
	v_and_b16 v5.h, 0xff00, v24.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v25.l, v5.h, v0.h clamp
	v_lshlrev_b16 v0.h, 8, v24.l
	v_lshlrev_b16 v5.h, 8, v6.l
	v_sub_nc_i16 v6.l, v0.h, v5.h clamp
	v_and_b16 v0.h, 0xff00, v24.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v6, v6, v25, 0xc0c0105
	v_sub_nc_i16 v5.l, v0.h, v5.l clamp
	v_lshlrev_b16 v0.h, 8, v24.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v0.l, v0.h, v0.l clamp
	v_perm_b32 v0, v0, v5, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v0, v0, 16, v6
	v_dot4_i32_iu8 v6, v0, v2, v1 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v0, 14, v27
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_and_b32_e32 v0, 0x3fc, v0
	global_load_b32 v7, v0, s[8:9]
	v_lshrrev_b32_e32 v0, 22, v27
	v_and_b32_e32 v0, 0x3fc, v0
	global_load_b32 v23, v0, s[8:9]
	v_bfe_u32 v0, v28, 21, 8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_bcnt_u32_b32 v1, v0, 0
	v_and_b32_e32 v1, 1, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v1, 7, v1
	v_xor_b32_e32 v0, v1, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v24, 0x1010101, v0
	v_and_b32_e32 v0, 0x8040201, v24
	v_bfe_i32 v2, v24, 0, 1
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_lshrrev_b32_e32 v1, 24, v0
	v_lshrrev_b16 v0.l, 8, v0.l
	v_cmp_ne_u16_e64 s0, 0, v1.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v0.l
	v_lshrrev_b32_e32 v0, 18, v24
	v_cndmask_b32_e64 v1, 0, -1, s0
	v_cndmask_b32_e64 v5, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_4)
	v_bfe_i32 v0, v0, 0, 1
	v_mov_b16_e32 v5.h, v21.l
	v_lshlrev_b16 v1.l, 8, v1.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b16 v1.h, 8, v5.l
	v_and_b16 v0.h, 0xff, v0.l
	v_lshlrev_b16 v0.l, 8, v0.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b16 v21.h, v0.h, v1.l
	v_and_b16 v0.h, 0xff, v2.l
	v_or_b16 v5.l, v0.h, v1.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v5, v5, v21
	s_waitcnt vmcnt(1)
	v_xor_b32_e32 v5, v7, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v0.h, 0xff00, v5.l
	v_sub_nc_i16 v7.l, v0.h, v1.h clamp
	v_lshlrev_b16 v0.h, 8, v5.l
	v_lshlrev_b16 v1.h, 8, v2.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v2.l, v0.h, v1.h clamp
	v_and_b16 v0.h, 0xff00, v5.h
	v_perm_b32 v2, v2, v7, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v1.l, v0.h, v1.l clamp
	v_lshlrev_b16 v0.h, 8, v5.h
	v_sub_nc_i16 v0.l, v0.h, v0.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_perm_b32 v0, v0, v1, 0xc0c0105
	v_and_b32_e32 v1, 0x80402010, v24
	v_lshl_or_b32 v5, v0, 16, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshrrev_b32_e32 v2, 24, v1
	v_lshrrev_b16 v0.l, 8, v1.l
	v_lshrrev_b16 v7.l, 4, v1.l
	v_cmp_ne_u16_e64 s0, 0, v2.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v0.l
	v_lshrrev_b32_e32 v0, 22, v24
	v_cndmask_b32_e64 v1, 0, -1, s0
	v_cndmask_b32_e64 v2, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_4)
	v_bfe_i32 v0, v0, 0, 1
	v_add_co_u32 v8, vcc_lo, 0x480, v8
	v_lshlrev_b16 v1.l, 8, v1.l
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_and_b16 v0.h, 0xff, v0.l
	v_lshlrev_b16 v0.l, 8, v0.l
	v_cmp_le_u32_e32 vcc_lo, s12, v18
	v_or_b16 v21.h, v0.h, v1.l
	v_lshlrev_b16 v0.h, 8, v2.l
	v_bfe_i32 v2, v7, 0, 1
	v_mov_b16_e32 v7.h, v21.l
	s_or_b32 s13, vcc_lo, s13
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v1.h, 0xff, v2.l
	v_or_b16 v7.l, v1.h, v0.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v7, v7, v21
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v7, v23, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v1.h, 0xff00, v7.l
	v_sub_nc_i16 v21.l, v1.h, v0.h clamp
	v_lshlrev_b16 v0.h, 8, v7.l
	v_lshlrev_b16 v1.h, 8, v2.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v2.l, v0.h, v1.h clamp
	v_and_b16 v0.h, 0xff00, v7.h
	v_perm_b32 v2, v2, v21, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v1.l, v0.h, v1.l clamp
	v_lshlrev_b16 v0.h, 8, v7.h
	v_sub_nc_i16 v0.l, v0.h, v0.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_perm_b32 v0, v0, v1, 0xc0c0105
	v_dot4_i32_iu8 v1, v5, v3, v6 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v5, 28, v28
	v_lshl_or_b32 v0, v0, 16, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v3, v0, v22, v1 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v0, 31, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v0, v3, v0
	v_ashrrev_i32_e32 v0, 1, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mad_u64_u32 v[1:2], null, v3, v5, v[0:1]
	v_lshrrev_b32_e32 v0, 31, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v0, v1, v0
	v_ashrrev_i32_e32 v1, 1, v0
	global_load_d16_b16 v0, v[10:11], off offset:64
	v_cvt_f32_i32_e32 v1, v1
	s_waitcnt vmcnt(0)
	v_cvt_f32_f16_e32 v0, v0.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v0, v12, v0
	v_fmac_f32_e32 v15, v0, v1
	s_and_not1_b32 exec_lo, exec_lo, s13
	s_cbranch_execnz .LBB0_2
; %bb.3:
	s_or_b32 exec_lo, exec_lo, s13
.LBB0_4:
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s1
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v17
	v_cmpx_ne_u32_e32 0, v17
	s_cbranch_execz .LBB0_6
; %bb.5:
	v_lshlrev_b32_e32 v0, 7, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_add_u32 v0, v14, 2, v0
	v_add_nc_u32_e32 v1, 0xffffff80, v0
	ds_store_b32 v1, v16
	ds_store_b32 v0, v15
.LBB0_6:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB0_52
; %bb.7:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB0_10
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB0_11
.LBB0_9:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr4
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr0
	s_branch .LBB0_26
.LBB0_10:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB0_9
.LBB0_11:
	v_mbcnt_lo_u32_b32 v0, -1, 0
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_xor_b32_e32 v1, 16, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v1
	v_cndmask_b32_e32 v1, v0, v1, vcc_lo
	v_dual_mov_b32 v1, 32 :: v_dual_lshlrev_b32 v2, 2, v1
	ds_bpermute_b32 v3, v2, v16
	s_cbranch_scc0 .LBB0_14
; %bb.12:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB0_15
.LBB0_13:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr4
                                        ; implicit-def: $vgpr3
	s_branch .LBB0_26
.LBB0_14:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB0_13
.LBB0_15:
	v_xor_b32_e32 v4, 8, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v5, v0, v4, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v4, v16, v3 :: v_dual_lshlrev_b32 v3, 2, v5
	ds_bpermute_b32 v5, v3, v4
	s_cbranch_scc0 .LBB0_18
; %bb.16:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB0_19
.LBB0_17:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr4
	s_branch .LBB0_26
.LBB0_18:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB0_17
.LBB0_19:
	v_xor_b32_e32 v6, 4, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v6
	v_cndmask_b32_e32 v6, v0, v6, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v5, v4, v5 :: v_dual_lshlrev_b32 v4, 2, v6
	ds_bpermute_b32 v6, v4, v5
	s_cbranch_scc0 .LBB0_22
; %bb.20:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB0_23
.LBB0_21:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
	s_branch .LBB0_26
.LBB0_22:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB0_21
.LBB0_23:
	v_xor_b32_e32 v7, 2, v0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v7
	s_waitcnt lgkmcnt(0)
	v_dual_cndmask_b32 v8, v0, v7 :: v_dual_add_f32 v7, v5, v6
	v_lshlrev_b32_e32 v5, 2, v8
	ds_bpermute_b32 v6, v5, v7
	s_cbranch_scc0 .LBB0_25
; %bb.24:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_branch .LBB0_26
.LBB0_25:
	s_mov_b32 s0, 0
	s_mov_b32 s4, -1
.LBB0_26:
	s_mov_b32 s1, 0
	s_and_b32 vcc_lo, exec_lo, s0
	s_mov_b32 s0, 0
	s_cbranch_vccnz .LBB0_39
; %bb.27:
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB0_41
.LBB0_28:
	v_xor_b32_e32 v8, 1, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_lt_i32_e32 vcc_lo, v8, v1
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v1, v7, v6 :: v_dual_cndmask_b32 v0, v0, v8
	v_lshlrev_b32_e32 v6, 2, v0
	ds_bpermute_b32 v0, v6, v1
	s_cbranch_scc0 .LBB0_30
; %bb.29:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB0_31
	s_branch .LBB0_46
.LBB0_30:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB0_46
.LBB0_31:
	ds_bpermute_b32 v2, v2, v15
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB0_33
; %bb.32:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB0_34
	s_branch .LBB0_46
.LBB0_33:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB0_46
.LBB0_34:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v15, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v3, v3, v2
	s_cbranch_scc0 .LBB0_36
; %bb.35:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB0_37
	s_branch .LBB0_46
.LBB0_36:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB0_46
.LBB0_37:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v2, v3
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v3, v4, v2
	s_cbranch_scc0 .LBB0_42
; %bb.38:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_branch .LBB0_43
.LBB0_39:
	s_cbranch_execnz .LBB0_53
; %bb.40:
	s_mov_b32 s0, -1
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB0_28
.LBB0_41:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr1
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB0_48
	s_branch .LBB0_49
.LBB0_42:
	s_mov_b32 s4, 0
.LBB0_43:
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB0_46
; %bb.44:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v2, v3
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v5, v3
	s_cbranch_scc0 .LBB0_55
; %bb.45:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB0_47
	s_branch .LBB0_56
.LBB0_46:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB0_56
.LBB0_47:
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB0_49
.LBB0_48:
	; divergent unreachable
.LBB0_49:
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB0_52
; %bb.50:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v3, v2
	v_cmp_eq_u32_e32 vcc_lo, 0, v14
	s_mov_b32 s1, 0
	ds_bpermute_b32 v3, v6, v2
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB0_52
; %bb.51:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v2, v3
	s_mul_i32 s0, s15, s3
	v_add_f32_e32 v0, v1, v0
	s_lshl_b64 s[0:1], s[0:1], 2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_mul_f32_e32 v3, 0xbfb8aa3b, v2
	s_add_u32 s4, s10, s0
	s_addc_u32 s5, s11, s1
	s_ashr_i32 s3, s2, 31
	s_lshl_b64 s[0:1], s[2:3], 2
	v_fma_f32 v4, 0xbfb8aa3b, v2, -v3
	v_rndne_f32_e32 v5, v3
	s_add_u32 s0, s4, s0
	s_addc_u32 s1, s5, s1
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_f32_e32 v3, v3, v5
	v_cmp_nlt_f32_e32 vcc_lo, 0x42ce8ed0, v2
	v_fmamk_f32 v4, v2, 0xb2a5705f, v4
	v_add_f32_e32 v3, v3, v4
	v_cvt_i32_f32_e32 v4, v5
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_exp_f32_e32 v3, v3
	s_waitcnt_depctr 0xfff
	v_ldexp_f32 v3, v3, v4
	v_cndmask_b32_e32 v3, 0, v3, vcc_lo
	v_cmp_ngt_f32_e32 vcc_lo, 0xc2b17218, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cndmask_b32_e32 v3, 0x7f800000, v3, vcc_lo
	v_add_f32_e32 v3, 1.0, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_div_scale_f32 v4, null, v3, v3, v2
	v_rcp_f32_e32 v5, v4
	s_waitcnt_depctr 0xfff
	v_fma_f32 v6, -v4, v5, 1.0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_fmac_f32_e32 v5, v6, v5
	v_div_scale_f32 v6, vcc_lo, v2, v3, v2
	v_mul_f32_e32 v7, v6, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fma_f32 v8, -v4, v7, v6
	v_fmac_f32_e32 v7, v8, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fma_f32 v4, -v4, v7, v6
	v_div_fmas_f32 v4, v4, v5, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_div_fixup_f32 v1, v4, v3, v2
	v_mov_b32_e32 v2, 0
	v_mul_f32_e32 v0, v0, v1
	global_store_b32 v2, v0, s[0:1]
.LBB0_52:
	s_endpgm
.LBB0_53:
	s_trap 2
	s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)
	s_mov_b32 ttmp2, m0
	s_waitcnt lgkmcnt(0)
	s_and_b32 s0, s0, 0x3ff
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_bitset1_b32 s0, 10
	s_mov_b32 m0, s0
	s_sendmsg sendmsg(MSG_INTERRUPT)
	s_mov_b32 m0, ttmp2
.LBB0_54:                               ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB0_54
.LBB0_55:
	s_mov_b32 s1, -1
	s_branch .LBB0_47
.LBB0_56:
	s_cbranch_execnz .LBB0_58
; %bb.57:
	s_cbranch_execnz .LBB0_48
	s_branch .LBB0_49
.LBB0_58:
	s_trap 2
	s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)
	s_mov_b32 ttmp2, m0
	s_waitcnt lgkmcnt(0)
	s_and_b32 s0, s0, 0x3ff
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_bitset1_b32 s0, 10
	s_mov_b32 m0, s0
	s_sendmsg sendmsg(MSG_INTERRUPT)
	s_mov_b32 m0, ttmp2
.LBB0_59:                               ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB0_59
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
		.amdhsa_group_segment_fixed_size 256
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 48
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 1
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 1
		.amdhsa_next_free_vgpr 33
		.amdhsa_next_free_sgpr 18
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_dx10_clamp 1
		.amdhsa_ieee_mode 1
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_shared_vgpr_count 0
		.amdhsa_inst_pref_size 61
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end0:
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj, .Lfunc_end0-_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.num_vgpr, 33
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 18
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 7760
; TotalNumSgprs: 20
; NumVgprs: 33
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 256 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 4
; NumSGPRsForWavesPerEU: 20
; NumVGPRsForWavesPerEU: 33
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_load_b256 s[4:11], s[0:1], 0x10
	v_bfe_u32 v12, v0, 10, 10
	v_dual_mov_b32 v11, 0 :: v_dual_and_b32 v10, 0x3ff, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v0, v12, 5, v10
	v_lshrrev_b32_e32 v13, 3, v0
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s14, s8, 8
	s_mov_b32 s8, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_gt_u32_e64 s14, v13
	s_cbranch_execz .LBB1_4
; %bb.1:
	v_lshl_add_u32 v0, v12, 5, v10
	s_mul_i32 s10, s10, s3
	v_dual_mov_b32 v11, 0 :: v_dual_and_b32 v4, 7, v10
	s_mul_hi_u32 s13, s10, 36
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_lshrrev_b32_e32 v2, 3, v0
	s_mul_i32 s12, s10, 36
	v_lshlrev_b32_e32 v5, 1, v10
	v_mad_u64_u32 v[0:1], null, 0x120, v2, s[12:13]
	s_load_b64 s[12:13], s[0:1], 0x0
	v_mad_u64_u32 v[2:3], null, v4, 36, v[0:1]
	v_and_b32_e32 v0, 14, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_lshlrev_b32_e32 v1, 1, v0
	v_add_co_u32 v2, vcc_lo, s4, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v3, null, s5, v3, vcc_lo
	v_lshlrev_b32_e32 v14, 1, v1
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v8, vcc_lo, v2, 32
	v_add_co_ci_u32_e64 v9, null, 0, v3, vcc_lo
	v_lshlrev_b32_e32 v15, 1, v0
	s_mul_i32 s5, s9, s2
	s_mov_b32 s4, 0
.LBB1_2:                                ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v18, s5, v13
	s_clause 0x2
	global_load_b32 v16, v[8:9], off
	global_load_b128 v[0:3], v[8:9], off offset:-32
	global_load_b128 v[4:7], v[8:9], off offset:-16
	s_getpc_b64 s[0:1]
	s_add_u32 s0, s0, _ZL11iq3xxs_grid@rel32@lo+4
	s_addc_u32 s1, s1, _ZL11iq3xxs_grid@rel32@hi+12
	v_mov_b16_e32 v17.l, 0
	v_add_nc_u32_e32 v13, 4, v13
	s_waitcnt lgkmcnt(0)
	v_mad_i64_i32 v[21:22], null, 0x42, v18, s[12:13]
	s_delay_alu instid0(VALU_DEP_3)
	v_mov_b16_e32 v18.h, v17.l
	v_mov_b16_e32 v19.h, v17.l
	v_mov_b16_e32 v20.h, v17.l
	v_mov_b16_e32 v45.h, v17.l
	v_mov_b16_e32 v46.h, v17.l
	v_add_co_u32 v23, vcc_lo, v21, v14
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v24, null, 0, v22, vcc_lo
	v_add_co_u32 v25, vcc_lo, v21, v15
	v_add_co_ci_u32_e64 v26, null, 0, v22, vcc_lo
	s_clause 0x2
	global_load_b64 v[23:24], v[23:24], off
	global_load_b32 v50, v[25:26], off offset:64
	global_load_d16_hi_b16 v0, v[21:22], off offset:64
	v_mov_b16_e32 v47.h, v17.l
	v_mov_b16_e32 v48.h, v17.l
	v_mov_b16_e32 v49.h, v17.l
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v21, 0xff, v23
	v_lshrrev_b32_e32 v22, 6, v23
	v_lshrrev_b32_e32 v26, 14, v23
	v_lshrrev_b32_e32 v23, 22, v23
	v_and_b32_e32 v28, 0xff, v24
	v_lshrrev_b32_e32 v29, 6, v24
	v_lshrrev_b32_e32 v31, 14, v24
	v_lshrrev_b32_e32 v24, 22, v24
	v_lshlrev_b32_e32 v21, 2, v21
	v_and_b32_e32 v22, 0x3fc, v22
	v_and_b32_e32 v26, 0x3fc, v26
	v_and_b32_e32 v23, 0x3fc, v23
	v_lshlrev_b32_e32 v28, 2, v28
	v_and_b32_e32 v29, 0x3fc, v29
	v_and_b32_e32 v31, 0x3fc, v31
	v_and_b32_e32 v24, 0x3fc, v24
	s_clause 0x7
	global_load_b32 v51, v21, s[0:1]
	global_load_b32 v52, v22, s[0:1]
	global_load_b32 v53, v26, s[0:1]
	global_load_b32 v54, v23, s[0:1]
	global_load_b32 v55, v28, s[0:1]
	global_load_b32 v56, v29, s[0:1]
	global_load_b32 v57, v31, s[0:1]
	global_load_b32 v58, v24, s[0:1]
	s_waitcnt vmcnt(9)
	v_and_b32_e32 v25, 0xff, v50
	v_bfe_u32 v27, v50, 7, 8
	v_bfe_u32 v30, v50, 14, 8
	v_bfe_u32 v32, v50, 21, 8
	v_cmp_le_u32_e64 s0, s14, v13
	v_bcnt_u32_b32 v33, v25, 0
	v_bcnt_u32_b32 v34, v27, 0
	v_bcnt_u32_b32 v35, v30, 0
	v_bcnt_u32_b32 v36, v32, 0
	s_or_b32 s4, s0, s4
	v_and_b32_e32 v21, 1, v33
	v_and_b32_e32 v22, 1, v34
	v_and_b32_e32 v23, 1, v35
	v_and_b32_e32 v24, 1, v36
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b32_e32 v21, 7, v21
	v_lshlrev_b32_e32 v22, 7, v22
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b32_e32 v23, 7, v23
	v_lshlrev_b32_e32 v24, 7, v24
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_xor_b32_e32 v21, v21, v25
	v_xor_b32_e32 v22, v22, v27
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_xor_b32_e32 v23, v23, v30
	v_xor_b32_e32 v24, v24, v32
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_mul_lo_u32 v21, 0x1010101, v21
	v_mul_lo_u32 v22, 0x1010101, v22
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_mul_lo_u32 v23, 0x1010101, v23
	v_mul_lo_u32 v24, 0x1010101, v24
	s_delay_alu instid0(VALU_DEP_4)
	v_and_b32_e32 v25, 0x8040201, v21
	v_lshrrev_b32_e32 v26, 18, v21
	v_bfe_i32 v27, v21, 0, 1
	v_and_b32_e32 v28, 0x80402010, v21
	v_lshrrev_b32_e32 v21, 22, v21
	v_lshrrev_b32_e32 v43, 24, v25
	v_and_b32_e32 v29, 0x8040201, v22
	v_lshrrev_b32_e32 v30, 18, v22
	v_bfe_i32 v31, v22, 0, 1
	v_and_b32_e32 v32, 0x80402010, v22
	v_lshrrev_b32_e32 v22, 22, v22
	v_and_b32_e32 v33, 0x8040201, v23
	v_lshrrev_b32_e32 v34, 18, v23
	v_bfe_i32 v35, v23, 0, 1
	v_and_b32_e32 v36, 0x80402010, v23
	v_lshrrev_b32_e32 v37, 22, v23
	v_and_b32_e32 v38, 0x8040201, v24
	v_lshrrev_b32_e32 v39, 18, v24
	v_bfe_i32 v40, v24, 0, 1
	v_and_b32_e32 v41, 0x80402010, v24
	v_lshrrev_b32_e32 v42, 22, v24
	v_lshrrev_b16 v17.h, 8, v25.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v43.l
	v_mov_b16_e32 v18.l, v27.l
	v_lshrrev_b32_e32 v27, 24, v28
	v_bfe_i32 v44, v21, 0, 1
	v_lshrrev_b32_e32 v59, 24, v29
	v_lshrrev_b16 v20.l, 8, v29.l
	v_bfe_i32 v29, v30, 0, 1
	v_mov_b16_e32 v21.l, v31.l
	v_lshrrev_b32_e32 v30, 24, v32
	v_lshrrev_b16 v21.h, 8, v32.l
	v_lshrrev_b16 v31.l, 4, v32.l
	v_bfe_i32 v32, v22, 0, 1
	v_lshrrev_b32_e32 v60, 24, v33
	v_lshrrev_b16 v22.l, 8, v33.l
	v_bfe_i32 v33, v34, 0, 1
	v_mov_b16_e32 v23.l, v35.l
	v_lshrrev_b32_e32 v34, 24, v36
	v_lshrrev_b16 v22.h, 8, v36.l
	v_lshrrev_b16 v35.l, 4, v36.l
	v_bfe_i32 v36, v37, 0, 1
	v_lshrrev_b32_e32 v37, 24, v38
	v_lshrrev_b16 v23.h, 8, v38.l
	v_bfe_i32 v38, v39, 0, 1
	v_mov_b16_e32 v24.l, v40.l
	v_lshrrev_b32_e32 v39, 24, v41
	v_lshrrev_b16 v24.h, 8, v41.l
	v_lshrrev_b16 v40.l, 4, v41.l
	v_bfe_i32 v41, v42, 0, 1
	v_cndmask_b32_e64 v42, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v17.h
	v_lshrrev_b16 v19.l, 8, v28.l
	v_bfe_i32 v25, v26, 0, 1
	v_and_b16 v25.h, 0xff, v18.l
	v_lshlrev_b16 v26.l, 8, v18.l
	v_cndmask_b32_e64 v43, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v27.l
	v_mov_b16_e32 v18.l, v44.l
	v_lshrrev_b16 v28.l, 4, v28.l
	v_bfe_i32 v66, v31, 0, 1
	v_mov_b16_e32 v27.l, v33.l
	v_cndmask_b32_e64 v44, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v19.l
	v_bfe_i32 v62, v28, 0, 1
	v_mov_b16_e32 v19.l, v29.l
	v_mov_b16_e32 v29.l, v42.l
	v_and_b16 v17.h, 0xff, v25.l
	v_cndmask_b32_e64 v61, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v59.l
	v_mov_b16_e32 v31.l, v44.l
	v_mov_b16_e32 v33.l, v62.l
	v_lshlrev_b16 v27.h, 8, v18.l
	v_lshlrev_b16 v29.l, 8, v29.l
	v_cndmask_b32_e64 v59, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v20.l
	v_mov_b16_e32 v20.l, v32.l
	v_mov_b16_e32 v32.l, v61.l
	v_and_b16 v28.h, 0xff, v19.l
	v_lshlrev_b16 v29.h, 8, v19.l
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v30.l
	v_mov_b16_e32 v30.l, v43.l
	v_lshlrev_b16 v31.l, 8, v31.l
	v_lshlrev_b16 v32.l, 8, v32.l
	v_and_b16 v36.h, 0xff, v33.l
	v_cndmask_b32_e64 v64, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.h
	v_lshlrev_b16 v30.l, 8, v30.l
	v_or_b16 v17.h, v17.h, v29.l
	v_and_b16 v26.h, 0xff, v21.l
	v_mov_b16_e32 v19.l, v64.l
	v_cndmask_b32_e64 v65, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v60.l
	v_and_b16 v21.h, 0xff, v23.l
	v_bfe_i32 v70, v35, 0, 1
	v_bfe_i32 v75, v40, 0, 1
	v_and_b16 v30.h, 0xff, v20.l
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v22.l
	v_lshlrev_b16 v22.l, 8, v23.l
	v_mov_b16_e32 v23.l, v36.l
	v_mov_b16_e32 v35.l, v65.l
	v_mov_b16_e32 v36.l, v66.l
	v_cndmask_b32_e64 v67, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v34.l
	v_mov_b16_e32 v34.l, v63.l
	v_lshlrev_b16 v31.h, 8, v20.l
	v_mov_b16_e32 v20.l, v60.l
	v_lshlrev_b16 v38.h, 8, v19.l
	v_cndmask_b32_e64 v68, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v22.h
	v_lshlrev_b16 v34.l, 8, v34.l
	v_or_b16 v19.l, v36.h, v32.l
	v_mov_b16_e32 v45.l, v75.l
	v_lshlrev_b16 v35.l, 8, v35.l
	v_cndmask_b32_e64 v69, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v37.l
	v_mov_b16_e32 v37.l, v67.l
	v_and_b16 v39.h, 0xff, v36.l
	v_lshlrev_b16 v40.h, 8, v20.l
	v_or_b16 v20.l, v26.h, v34.l
	v_cndmask_b32_e64 v71, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v23.h
	v_mov_b16_e32 v28.l, v38.l
	v_and_b16 v32.h, 0xff, v27.l
	v_mov_b16_e32 v38.l, v68.l
	v_mov_b16_e32 v40.l, v70.l
	v_cndmask_b32_e64 v72, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v39.l
	v_mov_b16_e32 v39.l, v69.l
	v_lshlrev_b16 v37.l, 8, v37.l
	v_and_b16 v43.h, 0xff, v45.l
	v_and_b16 v22.h, 0xff, v24.l
	v_cndmask_b32_e64 v73, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v24.h
	v_lshlrev_b16 v24.h, 8, v25.l
	v_and_b16 v25.l, 0xff, v18.l
	v_mov_b16_e32 v18.l, v59.l
	v_mov_b16_e32 v43.l, v73.l
	v_cndmask_b32_e64 v74, 0, -1, vcc_lo
	v_lshlrev_b16 v23.h, 8, v24.l
	v_mov_b16_e32 v24.l, v41.l
	v_lshlrev_b16 v37.h, 8, v18.l
	v_or_b16 v18.l, v25.h, v30.l
	v_mov_b16_e32 v44.l, v74.l
	v_lshlrev_b16 v42.h, 8, v43.l
	v_and_b16 v33.h, 0xff, v23.l
	v_mov_b16_e32 v41.l, v71.l
	v_or_b32_e32 v18, v18, v17
	v_or_b16 v17.h, v25.l, v31.l
	v_lshlrev_b16 v43.l, 8, v44.l
	v_lshlrev_b16 v44.l, 8, v45.l
	v_or_b16 v45.l, v39.h, v35.l
	v_mov_b16_e32 v42.l, v72.l
	v_or_b32_e32 v19, v19, v17
	v_or_b16 v17.h, v28.h, v37.h
	v_lshlrev_b16 v38.l, 8, v38.l
	v_lshlrev_b16 v39.l, 8, v39.l
	v_and_b16 v41.h, 0xff, v40.l
	v_or_b16 v46.l, v21.h, v37.l
	v_or_b32_e32 v20, v20, v17
	v_or_b16 v17.h, v30.h, v38.h
	v_and_b16 v34.h, 0xff, v28.l
	v_lshlrev_b16 v41.l, 8, v41.l
	v_lshlrev_b16 v42.l, 8, v42.l
	v_or_b16 v47.l, v41.h, v39.l
	v_or_b32_e32 v25, v45, v17
	v_or_b16 v17.h, v32.h, v40.h
	v_and_b16 v35.h, 0xff, v24.l
	v_or_b16 v48.l, v22.h, v42.l
	v_or_b16 v49.l, v43.h, v43.l
	v_lshlrev_b16 v33.l, 8, v33.l
	v_or_b32_e32 v45, v46, v17
	v_or_b16 v17.h, v33.h, v38.l
	v_lshlrev_b16 v21.l, 8, v21.l
	v_lshlrev_b16 v36.l, 8, v36.l
	v_lshlrev_b16 v27.l, 8, v27.l
	v_lshlrev_b16 v23.l, 8, v23.l
	v_or_b32_e32 v46, v47, v17
	v_or_b16 v17.h, v34.h, v41.l
	v_lshlrev_b16 v40.l, 8, v40.l
	v_lshlrev_b16 v28.l, 8, v28.l
	v_lshlrev_b16 v24.l, 8, v24.l
	v_add_co_u32 v8, vcc_lo, 0x480, v8
	v_or_b32_e32 v47, v48, v17
	v_or_b16 v17.h, v35.h, v42.h
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_or_b32_e32 v17, v49, v17
	s_waitcnt vmcnt(7)
	v_xor_b32_e32 v18, v51, v18
	s_waitcnt vmcnt(6)
	v_xor_b32_e32 v48, v52, v19
	s_waitcnt vmcnt(5)
	v_xor_b32_e32 v49, v53, v20
	s_waitcnt vmcnt(4)
	v_xor_b32_e32 v51, v54, v25
	s_waitcnt vmcnt(3)
	v_xor_b32_e32 v45, v55, v45
	s_waitcnt vmcnt(2)
	v_xor_b32_e32 v46, v56, v46
	v_and_b16 v19.l, 0xff00, v48.l
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v52, v58, v17
	v_and_b16 v17.l, 0xff00, v18.l
	v_lshlrev_b16 v17.h, 8, v18.l
	v_and_b16 v18.l, 0xff00, v18.h
	v_lshlrev_b16 v18.h, 8, v18.h
	v_lshlrev_b16 v19.h, 8, v48.l
	v_and_b16 v20.l, 0xff00, v48.h
	v_lshlrev_b16 v20.h, 8, v48.h
	v_and_b16 v26.h, 0xff00, v51.l
	v_sub_nc_i16 v17.l, v17.l, v30.l clamp
	v_sub_nc_i16 v26.l, v17.h, v26.l clamp
	v_sub_nc_i16 v18.l, v18.l, v29.l clamp
	v_sub_nc_i16 v29.l, v18.h, v24.h clamp
	v_and_b16 v21.h, 0xff00, v49.l
	v_lshlrev_b16 v22.h, 8, v49.l
	v_and_b16 v25.l, 0xff00, v49.h
	v_lshlrev_b16 v25.h, 8, v49.h
	v_and_b16 v30.h, 0xff00, v51.h
	v_sub_nc_i16 v19.l, v19.l, v32.l clamp
	v_sub_nc_i16 v30.l, v19.h, v33.l clamp
	v_sub_nc_i16 v20.l, v20.l, v31.l clamp
	v_sub_nc_i16 v31.l, v20.h, v27.h clamp
	v_perm_b32 v17, v26, v17, 0xc0c0105
	v_perm_b32 v18, v29, v18, 0xc0c0105
	v_lshlrev_b16 v28.h, 8, v51.l
	v_lshlrev_b16 v32.h, 8, v51.h
	v_and_b16 v33.h, 0xff00, v45.l
	v_sub_nc_i16 v32.l, v21.h, v34.l clamp
	v_sub_nc_i16 v21.l, v22.h, v21.l clamp
	v_sub_nc_i16 v25.l, v25.l, v37.h clamp
	v_sub_nc_i16 v33.l, v25.h, v29.h clamp
	v_perm_b32 v19, v30, v19, 0xc0c0105
	v_perm_b32 v20, v31, v20, 0xc0c0105
	v_lshl_or_b32 v17, v18, 16, v17
	v_lshlrev_b16 v34.h, 8, v45.l
	v_and_b16 v35.h, 0xff00, v45.h
	v_lshlrev_b16 v36.h, 8, v45.h
	v_sub_nc_i16 v34.l, v26.h, v35.l clamp
	v_sub_nc_i16 v35.l, v28.h, v36.l clamp
	v_sub_nc_i16 v36.l, v30.h, v38.h clamp
	v_sub_nc_i16 v49.l, v32.h, v31.h clamp
	v_perm_b32 v18, v21, v32, 0xc0c0105
	v_perm_b32 v21, v33, v25, 0xc0c0105
	v_lshl_or_b32 v19, v20, 16, v19
	v_dot4_i32_iu8 v1, v17, v1, 0 neg_lo:[1,1,0]
	v_xor_b32_e32 v47, v57, v47
	v_and_b16 v39.h, 0xff00, v46.l
	v_lshlrev_b16 v41.h, 8, v46.l
	v_and_b16 v43.h, 0xff00, v46.h
	v_lshlrev_b16 v44.h, 8, v46.h
	v_sub_nc_i16 v37.l, v33.h, v37.l clamp
	v_sub_nc_i16 v22.l, v34.h, v22.l clamp
	v_sub_nc_i16 v51.l, v35.h, v40.h clamp
	v_sub_nc_i16 v27.l, v36.h, v27.l clamp
	v_perm_b32 v17, v35, v34, 0xc0c0105
	v_perm_b32 v20, v49, v36, 0xc0c0105
	v_lshl_or_b32 v18, v21, 16, v18
	v_dot4_i32_iu8 v1, v19, v2, v1 neg_lo:[1,1,0]
	v_and_b16 v45.l, 0xff00, v47.l
	v_lshlrev_b16 v45.h, 8, v47.l
	v_and_b16 v46.l, 0xff00, v47.h
	v_lshlrev_b16 v46.h, 8, v47.h
	v_sub_nc_i16 v39.l, v39.h, v39.l clamp
	v_sub_nc_i16 v40.l, v41.h, v40.l clamp
	v_sub_nc_i16 v38.l, v43.h, v38.l clamp
	v_sub_nc_i16 v23.l, v44.h, v23.l clamp
	v_perm_b32 v2, v22, v37, 0xc0c0105
	v_perm_b32 v19, v27, v51, 0xc0c0105
	v_lshl_or_b32 v17, v20, 16, v17
	v_dot4_i32_iu8 v1, v18, v3, v1 neg_lo:[1,1,0]
	v_and_b16 v47.l, 0xff00, v52.l
	v_lshlrev_b16 v47.h, 8, v52.l
	v_and_b16 v48.l, 0xff00, v52.h
	v_lshlrev_b16 v48.h, 8, v52.h
	v_sub_nc_i16 v42.l, v45.l, v42.l clamp
	v_sub_nc_i16 v45.l, v45.h, v23.h clamp
	v_sub_nc_i16 v41.l, v46.l, v41.l clamp
	v_sub_nc_i16 v28.l, v46.h, v28.l clamp
	v_perm_b32 v3, v40, v39, 0xc0c0105
	v_perm_b32 v18, v23, v38, 0xc0c0105
	v_lshl_or_b32 v2, v19, 16, v2
	v_dot4_i32_iu8 v1, v17, v4, v1 neg_lo:[1,1,0]
	v_sub_nc_i16 v43.l, v47.l, v43.l clamp
	v_sub_nc_i16 v44.l, v47.h, v44.l clamp
	v_sub_nc_i16 v46.l, v48.l, v42.h clamp
	v_sub_nc_i16 v24.l, v48.h, v24.l clamp
	v_perm_b32 v4, v45, v42, 0xc0c0105
	v_perm_b32 v17, v28, v41, 0xc0c0105
	v_lshl_or_b32 v3, v18, 16, v3
	v_dot4_i32_iu8 v1, v2, v5, v1 neg_lo:[1,1,0]
	v_perm_b32 v2, v44, v43, 0xc0c0105
	v_perm_b32 v5, v24, v46, 0xc0c0105
	v_lshl_or_b32 v4, v17, 16, v4
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_dot4_i32_iu8 v1, v3, v6, v1 neg_lo:[1,1,0]
	v_lshl_or_b32 v2, v5, 16, v2
	v_lshrrev_b32_e32 v5, 28, v50
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v1, v4, v7, v1 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v4, v2, v16, v1 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v1, 31, v4
	v_add_nc_u32_e32 v1, v4, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 1, v1
	v_mad_u64_u32 v[2:3], null, v4, v5, v[1:2]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v1, 31, v2
	v_add_nc_u32_e32 v1, v2, v1
	v_cvt_f32_f16_e32 v2, v0.l
	v_cvt_f32_f16_e32 v0, v0.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_ashrrev_i32_e32 v1, 1, v1
	v_mul_f32_e32 v0, v0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_f32_i32_e32 v1, v1
	v_fmac_f32_e32 v11, v0, v1
	s_and_not1_b32 exec_lo, exec_lo, s4
	s_cbranch_execnz .LBB1_2
; %bb.3:
	s_or_b32 exec_lo, exec_lo, s4
.LBB1_4:
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s8
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v12
	v_cmpx_ne_u32_e32 0, v12
	s_cbranch_execz .LBB1_6
; %bb.5:
	v_lshlrev_b32_e32 v0, 7, v12
	v_lshlrev_b32_e32 v1, 2, v10
	s_delay_alu instid0(VALU_DEP_1)
	v_add3_u32 v0, v0, v1, 0xffffff80
	ds_store_b32 v0, v11
.LBB1_6:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB1_24
; %bb.7:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, 0
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB1_10
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB1_11
.LBB1_9:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr0
	s_branch .LBB1_20
.LBB1_10:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB1_9
.LBB1_11:
	v_mbcnt_lo_u32_b32 v0, -1, 0
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_xor_b32_e32 v1, 16, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v1
	v_cndmask_b32_e32 v1, v0, v1, vcc_lo
	v_lshlrev_b32_e32 v1, 2, v1
	ds_bpermute_b32 v2, v1, v11
	v_mov_b32_e32 v1, 32
	s_cbranch_scc0 .LBB1_13
; %bb.12:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB1_14
	s_branch .LBB1_19
.LBB1_13:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB1_19
.LBB1_14:
	v_xor_b32_e32 v3, 8, v0
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v11, v2
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v3
	v_cndmask_b32_e32 v3, v0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v3, 2, v3
	ds_bpermute_b32 v3, v3, v2
	s_cbranch_scc0 .LBB1_16
; %bb.15:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB1_17
	s_branch .LBB1_19
.LBB1_16:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB1_19
.LBB1_17:
	v_xor_b32_e32 v4, 4, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v4, v0, v4, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v2, v2, v3 :: v_dual_lshlrev_b32 v3, 2, v4
	ds_bpermute_b32 v3, v3, v2
	s_cbranch_scc0 .LBB1_25
; %bb.18:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB1_26
.LBB1_19:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
.LBB1_20:
	s_and_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB1_28
; %bb.21:
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB1_24
.LBB1_22:
	v_xor_b32_e32 v4, 1, v0
	s_mov_b32 s1, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_cmp_lt_i32_e32 vcc_lo, v4, v1
	s_waitcnt lgkmcnt(0)
	v_dual_cndmask_b32 v1, v0, v4 :: v_dual_add_f32 v0, v3, v2
	v_cmp_eq_u32_e32 vcc_lo, 0, v10
	v_lshlrev_b32_e32 v1, 2, v1
	ds_bpermute_b32 v1, v1, v0
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB1_24
; %bb.23:
	s_mul_i32 s0, s11, s3
	v_mov_b32_e32 v2, 0
	s_lshl_b64 s[0:1], s[0:1], 2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v0, v0, v1
	s_add_u32 s4, s6, s0
	s_addc_u32 s5, s7, s1
	s_ashr_i32 s3, s2, 31
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_lshl_b64 s[0:1], s[2:3], 2
	s_add_u32 s0, s4, s0
	s_addc_u32 s1, s5, s1
	global_store_b32 v2, v0, s[0:1]
.LBB1_24:
	s_endpgm
.LBB1_25:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB1_19
.LBB1_26:
	v_xor_b32_e32 v4, 2, v0
	s_cmp_lg_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v2, v3
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v4, v0, v4, vcc_lo
	v_lshlrev_b32_e32 v2, 2, v4
	ds_bpermute_b32 v2, v2, v3
	s_cbranch_scc0 .LBB1_32
; %bb.27:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_branch .LBB1_20
.LBB1_28:
	s_cbranch_execnz .LBB1_30
; %bb.29:
	; divergent unreachable
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB1_22
	s_branch .LBB1_24
.LBB1_30:
	s_trap 2
	s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)
	s_mov_b32 ttmp2, m0
	s_waitcnt lgkmcnt(0)
	s_and_b32 s0, s0, 0x3ff
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_bitset1_b32 s0, 10
	s_mov_b32 m0, s0
	s_sendmsg sendmsg(MSG_INTERRUPT)
	s_mov_b32 m0, ttmp2
.LBB1_31:                               ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB1_31
.LBB1_32:
	s_mov_b32 s1, 0
	s_mov_b32 s0, -1
	s_branch .LBB1_20
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
		.amdhsa_group_segment_fixed_size 128
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 48
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 1
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 1
		.amdhsa_next_free_vgpr 76
		.amdhsa_next_free_sgpr 15
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_dx10_clamp 1
		.amdhsa_ieee_mode 1
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_shared_vgpr_count 0
		.amdhsa_inst_pref_size 30
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end1:
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj, .Lfunc_end1-_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.num_vgpr, 76
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 15
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 3800
; TotalNumSgprs: 17
; NumVgprs: 76
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 128 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 9
; NumSGPRsForWavesPerEU: 17
; NumVGPRsForWavesPerEU: 76
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_load_b256 s[4:11], s[0:1], 0x10
	v_bfe_u32 v7, v0, 10, 10
	v_dual_mov_b32 v4, 0 :: v_dual_and_b32 v5, 0x3ff, v0
	v_mov_b32_e32 v6, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v0, v7, 5, v5
	v_lshrrev_b32_e32 v8, 3, v0
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s14, s8, 8
	s_mov_b32 s8, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_gt_u32_e64 s14, v8
	s_cbranch_execz .LBB2_4
; %bb.1:
	v_lshl_add_u32 v0, v7, 5, v5
	s_mul_i32 s12, s10, s3
	v_and_b32_e32 v4, 7, v5
	s_mul_hi_u32 s17, s12, 36
	s_mul_i32 s16, s12, 36
	v_lshrrev_b32_e32 v2, 3, v0
	s_load_b64 s[12:13], s[0:1], 0x0
	s_add_u32 s0, s4, s16
	s_addc_u32 s1, s5, s17
	v_lshl_add_u32 v9, v8, 3, s10
	v_mad_u64_u32 v[0:1], null, 0x120, v2, s[16:17]
	v_lshlrev_b32_e32 v2, 1, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_and_b32_e32 v10, 14, v2
	v_mad_u64_u32 v[2:3], null, v4, 36, v[0:1]
	v_mad_u64_u32 v[0:1], null, v4, 36, s[0:1]
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v4, 1, v10
	v_mov_b32_e32 v6, 0
	v_lshlrev_b32_e32 v10, 1, v10
	v_add_co_u32 v2, vcc_lo, s4, v2
	v_add_co_ci_u32_e64 v3, null, s5, v3, vcc_lo
	v_lshlrev_b32_e32 v11, 1, v4
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v2, vcc_lo, v2, 32
	v_add_co_ci_u32_e64 v3, null, 0, v3, vcc_lo
	v_mov_b32_e32 v4, 0
	s_mul_i32 s5, s9, s2
	s_mov_b32 s4, 0
.LBB2_2:                                ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v21, s5, v8
	v_mad_u64_u32 v[25:26], null, v9, 36, v[0:1]
	s_clause 0x2
	global_load_b32 v59, v[2:3], off
	global_load_b128 v[13:16], v[2:3], off offset:-32
	global_load_b128 v[17:20], v[2:3], off offset:-16
	s_getpc_b64 s[0:1]
	s_add_u32 s0, s0, _ZL11iq3xxs_grid@rel32@lo+4
	s_addc_u32 s1, s1, _ZL11iq3xxs_grid@rel32@hi+12
	s_waitcnt lgkmcnt(0)
	v_mad_i64_i32 v[29:30], null, 0x42, v21, s[12:13]
	v_mov_b16_e32 v12.l, 0
	s_clause 0x2
	global_load_b32 v60, v[25:26], off offset:32
	global_load_b128 v[21:24], v[25:26], off
	global_load_b128 v[25:28], v[25:26], off offset:16
	v_add_nc_u32_e32 v8, 4, v8
	v_add_nc_u32_e32 v9, 32, v9
	v_mov_b16_e32 v51.h, v12.l
	v_add_co_u32 v31, vcc_lo, v29, v11
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v32, null, 0, v30, vcc_lo
	v_add_co_u32 v33, vcc_lo, v29, v10
	v_add_co_ci_u32_e64 v34, null, 0, v30, vcc_lo
	s_clause 0x2
	global_load_b64 v[31:32], v[31:32], off
	global_load_b32 v61, v[33:34], off offset:64
	global_load_d16_hi_b16 v13, v[29:30], off offset:64
	v_mov_b16_e32 v52.h, v12.l
	v_mov_b16_e32 v53.h, v12.l
	v_mov_b16_e32 v54.h, v12.l
	v_mov_b16_e32 v55.h, v12.l
	v_mov_b16_e32 v56.h, v12.l
	v_mov_b16_e32 v57.h, v12.l
	v_mov_b16_e32 v58.h, v12.l
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v29, 0xff, v31
	v_lshrrev_b32_e32 v30, 6, v31
	v_lshrrev_b32_e32 v34, 14, v31
	v_lshrrev_b32_e32 v31, 22, v31
	v_and_b32_e32 v36, 0xff, v32
	v_lshrrev_b32_e32 v37, 6, v32
	v_lshrrev_b32_e32 v39, 14, v32
	v_lshrrev_b32_e32 v32, 22, v32
	v_lshlrev_b32_e32 v29, 2, v29
	v_and_b32_e32 v30, 0x3fc, v30
	v_and_b32_e32 v34, 0x3fc, v34
	v_and_b32_e32 v31, 0x3fc, v31
	v_lshlrev_b32_e32 v36, 2, v36
	v_and_b32_e32 v37, 0x3fc, v37
	v_and_b32_e32 v39, 0x3fc, v39
	v_and_b32_e32 v32, 0x3fc, v32
	s_clause 0x7
	global_load_b32 v62, v29, s[0:1]
	global_load_b32 v63, v30, s[0:1]
	global_load_b32 v64, v34, s[0:1]
	global_load_b32 v65, v31, s[0:1]
	global_load_b32 v66, v36, s[0:1]
	global_load_b32 v67, v37, s[0:1]
	global_load_b32 v68, v39, s[0:1]
	global_load_b32 v69, v32, s[0:1]
	s_waitcnt vmcnt(9)
	v_and_b32_e32 v33, 0xff, v61
	v_bfe_u32 v35, v61, 7, 8
	v_bfe_u32 v38, v61, 14, 8
	v_bfe_u32 v40, v61, 21, 8
	v_cmp_le_u32_e64 s0, s14, v8
	v_bcnt_u32_b32 v41, v33, 0
	v_bcnt_u32_b32 v42, v35, 0
	v_bcnt_u32_b32 v43, v38, 0
	v_bcnt_u32_b32 v44, v40, 0
	s_or_b32 s4, s0, s4
	v_and_b32_e32 v29, 1, v41
	v_and_b32_e32 v30, 1, v42
	v_and_b32_e32 v31, 1, v43
	v_and_b32_e32 v32, 1, v44
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b32_e32 v29, 7, v29
	v_lshlrev_b32_e32 v30, 7, v30
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b32_e32 v31, 7, v31
	v_lshlrev_b32_e32 v32, 7, v32
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_xor_b32_e32 v29, v29, v33
	v_xor_b32_e32 v30, v30, v35
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_xor_b32_e32 v31, v31, v38
	v_xor_b32_e32 v32, v32, v40
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_mul_lo_u32 v29, 0x1010101, v29
	v_mul_lo_u32 v30, 0x1010101, v30
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_mul_lo_u32 v31, 0x1010101, v31
	v_mul_lo_u32 v32, 0x1010101, v32
	s_delay_alu instid0(VALU_DEP_4)
	v_and_b32_e32 v33, 0x8040201, v29
	v_bfe_i32 v35, v29, 0, 1
	v_and_b32_e32 v36, 0x80402010, v29
	v_lshrrev_b32_e32 v37, 22, v29
	v_and_b32_e32 v38, 0x8040201, v30
	v_lshrrev_b32_e32 v72, 24, v33
	v_lshrrev_b32_e32 v39, 18, v30
	v_bfe_i32 v40, v30, 0, 1
	v_and_b32_e32 v41, 0x80402010, v30
	v_lshrrev_b32_e32 v42, 22, v30
	v_and_b32_e32 v43, 0x8040201, v31
	v_lshrrev_b32_e32 v44, 18, v31
	v_bfe_i32 v45, v31, 0, 1
	v_and_b32_e32 v46, 0x80402010, v31
	v_lshrrev_b32_e32 v47, 22, v31
	v_and_b32_e32 v48, 0x8040201, v32
	v_lshrrev_b32_e32 v49, 18, v32
	v_bfe_i32 v50, v32, 0, 1
	v_and_b32_e32 v70, 0x80402010, v32
	v_lshrrev_b32_e32 v71, 22, v32
	v_lshrrev_b16 v12.h, 8, v33.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v72.l
	v_lshrrev_b32_e32 v34, 18, v29
	v_mov_b16_e32 v29.l, v35.l
	v_lshrrev_b32_e32 v73, 24, v36
	v_bfe_i32 v35, v37, 0, 1
	v_lshrrev_b32_e32 v37, 24, v38
	v_lshrrev_b16 v29.h, 8, v38.l
	v_bfe_i32 v38, v39, 0, 1
	v_mov_b16_e32 v30.l, v40.l
	v_lshrrev_b32_e32 v39, 24, v41
	v_lshrrev_b16 v30.h, 8, v41.l
	v_lshrrev_b16 v40.l, 4, v41.l
	v_bfe_i32 v41, v42, 0, 1
	v_lshrrev_b32_e32 v42, 24, v43
	v_lshrrev_b16 v31.l, 8, v43.l
	v_bfe_i32 v43, v44, 0, 1
	v_mov_b16_e32 v32.l, v45.l
	v_lshrrev_b32_e32 v44, 24, v46
	v_lshrrev_b16 v31.h, 8, v46.l
	v_lshrrev_b16 v45.l, 4, v46.l
	v_bfe_i32 v46, v47, 0, 1
	v_lshrrev_b32_e32 v47, 24, v48
	v_lshrrev_b16 v32.h, 8, v48.l
	v_bfe_i32 v48, v49, 0, 1
	v_mov_b16_e32 v33.l, v50.l
	v_lshrrev_b32_e32 v49, 24, v70
	v_lshrrev_b16 v33.h, 8, v70.l
	v_lshrrev_b16 v50.l, 4, v70.l
	v_bfe_i32 v70, v71, 0, 1
	v_cndmask_b32_e64 v71, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v12.h
	v_lshrrev_b16 v21.h, 8, v36.l
	v_lshrrev_b16 v36.l, 4, v36.l
	v_bfe_i32 v34, v34, 0, 1
	v_bfe_i32 v80, v40, 0, 1
	v_cndmask_b32_e64 v72, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v73.l
	v_bfe_i32 v75, v36, 0, 1
	v_and_b16 v34.h, 0xff, v29.l
	v_bfe_i32 v85, v45, 0, 1
	v_mov_b16_e32 v40.l, v72.l
	v_cndmask_b32_e64 v73, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.h
	v_and_b16 v21.h, 0xff, v30.l
	v_and_b16 v12.h, 0xff, v34.l
	v_lshlrev_b16 v40.l, 8, v40.l
	v_mov_b16_e32 v36.l, v38.l
	v_cndmask_b32_e64 v74, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v37.l
	v_mov_b16_e32 v37.l, v43.l
	v_mov_b16_e32 v43.l, v75.l
	v_mov_b16_e32 v53.l, v85.l
	v_mov_b16_e32 v38.l, v48.l
	v_cndmask_b32_e64 v76, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v29.h
	v_lshlrev_b16 v29.h, 8, v30.l
	v_mov_b16_e32 v30.l, v41.l
	v_mov_b16_e32 v41.l, v73.l
	v_and_b16 v35.h, 0xff, v36.l
	v_cndmask_b32_e64 v77, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v39.l
	v_mov_b16_e32 v39.l, v71.l
	v_lshlrev_b16 v41.l, 8, v41.l
	v_mov_b16_e32 v48.l, v80.l
	v_mov_b16_e32 v45.l, v77.l
	v_cndmask_b32_e64 v78, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v30.h
	v_lshlrev_b16 v39.l, 8, v39.l
	v_and_b16 v30.h, 0xff, v32.l
	v_lshlrev_b16 v42.h, 8, v43.l
	v_lshlrev_b16 v43.h, 8, v45.l
	v_cndmask_b32_e64 v79, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v42.l
	v_mov_b16_e32 v42.l, v74.l
	v_or_b16 v12.h, v12.h, v39.l
	v_bfe_i32 v89, v50, 0, 1
	v_and_b16 v36.h, 0xff, v30.l
	v_cndmask_b32_e64 v81, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v31.l
	v_lshlrev_b16 v41.h, 8, v42.l
	v_and_b16 v42.l, 0xff, v43.l
	v_lshlrev_b16 v31.l, 8, v32.l
	v_mov_b16_e32 v32.l, v46.l
	v_cndmask_b32_e64 v82, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v44.l
	v_mov_b16_e32 v44.l, v76.l
	v_mov_b16_e32 v46.l, v78.l
	v_and_b16 v45.l, 0xff, v48.l
	v_mov_b16_e32 v50.l, v82.l
	v_cndmask_b32_e64 v83, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v31.h
	v_and_b16 v31.h, 0xff, v33.l
	v_lshlrev_b16 v43.l, 8, v44.l
	v_lshlrev_b16 v44.l, 8, v46.l
	v_mov_b16_e32 v51.l, v83.l
	v_cndmask_b32_e64 v84, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v47.l
	v_mov_b16_e32 v47.l, v79.l
	v_lshlrev_b16 v45.h, 8, v48.l
	v_lshlrev_b16 v48.l, 8, v53.l
	v_mov_b16_e32 v52.l, v84.l
	v_cndmask_b32_e64 v86, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v32.h
	v_lshlrev_b16 v32.h, 8, v33.l
	v_mov_b16_e32 v33.l, v70.l
	v_lshlrev_b16 v44.h, 8, v47.l
	v_lshlrev_b16 v47.l, 8, v51.l
	v_cndmask_b32_e64 v87, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v49.l
	v_or_b16 v51.l, v34.h, v40.l
	v_lshlrev_b16 v47.h, 8, v52.l
	v_and_b16 v34.h, 0xff, v53.l
	v_or_b16 v52.l, v42.l, v41.h
	v_cndmask_b32_e64 v70, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v33.h
	v_lshlrev_b16 v33.h, 8, v34.l
	v_and_b16 v34.l, 0xff, v35.l
	v_or_b32_e32 v51, v51, v12
	v_mov_b16_e32 v56.l, v70.l
	v_mov_b16_e32 v49.l, v81.l
	v_mov_b16_e32 v54.l, v86.l
	v_or_b16 v12.h, v34.l, v41.l
	v_or_b16 v53.l, v21.h, v43.h
	v_lshlrev_b16 v49.h, 8, v56.l
	v_or_b16 v56.l, v34.h, v47.h
	v_and_b16 v37.h, 0xff, v37.l
	v_or_b32_e32 v34, v52, v12
	v_or_b16 v12.h, v35.h, v43.l
	v_mov_b16_e32 v55.l, v87.l
	v_lshlrev_b16 v46.l, 8, v49.l
	v_lshlrev_b16 v46.h, 8, v50.l
	v_lshlrev_b16 v48.h, 8, v54.l
	v_or_b16 v54.l, v45.l, v44.h
	v_or_b32_e32 v52, v53, v12
	v_or_b16 v12.h, v36.h, v44.l
	v_cndmask_b32_e64 v88, 0, -1, vcc_lo
	v_and_b16 v38.h, 0xff, v32.l
	v_lshlrev_b16 v49.l, 8, v55.l
	v_or_b16 v55.l, v30.h, v46.h
	v_or_b32_e32 v53, v54, v12
	v_or_b16 v12.h, v37.h, v46.l
	v_and_b16 v39.h, 0xff, v38.l
	v_mov_b16_e32 v57.l, v88.l
	v_mov_b16_e32 v58.l, v89.l
	v_and_b16 v40.h, 0xff, v33.l
	v_or_b32_e32 v54, v55, v12
	v_or_b16 v12.h, v38.h, v47.l
	v_lshlrev_b16 v50.l, 8, v57.l
	v_and_b16 v42.l, 0xff, v58.l
	v_or_b16 v57.l, v31.h, v49.l
	v_lshlrev_b16 v50.h, 8, v58.l
	v_or_b32_e32 v55, v56, v12
	v_or_b16 v12.h, v39.h, v48.h
	v_or_b16 v58.l, v42.l, v50.l
	v_lshlrev_b16 v29.l, 8, v29.l
	v_lshlrev_b16 v35.l, 8, v35.l
	v_lshlrev_b16 v36.l, 8, v36.l
	v_or_b32_e32 v56, v57, v12
	v_or_b16 v12.h, v40.h, v49.h
	v_lshlrev_b16 v33.l, 8, v33.l
	v_lshlrev_b16 v30.l, 8, v30.l
	v_lshlrev_b16 v37.l, 8, v37.l
	v_lshlrev_b16 v32.l, 8, v32.l
	v_or_b32_e32 v12, v58, v12
	v_lshlrev_b16 v38.l, 8, v38.l
	v_add_co_u32 v2, vcc_lo, 0x480, v2
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v3, null, 0, v3, vcc_lo
	s_waitcnt vmcnt(7)
	v_xor_b32_e32 v51, v62, v51
	s_waitcnt vmcnt(6)
	v_xor_b32_e32 v57, v63, v34
	s_waitcnt vmcnt(5)
	v_xor_b32_e32 v52, v64, v52
	s_waitcnt vmcnt(4)
	v_xor_b32_e32 v53, v65, v53
	s_waitcnt vmcnt(3)
	v_xor_b32_e32 v54, v66, v54
	s_waitcnt vmcnt(2)
	v_xor_b32_e32 v55, v67, v55
	s_waitcnt vmcnt(1)
	v_xor_b32_e32 v58, v68, v56
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v62, v69, v12
	v_and_b16 v12.l, 0xff00, v51.l
	v_lshlrev_b16 v12.h, 8, v51.l
	v_and_b16 v21.h, 0xff00, v51.h
	v_lshlrev_b16 v30.h, 8, v51.h
	v_and_b16 v31.h, 0xff00, v57.l
	v_lshlrev_b16 v34.l, 8, v57.l
	v_and_b16 v34.h, 0xff00, v57.h
	v_lshlrev_b16 v35.h, 8, v57.h
	v_and_b16 v36.h, 0xff00, v52.l
	v_lshlrev_b16 v37.h, 8, v52.l
	v_and_b16 v38.h, 0xff00, v52.h
	v_lshlrev_b16 v39.h, 8, v52.h
	v_and_b16 v40.h, 0xff00, v53.l
	v_lshlrev_b16 v42.l, 8, v53.l
	v_and_b16 v45.l, 0xff00, v53.h
	v_lshlrev_b16 v51.l, 8, v53.h
	v_and_b16 v51.h, 0xff00, v54.l
	v_lshlrev_b16 v52.l, 8, v54.l
	v_and_b16 v52.h, 0xff00, v54.h
	v_lshlrev_b16 v53.l, 8, v54.h
	v_and_b16 v53.h, 0xff00, v55.l
	v_lshlrev_b16 v54.l, 8, v55.l
	v_and_b16 v54.h, 0xff00, v55.h
	v_lshlrev_b16 v55.l, 8, v55.h
	v_and_b16 v55.h, 0xff00, v58.l
	v_lshlrev_b16 v56.l, 8, v58.l
	v_and_b16 v57.h, 0xff00, v62.l
	v_sub_nc_i16 v40.l, v12.l, v40.l clamp
	v_lshlrev_b16 v12.l, 8, v62.l
	v_sub_nc_i16 v58.l, v12.h, v29.l clamp
	v_lshlrev_b16 v29.l, 8, v62.h
	v_sub_nc_i16 v39.l, v21.h, v39.l clamp
	v_sub_nc_i16 v62.l, v30.h, v33.h clamp
	v_sub_nc_i16 v63.l, v31.h, v41.h clamp
	v_sub_nc_i16 v34.l, v34.l, v42.h clamp
	v_sub_nc_i16 v41.l, v34.h, v41.l clamp
	v_sub_nc_i16 v35.l, v35.h, v35.l clamp
	v_sub_nc_i16 v36.l, v39.h, v36.l clamp
	v_sub_nc_i16 v29.l, v29.l, v33.l clamp
	v_perm_b32 v33, v58, v40, 0xc0c0105
	v_perm_b32 v39, v62, v39, 0xc0c0105
	v_sub_nc_i16 v64.l, v36.h, v43.h clamp
	v_sub_nc_i16 v65.l, v37.h, v29.h clamp
	v_sub_nc_i16 v43.l, v38.h, v43.l clamp
	v_perm_b32 v34, v34, v63, 0xc0c0105
	v_perm_b32 v35, v35, v41, 0xc0c0105
	v_lshl_or_b32 v33, v39, 16, v33
	v_sub_nc_i16 v66.l, v40.h, v44.h clamp
	v_sub_nc_i16 v42.l, v42.l, v45.h clamp
	v_sub_nc_i16 v44.l, v45.l, v44.l clamp
	v_sub_nc_i16 v30.l, v51.l, v30.l clamp
	v_perm_b32 v40, v65, v64, 0xc0c0105
	v_perm_b32 v36, v36, v43, 0xc0c0105
	v_lshl_or_b32 v34, v35, 16, v34
	v_dot4_i32_iu8 v14, v33, v14, 0 neg_lo:[1,1,0]
	v_sub_nc_i16 v45.l, v51.h, v46.h clamp
	v_sub_nc_i16 v31.l, v52.l, v31.l clamp
	v_sub_nc_i16 v46.l, v52.h, v46.l clamp
	v_sub_nc_i16 v37.l, v53.l, v37.l clamp
	v_perm_b32 v41, v42, v66, 0xc0c0105
	v_perm_b32 v30, v30, v44, 0xc0c0105
	v_dot4_i32_iu8 v22, v33, v22, 0 neg_lo:[1,1,0]
	v_lshl_or_b32 v33, v36, 16, v40
	v_dot4_i32_iu8 v14, v34, v15, v14 neg_lo:[1,1,0]
	v_and_b16 v56.h, 0xff00, v58.h
	v_lshlrev_b16 v57.l, 8, v58.h
	v_sub_nc_i16 v51.l, v53.h, v47.h clamp
	v_sub_nc_i16 v48.l, v54.l, v48.l clamp
	v_sub_nc_i16 v47.l, v54.h, v47.l clamp
	v_sub_nc_i16 v32.l, v55.l, v32.l clamp
	v_perm_b32 v31, v31, v45, 0xc0c0105
	v_perm_b32 v37, v37, v46, 0xc0c0105
	v_dot4_i32_iu8 v15, v34, v23, v22 neg_lo:[1,1,0]
	v_lshl_or_b32 v22, v30, 16, v41
	v_dot4_i32_iu8 v14, v33, v16, v14 neg_lo:[1,1,0]
	v_and_b16 v12.h, 0xff00, v62.h
	v_sub_nc_i16 v49.l, v55.h, v49.l clamp
	v_sub_nc_i16 v52.l, v56.l, v32.h clamp
	v_sub_nc_i16 v53.l, v56.h, v48.h clamp
	v_sub_nc_i16 v38.l, v57.l, v38.l clamp
	v_perm_b32 v42, v48, v51, 0xc0c0105
	v_perm_b32 v32, v32, v47, 0xc0c0105
	v_dot4_i32_iu8 v15, v33, v24, v15 neg_lo:[1,1,0]
	v_lshl_or_b32 v16, v37, 16, v31
	v_dot4_i32_iu8 v14, v22, v17, v14 neg_lo:[1,1,0]
	v_sub_nc_i16 v50.l, v57.h, v50.l clamp
	v_sub_nc_i16 v12.l, v12.l, v50.h clamp
	v_sub_nc_i16 v54.l, v12.h, v49.h clamp
	v_perm_b32 v43, v52, v49, 0xc0c0105
	v_perm_b32 v38, v38, v53, 0xc0c0105
	v_dot4_i32_iu8 v15, v22, v25, v15 neg_lo:[1,1,0]
	v_lshl_or_b32 v17, v32, 16, v42
	v_dot4_i32_iu8 v14, v16, v18, v14 neg_lo:[1,1,0]
	v_perm_b32 v12, v12, v50, 0xc0c0105
	v_perm_b32 v29, v29, v54, 0xc0c0105
	v_dot4_i32_iu8 v15, v16, v26, v15 neg_lo:[1,1,0]
	v_lshl_or_b32 v16, v38, 16, v43
	v_dot4_i32_iu8 v14, v17, v19, v14 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v19, 28, v61
	v_lshl_or_b32 v12, v29, 16, v12
	v_dot4_i32_iu8 v15, v17, v27, v15 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_dot4_i32_iu8 v14, v16, v20, v14 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v15, v16, v28, v15 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_dot4_i32_iu8 v17, v12, v59, v14 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v18, v12, v60, v15 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshrrev_b32_e32 v12, 31, v17
	v_lshrrev_b32_e32 v14, 31, v18
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_nc_u32_e32 v12, v17, v12
	v_add_nc_u32_e32 v14, v18, v14
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_ashrrev_i32_e32 v12, 1, v12
	v_ashrrev_i32_e32 v14, 1, v14
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mad_u64_u32 v[15:16], null, v17, v19, v[12:13]
	v_mad_u64_u32 v[16:17], null, v18, v19, v[14:15]
	v_lshrrev_b32_e32 v12, 31, v15
	v_cvt_f32_f16_e32 v17, v13.l
	v_cvt_f32_f16_e32 v13, v13.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_add_nc_u32_e32 v12, v15, v12
	v_lshrrev_b32_e32 v14, 31, v16
	v_cvt_f32_f16_e32 v15, v21.l
	v_ashrrev_i32_e32 v12, 1, v12
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_4)
	v_add_nc_u32_e32 v14, v16, v14
	v_mul_f32_e32 v16, v13, v17
	v_mul_f32_e32 v13, v13, v15
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_cvt_f32_i32_e32 v12, v12
	v_ashrrev_i32_e32 v14, 1, v14
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_fmac_f32_e32 v6, v16, v12
	v_cvt_f32_i32_e32 v14, v14
	s_delay_alu instid0(VALU_DEP_1)
	v_fmac_f32_e32 v4, v13, v14
	s_and_not1_b32 exec_lo, exec_lo, s4
	s_cbranch_execnz .LBB2_2
; %bb.3:
	s_or_b32 exec_lo, exec_lo, s4
.LBB2_4:
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s8
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v7
	v_cmpx_ne_u32_e32 0, v7
	s_cbranch_execz .LBB2_6
; %bb.5:
	v_lshlrev_b32_e32 v0, 8, v7
	v_lshlrev_b32_e32 v1, 2, v5
	s_delay_alu instid0(VALU_DEP_1)
	v_add3_u32 v0, v0, v1, 0xffffff00
	ds_store_2addr_b32 v0, v6, v4 offset1:32
.LBB2_6:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB2_35
; %bb.7:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, 0
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB2_9
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB2_10
	s_branch .LBB2_30
.LBB2_9:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB2_30
.LBB2_10:
	v_mbcnt_lo_u32_b32 v1, -1, 0
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_xor_b32_e32 v0, 16, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v0
	v_cndmask_b32_e32 v0, v1, v0, vcc_lo
	v_lshlrev_b32_e32 v0, 2, v0
	ds_bpermute_b32 v2, v0, v6
	s_cbranch_scc0 .LBB2_12
; %bb.11:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB2_13
	s_branch .LBB2_30
.LBB2_12:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB2_30
.LBB2_13:
	v_xor_b32_e32 v3, 8, v1
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v3
	v_cndmask_b32_e32 v7, v1, v3, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v3, v6, v2 :: v_dual_lshlrev_b32 v2, 2, v7
	ds_bpermute_b32 v6, v2, v3
	s_cbranch_scc0 .LBB2_15
; %bb.14:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB2_16
	s_branch .LBB2_30
.LBB2_15:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB2_30
.LBB2_16:
	v_xor_b32_e32 v7, 4, v1
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v6, v3, v6
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v7
	v_cndmask_b32_e32 v7, v1, v7, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v3, 2, v7
	ds_bpermute_b32 v7, v3, v6
	s_cbranch_scc0 .LBB2_18
; %bb.17:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB2_19
	s_branch .LBB2_30
.LBB2_18:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB2_30
.LBB2_19:
	v_xor_b32_e32 v8, 2, v1
	s_cmp_lg_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v6, v7
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v8
	v_cndmask_b32_e32 v8, v1, v8, vcc_lo
	v_lshlrev_b32_e32 v6, 2, v8
	ds_bpermute_b32 v8, v6, v7
	s_cbranch_scc0 .LBB2_21
; %bb.20:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_branch .LBB2_22
.LBB2_21:
	s_mov_b32 s4, -1
	s_mov_b32 s1, 0
.LBB2_22:
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB2_30
; %bb.23:
	v_xor_b32_e32 v9, 1, v1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	s_mul_i32 s0, s11, s3
	s_mov_b32 s1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_lshl_b64 s[4:5], s[0:1], 2
	v_cmp_gt_i32_e32 vcc_lo, 32, v9
	s_add_u32 s0, s6, s4
	s_addc_u32 s5, s7, s5
	s_ashr_i32 s3, s2, 31
	v_cmp_eq_u32_e64 s4, 0, v5
	v_cndmask_b32_e32 v1, v1, v9, vcc_lo
	s_lshl_b64 s[2:3], s[2:3], 2
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	s_add_u32 s2, s0, s2
	s_addc_u32 s3, s5, s3
	v_lshlrev_b32_e32 v1, 2, v1
	ds_bpermute_b32 v8, v1, v7
	s_and_saveexec_b32 s0, s4
	s_cbranch_execz .LBB2_25
; %bb.24:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v5, v7, v8
	v_mov_b32_e32 v7, 0
	global_store_b32 v7, v5, s[2:3]
.LBB2_25:
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s0, -1, 0
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB2_27
; %bb.26:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s0, -1, 0
.LBB2_27:
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB2_40
; %bb.28:
	ds_bpermute_b32 v0, v0, v4
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB2_41
; %bb.29:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s5, -1, 0
	s_branch .LBB2_42
.LBB2_30:
                                        ; implicit-def: $sgpr4
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $sgpr2_sgpr3
                                        ; implicit-def: $vgpr0
.LBB2_31:
	s_and_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB2_36
; %bb.32:
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB2_35
.LBB2_33:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v3, v2
	ds_bpermute_b32 v3, v1, v2
	s_and_b32 exec_lo, exec_lo, s4
	s_cbranch_execz .LBB2_35
; %bb.34:
	s_waitcnt lgkmcnt(0)
	v_dual_mov_b32 v1, 0 :: v_dual_add_f32 v2, v2, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	v_add_co_u32 v0, vcc_lo, s2, v0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v1, null, s3, v1, vcc_lo
	global_store_b32 v[0:1], v2, off
.LBB2_35:
	s_endpgm
.LBB2_36:
	s_cbranch_execnz .LBB2_38
; %bb.37:
	; divergent unreachable
	s_cbranch_execz .LBB2_33
	s_branch .LBB2_35
.LBB2_38:
	s_trap 2
	s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)
	s_mov_b32 ttmp2, m0
	s_waitcnt lgkmcnt(0)
	s_and_b32 s0, s0, 0x3ff
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_bitset1_b32 s0, 10
	s_mov_b32 m0, s0
	s_sendmsg sendmsg(MSG_INTERRUPT)
	s_mov_b32 m0, ttmp2
.LBB2_39:                               ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB2_39
.LBB2_40:
	s_mov_b32 s0, 0
	s_branch .LBB2_53
.LBB2_41:
	s_mov_b32 s1, 0
.LBB2_42:
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB2_53
; %bb.43:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v0, v4, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v2, v0
	s_cbranch_scc0 .LBB2_45
; %bb.44:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s5, -1, 0
	s_branch .LBB2_46
.LBB2_45:
	s_mov_b32 s1, 0
.LBB2_46:
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB2_53
; %bb.47:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v0, v0, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v3, v0
	s_cbranch_scc0 .LBB2_49
; %bb.48:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s5, -1, 0
	s_branch .LBB2_50
.LBB2_49:
	s_mov_b32 s1, 0
.LBB2_50:
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB2_53
; %bb.51:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v0, v2
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s1, 0
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v6, v3
	s_cbranch_scc0 .LBB2_54
; %bb.52:
	s_cmp_lg_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	v_mov_b32_e32 v0, s11
	s_branch .LBB2_31
.LBB2_53:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
.LBB2_54:
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v0, s11
	s_branch .LBB2_31
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
		.amdhsa_group_segment_fixed_size 256
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 48
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 1
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 1
		.amdhsa_next_free_vgpr 90
		.amdhsa_next_free_sgpr 18
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_dx10_clamp 1
		.amdhsa_ieee_mode 1
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_shared_vgpr_count 0
		.amdhsa_inst_pref_size 35
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end2:
	.size	_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj, .Lfunc_end2-_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.num_vgpr, 90
	.set _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 18
	.set _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 4368
; TotalNumSgprs: 20
; NumVgprs: 90
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 256 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 11
; NumSGPRsForWavesPerEU: 20
; NumVGPRsForWavesPerEU: 90
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_load_b256 s[4:11], s[0:1], 0x10
	v_bfe_u32 v10, v0, 10, 10
	v_dual_mov_b32 v5, 0 :: v_dual_and_b32 v8, 0x3ff, v0
	v_dual_mov_b32 v6, 0 :: v_dual_mov_b32 v7, 0
	v_mov_b32_e32 v9, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v0, v10, 5, v8
	v_lshrrev_b32_e32 v11, 3, v0
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s14, s8, 8
	s_mov_b32 s8, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_gt_u32_e64 s14, v11
	s_cbranch_execz .LBB3_4
; %bb.1:
	v_lshl_add_u32 v0, v10, 5, v8
	s_load_b64 s[12:13], s[0:1], 0x0
	s_mul_i32 s0, s10, s3
	v_lshlrev_b32_e32 v3, 1, v8
	s_mul_hi_u32 s1, s0, 36
	v_lshrrev_b32_e32 v2, 3, v0
	s_mul_i32 s0, s0, 36
	v_and_b32_e32 v5, 7, v8
	v_dual_mov_b32 v7, 0 :: v_dual_and_b32 v6, 14, v3
	s_delay_alu instid0(VALU_DEP_3)
	v_mad_u64_u32 v[0:1], null, 0x120, v2, s[0:1]
	v_dual_mov_b32 v9, 0 :: v_dual_lshlrev_b32 v2, 3, v11
	s_add_u32 s0, s4, s0
	s_addc_u32 s1, s5, s1
	v_lshlrev_b32_e32 v15, 1, v6
	s_mul_i32 s9, s9, s2
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_mad_u64_u32 v[3:4], null, v5, 36, v[0:1]
	v_add_nc_u32_e32 v12, s10, v2
	v_lshl_add_u32 v13, s10, 1, v2
	v_mad_u64_u32 v[0:1], null, s10, 3, v[2:3]
	v_add_co_u32 v3, vcc_lo, s4, v3
	v_mad_u64_u32 v[1:2], null, v5, 36, s[0:1]
	v_add_co_ci_u32_e64 v4, null, s5, v4, vcc_lo
	v_lshlrev_b32_e32 v5, 1, v6
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v3, vcc_lo, v3, 16
	v_add_co_ci_u32_e64 v4, null, 0, v4, vcc_lo
	s_delay_alu instid0(VALU_DEP_3)
	v_lshlrev_b32_e32 v14, 1, v5
	v_dual_mov_b32 v6, 0 :: v_dual_mov_b32 v5, 0
	s_mov_b32 s1, 0
.LBB3_2:                                ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v25, s9, v11
	v_mad_u64_u32 v[38:39], null, v12, 36, v[1:2]
	v_mad_u64_u32 v[41:42], null, v13, 36, v[1:2]
	s_waitcnt lgkmcnt(0)
	s_delay_alu instid0(VALU_DEP_3)
	v_mad_i64_i32 v[33:34], null, 0x42, v25, s[12:13]
	s_clause 0x1
	global_load_b128 v[17:20], v[3:4], off offset:-16
	global_load_b128 v[21:24], v[3:4], off
	s_clause 0x2
	global_load_b128 v[25:28], v[38:39], off
	global_load_b32 v71, v[38:39], off offset:32
	global_load_b128 v[29:32], v[41:42], off
	v_mov_b16_e32 v16.l, 0
	v_mad_u64_u32 v[47:48], null, v0, 36, v[1:2]
	v_add_co_u32 v35, vcc_lo, v33, v14
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v36, null, 0, v34, vcc_lo
	v_add_co_u32 v43, vcc_lo, v33, v15
	v_add_co_ci_u32_e64 v44, null, 0, v34, vcc_lo
	s_clause 0x2
	global_load_b64 v[35:36], v[35:36], off
	global_load_b32 v72, v[43:44], off offset:64
	global_load_d16_hi_b16 v17, v[33:34], off offset:64
	v_mov_b16_e32 v64.h, v16.l
	v_mov_b16_e32 v40.h, v16.l
	v_mov_b16_e32 v65.h, v16.l
	v_mov_b16_e32 v66.h, v16.l
	v_mov_b16_e32 v67.h, v16.l
	v_mov_b16_e32 v68.h, v16.l
	v_mov_b16_e32 v69.h, v16.l
	v_mov_b16_e32 v70.h, v16.l
	s_getpc_b64 s[4:5]
	s_add_u32 s4, s4, _ZL11iq3xxs_grid@rel32@lo+4
	s_addc_u32 s5, s5, _ZL11iq3xxs_grid@rel32@hi+12
	v_add_nc_u32_e32 v11, 4, v11
	v_add_nc_u32_e32 v12, 32, v12
	v_add_nc_u32_e32 v0, 32, v0
	v_add_nc_u32_e32 v13, 32, v13
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v75, 0xff, v36
	s_waitcnt vmcnt(1)
	v_and_b32_e32 v33, 0xff, v72
	v_bfe_u32 v34, v72, 7, 8
	v_lshrrev_b32_e32 v76, 6, v36
	v_lshrrev_b32_e32 v77, 14, v36
	v_lshrrev_b32_e32 v78, 22, v36
	v_bcnt_u32_b32 v37, v33, 0
	v_bfe_u32 v36, v72, 21, 8
	v_bcnt_u32_b32 v45, v34, 0
	v_and_b32_e32 v43, 0xff, v35
	v_lshrrev_b32_e32 v44, 6, v35
	v_and_b32_e32 v37, 1, v37
	v_bcnt_u32_b32 v49, v36, 0
	v_and_b32_e32 v45, 1, v45
	v_lshrrev_b32_e32 v73, 14, v35
	v_lshrrev_b32_e32 v74, 22, v35
	v_lshlrev_b32_e32 v37, 7, v37
	v_bfe_u32 v35, v72, 14, 8
	v_and_b32_e32 v49, 1, v49
	v_lshlrev_b32_e32 v45, 7, v45
	v_lshrrev_b32_e32 v72, 28, v72
	v_xor_b32_e32 v33, v37, v33
	v_bcnt_u32_b32 v46, v35, 0
	v_lshlrev_b32_e32 v49, 7, v49
	v_xor_b32_e32 v34, v45, v34
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_mul_lo_u32 v33, 0x1010101, v33
	v_and_b32_e32 v46, 1, v46
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_xor_b32_e32 v36, v49, v36
	v_mul_lo_u32 v34, 0x1010101, v34
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_lshlrev_b32_e32 v46, 7, v46
	v_mul_lo_u32 v36, 0x1010101, v36
	v_and_b32_e32 v37, 0x8040201, v33
	v_lshrrev_b32_e32 v45, 18, v33
	v_and_b32_e32 v49, 0x80402010, v33
	v_xor_b32_e32 v35, v46, v35
	v_bfe_i32 v46, v33, 0, 1
	v_lshrrev_b32_e32 v62, 24, v37
	v_bfe_i32 v52, v34, 0, 1
	v_lshrrev_b16 v16.h, 8, v37.l
	v_bfe_i32 v37, v45, 0, 1
	v_lshrrev_b32_e32 v51, 18, v34
	v_cmp_ne_u16_e32 vcc_lo, 0, v62.l
	v_bfe_i32 v60, v36, 0, 1
	v_mov_b16_e32 v45.l, v46.l
	v_lshrrev_b32_e32 v46, 24, v49
	v_lshrrev_b16 v25.h, 8, v49.l
	v_lshrrev_b16 v40.l, 4, v49.l
	v_mov_b16_e32 v49.l, v52.l
	v_mov_b16_e32 v52.l, v37.l
	v_cndmask_b32_e64 v37, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v16.h
	v_and_b32_e32 v50, 0x8040201, v34
	v_bfe_i32 v80, v51, 0, 1
	v_mov_b16_e32 v51.l, v60.l
	v_mul_lo_u32 v35, 0x1010101, v35
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v46.l
	v_lshrrev_b32_e32 v79, 24, v50
	v_and_b32_e32 v53, 0x80402010, v34
	v_lshrrev_b16 v29.h, 8, v50.l
	v_lshrrev_b32_e32 v33, 22, v33
	v_cndmask_b32_e64 v62, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v25.h
	v_and_b32_e32 v54, 0x8040201, v35
	v_lshrrev_b32_e32 v81, 24, v53
	v_lshrrev_b32_e32 v34, 22, v34
	v_bfe_i32 v63, v33, 0, 1
	v_cndmask_b32_e64 v46, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v79.l
	v_lshrrev_b16 v33.l, 8, v53.l
	v_lshrrev_b32_e32 v83, 24, v54
	v_lshrrev_b16 v33.h, 8, v54.l
	v_mov_b16_e32 v54.l, v80.l
	v_cndmask_b32_e64 v79, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v29.h
	v_lshrrev_b32_e32 v55, 18, v35
	v_bfe_i32 v82, v34, 0, 1
	v_and_b32_e32 v57, 0x80402010, v35
	v_bfe_i32 v56, v35, 0, 1
	v_cndmask_b32_e64 v80, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v81.l
	v_bfe_i32 v84, v55, 0, 1
	v_mov_b16_e32 v55.l, v82.l
	v_lshrrev_b32_e32 v85, 24, v57
	v_and_b32_e32 v58, 0x8040201, v36
	v_cndmask_b32_e64 v81, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v33.l
	v_mov_b16_e32 v50.l, v56.l
	v_lshrrev_b16 v34.l, 8, v57.l
	v_mov_b16_e32 v56.l, v84.l
	v_lshrrev_b32_e32 v35, 22, v35
	v_cndmask_b32_e64 v82, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v83.l
	v_and_b32_e32 v61, 0x80402010, v36
	v_lshrrev_b32_e32 v86, 24, v58
	v_lshrrev_b32_e32 v59, 18, v36
	v_lshrrev_b16 v64.l, 4, v53.l
	v_cndmask_b32_e64 v83, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v33.h
	v_lshrrev_b16 v65.l, 4, v57.l
	v_bfe_i32 v57, v35, 0, 1
	v_lshrrev_b16 v34.h, 8, v58.l
	v_lshrrev_b16 v35.l, 8, v61.l
	v_cndmask_b32_e64 v84, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v85.l
	v_lshrrev_b32_e32 v36, 22, v36
	v_bfe_i32 v58, v59, 0, 1
	v_lshrrev_b32_e32 v59, 24, v61
	v_lshrrev_b16 v61.l, 4, v61.l
	v_cndmask_b32_e64 v85, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v34.l
	v_mov_b16_e32 v34.l, v37.l
	v_bfe_i32 v87, v64, 0, 1
	v_cmp_ne_u16_e64 s0, 0, v34.h
	v_bfe_i32 v36, v36, 0, 1
	v_cndmask_b32_e64 v88, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v86.l
	v_lshlrev_b16 v45.h, 8, v34.l
	v_mov_b16_e32 v34.l, v60.l
	v_mov_b16_e32 v53.l, v63.l
	v_bfe_i32 v63, v40, 0, 1
	v_cndmask_b32_e64 v86, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v35.l
	v_mov_b16_e32 v35.l, v46.l
	v_lshlrev_b16 v46.l, 8, v34.l
	v_mov_b16_e32 v34.l, v80.l
	v_and_b16 v25.h, 0xff, v49.l
	v_bfe_i32 v89, v65, 0, 1
	v_cndmask_b32_e64 v90, 0, -1, s0
	v_lshlrev_b16 v49.h, 8, v35.l
	v_bfe_i32 v92, v61, 0, 1
	v_mov_b16_e32 v35.l, v82.l
	v_mov_b16_e32 v61.l, v87.l
	v_lshlrev_b16 v50.h, 8, v34.l
	v_mov_b16_e32 v34.l, v84.l
	v_and_b16 v35.h, 0xff, v45.l
	v_and_b16 v29.h, 0xff, v50.l
	v_cmp_ne_u16_e64 s0, 0, v59.l
	v_mov_b16_e32 v59.l, v36.l
	v_and_b16 v16.h, 0xff, v52.l
	v_mov_b16_e32 v60.l, v63.l
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_lshlrev_b16 v51.h, 8, v35.l
	v_or_b16 v65.l, v25.h, v50.h
	v_and_b16 v25.h, 0xff, v61.l
	v_mov_b16_e32 v35.l, v62.l
	v_mov_b16_e32 v36.l, v88.l
	v_mov_b16_e32 v62.l, v89.l
	v_mov_b16_e32 v37.l, v90.l
	v_lshlrev_b16 v52.h, 8, v34.l
	v_and_b16 v33.l, 0xff, v51.l
	v_or_b16 v16.h, v16.h, v45.h
	v_or_b16 v40.l, v35.h, v46.l
	v_and_b16 v33.h, 0xff, v60.l
	v_or_b16 v66.l, v25.h, v51.h
	v_and_b16 v25.h, 0xff, v53.l
	v_lshlrev_b16 v53.h, 8, v36.l
	v_or_b16 v67.l, v29.h, v52.h
	v_and_b16 v29.h, 0xff, v62.l
	v_mov_b16_e32 v34.l, v79.l
	v_mov_b16_e32 v36.l, v63.l
	v_mov_b16_e32 v63.l, v92.l
	v_lshlrev_b16 v54.h, 8, v37.l
	v_lshlrev_b16 v56.h, 8, v35.l
	v_or_b16 v64.l, v33.h, v49.h
	v_or_b16 v68.l, v29.h, v53.h
	v_and_b16 v29.h, 0xff, v54.l
	v_lshlrev_b16 v55.h, 8, v36.l
	v_or_b16 v69.l, v33.l, v54.h
	v_and_b16 v33.l, 0xff, v63.l
	v_mov_b16_e32 v36.l, v81.l
	v_or_b32_e32 v40, v40, v16
	v_or_b16 v16.h, v25.h, v56.h
	v_lshlrev_b16 v57.h, 8, v34.l
	v_or_b16 v70.l, v33.l, v55.h
	v_and_b16 v33.l, 0xff, v55.l
	v_mov_b16_e32 v35.l, v83.l
	v_or_b32_e32 v64, v64, v16
	v_or_b16 v16.h, v29.h, v57.h
	v_lshlrev_b16 v58.h, 8, v36.l
	v_and_b16 v25.h, 0xff, v56.l
	v_mov_b16_e32 v34.l, v85.l
	v_lshlrev_b16 v59.h, 8, v35.l
	v_or_b32_e32 v65, v65, v16
	v_or_b16 v16.h, v33.l, v58.h
	v_cndmask_b32_e64 v91, 0, -1, s0
	v_and_b16 v29.h, 0xff, v57.l
	v_mov_b16_e32 v36.l, v86.l
	v_lshlrev_b16 v60.h, 8, v34.l
	v_or_b32_e32 v66, v66, v16
	v_or_b16 v16.h, v25.h, v59.h
	v_and_b16 v33.l, 0xff, v58.l
	v_mov_b16_e32 v37.l, v91.l
	v_lshlrev_b16 v61.h, 8, v36.l
	v_and_b16 v25.h, 0xff, v59.l
	v_or_b32_e32 v67, v67, v16
	v_or_b16 v16.h, v29.h, v60.h
	v_lshlrev_b16 v62.h, 8, v37.l
	v_and_b32_e32 v37, 0x3fc, v44
	v_and_b32_e32 v44, 0x3fc, v74
	v_and_b32_e32 v74, 0x3fc, v76
	v_or_b32_e32 v68, v68, v16
	v_or_b16 v16.h, v33.l, v61.h
	v_and_b32_e32 v76, 0x3fc, v78
	global_load_b128 v[33:36], v[47:48], off
	s_waitcnt vmcnt(1)
	v_cvt_f32_f16_e32 v81, v17.l
	v_cvt_f32_f16_e32 v85, v29.l
	v_or_b32_e32 v69, v69, v16
	v_or_b16 v16.h, v25.h, v62.h
	v_cvt_f32_f16_e32 v83, v25.l
	v_lshlrev_b16 v25.l, 8, v59.l
	s_delay_alu instid0(VALU_DEP_3)
	v_or_b32_e32 v70, v70, v16
	v_lshlrev_b32_e32 v16, 2, v43
	v_and_b32_e32 v43, 0x3fc, v73
	v_lshlrev_b32_e32 v73, 2, v75
	v_and_b32_e32 v75, 0x3fc, v77
	s_clause 0x7
	global_load_b32 v16, v16, s[4:5]
	global_load_b32 v37, v37, s[4:5]
	global_load_b32 v43, v43, s[4:5]
	global_load_b32 v44, v44, s[4:5]
	global_load_b32 v73, v73, s[4:5]
	global_load_b32 v74, v74, s[4:5]
	global_load_b32 v75, v75, s[4:5]
	global_load_b32 v76, v76, s[4:5]
	global_load_b32 v78, v[41:42], off offset:32
	global_load_b32 v79, v[3:4], off offset:16
	v_add_co_u32 v3, vcc_lo, 0x480, v3
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v4, null, 0, v4, vcc_lo
	v_cmp_le_u32_e32 vcc_lo, s14, v11
	s_or_b32 s1, vcc_lo, s1
	s_waitcnt vmcnt(10)
	v_cvt_f32_f16_e32 v33, v33.l
	s_waitcnt vmcnt(9)
	v_xor_b32_e32 v77, v16, v40
	s_waitcnt vmcnt(8)
	v_xor_b32_e32 v64, v37, v64
	global_load_b128 v[37:40], v[38:39], off offset:16
	s_waitcnt vmcnt(8)
	v_xor_b32_e32 v65, v43, v65
	s_waitcnt vmcnt(7)
	v_xor_b32_e32 v66, v44, v66
	v_and_b16 v16.h, 0xff00, v77.l
	s_waitcnt vmcnt(5)
	v_xor_b32_e32 v68, v74, v68
	v_xor_b32_e32 v67, v73, v67
	global_load_b32 v73, v[47:48], off offset:32
	v_lshlrev_b16 v16.l, 8, v45.l
	v_sub_nc_i16 v74.l, v16.h, v46.l clamp
	v_and_b16 v16.h, 0xff00, v77.h
	s_waitcnt vmcnt(4)
	v_xor_b32_e32 v70, v76, v70
	v_lshlrev_b16 v25.h, 8, v77.l
	v_xor_b32_e32 v69, v75, v69
	v_lshlrev_b16 v17.l, 8, v65.h
	v_sub_nc_i16 v76.l, v16.h, v45.h clamp
	s_clause 0x1
	global_load_b128 v[45:48], v[47:48], off offset:16
	global_load_b128 v[41:44], v[41:42], off offset:16
	v_sub_nc_i16 v75.l, v25.h, v16.l clamp
	v_lshlrev_b16 v16.l, 8, v52.l
	v_lshlrev_b16 v25.h, 8, v77.h
	v_lshlrev_b16 v16.h, 8, v60.l
	v_lshlrev_b16 v29.l, 8, v68.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v52.l, v25.h, v16.l clamp
	v_and_b16 v16.l, 0xff00, v64.l
	v_lshlrev_b16 v25.h, 8, v64.h
	v_sub_nc_i16 v60.l, v16.l, v49.h clamp
	v_lshlrev_b16 v16.l, 8, v64.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v64.l, v16.l, v16.h clamp
	v_and_b16 v16.l, 0xff00, v64.h
	v_lshlrev_b16 v16.h, 8, v53.l
	v_sub_nc_i16 v77.l, v16.l, v56.h clamp
	v_lshlrev_b16 v16.l, 8, v49.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_sub_nc_i16 v49.l, v25.h, v16.h clamp
	v_and_b16 v16.h, 0xff00, v65.l
	v_lshlrev_b16 v25.h, 8, v63.l
	v_perm_b32 v49, v49, v77, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v53.l, v16.h, v50.h clamp
	v_lshlrev_b16 v16.h, 8, v65.l
	v_sub_nc_i16 v65.l, v16.h, v16.l clamp
	v_and_b16 v16.l, 0xff00, v65.h
	v_lshlrev_b16 v16.h, 8, v61.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v80.l, v16.l, v57.h clamp
	v_lshlrev_b16 v16.l, 8, v54.l
	v_sub_nc_i16 v54.l, v17.l, v16.l clamp
	v_and_b16 v16.l, 0xff00, v66.l
	v_lshlrev_b16 v17.l, 8, v66.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v61.l, v16.l, v51.h clamp
	v_lshlrev_b16 v16.l, 8, v66.l
	v_sub_nc_i16 v66.l, v16.l, v16.h clamp
	v_and_b16 v16.l, 0xff00, v66.h
	v_lshlrev_b16 v16.h, 8, v55.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_sub_nc_i16 v82.l, v16.l, v58.h clamp
	v_lshlrev_b16 v16.l, 8, v50.l
	v_sub_nc_i16 v50.l, v17.l, v16.h clamp
	v_and_b16 v16.h, 0xff00, v67.l
	v_lshlrev_b16 v17.l, 8, v67.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_perm_b32 v50, v50, v82, 0xc0c0105
	v_sub_nc_i16 v55.l, v16.h, v52.h clamp
	v_lshlrev_b16 v16.h, 8, v67.l
	v_perm_b32 v52, v52, v76, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v67.l, v16.h, v16.l clamp
	v_and_b16 v16.l, 0xff00, v67.h
	v_lshlrev_b16 v16.h, 8, v62.l
	v_sub_nc_i16 v84.l, v16.l, v59.h clamp
	v_lshlrev_b16 v16.l, 8, v56.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_sub_nc_i16 v56.l, v17.l, v16.l clamp
	v_and_b16 v16.l, 0xff00, v68.l
	v_lshlrev_b16 v17.l, 8, v58.l
	v_perm_b32 v56, v56, v84, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v62.l, v16.l, v53.h clamp
	v_lshlrev_b16 v16.l, 8, v68.l
	v_perm_b32 v53, v65, v53, 0xc0c0105
	v_sub_nc_i16 v68.l, v16.l, v16.h clamp
	v_lshlrev_b16 v16.h, 8, v57.l
	v_and_b16 v16.l, 0xff00, v68.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_sub_nc_i16 v29.l, v29.l, v16.h clamp
	v_and_b16 v16.h, 0xff00, v69.l
	v_sub_nc_i16 v86.l, v16.l, v60.h clamp
	v_lshlrev_b16 v16.l, 8, v51.l
	v_perm_b32 v60, v64, v60, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_2) | instid1(VALU_DEP_4)
	v_sub_nc_i16 v51.l, v16.h, v54.h clamp
	v_lshlrev_b16 v16.h, 8, v69.l
	v_perm_b32 v54, v54, v80, 0xc0c0105
	v_lshl_or_b32 v49, v49, 16, v60
	v_perm_b32 v29, v29, v86, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_sub_nc_i16 v57.l, v16.h, v16.l clamp
	v_lshlrev_b16 v16.h, 8, v69.h
	v_and_b16 v16.l, 0xff00, v69.h
	v_perm_b32 v51, v57, v51, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_3)
	v_sub_nc_i16 v59.l, v16.h, v17.l clamp
	v_lshlrev_b16 v16.h, 8, v70.l
	v_lshlrev_b16 v17.l, 8, v70.h
	v_sub_nc_i16 v58.l, v16.l, v61.h clamp
	v_and_b16 v16.l, 0xff00, v70.l
	v_perm_b32 v61, v66, v61, 0xc0c0105
	v_sub_nc_i16 v69.l, v16.h, v25.h clamp
	v_sub_nc_i16 v17.l, v17.l, v25.l clamp
	v_perm_b32 v25, v75, v74, 0xc0c0105
	v_sub_nc_i16 v63.l, v16.l, v55.h clamp
	v_and_b16 v16.l, 0xff00, v70.h
	v_perm_b32 v55, v67, v55, 0xc0c0105
	v_lshl_or_b32 v50, v50, 16, v61
	v_lshl_or_b32 v25, v52, 16, v25
	v_lshl_or_b32 v52, v54, 16, v53
	v_sub_nc_i16 v16.l, v16.l, v62.h clamp
	v_perm_b32 v62, v68, v62, 0xc0c0105
	v_lshl_or_b32 v53, v56, 16, v55
	v_dot4_i32_iu8 v18, v25, v18, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v26, v25, v26, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v30, v25, v30, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v25, v25, v34, 0 neg_lo:[1,1,0]
	v_perm_b32 v57, v59, v58, 0xc0c0105
	v_dot4_i32_iu8 v18, v49, v19, v18 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v19, v49, v27, v26 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v26, v49, v31, v30 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v25, v49, v35, v25 neg_lo:[1,1,0]
	v_lshl_or_b32 v29, v29, 16, v62
	v_dot4_i32_iu8 v18, v52, v20, v18 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v19, v52, v28, v19 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v20, v52, v32, v26 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v25, v52, v36, v25 neg_lo:[1,1,0]
	v_perm_b32 v58, v69, v63, 0xc0c0105
	v_dot4_i32_iu8 v18, v50, v21, v18 neg_lo:[1,1,0]
	v_perm_b32 v16, v17, v16, 0xc0c0105
	v_lshl_or_b32 v51, v57, 16, v51
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_dot4_i32_iu8 v18, v53, v22, v18 neg_lo:[1,1,0]
	v_lshl_or_b32 v16, v16, 16, v58
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v18, v29, v23, v18 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v18, v51, v24, v18 neg_lo:[1,1,0]
	s_waitcnt vmcnt(4)
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v23, v16, v79, v18 neg_lo:[1,1,0]
	s_waitcnt vmcnt(3)
	v_dot4_i32_iu8 v19, v50, v37, v19 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v19, v53, v38, v19 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1)
	v_dot4_i32_iu8 v19, v29, v39, v19 neg_lo:[1,1,0]
	s_waitcnt vmcnt(1)
	v_dot4_i32_iu8 v21, v50, v45, v25 neg_lo:[1,1,0]
	s_waitcnt vmcnt(0)
	v_dot4_i32_iu8 v20, v50, v41, v20 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v19, v51, v40, v19 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_dot4_i32_iu8 v21, v53, v46, v21 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v20, v53, v42, v20 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_dot4_i32_iu8 v24, v16, v71, v19 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v21, v29, v47, v21 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_dot4_i32_iu8 v20, v29, v43, v20 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v18, 31, v24
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_dot4_i32_iu8 v21, v51, v48, v21 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v20, v51, v44, v20 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_nc_u32_e32 v18, v24, v18
	v_dot4_i32_iu8 v26, v16, v73, v21 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_4)
	v_dot4_i32_iu8 v25, v16, v78, v20 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v16, 31, v23
	v_ashrrev_i32_e32 v18, 1, v18
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshrrev_b32_e32 v20, 31, v26
	v_lshrrev_b32_e32 v19, 31, v25
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_nc_u32_e32 v16, v23, v16
	v_add_nc_u32_e32 v20, v26, v20
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_nc_u32_e32 v19, v25, v19
	v_ashrrev_i32_e32 v16, 1, v16
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_ashrrev_i32_e32 v20, 1, v20
	v_ashrrev_i32_e32 v19, 1, v19
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mad_u64_u32 v[21:22], null, v23, v72, v[16:17]
	v_cvt_f32_f16_e32 v16, v17.h
	v_mad_u64_u32 v[22:23], null, v24, v72, v[18:19]
	v_mad_u64_u32 v[23:24], null, v25, v72, v[19:20]
	s_delay_alu instid0(VALU_DEP_4)
	v_mad_u64_u32 v[18:19], null, v26, v72, v[20:21]
	v_lshrrev_b32_e32 v19, 31, v21
	v_mul_f32_e32 v17, v16, v81
	v_lshrrev_b32_e32 v20, 31, v22
	v_mul_f32_e32 v26, v16, v83
	v_lshrrev_b32_e32 v24, 31, v23
	v_add_nc_u32_e32 v19, v21, v19
	v_lshrrev_b32_e32 v25, 31, v18
	v_add_nc_u32_e32 v20, v22, v20
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_dual_mul_f32 v22, v16, v85 :: v_dual_add_nc_u32 v21, v23, v24
	v_ashrrev_i32_e32 v19, 1, v19
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_add_nc_u32_e32 v18, v18, v25
	v_ashrrev_i32_e32 v20, 1, v20
	v_mul_f32_e32 v16, v16, v33
	v_ashrrev_i32_e32 v21, 1, v21
	v_cvt_f32_i32_e32 v19, v19
	v_ashrrev_i32_e32 v18, 1, v18
	v_cvt_f32_i32_e32 v20, v20
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_cvt_f32_i32_e32 v21, v21
	v_fmac_f32_e32 v9, v17, v19
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_cvt_f32_i32_e32 v18, v18
	v_fmac_f32_e32 v7, v26, v20
	s_delay_alu instid0(VALU_DEP_2)
	v_dual_fmac_f32 v6, v22, v21 :: v_dual_fmac_f32 v5, v16, v18
	s_and_not1_b32 exec_lo, exec_lo, s1
	s_cbranch_execnz .LBB3_2
; %bb.3:
	s_or_b32 exec_lo, exec_lo, s1
.LBB3_4:
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s8
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v10
	v_cmpx_ne_u32_e32 0, v10
	s_cbranch_execz .LBB3_6
; %bb.5:
	v_lshlrev_b32_e32 v0, 9, v10
	v_lshlrev_b32_e32 v1, 2, v8
	s_delay_alu instid0(VALU_DEP_1)
	v_add3_u32 v0, v0, v1, 0xfffffe00
	ds_store_2addr_b32 v0, v9, v7 offset1:32
	ds_store_2addr_b32 v0, v6, v5 offset0:64 offset1:96
.LBB3_6:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB3_35
; %bb.7:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB3_9
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB3_10
	s_branch .LBB3_30
.LBB3_9:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB3_30
.LBB3_10:
	v_mbcnt_lo_u32_b32 v0, -1, 0
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_xor_b32_e32 v1, 16, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v1
	v_cndmask_b32_e32 v1, v0, v1, vcc_lo
	v_lshlrev_b32_e32 v1, 2, v1
	ds_bpermute_b32 v2, v1, v9
	s_cbranch_scc0 .LBB3_12
; %bb.11:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB3_13
	s_branch .LBB3_30
.LBB3_12:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB3_30
.LBB3_13:
	v_xor_b32_e32 v3, 8, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v3
	s_waitcnt lgkmcnt(0)
	v_dual_cndmask_b32 v4, v0, v3 :: v_dual_add_f32 v3, v9, v2
	v_lshlrev_b32_e32 v2, 2, v4
	ds_bpermute_b32 v4, v2, v3
	s_cbranch_scc0 .LBB3_15
; %bb.14:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB3_16
	s_branch .LBB3_30
.LBB3_15:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB3_30
.LBB3_16:
	v_xor_b32_e32 v9, 4, v0
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v4, v3, v4
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v9
	v_cndmask_b32_e32 v9, v0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v3, 2, v9
	ds_bpermute_b32 v9, v3, v4
	s_cbranch_scc0 .LBB3_18
; %bb.17:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB3_19
	s_branch .LBB3_30
.LBB3_18:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB3_30
.LBB3_19:
	v_xor_b32_e32 v10, 2, v0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v10
	v_cndmask_b32_e32 v10, v0, v10, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v9, v4, v9 :: v_dual_lshlrev_b32 v4, 2, v10
	ds_bpermute_b32 v10, v4, v9
	s_cbranch_scc0 .LBB3_21
; %bb.20:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_branch .LBB3_22
.LBB3_21:
	s_mov_b32 s0, -1
	s_mov_b32 s5, 0
.LBB3_22:
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB3_30
; %bb.23:
	v_xor_b32_e32 v11, 1, v0
	s_mul_i32 s4, s11, s3
	s_mov_b32 s5, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v9, v9, v10
	s_lshl_b64 s[0:1], s[4:5], 2
	v_cmp_gt_i32_e32 vcc_lo, 32, v11
	s_add_u32 s4, s6, s0
	s_addc_u32 s6, s7, s1
	s_ashr_i32 s3, s2, 31
	v_cndmask_b32_e32 v0, v0, v11, vcc_lo
	s_lshl_b64 s[0:1], s[2:3], 2
	v_cmp_eq_u32_e64 s2, 0, v8
	s_add_u32 s0, s4, s0
	s_addc_u32 s1, s6, s1
	v_lshlrev_b32_e32 v0, 2, v0
	ds_bpermute_b32 v10, v0, v9
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB3_25
; %bb.24:
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v8, v9, v10 :: v_dual_mov_b32 v9, 0
	global_store_b32 v9, v8, s[0:1]
.LBB3_25:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB3_27
; %bb.26:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
.LBB3_27:
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB3_40
; %bb.28:
	ds_bpermute_b32 v8, v1, v7
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB3_41
; %bb.29:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB3_42
.LBB3_30:
                                        ; implicit-def: $sgpr2
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $sgpr0_sgpr1
                                        ; implicit-def: $vgpr3
.LBB3_31:
	s_and_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB3_36
; %bb.32:
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB3_35
.LBB3_33:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v2, v1
	ds_bpermute_b32 v0, v0, v1
	s_and_b32 exec_lo, exec_lo, s2
	s_cbranch_execz .LBB3_35
; %bb.34:
	v_mul_lo_u32 v2, v3, 3
	s_waitcnt lgkmcnt(0)
	v_dual_mov_b32 v3, 0 :: v_dual_add_f32 v4, v1, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64 v[2:3], 2, v[2:3]
	v_add_co_u32 v0, vcc_lo, s0, v2
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v1, null, s1, v3, vcc_lo
	global_store_b32 v[0:1], v4, off
.LBB3_35:
	s_endpgm
.LBB3_36:
	s_cbranch_execnz .LBB3_38
; %bb.37:
	; divergent unreachable
	s_cbranch_execz .LBB3_33
	s_branch .LBB3_35
.LBB3_38:
	s_trap 2
	s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)
	s_mov_b32 ttmp2, m0
	s_waitcnt lgkmcnt(0)
	s_and_b32 s0, s0, 0x3ff
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_bitset1_b32 s0, 10
	s_mov_b32 m0, s0
	s_sendmsg sendmsg(MSG_INTERRUPT)
	s_mov_b32 m0, ttmp2
.LBB3_39:                               ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB3_39
.LBB3_40:
	s_mov_b32 s4, 0
	s_branch .LBB3_97
.LBB3_41:
	s_mov_b32 s5, 0
.LBB3_42:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB3_97
; %bb.43:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v2, v7
	s_cbranch_scc0 .LBB3_45
; %bb.44:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB3_46
.LBB3_45:
	s_mov_b32 s5, 0
.LBB3_46:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB3_97
; %bb.47:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v3, v7
	s_cbranch_scc0 .LBB3_49
; %bb.48:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB3_50
.LBB3_49:
	s_mov_b32 s5, 0
.LBB3_50:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB3_97
; %bb.51:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v4, v7
	s_cbranch_scc0 .LBB3_53
; %bb.52:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB3_54
.LBB3_53:
	s_mov_b32 s5, 0
.LBB3_54:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB3_97
; %bb.55:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	ds_bpermute_b32 v8, v0, v7
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB3_57
; %bb.56:
	s_mov_b32 s5, 0
	s_mov_b32 s4, s11
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v7, v7, v8 :: v_dual_mov_b32 v8, 0
	s_lshl_b64 s[4:5], s[4:5], 2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_add_u32 s4, s0, s4
	s_addc_u32 s5, s1, s5
	global_store_b32 v8, v7, s[4:5]
.LBB3_57:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB3_59
; %bb.58:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB3_60
.LBB3_59:
	s_mov_b32 s5, 0
.LBB3_60:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB3_97
; %bb.61:
	ds_bpermute_b32 v7, v1, v6
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB3_63
; %bb.62:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB3_64
.LBB3_63:
	s_mov_b32 s5, 0
.LBB3_64:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB3_97
; %bb.65:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v6, v6, v7
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v7, v2, v6
	s_cbranch_scc0 .LBB3_67
; %bb.66:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB3_68
.LBB3_67:
	s_mov_b32 s5, 0
.LBB3_68:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB3_97
; %bb.69:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v6, v6, v7
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v7, v3, v6
	s_cbranch_scc0 .LBB3_71
; %bb.70:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB3_72
.LBB3_71:
	s_mov_b32 s5, 0
.LBB3_72:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB3_97
; %bb.73:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v6, v6, v7
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v7, v4, v6
	s_cbranch_scc0 .LBB3_75
; %bb.74:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB3_76
.LBB3_75:
	s_mov_b32 s5, 0
.LBB3_76:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB3_97
; %bb.77:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v6, v6, v7
	ds_bpermute_b32 v7, v0, v6
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB3_79
; %bb.78:
	s_lshl_b32 s4, s11, 1
	s_mov_b32 s5, 0
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v6, v6, v7 :: v_dual_mov_b32 v7, 0
	s_lshl_b64 s[4:5], s[4:5], 2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_add_u32 s4, s0, s4
	s_addc_u32 s5, s1, s5
	global_store_b32 v7, v6, s[4:5]
.LBB3_79:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB3_81
; %bb.80:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB3_82
.LBB3_81:
	s_mov_b32 s5, 0
.LBB3_82:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB3_97
; %bb.83:
	ds_bpermute_b32 v1, v1, v5
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB3_85
; %bb.84:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB3_86
.LBB3_85:
	s_mov_b32 s5, 0
.LBB3_86:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB3_97
; %bb.87:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v5, v1
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v2, v1
	s_cbranch_scc0 .LBB3_89
; %bb.88:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB3_90
.LBB3_89:
	s_mov_b32 s5, 0
.LBB3_90:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB3_97
; %bb.91:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v3, v1
	s_cbranch_scc0 .LBB3_93
; %bb.92:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB3_94
.LBB3_93:
	s_mov_b32 s5, 0
.LBB3_94:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB3_97
; %bb.95:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s5, 0
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v1, v4, v2
	s_cbranch_scc0 .LBB3_98
; %bb.96:
	s_cmp_lg_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	v_mov_b32_e32 v3, s11
	s_branch .LBB3_31
.LBB3_97:
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr2
.LBB3_98:
	v_mov_b32_e32 v3, s11
	s_branch .LBB3_31
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
		.amdhsa_group_segment_fixed_size 512
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 48
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 1
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 1
		.amdhsa_next_free_vgpr 93
		.amdhsa_next_free_sgpr 15
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_dx10_clamp 1
		.amdhsa_ieee_mode 1
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_shared_vgpr_count 0
		.amdhsa_inst_pref_size 44
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end3:
	.size	_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj, .Lfunc_end3-_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.num_vgpr, 93
	.set _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 15
	.set _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 5532
; TotalNumSgprs: 17
; NumVgprs: 93
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 512 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 11
; NumSGPRsForWavesPerEU: 17
; NumVGPRsForWavesPerEU: 93
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_load_b256 s[4:11], s[0:1], 0x10
	v_bfe_u32 v13, v0, 10, 10
	v_dual_mov_b32 v5, 0 :: v_dual_and_b32 v10, 0x3ff, v0
	v_dual_mov_b32 v4, 0 :: v_dual_mov_b32 v7, 0
	v_dual_mov_b32 v6, 0 :: v_dual_mov_b32 v9, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshl_or_b32 v0, v13, 5, v10
	v_dual_mov_b32 v8, 0 :: v_dual_mov_b32 v11, 0
	v_mov_b32_e32 v12, 0
	v_lshrrev_b32_e32 v14, 3, v0
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s14, s8, 8
	s_mov_b32 s8, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_gt_u32_e64 s14, v14
	s_cbranch_execz .LBB4_4
; %bb.1:
	v_lshl_add_u32 v0, v13, 5, v10
	s_load_b64 s[12:13], s[0:1], 0x0
	s_mul_i32 s0, s10, s3
	v_dual_mov_b32 v12, 0 :: v_dual_and_b32 v5, 7, v10
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_lshrrev_b32_e32 v2, 3, v0
	s_mul_hi_u32 s19, s0, 36
	s_mul_i32 s18, s0, 36
	v_dual_mov_b32 v11, 0 :: v_dual_lshlrev_b32 v4, 1, v10
	v_mad_u64_u32 v[0:1], null, 0x120, v2, s[18:19]
	s_add_u32 s18, s4, s18
	v_dual_mov_b32 v9, 0 :: v_dual_and_b32 v4, 14, v4
	s_addc_u32 s19, s5, s19
	v_dual_mov_b32 v8, 0 :: v_dual_lshlrev_b32 v15, 3, v14
	v_mad_u64_u32 v[2:3], null, v5, 36, v[0:1]
	v_mad_u64_u32 v[0:1], null, v5, 36, s[18:19]
	v_dual_mov_b32 v6, 0 :: v_dual_lshlrev_b32 v5, 1, v4
	v_dual_mov_b32 v4, 0 :: v_dual_lshlrev_b32 v17, 1, v4
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v2, vcc_lo, s4, v2
	v_add_co_ci_u32_e64 v3, null, s5, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_dual_mov_b32 v7, 0 :: v_dual_lshlrev_b32 v16, 1, v5
	v_add_co_u32 v2, vcc_lo, v2, 16
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v3, null, 0, v3, vcc_lo
	v_mov_b32_e32 v5, 0
	s_mul_i32 s1, s9, s2
	s_mul_i32 s9, s10, 7
	s_mul_i32 s15, s10, 6
	s_mul_i32 s16, s10, 5
	s_lshl_b32 s17, s10, 2
	s_mul_i32 s18, s10, 3
	s_lshl_b32 s20, s10, 1
	s_mov_b32 s19, 0
.LBB4_2:                                ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v18, s1, v14
	s_getpc_b64 s[4:5]
	s_add_u32 s4, s4, _ZL11iq3xxs_grid@rel32@lo+4
	s_addc_u32 s5, s5, _ZL11iq3xxs_grid@rel32@hi+12
	v_mov_b16_e32 v31.l, 0
	v_add_nc_u32_e32 v14, 4, v14
	s_waitcnt lgkmcnt(0)
	v_mad_i64_i32 v[28:29], null, 0x42, v18, s[12:13]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v18, vcc_lo, v28, v16
	v_add_co_ci_u32_e64 v19, null, 0, v29, vcc_lo
	global_load_b64 v[25:26], v[18:19], off
	v_add_co_u32 v18, vcc_lo, v28, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v19, null, 0, v29, vcc_lo
	global_load_b32 v30, v[18:19], off offset:64
	s_waitcnt vmcnt(1)
	v_and_b32_e32 v18, 0xff, v25
	v_lshlrev_b32_e32 v18, 2, v18
	global_load_b32 v22, v18, s[4:5]
	v_lshrrev_b32_e32 v18, 6, v25
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	v_and_b32_e32 v18, 0x3fc, v18
	global_load_b32 v23, v18, s[4:5]
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v18, 0xff, v30
	v_bcnt_u32_b32 v19, v18, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v19, 1, v19
	v_lshlrev_b32_e32 v19, 7, v19
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v18, v19, v18
	v_mul_lo_u32 v24, 0x1010101, v18
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b32_e32 v18, 0x8040201, v24
	v_bfe_i32 v20, v24, 0, 1
	v_lshrrev_b32_e32 v19, 24, v18
	v_lshrrev_b16 v18.l, 8, v18.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cmp_ne_u16_e64 s0, 0, v19.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v18.l
	v_lshrrev_b32_e32 v18, 18, v24
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v19, 0, -1, s0
	v_cndmask_b32_e64 v21, 0, -1, vcc_lo
	v_bfe_i32 v18, v18, 0, 1
	v_mov_b16_e32 v21.h, v31.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b16 v19.l, 8, v19.l
	v_lshlrev_b16 v19.h, 8, v21.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b16 v18.h, 0xff, v18.l
	v_lshlrev_b16 v18.l, 8, v18.l
	v_or_b16 v31.h, v18.h, v19.l
	v_and_b16 v18.h, 0xff, v20.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v21.l, v18.h, v19.h
	v_or_b32_e32 v21, v21, v31
	s_waitcnt vmcnt(1)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v21, v22, v21
	v_and_b16 v18.h, 0xff00, v21.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v22.l, v18.h, v19.h clamp
	v_lshlrev_b16 v18.h, 8, v21.l
	v_lshlrev_b16 v19.h, 8, v20.l
	v_sub_nc_i16 v20.l, v18.h, v19.h clamp
	v_and_b16 v18.h, 0xff00, v21.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v20, v20, v22, 0xc0c0105
	v_sub_nc_i16 v19.l, v18.h, v19.l clamp
	v_lshlrev_b16 v18.h, 8, v21.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v18.l, v18.h, v18.l clamp
	v_perm_b32 v18, v18, v19, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v18, v18, 16, v20
	v_and_b32_e32 v20, 0x80402010, v24
	v_lshrrev_b32_e32 v21, 24, v20
	v_lshrrev_b16 v19.l, 8, v20.l
	v_lshrrev_b16 v22.l, 4, v20.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e64 s0, 0, v21.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v19.l
	v_lshrrev_b32_e32 v19, 22, v24
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v20, 0, -1, s0
	v_cndmask_b32_e64 v21, 0, -1, vcc_lo
	v_bfe_i32 v19, v19, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshlrev_b16 v20.l, 8, v20.l
	v_and_b16 v19.h, 0xff, v19.l
	v_lshlrev_b16 v19.l, 8, v19.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_or_b16 v31.h, v19.h, v20.l
	v_lshlrev_b16 v19.h, 8, v21.l
	v_bfe_i32 v21, v22, 0, 1
	v_mov_b16_e32 v22.h, v31.l
	v_and_b16 v20.h, 0xff, v21.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v22.l, v20.h, v19.h
	v_or_b32_e32 v22, v22, v31
	s_waitcnt vmcnt(0)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v22, v23, v22
	v_and_b16 v20.h, 0xff00, v22.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v23.l, v20.h, v19.h clamp
	v_lshlrev_b16 v19.h, 8, v22.l
	v_lshlrev_b16 v20.h, 8, v21.l
	v_sub_nc_i16 v21.l, v19.h, v20.h clamp
	v_and_b16 v19.h, 0xff00, v22.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v21, v21, v23, 0xc0c0105
	v_sub_nc_i16 v20.l, v19.h, v20.l clamp
	v_lshlrev_b16 v19.h, 8, v22.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v19.l, v19.h, v19.l clamp
	v_perm_b32 v19, v19, v20, 0xc0c0105
	v_lshrrev_b32_e32 v20, 14, v25
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshl_or_b32 v19, v19, 16, v21
	v_and_b32_e32 v20, 0x3fc, v20
	global_load_b32 v24, v20, s[4:5]
	v_lshrrev_b32_e32 v20, 22, v25
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_and_b32_e32 v20, 0x3fc, v20
	global_load_b32 v25, v20, s[4:5]
	v_bfe_u32 v20, v30, 7, 8
	v_bcnt_u32_b32 v21, v20, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v21, 1, v21
	v_lshlrev_b32_e32 v21, 7, v21
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v20, v21, v20
	v_mul_lo_u32 v27, 0x1010101, v20
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b32_e32 v20, 0x8040201, v27
	v_bfe_i32 v22, v27, 0, 1
	v_lshrrev_b32_e32 v21, 24, v20
	v_lshrrev_b16 v20.l, 8, v20.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cmp_ne_u16_e64 s0, 0, v21.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v20.l
	v_lshrrev_b32_e32 v20, 18, v27
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v21, 0, -1, s0
	v_cndmask_b32_e64 v23, 0, -1, vcc_lo
	v_bfe_i32 v20, v20, 0, 1
	v_mov_b16_e32 v23.h, v31.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b16 v21.l, 8, v21.l
	v_lshlrev_b16 v21.h, 8, v23.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b16 v20.h, 0xff, v20.l
	v_lshlrev_b16 v20.l, 8, v20.l
	v_or_b16 v31.h, v20.h, v21.l
	v_and_b16 v20.h, 0xff, v22.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v23.l, v20.h, v21.h
	v_or_b32_e32 v23, v23, v31
	s_waitcnt vmcnt(1)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v23, v24, v23
	v_and_b16 v20.h, 0xff00, v23.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v24.l, v20.h, v21.h clamp
	v_lshlrev_b16 v20.h, 8, v23.l
	v_lshlrev_b16 v21.h, 8, v22.l
	v_sub_nc_i16 v22.l, v20.h, v21.h clamp
	v_and_b16 v20.h, 0xff00, v23.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v22, v22, v24, 0xc0c0105
	v_sub_nc_i16 v21.l, v20.h, v21.l clamp
	v_lshlrev_b16 v20.h, 8, v23.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v20.l, v20.h, v20.l clamp
	v_perm_b32 v20, v20, v21, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v20, v20, 16, v22
	v_and_b32_e32 v22, 0x80402010, v27
	v_lshrrev_b32_e32 v23, 24, v22
	v_lshrrev_b16 v21.l, 8, v22.l
	v_lshrrev_b16 v24.l, 4, v22.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e64 s0, 0, v23.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.l
	v_lshrrev_b32_e32 v21, 22, v27
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v22, 0, -1, s0
	v_cndmask_b32_e64 v23, 0, -1, vcc_lo
	v_bfe_i32 v21, v21, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshlrev_b16 v22.l, 8, v22.l
	v_and_b16 v21.h, 0xff, v21.l
	v_lshlrev_b16 v21.l, 8, v21.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_or_b16 v31.h, v21.h, v22.l
	v_lshlrev_b16 v21.h, 8, v23.l
	v_bfe_i32 v23, v24, 0, 1
	v_mov_b16_e32 v24.h, v31.l
	v_and_b16 v22.h, 0xff, v23.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v24.l, v22.h, v21.h
	v_or_b32_e32 v24, v24, v31
	s_waitcnt vmcnt(0)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v24, v25, v24
	v_and_b16 v22.h, 0xff00, v24.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v25.l, v22.h, v21.h clamp
	v_lshlrev_b16 v21.h, 8, v24.l
	v_lshlrev_b16 v22.h, 8, v23.l
	v_sub_nc_i16 v23.l, v21.h, v22.h clamp
	v_and_b16 v21.h, 0xff00, v24.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v23, v23, v25, 0xc0c0105
	v_sub_nc_i16 v22.l, v21.h, v22.l clamp
	v_lshlrev_b16 v21.h, 8, v24.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v21.l, v21.h, v21.l clamp
	v_perm_b32 v21, v21, v22, 0xc0c0105
	v_and_b32_e32 v22, 0xff, v26
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshl_or_b32 v21, v21, 16, v23
	v_lshlrev_b32_e32 v22, 2, v22
	global_load_b32 v27, v22, s[4:5]
	v_lshrrev_b32_e32 v22, 6, v26
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_and_b32_e32 v22, 0x3fc, v22
	global_load_b32 v32, v22, s[4:5]
	v_bfe_u32 v22, v30, 14, 8
	v_bcnt_u32_b32 v23, v22, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v23, 1, v23
	v_lshlrev_b32_e32 v23, 7, v23
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v22, v23, v22
	v_mul_lo_u32 v33, 0x1010101, v22
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b32_e32 v22, 0x8040201, v33
	v_bfe_i32 v24, v33, 0, 1
	v_lshrrev_b32_e32 v23, 24, v22
	v_lshrrev_b16 v22.l, 8, v22.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cmp_ne_u16_e64 s0, 0, v23.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v22.l
	v_lshrrev_b32_e32 v22, 18, v33
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v23, 0, -1, s0
	v_cndmask_b32_e64 v25, 0, -1, vcc_lo
	v_bfe_i32 v22, v22, 0, 1
	v_mov_b16_e32 v25.h, v31.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b16 v23.l, 8, v23.l
	v_lshlrev_b16 v23.h, 8, v25.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b16 v22.h, 0xff, v22.l
	v_lshlrev_b16 v22.l, 8, v22.l
	v_or_b16 v31.h, v22.h, v23.l
	v_and_b16 v22.h, 0xff, v24.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v25.l, v22.h, v23.h
	v_or_b32_e32 v25, v25, v31
	s_waitcnt vmcnt(1)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v25, v27, v25
	v_and_b16 v22.h, 0xff00, v25.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v27.l, v22.h, v23.h clamp
	v_lshlrev_b16 v22.h, 8, v25.l
	v_lshlrev_b16 v23.h, 8, v24.l
	v_sub_nc_i16 v24.l, v22.h, v23.h clamp
	v_and_b16 v22.h, 0xff00, v25.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v24, v24, v27, 0xc0c0105
	v_sub_nc_i16 v23.l, v22.h, v23.l clamp
	v_lshlrev_b16 v22.h, 8, v25.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v22.l, v22.h, v22.l clamp
	v_perm_b32 v22, v22, v23, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v22, v22, 16, v24
	v_and_b32_e32 v24, 0x80402010, v33
	v_lshrrev_b32_e32 v25, 24, v24
	v_lshrrev_b16 v23.l, 8, v24.l
	v_lshrrev_b16 v27.l, 4, v24.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e64 s0, 0, v25.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v23.l
	v_lshrrev_b32_e32 v23, 22, v33
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v24, 0, -1, s0
	v_cndmask_b32_e64 v25, 0, -1, vcc_lo
	v_bfe_i32 v23, v23, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshlrev_b16 v24.l, 8, v24.l
	v_and_b16 v23.h, 0xff, v23.l
	v_lshlrev_b16 v23.l, 8, v23.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_or_b16 v31.h, v23.h, v24.l
	v_lshlrev_b16 v23.h, 8, v25.l
	v_bfe_i32 v25, v27, 0, 1
	v_mov_b16_e32 v27.h, v31.l
	v_and_b16 v24.h, 0xff, v25.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v27.l, v24.h, v23.h
	v_or_b32_e32 v27, v27, v31
	s_waitcnt vmcnt(0)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v27, v32, v27
	v_and_b16 v24.h, 0xff00, v27.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v32.l, v24.h, v23.h clamp
	v_lshlrev_b16 v23.h, 8, v27.l
	v_lshlrev_b16 v24.h, 8, v25.l
	v_sub_nc_i16 v25.l, v23.h, v24.h clamp
	v_and_b16 v23.h, 0xff00, v27.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v25, v25, v32, 0xc0c0105
	v_sub_nc_i16 v24.l, v23.h, v24.l clamp
	v_lshlrev_b16 v23.h, 8, v27.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v23.l, v23.h, v23.l clamp
	v_perm_b32 v23, v23, v24, 0xc0c0105
	v_lshrrev_b32_e32 v24, 14, v26
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshl_or_b32 v23, v23, 16, v25
	v_and_b32_e32 v24, 0x3fc, v24
	global_load_b32 v32, v24, s[4:5]
	v_lshrrev_b32_e32 v24, 22, v26
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_and_b32_e32 v24, 0x3fc, v24
	global_load_b32 v33, v24, s[4:5]
	v_bfe_u32 v24, v30, 21, 8
	v_bcnt_u32_b32 v25, v24, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v25, 1, v25
	v_lshlrev_b32_e32 v25, 7, v25
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v24, v25, v24
	v_mul_lo_u32 v34, 0x1010101, v24
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b32_e32 v24, 0x8040201, v34
	v_bfe_i32 v26, v34, 0, 1
	v_lshrrev_b32_e32 v25, 24, v24
	v_lshrrev_b16 v24.l, 8, v24.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cmp_ne_u16_e64 s0, 0, v25.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v24.l
	v_lshrrev_b32_e32 v24, 18, v34
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v25, 0, -1, s0
	v_cndmask_b32_e64 v27, 0, -1, vcc_lo
	v_bfe_i32 v24, v24, 0, 1
	v_mov_b16_e32 v27.h, v31.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b16 v25.l, 8, v25.l
	v_lshlrev_b16 v25.h, 8, v27.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b16 v24.h, 0xff, v24.l
	v_lshlrev_b16 v24.l, 8, v24.l
	v_or_b16 v31.h, v24.h, v25.l
	v_and_b16 v24.h, 0xff, v26.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v27.l, v24.h, v25.h
	v_or_b32_e32 v27, v27, v31
	s_waitcnt vmcnt(1)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v27, v32, v27
	v_and_b16 v24.h, 0xff00, v27.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v32.l, v24.h, v25.h clamp
	v_lshlrev_b16 v24.h, 8, v27.l
	v_lshlrev_b16 v25.h, 8, v26.l
	v_sub_nc_i16 v26.l, v24.h, v25.h clamp
	v_and_b16 v24.h, 0xff00, v27.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v26, v26, v32, 0xc0c0105
	v_sub_nc_i16 v25.l, v24.h, v25.l clamp
	v_lshlrev_b16 v24.h, 8, v27.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v24.l, v24.h, v24.l clamp
	v_perm_b32 v24, v24, v25, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v25, v24, 16, v26
	v_and_b32_e32 v26, 0x80402010, v34
	v_lshrrev_b32_e32 v27, 24, v26
	v_lshrrev_b16 v24.l, 8, v26.l
	v_lshrrev_b16 v32.l, 4, v26.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e64 s0, 0, v27.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v24.l
	v_lshrrev_b32_e32 v24, 22, v34
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v26, 0, -1, s0
	v_cndmask_b32_e64 v27, 0, -1, vcc_lo
	v_bfe_i32 v24, v24, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshlrev_b16 v26.l, 8, v26.l
	v_and_b16 v24.h, 0xff, v24.l
	v_lshlrev_b16 v24.l, 8, v24.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_or_b16 v31.h, v24.h, v26.l
	v_lshlrev_b16 v24.h, 8, v27.l
	v_bfe_i32 v27, v32, 0, 1
	v_mov_b16_e32 v32.h, v31.l
	v_and_b16 v26.h, 0xff, v27.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v32.l, v26.h, v24.h
	v_or_b32_e32 v31, v32, v31
	s_waitcnt vmcnt(0)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v31, v33, v31
	v_and_b16 v26.h, 0xff00, v31.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v32.l, v26.h, v24.h clamp
	v_lshlrev_b16 v24.h, 8, v31.l
	v_lshlrev_b16 v26.h, 8, v27.l
	v_sub_nc_i16 v27.l, v24.h, v26.h clamp
	v_and_b16 v24.h, 0xff00, v31.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v27, v27, v32, 0xc0c0105
	v_sub_nc_i16 v26.l, v24.h, v26.l clamp
	v_lshlrev_b16 v24.h, 8, v31.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v24.l, v24.h, v24.l clamp
	v_perm_b32 v24, v24, v26, 0xc0c0105
	v_lshrrev_b32_e32 v26, 28, v30
	s_delay_alu instid0(VALU_DEP_2)
	v_lshl_or_b32 v27, v24, 16, v27
	global_load_d16_b16 v24, v[28:29], off offset:64
	s_clause 0x2
	global_load_b128 v[28:31], v[2:3], off offset:-16
	global_load_b32 v36, v[2:3], off offset:16
	global_load_b128 v[32:35], v[2:3], off
	v_add_co_u32 v2, vcc_lo, 0x480, v2
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v3, null, 0, v3, vcc_lo
	v_cmp_le_u32_e32 vcc_lo, s14, v14
	s_or_b32 s19, vcc_lo, s19
	s_waitcnt vmcnt(2)
	v_dot4_i32_iu8 v29, v18, v29, 0 neg_lo:[1,1,0]
	v_cvt_f32_f16_e32 v24, v24.l
	v_cvt_f32_f16_e32 v28, v28.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_dot4_i32_iu8 v29, v19, v30, v29 neg_lo:[1,1,0]
	v_mul_f32_e32 v28, v24, v28
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v29, v20, v31, v29 neg_lo:[1,1,0]
	s_waitcnt vmcnt(0)
	v_dot4_i32_iu8 v29, v21, v32, v29 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v29, v22, v33, v29 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v29, v23, v34, v29 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v29, v25, v35, v29 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v32, v27, v36, v29 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v29, 31, v32
	v_add_nc_u32_e32 v29, v32, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v29, 1, v29
	v_mad_u64_u32 v[30:31], null, v32, v26, v[29:30]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v29, 31, v30
	v_add_nc_u32_e32 v29, v30, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v29, 1, v29
	v_cvt_f32_i32_e32 v29, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_fmac_f32_e32 v12, v28, v29
	v_add_nc_u32_e32 v28, s10, v15
	v_mad_u64_u32 v[32:33], null, v28, 36, v[0:1]
	s_clause 0x2
	global_load_b128 v[28:31], v[32:33], off
	global_load_b32 v36, v[32:33], off offset:32
	global_load_b128 v[32:35], v[32:33], off offset:16
	s_waitcnt vmcnt(2)
	v_dot4_i32_iu8 v29, v18, v29, 0 neg_lo:[1,1,0]
	v_cvt_f32_f16_e32 v28, v28.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_dot4_i32_iu8 v29, v19, v30, v29 neg_lo:[1,1,0]
	v_mul_f32_e32 v28, v24, v28
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v29, v20, v31, v29 neg_lo:[1,1,0]
	s_waitcnt vmcnt(0)
	v_dot4_i32_iu8 v29, v21, v32, v29 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v29, v22, v33, v29 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v29, v23, v34, v29 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v29, v25, v35, v29 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v32, v27, v36, v29 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v29, 31, v32
	v_add_nc_u32_e32 v29, v32, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v29, 1, v29
	v_mad_u64_u32 v[30:31], null, v32, v26, v[29:30]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v29, 31, v30
	v_add_nc_u32_e32 v29, v30, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v29, 1, v29
	v_cvt_f32_i32_e32 v29, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_fmac_f32 v11, v28, v29 :: v_dual_add_nc_u32 v28, s20, v15
	v_mad_u64_u32 v[32:33], null, v28, 36, v[0:1]
	s_clause 0x2
	global_load_b128 v[28:31], v[32:33], off
	global_load_b32 v36, v[32:33], off offset:32
	global_load_b128 v[32:35], v[32:33], off offset:16
	s_waitcnt vmcnt(2)
	v_dot4_i32_iu8 v29, v18, v29, 0 neg_lo:[1,1,0]
	v_cvt_f32_f16_e32 v28, v28.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_dot4_i32_iu8 v29, v19, v30, v29 neg_lo:[1,1,0]
	v_mul_f32_e32 v28, v24, v28
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v29, v20, v31, v29 neg_lo:[1,1,0]
	s_waitcnt vmcnt(0)
	v_dot4_i32_iu8 v29, v21, v32, v29 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v29, v22, v33, v29 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v29, v23, v34, v29 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v29, v25, v35, v29 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v32, v27, v36, v29 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v29, 31, v32
	v_add_nc_u32_e32 v29, v32, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v29, 1, v29
	v_mad_u64_u32 v[30:31], null, v32, v26, v[29:30]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v29, 31, v30
	v_add_nc_u32_e32 v29, v30, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v29, 1, v29
	v_cvt_f32_i32_e32 v29, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_fmac_f32 v9, v28, v29 :: v_dual_add_nc_u32 v28, s18, v15
	v_mad_u64_u32 v[32:33], null, v28, 36, v[0:1]
	s_clause 0x2
	global_load_b128 v[28:31], v[32:33], off
	global_load_b32 v36, v[32:33], off offset:32
	global_load_b128 v[32:35], v[32:33], off offset:16
	s_waitcnt vmcnt(2)
	v_dot4_i32_iu8 v29, v18, v29, 0 neg_lo:[1,1,0]
	v_cvt_f32_f16_e32 v28, v28.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_dot4_i32_iu8 v29, v19, v30, v29 neg_lo:[1,1,0]
	v_mul_f32_e32 v28, v24, v28
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v29, v20, v31, v29 neg_lo:[1,1,0]
	s_waitcnt vmcnt(0)
	v_dot4_i32_iu8 v29, v21, v32, v29 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v29, v22, v33, v29 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v29, v23, v34, v29 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v29, v25, v35, v29 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v32, v27, v36, v29 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v29, 31, v32
	v_add_nc_u32_e32 v29, v32, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v29, 1, v29
	v_mad_u64_u32 v[30:31], null, v32, v26, v[29:30]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v29, 31, v30
	v_add_nc_u32_e32 v29, v30, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v29, 1, v29
	v_cvt_f32_i32_e32 v29, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_fmac_f32_e32 v8, v28, v29
	v_add_nc_u32_e32 v28, s17, v15
	v_mad_u64_u32 v[32:33], null, v28, 36, v[0:1]
	s_clause 0x2
	global_load_b128 v[28:31], v[32:33], off
	global_load_b32 v36, v[32:33], off offset:32
	global_load_b128 v[32:35], v[32:33], off offset:16
	s_waitcnt vmcnt(2)
	v_dot4_i32_iu8 v29, v18, v29, 0 neg_lo:[1,1,0]
	v_cvt_f32_f16_e32 v28, v28.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_dot4_i32_iu8 v29, v19, v30, v29 neg_lo:[1,1,0]
	v_mul_f32_e32 v28, v24, v28
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v29, v20, v31, v29 neg_lo:[1,1,0]
	s_waitcnt vmcnt(0)
	v_dot4_i32_iu8 v29, v21, v32, v29 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v29, v22, v33, v29 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v29, v23, v34, v29 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v29, v25, v35, v29 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v32, v27, v36, v29 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v29, 31, v32
	v_add_nc_u32_e32 v29, v32, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v29, 1, v29
	v_mad_u64_u32 v[30:31], null, v32, v26, v[29:30]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v29, 31, v30
	v_add_nc_u32_e32 v29, v30, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v29, 1, v29
	v_cvt_f32_i32_e32 v29, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_fmac_f32 v7, v28, v29 :: v_dual_add_nc_u32 v28, s16, v15
	v_mad_u64_u32 v[32:33], null, v28, 36, v[0:1]
	s_clause 0x2
	global_load_b128 v[28:31], v[32:33], off
	global_load_b32 v36, v[32:33], off offset:32
	global_load_b128 v[32:35], v[32:33], off offset:16
	s_waitcnt vmcnt(2)
	v_dot4_i32_iu8 v29, v18, v29, 0 neg_lo:[1,1,0]
	v_cvt_f32_f16_e32 v28, v28.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_dot4_i32_iu8 v29, v19, v30, v29 neg_lo:[1,1,0]
	v_mul_f32_e32 v28, v24, v28
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v29, v20, v31, v29 neg_lo:[1,1,0]
	s_waitcnt vmcnt(0)
	v_dot4_i32_iu8 v29, v21, v32, v29 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v29, v22, v33, v29 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v29, v23, v34, v29 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v29, v25, v35, v29 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v32, v27, v36, v29 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v29, 31, v32
	v_add_nc_u32_e32 v29, v32, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v29, 1, v29
	v_mad_u64_u32 v[30:31], null, v32, v26, v[29:30]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v29, 31, v30
	v_add_nc_u32_e32 v29, v30, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v29, 1, v29
	v_cvt_f32_i32_e32 v29, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_fmac_f32_e32 v6, v28, v29
	v_add_nc_u32_e32 v28, s15, v15
	v_mad_u64_u32 v[32:33], null, v28, 36, v[0:1]
	s_clause 0x2
	global_load_b128 v[28:31], v[32:33], off
	global_load_b32 v36, v[32:33], off offset:32
	global_load_b128 v[32:35], v[32:33], off offset:16
	s_waitcnt vmcnt(2)
	v_dot4_i32_iu8 v29, v18, v29, 0 neg_lo:[1,1,0]
	v_cvt_f32_f16_e32 v28, v28.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_dot4_i32_iu8 v29, v19, v30, v29 neg_lo:[1,1,0]
	v_mul_f32_e32 v28, v24, v28
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v29, v20, v31, v29 neg_lo:[1,1,0]
	s_waitcnt vmcnt(0)
	v_dot4_i32_iu8 v29, v21, v32, v29 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v29, v22, v33, v29 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v29, v23, v34, v29 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v29, v25, v35, v29 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v32, v27, v36, v29 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v29, 31, v32
	v_add_nc_u32_e32 v29, v32, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v29, 1, v29
	v_mad_u64_u32 v[30:31], null, v32, v26, v[29:30]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v29, 31, v30
	v_add_nc_u32_e32 v29, v30, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v29, 1, v29
	v_cvt_f32_i32_e32 v29, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_dual_fmac_f32 v5, v28, v29 :: v_dual_add_nc_u32 v28, s9, v15
	v_add_nc_u32_e32 v15, 32, v15
	v_mad_u64_u32 v[32:33], null, v28, 36, v[0:1]
	s_clause 0x2
	global_load_b128 v[28:31], v[32:33], off
	global_load_b32 v36, v[32:33], off offset:32
	global_load_b128 v[32:35], v[32:33], off offset:16
	s_waitcnt vmcnt(2)
	v_dot4_i32_iu8 v18, v18, v29, 0 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v18, v19, v30, v18 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v18, v20, v31, v18 neg_lo:[1,1,0]
	s_waitcnt vmcnt(0)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v18, v21, v32, v18 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v18, v22, v33, v18 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v18, v23, v34, v18 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v18, v25, v35, v18 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v21, v27, v36, v18 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v18, 31, v21
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v18, v21, v18
	v_ashrrev_i32_e32 v18, 1, v18
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mad_u64_u32 v[19:20], null, v21, v26, v[18:19]
	v_lshrrev_b32_e32 v18, 31, v19
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_nc_u32_e32 v18, v19, v18
	v_cvt_f32_f16_e32 v19, v28.l
	v_ashrrev_i32_e32 v18, 1, v18
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_f32_e32 v19, v24, v19
	v_cvt_f32_i32_e32 v18, v18
	s_delay_alu instid0(VALU_DEP_1)
	v_fmac_f32_e32 v4, v19, v18
	s_and_not1_b32 exec_lo, exec_lo, s19
	s_cbranch_execnz .LBB4_2
; %bb.3:
	s_or_b32 exec_lo, exec_lo, s19
.LBB4_4:
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s8
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v13
	v_cmpx_ne_u32_e32 0, v13
	s_cbranch_execz .LBB4_6
; %bb.5:
	v_lshlrev_b32_e32 v0, 10, v13
	v_lshlrev_b32_e32 v1, 2, v10
	s_delay_alu instid0(VALU_DEP_1)
	v_add3_u32 v0, v0, v1, 0xfffffc00
	ds_store_2addr_b32 v0, v12, v11 offset1:32
	ds_store_2addr_b32 v0, v9, v8 offset0:64 offset1:96
	ds_store_2addr_b32 v0, v7, v6 offset0:128 offset1:160
	ds_store_2addr_b32 v0, v5, v4 offset0:192 offset1:224
.LBB4_6:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB4_35
; %bb.7:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB4_9
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB4_10
	s_branch .LBB4_30
.LBB4_9:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB4_30
.LBB4_10:
	v_mbcnt_lo_u32_b32 v0, -1, 0
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_xor_b32_e32 v1, 16, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v1
	v_cndmask_b32_e32 v1, v0, v1, vcc_lo
	v_lshlrev_b32_e32 v1, 2, v1
	ds_bpermute_b32 v2, v1, v12
	s_cbranch_scc0 .LBB4_12
; %bb.11:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB4_13
	s_branch .LBB4_30
.LBB4_12:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB4_30
.LBB4_13:
	v_xor_b32_e32 v3, 8, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v3
	v_cndmask_b32_e32 v13, v0, v3, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v3, v12, v2 :: v_dual_lshlrev_b32 v2, 2, v13
	ds_bpermute_b32 v12, v2, v3
	s_cbranch_scc0 .LBB4_15
; %bb.14:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB4_16
	s_branch .LBB4_30
.LBB4_15:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB4_30
.LBB4_16:
	v_xor_b32_e32 v13, 4, v0
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v12, v3, v12
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v13
	v_cndmask_b32_e32 v13, v0, v13, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v3, 2, v13
	ds_bpermute_b32 v13, v3, v12
	s_cbranch_scc0 .LBB4_18
; %bb.17:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB4_19
	s_branch .LBB4_30
.LBB4_18:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB4_30
.LBB4_19:
	v_xor_b32_e32 v14, 2, v0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v14
	v_cndmask_b32_e32 v14, v0, v14, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v13, v12, v13 :: v_dual_lshlrev_b32 v12, 2, v14
	ds_bpermute_b32 v14, v12, v13
	s_cbranch_scc0 .LBB4_21
; %bb.20:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_branch .LBB4_22
.LBB4_21:
	s_mov_b32 s0, -1
	s_mov_b32 s5, 0
.LBB4_22:
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB4_30
; %bb.23:
	v_xor_b32_e32 v15, 1, v0
	s_mul_i32 s4, s11, s3
	s_mov_b32 s5, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v13, v13, v14
	s_lshl_b64 s[0:1], s[4:5], 2
	v_cmp_gt_i32_e32 vcc_lo, 32, v15
	s_add_u32 s4, s6, s0
	s_addc_u32 s6, s7, s1
	s_ashr_i32 s3, s2, 31
	v_cndmask_b32_e32 v0, v0, v15, vcc_lo
	s_lshl_b64 s[0:1], s[2:3], 2
	v_cmp_eq_u32_e64 s2, 0, v10
	s_add_u32 s0, s4, s0
	s_addc_u32 s1, s6, s1
	v_lshlrev_b32_e32 v0, 2, v0
	ds_bpermute_b32 v14, v0, v13
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB4_25
; %bb.24:
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v10, v13, v14 :: v_dual_mov_b32 v13, 0
	global_store_b32 v13, v10, s[0:1]
.LBB4_25:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_27
; %bb.26:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
.LBB4_27:
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_40
; %bb.28:
	ds_bpermute_b32 v10, v1, v11
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB4_41
; %bb.29:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_42
.LBB4_30:
                                        ; implicit-def: $sgpr2
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $sgpr0_sgpr1
                                        ; implicit-def: $vgpr3
.LBB4_31:
	s_and_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB4_36
; %bb.32:
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB4_35
.LBB4_33:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v2, v1
	ds_bpermute_b32 v0, v0, v1
	s_and_b32 exec_lo, exec_lo, s2
	s_cbranch_execz .LBB4_35
; %bb.34:
	v_mul_lo_u32 v2, v3, 7
	s_waitcnt lgkmcnt(0)
	v_dual_mov_b32 v3, 0 :: v_dual_add_f32 v4, v1, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64 v[2:3], 2, v[2:3]
	v_add_co_u32 v0, vcc_lo, s0, v2
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v1, null, s1, v3, vcc_lo
	global_store_b32 v[0:1], v4, off
.LBB4_35:
	s_endpgm
.LBB4_36:
	s_cbranch_execnz .LBB4_38
; %bb.37:
	; divergent unreachable
	s_cbranch_execz .LBB4_33
	s_branch .LBB4_35
.LBB4_38:
	s_trap 2
	s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)
	s_mov_b32 ttmp2, m0
	s_waitcnt lgkmcnt(0)
	s_and_b32 s0, s0, 0x3ff
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_bitset1_b32 s0, 10
	s_mov_b32 m0, s0
	s_sendmsg sendmsg(MSG_INTERRUPT)
	s_mov_b32 m0, ttmp2
.LBB4_39:                               ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB4_39
.LBB4_40:
	s_mov_b32 s4, 0
	s_branch .LBB4_185
.LBB4_41:
	s_mov_b32 s5, 0
.LBB4_42:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.43:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v10, v11, v10
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v11, v2, v10
	s_cbranch_scc0 .LBB4_45
; %bb.44:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_46
.LBB4_45:
	s_mov_b32 s5, 0
.LBB4_46:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.47:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v10, v10, v11
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v11, v3, v10
	s_cbranch_scc0 .LBB4_49
; %bb.48:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_50
.LBB4_49:
	s_mov_b32 s5, 0
.LBB4_50:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.51:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v10, v10, v11
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v11, v12, v10
	s_cbranch_scc0 .LBB4_53
; %bb.52:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_54
.LBB4_53:
	s_mov_b32 s5, 0
.LBB4_54:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.55:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v10, v10, v11
	ds_bpermute_b32 v11, v0, v10
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB4_57
; %bb.56:
	s_mov_b32 s5, 0
	s_mov_b32 s4, s11
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v10, v10, v11 :: v_dual_mov_b32 v11, 0
	s_lshl_b64 s[4:5], s[4:5], 2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_add_u32 s4, s0, s4
	s_addc_u32 s5, s1, s5
	global_store_b32 v11, v10, s[4:5]
.LBB4_57:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_59
; %bb.58:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_60
.LBB4_59:
	s_mov_b32 s5, 0
.LBB4_60:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.61:
	ds_bpermute_b32 v10, v1, v9
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB4_63
; %bb.62:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_64
.LBB4_63:
	s_mov_b32 s5, 0
.LBB4_64:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.65:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v9, v9, v10
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v10, v2, v9
	s_cbranch_scc0 .LBB4_67
; %bb.66:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_68
.LBB4_67:
	s_mov_b32 s5, 0
.LBB4_68:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.69:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v9, v9, v10
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v10, v3, v9
	s_cbranch_scc0 .LBB4_71
; %bb.70:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_72
.LBB4_71:
	s_mov_b32 s5, 0
.LBB4_72:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.73:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v9, v9, v10
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v10, v12, v9
	s_cbranch_scc0 .LBB4_75
; %bb.74:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_76
.LBB4_75:
	s_mov_b32 s5, 0
.LBB4_76:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.77:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v9, v9, v10
	ds_bpermute_b32 v10, v0, v9
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB4_79
; %bb.78:
	s_lshl_b32 s4, s11, 1
	s_mov_b32 s5, 0
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v9, v9, v10 :: v_dual_mov_b32 v10, 0
	s_lshl_b64 s[4:5], s[4:5], 2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_add_u32 s4, s0, s4
	s_addc_u32 s5, s1, s5
	global_store_b32 v10, v9, s[4:5]
.LBB4_79:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_81
; %bb.80:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_82
.LBB4_81:
	s_mov_b32 s5, 0
.LBB4_82:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.83:
	ds_bpermute_b32 v9, v1, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB4_85
; %bb.84:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_86
.LBB4_85:
	s_mov_b32 s5, 0
.LBB4_86:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.87:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v8, v8, v9
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v9, v2, v8
	s_cbranch_scc0 .LBB4_89
; %bb.88:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_90
.LBB4_89:
	s_mov_b32 s5, 0
.LBB4_90:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.91:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v8, v8, v9
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v9, v3, v8
	s_cbranch_scc0 .LBB4_93
; %bb.92:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_94
.LBB4_93:
	s_mov_b32 s5, 0
.LBB4_94:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.95:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v8, v8, v9
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v9, v12, v8
	s_cbranch_scc0 .LBB4_97
; %bb.96:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_98
.LBB4_97:
	s_mov_b32 s5, 0
.LBB4_98:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.99:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v8, v8, v9
	ds_bpermute_b32 v9, v0, v8
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB4_101
; %bb.100:
	s_mul_i32 s4, s11, 3
	s_mov_b32 s5, 0
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v8, v8, v9 :: v_dual_mov_b32 v9, 0
	s_lshl_b64 s[4:5], s[4:5], 2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_add_u32 s4, s0, s4
	s_addc_u32 s5, s1, s5
	global_store_b32 v9, v8, s[4:5]
.LBB4_101:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_103
; %bb.102:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_104
.LBB4_103:
	s_mov_b32 s5, 0
.LBB4_104:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.105:
	ds_bpermute_b32 v8, v1, v7
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB4_107
; %bb.106:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_108
.LBB4_107:
	s_mov_b32 s5, 0
.LBB4_108:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.109:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v2, v7
	s_cbranch_scc0 .LBB4_111
; %bb.110:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_112
.LBB4_111:
	s_mov_b32 s5, 0
.LBB4_112:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.113:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v3, v7
	s_cbranch_scc0 .LBB4_115
; %bb.114:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_116
.LBB4_115:
	s_mov_b32 s5, 0
.LBB4_116:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.117:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v12, v7
	s_cbranch_scc0 .LBB4_119
; %bb.118:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_120
.LBB4_119:
	s_mov_b32 s5, 0
.LBB4_120:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.121:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	ds_bpermute_b32 v8, v0, v7
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB4_123
; %bb.122:
	s_lshl_b32 s4, s11, 2
	s_mov_b32 s5, 0
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v7, v7, v8 :: v_dual_mov_b32 v8, 0
	s_lshl_b64 s[4:5], s[4:5], 2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_add_u32 s4, s0, s4
	s_addc_u32 s5, s1, s5
	global_store_b32 v8, v7, s[4:5]
.LBB4_123:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_125
; %bb.124:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_126
.LBB4_125:
	s_mov_b32 s5, 0
.LBB4_126:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.127:
	ds_bpermute_b32 v7, v1, v6
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB4_129
; %bb.128:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_130
.LBB4_129:
	s_mov_b32 s5, 0
.LBB4_130:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.131:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v6, v6, v7
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v7, v2, v6
	s_cbranch_scc0 .LBB4_133
; %bb.132:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_134
.LBB4_133:
	s_mov_b32 s5, 0
.LBB4_134:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.135:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v6, v6, v7
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v7, v3, v6
	s_cbranch_scc0 .LBB4_137
; %bb.136:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_138
.LBB4_137:
	s_mov_b32 s5, 0
.LBB4_138:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.139:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v6, v6, v7
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v7, v12, v6
	s_cbranch_scc0 .LBB4_141
; %bb.140:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_142
.LBB4_141:
	s_mov_b32 s5, 0
.LBB4_142:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.143:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v6, v6, v7
	ds_bpermute_b32 v7, v0, v6
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB4_145
; %bb.144:
	s_mul_i32 s4, s11, 5
	s_mov_b32 s5, 0
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v6, v6, v7 :: v_dual_mov_b32 v7, 0
	s_lshl_b64 s[4:5], s[4:5], 2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_add_u32 s4, s0, s4
	s_addc_u32 s5, s1, s5
	global_store_b32 v7, v6, s[4:5]
.LBB4_145:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_147
; %bb.146:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_148
.LBB4_147:
	s_mov_b32 s5, 0
.LBB4_148:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.149:
	ds_bpermute_b32 v6, v1, v5
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB4_151
; %bb.150:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_152
.LBB4_151:
	s_mov_b32 s5, 0
.LBB4_152:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.153:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v5, v5, v6
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v6, v2, v5
	s_cbranch_scc0 .LBB4_155
; %bb.154:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_156
.LBB4_155:
	s_mov_b32 s5, 0
.LBB4_156:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.157:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v5, v5, v6
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v6, v3, v5
	s_cbranch_scc0 .LBB4_159
; %bb.158:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_160
.LBB4_159:
	s_mov_b32 s5, 0
.LBB4_160:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.161:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v5, v5, v6
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v6, v12, v5
	s_cbranch_scc0 .LBB4_163
; %bb.162:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_164
.LBB4_163:
	s_mov_b32 s5, 0
.LBB4_164:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.165:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v5, v5, v6
	ds_bpermute_b32 v6, v0, v5
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB4_167
; %bb.166:
	s_mul_i32 s4, s11, 6
	s_mov_b32 s5, 0
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v5, v5, v6 :: v_dual_mov_b32 v6, 0
	s_lshl_b64 s[4:5], s[4:5], 2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_add_u32 s4, s0, s4
	s_addc_u32 s5, s1, s5
	global_store_b32 v6, v5, s[4:5]
.LBB4_167:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_169
; %bb.168:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_170
.LBB4_169:
	s_mov_b32 s5, 0
.LBB4_170:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.171:
	ds_bpermute_b32 v1, v1, v4
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB4_173
; %bb.172:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_174
.LBB4_173:
	s_mov_b32 s5, 0
.LBB4_174:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.175:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v4, v1
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v2, v1
	s_cbranch_scc0 .LBB4_177
; %bb.176:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_178
.LBB4_177:
	s_mov_b32 s5, 0
.LBB4_178:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.179:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v3, v1
	s_cbranch_scc0 .LBB4_181
; %bb.180:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB4_182
.LBB4_181:
	s_mov_b32 s5, 0
.LBB4_182:
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB4_185
; %bb.183:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s5, 0
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v1, v12, v2
	s_cbranch_scc0 .LBB4_186
; %bb.184:
	s_cmp_lg_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	v_mov_b32_e32 v3, s11
	s_branch .LBB4_31
.LBB4_185:
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr2
.LBB4_186:
	v_mov_b32_e32 v3, s11
	s_branch .LBB4_31
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
		.amdhsa_group_segment_fixed_size 1024
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 48
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 1
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 1
		.amdhsa_next_free_vgpr 37
		.amdhsa_next_free_sgpr 21
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_dx10_clamp 1
		.amdhsa_ieee_mode 1
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_shared_vgpr_count 0
		.amdhsa_inst_pref_size 63
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end4:
	.size	_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj, .Lfunc_end4-_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.num_vgpr, 37
	.set _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 21
	.set _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 8080
; TotalNumSgprs: 23
; NumVgprs: 37
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 1024 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 4
; NumSGPRsForWavesPerEU: 23
; NumVGPRsForWavesPerEU: 37
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_clause 0x1
	s_load_b128 s[12:15], s[0:1], 0x20
	s_load_b256 s[4:11], s[0:1], 0x0
	v_bfe_u32 v17, v0, 10, 10
	v_dual_mov_b32 v15, 0 :: v_dual_and_b32 v14, 0x3ff, v0
	v_mov_b32_e32 v16, 0
	s_mov_b32 s1, exec_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v0, v17, 5, v14
	v_lshrrev_b32_e32 v18, 3, v0
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s12, s12, 8
	s_delay_alu instid0(VALU_DEP_1) | instid1(SALU_CYCLE_1)
	v_cmpx_gt_u32_e64 s12, v18
	s_cbranch_execz .LBB5_4
; %bb.1:
	v_lshl_add_u32 v0, v17, 5, v14
	s_mul_i32 s0, s14, s3
	v_and_b32_e32 v4, 7, v14
	s_mul_hi_u32 s17, s0, 36
	s_mul_i32 s16, s0, 36
	v_lshrrev_b32_e32 v2, 3, v0
	s_mul_i32 s14, s13, s2
	s_mov_b32 s13, 0
	v_dual_mov_b32 v15, 0 :: v_dual_mov_b32 v16, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mad_u64_u32 v[0:1], null, 0x120, v2, s[16:17]
	v_lshlrev_b32_e32 v2, 1, v14
	v_and_b32_e32 v5, 14, v2
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mad_u64_u32 v[2:3], null, v4, 36, v[0:1]
	v_lshlrev_b32_e32 v0, 1, v5
	v_lshlrev_b32_e32 v19, 1, v5
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v1, vcc_lo, s8, v2
	v_add_co_ci_u32_e64 v2, null, s9, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_lshlrev_b32_e32 v20, 1, v0
	v_add_co_u32 v8, vcc_lo, v1, 32
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v9, null, 0, v2, vcc_lo
.LBB5_2:                                ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v23, s14, v18
	s_getpc_b64 s[8:9]
	s_add_u32 s8, s8, _ZL11iq3xxs_grid@rel32@lo+4
	s_addc_u32 s9, s9, _ZL11iq3xxs_grid@rel32@hi+12
	v_mov_b16_e32 v21.l, 0
	v_add_nc_u32_e32 v18, 4, v18
	v_mad_i64_i32 v[10:11], null, 0x42, v23, s[4:5]
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mov_b16_e32 v32.h, v21.l
	v_add_co_u32 v0, vcc_lo, v10, v20
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v1, null, 0, v11, vcc_lo
	global_load_b64 v[12:13], v[0:1], off
	v_add_co_u32 v0, vcc_lo, v10, v19
	v_add_co_ci_u32_e64 v1, null, 0, v11, vcc_lo
	global_load_b32 v24, v[0:1], off offset:64
	s_waitcnt vmcnt(1)
	v_and_b32_e32 v0, 0xff, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v0, 2, v0
	global_load_b32 v4, v0, s[8:9]
	v_lshrrev_b32_e32 v0, 6, v12
	v_and_b32_e32 v0, 0x3fc, v0
	global_load_b32 v27, v0, s[8:9]
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v0, 0xff, v24
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_bcnt_u32_b32 v1, v0, 0
	v_and_b32_e32 v1, 1, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v1, 7, v1
	v_xor_b32_e32 v0, v1, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v25, 0x1010101, v0
	v_and_b32_e32 v0, 0x8040201, v25
	v_bfe_i32 v2, v25, 0, 1
	v_and_b32_e32 v26, 0x80402010, v25
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_lshrrev_b32_e32 v1, 24, v0
	v_lshrrev_b16 v0.l, 8, v0.l
	v_lshrrev_b32_e32 v29, 24, v26
	v_lshrrev_b16 v30.l, 4, v26.l
	v_mov_b16_e32 v29.h, v21.l
	v_cmp_ne_u16_e64 s0, 0, v1.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v0.l
	v_lshrrev_b32_e32 v0, 18, v25
	v_lshrrev_b32_e32 v25, 22, v25
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_4)
	v_cndmask_b32_e64 v1, 0, -1, s0
	v_cndmask_b32_e64 v3, 0, -1, vcc_lo
	v_bfe_i32 v0, v0, 0, 1
	v_mov_b16_e32 v3.h, v21.l
	v_cmp_ne_u16_e64 s0, 0, v29.l
	v_lshlrev_b16 v1.l, 8, v1.l
	v_lshlrev_b16 v1.h, 8, v3.l
	v_and_b16 v0.h, 0xff, v0.l
	v_lshlrev_b16 v0.l, 8, v0.l
	v_bfe_i32 v25, v25, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b16 v21.h, v0.h, v1.l
	v_and_b16 v0.h, 0xff, v2.l
	v_or_b16 v3.l, v0.h, v1.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v3, v3, v21
	s_waitcnt vmcnt(1)
	v_xor_b32_e32 v3, v4, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v0.h, 0xff00, v3.l
	v_sub_nc_i16 v4.l, v0.h, v1.h clamp
	v_lshlrev_b16 v0.h, 8, v3.l
	v_lshlrev_b16 v1.h, 8, v2.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v2.l, v0.h, v1.h clamp
	v_and_b16 v0.h, 0xff00, v3.h
	v_perm_b32 v2, v2, v4, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v1.l, v0.h, v1.l clamp
	v_lshlrev_b16 v0.h, 8, v3.h
	v_sub_nc_i16 v0.l, v0.h, v0.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v0, v0, v1, 0xc0c0105
	v_lshl_or_b32 v28, v0, 16, v2
	s_clause 0x2
	global_load_b128 v[4:7], v[8:9], off offset:-32
	global_load_b32 v22, v[8:9], off
	global_load_b128 v[0:3], v[8:9], off offset:-16
	s_waitcnt vmcnt(2)
	v_lshrrev_b16 v4.h, 8, v26.l
	v_cndmask_b32_e64 v26, 0, -1, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	v_and_b16 v4.h, 0xff, v25.l
	v_lshlrev_b16 v25.h, 8, v26.l
	v_cndmask_b32_e64 v26, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_or_b16 v21.h, v4.h, v25.h
	v_lshlrev_b16 v4.h, 8, v26.l
	v_bfe_i32 v26, v30, 0, 1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v26.h, 0xff, v26.l
	v_or_b16 v29.l, v26.h, v4.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v29, v29, v21
	v_xor_b32_e32 v27, v27, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v21.h, 0xff00, v27.l
	v_sub_nc_i16 v29.l, v21.h, v4.h clamp
	v_lshlrev_b16 v4.h, 8, v27.l
	v_lshlrev_b16 v21.h, 8, v26.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_sub_nc_i16 v26.l, v4.h, v21.h clamp
	v_and_b16 v4.h, 0xff00, v27.h
	v_lshlrev_b16 v21.h, 8, v25.l
	v_perm_b32 v26, v26, v29, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v27.l, v4.h, v25.h clamp
	v_lshlrev_b16 v4.h, 8, v27.h
	v_sub_nc_i16 v25.l, v4.h, v21.h clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v25, v25, v27, 0xc0c0105
	v_lshl_or_b32 v25, v25, 16, v26
	v_dot4_i32_iu8 v26, v28, v5, 0 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_dot4_i32_iu8 v25, v25, v6, v26 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v26, 14, v12
	v_lshrrev_b32_e32 v12, 22, v12
	v_and_b32_e32 v26, 0x3fc, v26
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_4) | instid1(VALU_DEP_1)
	v_and_b32_e32 v12, 0x3fc, v12
	s_clause 0x1
	global_load_b32 v28, v26, s[8:9]
	global_load_b32 v29, v12, s[8:9]
	v_bfe_u32 v12, v24, 7, 8
	v_bcnt_u32_b32 v26, v12, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v26, 1, v26
	v_lshlrev_b32_e32 v26, 7, v26
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v12, v26, v12
	v_mul_lo_u32 v30, 0x1010101, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v12, 0x8040201, v30
	v_lshrrev_b32_e32 v26, 24, v12
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b32_e32 v12, 18, v30
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e64 s0, 0, v26.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_bfe_i32 v12, v12, 0, 1
	v_cndmask_b32_e64 v26, 0, -1, s0
	v_cndmask_b32_e64 v27, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_3)
	v_and_b16 v4.h, 0xff, v12.l
	v_mov_b16_e32 v27.h, v21.l
	v_lshlrev_b16 v12.l, 8, v12.l
	v_lshlrev_b16 v12.h, 8, v26.l
	v_bfe_i32 v26, v30, 0, 1
	v_lshlrev_b16 v26.h, 8, v27.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_or_b16 v21.h, v4.h, v12.h
	v_and_b16 v4.h, 0xff, v26.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v27.l, v4.h, v26.h
	v_or_b32_e32 v27, v27, v21
	v_lshlrev_b16 v21.h, 8, v26.l
	s_waitcnt vmcnt(1)
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v27, v28, v27
	v_and_b16 v4.h, 0xff00, v27.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v28.l, v4.h, v26.h clamp
	v_lshlrev_b16 v4.h, 8, v27.l
	v_sub_nc_i16 v26.l, v4.h, v21.h clamp
	v_and_b16 v4.h, 0xff00, v27.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v26, v26, v28, 0xc0c0105
	v_sub_nc_i16 v27.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v27.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	v_perm_b32 v12, v12, v27, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v27, v12, 16, v26
	v_and_b32_e32 v12, 0x80402010, v30
	v_lshrrev_b32_e32 v26, 24, v12
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b16 v28.l, 4, v12.l
	v_lshrrev_b32_e32 v12, 22, v30
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_cmp_ne_u16_e64 s0, 0, v26.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_bfe_i32 v12, v12, 0, 1
	v_cndmask_b32_e64 v26, 0, -1, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_and_b16 v4.h, 0xff, v12.l
	v_lshlrev_b16 v12.l, 8, v12.l
	v_lshlrev_b16 v12.h, 8, v26.l
	v_cndmask_b32_e64 v26, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_or_b16 v21.h, v4.h, v12.h
	v_lshlrev_b16 v4.h, 8, v26.l
	v_bfe_i32 v26, v28, 0, 1
	v_mov_b16_e32 v28.h, v21.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v26.h, 0xff, v26.l
	v_or_b16 v28.l, v26.h, v4.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v28, v28, v21
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v28, v29, v28
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v21.h, 0xff00, v28.l
	v_sub_nc_i16 v29.l, v21.h, v4.h clamp
	v_lshlrev_b16 v4.h, 8, v28.l
	v_lshlrev_b16 v21.h, 8, v26.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v26.l, v4.h, v21.h clamp
	v_and_b16 v4.h, 0xff00, v28.h
	v_perm_b32 v26, v26, v29, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v28.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v28.h
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v12, v12, v28, 0xc0c0105
	v_lshl_or_b32 v12, v12, 16, v26
	v_dot4_i32_iu8 v26, v27, v7, 0 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v28, v12, v0, v26 neg_lo:[1,1,0]
	v_and_b32_e32 v12, 0xff, v13
	v_lshlrev_b32_e32 v12, 2, v12
	global_load_b32 v29, v12, s[8:9]
	v_lshrrev_b32_e32 v12, 6, v13
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_and_b32_e32 v12, 0x3fc, v12
	global_load_b32 v30, v12, s[8:9]
	v_bfe_u32 v12, v24, 14, 8
	v_bcnt_u32_b32 v26, v12, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v26, 1, v26
	v_lshlrev_b32_e32 v26, 7, v26
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v12, v26, v12
	v_mul_lo_u32 v31, 0x1010101, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v12, 0x8040201, v31
	v_lshrrev_b32_e32 v26, 24, v12
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b32_e32 v12, 18, v31
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e64 s0, 0, v26.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_bfe_i32 v12, v12, 0, 1
	v_cndmask_b32_e64 v26, 0, -1, s0
	v_cndmask_b32_e64 v27, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_3)
	v_and_b16 v4.h, 0xff, v12.l
	v_mov_b16_e32 v27.h, v21.l
	v_lshlrev_b16 v12.l, 8, v12.l
	v_lshlrev_b16 v12.h, 8, v26.l
	v_bfe_i32 v26, v31, 0, 1
	v_lshlrev_b16 v26.h, 8, v27.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_or_b16 v21.h, v4.h, v12.h
	v_and_b16 v4.h, 0xff, v26.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v27.l, v4.h, v26.h
	v_or_b32_e32 v27, v27, v21
	v_lshlrev_b16 v21.h, 8, v26.l
	s_waitcnt vmcnt(1)
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v27, v29, v27
	v_and_b16 v4.h, 0xff00, v27.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v29.l, v4.h, v26.h clamp
	v_lshlrev_b16 v4.h, 8, v27.l
	v_sub_nc_i16 v26.l, v4.h, v21.h clamp
	v_and_b16 v4.h, 0xff00, v27.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v26, v26, v29, 0xc0c0105
	v_sub_nc_i16 v27.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v27.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	v_perm_b32 v12, v12, v27, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v27, v12, 16, v26
	v_and_b32_e32 v12, 0x80402010, v31
	v_lshrrev_b32_e32 v26, 24, v12
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b16 v29.l, 4, v12.l
	v_lshrrev_b32_e32 v12, 22, v31
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_cmp_ne_u16_e64 s0, 0, v26.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_bfe_i32 v12, v12, 0, 1
	v_cndmask_b32_e64 v26, 0, -1, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_and_b16 v4.h, 0xff, v12.l
	v_lshlrev_b16 v12.l, 8, v12.l
	v_lshlrev_b16 v12.h, 8, v26.l
	v_cndmask_b32_e64 v26, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_or_b16 v21.h, v4.h, v12.h
	v_lshlrev_b16 v4.h, 8, v26.l
	v_bfe_i32 v26, v29, 0, 1
	v_mov_b16_e32 v29.h, v21.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v26.h, 0xff, v26.l
	v_or_b16 v29.l, v26.h, v4.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v29, v29, v21
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v29, v30, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v21.h, 0xff00, v29.l
	v_sub_nc_i16 v30.l, v21.h, v4.h clamp
	v_lshlrev_b16 v4.h, 8, v29.l
	v_lshlrev_b16 v21.h, 8, v26.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v26.l, v4.h, v21.h clamp
	v_and_b16 v4.h, 0xff00, v29.h
	v_perm_b32 v26, v26, v30, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v29.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v29.h
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v12, v12, v29, 0xc0c0105
	v_lshl_or_b32 v12, v12, 16, v26
	v_dot4_i32_iu8 v26, v27, v1, 0 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v27, v12, v2, v26 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v12, 14, v13
	v_and_b32_e32 v12, 0x3fc, v12
	global_load_b32 v29, v12, s[8:9]
	v_lshrrev_b32_e32 v12, 22, v13
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_and_b32_e32 v12, 0x3fc, v12
	global_load_b32 v30, v12, s[8:9]
	v_bfe_u32 v12, v24, 21, 8
	v_bcnt_u32_b32 v13, v12, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v13, 1, v13
	v_lshlrev_b32_e32 v13, 7, v13
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v12, v13, v12
	v_mul_lo_u32 v31, 0x1010101, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v12, 0x8040201, v31
	v_lshrrev_b32_e32 v13, 24, v12
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b32_e32 v12, 18, v31
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e64 s0, 0, v13.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_bfe_i32 v12, v12, 0, 1
	v_cndmask_b32_e64 v13, 0, -1, s0
	v_cndmask_b32_e64 v26, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_3)
	v_and_b16 v4.h, 0xff, v12.l
	v_mov_b16_e32 v26.h, v21.l
	v_lshlrev_b16 v12.l, 8, v12.l
	v_lshlrev_b16 v12.h, 8, v13.l
	v_bfe_i32 v13, v31, 0, 1
	v_lshlrev_b16 v13.h, 8, v26.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_or_b16 v21.h, v4.h, v12.h
	v_and_b16 v4.h, 0xff, v13.l
	v_lshlrev_b16 v13.l, 8, v13.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v26.l, v4.h, v13.h
	v_or_b32_e32 v26, v26, v21
	s_waitcnt vmcnt(1)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v26, v29, v26
	v_and_b16 v4.h, 0xff00, v26.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v29.l, v4.h, v13.h clamp
	v_lshlrev_b16 v4.h, 8, v26.l
	v_sub_nc_i16 v13.l, v4.h, v13.l clamp
	v_and_b16 v4.h, 0xff00, v26.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v13, v13, v29, 0xc0c0105
	v_sub_nc_i16 v26.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v26.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	v_perm_b32 v12, v12, v26, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v26, v12, 16, v13
	v_and_b32_e32 v12, 0x80402010, v31
	v_lshrrev_b32_e32 v13, 24, v12
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b16 v29.l, 4, v12.l
	v_lshrrev_b32_e32 v12, 22, v31
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_cmp_ne_u16_e64 s0, 0, v13.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_bfe_i32 v12, v12, 0, 1
	v_cndmask_b32_e64 v13, 0, -1, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_and_b16 v4.h, 0xff, v12.l
	v_lshlrev_b16 v12.l, 8, v12.l
	v_lshlrev_b16 v12.h, 8, v13.l
	v_cndmask_b32_e64 v13, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_or_b16 v21.h, v4.h, v12.h
	v_lshlrev_b16 v4.h, 8, v13.l
	v_bfe_i32 v13, v29, 0, 1
	v_mov_b16_e32 v29.h, v21.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b16 v13.h, 0xff, v13.l
	v_lshlrev_b16 v13.l, 8, v13.l
	v_or_b16 v29.l, v13.h, v4.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v29, v29, v21
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v29, v30, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v13.h, 0xff00, v29.l
	v_sub_nc_i16 v30.l, v13.h, v4.h clamp
	v_lshlrev_b16 v4.h, 8, v29.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v13.l, v4.h, v13.l clamp
	v_and_b16 v4.h, 0xff00, v29.h
	v_perm_b32 v13, v13, v30, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v29.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v29.h
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	global_load_d16_hi_b16 v4, v[10:11], off offset:64
	v_perm_b32 v12, v12, v29, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_lshl_or_b32 v12, v12, 16, v13
	v_dot4_i32_iu8 v13, v26, v3, 0 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v26, 28, v24
	v_dot4_i32_iu8 v12, v12, v22, v13 neg_lo:[1,1,0]
	v_add_nc_u32_e32 v13, v28, v25
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v13, v13, v12, v27
	v_lshrrev_b32_e32 v12, 31, v13
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v12, v13, v12
	v_ashrrev_i32_e32 v12, 1, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mad_u64_u32 v[24:25], null, v13, v26, v[12:13]
	v_lshrrev_b32_e32 v12, 31, v24
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v12, v24, v12
	v_ashrrev_i32_e32 v13, 1, v12
	s_waitcnt vmcnt(0)
	v_cvt_f32_f16_e32 v12, v4.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cvt_f32_i32_e32 v13, v13
	v_cvt_f32_f16_e32 v10, v4.h
	v_mul_f32_e32 v4, v10, v12
	v_mad_i64_i32 v[10:11], null, 0x42, v23, s[6:7]
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_fmac_f32_e32 v16, v4, v13
	v_add_co_u32 v23, vcc_lo, v10, v20
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v24, null, 0, v11, vcc_lo
	global_load_b64 v[26:27], v[23:24], off
	v_add_co_u32 v23, vcc_lo, v10, v19
	v_add_co_ci_u32_e64 v24, null, 0, v11, vcc_lo
	global_load_b32 v28, v[23:24], off offset:64
	s_waitcnt vmcnt(1)
	v_and_b32_e32 v23, 0xff, v26
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v23, 2, v23
	global_load_b32 v29, v23, s[8:9]
	v_lshrrev_b32_e32 v23, 6, v26
	v_and_b32_e32 v23, 0x3fc, v23
	global_load_b32 v30, v23, s[8:9]
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v23, 0xff, v28
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_bcnt_u32_b32 v24, v23, 0
	v_and_b32_e32 v24, 1, v24
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v24, 7, v24
	v_xor_b32_e32 v23, v24, v23
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v31, 0x1010101, v23
	v_and_b32_e32 v23, 0x8040201, v31
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshrrev_b32_e32 v24, 24, v23
	v_lshrrev_b16 v21.h, 8, v23.l
	v_lshrrev_b32_e32 v23, 18, v31
	v_cmp_ne_u16_e64 s0, 0, v24.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.h
	v_bfe_i32 v23, v23, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v24, 0, -1, s0
	v_cndmask_b32_e64 v25, 0, -1, vcc_lo
	v_and_b16 v21.h, 0xff, v23.l
	v_lshlrev_b16 v23.l, 8, v23.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshlrev_b16 v23.h, 8, v24.l
	v_bfe_i32 v24, v31, 0, 1
	v_lshlrev_b16 v25.l, 8, v25.l
	v_or_b16 v21.h, v21.h, v23.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b16 v24.h, 0xff, v24.l
	v_lshlrev_b16 v24.l, 8, v24.l
	v_or_b16 v32.l, v24.h, v25.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v32, v32, v21
	s_waitcnt vmcnt(1)
	v_xor_b32_e32 v29, v29, v32
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v21.h, 0xff00, v29.l
	v_sub_nc_i16 v25.l, v21.h, v25.l clamp
	v_lshlrev_b16 v21.h, 8, v29.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v24.l, v21.h, v24.l clamp
	v_and_b16 v21.h, 0xff00, v29.h
	v_perm_b32 v24, v24, v25, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v25.l, v21.h, v23.h clamp
	v_lshlrev_b16 v21.h, 8, v29.h
	v_sub_nc_i16 v23.l, v21.h, v23.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v23, v23, v25, 0xc0c0105
	v_lshl_or_b32 v29, v23, 16, v24
	v_and_b32_e32 v23, 0x80402010, v31
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_dot4_i32_iu8 v5, v29, v5, 0 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v24, 24, v23
	v_lshrrev_b16 v21.h, 8, v23.l
	v_lshrrev_b16 v25.l, 4, v23.l
	v_lshrrev_b32_e32 v23, 22, v31
	v_mov_b16_e32 v31.h, v21.l
	v_cmp_ne_u16_e64 s0, 0, v24.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.h
	v_bfe_i32 v25, v25, 0, 1
	v_bfe_i32 v23, v23, 0, 1
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cndmask_b32_e64 v24, 0, -1, s0
	v_and_b16 v21.h, 0xff, v23.l
	v_lshlrev_b16 v23.l, 8, v23.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshlrev_b16 v23.h, 8, v24.l
	v_cndmask_b32_e64 v24, 0, -1, vcc_lo
	v_and_b16 v24.h, 0xff, v25.l
	v_or_b16 v21.h, v21.h, v23.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b16 v24.l, 8, v24.l
	v_or_b16 v31.l, v24.h, v24.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v31, v31, v21
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v30, v30, v31
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v21.h, 0xff00, v30.l
	v_sub_nc_i16 v31.l, v21.h, v24.l clamp
	v_lshlrev_b16 v21.h, 8, v30.l
	v_lshlrev_b16 v24.l, 8, v25.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v24.l, v21.h, v24.l clamp
	v_and_b16 v21.h, 0xff00, v30.h
	v_perm_b32 v24, v24, v31, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v25.l, v21.h, v23.h clamp
	v_lshlrev_b16 v21.h, 8, v30.h
	v_sub_nc_i16 v23.l, v21.h, v23.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v23, v23, v25, 0xc0c0105
	v_lshl_or_b32 v23, v23, 16, v24
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v25, v23, v6, v5 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v5, 14, v26
	v_and_b32_e32 v5, 0x3fc, v5
	global_load_b32 v29, v5, s[8:9]
	v_lshrrev_b32_e32 v5, 22, v26
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_and_b32_e32 v5, 0x3fc, v5
	global_load_b32 v26, v5, s[8:9]
	v_bfe_u32 v5, v28, 7, 8
	v_bcnt_u32_b32 v6, v5, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v6, 1, v6
	v_lshlrev_b32_e32 v6, 7, v6
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v5, v6, v5
	v_mul_lo_u32 v30, 0x1010101, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b32_e32 v5, 0x8040201, v30
	v_bfe_i32 v23, v30, 0, 1
	v_lshrrev_b32_e32 v6, 24, v5
	v_lshrrev_b16 v5.l, 8, v5.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cmp_ne_u16_e64 s0, 0, v6.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v5.l
	v_lshrrev_b32_e32 v5, 18, v30
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v6, 0, -1, s0
	v_cndmask_b32_e64 v24, 0, -1, vcc_lo
	v_bfe_i32 v5, v5, 0, 1
	v_mov_b16_e32 v24.h, v21.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b16 v6.l, 8, v6.l
	v_lshlrev_b16 v6.h, 8, v24.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b16 v5.h, 0xff, v5.l
	v_lshlrev_b16 v5.l, 8, v5.l
	v_or_b16 v21.h, v5.h, v6.l
	v_and_b16 v5.h, 0xff, v23.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v24.l, v5.h, v6.h
	v_or_b32_e32 v24, v24, v21
	s_waitcnt vmcnt(1)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v24, v29, v24
	v_and_b16 v5.h, 0xff00, v24.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v29.l, v5.h, v6.h clamp
	v_lshlrev_b16 v5.h, 8, v24.l
	v_lshlrev_b16 v6.h, 8, v23.l
	v_sub_nc_i16 v23.l, v5.h, v6.h clamp
	v_and_b16 v5.h, 0xff00, v24.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v23, v23, v29, 0xc0c0105
	v_sub_nc_i16 v6.l, v5.h, v6.l clamp
	v_lshlrev_b16 v5.h, 8, v24.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v5.l, v5.h, v5.l clamp
	v_perm_b32 v5, v5, v6, 0xc0c0105
	v_and_b32_e32 v6, 0x80402010, v30
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshl_or_b32 v24, v5, 16, v23
	v_lshrrev_b32_e32 v23, 24, v6
	v_lshrrev_b16 v5.l, 8, v6.l
	v_lshrrev_b16 v29.l, 4, v6.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e64 s0, 0, v23.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v5.l
	v_lshrrev_b32_e32 v5, 22, v30
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v6, 0, -1, s0
	v_cndmask_b32_e64 v23, 0, -1, vcc_lo
	v_bfe_i32 v5, v5, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshlrev_b16 v6.l, 8, v6.l
	v_and_b16 v5.h, 0xff, v5.l
	v_lshlrev_b16 v5.l, 8, v5.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_or_b16 v21.h, v5.h, v6.l
	v_lshlrev_b16 v5.h, 8, v23.l
	v_bfe_i32 v23, v29, 0, 1
	v_mov_b16_e32 v29.h, v21.l
	v_and_b16 v6.h, 0xff, v23.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v29.l, v6.h, v5.h
	v_or_b32_e32 v29, v29, v21
	s_waitcnt vmcnt(0)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v26, v26, v29
	v_and_b16 v6.h, 0xff00, v26.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v29.l, v6.h, v5.h clamp
	v_lshlrev_b16 v5.h, 8, v26.l
	v_lshlrev_b16 v6.h, 8, v23.l
	v_sub_nc_i16 v23.l, v5.h, v6.h clamp
	v_and_b16 v5.h, 0xff00, v26.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v23, v23, v29, 0xc0c0105
	v_sub_nc_i16 v6.l, v5.h, v6.l clamp
	v_lshlrev_b16 v5.h, 8, v26.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v5.l, v5.h, v5.l clamp
	v_perm_b32 v5, v5, v6, 0xc0c0105
	v_dot4_i32_iu8 v6, v24, v7, 0 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v5, v5, 16, v23
	v_dot4_i32_iu8 v23, v5, v0, v6 neg_lo:[1,1,0]
	v_and_b32_e32 v0, 0xff, v27
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v0, 2, v0
	global_load_b32 v24, v0, s[8:9]
	v_lshrrev_b32_e32 v0, 6, v27
	v_and_b32_e32 v0, 0x3fc, v0
	global_load_b32 v26, v0, s[8:9]
	v_bfe_u32 v0, v28, 14, 8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_bcnt_u32_b32 v5, v0, 0
	v_and_b32_e32 v5, 1, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v5, 7, v5
	v_xor_b32_e32 v0, v5, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v29, 0x1010101, v0
	v_and_b32_e32 v0, 0x8040201, v29
	v_bfe_i32 v6, v29, 0, 1
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_lshrrev_b32_e32 v5, 24, v0
	v_lshrrev_b16 v0.l, 8, v0.l
	v_cmp_ne_u16_e64 s0, 0, v5.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v0.l
	v_lshrrev_b32_e32 v0, 18, v29
	v_cndmask_b32_e64 v5, 0, -1, s0
	v_cndmask_b32_e64 v7, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_4)
	v_bfe_i32 v0, v0, 0, 1
	v_mov_b16_e32 v7.h, v21.l
	v_lshlrev_b16 v5.l, 8, v5.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b16 v5.h, 8, v7.l
	v_and_b16 v0.h, 0xff, v0.l
	v_lshlrev_b16 v0.l, 8, v0.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b16 v21.h, v0.h, v5.l
	v_and_b16 v0.h, 0xff, v6.l
	v_or_b16 v7.l, v0.h, v5.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v7, v7, v21
	s_waitcnt vmcnt(1)
	v_xor_b32_e32 v7, v24, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v0.h, 0xff00, v7.l
	v_sub_nc_i16 v24.l, v0.h, v5.h clamp
	v_lshlrev_b16 v0.h, 8, v7.l
	v_lshlrev_b16 v5.h, 8, v6.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v6.l, v0.h, v5.h clamp
	v_and_b16 v0.h, 0xff00, v7.h
	v_perm_b32 v6, v6, v24, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v5.l, v0.h, v5.l clamp
	v_lshlrev_b16 v0.h, 8, v7.h
	v_sub_nc_i16 v0.l, v0.h, v0.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_perm_b32 v0, v0, v5, 0xc0c0105
	v_and_b32_e32 v5, 0x80402010, v29
	v_lshl_or_b32 v7, v0, 16, v6
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_4)
	v_lshrrev_b32_e32 v6, 24, v5
	v_lshrrev_b16 v0.l, 8, v5.l
	v_lshrrev_b16 v24.l, 4, v5.l
	v_dot4_i32_iu8 v1, v7, v1, 0 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_cmp_ne_u16_e64 s0, 0, v6.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v0.l
	v_lshrrev_b32_e32 v0, 22, v29
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v5, 0, -1, s0
	v_cndmask_b32_e64 v6, 0, -1, vcc_lo
	v_bfe_i32 v0, v0, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshlrev_b16 v5.l, 8, v5.l
	v_and_b16 v0.h, 0xff, v0.l
	v_lshlrev_b16 v0.l, 8, v0.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_or_b16 v21.h, v0.h, v5.l
	v_lshlrev_b16 v0.h, 8, v6.l
	v_bfe_i32 v6, v24, 0, 1
	v_mov_b16_e32 v24.h, v21.l
	v_and_b16 v5.h, 0xff, v6.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v24.l, v5.h, v0.h
	v_or_b32_e32 v24, v24, v21
	s_waitcnt vmcnt(0)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v24, v26, v24
	v_and_b16 v5.h, 0xff00, v24.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v26.l, v5.h, v0.h clamp
	v_lshlrev_b16 v0.h, 8, v24.l
	v_lshlrev_b16 v5.h, 8, v6.l
	v_sub_nc_i16 v6.l, v0.h, v5.h clamp
	v_and_b16 v0.h, 0xff00, v24.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v6, v6, v26, 0xc0c0105
	v_sub_nc_i16 v5.l, v0.h, v5.l clamp
	v_lshlrev_b16 v0.h, 8, v24.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v0.l, v0.h, v0.l clamp
	v_perm_b32 v0, v0, v5, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v0, v0, 16, v6
	v_dot4_i32_iu8 v6, v0, v2, v1 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v0, 14, v27
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_and_b32_e32 v0, 0x3fc, v0
	global_load_b32 v7, v0, s[8:9]
	v_lshrrev_b32_e32 v0, 22, v27
	v_and_b32_e32 v0, 0x3fc, v0
	global_load_b32 v24, v0, s[8:9]
	v_bfe_u32 v0, v28, 21, 8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_bcnt_u32_b32 v1, v0, 0
	v_and_b32_e32 v1, 1, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v1, 7, v1
	v_xor_b32_e32 v0, v1, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v26, 0x1010101, v0
	v_and_b32_e32 v0, 0x8040201, v26
	v_bfe_i32 v2, v26, 0, 1
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_lshrrev_b32_e32 v1, 24, v0
	v_lshrrev_b16 v0.l, 8, v0.l
	v_cmp_ne_u16_e64 s0, 0, v1.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v0.l
	v_lshrrev_b32_e32 v0, 18, v26
	v_cndmask_b32_e64 v1, 0, -1, s0
	v_cndmask_b32_e64 v5, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_4)
	v_bfe_i32 v0, v0, 0, 1
	v_mov_b16_e32 v5.h, v21.l
	v_lshlrev_b16 v1.l, 8, v1.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b16 v1.h, 8, v5.l
	v_and_b16 v0.h, 0xff, v0.l
	v_lshlrev_b16 v0.l, 8, v0.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b16 v21.h, v0.h, v1.l
	v_and_b16 v0.h, 0xff, v2.l
	v_or_b16 v5.l, v0.h, v1.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v5, v5, v21
	s_waitcnt vmcnt(1)
	v_xor_b32_e32 v5, v7, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v0.h, 0xff00, v5.l
	v_sub_nc_i16 v7.l, v0.h, v1.h clamp
	v_lshlrev_b16 v0.h, 8, v5.l
	v_lshlrev_b16 v1.h, 8, v2.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v2.l, v0.h, v1.h clamp
	v_and_b16 v0.h, 0xff00, v5.h
	v_perm_b32 v2, v2, v7, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v1.l, v0.h, v1.l clamp
	v_lshlrev_b16 v0.h, 8, v5.h
	v_sub_nc_i16 v0.l, v0.h, v0.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_perm_b32 v0, v0, v1, 0xc0c0105
	v_and_b32_e32 v1, 0x80402010, v26
	v_lshl_or_b32 v5, v0, 16, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshrrev_b32_e32 v2, 24, v1
	v_lshrrev_b16 v0.l, 8, v1.l
	v_lshrrev_b16 v7.l, 4, v1.l
	v_cmp_ne_u16_e64 s0, 0, v2.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v0.l
	v_lshrrev_b32_e32 v0, 22, v26
	v_cndmask_b32_e64 v1, 0, -1, s0
	v_cndmask_b32_e64 v2, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_4)
	v_bfe_i32 v0, v0, 0, 1
	v_add_co_u32 v8, vcc_lo, 0x480, v8
	v_lshlrev_b16 v1.l, 8, v1.l
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_and_b16 v0.h, 0xff, v0.l
	v_lshlrev_b16 v0.l, 8, v0.l
	v_cmp_le_u32_e32 vcc_lo, s12, v18
	v_or_b16 v21.h, v0.h, v1.l
	v_lshlrev_b16 v0.h, 8, v2.l
	v_bfe_i32 v2, v7, 0, 1
	v_mov_b16_e32 v7.h, v21.l
	s_or_b32 s13, vcc_lo, s13
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v1.h, 0xff, v2.l
	v_or_b16 v7.l, v1.h, v0.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v7, v7, v21
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v7, v24, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v1.h, 0xff00, v7.l
	v_sub_nc_i16 v21.l, v1.h, v0.h clamp
	v_lshlrev_b16 v0.h, 8, v7.l
	v_lshlrev_b16 v1.h, 8, v2.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v2.l, v0.h, v1.h clamp
	v_and_b16 v0.h, 0xff00, v7.h
	v_perm_b32 v2, v2, v21, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v1.l, v0.h, v1.l clamp
	v_lshlrev_b16 v0.h, 8, v7.h
	v_sub_nc_i16 v0.l, v0.h, v0.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_perm_b32 v0, v0, v1, 0xc0c0105
	v_dot4_i32_iu8 v1, v5, v3, 0 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v5, 28, v28
	v_lshl_or_b32 v0, v0, 16, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v0, v0, v22, v1 neg_lo:[1,1,0]
	v_add_nc_u32_e32 v1, v23, v25
	v_add3_u32 v3, v1, v0, v6
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v0, 31, v3
	v_add_nc_u32_e32 v0, v3, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v0, 1, v0
	v_mad_u64_u32 v[1:2], null, v3, v5, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v0, 31, v1
	v_add_nc_u32_e32 v0, v1, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_4) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 1, v0
	global_load_d16_b16 v0, v[10:11], off offset:64
	v_cvt_f32_i32_e32 v1, v1
	s_waitcnt vmcnt(0)
	v_cvt_f32_f16_e32 v0, v0.l
	v_mul_f32_e32 v0, v12, v0
	s_delay_alu instid0(VALU_DEP_1)
	v_fmac_f32_e32 v15, v0, v1
	s_and_not1_b32 exec_lo, exec_lo, s13
	s_cbranch_execnz .LBB5_2
; %bb.3:
	s_or_b32 exec_lo, exec_lo, s13
.LBB5_4:
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s1
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v17
	v_cmpx_ne_u32_e32 0, v17
	s_cbranch_execz .LBB5_6
; %bb.5:
	v_lshlrev_b32_e32 v0, 7, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_add_u32 v0, v14, 2, v0
	v_add_nc_u32_e32 v1, 0xffffff80, v0
	ds_store_b32 v1, v16
	ds_store_b32 v0, v15
.LBB5_6:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB5_52
; %bb.7:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB5_10
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB5_11
.LBB5_9:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr4
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr0
	s_branch .LBB5_26
.LBB5_10:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB5_9
.LBB5_11:
	v_mbcnt_lo_u32_b32 v0, -1, 0
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_xor_b32_e32 v1, 16, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v1
	v_cndmask_b32_e32 v1, v0, v1, vcc_lo
	v_dual_mov_b32 v1, 32 :: v_dual_lshlrev_b32 v2, 2, v1
	ds_bpermute_b32 v3, v2, v16
	s_cbranch_scc0 .LBB5_14
; %bb.12:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB5_15
.LBB5_13:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr4
                                        ; implicit-def: $vgpr3
	s_branch .LBB5_26
.LBB5_14:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB5_13
.LBB5_15:
	v_xor_b32_e32 v4, 8, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v5, v0, v4, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v4, v16, v3 :: v_dual_lshlrev_b32 v3, 2, v5
	ds_bpermute_b32 v5, v3, v4
	s_cbranch_scc0 .LBB5_18
; %bb.16:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB5_19
.LBB5_17:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr4
	s_branch .LBB5_26
.LBB5_18:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB5_17
.LBB5_19:
	v_xor_b32_e32 v6, 4, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v6
	v_cndmask_b32_e32 v6, v0, v6, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v5, v4, v5 :: v_dual_lshlrev_b32 v4, 2, v6
	ds_bpermute_b32 v6, v4, v5
	s_cbranch_scc0 .LBB5_22
; %bb.20:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB5_23
.LBB5_21:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
	s_branch .LBB5_26
.LBB5_22:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB5_21
.LBB5_23:
	v_xor_b32_e32 v7, 2, v0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v7
	s_waitcnt lgkmcnt(0)
	v_dual_cndmask_b32 v8, v0, v7 :: v_dual_add_f32 v7, v5, v6
	v_lshlrev_b32_e32 v5, 2, v8
	ds_bpermute_b32 v6, v5, v7
	s_cbranch_scc0 .LBB5_25
; %bb.24:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_branch .LBB5_26
.LBB5_25:
	s_mov_b32 s0, 0
	s_mov_b32 s4, -1
.LBB5_26:
	s_mov_b32 s1, 0
	s_and_b32 vcc_lo, exec_lo, s0
	s_mov_b32 s0, 0
	s_cbranch_vccnz .LBB5_39
; %bb.27:
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB5_41
.LBB5_28:
	v_xor_b32_e32 v8, 1, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_lt_i32_e32 vcc_lo, v8, v1
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v1, v7, v6 :: v_dual_cndmask_b32 v0, v0, v8
	v_lshlrev_b32_e32 v6, 2, v0
	ds_bpermute_b32 v0, v6, v1
	s_cbranch_scc0 .LBB5_30
; %bb.29:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB5_31
	s_branch .LBB5_46
.LBB5_30:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB5_46
.LBB5_31:
	ds_bpermute_b32 v2, v2, v15
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB5_33
; %bb.32:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB5_34
	s_branch .LBB5_46
.LBB5_33:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB5_46
.LBB5_34:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v15, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v3, v3, v2
	s_cbranch_scc0 .LBB5_36
; %bb.35:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB5_37
	s_branch .LBB5_46
.LBB5_36:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB5_46
.LBB5_37:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v2, v3
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v3, v4, v2
	s_cbranch_scc0 .LBB5_42
; %bb.38:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_branch .LBB5_43
.LBB5_39:
	s_cbranch_execnz .LBB5_53
; %bb.40:
	s_mov_b32 s0, -1
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB5_28
.LBB5_41:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr1
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB5_48
	s_branch .LBB5_49
.LBB5_42:
	s_mov_b32 s4, 0
.LBB5_43:
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB5_46
; %bb.44:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v2, v3
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v5, v3
	s_cbranch_scc0 .LBB5_55
; %bb.45:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB5_47
	s_branch .LBB5_56
.LBB5_46:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB5_56
.LBB5_47:
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB5_49
.LBB5_48:
	; divergent unreachable
.LBB5_49:
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB5_52
; %bb.50:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v3, v2
	v_cmp_eq_u32_e32 vcc_lo, 0, v14
	s_mov_b32 s1, 0
	ds_bpermute_b32 v3, v6, v2
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB5_52
; %bb.51:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v2, v3
	s_mul_i32 s0, s15, s3
	v_add_f32_e32 v0, v1, v0
	s_lshl_b64 s[0:1], s[0:1], 2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_mul_f32_e32 v3, 0xbfb8aa3b, v2
	s_add_u32 s4, s10, s0
	s_addc_u32 s5, s11, s1
	s_ashr_i32 s3, s2, 31
	s_lshl_b64 s[0:1], s[2:3], 2
	v_fma_f32 v4, 0xbfb8aa3b, v2, -v3
	v_rndne_f32_e32 v5, v3
	s_add_u32 s0, s4, s0
	s_addc_u32 s1, s5, s1
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_f32_e32 v3, v3, v5
	v_cmp_nlt_f32_e32 vcc_lo, 0x42ce8ed0, v2
	v_fmamk_f32 v4, v2, 0xb2a5705f, v4
	v_add_f32_e32 v3, v3, v4
	v_cvt_i32_f32_e32 v4, v5
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_exp_f32_e32 v3, v3
	s_waitcnt_depctr 0xfff
	v_ldexp_f32 v3, v3, v4
	v_cndmask_b32_e32 v3, 0, v3, vcc_lo
	v_cmp_ngt_f32_e32 vcc_lo, 0xc2b17218, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cndmask_b32_e32 v3, 0x7f800000, v3, vcc_lo
	v_add_f32_e32 v3, 1.0, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_div_scale_f32 v4, null, v3, v3, v2
	v_rcp_f32_e32 v5, v4
	s_waitcnt_depctr 0xfff
	v_fma_f32 v6, -v4, v5, 1.0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_fmac_f32_e32 v5, v6, v5
	v_div_scale_f32 v6, vcc_lo, v2, v3, v2
	v_mul_f32_e32 v7, v6, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fma_f32 v8, -v4, v7, v6
	v_fmac_f32_e32 v7, v8, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fma_f32 v4, -v4, v7, v6
	v_div_fmas_f32 v4, v4, v5, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_div_fixup_f32 v1, v4, v3, v2
	v_mov_b32_e32 v2, 0
	v_mul_f32_e32 v0, v0, v1
	global_store_b32 v2, v0, s[0:1]
.LBB5_52:
	s_endpgm
.LBB5_53:
	s_trap 2
	s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)
	s_mov_b32 ttmp2, m0
	s_waitcnt lgkmcnt(0)
	s_and_b32 s0, s0, 0x3ff
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_bitset1_b32 s0, 10
	s_mov_b32 m0, s0
	s_sendmsg sendmsg(MSG_INTERRUPT)
	s_mov_b32 m0, ttmp2
.LBB5_54:                               ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB5_54
.LBB5_55:
	s_mov_b32 s1, -1
	s_branch .LBB5_47
.LBB5_56:
	s_cbranch_execnz .LBB5_58
; %bb.57:
	s_cbranch_execnz .LBB5_48
	s_branch .LBB5_49
.LBB5_58:
	s_trap 2
	s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)
	s_mov_b32 ttmp2, m0
	s_waitcnt lgkmcnt(0)
	s_and_b32 s0, s0, 0x3ff
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_bitset1_b32 s0, 10
	s_mov_b32 m0, s0
	s_sendmsg sendmsg(MSG_INTERRUPT)
	s_mov_b32 m0, ttmp2
.LBB5_59:                               ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB5_59
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
		.amdhsa_group_segment_fixed_size 256
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 48
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 1
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 1
		.amdhsa_next_free_vgpr 33
		.amdhsa_next_free_sgpr 18
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_dx10_clamp 1
		.amdhsa_ieee_mode 1
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_shared_vgpr_count 0
		.amdhsa_inst_pref_size 61
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end5:
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj, .Lfunc_end5-_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj.num_vgpr, 33
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 18
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 7788
; TotalNumSgprs: 20
; NumVgprs: 33
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 256 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 4
; NumSGPRsForWavesPerEU: 20
; NumVGPRsForWavesPerEU: 33
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_load_b256 s[4:11], s[0:1], 0x10
	v_bfe_u32 v12, v0, 10, 10
	v_dual_mov_b32 v11, 0 :: v_dual_and_b32 v10, 0x3ff, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v0, v12, 5, v10
	v_lshrrev_b32_e32 v13, 3, v0
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s14, s8, 8
	s_mov_b32 s8, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_gt_u32_e64 s14, v13
	s_cbranch_execz .LBB6_4
; %bb.1:
	v_lshl_add_u32 v0, v12, 5, v10
	s_mul_i32 s10, s10, s3
	v_dual_mov_b32 v11, 0 :: v_dual_and_b32 v4, 7, v10
	s_mul_hi_u32 s13, s10, 36
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_lshrrev_b32_e32 v2, 3, v0
	s_mul_i32 s12, s10, 36
	v_lshlrev_b32_e32 v5, 1, v10
	v_mad_u64_u32 v[0:1], null, 0x120, v2, s[12:13]
	s_load_b64 s[12:13], s[0:1], 0x0
	v_mad_u64_u32 v[2:3], null, v4, 36, v[0:1]
	v_and_b32_e32 v0, 14, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_lshlrev_b32_e32 v1, 1, v0
	v_add_co_u32 v2, vcc_lo, s4, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v3, null, s5, v3, vcc_lo
	v_lshlrev_b32_e32 v14, 1, v1
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v8, vcc_lo, v2, 32
	v_add_co_ci_u32_e64 v9, null, 0, v3, vcc_lo
	v_lshlrev_b32_e32 v15, 1, v0
	s_mul_i32 s5, s9, s2
	s_mov_b32 s4, 0
.LBB6_2:                                ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v18, s5, v13
	s_clause 0x2
	global_load_b32 v16, v[8:9], off
	global_load_b128 v[0:3], v[8:9], off offset:-32
	global_load_b128 v[4:7], v[8:9], off offset:-16
	s_getpc_b64 s[0:1]
	s_add_u32 s0, s0, _ZL11iq3xxs_grid@rel32@lo+4
	s_addc_u32 s1, s1, _ZL11iq3xxs_grid@rel32@hi+12
	v_mov_b16_e32 v17.l, 0
	v_add_nc_u32_e32 v13, 4, v13
	s_waitcnt lgkmcnt(0)
	v_mad_i64_i32 v[21:22], null, 0x42, v18, s[12:13]
	s_delay_alu instid0(VALU_DEP_3)
	v_mov_b16_e32 v18.h, v17.l
	v_mov_b16_e32 v19.h, v17.l
	v_mov_b16_e32 v20.h, v17.l
	v_mov_b16_e32 v45.h, v17.l
	v_mov_b16_e32 v46.h, v17.l
	v_add_co_u32 v23, vcc_lo, v21, v14
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v24, null, 0, v22, vcc_lo
	v_add_co_u32 v25, vcc_lo, v21, v15
	v_add_co_ci_u32_e64 v26, null, 0, v22, vcc_lo
	s_clause 0x2
	global_load_b64 v[23:24], v[23:24], off
	global_load_b32 v50, v[25:26], off offset:64
	global_load_d16_hi_b16 v0, v[21:22], off offset:64
	v_mov_b16_e32 v47.h, v17.l
	v_mov_b16_e32 v48.h, v17.l
	v_mov_b16_e32 v49.h, v17.l
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v21, 0xff, v23
	v_lshrrev_b32_e32 v22, 6, v23
	v_lshrrev_b32_e32 v26, 14, v23
	v_lshrrev_b32_e32 v23, 22, v23
	v_and_b32_e32 v28, 0xff, v24
	v_lshrrev_b32_e32 v29, 6, v24
	v_lshrrev_b32_e32 v31, 14, v24
	v_lshrrev_b32_e32 v24, 22, v24
	v_lshlrev_b32_e32 v21, 2, v21
	v_and_b32_e32 v22, 0x3fc, v22
	v_and_b32_e32 v26, 0x3fc, v26
	v_and_b32_e32 v23, 0x3fc, v23
	v_lshlrev_b32_e32 v28, 2, v28
	v_and_b32_e32 v29, 0x3fc, v29
	v_and_b32_e32 v31, 0x3fc, v31
	v_and_b32_e32 v24, 0x3fc, v24
	s_clause 0x7
	global_load_b32 v51, v21, s[0:1]
	global_load_b32 v52, v22, s[0:1]
	global_load_b32 v53, v26, s[0:1]
	global_load_b32 v54, v23, s[0:1]
	global_load_b32 v55, v28, s[0:1]
	global_load_b32 v56, v29, s[0:1]
	global_load_b32 v57, v31, s[0:1]
	global_load_b32 v58, v24, s[0:1]
	s_waitcnt vmcnt(9)
	v_and_b32_e32 v25, 0xff, v50
	v_bfe_u32 v27, v50, 7, 8
	v_bfe_u32 v30, v50, 14, 8
	v_bfe_u32 v32, v50, 21, 8
	v_cmp_le_u32_e64 s0, s14, v13
	v_bcnt_u32_b32 v33, v25, 0
	v_bcnt_u32_b32 v34, v27, 0
	v_bcnt_u32_b32 v35, v30, 0
	v_bcnt_u32_b32 v36, v32, 0
	s_or_b32 s4, s0, s4
	v_and_b32_e32 v21, 1, v33
	v_and_b32_e32 v22, 1, v34
	v_and_b32_e32 v23, 1, v35
	v_and_b32_e32 v24, 1, v36
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b32_e32 v21, 7, v21
	v_lshlrev_b32_e32 v22, 7, v22
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b32_e32 v23, 7, v23
	v_lshlrev_b32_e32 v24, 7, v24
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_xor_b32_e32 v21, v21, v25
	v_xor_b32_e32 v22, v22, v27
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_xor_b32_e32 v23, v23, v30
	v_xor_b32_e32 v24, v24, v32
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_mul_lo_u32 v21, 0x1010101, v21
	v_mul_lo_u32 v22, 0x1010101, v22
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_mul_lo_u32 v23, 0x1010101, v23
	v_mul_lo_u32 v24, 0x1010101, v24
	s_delay_alu instid0(VALU_DEP_4)
	v_and_b32_e32 v25, 0x8040201, v21
	v_lshrrev_b32_e32 v26, 18, v21
	v_bfe_i32 v27, v21, 0, 1
	v_and_b32_e32 v28, 0x80402010, v21
	v_lshrrev_b32_e32 v21, 22, v21
	v_lshrrev_b32_e32 v43, 24, v25
	v_and_b32_e32 v29, 0x8040201, v22
	v_lshrrev_b32_e32 v30, 18, v22
	v_bfe_i32 v31, v22, 0, 1
	v_and_b32_e32 v32, 0x80402010, v22
	v_lshrrev_b32_e32 v22, 22, v22
	v_and_b32_e32 v33, 0x8040201, v23
	v_lshrrev_b32_e32 v34, 18, v23
	v_bfe_i32 v35, v23, 0, 1
	v_and_b32_e32 v36, 0x80402010, v23
	v_lshrrev_b32_e32 v37, 22, v23
	v_and_b32_e32 v38, 0x8040201, v24
	v_lshrrev_b32_e32 v39, 18, v24
	v_bfe_i32 v40, v24, 0, 1
	v_and_b32_e32 v41, 0x80402010, v24
	v_lshrrev_b32_e32 v42, 22, v24
	v_lshrrev_b16 v17.h, 8, v25.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v43.l
	v_mov_b16_e32 v18.l, v27.l
	v_lshrrev_b32_e32 v27, 24, v28
	v_bfe_i32 v44, v21, 0, 1
	v_lshrrev_b32_e32 v59, 24, v29
	v_lshrrev_b16 v20.l, 8, v29.l
	v_bfe_i32 v29, v30, 0, 1
	v_mov_b16_e32 v21.l, v31.l
	v_lshrrev_b32_e32 v30, 24, v32
	v_lshrrev_b16 v21.h, 8, v32.l
	v_lshrrev_b16 v31.l, 4, v32.l
	v_bfe_i32 v32, v22, 0, 1
	v_lshrrev_b32_e32 v60, 24, v33
	v_lshrrev_b16 v22.l, 8, v33.l
	v_bfe_i32 v33, v34, 0, 1
	v_mov_b16_e32 v23.l, v35.l
	v_lshrrev_b32_e32 v34, 24, v36
	v_lshrrev_b16 v22.h, 8, v36.l
	v_lshrrev_b16 v35.l, 4, v36.l
	v_bfe_i32 v36, v37, 0, 1
	v_lshrrev_b32_e32 v37, 24, v38
	v_lshrrev_b16 v23.h, 8, v38.l
	v_bfe_i32 v38, v39, 0, 1
	v_mov_b16_e32 v24.l, v40.l
	v_lshrrev_b32_e32 v39, 24, v41
	v_lshrrev_b16 v24.h, 8, v41.l
	v_lshrrev_b16 v40.l, 4, v41.l
	v_bfe_i32 v41, v42, 0, 1
	v_cndmask_b32_e64 v42, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v17.h
	v_lshrrev_b16 v19.l, 8, v28.l
	v_bfe_i32 v25, v26, 0, 1
	v_and_b16 v25.h, 0xff, v18.l
	v_lshlrev_b16 v26.l, 8, v18.l
	v_cndmask_b32_e64 v43, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v27.l
	v_mov_b16_e32 v18.l, v44.l
	v_lshrrev_b16 v28.l, 4, v28.l
	v_bfe_i32 v66, v31, 0, 1
	v_mov_b16_e32 v27.l, v33.l
	v_cndmask_b32_e64 v44, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v19.l
	v_bfe_i32 v62, v28, 0, 1
	v_mov_b16_e32 v19.l, v29.l
	v_mov_b16_e32 v29.l, v42.l
	v_and_b16 v17.h, 0xff, v25.l
	v_cndmask_b32_e64 v61, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v59.l
	v_mov_b16_e32 v31.l, v44.l
	v_mov_b16_e32 v33.l, v62.l
	v_lshlrev_b16 v27.h, 8, v18.l
	v_lshlrev_b16 v29.l, 8, v29.l
	v_cndmask_b32_e64 v59, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v20.l
	v_mov_b16_e32 v20.l, v32.l
	v_mov_b16_e32 v32.l, v61.l
	v_and_b16 v28.h, 0xff, v19.l
	v_lshlrev_b16 v29.h, 8, v19.l
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v30.l
	v_mov_b16_e32 v30.l, v43.l
	v_lshlrev_b16 v31.l, 8, v31.l
	v_lshlrev_b16 v32.l, 8, v32.l
	v_and_b16 v36.h, 0xff, v33.l
	v_cndmask_b32_e64 v64, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.h
	v_lshlrev_b16 v30.l, 8, v30.l
	v_or_b16 v17.h, v17.h, v29.l
	v_and_b16 v26.h, 0xff, v21.l
	v_mov_b16_e32 v19.l, v64.l
	v_cndmask_b32_e64 v65, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v60.l
	v_and_b16 v21.h, 0xff, v23.l
	v_bfe_i32 v70, v35, 0, 1
	v_bfe_i32 v75, v40, 0, 1
	v_and_b16 v30.h, 0xff, v20.l
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v22.l
	v_lshlrev_b16 v22.l, 8, v23.l
	v_mov_b16_e32 v23.l, v36.l
	v_mov_b16_e32 v35.l, v65.l
	v_mov_b16_e32 v36.l, v66.l
	v_cndmask_b32_e64 v67, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v34.l
	v_mov_b16_e32 v34.l, v63.l
	v_lshlrev_b16 v31.h, 8, v20.l
	v_mov_b16_e32 v20.l, v60.l
	v_lshlrev_b16 v38.h, 8, v19.l
	v_cndmask_b32_e64 v68, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v22.h
	v_lshlrev_b16 v34.l, 8, v34.l
	v_or_b16 v19.l, v36.h, v32.l
	v_mov_b16_e32 v45.l, v75.l
	v_lshlrev_b16 v35.l, 8, v35.l
	v_cndmask_b32_e64 v69, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v37.l
	v_mov_b16_e32 v37.l, v67.l
	v_and_b16 v39.h, 0xff, v36.l
	v_lshlrev_b16 v40.h, 8, v20.l
	v_or_b16 v20.l, v26.h, v34.l
	v_cndmask_b32_e64 v71, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v23.h
	v_mov_b16_e32 v28.l, v38.l
	v_and_b16 v32.h, 0xff, v27.l
	v_mov_b16_e32 v38.l, v68.l
	v_mov_b16_e32 v40.l, v70.l
	v_cndmask_b32_e64 v72, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v39.l
	v_mov_b16_e32 v39.l, v69.l
	v_lshlrev_b16 v37.l, 8, v37.l
	v_and_b16 v43.h, 0xff, v45.l
	v_and_b16 v22.h, 0xff, v24.l
	v_cndmask_b32_e64 v73, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v24.h
	v_lshlrev_b16 v24.h, 8, v25.l
	v_and_b16 v25.l, 0xff, v18.l
	v_mov_b16_e32 v18.l, v59.l
	v_mov_b16_e32 v43.l, v73.l
	v_cndmask_b32_e64 v74, 0, -1, vcc_lo
	v_lshlrev_b16 v23.h, 8, v24.l
	v_mov_b16_e32 v24.l, v41.l
	v_lshlrev_b16 v37.h, 8, v18.l
	v_or_b16 v18.l, v25.h, v30.l
	v_mov_b16_e32 v44.l, v74.l
	v_lshlrev_b16 v42.h, 8, v43.l
	v_and_b16 v33.h, 0xff, v23.l
	v_mov_b16_e32 v41.l, v71.l
	v_or_b32_e32 v18, v18, v17
	v_or_b16 v17.h, v25.l, v31.l
	v_lshlrev_b16 v43.l, 8, v44.l
	v_lshlrev_b16 v44.l, 8, v45.l
	v_or_b16 v45.l, v39.h, v35.l
	v_mov_b16_e32 v42.l, v72.l
	v_or_b32_e32 v19, v19, v17
	v_or_b16 v17.h, v28.h, v37.h
	v_lshlrev_b16 v38.l, 8, v38.l
	v_lshlrev_b16 v39.l, 8, v39.l
	v_and_b16 v41.h, 0xff, v40.l
	v_or_b16 v46.l, v21.h, v37.l
	v_or_b32_e32 v20, v20, v17
	v_or_b16 v17.h, v30.h, v38.h
	v_and_b16 v34.h, 0xff, v28.l
	v_lshlrev_b16 v41.l, 8, v41.l
	v_lshlrev_b16 v42.l, 8, v42.l
	v_or_b16 v47.l, v41.h, v39.l
	v_or_b32_e32 v25, v45, v17
	v_or_b16 v17.h, v32.h, v40.h
	v_and_b16 v35.h, 0xff, v24.l
	v_or_b16 v48.l, v22.h, v42.l
	v_or_b16 v49.l, v43.h, v43.l
	v_lshlrev_b16 v21.l, 8, v21.l
	v_or_b32_e32 v45, v46, v17
	v_or_b16 v17.h, v33.h, v38.l
	v_lshlrev_b16 v33.l, 8, v33.l
	v_lshlrev_b16 v27.l, 8, v27.l
	v_lshlrev_b16 v23.l, 8, v23.l
	v_lshlrev_b16 v28.l, 8, v28.l
	v_or_b32_e32 v46, v47, v17
	v_or_b16 v17.h, v34.h, v41.l
	v_lshlrev_b16 v36.l, 8, v36.l
	v_lshlrev_b16 v40.l, 8, v40.l
	v_lshlrev_b16 v24.l, 8, v24.l
	v_add_co_u32 v8, vcc_lo, 0x480, v8
	v_or_b32_e32 v47, v48, v17
	v_or_b16 v17.h, v35.h, v42.h
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_or_b32_e32 v17, v49, v17
	s_waitcnt vmcnt(7)
	v_xor_b32_e32 v18, v51, v18
	s_waitcnt vmcnt(6)
	v_xor_b32_e32 v48, v52, v19
	s_waitcnt vmcnt(5)
	v_xor_b32_e32 v49, v53, v20
	s_waitcnt vmcnt(4)
	v_xor_b32_e32 v51, v54, v25
	s_waitcnt vmcnt(3)
	v_xor_b32_e32 v45, v55, v45
	s_waitcnt vmcnt(2)
	v_xor_b32_e32 v46, v56, v46
	s_waitcnt vmcnt(1)
	v_xor_b32_e32 v47, v57, v47
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v52, v58, v17
	v_and_b16 v17.l, 0xff00, v18.l
	v_lshlrev_b16 v17.h, 8, v18.l
	v_and_b16 v18.l, 0xff00, v18.h
	v_lshlrev_b16 v18.h, 8, v18.h
	v_and_b16 v19.l, 0xff00, v48.l
	v_lshlrev_b16 v19.h, 8, v48.l
	v_and_b16 v20.l, 0xff00, v48.h
	v_lshlrev_b16 v20.h, 8, v48.h
	v_and_b16 v21.h, 0xff00, v49.l
	v_lshlrev_b16 v22.h, 8, v49.l
	v_and_b16 v25.l, 0xff00, v49.h
	v_lshlrev_b16 v25.h, 8, v49.h
	v_and_b16 v26.h, 0xff00, v51.l
	v_lshlrev_b16 v28.h, 8, v51.l
	v_and_b16 v30.h, 0xff00, v51.h
	v_lshlrev_b16 v32.h, 8, v51.h
	v_and_b16 v33.h, 0xff00, v45.l
	v_lshlrev_b16 v34.h, 8, v45.l
	v_and_b16 v35.h, 0xff00, v45.h
	v_lshlrev_b16 v36.h, 8, v45.h
	v_and_b16 v39.h, 0xff00, v46.l
	v_lshlrev_b16 v41.h, 8, v46.l
	v_and_b16 v43.h, 0xff00, v46.h
	v_lshlrev_b16 v44.h, 8, v46.h
	v_and_b16 v45.l, 0xff00, v47.l
	v_lshlrev_b16 v45.h, 8, v47.l
	v_and_b16 v46.l, 0xff00, v47.h
	v_lshlrev_b16 v46.h, 8, v47.h
	v_sub_nc_i16 v17.l, v17.l, v30.l clamp
	v_sub_nc_i16 v26.l, v17.h, v26.l clamp
	v_sub_nc_i16 v18.l, v18.l, v29.l clamp
	v_sub_nc_i16 v29.l, v18.h, v24.h clamp
	v_sub_nc_i16 v19.l, v19.l, v32.l clamp
	v_sub_nc_i16 v30.l, v19.h, v33.l clamp
	v_sub_nc_i16 v20.l, v20.l, v31.l clamp
	v_sub_nc_i16 v31.l, v20.h, v27.h clamp
	v_sub_nc_i16 v32.l, v21.h, v34.l clamp
	v_sub_nc_i16 v21.l, v22.h, v21.l clamp
	v_sub_nc_i16 v25.l, v25.l, v37.h clamp
	v_sub_nc_i16 v33.l, v25.h, v29.h clamp
	v_and_b16 v47.l, 0xff00, v52.l
	v_lshlrev_b16 v47.h, 8, v52.l
	v_and_b16 v48.l, 0xff00, v52.h
	v_lshlrev_b16 v48.h, 8, v52.h
	v_sub_nc_i16 v34.l, v26.h, v35.l clamp
	v_sub_nc_i16 v35.l, v28.h, v36.l clamp
	v_sub_nc_i16 v36.l, v30.h, v38.h clamp
	v_sub_nc_i16 v49.l, v32.h, v31.h clamp
	v_sub_nc_i16 v37.l, v33.h, v37.l clamp
	v_sub_nc_i16 v22.l, v34.h, v22.l clamp
	v_sub_nc_i16 v51.l, v35.h, v40.h clamp
	v_sub_nc_i16 v27.l, v36.h, v27.l clamp
	v_sub_nc_i16 v39.l, v39.h, v39.l clamp
	v_sub_nc_i16 v40.l, v41.h, v40.l clamp
	v_sub_nc_i16 v38.l, v43.h, v38.l clamp
	v_sub_nc_i16 v23.l, v44.h, v23.l clamp
	v_sub_nc_i16 v42.l, v45.l, v42.l clamp
	v_sub_nc_i16 v45.l, v45.h, v23.h clamp
	v_sub_nc_i16 v41.l, v46.l, v41.l clamp
	v_sub_nc_i16 v28.l, v46.h, v28.l clamp
	v_perm_b32 v17, v26, v17, 0xc0c0105
	v_perm_b32 v18, v29, v18, 0xc0c0105
	v_perm_b32 v19, v30, v19, 0xc0c0105
	v_perm_b32 v20, v31, v20, 0xc0c0105
	v_perm_b32 v21, v21, v32, 0xc0c0105
	v_perm_b32 v25, v33, v25, 0xc0c0105
	v_sub_nc_i16 v43.l, v47.l, v43.l clamp
	v_sub_nc_i16 v44.l, v47.h, v44.l clamp
	v_sub_nc_i16 v46.l, v48.l, v42.h clamp
	v_sub_nc_i16 v24.l, v48.h, v24.l clamp
	v_perm_b32 v26, v35, v34, 0xc0c0105
	v_perm_b32 v29, v49, v36, 0xc0c0105
	v_perm_b32 v22, v22, v37, 0xc0c0105
	v_perm_b32 v27, v27, v51, 0xc0c0105
	v_perm_b32 v30, v40, v39, 0xc0c0105
	v_perm_b32 v23, v23, v38, 0xc0c0105
	v_perm_b32 v31, v45, v42, 0xc0c0105
	v_perm_b32 v28, v28, v41, 0xc0c0105
	v_lshl_or_b32 v17, v18, 16, v17
	v_lshl_or_b32 v18, v20, 16, v19
	v_lshl_or_b32 v19, v25, 16, v21
	v_perm_b32 v32, v44, v43, 0xc0c0105
	v_perm_b32 v24, v24, v46, 0xc0c0105
	v_lshl_or_b32 v20, v29, 16, v26
	v_lshl_or_b32 v21, v27, 16, v22
	v_lshl_or_b32 v22, v23, 16, v30
	v_lshl_or_b32 v23, v28, 16, v31
	v_dot4_i32_iu8 v1, v17, v1, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v3, v19, v3, 0 neg_lo:[1,1,0]
	v_lshl_or_b32 v24, v24, 16, v32
	v_dot4_i32_iu8 v5, v21, v5, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v7, v23, v7, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v1, v18, v2, v1 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v2, v20, v4, v3 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_dot4_i32_iu8 v3, v22, v6, v5 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v4, v24, v16, v7 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v5, 28, v50
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v1, v2, v1
	v_add3_u32 v4, v1, v4, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v1, 31, v4
	v_add_nc_u32_e32 v1, v4, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 1, v1
	v_mad_u64_u32 v[2:3], null, v4, v5, v[1:2]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v1, 31, v2
	v_add_nc_u32_e32 v1, v2, v1
	v_cvt_f32_f16_e32 v2, v0.l
	v_cvt_f32_f16_e32 v0, v0.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_ashrrev_i32_e32 v1, 1, v1
	v_mul_f32_e32 v0, v0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_f32_i32_e32 v1, v1
	v_fmac_f32_e32 v11, v0, v1
	s_and_not1_b32 exec_lo, exec_lo, s4
	s_cbranch_execnz .LBB6_2
; %bb.3:
	s_or_b32 exec_lo, exec_lo, s4
.LBB6_4:
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s8
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v12
	v_cmpx_ne_u32_e32 0, v12
	s_cbranch_execz .LBB6_6
; %bb.5:
	v_lshlrev_b32_e32 v0, 7, v12
	v_lshlrev_b32_e32 v1, 2, v10
	s_delay_alu instid0(VALU_DEP_1)
	v_add3_u32 v0, v0, v1, 0xffffff80
	ds_store_b32 v0, v11
.LBB6_6:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB6_24
; %bb.7:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, 0
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB6_10
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB6_11
.LBB6_9:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr0
	s_branch .LBB6_20
.LBB6_10:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB6_9
.LBB6_11:
	v_mbcnt_lo_u32_b32 v0, -1, 0
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_xor_b32_e32 v1, 16, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v1
	v_cndmask_b32_e32 v1, v0, v1, vcc_lo
	v_lshlrev_b32_e32 v1, 2, v1
	ds_bpermute_b32 v2, v1, v11
	v_mov_b32_e32 v1, 32
	s_cbranch_scc0 .LBB6_13
; %bb.12:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB6_14
	s_branch .LBB6_19
.LBB6_13:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB6_19
.LBB6_14:
	v_xor_b32_e32 v3, 8, v0
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v11, v2
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v3
	v_cndmask_b32_e32 v3, v0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v3, 2, v3
	ds_bpermute_b32 v3, v3, v2
	s_cbranch_scc0 .LBB6_16
; %bb.15:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB6_17
	s_branch .LBB6_19
.LBB6_16:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB6_19
.LBB6_17:
	v_xor_b32_e32 v4, 4, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v4, v0, v4, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v2, v2, v3 :: v_dual_lshlrev_b32 v3, 2, v4
	ds_bpermute_b32 v3, v3, v2
	s_cbranch_scc0 .LBB6_25
; %bb.18:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB6_26
.LBB6_19:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
.LBB6_20:
	s_and_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB6_28
; %bb.21:
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB6_24
.LBB6_22:
	v_xor_b32_e32 v4, 1, v0
	s_mov_b32 s1, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_cmp_lt_i32_e32 vcc_lo, v4, v1
	s_waitcnt lgkmcnt(0)
	v_dual_cndmask_b32 v1, v0, v4 :: v_dual_add_f32 v0, v3, v2
	v_cmp_eq_u32_e32 vcc_lo, 0, v10
	v_lshlrev_b32_e32 v1, 2, v1
	ds_bpermute_b32 v1, v1, v0
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB6_24
; %bb.23:
	s_mul_i32 s0, s11, s3
	v_mov_b32_e32 v2, 0
	s_lshl_b64 s[0:1], s[0:1], 2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v0, v0, v1
	s_add_u32 s4, s6, s0
	s_addc_u32 s5, s7, s1
	s_ashr_i32 s3, s2, 31
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_lshl_b64 s[0:1], s[2:3], 2
	s_add_u32 s0, s4, s0
	s_addc_u32 s1, s5, s1
	global_store_b32 v2, v0, s[0:1]
.LBB6_24:
	s_endpgm
.LBB6_25:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB6_19
.LBB6_26:
	v_xor_b32_e32 v4, 2, v0
	s_cmp_lg_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v2, v3
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v4, v0, v4, vcc_lo
	v_lshlrev_b32_e32 v2, 2, v4
	ds_bpermute_b32 v2, v2, v3
	s_cbranch_scc0 .LBB6_32
; %bb.27:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_branch .LBB6_20
.LBB6_28:
	s_cbranch_execnz .LBB6_30
; %bb.29:
	; divergent unreachable
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB6_22
	s_branch .LBB6_24
.LBB6_30:
	s_trap 2
	s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)
	s_mov_b32 ttmp2, m0
	s_waitcnt lgkmcnt(0)
	s_and_b32 s0, s0, 0x3ff
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_bitset1_b32 s0, 10
	s_mov_b32 m0, s0
	s_sendmsg sendmsg(MSG_INTERRUPT)
	s_mov_b32 m0, ttmp2
.LBB6_31:                               ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB6_31
.LBB6_32:
	s_mov_b32 s1, 0
	s_mov_b32 s0, -1
	s_branch .LBB6_20
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
		.amdhsa_group_segment_fixed_size 128
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 48
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 1
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 1
		.amdhsa_next_free_vgpr 76
		.amdhsa_next_free_sgpr 15
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_dx10_clamp 1
		.amdhsa_ieee_mode 1
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_shared_vgpr_count 0
		.amdhsa_inst_pref_size 30
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end6:
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj, .Lfunc_end6-_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj.num_vgpr, 76
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 15
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 3816
; TotalNumSgprs: 17
; NumVgprs: 76
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 128 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 9
; NumSGPRsForWavesPerEU: 17
; NumVGPRsForWavesPerEU: 76
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_clause 0x1
	s_load_b128 s[12:15], s[0:1], 0x20
	s_load_b256 s[4:11], s[0:1], 0x0
	v_bfe_u32 v17, v0, 10, 10
	v_dual_mov_b32 v15, 0 :: v_dual_and_b32 v14, 0x3ff, v0
	v_mov_b32_e32 v16, 0
	s_mov_b32 s1, exec_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v0, v17, 5, v14
	v_lshrrev_b32_e32 v18, 3, v0
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s12, s12, 8
	s_delay_alu instid0(VALU_DEP_1) | instid1(SALU_CYCLE_1)
	v_cmpx_gt_u32_e64 s12, v18
	s_cbranch_execz .LBB7_4
; %bb.1:
	v_lshl_add_u32 v0, v17, 5, v14
	s_mul_i32 s0, s14, s3
	v_and_b32_e32 v4, 7, v14
	s_mul_hi_u32 s17, s0, 36
	s_mul_i32 s16, s0, 36
	v_lshrrev_b32_e32 v2, 3, v0
	s_mul_i32 s14, s13, s2
	s_mov_b32 s13, 0
	v_dual_mov_b32 v15, 0 :: v_dual_mov_b32 v16, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mad_u64_u32 v[0:1], null, 0x120, v2, s[16:17]
	v_lshlrev_b32_e32 v2, 1, v14
	v_and_b32_e32 v5, 14, v2
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mad_u64_u32 v[2:3], null, v4, 36, v[0:1]
	v_lshlrev_b32_e32 v0, 1, v5
	v_lshlrev_b32_e32 v19, 1, v5
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v1, vcc_lo, s8, v2
	v_add_co_ci_u32_e64 v2, null, s9, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_lshlrev_b32_e32 v20, 1, v0
	v_add_co_u32 v8, vcc_lo, v1, 32
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v9, null, 0, v2, vcc_lo
.LBB7_2:                                ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v23, s14, v18
	s_getpc_b64 s[8:9]
	s_add_u32 s8, s8, _ZL11iq3xxs_grid@rel32@lo+4
	s_addc_u32 s9, s9, _ZL11iq3xxs_grid@rel32@hi+12
	v_mov_b16_e32 v21.l, 0
	v_add_nc_u32_e32 v18, 4, v18
	v_mad_i64_i32 v[10:11], null, 0x42, v23, s[4:5]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v0, vcc_lo, v10, v20
	v_add_co_ci_u32_e64 v1, null, 0, v11, vcc_lo
	global_load_b64 v[12:13], v[0:1], off
	v_add_co_u32 v0, vcc_lo, v10, v19
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v1, null, 0, v11, vcc_lo
	global_load_b32 v24, v[0:1], off offset:64
	s_waitcnt vmcnt(1)
	v_and_b32_e32 v0, 0xff, v12
	v_lshlrev_b32_e32 v0, 2, v0
	global_load_b32 v4, v0, s[8:9]
	v_lshrrev_b32_e32 v0, 6, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	v_and_b32_e32 v0, 0x3fc, v0
	global_load_b32 v27, v0, s[8:9]
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v0, 0xff, v24
	v_bcnt_u32_b32 v1, v0, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v1, 1, v1
	v_lshlrev_b32_e32 v1, 7, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v0, v1, v0
	v_mul_lo_u32 v25, 0x1010101, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_and_b32_e32 v0, 0x8040201, v25
	v_bfe_i32 v2, v25, 0, 1
	v_and_b32_e32 v26, 0x80402010, v25
	v_lshrrev_b32_e32 v1, 24, v0
	v_lshrrev_b16 v0.l, 8, v0.l
	s_delay_alu instid0(VALU_DEP_3)
	v_lshrrev_b32_e32 v29, 24, v26
	v_lshrrev_b16 v30.l, 4, v26.l
	v_mov_b16_e32 v29.h, v21.l
	v_cmp_ne_u16_e64 s0, 0, v1.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v0.l
	v_lshrrev_b32_e32 v0, 18, v25
	v_lshrrev_b32_e32 v25, 22, v25
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_4)
	v_cndmask_b32_e64 v1, 0, -1, s0
	v_cndmask_b32_e64 v3, 0, -1, vcc_lo
	v_bfe_i32 v0, v0, 0, 1
	v_mov_b16_e32 v3.h, v21.l
	v_cmp_ne_u16_e64 s0, 0, v29.l
	v_lshlrev_b16 v1.l, 8, v1.l
	v_lshlrev_b16 v1.h, 8, v3.l
	v_and_b16 v0.h, 0xff, v0.l
	v_lshlrev_b16 v0.l, 8, v0.l
	v_bfe_i32 v25, v25, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b16 v21.h, v0.h, v1.l
	v_and_b16 v0.h, 0xff, v2.l
	v_or_b16 v3.l, v0.h, v1.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v3, v3, v21
	s_waitcnt vmcnt(1)
	v_xor_b32_e32 v3, v4, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v0.h, 0xff00, v3.l
	v_sub_nc_i16 v4.l, v0.h, v1.h clamp
	v_lshlrev_b16 v0.h, 8, v3.l
	v_lshlrev_b16 v1.h, 8, v2.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v2.l, v0.h, v1.h clamp
	v_and_b16 v0.h, 0xff00, v3.h
	v_perm_b32 v2, v2, v4, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v1.l, v0.h, v1.l clamp
	v_lshlrev_b16 v0.h, 8, v3.h
	v_sub_nc_i16 v0.l, v0.h, v0.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v0, v0, v1, 0xc0c0105
	v_lshl_or_b32 v28, v0, 16, v2
	s_clause 0x2
	global_load_b128 v[4:7], v[8:9], off offset:-32
	global_load_b32 v22, v[8:9], off
	global_load_b128 v[0:3], v[8:9], off offset:-16
	s_waitcnt vmcnt(2)
	v_lshrrev_b16 v4.h, 8, v26.l
	v_cndmask_b32_e64 v26, 0, -1, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	v_and_b16 v4.h, 0xff, v25.l
	v_lshlrev_b16 v25.h, 8, v26.l
	v_cndmask_b32_e64 v26, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_or_b16 v21.h, v4.h, v25.h
	v_lshlrev_b16 v4.h, 8, v26.l
	v_bfe_i32 v26, v30, 0, 1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v26.h, 0xff, v26.l
	v_or_b16 v29.l, v26.h, v4.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b32_e32 v29, v29, v21
	v_xor_b32_e32 v27, v27, v29
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v21.h, 0xff00, v27.l
	v_sub_nc_i16 v29.l, v21.h, v4.h clamp
	v_lshlrev_b16 v4.h, 8, v27.l
	v_lshlrev_b16 v21.h, 8, v26.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_sub_nc_i16 v26.l, v4.h, v21.h clamp
	v_and_b16 v4.h, 0xff00, v27.h
	v_lshlrev_b16 v21.h, 8, v25.l
	v_perm_b32 v26, v26, v29, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v27.l, v4.h, v25.h clamp
	v_lshlrev_b16 v4.h, 8, v27.h
	v_sub_nc_i16 v25.l, v4.h, v21.h clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_perm_b32 v25, v25, v27, 0xc0c0105
	v_lshrrev_b32_e32 v27, 14, v12
	v_lshrrev_b32_e32 v12, 22, v12
	v_lshl_or_b32 v26, v25, 16, v26
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_and_b32_e32 v27, 0x3fc, v27
	v_and_b32_e32 v12, 0x3fc, v12
	s_clause 0x1
	global_load_b32 v29, v27, s[8:9]
	global_load_b32 v30, v12, s[8:9]
	v_bfe_u32 v12, v24, 7, 8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_bcnt_u32_b32 v27, v12, 0
	v_and_b32_e32 v27, 1, v27
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v27, 7, v27
	v_xor_b32_e32 v12, v27, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v31, 0x1010101, v12
	v_and_b32_e32 v12, 0x8040201, v31
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshrrev_b32_e32 v27, 24, v12
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b32_e32 v12, 18, v31
	v_cmp_ne_u16_e64 s0, 0, v27.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	v_bfe_i32 v12, v12, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cndmask_b32_e64 v27, 0, -1, s0
	v_and_b16 v4.h, 0xff, v12.l
	v_lshlrev_b16 v12.l, 8, v12.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_lshlrev_b16 v12.h, 8, v27.l
	v_bfe_i32 v27, v31, 0, 1
	v_or_b16 v21.h, v4.h, v12.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_4) | instid1(VALU_DEP_3)
	v_and_b16 v4.h, 0xff, v27.l
	v_dot4_i32_iu8 v25, v28, v5, 0 neg_lo:[1,1,0]
	v_cndmask_b32_e64 v28, 0, -1, vcc_lo
	v_mov_b16_e32 v28.h, v21.l
	v_dot4_i32_iu8 v26, v26, v6, 0 neg_lo:[1,1,0]
	v_lshlrev_b16 v27.h, 8, v28.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_nc_u32_e32 v25, v25, v26
	v_lshrrev_b32_e32 v26, 28, v24
	v_or_b16 v28.l, v4.h, v27.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_or_b32_e32 v28, v28, v21
	v_lshlrev_b16 v21.h, 8, v27.l
	s_waitcnt vmcnt(1)
	v_xor_b32_e32 v28, v29, v28
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v4.h, 0xff00, v28.l
	v_sub_nc_i16 v29.l, v4.h, v27.h clamp
	v_lshlrev_b16 v4.h, 8, v28.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v27.l, v4.h, v21.h clamp
	v_and_b16 v4.h, 0xff00, v28.h
	v_perm_b32 v27, v27, v29, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v28.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v28.h
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v12, v12, v28, 0xc0c0105
	v_lshl_or_b32 v28, v12, 16, v27
	v_and_b32_e32 v12, 0x80402010, v31
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_4)
	v_lshrrev_b32_e32 v27, 24, v12
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b16 v29.l, 4, v12.l
	v_lshrrev_b32_e32 v12, 22, v31
	v_cmp_ne_u16_e64 s0, 0, v27.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	v_bfe_i32 v12, v12, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cndmask_b32_e64 v27, 0, -1, s0
	v_and_b16 v4.h, 0xff, v12.l
	v_lshlrev_b16 v12.l, 8, v12.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_lshlrev_b16 v12.h, 8, v27.l
	v_cndmask_b32_e64 v27, 0, -1, vcc_lo
	v_or_b16 v21.h, v4.h, v12.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_lshlrev_b16 v4.h, 8, v27.l
	v_bfe_i32 v27, v29, 0, 1
	v_mov_b16_e32 v29.h, v21.l
	v_and_b16 v27.h, 0xff, v27.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v29.l, v27.h, v4.h
	v_or_b32_e32 v29, v29, v21
	s_waitcnt vmcnt(0)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v29, v30, v29
	v_and_b16 v21.h, 0xff00, v29.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v30.l, v21.h, v4.h clamp
	v_lshlrev_b16 v4.h, 8, v29.l
	v_lshlrev_b16 v21.h, 8, v27.l
	v_sub_nc_i16 v27.l, v4.h, v21.h clamp
	v_and_b16 v4.h, 0xff00, v29.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v27, v27, v30, 0xc0c0105
	v_sub_nc_i16 v29.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v29.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	v_perm_b32 v12, v12, v29, 0xc0c0105
	v_dot4_i32_iu8 v29, v28, v7, 0 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v12, v12, 16, v27
	v_dot4_i32_iu8 v30, v12, v0, 0 neg_lo:[1,1,0]
	v_and_b32_e32 v12, 0xff, v13
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add3_u32 v25, v25, v30, v29
	v_lshlrev_b32_e32 v12, 2, v12
	global_load_b32 v31, v12, s[8:9]
	v_lshrrev_b32_e32 v12, 6, v13
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_and_b32_e32 v12, 0x3fc, v12
	global_load_b32 v32, v12, s[8:9]
	v_bfe_u32 v12, v24, 14, 8
	v_bcnt_u32_b32 v27, v12, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v27, 1, v27
	v_lshlrev_b32_e32 v27, 7, v27
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v12, v27, v12
	v_mul_lo_u32 v33, 0x1010101, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v12, 0x8040201, v33
	v_lshrrev_b32_e32 v27, 24, v12
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b32_e32 v12, 18, v33
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e64 s0, 0, v27.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_bfe_i32 v12, v12, 0, 1
	v_cndmask_b32_e64 v27, 0, -1, s0
	v_cndmask_b32_e64 v28, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_3)
	v_and_b16 v4.h, 0xff, v12.l
	v_mov_b16_e32 v28.h, v21.l
	v_lshlrev_b16 v12.l, 8, v12.l
	v_lshlrev_b16 v12.h, 8, v27.l
	v_bfe_i32 v27, v33, 0, 1
	v_lshlrev_b16 v27.h, 8, v28.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_or_b16 v21.h, v4.h, v12.h
	v_and_b16 v4.h, 0xff, v27.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v28.l, v4.h, v27.h
	v_or_b32_e32 v28, v28, v21
	v_lshlrev_b16 v21.h, 8, v27.l
	s_waitcnt vmcnt(1)
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v28, v31, v28
	v_and_b16 v4.h, 0xff00, v28.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v31.l, v4.h, v27.h clamp
	v_lshlrev_b16 v4.h, 8, v28.l
	v_sub_nc_i16 v27.l, v4.h, v21.h clamp
	v_and_b16 v4.h, 0xff00, v28.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v27, v27, v31, 0xc0c0105
	v_sub_nc_i16 v28.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v28.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	v_perm_b32 v12, v12, v28, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_lshl_or_b32 v28, v12, 16, v27
	v_and_b32_e32 v12, 0x80402010, v33
	v_dot4_i32_iu8 v28, v28, v1, 0 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_4)
	v_lshrrev_b32_e32 v27, 24, v12
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b16 v31.l, 4, v12.l
	v_lshrrev_b32_e32 v12, 22, v33
	v_cmp_ne_u16_e64 s0, 0, v27.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	v_bfe_i32 v12, v12, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cndmask_b32_e64 v27, 0, -1, s0
	v_and_b16 v4.h, 0xff, v12.l
	v_lshlrev_b16 v12.l, 8, v12.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_lshlrev_b16 v12.h, 8, v27.l
	v_cndmask_b32_e64 v27, 0, -1, vcc_lo
	v_or_b16 v21.h, v4.h, v12.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_lshlrev_b16 v4.h, 8, v27.l
	v_bfe_i32 v27, v31, 0, 1
	v_mov_b16_e32 v31.h, v21.l
	v_and_b16 v27.h, 0xff, v27.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v31.l, v27.h, v4.h
	v_or_b32_e32 v31, v31, v21
	s_waitcnt vmcnt(0)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v31, v32, v31
	v_and_b16 v21.h, 0xff00, v31.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v32.l, v21.h, v4.h clamp
	v_lshlrev_b16 v4.h, 8, v31.l
	v_lshlrev_b16 v21.h, 8, v27.l
	v_sub_nc_i16 v27.l, v4.h, v21.h clamp
	v_and_b16 v4.h, 0xff00, v31.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v27, v27, v32, 0xc0c0105
	v_sub_nc_i16 v31.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v31.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	v_perm_b32 v12, v12, v31, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v12, v12, 16, v27
	v_dot4_i32_iu8 v31, v12, v2, 0 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v12, 14, v13
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add3_u32 v25, v25, v31, v28
	v_and_b32_e32 v12, 0x3fc, v12
	global_load_b32 v32, v12, s[8:9]
	v_lshrrev_b32_e32 v12, 22, v13
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_and_b32_e32 v12, 0x3fc, v12
	global_load_b32 v33, v12, s[8:9]
	v_bfe_u32 v12, v24, 21, 8
	v_bcnt_u32_b32 v13, v12, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v13, 1, v13
	v_lshlrev_b32_e32 v13, 7, v13
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v12, v13, v12
	v_mul_lo_u32 v34, 0x1010101, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v12, 0x8040201, v34
	v_lshrrev_b32_e32 v13, 24, v12
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b32_e32 v12, 18, v34
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e64 s0, 0, v13.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_bfe_i32 v12, v12, 0, 1
	v_cndmask_b32_e64 v13, 0, -1, s0
	v_cndmask_b32_e64 v27, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_3)
	v_and_b16 v4.h, 0xff, v12.l
	v_mov_b16_e32 v27.h, v21.l
	v_lshlrev_b16 v12.l, 8, v12.l
	v_lshlrev_b16 v12.h, 8, v13.l
	v_bfe_i32 v13, v34, 0, 1
	v_lshlrev_b16 v13.h, 8, v27.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_or_b16 v21.h, v4.h, v12.h
	v_and_b16 v4.h, 0xff, v13.l
	v_lshlrev_b16 v13.l, 8, v13.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v27.l, v4.h, v13.h
	v_or_b32_e32 v27, v27, v21
	s_waitcnt vmcnt(1)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v27, v32, v27
	v_and_b16 v4.h, 0xff00, v27.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v32.l, v4.h, v13.h clamp
	v_lshlrev_b16 v4.h, 8, v27.l
	v_sub_nc_i16 v13.l, v4.h, v13.l clamp
	v_and_b16 v4.h, 0xff00, v27.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v13, v13, v32, 0xc0c0105
	v_sub_nc_i16 v27.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v27.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	v_perm_b32 v12, v12, v27, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v27, v12, 16, v13
	v_and_b32_e32 v12, 0x80402010, v34
	v_lshrrev_b32_e32 v13, 24, v12
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b16 v32.l, 4, v12.l
	v_lshrrev_b32_e32 v12, 22, v34
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_cmp_ne_u16_e64 s0, 0, v13.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_bfe_i32 v12, v12, 0, 1
	v_cndmask_b32_e64 v13, 0, -1, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_and_b16 v4.h, 0xff, v12.l
	v_lshlrev_b16 v12.l, 8, v12.l
	v_lshlrev_b16 v12.h, 8, v13.l
	v_cndmask_b32_e64 v13, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_or_b16 v21.h, v4.h, v12.h
	v_lshlrev_b16 v4.h, 8, v13.l
	v_bfe_i32 v13, v32, 0, 1
	v_mov_b16_e32 v32.h, v21.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b16 v13.h, 0xff, v13.l
	v_lshlrev_b16 v13.l, 8, v13.l
	v_or_b16 v32.l, v13.h, v4.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v32, v32, v21
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v32, v33, v32
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v13.h, 0xff00, v32.l
	v_sub_nc_i16 v33.l, v13.h, v4.h clamp
	v_lshlrev_b16 v4.h, 8, v32.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v13.l, v4.h, v13.l clamp
	v_and_b16 v4.h, 0xff00, v32.h
	v_perm_b32 v13, v13, v33, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v32.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v32.h
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	global_load_d16_hi_b16 v4, v[10:11], off offset:64
	v_perm_b32 v12, v12, v32, 0xc0c0105
	v_mov_b16_e32 v32.h, v21.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_lshl_or_b32 v12, v12, 16, v13
	v_dot4_i32_iu8 v13, v27, v3, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v12, v12, v22, 0 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v13, v25, v12, v13
	v_lshrrev_b32_e32 v12, 31, v13
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v12, v13, v12
	v_ashrrev_i32_e32 v12, 1, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mad_u64_u32 v[24:25], null, v13, v26, v[12:13]
	v_lshrrev_b32_e32 v12, 31, v24
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v12, v24, v12
	v_ashrrev_i32_e32 v13, 1, v12
	s_waitcnt vmcnt(0)
	v_cvt_f32_f16_e32 v12, v4.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cvt_f32_i32_e32 v13, v13
	v_cvt_f32_f16_e32 v10, v4.h
	v_mul_f32_e32 v4, v10, v12
	v_mad_i64_i32 v[10:11], null, 0x42, v23, s[6:7]
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_fmac_f32_e32 v16, v4, v13
	v_add_co_u32 v23, vcc_lo, v10, v20
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v24, null, 0, v11, vcc_lo
	global_load_b64 v[26:27], v[23:24], off
	v_add_co_u32 v23, vcc_lo, v10, v19
	v_add_co_ci_u32_e64 v24, null, 0, v11, vcc_lo
	global_load_b32 v28, v[23:24], off offset:64
	s_waitcnt vmcnt(1)
	v_and_b32_e32 v23, 0xff, v26
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v23, 2, v23
	global_load_b32 v29, v23, s[8:9]
	v_lshrrev_b32_e32 v23, 6, v26
	v_and_b32_e32 v23, 0x3fc, v23
	global_load_b32 v30, v23, s[8:9]
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v23, 0xff, v28
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_bcnt_u32_b32 v24, v23, 0
	v_and_b32_e32 v24, 1, v24
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v24, 7, v24
	v_xor_b32_e32 v23, v24, v23
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v31, 0x1010101, v23
	v_and_b32_e32 v23, 0x8040201, v31
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshrrev_b32_e32 v24, 24, v23
	v_lshrrev_b16 v21.h, 8, v23.l
	v_lshrrev_b32_e32 v23, 18, v31
	v_cmp_ne_u16_e64 s0, 0, v24.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.h
	v_bfe_i32 v23, v23, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v24, 0, -1, s0
	v_cndmask_b32_e64 v25, 0, -1, vcc_lo
	v_and_b16 v21.h, 0xff, v23.l
	v_lshlrev_b16 v23.l, 8, v23.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshlrev_b16 v23.h, 8, v24.l
	v_bfe_i32 v24, v31, 0, 1
	v_lshlrev_b16 v25.l, 8, v25.l
	v_or_b16 v21.h, v21.h, v23.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b16 v24.h, 0xff, v24.l
	v_lshlrev_b16 v24.l, 8, v24.l
	v_or_b16 v32.l, v24.h, v25.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v32, v32, v21
	s_waitcnt vmcnt(1)
	v_xor_b32_e32 v29, v29, v32
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v21.h, 0xff00, v29.l
	v_sub_nc_i16 v25.l, v21.h, v25.l clamp
	v_lshlrev_b16 v21.h, 8, v29.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v24.l, v21.h, v24.l clamp
	v_and_b16 v21.h, 0xff00, v29.h
	v_perm_b32 v24, v24, v25, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v25.l, v21.h, v23.h clamp
	v_lshlrev_b16 v21.h, 8, v29.h
	v_sub_nc_i16 v23.l, v21.h, v23.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v23, v23, v25, 0xc0c0105
	v_lshl_or_b32 v29, v23, 16, v24
	v_and_b32_e32 v23, 0x80402010, v31
	s_delay_alu instid0(VALU_DEP_1)
	v_lshrrev_b32_e32 v24, 24, v23
	v_lshrrev_b16 v21.h, 8, v23.l
	v_lshrrev_b16 v25.l, 4, v23.l
	v_lshrrev_b32_e32 v23, 22, v31
	v_mov_b16_e32 v31.h, v21.l
	v_cmp_ne_u16_e64 s0, 0, v24.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.h
	v_bfe_i32 v25, v25, 0, 1
	v_bfe_i32 v23, v23, 0, 1
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cndmask_b32_e64 v24, 0, -1, s0
	v_and_b16 v21.h, 0xff, v23.l
	v_lshlrev_b16 v23.l, 8, v23.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshlrev_b16 v23.h, 8, v24.l
	v_cndmask_b32_e64 v24, 0, -1, vcc_lo
	v_and_b16 v24.h, 0xff, v25.l
	v_or_b16 v21.h, v21.h, v23.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b16 v24.l, 8, v24.l
	v_or_b16 v31.l, v24.h, v24.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v31, v31, v21
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v30, v30, v31
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v21.h, 0xff00, v30.l
	v_sub_nc_i16 v31.l, v21.h, v24.l clamp
	v_lshlrev_b16 v21.h, 8, v30.l
	v_lshlrev_b16 v24.l, 8, v25.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v24.l, v21.h, v24.l clamp
	v_and_b16 v21.h, 0xff00, v30.h
	v_perm_b32 v24, v24, v31, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v25.l, v21.h, v23.h clamp
	v_lshlrev_b16 v21.h, 8, v30.h
	v_sub_nc_i16 v23.l, v21.h, v23.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_perm_b32 v23, v23, v25, 0xc0c0105
	v_dot4_i32_iu8 v25, v29, v5, 0 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v5, 14, v26
	v_lshl_or_b32 v23, v23, 16, v24
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_and_b32_e32 v5, 0x3fc, v5
	v_dot4_i32_iu8 v29, v23, v6, 0 neg_lo:[1,1,0]
	global_load_b32 v30, v5, s[8:9]
	v_lshrrev_b32_e32 v5, 22, v26
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_and_b32_e32 v5, 0x3fc, v5
	global_load_b32 v26, v5, s[8:9]
	v_bfe_u32 v5, v28, 7, 8
	v_bcnt_u32_b32 v6, v5, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v6, 1, v6
	v_lshlrev_b32_e32 v6, 7, v6
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v5, v6, v5
	v_mul_lo_u32 v31, 0x1010101, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b32_e32 v5, 0x8040201, v31
	v_bfe_i32 v23, v31, 0, 1
	v_lshrrev_b32_e32 v6, 24, v5
	v_lshrrev_b16 v5.l, 8, v5.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cmp_ne_u16_e64 s0, 0, v6.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v5.l
	v_lshrrev_b32_e32 v5, 18, v31
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v6, 0, -1, s0
	v_cndmask_b32_e64 v24, 0, -1, vcc_lo
	v_bfe_i32 v5, v5, 0, 1
	v_mov_b16_e32 v24.h, v21.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b16 v6.l, 8, v6.l
	v_lshlrev_b16 v6.h, 8, v24.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b16 v5.h, 0xff, v5.l
	v_lshlrev_b16 v5.l, 8, v5.l
	v_or_b16 v21.h, v5.h, v6.l
	v_and_b16 v5.h, 0xff, v23.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v24.l, v5.h, v6.h
	v_or_b32_e32 v24, v24, v21
	s_waitcnt vmcnt(1)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v24, v30, v24
	v_and_b16 v5.h, 0xff00, v24.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v30.l, v5.h, v6.h clamp
	v_lshlrev_b16 v5.h, 8, v24.l
	v_lshlrev_b16 v6.h, 8, v23.l
	v_sub_nc_i16 v23.l, v5.h, v6.h clamp
	v_and_b16 v5.h, 0xff00, v24.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v23, v23, v30, 0xc0c0105
	v_sub_nc_i16 v6.l, v5.h, v6.l clamp
	v_lshlrev_b16 v5.h, 8, v24.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v5.l, v5.h, v5.l clamp
	v_perm_b32 v5, v5, v6, 0xc0c0105
	v_and_b32_e32 v6, 0x80402010, v31
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshl_or_b32 v24, v5, 16, v23
	v_lshrrev_b32_e32 v23, 24, v6
	v_lshrrev_b16 v5.l, 8, v6.l
	v_lshrrev_b16 v30.l, 4, v6.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e64 s0, 0, v23.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v5.l
	v_lshrrev_b32_e32 v5, 22, v31
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v6, 0, -1, s0
	v_cndmask_b32_e64 v23, 0, -1, vcc_lo
	v_bfe_i32 v5, v5, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshlrev_b16 v6.l, 8, v6.l
	v_and_b16 v5.h, 0xff, v5.l
	v_lshlrev_b16 v5.l, 8, v5.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_or_b16 v21.h, v5.h, v6.l
	v_lshlrev_b16 v5.h, 8, v23.l
	v_bfe_i32 v23, v30, 0, 1
	v_mov_b16_e32 v30.h, v21.l
	v_and_b16 v6.h, 0xff, v23.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v30.l, v6.h, v5.h
	v_or_b32_e32 v30, v30, v21
	s_waitcnt vmcnt(0)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v26, v26, v30
	v_and_b16 v6.h, 0xff00, v26.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v30.l, v6.h, v5.h clamp
	v_lshlrev_b16 v5.h, 8, v26.l
	v_lshlrev_b16 v6.h, 8, v23.l
	v_sub_nc_i16 v23.l, v5.h, v6.h clamp
	v_and_b16 v5.h, 0xff00, v26.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v23, v23, v30, 0xc0c0105
	v_sub_nc_i16 v6.l, v5.h, v6.l clamp
	v_lshlrev_b16 v5.h, 8, v26.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v5.l, v5.h, v5.l clamp
	v_perm_b32 v5, v5, v6, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_lshl_or_b32 v5, v5, 16, v23
	v_dot4_i32_iu8 v23, v24, v7, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v24, v5, v0, 0 neg_lo:[1,1,0]
	v_and_b32_e32 v0, 0xff, v27
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v0, 2, v0
	global_load_b32 v26, v0, s[8:9]
	v_lshrrev_b32_e32 v0, 6, v27
	v_and_b32_e32 v0, 0x3fc, v0
	global_load_b32 v30, v0, s[8:9]
	v_bfe_u32 v0, v28, 14, 8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_bcnt_u32_b32 v5, v0, 0
	v_and_b32_e32 v5, 1, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v5, 7, v5
	v_xor_b32_e32 v0, v5, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v31, 0x1010101, v0
	v_and_b32_e32 v0, 0x8040201, v31
	v_bfe_i32 v6, v31, 0, 1
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_lshrrev_b32_e32 v5, 24, v0
	v_lshrrev_b16 v0.l, 8, v0.l
	v_cmp_ne_u16_e64 s0, 0, v5.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v0.l
	v_lshrrev_b32_e32 v0, 18, v31
	v_cndmask_b32_e64 v5, 0, -1, s0
	v_cndmask_b32_e64 v7, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_4)
	v_bfe_i32 v0, v0, 0, 1
	v_mov_b16_e32 v7.h, v21.l
	v_lshlrev_b16 v5.l, 8, v5.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b16 v5.h, 8, v7.l
	v_and_b16 v0.h, 0xff, v0.l
	v_lshlrev_b16 v0.l, 8, v0.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b16 v21.h, v0.h, v5.l
	v_and_b16 v0.h, 0xff, v6.l
	v_or_b16 v7.l, v0.h, v5.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v7, v7, v21
	s_waitcnt vmcnt(1)
	v_xor_b32_e32 v7, v26, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v0.h, 0xff00, v7.l
	v_sub_nc_i16 v26.l, v0.h, v5.h clamp
	v_lshlrev_b16 v0.h, 8, v7.l
	v_lshlrev_b16 v5.h, 8, v6.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v6.l, v0.h, v5.h clamp
	v_and_b16 v0.h, 0xff00, v7.h
	v_perm_b32 v6, v6, v26, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v5.l, v0.h, v5.l clamp
	v_lshlrev_b16 v0.h, 8, v7.h
	v_sub_nc_i16 v0.l, v0.h, v0.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_perm_b32 v0, v0, v5, 0xc0c0105
	v_and_b32_e32 v5, 0x80402010, v31
	v_lshl_or_b32 v7, v0, 16, v6
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshrrev_b32_e32 v6, 24, v5
	v_lshrrev_b16 v0.l, 8, v5.l
	v_lshrrev_b16 v26.l, 4, v5.l
	v_cmp_ne_u16_e64 s0, 0, v6.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v0.l
	v_lshrrev_b32_e32 v0, 22, v31
	v_cndmask_b32_e64 v5, 0, -1, s0
	v_cndmask_b32_e64 v6, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_bfe_i32 v0, v0, 0, 1
	v_lshlrev_b16 v5.l, 8, v5.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b16 v0.h, 0xff, v0.l
	v_lshlrev_b16 v0.l, 8, v0.l
	v_or_b16 v21.h, v0.h, v5.l
	v_lshlrev_b16 v0.h, 8, v6.l
	v_bfe_i32 v6, v26, 0, 1
	v_mov_b16_e32 v26.h, v21.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v5.h, 0xff, v6.l
	v_or_b16 v26.l, v5.h, v0.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v26, v26, v21
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v26, v30, v26
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v5.h, 0xff00, v26.l
	v_sub_nc_i16 v30.l, v5.h, v0.h clamp
	v_lshlrev_b16 v0.h, 8, v26.l
	v_lshlrev_b16 v5.h, 8, v6.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v6.l, v0.h, v5.h clamp
	v_and_b16 v0.h, 0xff00, v26.h
	v_perm_b32 v6, v6, v30, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v5.l, v0.h, v5.l clamp
	v_lshlrev_b16 v0.h, 8, v26.h
	v_sub_nc_i16 v0.l, v0.h, v0.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v0, v0, v5, 0xc0c0105
	v_lshl_or_b32 v0, v0, 16, v6
	v_dot4_i32_iu8 v6, v7, v1, 0 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v7, v0, v2, 0 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v0, 14, v27
	v_and_b32_e32 v0, 0x3fc, v0
	global_load_b32 v26, v0, s[8:9]
	v_lshrrev_b32_e32 v0, 22, v27
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_and_b32_e32 v0, 0x3fc, v0
	global_load_b32 v27, v0, s[8:9]
	v_bfe_u32 v0, v28, 21, 8
	v_bcnt_u32_b32 v1, v0, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v1, 1, v1
	v_lshlrev_b32_e32 v1, 7, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v0, v1, v0
	v_mul_lo_u32 v30, 0x1010101, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b32_e32 v0, 0x8040201, v30
	v_bfe_i32 v2, v30, 0, 1
	v_lshrrev_b32_e32 v1, 24, v0
	v_lshrrev_b16 v0.l, 8, v0.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cmp_ne_u16_e64 s0, 0, v1.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v0.l
	v_lshrrev_b32_e32 v0, 18, v30
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v1, 0, -1, s0
	v_cndmask_b32_e64 v5, 0, -1, vcc_lo
	v_bfe_i32 v0, v0, 0, 1
	v_mov_b16_e32 v5.h, v21.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b16 v1.l, 8, v1.l
	v_lshlrev_b16 v1.h, 8, v5.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b16 v0.h, 0xff, v0.l
	v_lshlrev_b16 v0.l, 8, v0.l
	v_or_b16 v21.h, v0.h, v1.l
	v_and_b16 v0.h, 0xff, v2.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v5.l, v0.h, v1.h
	v_or_b32_e32 v5, v5, v21
	s_waitcnt vmcnt(1)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v5, v26, v5
	v_and_b16 v0.h, 0xff00, v5.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v26.l, v0.h, v1.h clamp
	v_lshlrev_b16 v0.h, 8, v5.l
	v_lshlrev_b16 v1.h, 8, v2.l
	v_sub_nc_i16 v2.l, v0.h, v1.h clamp
	v_and_b16 v0.h, 0xff00, v5.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v2, v2, v26, 0xc0c0105
	v_sub_nc_i16 v1.l, v0.h, v1.l clamp
	v_lshlrev_b16 v0.h, 8, v5.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v0.l, v0.h, v0.l clamp
	v_perm_b32 v0, v0, v1, 0xc0c0105
	v_and_b32_e32 v1, 0x80402010, v30
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshl_or_b32 v5, v0, 16, v2
	v_lshrrev_b32_e32 v2, 24, v1
	v_lshrrev_b16 v0.l, 8, v1.l
	v_lshrrev_b16 v26.l, 4, v1.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e64 s0, 0, v2.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v0.l
	v_lshrrev_b32_e32 v0, 22, v30
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v1, 0, -1, s0
	v_cndmask_b32_e64 v2, 0, -1, vcc_lo
	v_bfe_i32 v0, v0, 0, 1
	v_add_co_u32 v8, vcc_lo, 0x480, v8
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_4)
	v_lshlrev_b16 v1.l, 8, v1.l
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_and_b16 v0.h, 0xff, v0.l
	v_lshlrev_b16 v0.l, 8, v0.l
	v_cmp_le_u32_e32 vcc_lo, s12, v18
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_4) | instid1(VALU_DEP_2)
	v_or_b16 v21.h, v0.h, v1.l
	v_lshlrev_b16 v0.h, 8, v2.l
	v_bfe_i32 v2, v26, 0, 1
	v_mov_b16_e32 v26.h, v21.l
	s_or_b32 s13, vcc_lo, s13
	v_and_b16 v1.h, 0xff, v2.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v26.l, v1.h, v0.h
	v_or_b32_e32 v21, v26, v21
	s_waitcnt vmcnt(0)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v21, v27, v21
	v_and_b16 v1.h, 0xff00, v21.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v26.l, v1.h, v0.h clamp
	v_lshlrev_b16 v0.h, 8, v21.l
	v_lshlrev_b16 v1.h, 8, v2.l
	v_sub_nc_i16 v2.l, v0.h, v1.h clamp
	v_and_b16 v0.h, 0xff00, v21.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v2, v2, v26, 0xc0c0105
	v_sub_nc_i16 v1.l, v0.h, v1.l clamp
	v_lshlrev_b16 v0.h, 8, v21.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v0.l, v0.h, v0.l clamp
	v_perm_b32 v0, v0, v1, 0xc0c0105
	v_dot4_i32_iu8 v1, v5, v3, 0 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v5, 28, v28
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_lshl_or_b32 v0, v0, 16, v2
	v_add_nc_u32_e32 v2, v25, v29
	v_dot4_i32_iu8 v0, v0, v22, 0 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v2, v2, v24, v23
	v_add3_u32 v2, v2, v7, v6
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v3, v2, v0, v1
	v_lshrrev_b32_e32 v0, 31, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v0, v3, v0
	v_ashrrev_i32_e32 v0, 1, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mad_u64_u32 v[1:2], null, v3, v5, v[0:1]
	v_lshrrev_b32_e32 v0, 31, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v0, v1, v0
	v_ashrrev_i32_e32 v1, 1, v0
	global_load_d16_b16 v0, v[10:11], off offset:64
	v_cvt_f32_i32_e32 v1, v1
	s_waitcnt vmcnt(0)
	v_cvt_f32_f16_e32 v0, v0.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v0, v12, v0
	v_fmac_f32_e32 v15, v0, v1
	s_and_not1_b32 exec_lo, exec_lo, s13
	s_cbranch_execnz .LBB7_2
; %bb.3:
	s_or_b32 exec_lo, exec_lo, s13
.LBB7_4:
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s1
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v17
	v_cmpx_ne_u32_e32 0, v17
	s_cbranch_execz .LBB7_6
; %bb.5:
	v_lshlrev_b32_e32 v0, 7, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_add_u32 v0, v14, 2, v0
	v_add_nc_u32_e32 v1, 0xffffff80, v0
	ds_store_b32 v1, v16
	ds_store_b32 v0, v15
.LBB7_6:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB7_52
; %bb.7:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB7_10
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB7_11
.LBB7_9:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr4
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr0
	s_branch .LBB7_26
.LBB7_10:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB7_9
.LBB7_11:
	v_mbcnt_lo_u32_b32 v0, -1, 0
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_xor_b32_e32 v1, 16, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v1
	v_cndmask_b32_e32 v1, v0, v1, vcc_lo
	v_dual_mov_b32 v1, 32 :: v_dual_lshlrev_b32 v2, 2, v1
	ds_bpermute_b32 v3, v2, v16
	s_cbranch_scc0 .LBB7_14
; %bb.12:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB7_15
.LBB7_13:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr4
                                        ; implicit-def: $vgpr3
	s_branch .LBB7_26
.LBB7_14:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB7_13
.LBB7_15:
	v_xor_b32_e32 v4, 8, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v5, v0, v4, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v4, v16, v3 :: v_dual_lshlrev_b32 v3, 2, v5
	ds_bpermute_b32 v5, v3, v4
	s_cbranch_scc0 .LBB7_18
; %bb.16:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB7_19
.LBB7_17:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr4
	s_branch .LBB7_26
.LBB7_18:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB7_17
.LBB7_19:
	v_xor_b32_e32 v6, 4, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v6
	v_cndmask_b32_e32 v6, v0, v6, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v5, v4, v5 :: v_dual_lshlrev_b32 v4, 2, v6
	ds_bpermute_b32 v6, v4, v5
	s_cbranch_scc0 .LBB7_22
; %bb.20:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB7_23
.LBB7_21:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
	s_branch .LBB7_26
.LBB7_22:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB7_21
.LBB7_23:
	v_xor_b32_e32 v7, 2, v0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v7
	s_waitcnt lgkmcnt(0)
	v_dual_cndmask_b32 v8, v0, v7 :: v_dual_add_f32 v7, v5, v6
	v_lshlrev_b32_e32 v5, 2, v8
	ds_bpermute_b32 v6, v5, v7
	s_cbranch_scc0 .LBB7_25
; %bb.24:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_branch .LBB7_26
.LBB7_25:
	s_mov_b32 s0, 0
	s_mov_b32 s4, -1
.LBB7_26:
	s_mov_b32 s1, 0
	s_and_b32 vcc_lo, exec_lo, s0
	s_mov_b32 s0, 0
	s_cbranch_vccnz .LBB7_39
; %bb.27:
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB7_41
.LBB7_28:
	v_xor_b32_e32 v8, 1, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_lt_i32_e32 vcc_lo, v8, v1
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v1, v7, v6 :: v_dual_cndmask_b32 v0, v0, v8
	v_lshlrev_b32_e32 v6, 2, v0
	ds_bpermute_b32 v0, v6, v1
	s_cbranch_scc0 .LBB7_30
; %bb.29:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB7_31
	s_branch .LBB7_46
.LBB7_30:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB7_46
.LBB7_31:
	ds_bpermute_b32 v2, v2, v15
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB7_33
; %bb.32:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB7_34
	s_branch .LBB7_46
.LBB7_33:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB7_46
.LBB7_34:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v15, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v3, v3, v2
	s_cbranch_scc0 .LBB7_36
; %bb.35:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB7_37
	s_branch .LBB7_46
.LBB7_36:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB7_46
.LBB7_37:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v2, v3
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v3, v4, v2
	s_cbranch_scc0 .LBB7_42
; %bb.38:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_branch .LBB7_43
.LBB7_39:
	s_cbranch_execnz .LBB7_53
; %bb.40:
	s_mov_b32 s0, -1
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB7_28
.LBB7_41:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr1
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB7_48
	s_branch .LBB7_49
.LBB7_42:
	s_mov_b32 s4, 0
.LBB7_43:
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB7_46
; %bb.44:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v2, v3
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v5, v3
	s_cbranch_scc0 .LBB7_55
; %bb.45:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB7_47
	s_branch .LBB7_56
.LBB7_46:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB7_56
.LBB7_47:
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB7_49
.LBB7_48:
	; divergent unreachable
.LBB7_49:
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB7_52
; %bb.50:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v3, v2
	v_cmp_eq_u32_e32 vcc_lo, 0, v14
	s_mov_b32 s1, 0
	ds_bpermute_b32 v3, v6, v2
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB7_52
; %bb.51:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v2, v3
	s_mul_i32 s0, s15, s3
	v_add_f32_e32 v0, v1, v0
	s_lshl_b64 s[0:1], s[0:1], 2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_mul_f32_e32 v3, 0xbfb8aa3b, v2
	s_add_u32 s4, s10, s0
	s_addc_u32 s5, s11, s1
	s_ashr_i32 s3, s2, 31
	s_lshl_b64 s[0:1], s[2:3], 2
	v_fma_f32 v4, 0xbfb8aa3b, v2, -v3
	v_rndne_f32_e32 v5, v3
	s_add_u32 s0, s4, s0
	s_addc_u32 s1, s5, s1
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_f32_e32 v3, v3, v5
	v_cmp_nlt_f32_e32 vcc_lo, 0x42ce8ed0, v2
	v_fmamk_f32 v4, v2, 0xb2a5705f, v4
	v_add_f32_e32 v3, v3, v4
	v_cvt_i32_f32_e32 v4, v5
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_exp_f32_e32 v3, v3
	s_waitcnt_depctr 0xfff
	v_ldexp_f32 v3, v3, v4
	v_cndmask_b32_e32 v3, 0, v3, vcc_lo
	v_cmp_ngt_f32_e32 vcc_lo, 0xc2b17218, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cndmask_b32_e32 v3, 0x7f800000, v3, vcc_lo
	v_add_f32_e32 v3, 1.0, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_div_scale_f32 v4, null, v3, v3, v2
	v_rcp_f32_e32 v5, v4
	s_waitcnt_depctr 0xfff
	v_fma_f32 v6, -v4, v5, 1.0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_fmac_f32_e32 v5, v6, v5
	v_div_scale_f32 v6, vcc_lo, v2, v3, v2
	v_mul_f32_e32 v7, v6, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fma_f32 v8, -v4, v7, v6
	v_fmac_f32_e32 v7, v8, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fma_f32 v4, -v4, v7, v6
	v_div_fmas_f32 v4, v4, v5, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_div_fixup_f32 v1, v4, v3, v2
	v_mov_b32_e32 v2, 0
	v_mul_f32_e32 v0, v0, v1
	global_store_b32 v2, v0, s[0:1]
.LBB7_52:
	s_endpgm
.LBB7_53:
	s_trap 2
	s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)
	s_mov_b32 ttmp2, m0
	s_waitcnt lgkmcnt(0)
	s_and_b32 s0, s0, 0x3ff
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_bitset1_b32 s0, 10
	s_mov_b32 m0, s0
	s_sendmsg sendmsg(MSG_INTERRUPT)
	s_mov_b32 m0, ttmp2
.LBB7_54:                               ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB7_54
.LBB7_55:
	s_mov_b32 s1, -1
	s_branch .LBB7_47
.LBB7_56:
	s_cbranch_execnz .LBB7_58
; %bb.57:
	s_cbranch_execnz .LBB7_48
	s_branch .LBB7_49
.LBB7_58:
	s_trap 2
	s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)
	s_mov_b32 ttmp2, m0
	s_waitcnt lgkmcnt(0)
	s_and_b32 s0, s0, 0x3ff
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_bitset1_b32 s0, 10
	s_mov_b32 m0, s0
	s_sendmsg sendmsg(MSG_INTERRUPT)
	s_mov_b32 m0, ttmp2
.LBB7_59:                               ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB7_59
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
		.amdhsa_group_segment_fixed_size 256
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 48
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 1
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 1
		.amdhsa_next_free_vgpr 35
		.amdhsa_next_free_sgpr 18
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_dx10_clamp 1
		.amdhsa_ieee_mode 1
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_shared_vgpr_count 0
		.amdhsa_inst_pref_size 62
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end7:
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj, .Lfunc_end7-_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj.num_vgpr, 35
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 18
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 7828
; TotalNumSgprs: 20
; NumVgprs: 35
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 256 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 4
; NumSGPRsForWavesPerEU: 20
; NumVGPRsForWavesPerEU: 35
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_load_b256 s[4:11], s[0:1], 0x10
	v_bfe_u32 v12, v0, 10, 10
	v_dual_mov_b32 v11, 0 :: v_dual_and_b32 v10, 0x3ff, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v0, v12, 5, v10
	v_lshrrev_b32_e32 v13, 3, v0
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s14, s8, 8
	s_mov_b32 s8, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_gt_u32_e64 s14, v13
	s_cbranch_execz .LBB8_4
; %bb.1:
	v_lshl_add_u32 v0, v12, 5, v10
	s_mul_i32 s10, s10, s3
	v_dual_mov_b32 v11, 0 :: v_dual_and_b32 v4, 7, v10
	s_mul_hi_u32 s13, s10, 36
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_lshrrev_b32_e32 v2, 3, v0
	s_mul_i32 s12, s10, 36
	v_lshlrev_b32_e32 v5, 1, v10
	v_mad_u64_u32 v[0:1], null, 0x120, v2, s[12:13]
	s_load_b64 s[12:13], s[0:1], 0x0
	v_mad_u64_u32 v[2:3], null, v4, 36, v[0:1]
	v_and_b32_e32 v0, 14, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_lshlrev_b32_e32 v1, 1, v0
	v_add_co_u32 v2, vcc_lo, s4, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v3, null, s5, v3, vcc_lo
	v_lshlrev_b32_e32 v14, 1, v1
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v8, vcc_lo, v2, 32
	v_add_co_ci_u32_e64 v9, null, 0, v3, vcc_lo
	v_lshlrev_b32_e32 v15, 1, v0
	s_mul_i32 s5, s9, s2
	s_mov_b32 s4, 0
.LBB8_2:                                ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v18, s5, v13
	s_clause 0x2
	global_load_b32 v16, v[8:9], off
	global_load_b128 v[0:3], v[8:9], off offset:-32
	global_load_b128 v[4:7], v[8:9], off offset:-16
	s_getpc_b64 s[0:1]
	s_add_u32 s0, s0, _ZL11iq3xxs_grid@rel32@lo+4
	s_addc_u32 s1, s1, _ZL11iq3xxs_grid@rel32@hi+12
	v_mov_b16_e32 v17.l, 0
	v_add_nc_u32_e32 v13, 4, v13
	s_waitcnt lgkmcnt(0)
	v_mad_i64_i32 v[21:22], null, 0x42, v18, s[12:13]
	s_delay_alu instid0(VALU_DEP_3)
	v_mov_b16_e32 v18.h, v17.l
	v_mov_b16_e32 v19.h, v17.l
	v_mov_b16_e32 v20.h, v17.l
	v_mov_b16_e32 v45.h, v17.l
	v_mov_b16_e32 v46.h, v17.l
	v_add_co_u32 v23, vcc_lo, v21, v14
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v24, null, 0, v22, vcc_lo
	v_add_co_u32 v25, vcc_lo, v21, v15
	v_add_co_ci_u32_e64 v26, null, 0, v22, vcc_lo
	s_clause 0x2
	global_load_b64 v[23:24], v[23:24], off
	global_load_b32 v50, v[25:26], off offset:64
	global_load_d16_hi_b16 v0, v[21:22], off offset:64
	v_mov_b16_e32 v47.h, v17.l
	v_mov_b16_e32 v48.h, v17.l
	v_mov_b16_e32 v49.h, v17.l
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v21, 0xff, v23
	v_lshrrev_b32_e32 v22, 6, v23
	v_lshrrev_b32_e32 v26, 14, v23
	v_lshrrev_b32_e32 v23, 22, v23
	v_and_b32_e32 v28, 0xff, v24
	v_lshrrev_b32_e32 v29, 6, v24
	v_lshrrev_b32_e32 v31, 14, v24
	v_lshrrev_b32_e32 v24, 22, v24
	v_lshlrev_b32_e32 v21, 2, v21
	v_and_b32_e32 v22, 0x3fc, v22
	v_and_b32_e32 v26, 0x3fc, v26
	v_and_b32_e32 v23, 0x3fc, v23
	v_lshlrev_b32_e32 v28, 2, v28
	v_and_b32_e32 v29, 0x3fc, v29
	v_and_b32_e32 v31, 0x3fc, v31
	v_and_b32_e32 v24, 0x3fc, v24
	s_clause 0x7
	global_load_b32 v51, v21, s[0:1]
	global_load_b32 v52, v22, s[0:1]
	global_load_b32 v53, v26, s[0:1]
	global_load_b32 v54, v23, s[0:1]
	global_load_b32 v55, v28, s[0:1]
	global_load_b32 v56, v29, s[0:1]
	global_load_b32 v57, v31, s[0:1]
	global_load_b32 v58, v24, s[0:1]
	s_waitcnt vmcnt(9)
	v_and_b32_e32 v25, 0xff, v50
	v_bfe_u32 v27, v50, 7, 8
	v_bfe_u32 v30, v50, 14, 8
	v_bfe_u32 v32, v50, 21, 8
	v_cmp_le_u32_e64 s0, s14, v13
	v_bcnt_u32_b32 v33, v25, 0
	v_bcnt_u32_b32 v34, v27, 0
	v_bcnt_u32_b32 v35, v30, 0
	v_bcnt_u32_b32 v36, v32, 0
	s_or_b32 s4, s0, s4
	v_and_b32_e32 v21, 1, v33
	v_and_b32_e32 v22, 1, v34
	v_and_b32_e32 v23, 1, v35
	v_and_b32_e32 v24, 1, v36
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b32_e32 v21, 7, v21
	v_lshlrev_b32_e32 v22, 7, v22
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b32_e32 v23, 7, v23
	v_lshlrev_b32_e32 v24, 7, v24
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_xor_b32_e32 v21, v21, v25
	v_xor_b32_e32 v22, v22, v27
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_xor_b32_e32 v23, v23, v30
	v_xor_b32_e32 v24, v24, v32
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_mul_lo_u32 v21, 0x1010101, v21
	v_mul_lo_u32 v22, 0x1010101, v22
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_mul_lo_u32 v23, 0x1010101, v23
	v_mul_lo_u32 v24, 0x1010101, v24
	s_delay_alu instid0(VALU_DEP_4)
	v_and_b32_e32 v25, 0x8040201, v21
	v_lshrrev_b32_e32 v26, 18, v21
	v_bfe_i32 v27, v21, 0, 1
	v_and_b32_e32 v28, 0x80402010, v21
	v_lshrrev_b32_e32 v21, 22, v21
	v_lshrrev_b32_e32 v43, 24, v25
	v_and_b32_e32 v29, 0x8040201, v22
	v_lshrrev_b32_e32 v30, 18, v22
	v_bfe_i32 v31, v22, 0, 1
	v_and_b32_e32 v32, 0x80402010, v22
	v_lshrrev_b32_e32 v22, 22, v22
	v_and_b32_e32 v33, 0x8040201, v23
	v_lshrrev_b32_e32 v34, 18, v23
	v_bfe_i32 v35, v23, 0, 1
	v_and_b32_e32 v36, 0x80402010, v23
	v_lshrrev_b32_e32 v37, 22, v23
	v_and_b32_e32 v38, 0x8040201, v24
	v_lshrrev_b32_e32 v39, 18, v24
	v_bfe_i32 v40, v24, 0, 1
	v_and_b32_e32 v41, 0x80402010, v24
	v_lshrrev_b32_e32 v42, 22, v24
	v_lshrrev_b16 v17.h, 8, v25.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v43.l
	v_mov_b16_e32 v18.l, v27.l
	v_lshrrev_b32_e32 v27, 24, v28
	v_bfe_i32 v44, v21, 0, 1
	v_lshrrev_b32_e32 v59, 24, v29
	v_lshrrev_b16 v20.l, 8, v29.l
	v_bfe_i32 v29, v30, 0, 1
	v_mov_b16_e32 v21.l, v31.l
	v_lshrrev_b32_e32 v30, 24, v32
	v_lshrrev_b16 v21.h, 8, v32.l
	v_lshrrev_b16 v31.l, 4, v32.l
	v_bfe_i32 v32, v22, 0, 1
	v_lshrrev_b32_e32 v60, 24, v33
	v_lshrrev_b16 v22.l, 8, v33.l
	v_bfe_i32 v33, v34, 0, 1
	v_mov_b16_e32 v23.l, v35.l
	v_lshrrev_b32_e32 v34, 24, v36
	v_lshrrev_b16 v22.h, 8, v36.l
	v_lshrrev_b16 v35.l, 4, v36.l
	v_bfe_i32 v36, v37, 0, 1
	v_lshrrev_b32_e32 v37, 24, v38
	v_lshrrev_b16 v23.h, 8, v38.l
	v_bfe_i32 v38, v39, 0, 1
	v_mov_b16_e32 v24.l, v40.l
	v_lshrrev_b32_e32 v39, 24, v41
	v_lshrrev_b16 v24.h, 8, v41.l
	v_lshrrev_b16 v40.l, 4, v41.l
	v_bfe_i32 v41, v42, 0, 1
	v_cndmask_b32_e64 v42, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v17.h
	v_lshrrev_b16 v19.l, 8, v28.l
	v_bfe_i32 v25, v26, 0, 1
	v_and_b16 v25.h, 0xff, v18.l
	v_lshlrev_b16 v26.l, 8, v18.l
	v_cndmask_b32_e64 v43, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v27.l
	v_mov_b16_e32 v18.l, v44.l
	v_lshrrev_b16 v28.l, 4, v28.l
	v_bfe_i32 v66, v31, 0, 1
	v_mov_b16_e32 v27.l, v33.l
	v_cndmask_b32_e64 v44, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v19.l
	v_bfe_i32 v62, v28, 0, 1
	v_mov_b16_e32 v19.l, v29.l
	v_mov_b16_e32 v29.l, v42.l
	v_and_b16 v17.h, 0xff, v25.l
	v_cndmask_b32_e64 v61, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v59.l
	v_mov_b16_e32 v31.l, v44.l
	v_mov_b16_e32 v33.l, v62.l
	v_lshlrev_b16 v27.h, 8, v18.l
	v_lshlrev_b16 v29.l, 8, v29.l
	v_cndmask_b32_e64 v59, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v20.l
	v_mov_b16_e32 v20.l, v32.l
	v_mov_b16_e32 v32.l, v61.l
	v_and_b16 v28.h, 0xff, v19.l
	v_lshlrev_b16 v29.h, 8, v19.l
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v30.l
	v_mov_b16_e32 v30.l, v43.l
	v_lshlrev_b16 v31.l, 8, v31.l
	v_lshlrev_b16 v32.l, 8, v32.l
	v_and_b16 v36.h, 0xff, v33.l
	v_cndmask_b32_e64 v64, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.h
	v_lshlrev_b16 v30.l, 8, v30.l
	v_or_b16 v17.h, v17.h, v29.l
	v_and_b16 v26.h, 0xff, v21.l
	v_mov_b16_e32 v19.l, v64.l
	v_cndmask_b32_e64 v65, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v60.l
	v_and_b16 v21.h, 0xff, v23.l
	v_bfe_i32 v70, v35, 0, 1
	v_bfe_i32 v75, v40, 0, 1
	v_and_b16 v30.h, 0xff, v20.l
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v22.l
	v_lshlrev_b16 v22.l, 8, v23.l
	v_mov_b16_e32 v23.l, v36.l
	v_mov_b16_e32 v35.l, v65.l
	v_mov_b16_e32 v36.l, v66.l
	v_cndmask_b32_e64 v67, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v34.l
	v_mov_b16_e32 v34.l, v63.l
	v_lshlrev_b16 v31.h, 8, v20.l
	v_mov_b16_e32 v20.l, v60.l
	v_lshlrev_b16 v38.h, 8, v19.l
	v_cndmask_b32_e64 v68, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v22.h
	v_lshlrev_b16 v34.l, 8, v34.l
	v_or_b16 v19.l, v36.h, v32.l
	v_mov_b16_e32 v45.l, v75.l
	v_lshlrev_b16 v35.l, 8, v35.l
	v_cndmask_b32_e64 v69, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v37.l
	v_mov_b16_e32 v37.l, v67.l
	v_and_b16 v39.h, 0xff, v36.l
	v_lshlrev_b16 v40.h, 8, v20.l
	v_or_b16 v20.l, v26.h, v34.l
	v_cndmask_b32_e64 v71, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v23.h
	v_mov_b16_e32 v28.l, v38.l
	v_and_b16 v32.h, 0xff, v27.l
	v_mov_b16_e32 v38.l, v68.l
	v_mov_b16_e32 v40.l, v70.l
	v_cndmask_b32_e64 v72, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v39.l
	v_mov_b16_e32 v39.l, v69.l
	v_lshlrev_b16 v37.l, 8, v37.l
	v_and_b16 v43.h, 0xff, v45.l
	v_and_b16 v22.h, 0xff, v24.l
	v_cndmask_b32_e64 v73, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v24.h
	v_lshlrev_b16 v24.h, 8, v25.l
	v_and_b16 v25.l, 0xff, v18.l
	v_mov_b16_e32 v18.l, v59.l
	v_mov_b16_e32 v43.l, v73.l
	v_cndmask_b32_e64 v74, 0, -1, vcc_lo
	v_lshlrev_b16 v23.h, 8, v24.l
	v_mov_b16_e32 v24.l, v41.l
	v_lshlrev_b16 v37.h, 8, v18.l
	v_or_b16 v18.l, v25.h, v30.l
	v_mov_b16_e32 v44.l, v74.l
	v_lshlrev_b16 v42.h, 8, v43.l
	v_and_b16 v33.h, 0xff, v23.l
	v_mov_b16_e32 v41.l, v71.l
	v_or_b32_e32 v18, v18, v17
	v_or_b16 v17.h, v25.l, v31.l
	v_lshlrev_b16 v43.l, 8, v44.l
	v_lshlrev_b16 v44.l, 8, v45.l
	v_or_b16 v45.l, v39.h, v35.l
	v_mov_b16_e32 v42.l, v72.l
	v_or_b32_e32 v19, v19, v17
	v_or_b16 v17.h, v28.h, v37.h
	v_lshlrev_b16 v38.l, 8, v38.l
	v_lshlrev_b16 v39.l, 8, v39.l
	v_and_b16 v41.h, 0xff, v40.l
	v_or_b16 v46.l, v21.h, v37.l
	v_or_b32_e32 v20, v20, v17
	v_or_b16 v17.h, v30.h, v38.h
	v_and_b16 v34.h, 0xff, v28.l
	v_lshlrev_b16 v41.l, 8, v41.l
	v_lshlrev_b16 v42.l, 8, v42.l
	v_or_b16 v47.l, v41.h, v39.l
	v_or_b32_e32 v25, v45, v17
	v_or_b16 v17.h, v32.h, v40.h
	v_and_b16 v35.h, 0xff, v24.l
	v_or_b16 v48.l, v22.h, v42.l
	v_or_b16 v49.l, v43.h, v43.l
	v_lshlrev_b16 v33.l, 8, v33.l
	v_or_b32_e32 v45, v46, v17
	v_or_b16 v17.h, v33.h, v38.l
	v_lshlrev_b16 v21.l, 8, v21.l
	v_lshlrev_b16 v36.l, 8, v36.l
	v_lshlrev_b16 v27.l, 8, v27.l
	v_lshlrev_b16 v23.l, 8, v23.l
	v_or_b32_e32 v46, v47, v17
	v_or_b16 v17.h, v34.h, v41.l
	v_lshlrev_b16 v40.l, 8, v40.l
	v_lshlrev_b16 v28.l, 8, v28.l
	v_lshlrev_b16 v24.l, 8, v24.l
	v_add_co_u32 v8, vcc_lo, 0x480, v8
	v_or_b32_e32 v47, v48, v17
	v_or_b16 v17.h, v35.h, v42.h
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_2)
	v_or_b32_e32 v17, v49, v17
	s_waitcnt vmcnt(7)
	v_xor_b32_e32 v18, v51, v18
	s_waitcnt vmcnt(6)
	v_xor_b32_e32 v48, v52, v19
	s_waitcnt vmcnt(5)
	v_xor_b32_e32 v49, v53, v20
	s_waitcnt vmcnt(4)
	v_xor_b32_e32 v51, v54, v25
	s_waitcnt vmcnt(3)
	v_xor_b32_e32 v45, v55, v45
	s_waitcnt vmcnt(2)
	v_xor_b32_e32 v46, v56, v46
	v_and_b16 v19.l, 0xff00, v48.l
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v52, v58, v17
	v_and_b16 v17.l, 0xff00, v18.l
	v_lshlrev_b16 v17.h, 8, v18.l
	v_and_b16 v18.l, 0xff00, v18.h
	v_lshlrev_b16 v18.h, 8, v18.h
	v_lshlrev_b16 v19.h, 8, v48.l
	v_and_b16 v20.l, 0xff00, v48.h
	v_lshlrev_b16 v20.h, 8, v48.h
	v_and_b16 v21.h, 0xff00, v49.l
	v_lshlrev_b16 v22.h, 8, v49.l
	v_and_b16 v25.l, 0xff00, v49.h
	v_lshlrev_b16 v25.h, 8, v49.h
	v_and_b16 v26.h, 0xff00, v51.l
	v_lshlrev_b16 v28.h, 8, v51.l
	v_and_b16 v30.h, 0xff00, v51.h
	v_lshlrev_b16 v32.h, 8, v51.h
	v_sub_nc_i16 v17.l, v17.l, v30.l clamp
	v_sub_nc_i16 v26.l, v17.h, v26.l clamp
	v_sub_nc_i16 v18.l, v18.l, v29.l clamp
	v_sub_nc_i16 v29.l, v18.h, v24.h clamp
	v_sub_nc_i16 v19.l, v19.l, v32.l clamp
	v_sub_nc_i16 v30.l, v19.h, v33.l clamp
	v_sub_nc_i16 v20.l, v20.l, v31.l clamp
	v_sub_nc_i16 v31.l, v20.h, v27.h clamp
	v_xor_b32_e32 v47, v57, v47
	v_and_b16 v33.h, 0xff00, v45.l
	v_lshlrev_b16 v34.h, 8, v45.l
	v_and_b16 v35.h, 0xff00, v45.h
	v_lshlrev_b16 v36.h, 8, v45.h
	v_and_b16 v39.h, 0xff00, v46.l
	v_lshlrev_b16 v41.h, 8, v46.l
	v_and_b16 v43.h, 0xff00, v46.h
	v_lshlrev_b16 v44.h, 8, v46.h
	v_sub_nc_i16 v32.l, v21.h, v34.l clamp
	v_sub_nc_i16 v21.l, v22.h, v21.l clamp
	v_sub_nc_i16 v25.l, v25.l, v37.h clamp
	v_sub_nc_i16 v33.l, v25.h, v29.h clamp
	v_sub_nc_i16 v34.l, v26.h, v35.l clamp
	v_sub_nc_i16 v35.l, v28.h, v36.l clamp
	v_sub_nc_i16 v36.l, v30.h, v38.h clamp
	v_sub_nc_i16 v49.l, v32.h, v31.h clamp
	v_perm_b32 v17, v26, v17, 0xc0c0105
	v_perm_b32 v18, v29, v18, 0xc0c0105
	v_perm_b32 v19, v30, v19, 0xc0c0105
	v_perm_b32 v20, v31, v20, 0xc0c0105
	v_and_b16 v45.l, 0xff00, v47.l
	v_lshlrev_b16 v45.h, 8, v47.l
	v_and_b16 v46.l, 0xff00, v47.h
	v_lshlrev_b16 v46.h, 8, v47.h
	v_and_b16 v47.l, 0xff00, v52.l
	v_lshlrev_b16 v47.h, 8, v52.l
	v_and_b16 v48.l, 0xff00, v52.h
	v_lshlrev_b16 v48.h, 8, v52.h
	v_sub_nc_i16 v37.l, v33.h, v37.l clamp
	v_sub_nc_i16 v22.l, v34.h, v22.l clamp
	v_sub_nc_i16 v51.l, v35.h, v40.h clamp
	v_sub_nc_i16 v27.l, v36.h, v27.l clamp
	v_sub_nc_i16 v39.l, v39.h, v39.l clamp
	v_sub_nc_i16 v40.l, v41.h, v40.l clamp
	v_sub_nc_i16 v38.l, v43.h, v38.l clamp
	v_sub_nc_i16 v23.l, v44.h, v23.l clamp
	v_perm_b32 v21, v21, v32, 0xc0c0105
	v_perm_b32 v25, v33, v25, 0xc0c0105
	v_perm_b32 v26, v35, v34, 0xc0c0105
	v_perm_b32 v29, v49, v36, 0xc0c0105
	v_lshl_or_b32 v17, v18, 16, v17
	v_lshl_or_b32 v18, v20, 16, v19
	v_sub_nc_i16 v42.l, v45.l, v42.l clamp
	v_sub_nc_i16 v45.l, v45.h, v23.h clamp
	v_sub_nc_i16 v41.l, v46.l, v41.l clamp
	v_sub_nc_i16 v28.l, v46.h, v28.l clamp
	v_sub_nc_i16 v43.l, v47.l, v43.l clamp
	v_sub_nc_i16 v44.l, v47.h, v44.l clamp
	v_sub_nc_i16 v46.l, v48.l, v42.h clamp
	v_sub_nc_i16 v24.l, v48.h, v24.l clamp
	v_perm_b32 v22, v22, v37, 0xc0c0105
	v_perm_b32 v27, v27, v51, 0xc0c0105
	v_perm_b32 v30, v40, v39, 0xc0c0105
	v_perm_b32 v23, v23, v38, 0xc0c0105
	v_lshl_or_b32 v19, v25, 16, v21
	v_lshl_or_b32 v20, v29, 16, v26
	v_dot4_i32_iu8 v1, v17, v1, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v2, v18, v2, 0 neg_lo:[1,1,0]
	v_perm_b32 v31, v45, v42, 0xc0c0105
	v_perm_b32 v28, v28, v41, 0xc0c0105
	v_perm_b32 v32, v44, v43, 0xc0c0105
	v_perm_b32 v24, v24, v46, 0xc0c0105
	v_lshl_or_b32 v21, v27, 16, v22
	v_lshl_or_b32 v22, v23, 16, v30
	v_dot4_i32_iu8 v3, v19, v3, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v4, v20, v4, 0 neg_lo:[1,1,0]
	v_add_nc_u32_e32 v1, v1, v2
	v_lshl_or_b32 v17, v28, 16, v31
	v_lshl_or_b32 v2, v24, 16, v32
	v_dot4_i32_iu8 v5, v21, v5, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v6, v22, v6, 0 neg_lo:[1,1,0]
	v_add3_u32 v1, v1, v4, v3
	v_dot4_i32_iu8 v3, v17, v7, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v2, v2, v16, 0 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add3_u32 v1, v1, v6, v5
	v_lshrrev_b32_e32 v5, 28, v50
	v_add3_u32 v4, v1, v2, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v1, 31, v4
	v_add_nc_u32_e32 v1, v4, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 1, v1
	v_mad_u64_u32 v[2:3], null, v4, v5, v[1:2]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v1, 31, v2
	v_add_nc_u32_e32 v1, v2, v1
	v_cvt_f32_f16_e32 v2, v0.l
	v_cvt_f32_f16_e32 v0, v0.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_ashrrev_i32_e32 v1, 1, v1
	v_mul_f32_e32 v0, v0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_f32_i32_e32 v1, v1
	v_fmac_f32_e32 v11, v0, v1
	s_and_not1_b32 exec_lo, exec_lo, s4
	s_cbranch_execnz .LBB8_2
; %bb.3:
	s_or_b32 exec_lo, exec_lo, s4
.LBB8_4:
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s8
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v12
	v_cmpx_ne_u32_e32 0, v12
	s_cbranch_execz .LBB8_6
; %bb.5:
	v_lshlrev_b32_e32 v0, 7, v12
	v_lshlrev_b32_e32 v1, 2, v10
	s_delay_alu instid0(VALU_DEP_1)
	v_add3_u32 v0, v0, v1, 0xffffff80
	ds_store_b32 v0, v11
.LBB8_6:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB8_24
; %bb.7:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, 0
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB8_10
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB8_11
.LBB8_9:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr0
	s_branch .LBB8_20
.LBB8_10:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB8_9
.LBB8_11:
	v_mbcnt_lo_u32_b32 v0, -1, 0
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_xor_b32_e32 v1, 16, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v1
	v_cndmask_b32_e32 v1, v0, v1, vcc_lo
	v_lshlrev_b32_e32 v1, 2, v1
	ds_bpermute_b32 v2, v1, v11
	v_mov_b32_e32 v1, 32
	s_cbranch_scc0 .LBB8_13
; %bb.12:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB8_14
	s_branch .LBB8_19
.LBB8_13:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB8_19
.LBB8_14:
	v_xor_b32_e32 v3, 8, v0
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v11, v2
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v3
	v_cndmask_b32_e32 v3, v0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v3, 2, v3
	ds_bpermute_b32 v3, v3, v2
	s_cbranch_scc0 .LBB8_16
; %bb.15:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB8_17
	s_branch .LBB8_19
.LBB8_16:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB8_19
.LBB8_17:
	v_xor_b32_e32 v4, 4, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v4, v0, v4, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v2, v2, v3 :: v_dual_lshlrev_b32 v3, 2, v4
	ds_bpermute_b32 v3, v3, v2
	s_cbranch_scc0 .LBB8_25
; %bb.18:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB8_26
.LBB8_19:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
.LBB8_20:
	s_and_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB8_28
; %bb.21:
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB8_24
.LBB8_22:
	v_xor_b32_e32 v4, 1, v0
	s_mov_b32 s1, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_cmp_lt_i32_e32 vcc_lo, v4, v1
	s_waitcnt lgkmcnt(0)
	v_dual_cndmask_b32 v1, v0, v4 :: v_dual_add_f32 v0, v3, v2
	v_cmp_eq_u32_e32 vcc_lo, 0, v10
	v_lshlrev_b32_e32 v1, 2, v1
	ds_bpermute_b32 v1, v1, v0
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB8_24
; %bb.23:
	s_mul_i32 s0, s11, s3
	v_mov_b32_e32 v2, 0
	s_lshl_b64 s[0:1], s[0:1], 2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v0, v0, v1
	s_add_u32 s4, s6, s0
	s_addc_u32 s5, s7, s1
	s_ashr_i32 s3, s2, 31
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_lshl_b64 s[0:1], s[2:3], 2
	s_add_u32 s0, s4, s0
	s_addc_u32 s1, s5, s1
	global_store_b32 v2, v0, s[0:1]
.LBB8_24:
	s_endpgm
.LBB8_25:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB8_19
.LBB8_26:
	v_xor_b32_e32 v4, 2, v0
	s_cmp_lg_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v2, v3
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v4, v0, v4, vcc_lo
	v_lshlrev_b32_e32 v2, 2, v4
	ds_bpermute_b32 v2, v2, v3
	s_cbranch_scc0 .LBB8_32
; %bb.27:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_branch .LBB8_20
.LBB8_28:
	s_cbranch_execnz .LBB8_30
; %bb.29:
	; divergent unreachable
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB8_22
	s_branch .LBB8_24
.LBB8_30:
	s_trap 2
	s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)
	s_mov_b32 ttmp2, m0
	s_waitcnt lgkmcnt(0)
	s_and_b32 s0, s0, 0x3ff
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_bitset1_b32 s0, 10
	s_mov_b32 m0, s0
	s_sendmsg sendmsg(MSG_INTERRUPT)
	s_mov_b32 m0, ttmp2
.LBB8_31:                               ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB8_31
.LBB8_32:
	s_mov_b32 s1, 0
	s_mov_b32 s0, -1
	s_branch .LBB8_20
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
		.amdhsa_group_segment_fixed_size 128
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 48
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 1
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 1
		.amdhsa_next_free_vgpr 76
		.amdhsa_next_free_sgpr 15
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_dx10_clamp 1
		.amdhsa_ieee_mode 1
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_shared_vgpr_count 0
		.amdhsa_inst_pref_size 30
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end8:
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj, .Lfunc_end8-_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj.num_vgpr, 76
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 15
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 3824
; TotalNumSgprs: 17
; NumVgprs: 76
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 128 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 9
; NumSGPRsForWavesPerEU: 17
; NumVGPRsForWavesPerEU: 76
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_clause 0x1
	s_load_b128 s[12:15], s[0:1], 0x20
	s_load_b256 s[4:11], s[0:1], 0x0
	v_bfe_u32 v17, v0, 10, 10
	v_dual_mov_b32 v15, 0 :: v_dual_and_b32 v14, 0x3ff, v0
	v_mov_b32_e32 v16, 0
	s_mov_b32 s1, exec_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v0, v17, 5, v14
	v_lshrrev_b32_e32 v18, 3, v0
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s12, s12, 8
	s_delay_alu instid0(VALU_DEP_1) | instid1(SALU_CYCLE_1)
	v_cmpx_gt_u32_e64 s12, v18
	s_cbranch_execz .LBB9_4
; %bb.1:
	v_lshl_add_u32 v0, v17, 5, v14
	s_mul_i32 s0, s14, s3
	v_and_b32_e32 v4, 7, v14
	s_mul_hi_u32 s17, s0, 36
	s_mul_i32 s16, s0, 36
	v_lshrrev_b32_e32 v2, 3, v0
	s_mul_i32 s14, s13, s2
	s_mov_b32 s13, 0
	v_dual_mov_b32 v15, 0 :: v_dual_mov_b32 v16, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mad_u64_u32 v[0:1], null, 0x120, v2, s[16:17]
	v_lshlrev_b32_e32 v2, 1, v14
	v_and_b32_e32 v5, 14, v2
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mad_u64_u32 v[2:3], null, v4, 36, v[0:1]
	v_lshlrev_b32_e32 v0, 1, v5
	v_lshlrev_b32_e32 v19, 1, v5
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v1, vcc_lo, s8, v2
	v_add_co_ci_u32_e64 v2, null, s9, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_lshlrev_b32_e32 v20, 1, v0
	v_add_co_u32 v8, vcc_lo, v1, 32
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v9, null, 0, v2, vcc_lo
.LBB9_2:                                ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v23, s14, v18
	s_getpc_b64 s[8:9]
	s_add_u32 s8, s8, _ZL11iq3xxs_grid@rel32@lo+4
	s_addc_u32 s9, s9, _ZL11iq3xxs_grid@rel32@hi+12
	v_mov_b16_e32 v21.l, 0
	v_add_nc_u32_e32 v18, 4, v18
	v_mad_i64_i32 v[10:11], null, 0x42, v23, s[4:5]
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_mov_b16_e32 v35.h, v21.l
	v_mov_b16_e32 v36.h, v21.l
	v_add_co_u32 v0, vcc_lo, v10, v20
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v1, null, 0, v11, vcc_lo
	global_load_b64 v[12:13], v[0:1], off
	v_add_co_u32 v0, vcc_lo, v10, v19
	v_add_co_ci_u32_e64 v1, null, 0, v11, vcc_lo
	global_load_b32 v24, v[0:1], off offset:64
	s_waitcnt vmcnt(1)
	v_and_b32_e32 v0, 0xff, v12
	v_lshrrev_b32_e32 v27, 14, v12
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_lshlrev_b32_e32 v0, 2, v0
	v_and_b32_e32 v27, 0x3fc, v27
	global_load_b32 v4, v0, s[8:9]
	v_lshrrev_b32_e32 v0, 6, v12
	v_lshrrev_b32_e32 v12, 22, v12
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_and_b32_e32 v0, 0x3fc, v0
	v_and_b32_e32 v12, 0x3fc, v12
	global_load_b32 v5, v0, s[8:9]
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v0, 0xff, v24
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_bcnt_u32_b32 v1, v0, 0
	v_and_b32_e32 v1, 1, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v1, 7, v1
	v_xor_b32_e32 v0, v1, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v6, 0x1010101, v0
	v_and_b32_e32 v0, 0x8040201, v6
	v_bfe_i32 v2, v6, 0, 1
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_lshrrev_b32_e32 v1, 24, v0
	v_lshrrev_b16 v0.l, 8, v0.l
	v_cmp_ne_u16_e64 s0, 0, v1.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v0.l
	v_lshrrev_b32_e32 v0, 18, v6
	v_cndmask_b32_e64 v1, 0, -1, s0
	v_cndmask_b32_e64 v3, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_4)
	v_bfe_i32 v0, v0, 0, 1
	v_mov_b16_e32 v3.h, v21.l
	v_lshlrev_b16 v1.l, 8, v1.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b16 v1.h, 8, v3.l
	v_and_b16 v0.h, 0xff, v0.l
	v_lshlrev_b16 v0.l, 8, v0.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b16 v21.h, v0.h, v1.l
	v_and_b16 v0.h, 0xff, v2.l
	v_or_b16 v3.l, v0.h, v1.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v3, v3, v21
	s_waitcnt vmcnt(1)
	v_xor_b32_e32 v3, v4, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v0.h, 0xff00, v3.l
	v_sub_nc_i16 v4.l, v0.h, v1.h clamp
	v_lshlrev_b16 v0.h, 8, v3.l
	v_lshlrev_b16 v1.h, 8, v2.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v2.l, v0.h, v1.h clamp
	v_and_b16 v0.h, 0xff00, v3.h
	v_perm_b32 v2, v2, v4, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v1.l, v0.h, v1.l clamp
	v_lshlrev_b16 v0.h, 8, v3.h
	v_sub_nc_i16 v0.l, v0.h, v0.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_perm_b32 v0, v0, v1, 0xc0c0105
	v_and_b32_e32 v1, 0x80402010, v6
	v_lshl_or_b32 v25, v0, 16, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshrrev_b32_e32 v2, 24, v1
	v_lshrrev_b16 v0.l, 8, v1.l
	v_lshrrev_b16 v3.l, 4, v1.l
	v_cmp_ne_u16_e64 s0, 0, v2.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v0.l
	v_lshrrev_b32_e32 v0, 22, v6
	v_cndmask_b32_e64 v1, 0, -1, s0
	v_cndmask_b32_e64 v2, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_bfe_i32 v0, v0, 0, 1
	v_lshlrev_b16 v1.l, 8, v1.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b16 v0.h, 0xff, v0.l
	v_lshlrev_b16 v0.l, 8, v0.l
	v_or_b16 v21.h, v0.h, v1.l
	v_lshlrev_b16 v0.h, 8, v2.l
	v_bfe_i32 v2, v3, 0, 1
	v_mov_b16_e32 v3.h, v21.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v1.h, 0xff, v2.l
	v_or_b16 v3.l, v1.h, v0.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v3, v3, v21
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v3, v5, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v1.h, 0xff00, v3.l
	v_sub_nc_i16 v4.l, v1.h, v0.h clamp
	v_lshlrev_b16 v0.h, 8, v3.l
	v_lshlrev_b16 v1.h, 8, v2.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v2.l, v0.h, v1.h clamp
	v_and_b16 v0.h, 0xff00, v3.h
	v_perm_b32 v2, v2, v4, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v1.l, v0.h, v1.l clamp
	v_lshlrev_b16 v0.h, 8, v3.h
	v_sub_nc_i16 v0.l, v0.h, v0.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v0, v0, v1, 0xc0c0105
	v_lshl_or_b32 v26, v0, 16, v2
	s_clause 0x2
	global_load_b128 v[4:7], v[8:9], off offset:-32
	global_load_b32 v22, v[8:9], off
	global_load_b128 v[0:3], v[8:9], off offset:-16
	s_clause 0x1
	global_load_b32 v29, v27, s[8:9]
	global_load_b32 v30, v12, s[8:9]
	v_bfe_u32 v12, v24, 7, 8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_bcnt_u32_b32 v27, v12, 0
	v_and_b32_e32 v27, 1, v27
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v27, 7, v27
	v_xor_b32_e32 v12, v27, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v31, 0x1010101, v12
	v_and_b32_e32 v12, 0x8040201, v31
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_3)
	v_lshrrev_b32_e32 v27, 24, v12
	s_waitcnt vmcnt(4)
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b32_e32 v12, 18, v31
	v_cmp_ne_u16_e64 s0, 0, v27.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	v_bfe_i32 v12, v12, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v27, 0, -1, s0
	v_cndmask_b32_e64 v28, 0, -1, vcc_lo
	v_and_b16 v4.h, 0xff, v12.l
	v_mov_b16_e32 v28.h, v21.l
	v_lshlrev_b16 v12.l, 8, v12.l
	v_lshlrev_b16 v12.h, 8, v27.l
	v_bfe_i32 v27, v31, 0, 1
	v_lshlrev_b16 v27.h, 8, v28.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_or_b16 v21.h, v4.h, v12.h
	v_and_b16 v4.h, 0xff, v27.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v28.l, v4.h, v27.h
	v_or_b32_e32 v28, v28, v21
	v_lshlrev_b16 v21.h, 8, v27.l
	s_waitcnt vmcnt(1)
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v28, v29, v28
	v_and_b16 v4.h, 0xff00, v28.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v29.l, v4.h, v27.h clamp
	v_lshlrev_b16 v4.h, 8, v28.l
	v_sub_nc_i16 v27.l, v4.h, v21.h clamp
	v_and_b16 v4.h, 0xff00, v28.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v27, v27, v29, 0xc0c0105
	v_sub_nc_i16 v28.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v28.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	v_perm_b32 v12, v12, v28, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v29, v12, 16, v27
	v_and_b32_e32 v12, 0x80402010, v31
	v_lshrrev_b32_e32 v27, 24, v12
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b16 v28.l, 4, v12.l
	v_lshrrev_b32_e32 v12, 22, v31
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_cmp_ne_u16_e64 s0, 0, v27.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_bfe_i32 v12, v12, 0, 1
	v_cndmask_b32_e64 v27, 0, -1, s0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_and_b16 v4.h, 0xff, v12.l
	v_lshlrev_b16 v12.l, 8, v12.l
	v_lshlrev_b16 v12.h, 8, v27.l
	v_cndmask_b32_e64 v27, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_or_b16 v21.h, v4.h, v12.h
	v_lshlrev_b16 v4.h, 8, v27.l
	v_bfe_i32 v27, v28, 0, 1
	v_mov_b16_e32 v28.h, v21.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v27.h, 0xff, v27.l
	v_or_b16 v28.l, v27.h, v4.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v28, v28, v21
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v28, v30, v28
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v21.h, 0xff00, v28.l
	v_sub_nc_i16 v30.l, v21.h, v4.h clamp
	v_lshlrev_b16 v4.h, 8, v28.l
	v_lshlrev_b16 v21.h, 8, v27.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v27.l, v4.h, v21.h clamp
	v_and_b16 v4.h, 0xff00, v28.h
	v_perm_b32 v27, v27, v30, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v28.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v28.h
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v12, v12, v28, 0xc0c0105
	v_lshl_or_b32 v30, v12, 16, v27
	v_and_b32_e32 v12, 0xff, v13
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v12, 2, v12
	global_load_b32 v31, v12, s[8:9]
	v_lshrrev_b32_e32 v12, 6, v13
	v_and_b32_e32 v12, 0x3fc, v12
	global_load_b32 v32, v12, s[8:9]
	v_bfe_u32 v12, v24, 14, 8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_bcnt_u32_b32 v27, v12, 0
	v_and_b32_e32 v27, 1, v27
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v27, 7, v27
	v_xor_b32_e32 v12, v27, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v33, 0x1010101, v12
	v_and_b32_e32 v12, 0x8040201, v33
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshrrev_b32_e32 v27, 24, v12
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b32_e32 v12, 18, v33
	v_cmp_ne_u16_e64 s0, 0, v27.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	v_bfe_i32 v12, v12, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v27, 0, -1, s0
	v_cndmask_b32_e64 v28, 0, -1, vcc_lo
	v_and_b16 v4.h, 0xff, v12.l
	v_mov_b16_e32 v28.h, v21.l
	v_lshlrev_b16 v12.l, 8, v12.l
	v_lshlrev_b16 v12.h, 8, v27.l
	v_bfe_i32 v27, v33, 0, 1
	v_lshlrev_b16 v27.h, 8, v28.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_or_b16 v21.h, v4.h, v12.h
	v_and_b16 v4.h, 0xff, v27.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v28.l, v4.h, v27.h
	v_or_b32_e32 v28, v28, v21
	v_lshlrev_b16 v21.h, 8, v27.l
	s_waitcnt vmcnt(1)
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v28, v31, v28
	v_and_b16 v4.h, 0xff00, v28.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v31.l, v4.h, v27.h clamp
	v_lshlrev_b16 v4.h, 8, v28.l
	v_sub_nc_i16 v27.l, v4.h, v21.h clamp
	v_and_b16 v4.h, 0xff00, v28.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v27, v27, v31, 0xc0c0105
	v_sub_nc_i16 v28.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v28.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	v_perm_b32 v12, v12, v28, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_lshl_or_b32 v28, v12, 16, v27
	v_and_b32_e32 v12, 0x80402010, v33
	v_dot4_i32_iu8 v28, v28, v1, 0 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_4)
	v_lshrrev_b32_e32 v27, 24, v12
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b16 v31.l, 4, v12.l
	v_lshrrev_b32_e32 v12, 22, v33
	v_cmp_ne_u16_e64 s0, 0, v27.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	v_bfe_i32 v12, v12, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cndmask_b32_e64 v27, 0, -1, s0
	v_and_b16 v4.h, 0xff, v12.l
	v_lshlrev_b16 v12.l, 8, v12.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_lshlrev_b16 v12.h, 8, v27.l
	v_cndmask_b32_e64 v27, 0, -1, vcc_lo
	v_or_b16 v21.h, v4.h, v12.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_lshlrev_b16 v4.h, 8, v27.l
	v_bfe_i32 v27, v31, 0, 1
	v_mov_b16_e32 v31.h, v21.l
	v_and_b16 v27.h, 0xff, v27.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v31.l, v27.h, v4.h
	v_or_b32_e32 v31, v31, v21
	s_waitcnt vmcnt(0)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v31, v32, v31
	v_and_b16 v21.h, 0xff00, v31.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v32.l, v21.h, v4.h clamp
	v_lshlrev_b16 v4.h, 8, v31.l
	v_lshlrev_b16 v21.h, 8, v27.l
	v_sub_nc_i16 v27.l, v4.h, v21.h clamp
	v_and_b16 v4.h, 0xff00, v31.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v27, v27, v32, 0xc0c0105
	v_sub_nc_i16 v31.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v31.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	v_perm_b32 v12, v12, v31, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v31, v12, 16, v27
	v_lshrrev_b32_e32 v12, 14, v13
	v_and_b32_e32 v12, 0x3fc, v12
	global_load_b32 v32, v12, s[8:9]
	v_lshrrev_b32_e32 v12, 22, v13
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_and_b32_e32 v12, 0x3fc, v12
	global_load_b32 v33, v12, s[8:9]
	v_bfe_u32 v12, v24, 21, 8
	v_bcnt_u32_b32 v13, v12, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v13, 1, v13
	v_lshlrev_b32_e32 v13, 7, v13
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v12, v13, v12
	v_mul_lo_u32 v34, 0x1010101, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b32_e32 v12, 0x8040201, v34
	v_lshrrev_b32_e32 v13, 24, v12
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b32_e32 v12, 18, v34
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e64 s0, 0, v13.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_bfe_i32 v12, v12, 0, 1
	v_cndmask_b32_e64 v13, 0, -1, s0
	v_cndmask_b32_e64 v27, 0, -1, vcc_lo
	s_delay_alu instid0(VALU_DEP_3)
	v_and_b16 v4.h, 0xff, v12.l
	v_mov_b16_e32 v27.h, v21.l
	v_lshlrev_b16 v12.l, 8, v12.l
	v_lshlrev_b16 v12.h, 8, v13.l
	v_bfe_i32 v13, v34, 0, 1
	v_lshlrev_b16 v13.h, 8, v27.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_or_b16 v21.h, v4.h, v12.h
	v_and_b16 v4.h, 0xff, v13.l
	v_lshlrev_b16 v13.l, 8, v13.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v27.l, v4.h, v13.h
	v_or_b32_e32 v27, v27, v21
	s_waitcnt vmcnt(1)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v27, v32, v27
	v_and_b16 v4.h, 0xff00, v27.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v32.l, v4.h, v13.h clamp
	v_lshlrev_b16 v4.h, 8, v27.l
	v_sub_nc_i16 v13.l, v4.h, v13.l clamp
	v_and_b16 v4.h, 0xff00, v27.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v13, v13, v32, 0xc0c0105
	v_sub_nc_i16 v27.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v27.h
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	v_perm_b32 v12, v12, v27, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_lshl_or_b32 v27, v12, 16, v13
	v_and_b32_e32 v12, 0x80402010, v34
	v_dot4_i32_iu8 v27, v27, v3, 0 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_4)
	v_lshrrev_b32_e32 v13, 24, v12
	v_lshrrev_b16 v4.h, 8, v12.l
	v_lshrrev_b16 v32.l, 4, v12.l
	v_lshrrev_b32_e32 v12, 22, v34
	v_cmp_ne_u16_e64 s0, 0, v13.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v4.h
	v_bfe_i32 v12, v12, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cndmask_b32_e64 v13, 0, -1, s0
	v_and_b16 v4.h, 0xff, v12.l
	v_lshlrev_b16 v12.l, 8, v12.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_lshlrev_b16 v12.h, 8, v13.l
	v_cndmask_b32_e64 v13, 0, -1, vcc_lo
	v_or_b16 v21.h, v4.h, v12.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_lshlrev_b16 v4.h, 8, v13.l
	v_bfe_i32 v13, v32, 0, 1
	v_mov_b16_e32 v32.h, v21.l
	v_and_b16 v13.h, 0xff, v13.l
	v_lshlrev_b16 v13.l, 8, v13.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_or_b16 v32.l, v13.h, v4.h
	v_or_b32_e32 v32, v32, v21
	s_waitcnt vmcnt(0)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_xor_b32_e32 v32, v33, v32
	v_and_b16 v13.h, 0xff00, v32.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v33.l, v13.h, v4.h clamp
	v_lshlrev_b16 v4.h, 8, v32.l
	v_sub_nc_i16 v13.l, v4.h, v13.l clamp
	v_and_b16 v4.h, 0xff00, v32.h
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_perm_b32 v13, v13, v33, 0xc0c0105
	v_sub_nc_i16 v32.l, v4.h, v12.h clamp
	v_lshlrev_b16 v4.h, 8, v32.h
	v_mov_b16_e32 v33.h, v21.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v12.l, v4.h, v12.l clamp
	global_load_d16_hi_b16 v4, v[10:11], off offset:64
	v_perm_b32 v12, v12, v32, 0xc0c0105
	v_mov_b16_e32 v32.h, v21.l
	v_lshl_or_b32 v12, v12, 16, v13
	v_dot4_i32_iu8 v13, v25, v5, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v25, v26, v6, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v26, v29, v7, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v29, v30, v0, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v30, v31, v2, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v12, v12, v22, 0 neg_lo:[1,1,0]
	v_add_nc_u32_e32 v13, v13, v25
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add3_u32 v13, v13, v29, v26
	v_lshrrev_b32_e32 v26, 28, v24
	v_add3_u32 v13, v13, v30, v28
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add3_u32 v13, v13, v12, v27
	v_lshrrev_b32_e32 v12, 31, v13
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v12, v13, v12
	v_ashrrev_i32_e32 v12, 1, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mad_u64_u32 v[24:25], null, v13, v26, v[12:13]
	v_lshrrev_b32_e32 v12, 31, v24
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v12, v24, v12
	v_ashrrev_i32_e32 v13, 1, v12
	s_waitcnt vmcnt(0)
	v_cvt_f32_f16_e32 v12, v4.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cvt_f32_i32_e32 v13, v13
	v_cvt_f32_f16_e32 v10, v4.h
	v_mul_f32_e32 v4, v10, v12
	v_mad_i64_i32 v[10:11], null, 0x42, v23, s[6:7]
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_fmac_f32_e32 v16, v4, v13
	v_add_co_u32 v23, vcc_lo, v10, v20
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v24, null, 0, v11, vcc_lo
	global_load_b64 v[26:27], v[23:24], off
	v_add_co_u32 v23, vcc_lo, v10, v19
	v_add_co_ci_u32_e64 v24, null, 0, v11, vcc_lo
	global_load_b32 v28, v[23:24], off offset:64
	s_waitcnt vmcnt(1)
	v_and_b32_e32 v23, 0xff, v26
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v23, 2, v23
	global_load_b32 v29, v23, s[8:9]
	v_lshrrev_b32_e32 v23, 6, v26
	v_and_b32_e32 v23, 0x3fc, v23
	global_load_b32 v30, v23, s[8:9]
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v23, 0xff, v28
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_bcnt_u32_b32 v24, v23, 0
	v_and_b32_e32 v24, 1, v24
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v24, 7, v24
	v_xor_b32_e32 v23, v24, v23
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v31, 0x1010101, v23
	v_and_b32_e32 v23, 0x8040201, v31
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshrrev_b32_e32 v24, 24, v23
	v_lshrrev_b16 v21.h, 8, v23.l
	v_lshrrev_b32_e32 v23, 18, v31
	v_cmp_ne_u16_e64 s0, 0, v24.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.h
	v_bfe_i32 v23, v23, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v24, 0, -1, s0
	v_cndmask_b32_e64 v25, 0, -1, vcc_lo
	v_and_b16 v21.h, 0xff, v23.l
	v_lshlrev_b16 v23.l, 8, v23.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshlrev_b16 v23.h, 8, v24.l
	v_bfe_i32 v24, v31, 0, 1
	v_lshlrev_b16 v25.l, 8, v25.l
	v_or_b16 v21.h, v21.h, v23.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b16 v24.h, 0xff, v24.l
	v_lshlrev_b16 v24.l, 8, v24.l
	v_or_b16 v32.l, v24.h, v25.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v32, v32, v21
	s_waitcnt vmcnt(1)
	v_xor_b32_e32 v29, v29, v32
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v21.h, 0xff00, v29.l
	v_sub_nc_i16 v25.l, v21.h, v25.l clamp
	v_lshlrev_b16 v21.h, 8, v29.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v24.l, v21.h, v24.l clamp
	v_and_b16 v21.h, 0xff00, v29.h
	v_perm_b32 v24, v24, v25, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v25.l, v21.h, v23.h clamp
	v_lshlrev_b16 v21.h, 8, v29.h
	v_sub_nc_i16 v23.l, v21.h, v23.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v23, v23, v25, 0xc0c0105
	v_lshl_or_b32 v29, v23, 16, v24
	v_and_b32_e32 v23, 0x80402010, v31
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_dot4_i32_iu8 v5, v29, v5, 0 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v24, 24, v23
	v_lshrrev_b16 v21.h, 8, v23.l
	v_lshrrev_b16 v25.l, 4, v23.l
	v_lshrrev_b32_e32 v23, 22, v31
	v_mov_b16_e32 v31.h, v21.l
	v_cmp_ne_u16_e64 s0, 0, v24.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.h
	v_bfe_i32 v25, v25, 0, 1
	v_bfe_i32 v23, v23, 0, 1
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cndmask_b32_e64 v24, 0, -1, s0
	v_and_b16 v21.h, 0xff, v23.l
	v_lshlrev_b16 v23.l, 8, v23.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshlrev_b16 v23.h, 8, v24.l
	v_cndmask_b32_e64 v24, 0, -1, vcc_lo
	v_and_b16 v24.h, 0xff, v25.l
	v_or_b16 v21.h, v21.h, v23.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b16 v24.l, 8, v24.l
	v_or_b16 v31.l, v24.h, v24.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v31, v31, v21
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v30, v30, v31
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v21.h, 0xff00, v30.l
	v_sub_nc_i16 v31.l, v21.h, v24.l clamp
	v_lshlrev_b16 v21.h, 8, v30.l
	v_lshlrev_b16 v24.l, 8, v25.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v24.l, v21.h, v24.l clamp
	v_and_b16 v21.h, 0xff00, v30.h
	v_perm_b32 v24, v24, v31, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v25.l, v21.h, v23.h clamp
	v_lshlrev_b16 v21.h, 8, v30.h
	v_sub_nc_i16 v23.l, v21.h, v23.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v23, v23, v25, 0xc0c0105
	v_lshl_or_b32 v30, v23, 16, v24
	v_lshrrev_b32_e32 v23, 14, v26
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_dot4_i32_iu8 v6, v30, v6, 0 neg_lo:[1,1,0]
	v_and_b32_e32 v23, 0x3fc, v23
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v5, v5, v6
	global_load_b32 v31, v23, s[8:9]
	v_lshrrev_b32_e32 v23, 22, v26
	v_and_b32_e32 v23, 0x3fc, v23
	global_load_b32 v26, v23, s[8:9]
	v_bfe_u32 v23, v28, 7, 8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_bcnt_u32_b32 v24, v23, 0
	v_and_b32_e32 v24, 1, v24
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v24, 7, v24
	v_xor_b32_e32 v23, v24, v23
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v32, 0x1010101, v23
	v_and_b32_e32 v23, 0x8040201, v32
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshrrev_b32_e32 v24, 24, v23
	v_lshrrev_b16 v21.h, 8, v23.l
	v_lshrrev_b32_e32 v23, 18, v32
	v_cmp_ne_u16_e64 s0, 0, v24.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.h
	v_bfe_i32 v23, v23, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v24, 0, -1, s0
	v_cndmask_b32_e64 v25, 0, -1, vcc_lo
	v_and_b16 v21.h, 0xff, v23.l
	v_lshlrev_b16 v23.l, 8, v23.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshlrev_b16 v23.h, 8, v24.l
	v_bfe_i32 v24, v32, 0, 1
	v_lshlrev_b16 v25.l, 8, v25.l
	v_or_b16 v21.h, v21.h, v23.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b16 v24.h, 0xff, v24.l
	v_lshlrev_b16 v24.l, 8, v24.l
	v_or_b16 v33.l, v24.h, v25.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v33, v33, v21
	s_waitcnt vmcnt(1)
	v_xor_b32_e32 v31, v31, v33
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v21.h, 0xff00, v31.l
	v_sub_nc_i16 v25.l, v21.h, v25.l clamp
	v_lshlrev_b16 v21.h, 8, v31.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v24.l, v21.h, v24.l clamp
	v_and_b16 v21.h, 0xff00, v31.h
	v_perm_b32 v24, v24, v25, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v25.l, v21.h, v23.h clamp
	v_lshlrev_b16 v21.h, 8, v31.h
	v_sub_nc_i16 v23.l, v21.h, v23.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v23, v23, v25, 0xc0c0105
	v_lshl_or_b32 v31, v23, 16, v24
	v_and_b32_e32 v23, 0x80402010, v32
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_dot4_i32_iu8 v7, v31, v7, 0 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v24, 24, v23
	v_lshrrev_b16 v21.h, 8, v23.l
	v_lshrrev_b16 v25.l, 4, v23.l
	v_lshrrev_b32_e32 v23, 22, v32
	v_mov_b16_e32 v32.h, v21.l
	v_cmp_ne_u16_e64 s0, 0, v24.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.h
	v_bfe_i32 v25, v25, 0, 1
	v_bfe_i32 v23, v23, 0, 1
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cndmask_b32_e64 v24, 0, -1, s0
	v_and_b16 v21.h, 0xff, v23.l
	v_lshlrev_b16 v23.l, 8, v23.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshlrev_b16 v23.h, 8, v24.l
	v_cndmask_b32_e64 v24, 0, -1, vcc_lo
	v_and_b16 v24.h, 0xff, v25.l
	v_or_b16 v21.h, v21.h, v23.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b16 v24.l, 8, v24.l
	v_or_b16 v32.l, v24.h, v24.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v32, v32, v21
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v26, v26, v32
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v21.h, 0xff00, v26.l
	v_sub_nc_i16 v32.l, v21.h, v24.l clamp
	v_lshlrev_b16 v21.h, 8, v26.l
	v_lshlrev_b16 v24.l, 8, v25.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v24.l, v21.h, v24.l clamp
	v_and_b16 v21.h, 0xff00, v26.h
	v_perm_b32 v24, v24, v32, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v25.l, v21.h, v23.h clamp
	v_lshlrev_b16 v21.h, 8, v26.h
	v_sub_nc_i16 v23.l, v21.h, v23.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v23, v23, v25, 0xc0c0105
	v_lshl_or_b32 v26, v23, 16, v24
	v_and_b32_e32 v23, 0xff, v27
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_dot4_i32_iu8 v0, v26, v0, 0 neg_lo:[1,1,0]
	v_lshlrev_b32_e32 v23, 2, v23
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_add3_u32 v0, v5, v0, v7
	global_load_b32 v32, v23, s[8:9]
	v_lshrrev_b32_e32 v23, 6, v27
	v_lshrrev_b32_e32 v5, 28, v28
	v_and_b32_e32 v23, 0x3fc, v23
	global_load_b32 v33, v23, s[8:9]
	v_bfe_u32 v23, v28, 14, 8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_bcnt_u32_b32 v24, v23, 0
	v_and_b32_e32 v24, 1, v24
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v24, 7, v24
	v_xor_b32_e32 v23, v24, v23
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v34, 0x1010101, v23
	v_and_b32_e32 v23, 0x8040201, v34
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshrrev_b32_e32 v24, 24, v23
	v_lshrrev_b16 v21.h, 8, v23.l
	v_lshrrev_b32_e32 v23, 18, v34
	v_cmp_ne_u16_e64 s0, 0, v24.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.h
	v_bfe_i32 v23, v23, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v24, 0, -1, s0
	v_cndmask_b32_e64 v25, 0, -1, vcc_lo
	v_and_b16 v21.h, 0xff, v23.l
	v_lshlrev_b16 v23.l, 8, v23.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshlrev_b16 v23.h, 8, v24.l
	v_bfe_i32 v24, v34, 0, 1
	v_lshlrev_b16 v25.l, 8, v25.l
	v_or_b16 v21.h, v21.h, v23.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b16 v24.h, 0xff, v24.l
	v_lshlrev_b16 v24.l, 8, v24.l
	v_or_b16 v35.l, v24.h, v25.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v35, v35, v21
	s_waitcnt vmcnt(1)
	v_xor_b32_e32 v32, v32, v35
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v21.h, 0xff00, v32.l
	v_sub_nc_i16 v25.l, v21.h, v25.l clamp
	v_lshlrev_b16 v21.h, 8, v32.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v24.l, v21.h, v24.l clamp
	v_and_b16 v21.h, 0xff00, v32.h
	v_perm_b32 v24, v24, v25, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v25.l, v21.h, v23.h clamp
	v_lshlrev_b16 v21.h, 8, v32.h
	v_sub_nc_i16 v23.l, v21.h, v23.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v23, v23, v25, 0xc0c0105
	v_lshl_or_b32 v32, v23, 16, v24
	v_and_b32_e32 v23, 0x80402010, v34
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_dot4_i32_iu8 v1, v32, v1, 0 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v24, 24, v23
	v_lshrrev_b16 v21.h, 8, v23.l
	v_lshrrev_b16 v25.l, 4, v23.l
	v_lshrrev_b32_e32 v23, 22, v34
	v_mov_b16_e32 v34.h, v21.l
	v_cmp_ne_u16_e64 s0, 0, v24.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.h
	v_bfe_i32 v25, v25, 0, 1
	v_bfe_i32 v23, v23, 0, 1
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cndmask_b32_e64 v24, 0, -1, s0
	v_and_b16 v21.h, 0xff, v23.l
	v_lshlrev_b16 v23.l, 8, v23.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshlrev_b16 v23.h, 8, v24.l
	v_cndmask_b32_e64 v24, 0, -1, vcc_lo
	v_and_b16 v24.h, 0xff, v25.l
	v_or_b16 v21.h, v21.h, v23.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b16 v24.l, 8, v24.l
	v_or_b16 v34.l, v24.h, v24.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v34, v34, v21
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v33, v33, v34
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v21.h, 0xff00, v33.l
	v_sub_nc_i16 v34.l, v21.h, v24.l clamp
	v_lshlrev_b16 v21.h, 8, v33.l
	v_lshlrev_b16 v24.l, 8, v25.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v24.l, v21.h, v24.l clamp
	v_and_b16 v21.h, 0xff00, v33.h
	v_perm_b32 v24, v24, v34, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v25.l, v21.h, v23.h clamp
	v_lshlrev_b16 v21.h, 8, v33.h
	v_sub_nc_i16 v23.l, v21.h, v23.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v23, v23, v25, 0xc0c0105
	v_lshl_or_b32 v33, v23, 16, v24
	v_lshrrev_b32_e32 v23, 14, v27
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_dot4_i32_iu8 v2, v33, v2, 0 neg_lo:[1,1,0]
	v_and_b32_e32 v23, 0x3fc, v23
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_add3_u32 v0, v0, v2, v1
	global_load_b32 v34, v23, s[8:9]
	v_lshrrev_b32_e32 v23, 22, v27
	v_and_b32_e32 v23, 0x3fc, v23
	global_load_b32 v27, v23, s[8:9]
	v_bfe_u32 v23, v28, 21, 8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_bcnt_u32_b32 v24, v23, 0
	v_and_b32_e32 v24, 1, v24
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v24, 7, v24
	v_xor_b32_e32 v23, v24, v23
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_lo_u32 v35, 0x1010101, v23
	v_and_b32_e32 v23, 0x8040201, v35
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshrrev_b32_e32 v24, 24, v23
	v_lshrrev_b16 v21.h, 8, v23.l
	v_lshrrev_b32_e32 v23, 18, v35
	v_cmp_ne_u16_e64 s0, 0, v24.l
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.h
	v_bfe_i32 v23, v23, 0, 1
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_cndmask_b32_e64 v24, 0, -1, s0
	v_cndmask_b32_e64 v25, 0, -1, vcc_lo
	v_and_b16 v21.h, 0xff, v23.l
	v_lshlrev_b16 v23.l, 8, v23.l
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshlrev_b16 v23.h, 8, v24.l
	v_bfe_i32 v24, v35, 0, 1
	v_lshlrev_b16 v25.l, 8, v25.l
	v_or_b16 v21.h, v21.h, v23.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b16 v24.h, 0xff, v24.l
	v_lshlrev_b16 v24.l, 8, v24.l
	v_or_b16 v36.l, v24.h, v25.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v36, v36, v21
	s_waitcnt vmcnt(1)
	v_xor_b32_e32 v34, v34, v36
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v21.h, 0xff00, v34.l
	v_sub_nc_i16 v25.l, v21.h, v25.l clamp
	v_lshlrev_b16 v21.h, 8, v34.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_sub_nc_i16 v24.l, v21.h, v24.l clamp
	v_and_b16 v21.h, 0xff00, v34.h
	v_perm_b32 v24, v24, v25, 0xc0c0105
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v25.l, v21.h, v23.h clamp
	v_lshlrev_b16 v21.h, 8, v34.h
	v_sub_nc_i16 v23.l, v21.h, v23.l clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v23, v23, v25, 0xc0c0105
	v_lshl_or_b32 v34, v23, 16, v24
	v_and_b32_e32 v23, 0x80402010, v35
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_dot4_i32_iu8 v3, v34, v3, 0 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v24, 24, v23
	v_lshrrev_b16 v21.h, 8, v23.l
	v_lshrrev_b16 v25.l, 4, v23.l
	v_lshrrev_b32_e32 v23, 22, v35
	v_mov_b16_e32 v35.h, v21.l
	v_cmp_ne_u16_e64 s0, 0, v24.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.h
	v_bfe_i32 v25, v25, 0, 1
	v_bfe_i32 v23, v23, 0, 1
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cndmask_b32_e64 v24, 0, -1, s0
	v_and_b16 v21.h, 0xff, v23.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_4)
	v_lshlrev_b16 v23.h, 8, v24.l
	v_cndmask_b32_e64 v24, 0, -1, vcc_lo
	v_and_b16 v24.h, 0xff, v25.l
	v_add_co_u32 v8, vcc_lo, 0x480, v8
	v_or_b16 v21.h, v21.h, v23.h
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshlrev_b16 v24.l, 8, v24.l
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_cmp_le_u32_e32 vcc_lo, s12, v18
	v_or_b16 v35.l, v24.h, v24.l
	s_or_b32 s13, vcc_lo, s13
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_or_b32_e32 v21, v35, v21
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v27, v27, v21
	v_lshlrev_b16 v21.h, 8, v25.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_and_b16 v21.l, 0xff00, v27.l
	v_sub_nc_i16 v24.l, v21.l, v24.l clamp
	v_lshlrev_b16 v21.l, 8, v27.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v21.l, v21.l, v21.h clamp
	v_perm_b32 v24, v21, v24, 0xc0c0105
	v_and_b16 v21.l, 0xff00, v27.h
	v_lshlrev_b16 v21.h, 8, v23.l
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_sub_nc_i16 v25.l, v21.l, v23.h clamp
	v_lshlrev_b16 v21.l, 8, v27.h
	v_sub_nc_i16 v21.l, v21.l, v21.h clamp
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_perm_b32 v21, v21, v25, 0xc0c0105
	v_lshl_or_b32 v21, v21, 16, v24
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v21, v21, v22, 0 neg_lo:[1,1,0]
	v_add3_u32 v3, v0, v21, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v0, 31, v3
	v_add_nc_u32_e32 v0, v3, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v0, 1, v0
	v_mad_u64_u32 v[1:2], null, v3, v5, v[0:1]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v0, 31, v1
	v_add_nc_u32_e32 v0, v1, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_4) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 1, v0
	global_load_d16_b16 v0, v[10:11], off offset:64
	v_cvt_f32_i32_e32 v1, v1
	s_waitcnt vmcnt(0)
	v_cvt_f32_f16_e32 v0, v0.l
	v_mul_f32_e32 v0, v12, v0
	s_delay_alu instid0(VALU_DEP_1)
	v_fmac_f32_e32 v15, v0, v1
	s_and_not1_b32 exec_lo, exec_lo, s13
	s_cbranch_execnz .LBB9_2
; %bb.3:
	s_or_b32 exec_lo, exec_lo, s13
.LBB9_4:
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s1
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v17
	v_cmpx_ne_u32_e32 0, v17
	s_cbranch_execz .LBB9_6
; %bb.5:
	v_lshlrev_b32_e32 v0, 7, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_add_u32 v0, v14, 2, v0
	v_add_nc_u32_e32 v1, 0xffffff80, v0
	ds_store_b32 v1, v16
	ds_store_b32 v0, v15
.LBB9_6:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB9_52
; %bb.7:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB9_10
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB9_11
.LBB9_9:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr4
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr0
	s_branch .LBB9_26
.LBB9_10:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB9_9
.LBB9_11:
	v_mbcnt_lo_u32_b32 v0, -1, 0
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_xor_b32_e32 v1, 16, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v1
	v_cndmask_b32_e32 v1, v0, v1, vcc_lo
	v_dual_mov_b32 v1, 32 :: v_dual_lshlrev_b32 v2, 2, v1
	ds_bpermute_b32 v3, v2, v16
	s_cbranch_scc0 .LBB9_14
; %bb.12:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB9_15
.LBB9_13:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr4
                                        ; implicit-def: $vgpr3
	s_branch .LBB9_26
.LBB9_14:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB9_13
.LBB9_15:
	v_xor_b32_e32 v4, 8, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v5, v0, v4, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v4, v16, v3 :: v_dual_lshlrev_b32 v3, 2, v5
	ds_bpermute_b32 v5, v3, v4
	s_cbranch_scc0 .LBB9_18
; %bb.16:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB9_19
.LBB9_17:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr4
	s_branch .LBB9_26
.LBB9_18:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB9_17
.LBB9_19:
	v_xor_b32_e32 v6, 4, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v6
	v_cndmask_b32_e32 v6, v0, v6, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v5, v4, v5 :: v_dual_lshlrev_b32 v4, 2, v6
	ds_bpermute_b32 v6, v4, v5
	s_cbranch_scc0 .LBB9_22
; %bb.20:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB9_23
.LBB9_21:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
	s_branch .LBB9_26
.LBB9_22:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB9_21
.LBB9_23:
	v_xor_b32_e32 v7, 2, v0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v7
	s_waitcnt lgkmcnt(0)
	v_dual_cndmask_b32 v8, v0, v7 :: v_dual_add_f32 v7, v5, v6
	v_lshlrev_b32_e32 v5, 2, v8
	ds_bpermute_b32 v6, v5, v7
	s_cbranch_scc0 .LBB9_25
; %bb.24:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_branch .LBB9_26
.LBB9_25:
	s_mov_b32 s0, 0
	s_mov_b32 s4, -1
.LBB9_26:
	s_mov_b32 s1, 0
	s_and_b32 vcc_lo, exec_lo, s0
	s_mov_b32 s0, 0
	s_cbranch_vccnz .LBB9_39
; %bb.27:
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB9_41
.LBB9_28:
	v_xor_b32_e32 v8, 1, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_lt_i32_e32 vcc_lo, v8, v1
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v1, v7, v6 :: v_dual_cndmask_b32 v0, v0, v8
	v_lshlrev_b32_e32 v6, 2, v0
	ds_bpermute_b32 v0, v6, v1
	s_cbranch_scc0 .LBB9_30
; %bb.29:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB9_31
	s_branch .LBB9_46
.LBB9_30:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB9_46
.LBB9_31:
	ds_bpermute_b32 v2, v2, v15
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB9_33
; %bb.32:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB9_34
	s_branch .LBB9_46
.LBB9_33:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB9_46
.LBB9_34:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v15, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v3, v3, v2
	s_cbranch_scc0 .LBB9_36
; %bb.35:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB9_37
	s_branch .LBB9_46
.LBB9_36:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB9_46
.LBB9_37:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v2, v3
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v3, v4, v2
	s_cbranch_scc0 .LBB9_42
; %bb.38:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_branch .LBB9_43
.LBB9_39:
	s_cbranch_execnz .LBB9_53
; %bb.40:
	s_mov_b32 s0, -1
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB9_28
.LBB9_41:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr1
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB9_48
	s_branch .LBB9_49
.LBB9_42:
	s_mov_b32 s4, 0
.LBB9_43:
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB9_46
; %bb.44:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v2, v3
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v5, v3
	s_cbranch_scc0 .LBB9_55
; %bb.45:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB9_47
	s_branch .LBB9_56
.LBB9_46:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB9_56
.LBB9_47:
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB9_49
.LBB9_48:
	; divergent unreachable
.LBB9_49:
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB9_52
; %bb.50:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v3, v2
	v_cmp_eq_u32_e32 vcc_lo, 0, v14
	s_mov_b32 s1, 0
	ds_bpermute_b32 v3, v6, v2
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB9_52
; %bb.51:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v2, v3
	s_mul_i32 s0, s15, s3
	v_add_f32_e32 v0, v1, v0
	s_lshl_b64 s[0:1], s[0:1], 2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_mul_f32_e32 v3, 0xbfb8aa3b, v2
	s_add_u32 s4, s10, s0
	s_addc_u32 s5, s11, s1
	s_ashr_i32 s3, s2, 31
	s_lshl_b64 s[0:1], s[2:3], 2
	v_fma_f32 v4, 0xbfb8aa3b, v2, -v3
	v_rndne_f32_e32 v5, v3
	s_add_u32 s0, s4, s0
	s_addc_u32 s1, s5, s1
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_f32_e32 v3, v3, v5
	v_cmp_nlt_f32_e32 vcc_lo, 0x42ce8ed0, v2
	v_fmamk_f32 v4, v2, 0xb2a5705f, v4
	v_add_f32_e32 v3, v3, v4
	v_cvt_i32_f32_e32 v4, v5
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_exp_f32_e32 v3, v3
	s_waitcnt_depctr 0xfff
	v_ldexp_f32 v3, v3, v4
	v_cndmask_b32_e32 v3, 0, v3, vcc_lo
	v_cmp_ngt_f32_e32 vcc_lo, 0xc2b17218, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cndmask_b32_e32 v3, 0x7f800000, v3, vcc_lo
	v_add_f32_e32 v3, 1.0, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_div_scale_f32 v4, null, v3, v3, v2
	v_rcp_f32_e32 v5, v4
	s_waitcnt_depctr 0xfff
	v_fma_f32 v6, -v4, v5, 1.0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_fmac_f32_e32 v5, v6, v5
	v_div_scale_f32 v6, vcc_lo, v2, v3, v2
	v_mul_f32_e32 v7, v6, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fma_f32 v8, -v4, v7, v6
	v_fmac_f32_e32 v7, v8, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fma_f32 v4, -v4, v7, v6
	v_div_fmas_f32 v4, v4, v5, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_div_fixup_f32 v1, v4, v3, v2
	v_mov_b32_e32 v2, 0
	v_mul_f32_e32 v0, v0, v1
	global_store_b32 v2, v0, s[0:1]
.LBB9_52:
	s_endpgm
.LBB9_53:
	s_trap 2
	s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)
	s_mov_b32 ttmp2, m0
	s_waitcnt lgkmcnt(0)
	s_and_b32 s0, s0, 0x3ff
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_bitset1_b32 s0, 10
	s_mov_b32 m0, s0
	s_sendmsg sendmsg(MSG_INTERRUPT)
	s_mov_b32 m0, ttmp2
.LBB9_54:                               ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB9_54
.LBB9_55:
	s_mov_b32 s1, -1
	s_branch .LBB9_47
.LBB9_56:
	s_cbranch_execnz .LBB9_58
; %bb.57:
	s_cbranch_execnz .LBB9_48
	s_branch .LBB9_49
.LBB9_58:
	s_trap 2
	s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)
	s_mov_b32 ttmp2, m0
	s_waitcnt lgkmcnt(0)
	s_and_b32 s0, s0, 0x3ff
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_bitset1_b32 s0, 10
	s_mov_b32 m0, s0
	s_sendmsg sendmsg(MSG_INTERRUPT)
	s_mov_b32 m0, ttmp2
.LBB9_59:                               ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB9_59
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
		.amdhsa_group_segment_fixed_size 256
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 48
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 1
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 1
		.amdhsa_next_free_vgpr 37
		.amdhsa_next_free_sgpr 18
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_dx10_clamp 1
		.amdhsa_ieee_mode 1
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_shared_vgpr_count 0
		.amdhsa_inst_pref_size 62
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end9:
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj, .Lfunc_end9-_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj.num_vgpr, 37
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 18
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 7828
; TotalNumSgprs: 20
; NumVgprs: 37
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 256 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 4
; NumSGPRsForWavesPerEU: 20
; NumVGPRsForWavesPerEU: 37
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_load_b256 s[4:11], s[0:1], 0x10
	v_bfe_u32 v12, v0, 10, 10
	v_dual_mov_b32 v11, 0 :: v_dual_and_b32 v10, 0x3ff, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v0, v12, 5, v10
	v_lshrrev_b32_e32 v13, 3, v0
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s14, s8, 8
	s_mov_b32 s8, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_gt_u32_e64 s14, v13
	s_cbranch_execz .LBB10_4
; %bb.1:
	v_lshl_add_u32 v0, v12, 5, v10
	s_mul_i32 s10, s10, s3
	v_dual_mov_b32 v11, 0 :: v_dual_and_b32 v4, 7, v10
	s_mul_hi_u32 s13, s10, 36
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_lshrrev_b32_e32 v2, 3, v0
	s_mul_i32 s12, s10, 36
	v_lshlrev_b32_e32 v5, 1, v10
	v_mad_u64_u32 v[0:1], null, 0x120, v2, s[12:13]
	s_load_b64 s[12:13], s[0:1], 0x0
	v_mad_u64_u32 v[2:3], null, v4, 36, v[0:1]
	v_and_b32_e32 v0, 14, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_lshlrev_b32_e32 v1, 1, v0
	v_add_co_u32 v2, vcc_lo, s4, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v3, null, s5, v3, vcc_lo
	v_lshlrev_b32_e32 v14, 1, v1
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v8, vcc_lo, v2, 32
	v_add_co_ci_u32_e64 v9, null, 0, v3, vcc_lo
	v_lshlrev_b32_e32 v15, 1, v0
	s_mul_i32 s5, s9, s2
	s_mov_b32 s4, 0
.LBB10_2:                               ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v18, s5, v13
	s_clause 0x2
	global_load_b32 v16, v[8:9], off
	global_load_b128 v[0:3], v[8:9], off offset:-32
	global_load_b128 v[4:7], v[8:9], off offset:-16
	s_getpc_b64 s[0:1]
	s_add_u32 s0, s0, _ZL11iq3xxs_grid@rel32@lo+4
	s_addc_u32 s1, s1, _ZL11iq3xxs_grid@rel32@hi+12
	v_mov_b16_e32 v17.l, 0
	v_add_nc_u32_e32 v13, 4, v13
	s_waitcnt lgkmcnt(0)
	v_mad_i64_i32 v[21:22], null, 0x42, v18, s[12:13]
	s_delay_alu instid0(VALU_DEP_3)
	v_mov_b16_e32 v19.h, v17.l
	v_mov_b16_e32 v18.h, v17.l
	v_mov_b16_e32 v20.h, v17.l
	v_mov_b16_e32 v45.h, v17.l
	v_mov_b16_e32 v46.h, v17.l
	v_add_co_u32 v23, vcc_lo, v21, v14
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v24, null, 0, v22, vcc_lo
	v_add_co_u32 v25, vcc_lo, v21, v15
	v_add_co_ci_u32_e64 v26, null, 0, v22, vcc_lo
	s_clause 0x2
	global_load_b64 v[23:24], v[23:24], off
	global_load_b32 v50, v[25:26], off offset:64
	global_load_d16_hi_b16 v0, v[21:22], off offset:64
	v_mov_b16_e32 v47.h, v17.l
	v_mov_b16_e32 v48.h, v17.l
	v_mov_b16_e32 v49.h, v17.l
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v21, 0xff, v23
	v_lshrrev_b32_e32 v22, 6, v23
	v_lshrrev_b32_e32 v26, 14, v23
	v_lshrrev_b32_e32 v23, 22, v23
	v_and_b32_e32 v28, 0xff, v24
	v_lshrrev_b32_e32 v29, 6, v24
	v_lshrrev_b32_e32 v31, 14, v24
	v_lshrrev_b32_e32 v24, 22, v24
	v_lshlrev_b32_e32 v21, 2, v21
	v_and_b32_e32 v22, 0x3fc, v22
	v_and_b32_e32 v26, 0x3fc, v26
	v_and_b32_e32 v23, 0x3fc, v23
	v_lshlrev_b32_e32 v28, 2, v28
	v_and_b32_e32 v29, 0x3fc, v29
	v_and_b32_e32 v31, 0x3fc, v31
	v_and_b32_e32 v24, 0x3fc, v24
	s_clause 0x7
	global_load_b32 v51, v21, s[0:1]
	global_load_b32 v52, v22, s[0:1]
	global_load_b32 v53, v26, s[0:1]
	global_load_b32 v54, v23, s[0:1]
	global_load_b32 v55, v28, s[0:1]
	global_load_b32 v56, v29, s[0:1]
	global_load_b32 v57, v31, s[0:1]
	global_load_b32 v58, v24, s[0:1]
	s_waitcnt vmcnt(9)
	v_and_b32_e32 v25, 0xff, v50
	v_bfe_u32 v27, v50, 7, 8
	v_bfe_u32 v30, v50, 14, 8
	v_bfe_u32 v32, v50, 21, 8
	v_cmp_le_u32_e64 s0, s14, v13
	v_bcnt_u32_b32 v33, v25, 0
	v_bcnt_u32_b32 v34, v27, 0
	v_bcnt_u32_b32 v35, v30, 0
	v_bcnt_u32_b32 v36, v32, 0
	s_or_b32 s4, s0, s4
	v_and_b32_e32 v21, 1, v33
	v_and_b32_e32 v22, 1, v34
	v_and_b32_e32 v23, 1, v35
	v_and_b32_e32 v24, 1, v36
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b32_e32 v21, 7, v21
	v_lshlrev_b32_e32 v22, 7, v22
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b32_e32 v23, 7, v23
	v_lshlrev_b32_e32 v24, 7, v24
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_xor_b32_e32 v21, v21, v25
	v_xor_b32_e32 v22, v22, v27
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_xor_b32_e32 v23, v23, v30
	v_xor_b32_e32 v24, v24, v32
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_mul_lo_u32 v21, 0x1010101, v21
	v_mul_lo_u32 v22, 0x1010101, v22
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_mul_lo_u32 v23, 0x1010101, v23
	v_mul_lo_u32 v24, 0x1010101, v24
	s_delay_alu instid0(VALU_DEP_4)
	v_and_b32_e32 v25, 0x8040201, v21
	v_lshrrev_b32_e32 v26, 18, v21
	v_bfe_i32 v27, v21, 0, 1
	v_and_b32_e32 v28, 0x80402010, v21
	v_lshrrev_b32_e32 v21, 22, v21
	v_lshrrev_b32_e32 v43, 24, v25
	v_and_b32_e32 v29, 0x8040201, v22
	v_lshrrev_b32_e32 v30, 18, v22
	v_bfe_i32 v31, v22, 0, 1
	v_and_b32_e32 v32, 0x80402010, v22
	v_lshrrev_b32_e32 v22, 22, v22
	v_and_b32_e32 v33, 0x8040201, v23
	v_lshrrev_b32_e32 v34, 18, v23
	v_bfe_i32 v35, v23, 0, 1
	v_and_b32_e32 v36, 0x80402010, v23
	v_lshrrev_b32_e32 v37, 22, v23
	v_and_b32_e32 v38, 0x8040201, v24
	v_lshrrev_b32_e32 v39, 18, v24
	v_bfe_i32 v40, v24, 0, 1
	v_and_b32_e32 v41, 0x80402010, v24
	v_lshrrev_b32_e32 v42, 22, v24
	v_lshrrev_b16 v17.h, 8, v25.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v43.l
	v_mov_b16_e32 v18.l, v27.l
	v_lshrrev_b32_e32 v27, 24, v28
	v_bfe_i32 v44, v21, 0, 1
	v_lshrrev_b32_e32 v59, 24, v29
	v_lshrrev_b16 v20.l, 8, v29.l
	v_bfe_i32 v29, v30, 0, 1
	v_mov_b16_e32 v21.l, v31.l
	v_lshrrev_b32_e32 v30, 24, v32
	v_lshrrev_b16 v21.h, 8, v32.l
	v_lshrrev_b16 v31.l, 4, v32.l
	v_bfe_i32 v32, v22, 0, 1
	v_lshrrev_b32_e32 v60, 24, v33
	v_lshrrev_b16 v22.l, 8, v33.l
	v_bfe_i32 v33, v34, 0, 1
	v_mov_b16_e32 v23.l, v35.l
	v_lshrrev_b32_e32 v34, 24, v36
	v_lshrrev_b16 v22.h, 8, v36.l
	v_lshrrev_b16 v35.l, 4, v36.l
	v_bfe_i32 v36, v37, 0, 1
	v_lshrrev_b32_e32 v37, 24, v38
	v_lshrrev_b16 v23.h, 8, v38.l
	v_bfe_i32 v38, v39, 0, 1
	v_mov_b16_e32 v24.l, v40.l
	v_lshrrev_b32_e32 v39, 24, v41
	v_lshrrev_b16 v24.h, 8, v41.l
	v_lshrrev_b16 v40.l, 4, v41.l
	v_bfe_i32 v41, v42, 0, 1
	v_cndmask_b32_e64 v42, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v17.h
	v_lshrrev_b16 v19.l, 8, v28.l
	v_bfe_i32 v25, v26, 0, 1
	v_and_b16 v25.h, 0xff, v18.l
	v_lshlrev_b16 v26.l, 8, v18.l
	v_cndmask_b32_e64 v43, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v27.l
	v_mov_b16_e32 v18.l, v44.l
	v_lshrrev_b16 v28.l, 4, v28.l
	v_bfe_i32 v66, v31, 0, 1
	v_mov_b16_e32 v27.l, v33.l
	v_cndmask_b32_e64 v44, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v19.l
	v_bfe_i32 v62, v28, 0, 1
	v_mov_b16_e32 v19.l, v29.l
	v_mov_b16_e32 v29.l, v42.l
	v_and_b16 v17.h, 0xff, v25.l
	v_cndmask_b32_e64 v61, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v59.l
	v_mov_b16_e32 v31.l, v44.l
	v_mov_b16_e32 v33.l, v62.l
	v_and_b16 v28.h, 0xff, v19.l
	v_lshlrev_b16 v29.h, 8, v19.l
	v_cndmask_b32_e64 v59, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v20.l
	v_mov_b16_e32 v20.l, v32.l
	v_mov_b16_e32 v32.l, v61.l
	v_lshlrev_b16 v29.l, 8, v29.l
	v_lshlrev_b16 v27.h, 8, v18.l
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v30.l
	v_mov_b16_e32 v30.l, v43.l
	v_lshlrev_b16 v31.l, 8, v31.l
	v_lshlrev_b16 v32.l, 8, v32.l
	v_and_b16 v36.h, 0xff, v33.l
	v_cndmask_b32_e64 v64, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.h
	v_lshlrev_b16 v30.l, 8, v30.l
	v_or_b16 v17.h, v17.h, v29.l
	v_and_b16 v26.h, 0xff, v21.l
	v_mov_b16_e32 v19.l, v64.l
	v_cndmask_b32_e64 v65, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v60.l
	v_and_b16 v21.h, 0xff, v23.l
	v_bfe_i32 v70, v35, 0, 1
	v_lshlrev_b16 v38.h, 8, v19.l
	v_or_b16 v19.l, v25.h, v30.l
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v22.l
	v_lshlrev_b16 v22.l, 8, v23.l
	v_mov_b16_e32 v23.l, v36.l
	v_bfe_i32 v75, v40, 0, 1
	v_and_b16 v30.h, 0xff, v20.l
	v_cndmask_b32_e64 v67, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v34.l
	v_mov_b16_e32 v34.l, v63.l
	v_mov_b16_e32 v35.l, v65.l
	v_mov_b16_e32 v36.l, v66.l
	v_lshlrev_b16 v31.h, 8, v20.l
	v_cndmask_b32_e64 v68, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v22.h
	v_mov_b16_e32 v20.l, v60.l
	v_lshlrev_b16 v34.l, 8, v34.l
	v_or_b32_e32 v19, v19, v17
	v_mov_b16_e32 v45.l, v75.l
	v_cndmask_b32_e64 v69, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v37.l
	v_mov_b16_e32 v37.l, v67.l
	v_lshlrev_b16 v35.l, 8, v35.l
	v_and_b16 v39.h, 0xff, v36.l
	v_lshlrev_b16 v40.h, 8, v20.l
	v_cndmask_b32_e64 v71, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v23.h
	v_or_b16 v20.l, v26.h, v34.l
	v_mov_b16_e32 v28.l, v38.l
	v_and_b16 v32.h, 0xff, v27.l
	v_mov_b16_e32 v38.l, v68.l
	v_cndmask_b32_e64 v72, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v39.l
	v_mov_b16_e32 v39.l, v69.l
	v_mov_b16_e32 v40.l, v70.l
	v_lshlrev_b16 v37.l, 8, v37.l
	v_and_b16 v43.h, 0xff, v45.l
	v_cndmask_b32_e64 v73, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v24.h
	v_lshlrev_b16 v24.h, 8, v25.l
	v_and_b16 v25.l, 0xff, v18.l
	v_mov_b16_e32 v18.l, v59.l
	v_mov_b16_e32 v43.l, v73.l
	v_cndmask_b32_e64 v74, 0, -1, vcc_lo
	v_and_b16 v22.h, 0xff, v24.l
	v_or_b16 v17.h, v25.l, v31.l
	v_lshlrev_b16 v37.h, 8, v18.l
	v_or_b16 v18.l, v36.h, v32.l
	v_mov_b16_e32 v44.l, v74.l
	v_lshlrev_b16 v42.h, 8, v43.l
	v_lshlrev_b16 v23.h, 8, v24.l
	v_mov_b16_e32 v24.l, v41.l
	v_or_b32_e32 v18, v18, v17
	v_or_b16 v17.h, v28.h, v37.h
	v_lshlrev_b16 v43.l, 8, v44.l
	v_lshlrev_b16 v44.l, 8, v45.l
	v_or_b16 v45.l, v39.h, v35.l
	v_and_b16 v33.h, 0xff, v23.l
	v_or_b32_e32 v20, v20, v17
	v_or_b16 v17.h, v30.h, v38.h
	v_mov_b16_e32 v41.l, v71.l
	v_mov_b16_e32 v42.l, v72.l
	v_lshlrev_b16 v38.l, 8, v38.l
	v_lshlrev_b16 v39.l, 8, v39.l
	v_and_b16 v41.h, 0xff, v40.l
	v_or_b16 v46.l, v21.h, v37.l
	v_or_b32_e32 v25, v45, v17
	v_or_b16 v17.h, v32.h, v40.h
	v_and_b16 v34.h, 0xff, v28.l
	v_lshlrev_b16 v41.l, 8, v41.l
	v_lshlrev_b16 v42.l, 8, v42.l
	v_or_b16 v47.l, v41.h, v39.l
	v_or_b32_e32 v45, v46, v17
	v_or_b16 v17.h, v33.h, v38.l
	v_and_b16 v35.h, 0xff, v24.l
	v_or_b16 v48.l, v22.h, v42.l
	v_or_b16 v49.l, v43.h, v43.l
	v_lshlrev_b16 v33.l, 8, v33.l
	v_or_b32_e32 v46, v47, v17
	v_or_b16 v17.h, v34.h, v41.l
	v_lshlrev_b16 v21.l, 8, v21.l
	v_lshlrev_b16 v36.l, 8, v36.l
	v_lshlrev_b16 v27.l, 8, v27.l
	v_lshlrev_b16 v23.l, 8, v23.l
	v_or_b32_e32 v47, v48, v17
	v_or_b16 v17.h, v35.h, v42.h
	v_lshlrev_b16 v40.l, 8, v40.l
	v_lshlrev_b16 v28.l, 8, v28.l
	v_lshlrev_b16 v24.l, 8, v24.l
	v_add_co_u32 v8, vcc_lo, 0x480, v8
	v_or_b32_e32 v17, v49, v17
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_waitcnt vmcnt(7)
	v_xor_b32_e32 v19, v51, v19
	s_waitcnt vmcnt(6)
	v_xor_b32_e32 v48, v52, v18
	s_waitcnt vmcnt(5)
	v_xor_b32_e32 v49, v53, v20
	s_waitcnt vmcnt(4)
	v_xor_b32_e32 v51, v54, v25
	s_waitcnt vmcnt(3)
	v_xor_b32_e32 v45, v55, v45
	v_and_b16 v18.l, 0xff00, v19.h
	v_lshlrev_b16 v18.h, 8, v19.h
	s_waitcnt vmcnt(0)
	v_xor_b32_e32 v52, v58, v17
	v_and_b16 v17.l, 0xff00, v19.l
	v_lshlrev_b16 v17.h, 8, v19.l
	v_and_b16 v19.l, 0xff00, v48.l
	v_lshlrev_b16 v19.h, 8, v48.l
	v_and_b16 v20.l, 0xff00, v48.h
	v_lshlrev_b16 v20.h, 8, v48.h
	v_xor_b32_e32 v46, v56, v46
	v_and_b16 v21.h, 0xff00, v49.l
	v_lshlrev_b16 v22.h, 8, v49.l
	v_and_b16 v25.l, 0xff00, v49.h
	v_lshlrev_b16 v25.h, 8, v49.h
	v_and_b16 v26.h, 0xff00, v51.l
	v_lshlrev_b16 v28.h, 8, v51.l
	v_and_b16 v30.h, 0xff00, v51.h
	v_lshlrev_b16 v32.h, 8, v51.h
	v_sub_nc_i16 v17.l, v17.l, v30.l clamp
	v_sub_nc_i16 v26.l, v17.h, v26.l clamp
	v_sub_nc_i16 v18.l, v18.l, v29.l clamp
	v_sub_nc_i16 v29.l, v18.h, v24.h clamp
	v_sub_nc_i16 v19.l, v19.l, v32.l clamp
	v_sub_nc_i16 v30.l, v19.h, v33.l clamp
	v_sub_nc_i16 v20.l, v20.l, v31.l clamp
	v_sub_nc_i16 v31.l, v20.h, v27.h clamp
	v_xor_b32_e32 v47, v57, v47
	v_and_b16 v33.h, 0xff00, v45.l
	v_lshlrev_b16 v34.h, 8, v45.l
	v_and_b16 v35.h, 0xff00, v45.h
	v_lshlrev_b16 v36.h, 8, v45.h
	v_and_b16 v39.h, 0xff00, v46.l
	v_lshlrev_b16 v41.h, 8, v46.l
	v_and_b16 v43.h, 0xff00, v46.h
	v_lshlrev_b16 v44.h, 8, v46.h
	v_sub_nc_i16 v32.l, v21.h, v34.l clamp
	v_sub_nc_i16 v21.l, v22.h, v21.l clamp
	v_sub_nc_i16 v25.l, v25.l, v37.h clamp
	v_sub_nc_i16 v33.l, v25.h, v29.h clamp
	v_sub_nc_i16 v34.l, v26.h, v35.l clamp
	v_sub_nc_i16 v35.l, v28.h, v36.l clamp
	v_sub_nc_i16 v36.l, v30.h, v38.h clamp
	v_sub_nc_i16 v49.l, v32.h, v31.h clamp
	v_perm_b32 v17, v26, v17, 0xc0c0105
	v_perm_b32 v18, v29, v18, 0xc0c0105
	v_perm_b32 v19, v30, v19, 0xc0c0105
	v_perm_b32 v20, v31, v20, 0xc0c0105
	v_and_b16 v45.l, 0xff00, v47.l
	v_lshlrev_b16 v45.h, 8, v47.l
	v_and_b16 v46.l, 0xff00, v47.h
	v_lshlrev_b16 v46.h, 8, v47.h
	v_and_b16 v47.l, 0xff00, v52.l
	v_lshlrev_b16 v47.h, 8, v52.l
	v_and_b16 v48.l, 0xff00, v52.h
	v_lshlrev_b16 v48.h, 8, v52.h
	v_sub_nc_i16 v37.l, v33.h, v37.l clamp
	v_sub_nc_i16 v22.l, v34.h, v22.l clamp
	v_sub_nc_i16 v51.l, v35.h, v40.h clamp
	v_sub_nc_i16 v27.l, v36.h, v27.l clamp
	v_sub_nc_i16 v39.l, v39.h, v39.l clamp
	v_sub_nc_i16 v40.l, v41.h, v40.l clamp
	v_sub_nc_i16 v38.l, v43.h, v38.l clamp
	v_sub_nc_i16 v23.l, v44.h, v23.l clamp
	v_perm_b32 v21, v21, v32, 0xc0c0105
	v_perm_b32 v25, v33, v25, 0xc0c0105
	v_perm_b32 v26, v35, v34, 0xc0c0105
	v_perm_b32 v29, v49, v36, 0xc0c0105
	v_lshl_or_b32 v17, v18, 16, v17
	v_lshl_or_b32 v18, v20, 16, v19
	v_sub_nc_i16 v42.l, v45.l, v42.l clamp
	v_sub_nc_i16 v45.l, v45.h, v23.h clamp
	v_sub_nc_i16 v41.l, v46.l, v41.l clamp
	v_sub_nc_i16 v28.l, v46.h, v28.l clamp
	v_sub_nc_i16 v43.l, v47.l, v43.l clamp
	v_sub_nc_i16 v44.l, v47.h, v44.l clamp
	v_sub_nc_i16 v46.l, v48.l, v42.h clamp
	v_sub_nc_i16 v24.l, v48.h, v24.l clamp
	v_perm_b32 v22, v22, v37, 0xc0c0105
	v_perm_b32 v27, v27, v51, 0xc0c0105
	v_perm_b32 v30, v40, v39, 0xc0c0105
	v_perm_b32 v23, v23, v38, 0xc0c0105
	v_lshl_or_b32 v19, v25, 16, v21
	v_lshl_or_b32 v20, v29, 16, v26
	v_dot4_i32_iu8 v1, v17, v1, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v2, v18, v2, 0 neg_lo:[1,1,0]
	v_perm_b32 v31, v45, v42, 0xc0c0105
	v_perm_b32 v28, v28, v41, 0xc0c0105
	v_perm_b32 v32, v44, v43, 0xc0c0105
	v_perm_b32 v24, v24, v46, 0xc0c0105
	v_lshl_or_b32 v21, v27, 16, v22
	v_lshl_or_b32 v22, v23, 16, v30
	v_dot4_i32_iu8 v3, v19, v3, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v4, v20, v4, 0 neg_lo:[1,1,0]
	v_add_nc_u32_e32 v1, v1, v2
	v_lshl_or_b32 v17, v28, 16, v31
	v_lshl_or_b32 v2, v24, 16, v32
	v_dot4_i32_iu8 v5, v21, v5, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v6, v22, v6, 0 neg_lo:[1,1,0]
	v_add3_u32 v1, v1, v4, v3
	v_dot4_i32_iu8 v3, v17, v7, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v2, v2, v16, 0 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add3_u32 v1, v1, v6, v5
	v_lshrrev_b32_e32 v5, 28, v50
	v_add3_u32 v4, v1, v2, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v1, 31, v4
	v_add_nc_u32_e32 v1, v4, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 1, v1
	v_mad_u64_u32 v[2:3], null, v4, v5, v[1:2]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v1, 31, v2
	v_add_nc_u32_e32 v1, v2, v1
	v_cvt_f32_f16_e32 v2, v0.l
	v_cvt_f32_f16_e32 v0, v0.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_ashrrev_i32_e32 v1, 1, v1
	v_mul_f32_e32 v0, v0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_f32_i32_e32 v1, v1
	v_fmac_f32_e32 v11, v0, v1
	s_and_not1_b32 exec_lo, exec_lo, s4
	s_cbranch_execnz .LBB10_2
; %bb.3:
	s_or_b32 exec_lo, exec_lo, s4
.LBB10_4:
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s8
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v12
	v_cmpx_ne_u32_e32 0, v12
	s_cbranch_execz .LBB10_6
; %bb.5:
	v_lshlrev_b32_e32 v0, 7, v12
	v_lshlrev_b32_e32 v1, 2, v10
	s_delay_alu instid0(VALU_DEP_1)
	v_add3_u32 v0, v0, v1, 0xffffff80
	ds_store_b32 v0, v11
.LBB10_6:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB10_24
; %bb.7:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, 0
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB10_10
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB10_11
.LBB10_9:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr0
	s_branch .LBB10_20
.LBB10_10:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB10_9
.LBB10_11:
	v_mbcnt_lo_u32_b32 v0, -1, 0
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_xor_b32_e32 v1, 16, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v1
	v_cndmask_b32_e32 v1, v0, v1, vcc_lo
	v_lshlrev_b32_e32 v1, 2, v1
	ds_bpermute_b32 v2, v1, v11
	v_mov_b32_e32 v1, 32
	s_cbranch_scc0 .LBB10_13
; %bb.12:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB10_14
	s_branch .LBB10_19
.LBB10_13:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB10_19
.LBB10_14:
	v_xor_b32_e32 v3, 8, v0
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v11, v2
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v3
	v_cndmask_b32_e32 v3, v0, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v3, 2, v3
	ds_bpermute_b32 v3, v3, v2
	s_cbranch_scc0 .LBB10_16
; %bb.15:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB10_17
	s_branch .LBB10_19
.LBB10_16:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB10_19
.LBB10_17:
	v_xor_b32_e32 v4, 4, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v4, v0, v4, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v2, v2, v3 :: v_dual_lshlrev_b32 v3, 2, v4
	ds_bpermute_b32 v3, v3, v2
	s_cbranch_scc0 .LBB10_25
; %bb.18:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB10_26
.LBB10_19:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
.LBB10_20:
	s_and_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB10_28
; %bb.21:
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB10_24
.LBB10_22:
	v_xor_b32_e32 v4, 1, v0
	s_mov_b32 s1, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_cmp_lt_i32_e32 vcc_lo, v4, v1
	s_waitcnt lgkmcnt(0)
	v_dual_cndmask_b32 v1, v0, v4 :: v_dual_add_f32 v0, v3, v2
	v_cmp_eq_u32_e32 vcc_lo, 0, v10
	v_lshlrev_b32_e32 v1, 2, v1
	ds_bpermute_b32 v1, v1, v0
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB10_24
; %bb.23:
	s_mul_i32 s0, s11, s3
	v_mov_b32_e32 v2, 0
	s_lshl_b64 s[0:1], s[0:1], 2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v0, v0, v1
	s_add_u32 s4, s6, s0
	s_addc_u32 s5, s7, s1
	s_ashr_i32 s3, s2, 31
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_lshl_b64 s[0:1], s[2:3], 2
	s_add_u32 s0, s4, s0
	s_addc_u32 s1, s5, s1
	global_store_b32 v2, v0, s[0:1]
.LBB10_24:
	s_endpgm
.LBB10_25:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB10_19
.LBB10_26:
	v_xor_b32_e32 v4, 2, v0
	s_cmp_lg_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v2, v3
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v4, v0, v4, vcc_lo
	v_lshlrev_b32_e32 v2, 2, v4
	ds_bpermute_b32 v2, v2, v3
	s_cbranch_scc0 .LBB10_32
; %bb.27:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_branch .LBB10_20
.LBB10_28:
	s_cbranch_execnz .LBB10_30
; %bb.29:
	; divergent unreachable
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB10_22
	s_branch .LBB10_24
.LBB10_30:
	s_trap 2
	s_sendmsg_rtn_b32 s0, sendmsg(MSG_RTN_GET_DOORBELL)
	s_mov_b32 ttmp2, m0
	s_waitcnt lgkmcnt(0)
	s_and_b32 s0, s0, 0x3ff
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_bitset1_b32 s0, 10
	s_mov_b32 m0, s0
	s_sendmsg sendmsg(MSG_INTERRUPT)
	s_mov_b32 m0, ttmp2
.LBB10_31:                              ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB10_31
.LBB10_32:
	s_mov_b32 s1, 0
	s_mov_b32 s0, -1
	s_branch .LBB10_20
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
		.amdhsa_group_segment_fixed_size 128
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 48
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 1
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 1
		.amdhsa_next_free_vgpr 76
		.amdhsa_next_free_sgpr 15
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_dx10_clamp 1
		.amdhsa_ieee_mode 1
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 1
		.amdhsa_shared_vgpr_count 0
		.amdhsa_inst_pref_size 30
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end10:
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj, .Lfunc_end10-_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj.num_vgpr, 76
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 15
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 3816
; TotalNumSgprs: 17
; NumVgprs: 76
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 128 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 9
; NumSGPRsForWavesPerEU: 17
; NumVGPRsForWavesPerEU: 76
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.section	.AMDGPU.gpr_maximums,"",@progbits
	.set amdgpu.max_num_vgpr, 0
	.set amdgpu.max_num_agpr, 0
	.set amdgpu.max_num_sgpr, 0
	.section	.AMDGPU.csdata,"",@progbits
	.type	_ZL11iq3xxs_grid,@object        ; @_ZL11iq3xxs_grid
	.section	.rodata,"a",@progbits
	.p2align	4, 0x0
_ZL11iq3xxs_grid:
	.long	3                               ; 0x3
	.long	67372036                        ; 0x4040404
	.long	67372052                        ; 0x4040414
	.long	67372068                        ; 0x4040424
	.long	67374092                        ; 0x4040c0c
	.long	67374108                        ; 0x4040c1c
	.long	67374142                        ; 0x4040c3e
	.long	67376132                        ; 0x4041404
	.long	67376148                        ; 0x4041414
	.long	67378188                        ; 0x4041c0c
	.long	67380244                        ; 0x4042414
	.long	67386908                        ; 0x4043e1c
	.long	67386924                        ; 0x4043e2c
	.long	67896332                        ; 0x40c040c
	.long	67896348                        ; 0x40c041c
	.long	67898372                        ; 0x40c0c04
	.long	67898388                        ; 0x40c0c14
	.long	67900428                        ; 0x40c140c
	.long	67900460                        ; 0x40c142c
	.long	67902468                        ; 0x40c1c04
	.long	67902484                        ; 0x40c1c14
	.long	67904524                        ; 0x40c240c
	.long	67906596                        ; 0x40c2c24
	.long	67911172                        ; 0x40c3e04
	.long	68420612                        ; 0x4140404
	.long	68420628                        ; 0x4140414
	.long	68420644                        ; 0x4140424
	.long	68422668                        ; 0x4140c0c
	.long	68424708                        ; 0x4141404
	.long	68424724                        ; 0x4141414
	.long	68426764                        ; 0x4141c0c
	.long	68426780                        ; 0x4141c1c
	.long	68426814                        ; 0x4141c3e
	.long	68430860                        ; 0x4142c0c
	.long	68430910                        ; 0x4142c3e
	.long	68435500                        ; 0x4143e2c
	.long	68944908                        ; 0x41c040c
	.long	68944958                        ; 0x41c043e
	.long	68946948                        ; 0x41c0c04
	.long	68946964                        ; 0x41c0c14
	.long	68949036                        ; 0x41c142c
	.long	68959748                        ; 0x41c3e04
	.long	69471260                        ; 0x4240c1c
	.long	69475390                        ; 0x4241c3e
	.long	69477412                        ; 0x4242424
	.long	69479486                        ; 0x4242c3e
	.long	69484060                        ; 0x4243e1c
	.long	69484076                        ; 0x4243e2c
	.long	69993484                        ; 0x42c040c
	.long	69993534                        ; 0x42c043e
	.long	69999636                        ; 0x42c1c14
	.long	70003732                        ; 0x42c2c14
	.long	70523948                        ; 0x4341c2c
	.long	70530084                        ; 0x4343424
	.long	71175172                        ; 0x43e0c04
	.long	71175204                        ; 0x43e0c24
	.long	71175220                        ; 0x43e0c34
	.long	71181340                        ; 0x43e241c
	.long	71185420                        ; 0x43e340c
	.long	201589772                       ; 0xc04040c
	.long	201589788                       ; 0xc04041c
	.long	201591812                       ; 0xc040c04
	.long	201591828                       ; 0xc040c14
	.long	201593868                       ; 0xc04140c
	.long	201593884                       ; 0xc04141c
	.long	201595908                       ; 0xc041c04
	.long	201595924                       ; 0xc041c14
	.long	201595940                       ; 0xc041c24
	.long	201598014                       ; 0xc04243e
	.long	201600004                       ; 0xc042c04
	.long	202114052                       ; 0xc0c0404
	.long	202114068                       ; 0xc0c0414
	.long	202116108                       ; 0xc0c0c0c
	.long	202118148                       ; 0xc0c1404
	.long	202118164                       ; 0xc0c1414
	.long	202638348                       ; 0xc14040c
	.long	202638364                       ; 0xc14041c
	.long	202640388                       ; 0xc140c04
	.long	202640404                       ; 0xc140c14
	.long	202642444                       ; 0xc14140c
	.long	202644484                       ; 0xc141c04
	.long	202653204                       ; 0xc143e14
	.long	203162628                       ; 0xc1c0404
	.long	203162644                       ; 0xc1c0414
	.long	203166724                       ; 0xc1c1404
	.long	203168780                       ; 0xc1c1c0c
	.long	203170868                       ; 0xc1c2434
	.long	203174964                       ; 0xc1c3434
	.long	203686924                       ; 0xc24040c
	.long	203686956                       ; 0xc24042c
	.long	203697156                       ; 0xc242c04
	.long	204215300                       ; 0xc2c1404
	.long	204215332                       ; 0xc2c1424
	.long	204219444                       ; 0xc2c2434
	.long	204226060                       ; 0xc2c3e0c
	.long	204735532                       ; 0xc34042c
	.long	205394964                       ; 0xc3e1414
	.long	205399044                       ; 0xc3e2404
	.long	335807492                       ; 0x14040404
	.long	335807508                       ; 0x14040414
	.long	335809548                       ; 0x14040c0c
	.long	335809564                       ; 0x14040c1c
	.long	335811588                       ; 0x14041404
	.long	335811604                       ; 0x14041414
	.long	335811636                       ; 0x14041434
	.long	335813644                       ; 0x14041c0c
	.long	335815700                       ; 0x14042414
	.long	336331788                       ; 0x140c040c
	.long	336331804                       ; 0x140c041c
	.long	336331820                       ; 0x140c042c
	.long	336333828                       ; 0x140c0c04
	.long	336333844                       ; 0x140c0c14
	.long	336335884                       ; 0x140c140c
	.long	336337924                       ; 0x140c1c04
	.long	336344092                       ; 0x140c341c
	.long	336344126                       ; 0x140c343e
	.long	336346628                       ; 0x140c3e04
	.long	336856068                       ; 0x14140404
	.long	336856084                       ; 0x14140414
	.long	336858124                       ; 0x14140c0c
	.long	336858174                       ; 0x14140c3e
	.long	336860164                       ; 0x14141404
	.long	336860180                       ; 0x14141414
	.long	336862270                       ; 0x14141c3e
	.long	336864260                       ; 0x14142404
	.long	336866348                       ; 0x14142c2c
	.long	337380364                       ; 0x141c040c
	.long	337382404                       ; 0x141c0c04
	.long	337382436                       ; 0x141c0c24
	.long	337395204                       ; 0x141c3e04
	.long	337395236                       ; 0x141c3e24
	.long	337910828                       ; 0x14241c2c
	.long	337914908                       ; 0x14242c1c
	.long	338428956                       ; 0x142c041c
	.long	338433086                       ; 0x142c143e
	.long	338437132                       ; 0x142c240c
	.long	338443812                       ; 0x142c3e24
	.long	339608588                       ; 0x143e040c
	.long	339608604                       ; 0x143e041c
	.long	339610676                       ; 0x143e0c34
	.long	339616812                       ; 0x143e242c
	.long	470025228                       ; 0x1c04040c
	.long	470027268                       ; 0x1c040c04
	.long	470027284                       ; 0x1c040c14
	.long	470029324                       ; 0x1c04140c
	.long	470029340                       ; 0x1c04141c
	.long	470035460                       ; 0x1c042c04
	.long	470037548                       ; 0x1c04342c
	.long	470040084                       ; 0x1c043e14
	.long	470549508                       ; 0x1c0c0404
	.long	470549524                       ; 0x1c0c0414
	.long	470553604                       ; 0x1c0c1404
	.long	470555660                       ; 0x1c0c1c0c
	.long	470557732                       ; 0x1c0c2424
	.long	470557748                       ; 0x1c0c2434
	.long	471073804                       ; 0x1c14040c
	.long	471073820                       ; 0x1c14041c
	.long	471075844                       ; 0x1c140c04
	.long	471077932                       ; 0x1c14142c
	.long	471084052                       ; 0x1c142c14
	.long	471088660                       ; 0x1c143e14
	.long	471600140                       ; 0x1c1c0c0c
	.long	471604252                       ; 0x1c1c1c1c
	.long	472128516                       ; 0x1c241c04
	.long	472130622                       ; 0x1c24243e
	.long	472137236                       ; 0x1c243e14
	.long	472646660                       ; 0x1c2c0404
	.long	472646708                       ; 0x1c2c0434
	.long	472650772                       ; 0x1c2c1414
	.long	472656940                       ; 0x1c2c2c2c
	.long	473173028                       ; 0x1c340c24
	.long	473177140                       ; 0x1c341c34
	.long	473183260                       ; 0x1c34341c
	.long	473832476                       ; 0x1c3e1c1c
	.long	473838596                       ; 0x1c3e3404
	.long	604242980                       ; 0x24040424
	.long	604245054                       ; 0x24040c3e
	.long	604249132                       ; 0x24041c2c
	.long	604249150                       ; 0x24041c3e
	.long	604253212                       ; 0x24042c1c
	.long	604253246                       ; 0x24042c3e
	.long	604782116                       ; 0x240c3e24
	.long	605295620                       ; 0x24141404
	.long	605297726                       ; 0x24141c3e
	.long	605299716                       ; 0x24142404
	.long	605303812                       ; 0x24143404
	.long	605303860                       ; 0x24143434
	.long	605815870                       ; 0x241c043e
	.long	605824044                       ; 0x241c242c
	.long	606340132                       ; 0x24240424
	.long	606350348                       ; 0x24242c0c
	.long	606352420                       ; 0x24243424
	.long	606868524                       ; 0x242c142c
	.long	606872604                       ; 0x242c241c
	.long	606879236                       ; 0x242c3e04
	.long	608044076                       ; 0x243e042c
	.long	608046084                       ; 0x243e0c04
	.long	608046100                       ; 0x243e0c14
	.long	608050180                       ; 0x243e1c04
	.long	738462740                       ; 0x2c040c14
	.long	738468876                       ; 0x2c04240c
	.long	738475524                       ; 0x2c043e04
	.long	738984964                       ; 0x2c0c0404
	.long	738985012                       ; 0x2c0c0434
	.long	738989108                       ; 0x2c0c1434
	.long	738995244                       ; 0x2c0c2c2c
	.long	739511332                       ; 0x2c140c24
	.long	739515412                       ; 0x2c141c14
	.long	739524116                       ; 0x2c143e14
	.long	740033556                       ; 0x2c1c0414
	.long	740043804                       ; 0x2c1c2c1c
	.long	740559876                       ; 0x2c240c04
	.long	740561948                       ; 0x2c24141c
	.long	740561982                       ; 0x2c24143e
	.long	740572692                       ; 0x2c243e14
	.long	741082132                       ; 0x2c2c0414
	.long	741088268                       ; 0x2c2c1c0c
	.long	741616644                       ; 0x2c342c04
	.long	742265892                       ; 0x2c3e1424
	.long	742269972                       ; 0x2c3e2414
	.long	872682532                       ; 0x34041424
	.long	872686628                       ; 0x34042424
	.long	872686644                       ; 0x34042434
	.long	872690724                       ; 0x34043424
	.long	873206796                       ; 0x340c140c
	.long	873214988                       ; 0x340c340c
	.long	873729086                       ; 0x34140c3e
	.long	873739300                       ; 0x34143424
	.long	874257412                       ; 0x341c1c04
	.long	874257460                       ; 0x341c1c34
	.long	874783780                       ; 0x34242424
	.long	875299884                       ; 0x342c042c
	.long	875310100                       ; 0x342c2c14
	.long	875830300                       ; 0x34341c1c
	.long	876479516                       ; 0x343e041c
	.long	876483596                       ; 0x343e140c
	.long	1040450588                      ; 0x3e04041c
	.long	1040450604                      ; 0x3e04042c
	.long	1040450622                      ; 0x3e04043e
	.long	1040452612                      ; 0x3e040c04
	.long	1040456724                      ; 0x3e041c14
	.long	1040460820                      ; 0x3e042c14
	.long	1040978996                      ; 0x3e0c1434
	.long	1040983044                      ; 0x3e0c2404
	.long	1041501204                      ; 0x3e140c14
	.long	1041507372                      ; 0x3e14242c
	.long	1041509396                      ; 0x3e142c14
	.long	1042023428                      ; 0x3e1c0404
	.long	1042025516                      ; 0x3e1c0c2c
	.long	1042029596                      ; 0x3e1c1c1c
	.long	1042035716                      ; 0x3e1c3404
	.long	1042551820                      ; 0x3e24140c
	.long	1042555916                      ; 0x3e24240c
	.long	1043072004                      ; 0x3e2c0404
	.long	1043072020                      ; 0x3e2c0414
	.long	1043076132                      ; 0x3e2c1424
	.size	_ZL11iq3xxs_grid, 1024

	.type	__hip_cuid_dfe6ff6a84b3117c,@object ; @__hip_cuid_dfe6ff6a84b3117c
	.section	.bss,"aw",@nobits
	.globl	__hip_cuid_dfe6ff6a84b3117c
__hip_cuid_dfe6ff6a84b3117c:
	.byte	0                               ; 0x0
	.size	__hip_cuid_dfe6ff6a84b3117c, 1

	.ident	"AMD clang version 22.0.0git (/srcdest/rocm-llvm f58b06dce1f9c15707c5f808fd002e18c2accf7e)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym __hip_cuid_dfe6ff6a84b3117c
	.amdgpu_metadata
---
amdhsa.kernels:
  - .args:
      - .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         24
        .size:           8
        .value_kind:     global_buffer
      - .offset:         32
        .size:           4
        .value_kind:     by_value
      - .offset:         36
        .size:           4
        .value_kind:     by_value
      - .offset:         40
        .size:           4
        .value_kind:     by_value
      - .offset:         44
        .size:           4
        .value_kind:     by_value
    .group_segment_fixed_size: 256
    .kernarg_segment_align: 8
    .kernarg_segment_size: 48
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 32
    .name:           _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     20
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     33
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         24
        .size:           8
        .value_kind:     global_buffer
      - .offset:         32
        .size:           4
        .value_kind:     by_value
      - .offset:         36
        .size:           4
        .value_kind:     by_value
      - .offset:         40
        .size:           4
        .value_kind:     by_value
      - .offset:         44
        .size:           4
        .value_kind:     by_value
    .group_segment_fixed_size: 128
    .kernarg_segment_align: 8
    .kernarg_segment_size: 48
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 32
    .name:           _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     17
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     76
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         24
        .size:           8
        .value_kind:     global_buffer
      - .offset:         32
        .size:           4
        .value_kind:     by_value
      - .offset:         36
        .size:           4
        .value_kind:     by_value
      - .offset:         40
        .size:           4
        .value_kind:     by_value
      - .offset:         44
        .size:           4
        .value_kind:     by_value
    .group_segment_fixed_size: 256
    .kernarg_segment_align: 8
    .kernarg_segment_size: 48
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 32
    .name:           _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     20
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     90
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         24
        .size:           8
        .value_kind:     global_buffer
      - .offset:         32
        .size:           4
        .value_kind:     by_value
      - .offset:         36
        .size:           4
        .value_kind:     by_value
      - .offset:         40
        .size:           4
        .value_kind:     by_value
      - .offset:         44
        .size:           4
        .value_kind:     by_value
    .group_segment_fixed_size: 512
    .kernarg_segment_align: 8
    .kernarg_segment_size: 48
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 32
    .name:           _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     17
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     93
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         24
        .size:           8
        .value_kind:     global_buffer
      - .offset:         32
        .size:           4
        .value_kind:     by_value
      - .offset:         36
        .size:           4
        .value_kind:     by_value
      - .offset:         40
        .size:           4
        .value_kind:     by_value
      - .offset:         44
        .size:           4
        .value_kind:     by_value
    .group_segment_fixed_size: 1024
    .kernarg_segment_align: 8
    .kernarg_segment_size: 48
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 32
    .name:           _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     23
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     37
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         24
        .size:           8
        .value_kind:     global_buffer
      - .offset:         32
        .size:           4
        .value_kind:     by_value
      - .offset:         36
        .size:           4
        .value_kind:     by_value
      - .offset:         40
        .size:           4
        .value_kind:     by_value
      - .offset:         44
        .size:           4
        .value_kind:     by_value
    .group_segment_fixed_size: 256
    .kernarg_segment_align: 8
    .kernarg_segment_size: 48
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 32
    .name:           _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     20
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     33
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         24
        .size:           8
        .value_kind:     global_buffer
      - .offset:         32
        .size:           4
        .value_kind:     by_value
      - .offset:         36
        .size:           4
        .value_kind:     by_value
      - .offset:         40
        .size:           4
        .value_kind:     by_value
      - .offset:         44
        .size:           4
        .value_kind:     by_value
    .group_segment_fixed_size: 128
    .kernarg_segment_align: 8
    .kernarg_segment_size: 48
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 32
    .name:           _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     17
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     76
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         24
        .size:           8
        .value_kind:     global_buffer
      - .offset:         32
        .size:           4
        .value_kind:     by_value
      - .offset:         36
        .size:           4
        .value_kind:     by_value
      - .offset:         40
        .size:           4
        .value_kind:     by_value
      - .offset:         44
        .size:           4
        .value_kind:     by_value
    .group_segment_fixed_size: 256
    .kernarg_segment_align: 8
    .kernarg_segment_size: 48
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 32
    .name:           _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     20
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     35
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         24
        .size:           8
        .value_kind:     global_buffer
      - .offset:         32
        .size:           4
        .value_kind:     by_value
      - .offset:         36
        .size:           4
        .value_kind:     by_value
      - .offset:         40
        .size:           4
        .value_kind:     by_value
      - .offset:         44
        .size:           4
        .value_kind:     by_value
    .group_segment_fixed_size: 128
    .kernarg_segment_align: 8
    .kernarg_segment_size: 48
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 32
    .name:           _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     17
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     76
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         24
        .size:           8
        .value_kind:     global_buffer
      - .offset:         32
        .size:           4
        .value_kind:     by_value
      - .offset:         36
        .size:           4
        .value_kind:     by_value
      - .offset:         40
        .size:           4
        .value_kind:     by_value
      - .offset:         44
        .size:           4
        .value_kind:     by_value
    .group_segment_fixed_size: 256
    .kernarg_segment_align: 8
    .kernarg_segment_size: 48
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 32
    .name:           _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     20
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     37
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
  - .args:
      - .address_space:  global
        .offset:         0
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         8
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         16
        .size:           8
        .value_kind:     global_buffer
      - .address_space:  global
        .offset:         24
        .size:           8
        .value_kind:     global_buffer
      - .offset:         32
        .size:           4
        .value_kind:     by_value
      - .offset:         36
        .size:           4
        .value_kind:     by_value
      - .offset:         40
        .size:           4
        .value_kind:     by_value
      - .offset:         44
        .size:           4
        .value_kind:     by_value
    .group_segment_fixed_size: 128
    .kernarg_segment_align: 8
    .kernarg_segment_size: 48
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 32
    .name:           _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     17
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     76
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
amdhsa.target:   amdgcn-amd-amdhsa--gfx1101
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata

# __CLANG_OFFLOAD_BUNDLE____END__ hip-amdgcn-amd-amdhsa--gfx1101

# __CLANG_OFFLOAD_BUNDLE____START__ host-x86_64-pc-linux-gnu-
	.file	"mmvq_bench_accum.hip"
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function main
.LCPI0_0:
	.long	1127219200                      # 0x43300000
	.long	1160773632                      # 0x45300000
	.long	0                               # 0x0
	.long	0                               # 0x0
.LCPI0_1:
	.quad	0x4330000000000000              # double 4503599627370496
	.quad	0x4530000000000000              # double 1.9342813113834067E+25
.LCPI0_3:
	.quad	0x41cdcd6500000000              # double 1.0E+9
	.quad	0x41cdcd6500000000              # double 1.0E+9
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.LCPI0_2:
	.quad	0x3f50624dd2f1a9fc              # double 0.001
	.text
	.globl	main
	.p2align	4
	.type	main,@function
main:                                   # @main
.Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, DW.ref.__gxx_personality_v0
	.cfi_lsda 27, .Lexception0
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$1096, %rsp                     # imm = 0x448
	.cfi_def_cfa_offset 1152
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	cmpl	$1, %edi
	jg	.LBB0_2
# %bb.1:
	movq	(%rsi), %rsi
	leaq	.L.str(%rip), %rdi
	jmp	.LBB0_5
.LBB0_2:
	movl	%edi, %ebp
	movq	%rsi, %r14
	movq	8(%rsi), %rbx
	leaq	.L.str.1(%rip), %rsi
	movq	%rbx, %rdi
	callq	strcmp@PLT
	testl	%eax, %eax
	je	.LBB0_6
# %bb.3:
	leaq	.L.str.7(%rip), %rsi
	movq	%rbx, %rdi
	callq	strcmp@PLT
	testl	%eax, %eax
	je	.LBB0_12
# %bb.4:
	leaq	.L.str.21(%rip), %rdi
	movq	%rbx, %rsi
.LBB0_5:
	xorl	%eax, %eax
	callq	printf@PLT
	movl	$1, %eax
	jmp	.LBB0_172
.LBB0_6:
	leaq	.L.str.2(%rip), %rsi
	leaq	584(%rsp), %rbx
	movq	%rbx, %rdi
	movl	$16, %edx
	callq	_ZNSt14basic_ofstreamIcSt11char_traitsIcEEC1EPKcSt13_Ios_Openmode@PLT
.Ltmp196:                               # EH_LABEL
	leaq	.L.str.3(%rip), %rsi
	movl	$56, %edx
	movq	%rbx, %rdi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp197:                               # EH_LABEL
# %bb.7:
.Ltmp198:                               # EH_LABEL
	leaq	.L.str.4(%rip), %rsi
	leaq	584(%rsp), %rdi
	movl	$81, %edx
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp199:                               # EH_LABEL
# %bb.8:
.Ltmp200:                               # EH_LABEL
	leaq	584(%rsp), %rcx
	movl	$17408, %edi                    # imm = 0x4400
	movl	$5120, %esi                     # imm = 0x1400
	xorl	%edx, %edx
	callq	_ZL8verify_eiibRSt14basic_ofstreamIcSt11char_traitsIcEE
.Ltmp201:                               # EH_LABEL
# %bb.9:
.Ltmp202:                               # EH_LABEL
	leaq	584(%rsp), %rcx
	movl	$5120, %edi                     # imm = 0x1400
	movl	$17408, %esi                    # imm = 0x4400
	movl	$1, %edx
	callq	_ZL8verify_eiibRSt14basic_ofstreamIcSt11char_traitsIcEE
.Ltmp203:                               # EH_LABEL
# %bb.10:
.Ltmp204:                               # EH_LABEL
	leaq	.L.str.5(%rip), %rsi
	leaq	584(%rsp), %rdi
	movl	$50, %edx
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp205:                               # EH_LABEL
# %bb.11:
	leaq	.Lstr(%rip), %rdi
	callq	puts@PLT
	jmp	.LBB0_171
.LBB0_12:
	cmpl	$2, %ebp
	jne	.LBB0_14
# %bb.13:
	leaq	.L.str.8(%rip), %rsi
	jmp	.LBB0_15
.LBB0_14:
	movq	16(%r14), %rsi
.LBB0_15:
	leaq	584(%rsp), %rbx
	movq	%rbx, %rdi
	movq	%rsi, 376(%rsp)                 # 8-byte Spill
	movl	$16, %edx
	callq	_ZNSt14basic_ofstreamIcSt11char_traitsIcEEC1EPKcSt13_Ios_Openmode@PLT
.Ltmp0:                                 # EH_LABEL
	leaq	.L.str.9(%rip), %rsi
	movl	$96, %edx
	movq	%rbx, %rdi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp1:                                 # EH_LABEL
# %bb.16:
	xorl	%r15d, %r15d
	.p2align	4
.LBB0_17:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_18 Depth 2
                                        #       Child Loop BB0_24 Depth 3
                                        #       Child Loop BB0_27 Depth 3
                                        #         Child Loop BB0_28 Depth 4
                                        #           Child Loop BB0_29 Depth 5
                                        #       Child Loop BB0_42 Depth 3
                                        #       Child Loop BB0_46 Depth 3
                                        #         Child Loop BB0_47 Depth 4
                                        #       Child Loop BB0_84 Depth 3
                                        #       Child Loop BB0_109 Depth 3
                                        #         Child Loop BB0_114 Depth 4
                                        #       Child Loop BB0_122 Depth 3
                                        #         Child Loop BB0_127 Depth 4
                                        #       Child Loop BB0_139 Depth 3
                                        #         Child Loop BB0_141 Depth 4
	movq	%r15, 440(%rsp)                 # 8-byte Spill
	leaq	.L__const.main.cases(%rip), %rcx
	movslq	16(%r15,%rcx), %r8
	testq	%r8, %r8
	setle	%al
	movl	8(%r15,%rcx), %r9d
	movl	12(%r15,%rcx), %r10d
	testq	%r10, %r10
	sete	%sil
	movzbl	20(%r15,%rcx), %ecx
	leal	255(%r9), %edi
	leal	31(%r9), %edx
	testl	%r9d, %r9d
	movl	%r9d, %r11d
	cmovsl	%edi, %r11d
	movl	%r9d, %ebx
	cmovsl	%edx, %ebx
	sarl	$8, %r11d
	movl	%r11d, 232(%rsp)                # 4-byte Spill
	movslq	%r11d, %r14
	movq	%r14, %r11
	shlq	$6, %r11
	leaq	(%r11,%r14,2), %r11
	movslq	%r10d, %r15
	movq	%r11, 496(%rsp)                 # 8-byte Spill
	imulq	%r15, %r11
	movq	%r11, %r12
	shlq	%cl, %r12
	cmpl	$511, %edi                      # imm = 0x1FF
	setb	%dil
	orb	%sil, %dil
	movb	%dil, 51(%rsp)                  # 1-byte Spill
	cmpq	$1, %r14
	adcq	$0, %r14
	movq	%r14, 504(%rsp)                 # 8-byte Spill
	sarl	$5, %ebx
	movl	%ebx, 228(%rsp)                 # 4-byte Spill
	movslq	%ebx, %rdi
	leaq	(,%rdi,4), %rsi
	leaq	(%rsi,%rsi,8), %rsi
	movq	%rsi, 464(%rsp)                 # 8-byte Spill
	imulq	%r8, %rsi
	cmpl	$63, %edx
	setb	%dl
	orb	%al, %dl
	movb	%dl, 50(%rsp)                   # 1-byte Spill
	cmpq	$1, %rdi
	adcq	$0, %rdi
	movq	%rdi, 472(%rsp)                 # 8-byte Spill
	movq	%r15, 488(%rsp)                 # 8-byte Spill
	movq	%r8, 208(%rsp)                  # 8-byte Spill
	imulq	%r8, %r15
	shlq	$2, %r15
	movq	%r10, 240(%rsp)                 # 8-byte Spill
	movabsq	$4294967296, %rax               # imm = 0x100000000
	orq	%rax, %r10
	movq	%r10, 120(%rsp)                 # 8-byte Spill
	testl	%ecx, %ecx
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rax
	cmovneq	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rax
	movq	%rax, 400(%rsp)                 # 8-byte Spill
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rax
	cmovneq	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rax
	movq	%rax, 392(%rsp)                 # 8-byte Spill
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rax
	cmovneq	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rax
	movq	%rax, 448(%rsp)                 # 8-byte Spill
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rax
	cmovneq	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rax
	movq	%rax, 384(%rsp)                 # 8-byte Spill
	movq	%r11, 288(%rsp)                 # 8-byte Spill
	cvtsi2sd	%r11, %xmm0
	movq	%rcx, 432(%rsp)                 # 8-byte Spill
	leaq	1(%rcx), %rax
	movq	%rax, 480(%rsp)                 # 8-byte Spill
	cvtsi2sd	%eax, %xmm3
	mulsd	%xmm0, %xmm3
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rsi, %xmm0
	addsd	%xmm3, %xmm0
	movq	%r15, 456(%rsp)                 # 8-byte Spill
	movq	%r15, %xmm1
	punpckldq	.LCPI0_0(%rip), %xmm1   # xmm1 = xmm1[0],mem[0],xmm1[1],mem[1]
	subpd	.LCPI0_1(%rip), %xmm1
	movapd	%xmm1, %xmm2
	unpckhpd	%xmm1, %xmm2                    # xmm2 = xmm2[1],xmm1[1]
	addsd	%xmm1, %xmm2
	addsd	%xmm0, %xmm2
	unpcklpd	%xmm2, %xmm3                    # xmm3 = xmm3[0],xmm2[0]
	movapd	%xmm3, 512(%rsp)                # 16-byte Spill
	leaq	-1(%r12), %rax
	movq	%rax, 416(%rsp)                 # 8-byte Spill
	movq	%r9, 248(%rsp)                  # 8-byte Spill
	leal	60(%r9), %eax
	movl	%eax, 236(%rsp)                 # 4-byte Spill
	movq	%rsi, 256(%rsp)                 # 8-byte Spill
	leaq	-1(%rsi), %rax
	movq	%rax, 408(%rsp)                 # 8-byte Spill
	movl	$0, 52(%rsp)                    # 4-byte Folded Spill
	movq	%r12, 424(%rsp)                 # 8-byte Spill
	.p2align	4
.LBB0_18:                               #   Parent Loop BB0_17 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_24 Depth 3
                                        #       Child Loop BB0_27 Depth 3
                                        #         Child Loop BB0_28 Depth 4
                                        #           Child Loop BB0_29 Depth 5
                                        #       Child Loop BB0_42 Depth 3
                                        #       Child Loop BB0_46 Depth 3
                                        #         Child Loop BB0_47 Depth 4
                                        #       Child Loop BB0_84 Depth 3
                                        #       Child Loop BB0_109 Depth 3
                                        #         Child Loop BB0_114 Depth 4
                                        #       Child Loop BB0_122 Depth 3
                                        #         Child Loop BB0_127 Depth 4
                                        #       Child Loop BB0_139 Depth 3
                                        #         Child Loop BB0_141 Depth 4
	cmpq	$0, 288(%rsp)                   # 8-byte Folded Reload
	js	.LBB0_196
# %bb.19:                               #   in Loop: Header=BB0_18 Depth=2
	je	.LBB0_22
# %bb.20:                               #   in Loop: Header=BB0_18 Depth=2
.Ltmp3:                                 # EH_LABEL
	movq	%r12, %rdi
	callq	_Znwm@PLT
.Ltmp4:                                 # EH_LABEL
# %bb.21:                               #   in Loop: Header=BB0_18 Depth=2
	movq	%rax, %r14
	leaq	(%rax,%r12), %r15
	movb	$0, (%rax)
	movq	%rax, %rdi
	incq	%rdi
	xorl	%esi, %esi
	movq	416(%rsp), %rdx                 # 8-byte Reload
	callq	memset@PLT
	movl	236(%rsp), %edi                 # 4-byte Reload
	callq	srand@PLT
	subq	%r14, %r15
	jne	.LBB0_23
	jmp	.LBB0_25
	.p2align	4
.LBB0_22:                               #   in Loop: Header=BB0_18 Depth=2
	xorl	%r15d, %r15d
	xorl	%r14d, %r14d
	movl	236(%rsp), %edi                 # 4-byte Reload
	callq	srand@PLT
	subq	%r14, %r15
	je	.LBB0_25
.LBB0_23:                               #   in Loop: Header=BB0_18 Depth=2
	xorl	%ebx, %ebx
	.p2align	4
.LBB0_24:                               #   Parent Loop BB0_17 Depth=1
                                        #     Parent Loop BB0_18 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	callq	rand@PLT
	movb	%al, (%r14,%rbx)
	incq	%rbx
	cmpq	%rbx, %r15
	jne	.LBB0_24
.LBB0_25:                               #   in Loop: Header=BB0_18 Depth=2
	movq	%r15, 32(%rsp)                  # 8-byte Spill
	movq	%r14, 72(%rsp)                  # 8-byte Spill
	cmpb	$0, 51(%rsp)                    # 1-byte Folded Reload
	jne	.LBB0_32
# %bb.26:                               #   in Loop: Header=BB0_18 Depth=2
	movq	72(%rsp), %rax                  # 8-byte Reload
	leaq	64(%rax), %r15
	xorl	%r12d, %r12d
	.p2align	4
.LBB0_27:                               #   Parent Loop BB0_17 Depth=1
                                        #     Parent Loop BB0_18 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_28 Depth 4
                                        #           Child Loop BB0_29 Depth 5
	movq	%r15, %rbx
	xorl	%ebp, %ebp
	.p2align	4
.LBB0_28:                               #   Parent Loop BB0_17 Depth=1
                                        #     Parent Loop BB0_18 Depth=2
                                        #       Parent Loop BB0_27 Depth=3
                                        # =>      This Loop Header: Depth=4
                                        #           Child Loop BB0_29 Depth 5
	movq	%rbx, %r13
	movq	504(%rsp), %r14                 # 8-byte Reload
	.p2align	4
.LBB0_29:                               #   Parent Loop BB0_17 Depth=1
                                        #     Parent Loop BB0_18 Depth=2
                                        #       Parent Loop BB0_27 Depth=3
                                        #         Parent Loop BB0_28 Depth=4
                                        # =>        This Inner Loop Header: Depth=5
	callq	rand@PLT
                                        # kill: def $eax killed $eax def $rax
	leal	511(%rax), %ecx
	testl	%eax, %eax
	cmovnsl	%eax, %ecx
	andl	$65024, %ecx                    # imm = 0xFE00
	negl	%ecx
	addl	%ecx, %eax
	addl	$14336, %eax                    # imm = 0x3800
	movw	%ax, (%r13)
	addq	$66, %r13
	decq	%r14
	jne	.LBB0_29
# %bb.30:                               #   in Loop: Header=BB0_28 Depth=4
	incq	%rbp
	addq	496(%rsp), %rbx                 # 8-byte Folded Reload
	cmpq	488(%rsp), %rbp                 # 8-byte Folded Reload
	jne	.LBB0_28
# %bb.31:                               #   in Loop: Header=BB0_27 Depth=3
	incq	%r12
	addq	288(%rsp), %r15                 # 8-byte Folded Reload
	cmpq	480(%rsp), %r12                 # 8-byte Folded Reload
	jne	.LBB0_27
.LBB0_32:                               #   in Loop: Header=BB0_18 Depth=2
.Ltmp6:                                 # EH_LABEL
	leaq	96(%rsp), %rdi
	movq	32(%rsp), %r14                  # 8-byte Reload
	movq	%r14, %rsi
	callq	hipMalloc@PLT
.Ltmp7:                                 # EH_LABEL
# %bb.33:                               #   in Loop: Header=BB0_18 Depth=2
	testl	%eax, %eax
	movq	72(%rsp), %rsi                  # 8-byte Reload
	movq	256(%rsp), %r12                 # 8-byte Reload
	jne	.LBB0_200
# %bb.34:                               #   in Loop: Header=BB0_18 Depth=2
	movq	96(%rsp), %rdi
.Ltmp12:                                # EH_LABEL
	movq	%r14, %rdx
	movl	$1, %ecx
	callq	hipMemcpy@PLT
.Ltmp13:                                # EH_LABEL
# %bb.35:                               #   in Loop: Header=BB0_18 Depth=2
	testl	%eax, %eax
	jne	.LBB0_188
# %bb.36:                               #   in Loop: Header=BB0_18 Depth=2
.Ltmp18:                                # EH_LABEL
	leaq	88(%rsp), %rdi
	movq	%r12, %rsi
	callq	hipMalloc@PLT
.Ltmp19:                                # EH_LABEL
# %bb.37:                               #   in Loop: Header=BB0_18 Depth=2
	testl	%eax, %eax
	jne	.LBB0_190
# %bb.38:                               #   in Loop: Header=BB0_18 Depth=2
	testq	%r12, %r12
	js	.LBB0_198
# %bb.39:                               #   in Loop: Header=BB0_18 Depth=2
	je	.LBB0_44
# %bb.40:                               #   in Loop: Header=BB0_18 Depth=2
.Ltmp24:                                # EH_LABEL
	movq	%r12, %rdi
	callq	_Znwm@PLT
.Ltmp25:                                # EH_LABEL
# %bb.41:                               #   in Loop: Header=BB0_18 Depth=2
	movq	%rax, %r13
	movb	$0, (%rax)
	leaq	1(%rax), %rdi
	xorl	%esi, %esi
	movq	408(%rsp), %rdx                 # 8-byte Reload
	callq	memset@PLT
	xorl	%ebx, %ebx
	.p2align	4
.LBB0_42:                               #   Parent Loop BB0_17 Depth=1
                                        #     Parent Loop BB0_18 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	callq	rand@PLT
	movb	%al, (%r13,%rbx)
	incq	%rbx
	cmpq	%rbx, %r12
	jne	.LBB0_42
# %bb.43:                               #   in Loop: Header=BB0_18 Depth=2
	movq	%r13, 40(%rsp)                  # 8-byte Spill
	addq	%r12, %r13
	movq	%r13, 200(%rsp)                 # 8-byte Spill
	cmpb	$0, 50(%rsp)                    # 1-byte Folded Reload
	je	.LBB0_45
	jmp	.LBB0_49
	.p2align	4
.LBB0_44:                               #   in Loop: Header=BB0_18 Depth=2
	movq	$0, 40(%rsp)                    # 8-byte Folded Spill
	movq	$0, 200(%rsp)                   # 8-byte Folded Spill
	cmpb	$0, 50(%rsp)                    # 1-byte Folded Reload
	jne	.LBB0_49
.LBB0_45:                               #   in Loop: Header=BB0_18 Depth=2
	movq	40(%rsp), %rax                  # 8-byte Reload
	leaq	2(%rax), %rbx
	xorl	%r12d, %r12d
	.p2align	4
.LBB0_46:                               #   Parent Loop BB0_17 Depth=1
                                        #     Parent Loop BB0_18 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_47 Depth 4
	movq	%rbx, %r13
	movq	472(%rsp), %rbp                 # 8-byte Reload
	.p2align	4
.LBB0_47:                               #   Parent Loop BB0_17 Depth=1
                                        #     Parent Loop BB0_18 Depth=2
                                        #       Parent Loop BB0_46 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	callq	rand@PLT
                                        # kill: def $eax killed $eax def $rax
	leal	255(%rax), %ecx
	testl	%eax, %eax
	cmovnsl	%eax, %ecx
	andl	$65280, %ecx                    # imm = 0xFF00
	negl	%ecx
	leal	(%rax,%rcx), %r14d
	addl	$14336, %r14d                   # imm = 0x3800
	callq	rand@PLT
                                        # kill: def $eax killed $eax def $rax
	leal	255(%rax), %ecx
	testl	%eax, %eax
	cmovnsl	%eax, %ecx
	andl	$65280, %ecx                    # imm = 0xFF00
	negl	%ecx
	addl	%ecx, %eax
	addl	$14336, %eax                    # imm = 0x3800
	movw	%r14w, -2(%r13)
	movw	%ax, (%r13)
	addq	$36, %r13
	decq	%rbp
	jne	.LBB0_47
# %bb.48:                               #   in Loop: Header=BB0_46 Depth=3
	incq	%r12
	addq	464(%rsp), %rbx                 # 8-byte Folded Reload
	cmpq	208(%rsp), %r12                 # 8-byte Folded Reload
	jne	.LBB0_46
.LBB0_49:                               #   in Loop: Header=BB0_18 Depth=2
	movq	88(%rsp), %rdi
.Ltmp27:                                # EH_LABEL
	movq	40(%rsp), %r12                  # 8-byte Reload
	movq	%r12, %rsi
	movq	256(%rsp), %rdx                 # 8-byte Reload
	movl	$1, %ecx
	callq	hipMemcpy@PLT
.Ltmp28:                                # EH_LABEL
# %bb.50:                               #   in Loop: Header=BB0_18 Depth=2
	testl	%eax, %eax
	leaq	128(%rsp), %rbx
	jne	.LBB0_194
# %bb.51:                               #   in Loop: Header=BB0_18 Depth=2
.Ltmp33:                                # EH_LABEL
	leaq	112(%rsp), %rdi
	movq	456(%rsp), %rsi                 # 8-byte Reload
	callq	hipMalloc@PLT
.Ltmp34:                                # EH_LABEL
# %bb.52:                               #   in Loop: Header=BB0_18 Depth=2
	testl	%eax, %eax
	movq	32(%rsp), %r14                  # 8-byte Reload
	jne	.LBB0_192
# %bb.53:                               #   in Loop: Header=BB0_18 Depth=2
	cmpl	$3, 52(%rsp)                    # 4-byte Folded Reload
	ja	.LBB0_211
# %bb.54:                               #   in Loop: Header=BB0_18 Depth=2
	movl	52(%rsp), %eax                  # 4-byte Reload
	leaq	.LJTI0_0(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	movq	448(%rsp), %rsi                 # 8-byte Reload
	jmpq	*%rax
.LBB0_55:                               #   in Loop: Header=BB0_18 Depth=2
	movq	208(%rsp), %rax                 # 8-byte Reload
	decl	%eax
	cmpl	$7, %eax
	ja	.LBB0_211
# %bb.56:                               #   in Loop: Header=BB0_18 Depth=2
	leaq	.LJTI0_1(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	movq	_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rsi
	jmpq	*%rax
.LBB0_57:                               #   in Loop: Header=BB0_18 Depth=2
	movq	384(%rsp), %rsi                 # 8-byte Reload
	jmp	.LBB0_60
	.p2align	4
.LBB0_58:                               #   in Loop: Header=BB0_18 Depth=2
	movq	392(%rsp), %rsi                 # 8-byte Reload
	jmp	.LBB0_60
	.p2align	4
.LBB0_59:                               #   in Loop: Header=BB0_18 Depth=2
	movq	400(%rsp), %rsi                 # 8-byte Reload
.LBB0_60:                               #   in Loop: Header=BB0_18 Depth=2
	xorpd	%xmm0, %xmm0
	movapd	%xmm0, 352(%rsp)
	movapd	%xmm0, 336(%rsp)
	movapd	%xmm0, 320(%rsp)
	movapd	%xmm0, 304(%rsp)
	movq	$0, 368(%rsp)
.Ltmp39:                                # EH_LABEL
	leaq	372(%rsp), %rdi
	movq	%rsi, %rbp
	movl	$32, %edx
	xorl	%ecx, %ecx
	callq	hipOccupancyMaxActiveBlocksPerMultiprocessor@PLT
.Ltmp40:                                # EH_LABEL
# %bb.61:                               #   in Loop: Header=BB0_18 Depth=2
	testl	%eax, %eax
	jne	.LBB0_186
# %bb.62:                               #   in Loop: Header=BB0_18 Depth=2
.Ltmp45:                                # EH_LABEL
	leaq	528(%rsp), %rdi
	movq	%rbp, %rsi
	callq	hipFuncGetAttributes@PLT
.Ltmp46:                                # EH_LABEL
# %bb.63:                               #   in Loop: Header=BB0_18 Depth=2
	testl	%eax, %eax
	jne	.LBB0_202
# %bb.64:                               #   in Loop: Header=BB0_18 Depth=2
	movl	560(%rsp), %eax
	movl	%eax, 368(%rsp)
	movq	$32, 360(%rsp)
	movq	248(%rsp), %rax                 # 8-byte Reload
	movl	%eax, 68(%rsp)
	movl	232(%rsp), %eax                 # 4-byte Reload
	movl	%eax, 64(%rsp)
	movl	228(%rsp), %eax                 # 4-byte Reload
	movl	%eax, 60(%rsp)
	movq	240(%rsp), %rax                 # 8-byte Reload
	movl	%eax, 56(%rsp)
	leaq	96(%rsp), %rax
	movq	%rax, 128(%rsp)
	movq	%rax, 136(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	112(%rsp), %rax
	movq	%rax, 152(%rsp)
	leaq	68(%rsp), %rax
	movq	%rax, 160(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 168(%rsp)
	leaq	60(%rsp), %rax
	movq	%rax, 176(%rsp)
	leaq	56(%rsp), %rax
	movq	%rax, 184(%rsp)
.Ltmp51:                                # EH_LABEL
	xorpd	%xmm0, %xmm0
	movupd	%xmm0, (%rsp)
	movq	%rbp, %rdi
	movq	120(%rsp), %rsi                 # 8-byte Reload
	movl	$1, %edx
	movabsq	$4294967328, %rcx               # imm = 0x100000020
	movl	$1, %r8d
	movq	%rbx, %r9
	callq	hipLaunchKernel@PLT
.Ltmp52:                                # EH_LABEL
# %bb.65:                               #   in Loop: Header=BB0_18 Depth=2
	testl	%eax, %eax
	jne	.LBB0_185
# %bb.66:                               #   in Loop: Header=BB0_18 Depth=2
	leaq	96(%rsp), %rax
	movq	%rax, 128(%rsp)
	movq	%rax, 136(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	112(%rsp), %rax
	movq	%rax, 152(%rsp)
	leaq	68(%rsp), %rax
	movq	%rax, 160(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 168(%rsp)
	leaq	60(%rsp), %rax
	movq	%rax, 176(%rsp)
	leaq	56(%rsp), %rax
	movq	%rax, 184(%rsp)
.Ltmp53:                                # EH_LABEL
	xorpd	%xmm0, %xmm0
	movupd	%xmm0, (%rsp)
	movq	%rbp, %rdi
	movq	120(%rsp), %rsi                 # 8-byte Reload
	movl	$1, %edx
	movabsq	$4294967328, %rcx               # imm = 0x100000020
	movl	$1, %r8d
	movq	%rbx, %r9
	callq	hipLaunchKernel@PLT
.Ltmp54:                                # EH_LABEL
# %bb.67:                               #   in Loop: Header=BB0_18 Depth=2
	testl	%eax, %eax
	jne	.LBB0_185
# %bb.68:                               #   in Loop: Header=BB0_18 Depth=2
	leaq	96(%rsp), %rax
	movq	%rax, 128(%rsp)
	movq	%rax, 136(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	112(%rsp), %rax
	movq	%rax, 152(%rsp)
	leaq	68(%rsp), %rax
	movq	%rax, 160(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 168(%rsp)
	leaq	60(%rsp), %rax
	movq	%rax, 176(%rsp)
	leaq	56(%rsp), %rax
	movq	%rax, 184(%rsp)
.Ltmp55:                                # EH_LABEL
	xorpd	%xmm0, %xmm0
	movupd	%xmm0, (%rsp)
	movq	%rbp, %rdi
	movq	120(%rsp), %rsi                 # 8-byte Reload
	movl	$1, %edx
	movabsq	$4294967328, %rcx               # imm = 0x100000020
	movl	$1, %r8d
	movq	%rbx, %r9
	callq	hipLaunchKernel@PLT
.Ltmp56:                                # EH_LABEL
# %bb.69:                               #   in Loop: Header=BB0_18 Depth=2
	testl	%eax, %eax
	jne	.LBB0_185
# %bb.70:                               #   in Loop: Header=BB0_18 Depth=2
	leaq	96(%rsp), %rax
	movq	%rax, 128(%rsp)
	movq	%rax, 136(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	112(%rsp), %rax
	movq	%rax, 152(%rsp)
	leaq	68(%rsp), %rax
	movq	%rax, 160(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 168(%rsp)
	leaq	60(%rsp), %rax
	movq	%rax, 176(%rsp)
	leaq	56(%rsp), %rax
	movq	%rax, 184(%rsp)
.Ltmp57:                                # EH_LABEL
	xorpd	%xmm0, %xmm0
	movupd	%xmm0, (%rsp)
	movq	%rbp, %rdi
	movq	120(%rsp), %rsi                 # 8-byte Reload
	movl	$1, %edx
	movabsq	$4294967328, %rcx               # imm = 0x100000020
	movl	$1, %r8d
	movq	%rbx, %r9
	callq	hipLaunchKernel@PLT
.Ltmp58:                                # EH_LABEL
# %bb.71:                               #   in Loop: Header=BB0_18 Depth=2
	testl	%eax, %eax
	jne	.LBB0_185
# %bb.72:                               #   in Loop: Header=BB0_18 Depth=2
	leaq	96(%rsp), %rax
	movq	%rax, 128(%rsp)
	movq	%rax, 136(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	112(%rsp), %rax
	movq	%rax, 152(%rsp)
	leaq	68(%rsp), %rax
	movq	%rax, 160(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 168(%rsp)
	leaq	60(%rsp), %rax
	movq	%rax, 176(%rsp)
	leaq	56(%rsp), %rax
	movq	%rax, 184(%rsp)
.Ltmp59:                                # EH_LABEL
	xorpd	%xmm0, %xmm0
	movupd	%xmm0, (%rsp)
	movq	%rbp, %rdi
	movq	120(%rsp), %rsi                 # 8-byte Reload
	movl	$1, %edx
	movabsq	$4294967328, %rcx               # imm = 0x100000020
	movl	$1, %r8d
	movq	%rbx, %r9
	callq	hipLaunchKernel@PLT
.Ltmp60:                                # EH_LABEL
# %bb.73:                               #   in Loop: Header=BB0_18 Depth=2
	testl	%eax, %eax
	jne	.LBB0_185
# %bb.74:                               #   in Loop: Header=BB0_18 Depth=2
.Ltmp65:                                # EH_LABEL
	callq	hipDeviceSynchronize@PLT
.Ltmp66:                                # EH_LABEL
# %bb.75:                               #   in Loop: Header=BB0_18 Depth=2
	testl	%eax, %eax
	jne	.LBB0_209
# %bb.76:                               #   in Loop: Header=BB0_18 Depth=2
.Ltmp71:                                # EH_LABEL
	callq	hipGetLastError@PLT
.Ltmp72:                                # EH_LABEL
# %bb.77:                               #   in Loop: Header=BB0_18 Depth=2
	testl	%eax, %eax
	jne	.LBB0_207
# %bb.78:                               #   in Loop: Header=BB0_18 Depth=2
.Ltmp77:                                # EH_LABEL
	leaq	296(%rsp), %rdi
	callq	hipEventCreate@PLT
.Ltmp78:                                # EH_LABEL
# %bb.79:                               #   in Loop: Header=BB0_18 Depth=2
	testl	%eax, %eax
	jne	.LBB0_205
# %bb.80:                               #   in Loop: Header=BB0_18 Depth=2
.Ltmp83:                                # EH_LABEL
	leaq	216(%rsp), %rdi
	callq	hipEventCreate@PLT
.Ltmp84:                                # EH_LABEL
# %bb.81:                               #   in Loop: Header=BB0_18 Depth=2
	testl	%eax, %eax
	jne	.LBB0_204
# %bb.82:                               #   in Loop: Header=BB0_18 Depth=2
	movl	$100, %r13d
	movq	$0, 80(%rsp)                    # 8-byte Folded Spill
	xorl	%r12d, %r12d
	movq	$0, 24(%rsp)                    # 8-byte Folded Spill
	movq	%rbp, %r14
	jmp	.LBB0_84
	.p2align	4
.LBB0_83:                               #   in Loop: Header=BB0_84 Depth=3
	movsd	%xmm0, (%r12)
	movq	%r12, %rbp
	leaq	8(%rbp), %r12
	decl	%r13d
	je	.LBB0_102
.LBB0_84:                               #   Parent Loop BB0_17 Depth=1
                                        #     Parent Loop BB0_18 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	296(%rsp), %rdi
.Ltmp89:                                # EH_LABEL
	xorl	%esi, %esi
	callq	hipEventRecord@PLT
.Ltmp90:                                # EH_LABEL
# %bb.85:                               #   in Loop: Header=BB0_84 Depth=3
	testl	%eax, %eax
	jne	.LBB0_181
# %bb.86:                               #   in Loop: Header=BB0_84 Depth=3
	leaq	96(%rsp), %rax
	movq	%rax, 128(%rsp)
	movq	%rax, 136(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	112(%rsp), %rax
	movq	%rax, 152(%rsp)
	leaq	68(%rsp), %rax
	movq	%rax, 160(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 168(%rsp)
	leaq	60(%rsp), %rax
	movq	%rax, 176(%rsp)
	leaq	56(%rsp), %rax
	movq	%rax, 184(%rsp)
.Ltmp95:                                # EH_LABEL
	xorpd	%xmm0, %xmm0
	movupd	%xmm0, (%rsp)
	movq	%r14, %rdi
	movq	120(%rsp), %rsi                 # 8-byte Reload
	movl	$1, %edx
	movabsq	$4294967328, %rcx               # imm = 0x100000020
	movl	$1, %r8d
	leaq	128(%rsp), %rbx
	movq	%rbx, %r9
	callq	hipLaunchKernel@PLT
.Ltmp96:                                # EH_LABEL
# %bb.87:                               #   in Loop: Header=BB0_84 Depth=3
	testl	%eax, %eax
	jne	.LBB0_173
# %bb.88:                               #   in Loop: Header=BB0_84 Depth=3
	movq	216(%rsp), %rdi
.Ltmp101:                               # EH_LABEL
	xorl	%esi, %esi
	movq	80(%rsp), %rbp                  # 8-byte Reload
	callq	hipEventRecord@PLT
.Ltmp102:                               # EH_LABEL
# %bb.89:                               #   in Loop: Header=BB0_84 Depth=3
	testl	%eax, %eax
	jne	.LBB0_175
# %bb.90:                               #   in Loop: Header=BB0_84 Depth=3
	movq	216(%rsp), %rdi
.Ltmp107:                               # EH_LABEL
	callq	hipEventSynchronize@PLT
.Ltmp108:                               # EH_LABEL
# %bb.91:                               #   in Loop: Header=BB0_84 Depth=3
	testl	%eax, %eax
	jne	.LBB0_179
# %bb.92:                               #   in Loop: Header=BB0_84 Depth=3
	movq	296(%rsp), %rsi
	movq	216(%rsp), %rdx
.Ltmp113:                               # EH_LABEL
	movq	%rbx, %rdi
	callq	hipEventElapsedTime@PLT
.Ltmp114:                               # EH_LABEL
# %bb.93:                               #   in Loop: Header=BB0_84 Depth=3
	testl	%eax, %eax
	jne	.LBB0_177
# %bb.94:                               #   in Loop: Header=BB0_84 Depth=3
	movss	128(%rsp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	%xmm0, %xmm0
	cmpq	%rbp, %r12
	jne	.LBB0_83
# %bb.95:                               #   in Loop: Header=BB0_84 Depth=3
	subq	24(%rsp), %rbp                  # 8-byte Folded Reload
	movabsq	$9223372036854775800, %rax      # imm = 0x7FFFFFFFFFFFFFF8
	cmpq	%rax, %rbp
	je	.LBB0_183
# %bb.96:                               #   in Loop: Header=BB0_84 Depth=3
	movsd	%xmm0, 104(%rsp)                # 8-byte Spill
	movq	%rbp, %r12
	sarq	$3, %r12
	cmpq	$1, %r12
	adcq	%r12, %r12
	movabsq	$1152921504606846975, %rax      # imm = 0xFFFFFFFFFFFFFFF
	cmpq	%rax, %r12
	cmovaeq	%rax, %r12
	leaq	(,%r12,8), %rdi
.Ltmp119:                               # EH_LABEL
	callq	_Znwm@PLT
.Ltmp120:                               # EH_LABEL
# %bb.97:                               #   in Loop: Header=BB0_84 Depth=3
	movq	%rax, %rbx
	movsd	104(%rsp), %xmm0                # 8-byte Reload
                                        # xmm0 = mem[0],zero
	movsd	%xmm0, (%rax,%rbp)
	testq	%rbp, %rbp
	movq	24(%rsp), %r15                  # 8-byte Reload
	jle	.LBB0_99
# %bb.98:                               #   in Loop: Header=BB0_84 Depth=3
	movq	%rbx, %rdi
	movq	%r15, %rsi
	movq	%rbp, %rdx
	callq	memcpy@PLT
.LBB0_99:                               #   in Loop: Header=BB0_84 Depth=3
	testq	%r15, %r15
	je	.LBB0_101
# %bb.100:                              #   in Loop: Header=BB0_84 Depth=3
	movq	%r15, %rdi
	movq	%rbp, %rsi
	callq	_ZdlPvm@PLT
.LBB0_101:                              #   in Loop: Header=BB0_84 Depth=3
	addq	%rbx, %rbp
	leaq	(%rbx,%r12,8), %rax
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rbx, 24(%rsp)                  # 8-byte Spill
	leaq	8(%rbp), %r12
	decl	%r13d
	jne	.LBB0_84
.LBB0_102:                              #   in Loop: Header=BB0_18 Depth=2
	movq	%r12, %rcx
	movq	24(%rsp), %rax                  # 8-byte Reload
	subq	%rax, %rcx
	sarq	$3, %rcx
	movq	%rcx, 272(%rsp)                 # 8-byte Spill
	movq	%r12, %rcx
	subq	%rax, %rcx
	movq	%rcx, 264(%rsp)                 # 8-byte Spill
	je	.LBB0_129
# %bb.103:                              #   in Loop: Header=BB0_18 Depth=2
	bsrq	272(%rsp), %rdx                 # 8-byte Folded Reload
	xorl	$63, %edx
	addl	%edx, %edx
	xorq	$126, %rdx
.Ltmp122:                               # EH_LABEL
	movq	24(%rsp), %r13                  # 8-byte Reload
	movq	%r13, %rdi
	movq	%r12, %rsi
	callq	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElSt4lessIvEEvT_S9_T0_T1_
.Ltmp123:                               # EH_LABEL
# %bb.104:                              #   in Loop: Header=BB0_18 Depth=2
	cmpq	$129, 264(%rsp)                 # 8-byte Folded Reload
	jl	.LBB0_106
# %bb.105:                              #   in Loop: Header=BB0_18 Depth=2
	leaq	8(%r13), %rbx
	movq	%r13, %r15
	movl	$8, %r13d
	movq	%rbx, 280(%rsp)                 # 8-byte Spill
	jmp	.LBB0_122
	.p2align	4
.LBB0_106:                              #   in Loop: Header=BB0_18 Depth=2
	cmpq	%rbp, %r13
	je	.LBB0_129
# %bb.107:                              #   in Loop: Header=BB0_18 Depth=2
	movq	24(%rsp), %r13                  # 8-byte Reload
	leaq	8(%r13), %r12
	jmp	.LBB0_109
	.p2align	4
.LBB0_108:                              #   in Loop: Header=BB0_109 Depth=3
	movsd	%xmm1, (%rbx)
	addq	$8, %r12
	cmpq	%rbp, %r13
	je	.LBB0_129
.LBB0_109:                              #   Parent Loop BB0_17 Depth=1
                                        #     Parent Loop BB0_18 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_114 Depth 4
	movq	%r13, %rdi
	addq	$8, %r13
	movsd	8(%rdi), %xmm1                  # xmm1 = mem[0],zero
	movq	24(%rsp), %rbx                  # 8-byte Reload
	movsd	(%rbx), %xmm0                   # xmm0 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jbe	.LBB0_112
# %bb.110:                              #   in Loop: Header=BB0_109 Depth=3
	movsd	%xmm1, 104(%rsp)                # 8-byte Spill
	movq	%r13, %rdx
	subq	%rbx, %rdx
	subq	%rdx, %rdi
	movq	%rdx, %rax
	sarq	$3, %rax
	addq	$16, %rdi
	cmpq	$2, %rax
	jl	.LBB0_115
# %bb.111:                              #   in Loop: Header=BB0_109 Depth=3
	movq	%rbx, %rsi
	callq	memmove@PLT
	movsd	104(%rsp), %xmm1                # 8-byte Reload
                                        # xmm1 = mem[0],zero
	jmp	.LBB0_108
	.p2align	4
.LBB0_112:                              #   in Loop: Header=BB0_109 Depth=3
	movsd	(%rdi), %xmm0                   # xmm0 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	movq	%r13, %rbx
	jbe	.LBB0_108
# %bb.113:                              #   in Loop: Header=BB0_109 Depth=3
	movq	%r12, %rbx
	.p2align	4
.LBB0_114:                              #   Parent Loop BB0_17 Depth=1
                                        #     Parent Loop BB0_18 Depth=2
                                        #       Parent Loop BB0_109 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movsd	%xmm0, (%rbx)
	movsd	-16(%rbx), %xmm0                # xmm0 = mem[0],zero
	addq	$-8, %rbx
	ucomisd	%xmm1, %xmm0
	ja	.LBB0_114
	jmp	.LBB0_108
.LBB0_115:                              #   in Loop: Header=BB0_109 Depth=3
	cmpq	$8, %rdx
	movsd	104(%rsp), %xmm1                # 8-byte Reload
                                        # xmm1 = mem[0],zero
	jne	.LBB0_108
# %bb.116:                              #   in Loop: Header=BB0_109 Depth=3
	movsd	%xmm0, (%rdi)
	movq	24(%rsp), %rbx                  # 8-byte Reload
	jmp	.LBB0_108
.LBB0_117:                              #   in Loop: Header=BB0_18 Depth=2
	movq	_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rsi
	jmp	.LBB0_60
.LBB0_118:                              #   in Loop: Header=BB0_18 Depth=2
	movq	_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rsi
	jmp	.LBB0_60
.LBB0_119:                              #   in Loop: Header=BB0_122 Depth=3
	movq	280(%rsp), %rax                 # 8-byte Reload
	movsd	%xmm0, (%rax)
	movq	24(%rsp), %r14                  # 8-byte Reload
	.p2align	4
.LBB0_120:                              #   in Loop: Header=BB0_122 Depth=3
	movsd	104(%rsp), %xmm1                # 8-byte Reload
                                        # xmm1 = mem[0],zero
.LBB0_121:                              #   in Loop: Header=BB0_122 Depth=3
	movsd	%xmm1, (%r14)
	addq	$8, %r13
	addq	$8, %rbx
	cmpq	$128, %r13
	je	.LBB0_128
.LBB0_122:                              #   Parent Loop BB0_17 Depth=1
                                        #     Parent Loop BB0_18 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_127 Depth 4
	movq	%r15, %rax
	movq	24(%rsp), %rcx                  # 8-byte Reload
	leaq	(%rcx,%r13), %r15
	movsd	(%rcx,%r13), %xmm1              # xmm1 = mem[0],zero
	movsd	(%rcx), %xmm0                   # xmm0 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jbe	.LBB0_125
# %bb.123:                              #   in Loop: Header=BB0_122 Depth=3
	movsd	%xmm1, 104(%rsp)                # 8-byte Spill
	cmpq	$9, %r13
	jb	.LBB0_119
# %bb.124:                              #   in Loop: Header=BB0_122 Depth=3
	movq	280(%rsp), %rdi                 # 8-byte Reload
	movq	24(%rsp), %r14                  # 8-byte Reload
	movq	%r14, %rsi
	movq	%r13, %rdx
	callq	memmove@PLT
	jmp	.LBB0_120
	.p2align	4
.LBB0_125:                              #   in Loop: Header=BB0_122 Depth=3
	movsd	(%rax), %xmm0                   # xmm0 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	movq	%r15, %r14
	jbe	.LBB0_121
# %bb.126:                              #   in Loop: Header=BB0_122 Depth=3
	movq	%rbx, %r14
	.p2align	4
.LBB0_127:                              #   Parent Loop BB0_17 Depth=1
                                        #     Parent Loop BB0_18 Depth=2
                                        #       Parent Loop BB0_122 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movsd	%xmm0, (%r14)
	movsd	-16(%r14), %xmm0                # xmm0 = mem[0],zero
	addq	$-8, %r14
	ucomisd	%xmm1, %xmm0
	ja	.LBB0_127
	jmp	.LBB0_121
	.p2align	4
.LBB0_128:                              #   in Loop: Header=BB0_18 Depth=2
	movq	24(%rsp), %rax                  # 8-byte Reload
	addq	$128, %rax
	cmpq	%r12, %rax
	jne	.LBB0_139
	.p2align	4
.LBB0_129:                              #   in Loop: Header=BB0_18 Depth=2
	movq	272(%rsp), %rsi                 # 8-byte Reload
	movq	%rsi, %rax
	andq	$-2, %rax
	movq	24(%rsp), %r13                  # 8-byte Reload
	movsd	(%r13,%rax,4), %xmm0            # xmm0 = mem[0],zero
	leaq	-1(%rsi), %rax
	movabsq	$-3689348814741910323, %rcx     # imm = 0xCCCCCCCCCCCCCCCD
	mulq	%rcx
	andq	$-8, %rdx
	movsd	(%r13,%rdx), %xmm1              # xmm1 = mem[0],zero
	movsd	%xmm1, 312(%rsp)
	movq	264(%rsp), %rax                 # 8-byte Reload
	addq	%rsi, %rax
	mulq	%rcx
	andq	$-8, %rdx
	movsd	(%r13,%rdx), %xmm1              # xmm1 = mem[0],zero
	movsd	%xmm1, 320(%rsp)
	movsd	(%r13), %xmm1                   # xmm1 = mem[0],zero
	movsd	%xmm1, 328(%rsp)
	movsd	(%rbp), %xmm1                   # xmm1 = mem[0],zero
	movsd	%xmm1, 336(%rsp)
	movsd	%xmm0, 304(%rsp)
	mulsd	.LCPI0_2(%rip), %xmm0
	unpcklpd	%xmm0, %xmm0                    # xmm0 = xmm0[0,0]
	movapd	512(%rsp), %xmm1                # 16-byte Reload
	divpd	%xmm0, %xmm1
	divpd	.LCPI0_3(%rip), %xmm1
	movupd	%xmm1, 344(%rsp)
	movq	96(%rsp), %rdi
.Ltmp125:                               # EH_LABEL
	callq	hipFree@PLT
.Ltmp126:                               # EH_LABEL
# %bb.130:                              #   in Loop: Header=BB0_18 Depth=2
	movq	88(%rsp), %rdi
.Ltmp127:                               # EH_LABEL
	callq	hipFree@PLT
.Ltmp128:                               # EH_LABEL
# %bb.131:                              #   in Loop: Header=BB0_18 Depth=2
	movq	112(%rsp), %rdi
.Ltmp129:                               # EH_LABEL
	callq	hipFree@PLT
.Ltmp130:                               # EH_LABEL
# %bb.132:                              #   in Loop: Header=BB0_18 Depth=2
	movq	80(%rsp), %rsi                  # 8-byte Reload
	subq	%r13, %rsi
	movq	%r13, %rdi
	callq	_ZdlPvm@PLT
	movq	40(%rsp), %rdi                  # 8-byte Reload
	testq	%rdi, %rdi
	movq	32(%rsp), %rbx                  # 8-byte Reload
	je	.LBB0_134
# %bb.133:                              #   in Loop: Header=BB0_18 Depth=2
	movq	200(%rsp), %rsi                 # 8-byte Reload
	subq	%rdi, %rsi
	callq	_ZdlPvm@PLT
.LBB0_134:                              #   in Loop: Header=BB0_18 Depth=2
	movq	72(%rsp), %rdi                  # 8-byte Reload
	testq	%rdi, %rdi
	leaq	128(%rsp), %r14
	leaq	.L.str.17(%rip), %r13
	leaq	584(%rsp), %rbp
	je	.LBB0_136
# %bb.135:                              #   in Loop: Header=BB0_18 Depth=2
	movq	%rbx, %rsi
	callq	_ZdlPvm@PLT
.LBB0_136:                              #   in Loop: Header=BB0_18 Depth=2
	movl	52(%rsp), %edx                  # 4-byte Reload
	cmpl	$2, %edx
	leaq	.L.str.16(%rip), %rcx
	leaq	.L.str.15(%rip), %rax
	cmoveq	%rax, %rcx
	cmpl	$1, %edx
	leaq	.L.str.14(%rip), %rax
	cmoveq	%rax, %rcx
	testl	%edx, %edx
	leaq	.L.str.13(%rip), %rax
	cmoveq	%rax, %rcx
	movl	$4, %esi
	movq	%r14, %rdi
	leaq	.L.str.12(%rip), %rdx
	xorl	%eax, %eax
	callq	snprintf@PLT
	leaq	.L__const.main.cases(%rip), %rax
	movq	440(%rsp), %r15                 # 8-byte Reload
	movq	(%r15,%rax), %r12
	testq	%r12, %r12
	je	.LBB0_142
# %bb.137:                              #   in Loop: Header=BB0_18 Depth=2
	movq	%r12, %rdi
	callq	strlen@PLT
.Ltmp132:                               # EH_LABEL
	movq	%rbp, %rdi
	movq	%r12, %rsi
	movq	%rax, %rdx
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp133:                               # EH_LABEL
	jmp	.LBB0_143
	.p2align	4
.LBB0_138:                              #   in Loop: Header=BB0_139 Depth=3
	movsd	%xmm0, (%rcx)
	cmpq	%rbp, %rax
	leaq	8(%rax), %rax
	je	.LBB0_129
.LBB0_139:                              #   Parent Loop BB0_17 Depth=1
                                        #     Parent Loop BB0_18 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_141 Depth 4
	movsd	-8(%rax), %xmm1                 # xmm1 = mem[0],zero
	movsd	(%rax), %xmm0                   # xmm0 = mem[0],zero
	ucomisd	%xmm0, %xmm1
	movq	%rax, %rcx
	jbe	.LBB0_138
# %bb.140:                              #   in Loop: Header=BB0_139 Depth=3
	movq	%rax, %rcx
	.p2align	4
.LBB0_141:                              #   Parent Loop BB0_17 Depth=1
                                        #     Parent Loop BB0_18 Depth=2
                                        #       Parent Loop BB0_139 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movsd	%xmm1, (%rcx)
	movsd	-16(%rcx), %xmm1                # xmm1 = mem[0],zero
	addq	$-8, %rcx
	ucomisd	%xmm0, %xmm1
	ja	.LBB0_141
	jmp	.LBB0_138
	.p2align	4
.LBB0_142:                              #   in Loop: Header=BB0_18 Depth=2
	movq	584(%rsp), %rax
	movq	-24(%rax), %rax
	leaq	(%rsp,%rax), %rdi
	addq	$584, %rdi                      # imm = 0x248
	movl	616(%rsp,%rax), %esi
	orl	$1, %esi
.Ltmp134:                               # EH_LABEL
	callq	_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate@PLT
.Ltmp135:                               # EH_LABEL
.LBB0_143:                              #   in Loop: Header=BB0_18 Depth=2
.Ltmp136:                               # EH_LABEL
	movl	$1, %edx
	movq	%rbp, %rdi
	movq	%r13, %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp137:                               # EH_LABEL
# %bb.144:                              #   in Loop: Header=BB0_18 Depth=2
	movq	%r14, %rdi
	callq	strlen@PLT
.Ltmp138:                               # EH_LABEL
	movq	%rbp, %rdi
	movq	%r14, %rsi
	movq	%rax, %rdx
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp139:                               # EH_LABEL
# %bb.145:                              #   in Loop: Header=BB0_18 Depth=2
.Ltmp140:                               # EH_LABEL
	movl	$1, %edx
	movq	%rbp, %rdi
	movq	%r13, %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp141:                               # EH_LABEL
# %bb.146:                              #   in Loop: Header=BB0_18 Depth=2
.Ltmp142:                               # EH_LABEL
	movq	%rbp, %rdi
	movq	248(%rsp), %rsi                 # 8-byte Reload
                                        # kill: def $esi killed $esi killed $rsi
	callq	_ZNSolsEi@PLT
.Ltmp143:                               # EH_LABEL
# %bb.147:                              #   in Loop: Header=BB0_18 Depth=2
.Ltmp144:                               # EH_LABEL
	movq	%rax, %rbx
	movl	$1, %edx
	movq	%rax, %rdi
	movq	%r13, %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp145:                               # EH_LABEL
# %bb.148:                              #   in Loop: Header=BB0_18 Depth=2
.Ltmp146:                               # EH_LABEL
	movq	%rbx, %rdi
	movq	240(%rsp), %rsi                 # 8-byte Reload
                                        # kill: def $esi killed $esi killed $rsi
	callq	_ZNSolsEi@PLT
.Ltmp147:                               # EH_LABEL
# %bb.149:                              #   in Loop: Header=BB0_18 Depth=2
.Ltmp148:                               # EH_LABEL
	movq	%rax, %rbx
	movl	$1, %edx
	movq	%rax, %rdi
	movq	%r13, %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp149:                               # EH_LABEL
# %bb.150:                              #   in Loop: Header=BB0_18 Depth=2
.Ltmp150:                               # EH_LABEL
	movq	%rbx, %rdi
	movq	208(%rsp), %rsi                 # 8-byte Reload
                                        # kill: def $esi killed $esi killed $rsi
	callq	_ZNSolsEi@PLT
.Ltmp151:                               # EH_LABEL
# %bb.151:                              #   in Loop: Header=BB0_18 Depth=2
.Ltmp152:                               # EH_LABEL
	movq	%rax, %rbx
	movl	$1, %edx
	movq	%rax, %rdi
	movq	%r13, %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp153:                               # EH_LABEL
# %bb.152:                              #   in Loop: Header=BB0_18 Depth=2
.Ltmp154:                               # EH_LABEL
	movq	%rbx, %rdi
	movq	432(%rsp), %rsi                 # 8-byte Reload
                                        # kill: def $esi killed $esi killed $rsi
	callq	_ZNSolsEi@PLT
.Ltmp155:                               # EH_LABEL
# %bb.153:                              #   in Loop: Header=BB0_18 Depth=2
.Ltmp156:                               # EH_LABEL
	movq	%rax, %rbx
	movl	$1, %edx
	movq	%rax, %rdi
	movq	%r13, %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp157:                               # EH_LABEL
# %bb.154:                              #   in Loop: Header=BB0_18 Depth=2
	movsd	304(%rsp), %xmm0                # xmm0 = mem[0],zero
.Ltmp158:                               # EH_LABEL
	movq	%rbx, %rdi
	callq	_ZNSo9_M_insertIdEERSoT_@PLT
.Ltmp159:                               # EH_LABEL
# %bb.155:                              #   in Loop: Header=BB0_18 Depth=2
.Ltmp160:                               # EH_LABEL
	movq	%rax, %rbx
	movl	$1, %edx
	movq	%rax, %rdi
	movq	%r13, %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp161:                               # EH_LABEL
# %bb.156:                              #   in Loop: Header=BB0_18 Depth=2
	movsd	312(%rsp), %xmm0                # xmm0 = mem[0],zero
.Ltmp162:                               # EH_LABEL
	movq	%rbx, %rdi
	callq	_ZNSo9_M_insertIdEERSoT_@PLT
.Ltmp163:                               # EH_LABEL
# %bb.157:                              #   in Loop: Header=BB0_18 Depth=2
.Ltmp164:                               # EH_LABEL
	movq	%rax, %rbx
	movl	$1, %edx
	movq	%rax, %rdi
	movq	%r13, %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp165:                               # EH_LABEL
# %bb.158:                              #   in Loop: Header=BB0_18 Depth=2
	movsd	320(%rsp), %xmm0                # xmm0 = mem[0],zero
.Ltmp166:                               # EH_LABEL
	movq	%rbx, %rdi
	callq	_ZNSo9_M_insertIdEERSoT_@PLT
.Ltmp167:                               # EH_LABEL
# %bb.159:                              #   in Loop: Header=BB0_18 Depth=2
.Ltmp168:                               # EH_LABEL
	movq	%rax, %rbx
	movl	$1, %edx
	movq	%rax, %rdi
	movq	%r13, %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp169:                               # EH_LABEL
# %bb.160:                              #   in Loop: Header=BB0_18 Depth=2
	movsd	344(%rsp), %xmm0                # xmm0 = mem[0],zero
.Ltmp170:                               # EH_LABEL
	movq	%rbx, %rdi
	callq	_ZNSo9_M_insertIdEERSoT_@PLT
.Ltmp171:                               # EH_LABEL
# %bb.161:                              #   in Loop: Header=BB0_18 Depth=2
.Ltmp172:                               # EH_LABEL
	movq	%rax, %rbx
	movl	$1, %edx
	movq	%rax, %rdi
	movq	%r13, %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp173:                               # EH_LABEL
# %bb.162:                              #   in Loop: Header=BB0_18 Depth=2
	movsd	352(%rsp), %xmm0                # xmm0 = mem[0],zero
.Ltmp174:                               # EH_LABEL
	movq	%rbx, %rdi
	callq	_ZNSo9_M_insertIdEERSoT_@PLT
.Ltmp175:                               # EH_LABEL
# %bb.163:                              #   in Loop: Header=BB0_18 Depth=2
.Ltmp176:                               # EH_LABEL
	movq	%rax, %rbx
	movl	$1, %edx
	movq	%rax, %rdi
	movq	%r13, %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp177:                               # EH_LABEL
# %bb.164:                              #   in Loop: Header=BB0_18 Depth=2
	movl	368(%rsp), %esi
.Ltmp178:                               # EH_LABEL
	movq	%rbx, %rdi
	callq	_ZNSolsEi@PLT
.Ltmp179:                               # EH_LABEL
# %bb.165:                              #   in Loop: Header=BB0_18 Depth=2
.Ltmp180:                               # EH_LABEL
	movq	%rax, %rbx
	movl	$1, %edx
	movq	%rax, %rdi
	movq	%r13, %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp181:                               # EH_LABEL
# %bb.166:                              #   in Loop: Header=BB0_18 Depth=2
	movl	372(%rsp), %esi
.Ltmp182:                               # EH_LABEL
	movq	%rbx, %rdi
	callq	_ZNSolsEi@PLT
.Ltmp183:                               # EH_LABEL
# %bb.167:                              #   in Loop: Header=BB0_18 Depth=2
.Ltmp184:                               # EH_LABEL
	movl	$1, %edx
	movq	%rax, %rdi
	leaq	.L.str.18(%rip), %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp185:                               # EH_LABEL
# %bb.168:                              #   in Loop: Header=BB0_18 Depth=2
	movsd	304(%rsp), %xmm0                # xmm0 = mem[0],zero
	movsd	344(%rsp), %xmm1                # xmm1 = mem[0],zero
	movsd	352(%rsp), %xmm2                # xmm2 = mem[0],zero
	movl	368(%rsp), %ecx
	movl	372(%rsp), %r8d
	leaq	.L.str.19(%rip), %rdi
	movq	%r12, %rsi
	movq	%r14, %rdx
	movb	$3, %al
	callq	printf@PLT
	movl	52(%rsp), %eax                  # 4-byte Reload
	incl	%eax
	movl	%eax, 52(%rsp)                  # 4-byte Spill
	cmpl	$4, %eax
	movq	424(%rsp), %r12                 # 8-byte Reload
	jne	.LBB0_18
# %bb.169:                              #   in Loop: Header=BB0_17 Depth=1
	addq	$24, %r15
	cmpq	$48, %r15
	jne	.LBB0_17
# %bb.170:
	leaq	.L.str.20(%rip), %rdi
	movq	376(%rsp), %rsi                 # 8-byte Reload
	xorl	%eax, %eax
	callq	printf@PLT
.LBB0_171:
	leaq	584(%rsp), %rdi
	callq	_ZNSt14basic_ofstreamIcSt11char_traitsIcEED1Ev@PLT
	xorl	%eax, %eax
.LBB0_172:
	addq	$1096, %rsp                     # imm = 0x448
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.LBB0_173:
	.cfi_def_cfa_offset 1152
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp98:                                # EH_LABEL
	movl	%eax, %edi
	movq	32(%rsp), %r14                  # 8-byte Reload
	movq	40(%rsp), %r12                  # 8-byte Reload
	movq	24(%rsp), %r13                  # 8-byte Reload
	movq	80(%rsp), %rbp                  # 8-byte Reload
	callq	hipGetErrorString@PLT
.Ltmp99:                                # EH_LABEL
.LBB0_174:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$591, %r8d                      # imm = 0x24F
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB0_175:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp104:                               # EH_LABEL
	movl	%eax, %edi
	movq	32(%rsp), %r14                  # 8-byte Reload
	movq	40(%rsp), %r12                  # 8-byte Reload
	movq	24(%rsp), %r13                  # 8-byte Reload
	callq	hipGetErrorString@PLT
.Ltmp105:                               # EH_LABEL
# %bb.176:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$603, %r8d                      # imm = 0x25B
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB0_177:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp116:                               # EH_LABEL
	movl	%eax, %edi
	movq	32(%rsp), %r14                  # 8-byte Reload
	movq	40(%rsp), %r12                  # 8-byte Reload
	movq	24(%rsp), %r13                  # 8-byte Reload
	callq	hipGetErrorString@PLT
.Ltmp117:                               # EH_LABEL
# %bb.178:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$605, %r8d                      # imm = 0x25D
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB0_179:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp110:                               # EH_LABEL
	movl	%eax, %edi
	movq	32(%rsp), %r14                  # 8-byte Reload
	movq	40(%rsp), %r12                  # 8-byte Reload
	movq	24(%rsp), %r13                  # 8-byte Reload
	callq	hipGetErrorString@PLT
.Ltmp111:                               # EH_LABEL
# %bb.180:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$604, %r8d                      # imm = 0x25C
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB0_181:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp92:                                # EH_LABEL
	movl	%eax, %edi
	movq	32(%rsp), %r14                  # 8-byte Reload
	movq	40(%rsp), %r12                  # 8-byte Reload
	movq	24(%rsp), %r13                  # 8-byte Reload
	callq	hipGetErrorString@PLT
.Ltmp93:                                # EH_LABEL
# %bb.182:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$601, %r8d                      # imm = 0x259
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB0_183:
.Ltmp187:                               # EH_LABEL
	leaq	.L.str.38(%rip), %rdi
	movq	32(%rsp), %r14                  # 8-byte Reload
	movq	40(%rsp), %r12                  # 8-byte Reload
	callq	_ZSt20__throw_length_errorPKc@PLT
.Ltmp188:                               # EH_LABEL
# %bb.184:
.LBB0_185:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp62:                                # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp63:                                # EH_LABEL
	jmp	.LBB0_174
.LBB0_186:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp42:                                # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp43:                                # EH_LABEL
# %bb.187:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$578, %r8d                      # imm = 0x242
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB0_188:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp15:                                # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp16:                                # EH_LABEL
# %bb.189:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$551, %r8d                      # imm = 0x227
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB0_190:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp21:                                # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp22:                                # EH_LABEL
# %bb.191:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$555, %r8d                      # imm = 0x22B
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB0_192:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp36:                                # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp37:                                # EH_LABEL
# %bb.193:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$569, %r8d                      # imm = 0x239
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB0_194:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp30:                                # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp31:                                # EH_LABEL
# %bb.195:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$567, %r8d                      # imm = 0x237
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB0_196:
.Ltmp193:                               # EH_LABEL
	leaq	.L.str.36(%rip), %rdi
	callq	_ZSt20__throw_length_errorPKc@PLT
.Ltmp194:                               # EH_LABEL
# %bb.197:
.LBB0_198:
.Ltmp190:                               # EH_LABEL
	leaq	.L.str.36(%rip), %rdi
	callq	_ZSt20__throw_length_errorPKc@PLT
.Ltmp191:                               # EH_LABEL
# %bb.199:
.LBB0_200:
	movq	%rsi, %r15
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp9:                                 # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp10:                                # EH_LABEL
# %bb.201:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$550, %r8d                      # imm = 0x226
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB0_202:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp48:                                # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp49:                                # EH_LABEL
# %bb.203:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$580, %r8d                      # imm = 0x244
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB0_204:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp86:                                # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp87:                                # EH_LABEL
	jmp	.LBB0_206
.LBB0_205:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp80:                                # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp81:                                # EH_LABEL
.LBB0_206:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$598, %r8d                      # imm = 0x256
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB0_207:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp74:                                # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp75:                                # EH_LABEL
# %bb.208:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$596, %r8d                      # imm = 0x254
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB0_209:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp68:                                # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp69:                                # EH_LABEL
# %bb.210:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$595, %r8d                      # imm = 0x253
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB0_211:
	movq	stderr@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	leaq	.L.str.37(%rip), %rsi
	movl	52(%rsp), %edx                  # 4-byte Reload
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB0_212:
.Ltmp2:                                 # EH_LABEL
	jmp	.LBB0_253
.LBB0_213:
.Ltmp206:                               # EH_LABEL
	jmp	.LBB0_253
.LBB0_214:
.Ltmp70:                                # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_266
.LBB0_215:
.Ltmp76:                                # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_266
.LBB0_216:
.Ltmp82:                                # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_266
.LBB0_217:
.Ltmp88:                                # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_266
.LBB0_218:
.Ltmp50:                                # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_266
.LBB0_219:
.Ltmp11:                                # EH_LABEL
	movq	%rax, %rbx
	movq	%r15, %rdi
	jmp	.LBB0_269
.LBB0_220:
.Ltmp32:                                # EH_LABEL
	jmp	.LBB0_238
.LBB0_221:
.Ltmp38:                                # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_266
.LBB0_222:
.Ltmp23:                                # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_268
.LBB0_223:
.Ltmp17:                                # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_268
.LBB0_224:
.Ltmp44:                                # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_266
.LBB0_225:
.Ltmp124:                               # EH_LABEL
	movq	%rax, %rbx
	movq	32(%rsp), %r14                  # 8-byte Reload
	movq	40(%rsp), %r12                  # 8-byte Reload
	jmp	.LBB0_258
.LBB0_226:
.Ltmp26:                                # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_268
.LBB0_227:
.Ltmp5:                                 # EH_LABEL
	jmp	.LBB0_253
.LBB0_228:
.Ltmp67:                                # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_266
.LBB0_229:
.Ltmp73:                                # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_266
.LBB0_230:
.Ltmp79:                                # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_266
.LBB0_231:
.Ltmp85:                                # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_266
.LBB0_232:
.Ltmp8:                                 # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_268
.LBB0_233:
.Ltmp29:                                # EH_LABEL
	jmp	.LBB0_238
.LBB0_234:
.Ltmp192:                               # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_268
.LBB0_235:
.Ltmp195:                               # EH_LABEL
	jmp	.LBB0_253
.LBB0_236:
.Ltmp14:                                # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_268
.LBB0_237:
.Ltmp35:                                # EH_LABEL
.LBB0_238:
	movq	%rax, %rbx
	movq	32(%rsp), %r14                  # 8-byte Reload
	jmp	.LBB0_266
.LBB0_239:
.Ltmp20:                                # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_268
.LBB0_240:
.Ltmp41:                                # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_266
.LBB0_241:
.Ltmp47:                                # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_266
.LBB0_242:
.Ltmp64:                                # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_266
.LBB0_243:
.Ltmp131:                               # EH_LABEL
	movq	%rax, %rbx
	movq	80(%rsp), %rbp                  # 8-byte Reload
	subq	%r13, %rbp
	movq	32(%rsp), %r14                  # 8-byte Reload
	movq	40(%rsp), %r12                  # 8-byte Reload
	jmp	.LBB0_265
.LBB0_244:
.Ltmp61:                                # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_266
.LBB0_245:
.Ltmp189:                               # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_257
.LBB0_246:
.Ltmp121:                               # EH_LABEL
	jmp	.LBB0_256
.LBB0_247:
.Ltmp94:                                # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_258
.LBB0_248:
.Ltmp112:                               # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_263
.LBB0_249:
.Ltmp118:                               # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_263
.LBB0_250:
.Ltmp106:                               # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_263
.LBB0_251:
.Ltmp100:                               # EH_LABEL
	movq	%rax, %rbx
	jmp	.LBB0_263
.LBB0_252:
.Ltmp186:                               # EH_LABEL
.LBB0_253:
	movq	%rax, %rbx
	leaq	584(%rsp), %rdi
	callq	_ZNSt14basic_ofstreamIcSt11char_traitsIcEED1Ev@PLT
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.LBB0_254:
.Ltmp91:                                # EH_LABEL
	jmp	.LBB0_256
.LBB0_255:
.Ltmp97:                                # EH_LABEL
.LBB0_256:
	movq	%rax, %rbx
	movq	32(%rsp), %r14                  # 8-byte Reload
	movq	40(%rsp), %r12                  # 8-byte Reload
.LBB0_257:
	movq	24(%rsp), %r13                  # 8-byte Reload
.LBB0_258:
	movq	80(%rsp), %rbp                  # 8-byte Reload
	jmp	.LBB0_263
.LBB0_259:
.Ltmp103:                               # EH_LABEL
	jmp	.LBB0_262
.LBB0_260:
.Ltmp109:                               # EH_LABEL
	jmp	.LBB0_262
.LBB0_261:
.Ltmp115:                               # EH_LABEL
.LBB0_262:
	movq	%rax, %rbx
	movq	32(%rsp), %r14                  # 8-byte Reload
	movq	40(%rsp), %r12                  # 8-byte Reload
	movq	24(%rsp), %r13                  # 8-byte Reload
.LBB0_263:
	testq	%r13, %r13
	je	.LBB0_266
# %bb.264:
	subq	%r13, %rbp
.LBB0_265:
	movq	%r13, %rdi
	movq	%rbp, %rsi
	callq	_ZdlPvm@PLT
.LBB0_266:
	testq	%r12, %r12
	je	.LBB0_268
# %bb.267:
	movq	200(%rsp), %rsi                 # 8-byte Reload
	subq	%r12, %rsi
	movq	%r12, %rdi
	callq	_ZdlPvm@PLT
.LBB0_268:
	movq	72(%rsp), %rdi                  # 8-byte Reload
.LBB0_269:
	testq	%rdi, %rdi
	je	.LBB0_271
# %bb.270:
	movq	%r14, %rsi
	callq	_ZdlPvm@PLT
.LBB0_271:
	leaq	584(%rsp), %rdi
	callq	_ZNSt14basic_ofstreamIcSt11char_traitsIcEED1Ev@PLT
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
.LJTI0_0:
	.long	.LBB0_55-.LJTI0_0
	.long	.LBB0_60-.LJTI0_0
	.long	.LBB0_58-.LJTI0_0
	.long	.LBB0_59-.LJTI0_0
.LJTI0_1:
	.long	.LBB0_57-.LJTI0_1
	.long	.LBB0_60-.LJTI0_1
	.long	.LBB0_211-.LJTI0_1
	.long	.LBB0_117-.LJTI0_1
	.long	.LBB0_211-.LJTI0_1
	.long	.LBB0_211-.LJTI0_1
	.long	.LBB0_211-.LJTI0_1
	.long	.LBB0_118-.LJTI0_1
	.section	.gcc_except_table,"a",@progbits
	.p2align	2, 0x0
GCC_except_table0:
.Lexception0:
	.byte	255                             # @LPStart Encoding = omit
	.byte	255                             # @TType Encoding = omit
	.byte	1                               # Call site Encoding = uleb128
	.uleb128 .Lcst_end0-.Lcst_begin0
.Lcst_begin0:
	.uleb128 .Lfunc_begin0-.Lfunc_begin0    # >> Call Site 1 <<
	.uleb128 .Ltmp196-.Lfunc_begin0         #   Call between .Lfunc_begin0 and .Ltmp196
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp196-.Lfunc_begin0         # >> Call Site 2 <<
	.uleb128 .Ltmp205-.Ltmp196              #   Call between .Ltmp196 and .Ltmp205
	.uleb128 .Ltmp206-.Lfunc_begin0         #     jumps to .Ltmp206
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp205-.Lfunc_begin0         # >> Call Site 3 <<
	.uleb128 .Ltmp0-.Ltmp205                #   Call between .Ltmp205 and .Ltmp0
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp0-.Lfunc_begin0           # >> Call Site 4 <<
	.uleb128 .Ltmp1-.Ltmp0                  #   Call between .Ltmp0 and .Ltmp1
	.uleb128 .Ltmp2-.Lfunc_begin0           #     jumps to .Ltmp2
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp3-.Lfunc_begin0           # >> Call Site 5 <<
	.uleb128 .Ltmp4-.Ltmp3                  #   Call between .Ltmp3 and .Ltmp4
	.uleb128 .Ltmp5-.Lfunc_begin0           #     jumps to .Ltmp5
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp4-.Lfunc_begin0           # >> Call Site 6 <<
	.uleb128 .Ltmp6-.Ltmp4                  #   Call between .Ltmp4 and .Ltmp6
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp6-.Lfunc_begin0           # >> Call Site 7 <<
	.uleb128 .Ltmp7-.Ltmp6                  #   Call between .Ltmp6 and .Ltmp7
	.uleb128 .Ltmp8-.Lfunc_begin0           #     jumps to .Ltmp8
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp12-.Lfunc_begin0          # >> Call Site 8 <<
	.uleb128 .Ltmp13-.Ltmp12                #   Call between .Ltmp12 and .Ltmp13
	.uleb128 .Ltmp14-.Lfunc_begin0          #     jumps to .Ltmp14
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp18-.Lfunc_begin0          # >> Call Site 9 <<
	.uleb128 .Ltmp19-.Ltmp18                #   Call between .Ltmp18 and .Ltmp19
	.uleb128 .Ltmp20-.Lfunc_begin0          #     jumps to .Ltmp20
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp24-.Lfunc_begin0          # >> Call Site 10 <<
	.uleb128 .Ltmp25-.Ltmp24                #   Call between .Ltmp24 and .Ltmp25
	.uleb128 .Ltmp26-.Lfunc_begin0          #     jumps to .Ltmp26
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp25-.Lfunc_begin0          # >> Call Site 11 <<
	.uleb128 .Ltmp27-.Ltmp25                #   Call between .Ltmp25 and .Ltmp27
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp27-.Lfunc_begin0          # >> Call Site 12 <<
	.uleb128 .Ltmp28-.Ltmp27                #   Call between .Ltmp27 and .Ltmp28
	.uleb128 .Ltmp29-.Lfunc_begin0          #     jumps to .Ltmp29
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp33-.Lfunc_begin0          # >> Call Site 13 <<
	.uleb128 .Ltmp34-.Ltmp33                #   Call between .Ltmp33 and .Ltmp34
	.uleb128 .Ltmp35-.Lfunc_begin0          #     jumps to .Ltmp35
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp39-.Lfunc_begin0          # >> Call Site 14 <<
	.uleb128 .Ltmp40-.Ltmp39                #   Call between .Ltmp39 and .Ltmp40
	.uleb128 .Ltmp41-.Lfunc_begin0          #     jumps to .Ltmp41
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp45-.Lfunc_begin0          # >> Call Site 15 <<
	.uleb128 .Ltmp46-.Ltmp45                #   Call between .Ltmp45 and .Ltmp46
	.uleb128 .Ltmp47-.Lfunc_begin0          #     jumps to .Ltmp47
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp51-.Lfunc_begin0          # >> Call Site 16 <<
	.uleb128 .Ltmp60-.Ltmp51                #   Call between .Ltmp51 and .Ltmp60
	.uleb128 .Ltmp61-.Lfunc_begin0          #     jumps to .Ltmp61
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp65-.Lfunc_begin0          # >> Call Site 17 <<
	.uleb128 .Ltmp66-.Ltmp65                #   Call between .Ltmp65 and .Ltmp66
	.uleb128 .Ltmp67-.Lfunc_begin0          #     jumps to .Ltmp67
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp71-.Lfunc_begin0          # >> Call Site 18 <<
	.uleb128 .Ltmp72-.Ltmp71                #   Call between .Ltmp71 and .Ltmp72
	.uleb128 .Ltmp73-.Lfunc_begin0          #     jumps to .Ltmp73
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp77-.Lfunc_begin0          # >> Call Site 19 <<
	.uleb128 .Ltmp78-.Ltmp77                #   Call between .Ltmp77 and .Ltmp78
	.uleb128 .Ltmp79-.Lfunc_begin0          #     jumps to .Ltmp79
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp83-.Lfunc_begin0          # >> Call Site 20 <<
	.uleb128 .Ltmp84-.Ltmp83                #   Call between .Ltmp83 and .Ltmp84
	.uleb128 .Ltmp85-.Lfunc_begin0          #     jumps to .Ltmp85
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp89-.Lfunc_begin0          # >> Call Site 21 <<
	.uleb128 .Ltmp90-.Ltmp89                #   Call between .Ltmp89 and .Ltmp90
	.uleb128 .Ltmp91-.Lfunc_begin0          #     jumps to .Ltmp91
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp95-.Lfunc_begin0          # >> Call Site 22 <<
	.uleb128 .Ltmp96-.Ltmp95                #   Call between .Ltmp95 and .Ltmp96
	.uleb128 .Ltmp97-.Lfunc_begin0          #     jumps to .Ltmp97
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp101-.Lfunc_begin0         # >> Call Site 23 <<
	.uleb128 .Ltmp102-.Ltmp101              #   Call between .Ltmp101 and .Ltmp102
	.uleb128 .Ltmp103-.Lfunc_begin0         #     jumps to .Ltmp103
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp107-.Lfunc_begin0         # >> Call Site 24 <<
	.uleb128 .Ltmp108-.Ltmp107              #   Call between .Ltmp107 and .Ltmp108
	.uleb128 .Ltmp109-.Lfunc_begin0         #     jumps to .Ltmp109
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp113-.Lfunc_begin0         # >> Call Site 25 <<
	.uleb128 .Ltmp114-.Ltmp113              #   Call between .Ltmp113 and .Ltmp114
	.uleb128 .Ltmp115-.Lfunc_begin0         #     jumps to .Ltmp115
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp119-.Lfunc_begin0         # >> Call Site 26 <<
	.uleb128 .Ltmp120-.Ltmp119              #   Call between .Ltmp119 and .Ltmp120
	.uleb128 .Ltmp121-.Lfunc_begin0         #     jumps to .Ltmp121
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp120-.Lfunc_begin0         # >> Call Site 27 <<
	.uleb128 .Ltmp122-.Ltmp120              #   Call between .Ltmp120 and .Ltmp122
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp122-.Lfunc_begin0         # >> Call Site 28 <<
	.uleb128 .Ltmp123-.Ltmp122              #   Call between .Ltmp122 and .Ltmp123
	.uleb128 .Ltmp124-.Lfunc_begin0         #     jumps to .Ltmp124
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp123-.Lfunc_begin0         # >> Call Site 29 <<
	.uleb128 .Ltmp125-.Ltmp123              #   Call between .Ltmp123 and .Ltmp125
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp125-.Lfunc_begin0         # >> Call Site 30 <<
	.uleb128 .Ltmp130-.Ltmp125              #   Call between .Ltmp125 and .Ltmp130
	.uleb128 .Ltmp131-.Lfunc_begin0         #     jumps to .Ltmp131
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp132-.Lfunc_begin0         # >> Call Site 31 <<
	.uleb128 .Ltmp185-.Ltmp132              #   Call between .Ltmp132 and .Ltmp185
	.uleb128 .Ltmp186-.Lfunc_begin0         #     jumps to .Ltmp186
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp98-.Lfunc_begin0          # >> Call Site 32 <<
	.uleb128 .Ltmp99-.Ltmp98                #   Call between .Ltmp98 and .Ltmp99
	.uleb128 .Ltmp100-.Lfunc_begin0         #     jumps to .Ltmp100
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp104-.Lfunc_begin0         # >> Call Site 33 <<
	.uleb128 .Ltmp105-.Ltmp104              #   Call between .Ltmp104 and .Ltmp105
	.uleb128 .Ltmp106-.Lfunc_begin0         #     jumps to .Ltmp106
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp116-.Lfunc_begin0         # >> Call Site 34 <<
	.uleb128 .Ltmp117-.Ltmp116              #   Call between .Ltmp116 and .Ltmp117
	.uleb128 .Ltmp118-.Lfunc_begin0         #     jumps to .Ltmp118
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp110-.Lfunc_begin0         # >> Call Site 35 <<
	.uleb128 .Ltmp111-.Ltmp110              #   Call between .Ltmp110 and .Ltmp111
	.uleb128 .Ltmp112-.Lfunc_begin0         #     jumps to .Ltmp112
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp92-.Lfunc_begin0          # >> Call Site 36 <<
	.uleb128 .Ltmp93-.Ltmp92                #   Call between .Ltmp92 and .Ltmp93
	.uleb128 .Ltmp94-.Lfunc_begin0          #     jumps to .Ltmp94
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp187-.Lfunc_begin0         # >> Call Site 37 <<
	.uleb128 .Ltmp188-.Ltmp187              #   Call between .Ltmp187 and .Ltmp188
	.uleb128 .Ltmp189-.Lfunc_begin0         #     jumps to .Ltmp189
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp62-.Lfunc_begin0          # >> Call Site 38 <<
	.uleb128 .Ltmp63-.Ltmp62                #   Call between .Ltmp62 and .Ltmp63
	.uleb128 .Ltmp64-.Lfunc_begin0          #     jumps to .Ltmp64
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp42-.Lfunc_begin0          # >> Call Site 39 <<
	.uleb128 .Ltmp43-.Ltmp42                #   Call between .Ltmp42 and .Ltmp43
	.uleb128 .Ltmp44-.Lfunc_begin0          #     jumps to .Ltmp44
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp15-.Lfunc_begin0          # >> Call Site 40 <<
	.uleb128 .Ltmp16-.Ltmp15                #   Call between .Ltmp15 and .Ltmp16
	.uleb128 .Ltmp17-.Lfunc_begin0          #     jumps to .Ltmp17
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp21-.Lfunc_begin0          # >> Call Site 41 <<
	.uleb128 .Ltmp22-.Ltmp21                #   Call between .Ltmp21 and .Ltmp22
	.uleb128 .Ltmp23-.Lfunc_begin0          #     jumps to .Ltmp23
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp36-.Lfunc_begin0          # >> Call Site 42 <<
	.uleb128 .Ltmp37-.Ltmp36                #   Call between .Ltmp36 and .Ltmp37
	.uleb128 .Ltmp38-.Lfunc_begin0          #     jumps to .Ltmp38
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp30-.Lfunc_begin0          # >> Call Site 43 <<
	.uleb128 .Ltmp31-.Ltmp30                #   Call between .Ltmp30 and .Ltmp31
	.uleb128 .Ltmp32-.Lfunc_begin0          #     jumps to .Ltmp32
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp193-.Lfunc_begin0         # >> Call Site 44 <<
	.uleb128 .Ltmp194-.Ltmp193              #   Call between .Ltmp193 and .Ltmp194
	.uleb128 .Ltmp195-.Lfunc_begin0         #     jumps to .Ltmp195
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp190-.Lfunc_begin0         # >> Call Site 45 <<
	.uleb128 .Ltmp191-.Ltmp190              #   Call between .Ltmp190 and .Ltmp191
	.uleb128 .Ltmp192-.Lfunc_begin0         #     jumps to .Ltmp192
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp9-.Lfunc_begin0           # >> Call Site 46 <<
	.uleb128 .Ltmp10-.Ltmp9                 #   Call between .Ltmp9 and .Ltmp10
	.uleb128 .Ltmp11-.Lfunc_begin0          #     jumps to .Ltmp11
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp48-.Lfunc_begin0          # >> Call Site 47 <<
	.uleb128 .Ltmp49-.Ltmp48                #   Call between .Ltmp48 and .Ltmp49
	.uleb128 .Ltmp50-.Lfunc_begin0          #     jumps to .Ltmp50
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp86-.Lfunc_begin0          # >> Call Site 48 <<
	.uleb128 .Ltmp87-.Ltmp86                #   Call between .Ltmp86 and .Ltmp87
	.uleb128 .Ltmp88-.Lfunc_begin0          #     jumps to .Ltmp88
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp80-.Lfunc_begin0          # >> Call Site 49 <<
	.uleb128 .Ltmp81-.Ltmp80                #   Call between .Ltmp80 and .Ltmp81
	.uleb128 .Ltmp82-.Lfunc_begin0          #     jumps to .Ltmp82
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp74-.Lfunc_begin0          # >> Call Site 50 <<
	.uleb128 .Ltmp75-.Ltmp74                #   Call between .Ltmp74 and .Ltmp75
	.uleb128 .Ltmp76-.Lfunc_begin0          #     jumps to .Ltmp76
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp68-.Lfunc_begin0          # >> Call Site 51 <<
	.uleb128 .Ltmp69-.Ltmp68                #   Call between .Ltmp68 and .Ltmp69
	.uleb128 .Ltmp70-.Lfunc_begin0          #     jumps to .Ltmp70
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp69-.Lfunc_begin0          # >> Call Site 52 <<
	.uleb128 .Lfunc_end0-.Ltmp69            #   Call between .Ltmp69 and .Lfunc_end0
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
.Lcst_end0:
	.p2align	2, 0x0
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function _ZL8verify_eiibRSt14basic_ofstreamIcSt11char_traitsIcEE
.LCPI1_0:
	.long	0                               # 0x0
	.long	1                               # 0x1
	.long	2                               # 0x2
	.long	3                               # 0x3
.LCPI1_1:
	.quad	2                               # 0x2
	.quad	3                               # 0x3
.LCPI1_2:
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	1                               # 0x1
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
.LCPI1_3:
	.quad	14                              # 0xe
	.quad	15                              # 0xf
.LCPI1_4:
	.quad	12                              # 0xc
	.quad	13                              # 0xd
.LCPI1_5:
	.quad	10                              # 0xa
	.quad	11                              # 0xb
.LCPI1_6:
	.quad	8                               # 0x8
	.quad	9                               # 0x9
.LCPI1_7:
	.quad	6                               # 0x6
	.quad	7                               # 0x7
.LCPI1_8:
	.quad	4                               # 0x4
	.quad	5                               # 0x5
.LCPI1_9:
	.byte	255                             # 0xff
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	255                             # 0xff
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
.LCPI1_10:
	.quad	16                              # 0x10
	.quad	16                              # 0x10
.LCPI1_11:
	.quad	4                               # 0x4
	.quad	4                               # 0x4
.LCPI1_12:
	.short	0                               # 0x0
	.short	1                               # 0x1
	.zero	2
	.zero	2
	.zero	2
	.zero	2
	.zero	2
	.zero	2
.LCPI1_13:
	.byte	255                             # 0xff
	.byte	0                               # 0x0
	.byte	255                             # 0xff
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
.LCPI1_14:
	.short	14336                           # 0x3800
	.short	14336                           # 0x3800
	.zero	2
	.zero	2
	.zero	2
	.zero	2
	.zero	2
	.zero	2
.LCPI1_15:
	.short	0                               # 0x0
	.short	1                               # 0x1
	.short	0                               # 0x0
	.short	0                               # 0x0
	.short	0                               # 0x0
	.short	0                               # 0x0
	.short	0                               # 0x0
	.short	0                               # 0x0
	.text
	.p2align	4
	.type	_ZL8verify_eiibRSt14basic_ofstreamIcSt11char_traitsIcEE,@function
_ZL8verify_eiibRSt14basic_ofstreamIcSt11char_traitsIcEE: # @_ZL8verify_eiibRSt14basic_ofstreamIcSt11char_traitsIcEE
.Lfunc_begin1:
	.cfi_startproc
	.cfi_personality 155, DW.ref.__gxx_personality_v0
	.cfi_lsda 27, .Lexception1
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$488, %rsp                      # imm = 0x1E8
	.cfi_def_cfa_offset 544
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rcx, 272(%rsp)                 # 8-byte Spill
	movl	%edx, %ecx
	movl	%edi, %edx
	movl	%edi, %r8d
	shrl	$8, %r8d
	movl	%r8d, %eax
	shll	$6, %eax
	leaq	(%rax,%r8,2), %r14
	movl	%esi, 20(%rsp)                  # 4-byte Spill
	movl	%esi, %esi
	movq	%r14, %rdi
	imulq	%rsi, %rdi
	movl	%ecx, %eax
	incq	%rax
	movq	%rax, 376(%rsp)                 # 8-byte Spill
	movaps	.LCPI1_0(%rip), %xmm0           # xmm0 = [0,1,2,3]
	movaps	%xmm0, 304(%rsp)
	movq	%rdi, 384(%rsp)                 # 8-byte Spill
	shlq	%cl, %rdi
	movl	%edx, 80(%rsp)                  # 4-byte Spill
	movl	%edx, %r9d
	shrl	$5, %r9d
	movabsq	$4294967296, %rax               # imm = 0x100000000
	orq	%rsi, %rax
	movq	%rax, 280(%rsp)                 # 8-byte Spill
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rax
	movl	%ecx, 76(%rsp)                  # 4-byte Spill
	testl	%ecx, %ecx
	cmovneq	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rax
	movq	%rax, 368(%rsp)                 # 8-byte Spill
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rax
	cmovneq	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rax
	movq	%rax, 352(%rsp)                 # 8-byte Spill
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rax
	cmovneq	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rax
	movq	%rax, 344(%rsp)                 # 8-byte Spill
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rax
	cmovneq	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rax
	movq	%rax, 360(%rsp)                 # 8-byte Spill
	movl	%edi, %eax
	andl	$1073741808, %eax               # imm = 0x3FFFFFF0
	movq	%rax, 320(%rsp)                 # 8-byte Spill
	movl	%edi, %eax
	andl	$1073741820, %eax               # imm = 0x3FFFFFFC
	movq	%rax, 408(%rsp)                 # 8-byte Spill
	movl	%r8d, %r10d
	andl	$3, %r10d
	movl	%r8d, %r15d
	andl	$124, %r15d
	leal	(,%r9,4), %eax
	leaq	(%rax,%rax,8), %rdx
	movl	%edx, %ecx
	andl	$65520, %ecx                    # imm = 0xFFF0
	movq	%rcx, 432(%rsp)                 # 8-byte Spill
	movq	%rcx, %xmm0
	pshufd	$68, %xmm0, %xmm0               # xmm0 = xmm0[0,1,0,1]
	movdqa	.LCPI1_1(%rip), %xmm1           # xmm1 = [2,3]
	por	%xmm0, %xmm1
	movdqa	%xmm1, 448(%rsp)                # 16-byte Spill
	por	.LCPI1_2(%rip), %xmm0
	movdqa	%xmm0, 464(%rsp)                # 16-byte Spill
	movq	%r9, 176(%rsp)                  # 8-byte Spill
                                        # kill: def $r9d killed $r9d killed $r9 def $r9
	andl	$1022, %r9d                     # imm = 0x3FE
	movq	%r9, 416(%rsp)                  # 8-byte Spill
	movl	%r10d, %ecx
	shll	$6, %ecx
	movq	%r10, 184(%rsp)                 # 8-byte Spill
	leal	(%rcx,%r10,2), %r13d
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	andq	$-65524, %rdx                   # imm = 0xFFFF000C
	movq	%rdx, 424(%rsp)                 # 8-byte Spill
	leaq	(%rax,%rax,8), %rcx
	decq	%rcx
	movq	%rcx, 328(%rsp)                 # 8-byte Spill
	leal	(%rax,%rax,8), %eax
	andb	$-16, %al
	movq	%rax, 400(%rsp)                 # 8-byte Spill
	leaq	-1(%rdi), %rax
	movq	%rax, 336(%rsp)                 # 8-byte Spill
	leaq	(,%rsi,4), %rax
	movq	%rax, 392(%rsp)                 # 8-byte Spill
	movq	%rsi, 56(%rsp)                  # 8-byte Spill
	leaq	-4(,%rsi,4), %r12
	movq	%r8, 288(%rsp)                  # 8-byte Spill
	leal	-1(%r8), %eax
	movl	%eax, 84(%rsp)                  # 4-byte Spill
	xorl	%eax, %eax
	movq	%rdi, 24(%rsp)                  # 8-byte Spill
	movq	%r12, 296(%rsp)                 # 8-byte Spill
	.p2align	4
.LBB1_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_8 Depth 2
                                        #     Child Loop BB1_12 Depth 2
                                        #     Child Loop BB1_15 Depth 2
                                        #       Child Loop BB1_16 Depth 3
                                        #         Child Loop BB1_19 Depth 4
                                        #         Child Loop BB1_22 Depth 4
                                        #     Child Loop BB1_48 Depth 2
                                        #     Child Loop BB1_62 Depth 2
                                        #     Child Loop BB1_60 Depth 2
                                        #     Child Loop BB1_65 Depth 2
                                        #     Child Loop BB1_77 Depth 2
                                        #       Child Loop BB1_117 Depth 3
	movq	%rax, 440(%rsp)                 # 8-byte Spill
	movl	304(%rsp,%rax), %ebx
.Ltmp207:                               # EH_LABEL
	movq	%rdi, %r12
	callq	_Znwm@PLT
.Ltmp208:                               # EH_LABEL
# %bb.2:                                #   in Loop: Header=BB1_1 Depth=1
	movb	$0, (%rax)
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	leaq	1(%rax), %rdi
	xorl	%esi, %esi
	movq	336(%rsp), %rdx                 # 8-byte Reload
	callq	memset@PLT
	cmpq	$4, %r12
	movq	%r12, %rdx
	jae	.LBB1_5
# %bb.3:                                #   in Loop: Header=BB1_1 Depth=1
	xorl	%ecx, %ecx
	movq	88(%rsp), %rsi                  # 8-byte Reload
	jmp	.LBB1_4
	.p2align	4
.LBB1_5:                                #   in Loop: Header=BB1_1 Depth=1
	cmpq	$16, %rdx
	jae	.LBB1_7
# %bb.6:                                #   in Loop: Header=BB1_1 Depth=1
	xorl	%eax, %eax
	movq	88(%rsp), %rsi                  # 8-byte Reload
	jmp	.LBB1_11
	.p2align	4
.LBB1_7:                                #   in Loop: Header=BB1_1 Depth=1
	movd	%ebx, %xmm0
	pshufd	$68, %xmm0, %xmm0               # xmm0 = xmm0[0,1,0,1]
	xorl	%eax, %eax
	movdqa	.LCPI1_2(%rip), %xmm1           # xmm1 = [0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0]
	movdqa	.LCPI1_1(%rip), %xmm2           # xmm2 = [2,3]
	movdqa	.LCPI1_8(%rip), %xmm3           # xmm3 = [4,5]
	movdqa	.LCPI1_7(%rip), %xmm4           # xmm4 = [6,7]
	movdqa	.LCPI1_6(%rip), %xmm5           # xmm5 = [8,9]
	movdqa	.LCPI1_5(%rip), %xmm6           # xmm6 = [10,11]
	movdqa	.LCPI1_4(%rip), %xmm7           # xmm7 = [12,13]
	movdqa	.LCPI1_3(%rip), %xmm8           # xmm8 = [14,15]
	movq	88(%rsp), %rsi                  # 8-byte Reload
	movq	320(%rsp), %rcx                 # 8-byte Reload
	movdqa	.LCPI1_9(%rip), %xmm13          # xmm13 = [255,0,0,0,0,0,0,0,255,0,0,0,0,0,0,0]
	movdqa	.LCPI1_10(%rip), %xmm14         # xmm14 = [16,16]
	.p2align	4
.LBB1_8:                                #   Parent Loop BB1_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movdqa	%xmm8, %xmm9
	paddq	%xmm0, %xmm9
	movdqa	%xmm4, %xmm11
	paddq	%xmm0, %xmm11
	movdqa	%xmm2, %xmm12
	paddq	%xmm0, %xmm12
	movdqa	%xmm1, %xmm10
	paddq	%xmm0, %xmm10
	pand	%xmm13, %xmm10
	pand	%xmm13, %xmm12
	packuswb	%xmm12, %xmm10
	movdqa	%xmm3, %xmm12
	paddq	%xmm0, %xmm12
	pand	%xmm13, %xmm12
	pand	%xmm13, %xmm11
	packuswb	%xmm11, %xmm12
	movdqa	%xmm6, %xmm11
	paddq	%xmm0, %xmm11
	packuswb	%xmm12, %xmm10
	movdqa	%xmm5, %xmm12
	paddq	%xmm0, %xmm12
	pand	%xmm13, %xmm12
	pand	%xmm13, %xmm11
	packuswb	%xmm11, %xmm12
	movdqa	%xmm7, %xmm11
	paddq	%xmm0, %xmm11
	pand	%xmm13, %xmm11
	pand	%xmm13, %xmm9
	packuswb	%xmm9, %xmm11
	packuswb	%xmm11, %xmm12
	packuswb	%xmm12, %xmm10
	movdqu	%xmm10, (%rsi,%rax)
	addq	$16, %rax
	paddq	%xmm14, %xmm1
	paddq	%xmm14, %xmm2
	paddq	%xmm14, %xmm3
	paddq	%xmm14, %xmm4
	paddq	%xmm14, %xmm5
	paddq	%xmm14, %xmm6
	paddq	%xmm14, %xmm7
	paddq	%xmm14, %xmm8
	cmpq	%rax, %rcx
	jne	.LBB1_8
# %bb.9:                                #   in Loop: Header=BB1_1 Depth=1
	cmpq	%rcx, %rdx
	je	.LBB1_14
# %bb.10:                               #   in Loop: Header=BB1_1 Depth=1
	movq	320(%rsp), %rcx                 # 8-byte Reload
	movq	%rcx, %rax
	testb	$12, %dl
	je	.LBB1_4
.LBB1_11:                               #   in Loop: Header=BB1_1 Depth=1
	movd	%ebx, %xmm0
	pshufd	$68, %xmm0, %xmm0               # xmm0 = xmm0[0,1,0,1]
	movd	%eax, %xmm1
	pshufd	$68, %xmm1, %xmm1               # xmm1 = xmm1[0,1,0,1]
	movdqa	%xmm1, %xmm2
	por	.LCPI1_1(%rip), %xmm2
	por	.LCPI1_2(%rip), %xmm1
	movq	408(%rsp), %rcx                 # 8-byte Reload
	movdqa	.LCPI1_9(%rip), %xmm5           # xmm5 = [255,0,0,0,0,0,0,0,255,0,0,0,0,0,0,0]
	movdqa	.LCPI1_11(%rip), %xmm6          # xmm6 = [4,4]
	.p2align	4
.LBB1_12:                               #   Parent Loop BB1_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movdqa	%xmm2, %xmm3
	paddq	%xmm0, %xmm3
	movdqa	%xmm1, %xmm4
	paddq	%xmm0, %xmm4
	pand	%xmm5, %xmm4
	pand	%xmm5, %xmm3
	packuswb	%xmm3, %xmm4
	packuswb	%xmm4, %xmm4
	packuswb	%xmm4, %xmm4
	movd	%xmm4, (%rsi,%rax)
	addq	$4, %rax
	paddq	%xmm6, %xmm1
	paddq	%xmm6, %xmm2
	cmpq	%rax, %rcx
	jne	.LBB1_12
	jmp	.LBB1_13
	.p2align	4
.LBB1_4:                                #   in Loop: Header=BB1_1 Depth=1
	leal	(%rbx,%rcx), %eax
	movb	%al, (%rsi,%rcx)
	incq	%rcx
.LBB1_13:                               #   in Loop: Header=BB1_1 Depth=1
	cmpq	%rcx, %rdx
	jne	.LBB1_4
.LBB1_14:                               #   in Loop: Header=BB1_1 Depth=1
	movzbl	%bl, %eax
	movq	%rax, 168(%rsp)                 # 8-byte Spill
	leaq	262(%rsi), %rax
	movq	%rsi, %rcx
	addq	$64, %rcx
	xorl	%edx, %edx
	jmp	.LBB1_15
	.p2align	4
.LBB1_24:                               #   in Loop: Header=BB1_15 Depth=2
	incq	%rdx
	movq	384(%rsp), %rsi                 # 8-byte Reload
	addq	%rsi, %rax
	addq	%rsi, %rcx
	cmpq	376(%rsp), %rdx                 # 8-byte Folded Reload
	je	.LBB1_25
.LBB1_15:                               #   Parent Loop BB1_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_16 Depth 3
                                        #         Child Loop BB1_19 Depth 4
                                        #         Child Loop BB1_22 Depth 4
	movq	%rcx, %rsi
	movq	168(%rsp), %rdi                 # 8-byte Reload
	movq	%rax, %r8
	xorl	%r9d, %r9d
	jmp	.LBB1_16
	.p2align	4
.LBB1_23:                               #   in Loop: Header=BB1_16 Depth=3
	incq	%r9
	addq	%r14, %r8
	incq	%rdi
	addq	%r14, %rsi
	cmpq	56(%rsp), %r9                   # 8-byte Folded Reload
	movq	296(%rsp), %r12                 # 8-byte Reload
	je	.LBB1_24
.LBB1_16:                               #   Parent Loop BB1_1 Depth=1
                                        #     Parent Loop BB1_15 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB1_19 Depth 4
                                        #         Child Loop BB1_22 Depth 4
	cmpl	$3, 84(%rsp)                    # 4-byte Folded Reload
	jae	.LBB1_18
# %bb.17:                               #   in Loop: Header=BB1_16 Depth=3
	xorl	%r10d, %r10d
	jmp	.LBB1_20
	.p2align	4
.LBB1_18:                               #   in Loop: Header=BB1_16 Depth=3
	movq	%r8, %r11
	xorl	%r10d, %r10d
	.p2align	4
.LBB1_19:                               #   Parent Loop BB1_1 Depth=1
                                        #     Parent Loop BB1_15 Depth=2
                                        #       Parent Loop BB1_16 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	leal	(%rdi,%r10), %ebp
	andl	$511, %ebp                      # imm = 0x1FF
	orl	$14336, %ebp                    # imm = 0x3800
	movw	%bp, -198(%r11)
	leal	(%rdi,%r10), %ebp
	incl	%ebp
	andl	$511, %ebp                      # imm = 0x1FF
	orl	$14336, %ebp                    # imm = 0x3800
	movw	%bp, -132(%r11)
	leal	(%rdi,%r10), %ebp
	addl	$2, %ebp
	andl	$511, %ebp                      # imm = 0x1FF
	orl	$14336, %ebp                    # imm = 0x3800
	movw	%bp, -66(%r11)
	leal	(%rdi,%r10), %ebp
	addl	$3, %ebp
	andl	$511, %ebp                      # imm = 0x1FF
	orl	$14336, %ebp                    # imm = 0x3800
	movw	%bp, (%r11)
	addq	$4, %r10
	addq	$264, %r11                      # imm = 0x108
	cmpq	%r10, %r15
	jne	.LBB1_19
.LBB1_20:                               #   in Loop: Header=BB1_16 Depth=3
	cmpq	$0, 184(%rsp)                   # 8-byte Folded Reload
	je	.LBB1_23
# %bb.21:                               #   in Loop: Header=BB1_16 Depth=3
	leal	(%rdi,%r10), %r11d
	movq	%r10, %r12
	shlq	$6, %r12
	leaq	(%r12,%r10,2), %r10
	addq	%rsi, %r10
	xorl	%r12d, %r12d
	.p2align	4
.LBB1_22:                               #   Parent Loop BB1_1 Depth=1
                                        #     Parent Loop BB1_15 Depth=2
                                        #       Parent Loop BB1_16 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movl	%r11d, %ebp
	andl	$511, %ebp                      # imm = 0x1FF
	orl	$14336, %ebp                    # imm = 0x3800
	movw	%bp, (%r10,%r12)
	incl	%r11d
	addq	$66, %r12
	cmpq	%r12, %r13
	jne	.LBB1_22
	jmp	.LBB1_23
	.p2align	4
.LBB1_25:                               #   in Loop: Header=BB1_1 Depth=1
.Ltmp210:                               # EH_LABEL
	leaq	64(%rsp), %rdi
	movq	24(%rsp), %rsi                  # 8-byte Reload
	callq	hipMalloc@PLT
.Ltmp211:                               # EH_LABEL
# %bb.26:                               #   in Loop: Header=BB1_1 Depth=1
	testl	%eax, %eax
	jne	.LBB1_27
# %bb.34:                               #   in Loop: Header=BB1_1 Depth=1
	movq	64(%rsp), %rdi
.Ltmp216:                               # EH_LABEL
	movq	88(%rsp), %rsi                  # 8-byte Reload
	movq	24(%rsp), %rdx                  # 8-byte Reload
	movl	$1, %ecx
	callq	hipMemcpy@PLT
.Ltmp217:                               # EH_LABEL
# %bb.35:                               #   in Loop: Header=BB1_1 Depth=1
	testl	%eax, %eax
	jne	.LBB1_36
# %bb.40:                               #   in Loop: Header=BB1_1 Depth=1
.Ltmp222:                               # EH_LABEL
	leaq	96(%rsp), %rdi
	movq	48(%rsp), %rsi                  # 8-byte Reload
	callq	hipMalloc@PLT
.Ltmp223:                               # EH_LABEL
# %bb.41:                               #   in Loop: Header=BB1_1 Depth=1
	testl	%eax, %eax
	jne	.LBB1_42
# %bb.46:                               #   in Loop: Header=BB1_1 Depth=1
.Ltmp228:                               # EH_LABEL
	movq	48(%rsp), %rdi                  # 8-byte Reload
	callq	_Znwm@PLT
.Ltmp229:                               # EH_LABEL
# %bb.47:                               #   in Loop: Header=BB1_1 Depth=1
	movq	%rax, %rbp
	movb	$0, (%rax)
	leaq	1(%rax), %rdi
	xorl	%esi, %esi
	movq	328(%rsp), %rdx                 # 8-byte Reload
	callq	memset@PLT
	movd	%ebx, %xmm0
	pshufd	$68, %xmm0, %xmm0               # xmm0 = xmm0[0,1,0,1]
	xorl	%eax, %eax
	movdqa	.LCPI1_2(%rip), %xmm1           # xmm1 = [0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0]
	movdqa	.LCPI1_1(%rip), %xmm2           # xmm2 = [2,3]
	movdqa	.LCPI1_8(%rip), %xmm3           # xmm3 = [4,5]
	movdqa	.LCPI1_7(%rip), %xmm4           # xmm4 = [6,7]
	movdqa	.LCPI1_6(%rip), %xmm5           # xmm5 = [8,9]
	movdqa	.LCPI1_5(%rip), %xmm6           # xmm6 = [10,11]
	movdqa	.LCPI1_4(%rip), %xmm7           # xmm7 = [12,13]
	movdqa	.LCPI1_3(%rip), %xmm8           # xmm8 = [14,15]
	movq	432(%rsp), %rdx                 # 8-byte Reload
	movdqa	.LCPI1_9(%rip), %xmm13          # xmm13 = [255,0,0,0,0,0,0,0,255,0,0,0,0,0,0,0]
	movdqa	.LCPI1_10(%rip), %xmm14         # xmm14 = [16,16]
	.p2align	4
.LBB1_48:                               #   Parent Loop BB1_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movdqa	%xmm8, %xmm9
	paddq	%xmm0, %xmm9
	movdqa	%xmm4, %xmm11
	paddq	%xmm0, %xmm11
	movdqa	%xmm2, %xmm12
	paddq	%xmm0, %xmm12
	movdqa	%xmm1, %xmm10
	paddq	%xmm0, %xmm10
	pand	%xmm13, %xmm10
	pand	%xmm13, %xmm12
	packuswb	%xmm12, %xmm10
	movdqa	%xmm3, %xmm12
	paddq	%xmm0, %xmm12
	pand	%xmm13, %xmm12
	pand	%xmm13, %xmm11
	packuswb	%xmm11, %xmm12
	movdqa	%xmm6, %xmm11
	paddq	%xmm0, %xmm11
	packuswb	%xmm12, %xmm10
	movdqa	%xmm5, %xmm12
	paddq	%xmm0, %xmm12
	pand	%xmm13, %xmm12
	pand	%xmm13, %xmm11
	packuswb	%xmm11, %xmm12
	movdqa	%xmm7, %xmm11
	paddq	%xmm0, %xmm11
	pand	%xmm13, %xmm11
	pand	%xmm13, %xmm9
	packuswb	%xmm9, %xmm11
	packuswb	%xmm11, %xmm12
	packuswb	%xmm12, %xmm10
	movdqu	%xmm10, (%rbp,%rax)
	addq	$16, %rax
	paddq	%xmm14, %xmm1
	paddq	%xmm14, %xmm2
	paddq	%xmm14, %xmm3
	paddq	%xmm14, %xmm4
	paddq	%xmm14, %xmm5
	paddq	%xmm14, %xmm6
	paddq	%xmm14, %xmm7
	paddq	%xmm14, %xmm8
	cmpq	%rax, %rdx
	jne	.LBB1_48
# %bb.49:                               #   in Loop: Header=BB1_1 Depth=1
	movq	48(%rsp), %rcx                  # 8-byte Reload
	cmpq	%rdx, %rcx
	movq	424(%rsp), %rdi                 # 8-byte Reload
	je	.LBB1_50
# %bb.58:                               #   in Loop: Header=BB1_1 Depth=1
	testb	$12, %cl
	je	.LBB1_59
# %bb.61:                               #   in Loop: Header=BB1_1 Depth=1
	movd	%ebx, %xmm0
	pshufd	$68, %xmm0, %xmm0               # xmm0 = xmm0[0,1,0,1]
	movq	%rdx, %rax
	movdqa	464(%rsp), %xmm1                # 16-byte Reload
	movdqa	448(%rsp), %xmm2                # 16-byte Reload
	movdqa	.LCPI1_9(%rip), %xmm5           # xmm5 = [255,0,0,0,0,0,0,0,255,0,0,0,0,0,0,0]
	movdqa	.LCPI1_11(%rip), %xmm6          # xmm6 = [4,4]
	.p2align	4
.LBB1_62:                               #   Parent Loop BB1_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movdqa	%xmm2, %xmm3
	paddq	%xmm0, %xmm3
	movdqa	%xmm1, %xmm4
	paddq	%xmm0, %xmm4
	pand	%xmm5, %xmm4
	pand	%xmm5, %xmm3
	packuswb	%xmm3, %xmm4
	packuswb	%xmm4, %xmm4
	packuswb	%xmm4, %xmm4
	movd	%xmm4, (%rbp,%rax)
	addq	$4, %rax
	paddq	%xmm6, %xmm1
	paddq	%xmm6, %xmm2
	cmpq	%rax, %rcx
	jne	.LBB1_62
	jmp	.LBB1_50
.LBB1_59:                               #   in Loop: Header=BB1_1 Depth=1
	movq	400(%rsp), %rax                 # 8-byte Reload
	addl	%ebx, %eax
	movzbl	%al, %eax
	movq	%rbp, %rcx
	addq	%rdx, %rcx
	xorl	%edx, %edx
	.p2align	4
.LBB1_60:                               #   Parent Loop BB1_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leal	(%rax,%rdx), %esi
	movb	%sil, (%rcx,%rdx)
	incq	%rdx
	cmpq	%rdx, %rdi
	jne	.LBB1_60
	.p2align	4
.LBB1_50:                               #   in Loop: Header=BB1_1 Depth=1
	movq	%rbp, 192(%rsp)                 # 8-byte Spill
	cmpl	$1, 176(%rsp)                   # 4-byte Folded Reload
	jne	.LBB1_64
# %bb.51:                               #   in Loop: Header=BB1_1 Depth=1
	xorl	%eax, %eax
	movd	.LCPI1_15(%rip), %xmm1          # xmm1 = [0,1,0,0,0,0,0,0]
	movd	.LCPI1_13(%rip), %xmm2          # xmm2 = [255,0,255,0,0,0,0,0,0,0,0,0,0,0,0,0]
	movdqa	.LCPI1_14(%rip), %xmm3          # xmm3 = [14336,14336,u,u,u,u,u,u]
	jmp	.LBB1_52
	.p2align	4
.LBB1_64:                               #   in Loop: Header=BB1_1 Depth=1
	movzbl	%bl, %ecx
	movq	192(%rsp), %rdx                 # 8-byte Reload
	xorl	%eax, %eax
	movq	416(%rsp), %rdi                 # 8-byte Reload
	movd	.LCPI1_15(%rip), %xmm1          # xmm1 = [0,1,0,0,0,0,0,0]
	movd	.LCPI1_13(%rip), %xmm2          # xmm2 = [255,0,255,0,0,0,0,0,0,0,0,0,0,0,0,0]
	movdqa	.LCPI1_14(%rip), %xmm3          # xmm3 = [14336,14336,u,u,u,u,u,u]
	.p2align	4
.LBB1_65:                               #   Parent Loop BB1_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movd	%ecx, %xmm0
	pshuflw	$0, %xmm0, %xmm0                # xmm0 = xmm0[0,0,0,0,4,5,6,7]
	paddw	%xmm1, %xmm0
	pand	%xmm2, %xmm0
	por	%xmm3, %xmm0
	movd	%xmm0, (%rdx)
	leal	1(%rcx), %esi
	movd	%esi, %xmm0
	pshuflw	$0, %xmm0, %xmm0                # xmm0 = xmm0[0,0,0,0,4,5,6,7]
	paddw	%xmm1, %xmm0
	pand	%xmm2, %xmm0
	por	%xmm3, %xmm0
	movd	%xmm0, 36(%rdx)
	addq	$2, %rax
	addq	$72, %rdx
	addl	$2, %ecx
	cmpq	%rax, %rdi
	jne	.LBB1_65
.LBB1_52:                               #   in Loop: Header=BB1_1 Depth=1
	testb	$1, 176(%rsp)                   # 1-byte Folded Reload
	je	.LBB1_54
# %bb.53:                               #   in Loop: Header=BB1_1 Depth=1
	leaq	(%rax,%rax,8), %rcx
	addl	168(%rsp), %eax                 # 4-byte Folded Reload
	movd	%eax, %xmm0
	pshuflw	$0, %xmm0, %xmm0                # xmm0 = xmm0[0,0,0,0,4,5,6,7]
	paddw	%xmm1, %xmm0
	pand	%xmm2, %xmm0
	por	%xmm3, %xmm0
	movq	192(%rsp), %rax                 # 8-byte Reload
	movd	%xmm0, (%rax,%rcx,4)
.LBB1_54:                               #   in Loop: Header=BB1_1 Depth=1
	movq	96(%rsp), %rdi
.Ltmp231:                               # EH_LABEL
	movq	192(%rsp), %rsi                 # 8-byte Reload
	movq	48(%rsp), %rdx                  # 8-byte Reload
	movl	$1, %ecx
	callq	hipMemcpy@PLT
.Ltmp232:                               # EH_LABEL
# %bb.55:                               #   in Loop: Header=BB1_1 Depth=1
	testl	%eax, %eax
	jne	.LBB1_56
# %bb.68:                               #   in Loop: Header=BB1_1 Depth=1
.Ltmp237:                               # EH_LABEL
	leaq	128(%rsp), %rdi
	movq	56(%rsp), %rax                  # 8-byte Reload
	leaq	(,%rax,4), %rsi
	callq	hipMalloc@PLT
.Ltmp238:                               # EH_LABEL
# %bb.69:                               #   in Loop: Header=BB1_1 Depth=1
	testl	%eax, %eax
	jne	.LBB1_70
# %bb.74:                               #   in Loop: Header=BB1_1 Depth=1
.Ltmp243:                               # EH_LABEL
	leaq	120(%rsp), %rdi
	movq	56(%rsp), %rax                  # 8-byte Reload
	leaq	(,%rax,4), %rsi
	callq	hipMalloc@PLT
.Ltmp244:                               # EH_LABEL
# %bb.75:                               #   in Loop: Header=BB1_1 Depth=1
	testl	%eax, %eax
	jne	.LBB1_84
# %bb.76:                               #   in Loop: Header=BB1_1 Depth=1
	movl	$1, %ebp
	.p2align	4
.LBB1_77:                               #   Parent Loop BB1_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_117 Depth 3
	movq	360(%rsp), %rbx                 # 8-byte Reload
	cmpl	$1, %ebp
	je	.LBB1_80
# %bb.78:                               #   in Loop: Header=BB1_77 Depth=2
	movq	352(%rsp), %rbx                 # 8-byte Reload
	cmpl	$3, %ebp
	je	.LBB1_80
# %bb.79:                               #   in Loop: Header=BB1_77 Depth=2
	movq	344(%rsp), %rbx                 # 8-byte Reload
.LBB1_80:                               #   in Loop: Header=BB1_77 Depth=2
	movq	128(%rsp), %rax
	movq	64(%rsp), %rcx
	movq	96(%rsp), %rdx
	movq	%rax, 144(%rsp)
	movq	%rcx, 136(%rsp)
	movq	%rdx, 104(%rsp)
	movl	80(%rsp), %eax                  # 4-byte Reload
	movl	%eax, 44(%rsp)
	movq	288(%rsp), %rax                 # 8-byte Reload
	movl	%eax, 40(%rsp)
	movq	176(%rsp), %rax                 # 8-byte Reload
	movl	%eax, 36(%rsp)
	movl	20(%rsp), %eax                  # 4-byte Reload
	movl	%eax, 156(%rsp)
	leaq	136(%rsp), %rax
	movq	%rax, 208(%rsp)
	movq	%rax, 216(%rsp)
	leaq	104(%rsp), %rax
	movq	%rax, 224(%rsp)
	leaq	144(%rsp), %rax
	movq	%rax, 232(%rsp)
	leaq	44(%rsp), %rax
	movq	%rax, 240(%rsp)
	leaq	40(%rsp), %rax
	movq	%rax, 248(%rsp)
	leaq	36(%rsp), %rax
	movq	%rax, 256(%rsp)
	leaq	156(%rsp), %rax
	movq	%rax, 264(%rsp)
.Ltmp249:                               # EH_LABEL
	pxor	%xmm0, %xmm0
	movdqu	%xmm0, (%rsp)
	movq	368(%rsp), %rdi                 # 8-byte Reload
	movq	280(%rsp), %rsi                 # 8-byte Reload
	movl	$1, %edx
	movabsq	$4294967328, %rcx               # imm = 0x100000020
	movl	$1, %r8d
	leaq	208(%rsp), %r9
	callq	hipLaunchKernel@PLT
.Ltmp250:                               # EH_LABEL
# %bb.81:                               #   in Loop: Header=BB1_77 Depth=2
	testl	%eax, %eax
	jne	.LBB1_82
# %bb.88:                               #   in Loop: Header=BB1_77 Depth=2
	movq	120(%rsp), %rax
	movq	64(%rsp), %rcx
	movq	96(%rsp), %rdx
	movq	%rax, 144(%rsp)
	movq	%rcx, 136(%rsp)
	movq	%rdx, 104(%rsp)
	movl	80(%rsp), %eax                  # 4-byte Reload
	movl	%eax, 44(%rsp)
	movq	288(%rsp), %rax                 # 8-byte Reload
	movl	%eax, 40(%rsp)
	movq	176(%rsp), %rax                 # 8-byte Reload
	movl	%eax, 36(%rsp)
	movl	20(%rsp), %eax                  # 4-byte Reload
	movl	%eax, 156(%rsp)
	leaq	136(%rsp), %rax
	movq	%rax, 208(%rsp)
	movq	%rax, 216(%rsp)
	leaq	104(%rsp), %rax
	movq	%rax, 224(%rsp)
	leaq	144(%rsp), %rax
	movq	%rax, 232(%rsp)
	leaq	44(%rsp), %rax
	movq	%rax, 240(%rsp)
	leaq	40(%rsp), %rax
	movq	%rax, 248(%rsp)
	leaq	36(%rsp), %rax
	movq	%rax, 256(%rsp)
	leaq	156(%rsp), %rax
	movq	%rax, 264(%rsp)
.Ltmp253:                               # EH_LABEL
	pxor	%xmm0, %xmm0
	movdqu	%xmm0, (%rsp)
	movq	%rbx, %rdi
	movq	280(%rsp), %rsi                 # 8-byte Reload
	movl	$1, %edx
	movabsq	$4294967328, %rcx               # imm = 0x100000020
	movl	$1, %r8d
	leaq	208(%rsp), %r9
	callq	hipLaunchKernel@PLT
.Ltmp254:                               # EH_LABEL
# %bb.89:                               #   in Loop: Header=BB1_77 Depth=2
	testl	%eax, %eax
	jne	.LBB1_90
# %bb.91:                               #   in Loop: Header=BB1_77 Depth=2
.Ltmp259:                               # EH_LABEL
	callq	hipDeviceSynchronize@PLT
.Ltmp260:                               # EH_LABEL
# %bb.92:                               #   in Loop: Header=BB1_77 Depth=2
	testl	%eax, %eax
	jne	.LBB1_93
# %bb.99:                               #   in Loop: Header=BB1_77 Depth=2
.Ltmp265:                               # EH_LABEL
	movq	56(%rsp), %rax                  # 8-byte Reload
	leaq	(,%rax,4), %rbx
	movq	%rbx, %rdi
	callq	_Znwm@PLT
.Ltmp266:                               # EH_LABEL
# %bb.100:                              #   in Loop: Header=BB1_77 Depth=2
	movl	%ebp, 160(%rsp)                 # 4-byte Spill
	movl	$0, (%rax)
	movq	%rax, %rbp
	movq	%rax, %rdi
	addq	$4, %rdi
	xorl	%esi, %esi
	movq	%r12, %rdx
	callq	memset@PLT
.Ltmp268:                               # EH_LABEL
	movq	%rbx, %rdi
	movq	%rbp, 112(%rsp)                 # 8-byte Spill
	callq	_Znwm@PLT
	movq	%r12, %rdx
.Ltmp269:                               # EH_LABEL
# %bb.101:                              #   in Loop: Header=BB1_77 Depth=2
	movq	%rax, %r12
	movl	$0, (%rax)
	movq	%rax, %rdi
	addq	$4, %rdi
	xorl	%esi, %esi
	callq	memset@PLT
	movq	128(%rsp), %rsi
.Ltmp271:                               # EH_LABEL
	movq	%rbp, %rdi
	movq	%rbx, %rdx
	movl	$2, %ecx
	callq	hipMemcpy@PLT
.Ltmp272:                               # EH_LABEL
# %bb.102:                              #   in Loop: Header=BB1_77 Depth=2
	testl	%eax, %eax
	jne	.LBB1_103
# %bb.109:                              #   in Loop: Header=BB1_77 Depth=2
	movq	120(%rsp), %rsi
.Ltmp277:                               # EH_LABEL
	movq	%r12, %rdi
	movq	56(%rsp), %rax                  # 8-byte Reload
	leaq	(,%rax,4), %rdx
	movl	$2, %ecx
	callq	hipMemcpy@PLT
.Ltmp278:                               # EH_LABEL
# %bb.110:                              #   in Loop: Header=BB1_77 Depth=2
	testl	%eax, %eax
	jne	.LBB1_111
# %bb.115:                              #   in Loop: Header=BB1_77 Depth=2
	movq	112(%rsp), %rdi                 # 8-byte Reload
	movq	%r12, %rsi
	movq	56(%rsp), %rax                  # 8-byte Reload
	leaq	(,%rax,4), %rdx
	callq	bcmp@PLT
	movl	%eax, 200(%rsp)                 # 4-byte Spill
	testl	%eax, %eax
	je	.LBB1_119
# %bb.116:                              #   in Loop: Header=BB1_77 Depth=2
	xorl	%ebp, %ebp
	movq	112(%rsp), %rax                 # 8-byte Reload
	.p2align	4
.LBB1_117:                              #   Parent Loop BB1_1 Depth=1
                                        #     Parent Loop BB1_77 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movss	(%rax,%rbp,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
	ucomiss	(%r12,%rbp,4), %xmm0
	jne	.LBB1_120
	jp	.LBB1_120
# %bb.118:                              #   in Loop: Header=BB1_117 Depth=3
	incq	%rbp
	cmpq	%rbp, 56(%rsp)                  # 8-byte Folded Reload
	jne	.LBB1_117
.LBB1_119:                              #   in Loop: Header=BB1_77 Depth=2
	xorl	%ebp, %ebp
.LBB1_120:                              #   in Loop: Header=BB1_77 Depth=2
	movl	$4, %esi
	leaq	208(%rsp), %rdi
	leaq	.L.str.24(%rip), %rdx
	movl	160(%rsp), %ecx                 # 4-byte Reload
	xorl	%eax, %eax
	callq	snprintf@PLT
.Ltmp283:                               # EH_LABEL
	movl	$12, %edx
	movq	272(%rsp), %rdi                 # 8-byte Reload
	leaq	.L.str.25(%rip), %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp284:                               # EH_LABEL
# %bb.121:                              #   in Loop: Header=BB1_77 Depth=2
.Ltmp285:                               # EH_LABEL
	movq	272(%rsp), %rdi                 # 8-byte Reload
	movq	168(%rsp), %rsi                 # 8-byte Reload
                                        # kill: def $esi killed $esi killed $rsi
	callq	_ZNSolsEi@PLT
.Ltmp286:                               # EH_LABEL
# %bb.122:                              #   in Loop: Header=BB1_77 Depth=2
.Ltmp287:                               # EH_LABEL
	movq	%rax, %rbx
	movl	$1, %edx
	movq	%rax, %rdi
	leaq	.L.str.26(%rip), %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp288:                               # EH_LABEL
# %bb.123:                              #   in Loop: Header=BB1_77 Depth=2
	leaq	208(%rsp), %rdi
	callq	strlen@PLT
.Ltmp289:                               # EH_LABEL
	movq	%rbx, %rdi
	leaq	208(%rsp), %rsi
	movq	%rax, %rdx
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp290:                               # EH_LABEL
# %bb.124:                              #   in Loop: Header=BB1_77 Depth=2
.Ltmp291:                               # EH_LABEL
	movl	$7, %edx
	movq	%rbx, %rdi
	leaq	.L.str.27(%rip), %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp292:                               # EH_LABEL
# %bb.125:                              #   in Loop: Header=BB1_77 Depth=2
.Ltmp293:                               # EH_LABEL
	movq	%rbx, %rdi
	movl	76(%rsp), %esi                  # 4-byte Reload
	callq	_ZNSolsEi@PLT
.Ltmp294:                               # EH_LABEL
# %bb.126:                              #   in Loop: Header=BB1_77 Depth=2
.Ltmp295:                               # EH_LABEL
	movq	%rax, %rbx
	movl	$4, %edx
	movq	%rax, %rdi
	leaq	.L.str.28(%rip), %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp296:                               # EH_LABEL
# %bb.127:                              #   in Loop: Header=BB1_77 Depth=2
	xorl	%esi, %esi
	cmpl	$0, 200(%rsp)                   # 4-byte Folded Reload
	sete	%sil
.Ltmp297:                               # EH_LABEL
	movq	%rbx, %rdi
	callq	_ZNSolsEi@PLT
.Ltmp298:                               # EH_LABEL
# %bb.128:                              #   in Loop: Header=BB1_77 Depth=2
.Ltmp299:                               # EH_LABEL
	movq	%rax, %rbx
	movl	$12, %edx
	movq	%rax, %rdi
	leaq	.L.str.29(%rip), %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp300:                               # EH_LABEL
# %bb.129:                              #   in Loop: Header=BB1_77 Depth=2
.Ltmp301:                               # EH_LABEL
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	_ZNSo9_M_insertImEERSoT_@PLT
.Ltmp302:                               # EH_LABEL
# %bb.130:                              #   in Loop: Header=BB1_77 Depth=2
.Ltmp303:                               # EH_LABEL
	movq	%rax, %rbx
	movl	$3, %edx
	movq	%rax, %rdi
	leaq	.L.str.30(%rip), %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp304:                               # EH_LABEL
# %bb.131:                              #   in Loop: Header=BB1_77 Depth=2
.Ltmp305:                               # EH_LABEL
	movq	%rbx, %rdi
	movl	20(%rsp), %esi                  # 4-byte Reload
	callq	_ZNSolsEi@PLT
.Ltmp306:                               # EH_LABEL
# %bb.132:                              #   in Loop: Header=BB1_77 Depth=2
.Ltmp307:                               # EH_LABEL
	movl	$1, %edx
	movq	%rax, %rdi
	leaq	.L.str.18(%rip), %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp308:                               # EH_LABEL
# %bb.133:                              #   in Loop: Header=BB1_77 Depth=2
	cmpl	$0, 200(%rsp)                   # 4-byte Folded Reload
	leaq	.L.str.33(%rip), %r8
	leaq	.L.str.32(%rip), %rax
	cmoveq	%rax, %r8
	leaq	.L.str.31(%rip), %rdi
	movq	168(%rsp), %rsi                 # 8-byte Reload
                                        # kill: def $esi killed $esi killed $rsi
	leaq	208(%rsp), %rdx
	movl	76(%rsp), %ecx                  # 4-byte Reload
	movl	20(%rsp), %r9d                  # 4-byte Reload
	xorl	%eax, %eax
	callq	printf@PLT
	movq	%r12, %rdi
	movq	56(%rsp), %rax                  # 8-byte Reload
	leaq	(,%rax,4), %rbx
	movq	%rbx, %rsi
	callq	_ZdlPvm@PLT
	movq	112(%rsp), %rdi                 # 8-byte Reload
	movq	%rbx, %rsi
	callq	_ZdlPvm@PLT
	movl	160(%rsp), %ebp                 # 4-byte Reload
	incl	%ebp
	cmpl	$4, %ebp
	movq	296(%rsp), %r12                 # 8-byte Reload
	jne	.LBB1_77
# %bb.134:                              #   in Loop: Header=BB1_1 Depth=1
	movq	64(%rsp), %rdi
.Ltmp310:                               # EH_LABEL
	callq	hipFree@PLT
.Ltmp311:                               # EH_LABEL
# %bb.135:                              #   in Loop: Header=BB1_1 Depth=1
	movq	96(%rsp), %rdi
.Ltmp312:                               # EH_LABEL
	callq	hipFree@PLT
.Ltmp313:                               # EH_LABEL
# %bb.136:                              #   in Loop: Header=BB1_1 Depth=1
	movq	128(%rsp), %rdi
.Ltmp314:                               # EH_LABEL
	callq	hipFree@PLT
.Ltmp315:                               # EH_LABEL
# %bb.137:                              #   in Loop: Header=BB1_1 Depth=1
	movq	120(%rsp), %rdi
.Ltmp316:                               # EH_LABEL
	callq	hipFree@PLT
.Ltmp317:                               # EH_LABEL
# %bb.138:                              #   in Loop: Header=BB1_1 Depth=1
	movq	192(%rsp), %rdi                 # 8-byte Reload
	movq	48(%rsp), %rsi                  # 8-byte Reload
	callq	_ZdlPvm@PLT
	movq	88(%rsp), %rdi                  # 8-byte Reload
	movq	24(%rsp), %rbx                  # 8-byte Reload
	movq	%rbx, %rsi
	callq	_ZdlPvm@PLT
	movq	%rbx, %rdi
	movq	440(%rsp), %rax                 # 8-byte Reload
	addq	$4, %rax
	cmpq	$16, %rax
	jne	.LBB1_1
# %bb.139:
	xorl	%ecx, %ecx
	.p2align	4
.LBB1_140:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_141 Depth 2
                                        #     Child Loop BB1_143 Depth 2
                                        #       Child Loop BB1_144 Depth 3
                                        #         Child Loop BB1_145 Depth 4
                                        #     Child Loop BB1_176 Depth 2
                                        #     Child Loop BB1_178 Depth 2
                                        #     Child Loop BB1_198 Depth 2
                                        #       Child Loop BB1_234 Depth 3
	leaq	.Lconstinit(%rip), %rax
	movq	%rcx, 88(%rsp)                  # 8-byte Spill
	movl	(%rcx,%rax), %ebx
	movq	%rdi, %r15
	callq	_Znwm@PLT
	movq	%rax, %r12
	movb	$0, (%rax)
	leaq	1(%rax), %rdi
	xorl	%esi, %esi
	movq	336(%rsp), %rdx                 # 8-byte Reload
	callq	memset@PLT
	movq	%rbx, 112(%rsp)                 # 8-byte Spill
	movl	%ebx, %edi
	callq	srand@PLT
	xorl	%ebx, %ebx
	.p2align	4
.LBB1_141:                              #   Parent Loop BB1_140 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	callq	rand@PLT
	movb	%al, (%r12,%rbx)
	incq	%rbx
	cmpq	%rbx, %r15
	jne	.LBB1_141
# %bb.142:                              #   in Loop: Header=BB1_140 Depth=1
	movq	%r12, 160(%rsp)                 # 8-byte Spill
	movq	%r12, %rbx
	addq	$64, %rbx
	xorl	%r12d, %r12d
	.p2align	4
.LBB1_143:                              #   Parent Loop BB1_140 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_144 Depth 3
                                        #         Child Loop BB1_145 Depth 4
	movq	%rbx, %r13
	xorl	%ebp, %ebp
	.p2align	4
.LBB1_144:                              #   Parent Loop BB1_140 Depth=1
                                        #     Parent Loop BB1_143 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB1_145 Depth 4
	xorl	%r15d, %r15d
	.p2align	4
.LBB1_145:                              #   Parent Loop BB1_140 Depth=1
                                        #     Parent Loop BB1_143 Depth=2
                                        #       Parent Loop BB1_144 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	callq	rand@PLT
                                        # kill: def $eax killed $eax def $rax
	leal	511(%rax), %ecx
	testl	%eax, %eax
	cmovnsl	%eax, %ecx
	andl	$65024, %ecx                    # imm = 0xFE00
	negl	%ecx
	addl	%ecx, %eax
	addl	$14336, %eax                    # imm = 0x3800
	movw	%ax, (%r13,%r15)
	addq	$66, %r15
	cmpq	%r15, %r14
	jne	.LBB1_145
# %bb.146:                              #   in Loop: Header=BB1_144 Depth=3
	incq	%rbp
	addq	%r14, %r13
	cmpq	56(%rsp), %rbp                  # 8-byte Folded Reload
	jne	.LBB1_144
# %bb.147:                              #   in Loop: Header=BB1_143 Depth=2
	incq	%r12
	addq	384(%rsp), %rbx                 # 8-byte Folded Reload
	cmpq	376(%rsp), %r12                 # 8-byte Folded Reload
	jne	.LBB1_143
# %bb.148:                              #   in Loop: Header=BB1_140 Depth=1
.Ltmp319:                               # EH_LABEL
	leaq	104(%rsp), %rdi
	movq	24(%rsp), %rsi                  # 8-byte Reload
	callq	hipMalloc@PLT
.Ltmp320:                               # EH_LABEL
# %bb.149:                              #   in Loop: Header=BB1_140 Depth=1
	testl	%eax, %eax
	movq	296(%rsp), %r12                 # 8-byte Reload
	jne	.LBB1_150
# %bb.162:                              #   in Loop: Header=BB1_140 Depth=1
	movq	104(%rsp), %rdi
.Ltmp325:                               # EH_LABEL
	movq	160(%rsp), %rsi                 # 8-byte Reload
	movq	24(%rsp), %rdx                  # 8-byte Reload
	movl	$1, %ecx
	callq	hipMemcpy@PLT
.Ltmp326:                               # EH_LABEL
# %bb.163:                              #   in Loop: Header=BB1_140 Depth=1
	testl	%eax, %eax
	jne	.LBB1_164
# %bb.168:                              #   in Loop: Header=BB1_140 Depth=1
.Ltmp331:                               # EH_LABEL
	leaq	64(%rsp), %rdi
	movq	48(%rsp), %rsi                  # 8-byte Reload
	callq	hipMalloc@PLT
.Ltmp332:                               # EH_LABEL
# %bb.169:                              #   in Loop: Header=BB1_140 Depth=1
	testl	%eax, %eax
	jne	.LBB1_170
# %bb.174:                              #   in Loop: Header=BB1_140 Depth=1
.Ltmp337:                               # EH_LABEL
	movq	48(%rsp), %rdi                  # 8-byte Reload
	callq	_Znwm@PLT
.Ltmp338:                               # EH_LABEL
# %bb.175:                              #   in Loop: Header=BB1_140 Depth=1
	movq	%rax, %r13
	movb	$0, (%rax)
	movq	%rax, %rdi
	incq	%rdi
	xorl	%esi, %esi
	movq	328(%rsp), %rdx                 # 8-byte Reload
	callq	memset@PLT
	xorl	%ebx, %ebx
	movq	48(%rsp), %r15                  # 8-byte Reload
	.p2align	4
.LBB1_176:                              #   Parent Loop BB1_140 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	callq	rand@PLT
	movb	%al, (%r13,%rbx)
	incq	%rbx
	cmpq	%rbx, %r15
	jne	.LBB1_176
# %bb.177:                              #   in Loop: Header=BB1_140 Depth=1
	xorl	%ebx, %ebx
	.p2align	4
.LBB1_178:                              #   Parent Loop BB1_140 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	callq	rand@PLT
                                        # kill: def $eax killed $eax def $rax
	leal	255(%rax), %ecx
	testl	%eax, %eax
	cmovnsl	%eax, %ecx
	andl	$65280, %ecx                    # imm = 0xFF00
	negl	%ecx
	leal	(%rax,%rcx), %ebp
	addl	$14336, %ebp                    # imm = 0x3800
	callq	rand@PLT
                                        # kill: def $eax killed $eax def $rax
	leal	255(%rax), %ecx
	testl	%eax, %eax
	cmovnsl	%eax, %ecx
	andl	$65280, %ecx                    # imm = 0xFF00
	negl	%ecx
	addl	%ecx, %eax
	addl	$14336, %eax                    # imm = 0x3800
	movw	%bp, (%r13,%rbx)
	movw	%ax, 2(%r13,%rbx)
	addq	$36, %rbx
	cmpq	%rbx, %r15
	jne	.LBB1_178
# %bb.179:                              #   in Loop: Header=BB1_140 Depth=1
	movq	64(%rsp), %rdi
.Ltmp340:                               # EH_LABEL
	movq	%r13, 200(%rsp)                 # 8-byte Spill
	movq	%r13, %rsi
	movq	%r15, %rdx
	movl	$1, %ecx
	callq	hipMemcpy@PLT
.Ltmp341:                               # EH_LABEL
# %bb.180:                              #   in Loop: Header=BB1_140 Depth=1
	testl	%eax, %eax
	movq	56(%rsp), %rcx                  # 8-byte Reload
	leaq	(,%rcx,4), %r15
	jne	.LBB1_181
# %bb.185:                              #   in Loop: Header=BB1_140 Depth=1
.Ltmp346:                               # EH_LABEL
	leaq	96(%rsp), %rdi
	movq	%r15, %rsi
	callq	hipMalloc@PLT
.Ltmp347:                               # EH_LABEL
# %bb.186:                              #   in Loop: Header=BB1_140 Depth=1
	testl	%eax, %eax
	jne	.LBB1_187
# %bb.191:                              #   in Loop: Header=BB1_140 Depth=1
.Ltmp352:                               # EH_LABEL
	leaq	128(%rsp), %rdi
	movq	%r15, %rsi
	callq	hipMalloc@PLT
.Ltmp353:                               # EH_LABEL
# %bb.192:                              #   in Loop: Header=BB1_140 Depth=1
	testl	%eax, %eax
	jne	.LBB1_193
# %bb.197:                              #   in Loop: Header=BB1_140 Depth=1
	movl	$1, %r13d
	.p2align	4
.LBB1_198:                              #   Parent Loop BB1_140 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_234 Depth 3
	movq	360(%rsp), %rbx                 # 8-byte Reload
	cmpl	$1, %r13d
	je	.LBB1_201
# %bb.199:                              #   in Loop: Header=BB1_198 Depth=2
	movq	344(%rsp), %rbx                 # 8-byte Reload
	cmpl	$3, %r13d
	jne	.LBB1_201
# %bb.200:                              #   in Loop: Header=BB1_198 Depth=2
	movq	352(%rsp), %rbx                 # 8-byte Reload
.LBB1_201:                              #   in Loop: Header=BB1_198 Depth=2
	movq	96(%rsp), %rax
	movq	104(%rsp), %rcx
	movq	64(%rsp), %rdx
	movq	%rax, 304(%rsp)
	movq	%rcx, 144(%rsp)
	movq	%rdx, 136(%rsp)
	movl	80(%rsp), %eax                  # 4-byte Reload
	movl	%eax, 120(%rsp)
	movq	288(%rsp), %rax                 # 8-byte Reload
	movl	%eax, 44(%rsp)
	movq	176(%rsp), %rax                 # 8-byte Reload
	movl	%eax, 40(%rsp)
	movl	20(%rsp), %eax                  # 4-byte Reload
	movl	%eax, 36(%rsp)
	leaq	144(%rsp), %rax
	movq	%rax, 208(%rsp)
	movq	%rax, 216(%rsp)
	leaq	136(%rsp), %rax
	movq	%rax, 224(%rsp)
	leaq	304(%rsp), %rax
	movq	%rax, 232(%rsp)
	leaq	120(%rsp), %rax
	movq	%rax, 240(%rsp)
	leaq	44(%rsp), %rax
	movq	%rax, 248(%rsp)
	leaq	40(%rsp), %rax
	movq	%rax, 256(%rsp)
	leaq	36(%rsp), %rax
	movq	%rax, 264(%rsp)
.Ltmp358:                               # EH_LABEL
	pxor	%xmm0, %xmm0
	movdqu	%xmm0, (%rsp)
	movq	368(%rsp), %rdi                 # 8-byte Reload
	movq	280(%rsp), %rsi                 # 8-byte Reload
	movl	$1, %edx
	movabsq	$4294967328, %rcx               # imm = 0x100000020
	movl	$1, %r8d
	leaq	208(%rsp), %r9
	callq	hipLaunchKernel@PLT
.Ltmp359:                               # EH_LABEL
# %bb.202:                              #   in Loop: Header=BB1_198 Depth=2
	testl	%eax, %eax
	jne	.LBB1_203
# %bb.205:                              #   in Loop: Header=BB1_198 Depth=2
	movq	128(%rsp), %rax
	movq	104(%rsp), %rcx
	movq	64(%rsp), %rdx
	movq	%rax, 304(%rsp)
	movq	%rcx, 144(%rsp)
	movq	%rdx, 136(%rsp)
	movl	80(%rsp), %eax                  # 4-byte Reload
	movl	%eax, 120(%rsp)
	movq	288(%rsp), %rax                 # 8-byte Reload
	movl	%eax, 44(%rsp)
	movq	176(%rsp), %rax                 # 8-byte Reload
	movl	%eax, 40(%rsp)
	movl	20(%rsp), %eax                  # 4-byte Reload
	movl	%eax, 36(%rsp)
	leaq	144(%rsp), %rax
	movq	%rax, 208(%rsp)
	movq	%rax, 216(%rsp)
	leaq	136(%rsp), %rax
	movq	%rax, 224(%rsp)
	leaq	304(%rsp), %rax
	movq	%rax, 232(%rsp)
	leaq	120(%rsp), %rax
	movq	%rax, 240(%rsp)
	leaq	44(%rsp), %rax
	movq	%rax, 248(%rsp)
	leaq	40(%rsp), %rax
	movq	%rax, 256(%rsp)
	leaq	36(%rsp), %rax
	movq	%rax, 264(%rsp)
.Ltmp362:                               # EH_LABEL
	pxor	%xmm0, %xmm0
	movdqu	%xmm0, (%rsp)
	movq	%rbx, %rdi
	movq	280(%rsp), %rsi                 # 8-byte Reload
	movl	$1, %edx
	movabsq	$4294967328, %rcx               # imm = 0x100000020
	movl	$1, %r8d
	leaq	208(%rsp), %r9
	callq	hipLaunchKernel@PLT
.Ltmp363:                               # EH_LABEL
# %bb.206:                              #   in Loop: Header=BB1_198 Depth=2
	testl	%eax, %eax
	jne	.LBB1_207
# %bb.208:                              #   in Loop: Header=BB1_198 Depth=2
.Ltmp368:                               # EH_LABEL
	callq	hipDeviceSynchronize@PLT
.Ltmp369:                               # EH_LABEL
# %bb.209:                              #   in Loop: Header=BB1_198 Depth=2
	testl	%eax, %eax
	jne	.LBB1_210
# %bb.216:                              #   in Loop: Header=BB1_198 Depth=2
.Ltmp374:                               # EH_LABEL
	movq	%r15, %rdi
	callq	_Znwm@PLT
.Ltmp375:                               # EH_LABEL
# %bb.217:                              #   in Loop: Header=BB1_198 Depth=2
	movl	$0, (%rax)
	movq	%rax, %rbx
	movq	%rax, %rdi
	addq	$4, %rdi
	xorl	%esi, %esi
	movq	%r12, %rdx
	callq	memset@PLT
.Ltmp377:                               # EH_LABEL
	movq	%r15, %rdi
	movq	%rbx, 184(%rsp)                 # 8-byte Spill
	callq	_Znwm@PLT
	movq	%r12, %rdx
.Ltmp378:                               # EH_LABEL
# %bb.218:                              #   in Loop: Header=BB1_198 Depth=2
	movq	%rax, %r12
	movl	$0, (%rax)
	movq	%rax, %rdi
	addq	$4, %rdi
	xorl	%esi, %esi
	callq	memset@PLT
	movq	96(%rsp), %rsi
.Ltmp380:                               # EH_LABEL
	movq	%rbx, %rdi
	movq	%r15, %rdx
	movl	$2, %ecx
	callq	hipMemcpy@PLT
.Ltmp381:                               # EH_LABEL
# %bb.219:                              #   in Loop: Header=BB1_198 Depth=2
	testl	%eax, %eax
	jne	.LBB1_220
# %bb.226:                              #   in Loop: Header=BB1_198 Depth=2
	movq	128(%rsp), %rsi
.Ltmp386:                               # EH_LABEL
	movq	%r12, %rdi
	movq	%r15, %rdx
	movl	$2, %ecx
	callq	hipMemcpy@PLT
.Ltmp387:                               # EH_LABEL
# %bb.227:                              #   in Loop: Header=BB1_198 Depth=2
	testl	%eax, %eax
	jne	.LBB1_228
# %bb.232:                              #   in Loop: Header=BB1_198 Depth=2
	movq	184(%rsp), %rdi                 # 8-byte Reload
	movq	%r12, %rsi
	movq	%r15, %rdx
	callq	bcmp@PLT
	movl	%eax, 84(%rsp)                  # 4-byte Spill
	testl	%eax, %eax
	je	.LBB1_236
# %bb.233:                              #   in Loop: Header=BB1_198 Depth=2
	xorl	%ebp, %ebp
	movq	184(%rsp), %rax                 # 8-byte Reload
	.p2align	4
.LBB1_234:                              #   Parent Loop BB1_140 Depth=1
                                        #     Parent Loop BB1_198 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movss	(%rax,%rbp,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
	ucomiss	(%r12,%rbp,4), %xmm0
	jne	.LBB1_237
	jp	.LBB1_237
# %bb.235:                              #   in Loop: Header=BB1_234 Depth=3
	incq	%rbp
	cmpq	%rbp, 56(%rsp)                  # 8-byte Folded Reload
	jne	.LBB1_234
.LBB1_236:                              #   in Loop: Header=BB1_198 Depth=2
	xorl	%ebp, %ebp
.LBB1_237:                              #   in Loop: Header=BB1_198 Depth=2
	movl	$4, %esi
	leaq	208(%rsp), %rdi
	leaq	.L.str.24(%rip), %rdx
	movl	%r13d, 168(%rsp)                # 4-byte Spill
	movl	%r13d, %ecx
	xorl	%eax, %eax
	callq	snprintf@PLT
.Ltmp392:                               # EH_LABEL
	movl	$5, %edx
	movq	272(%rsp), %rdi                 # 8-byte Reload
	leaq	.L.str.34(%rip), %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp393:                               # EH_LABEL
# %bb.238:                              #   in Loop: Header=BB1_198 Depth=2
.Ltmp394:                               # EH_LABEL
	movq	272(%rsp), %rdi                 # 8-byte Reload
	movq	112(%rsp), %rsi                 # 8-byte Reload
	callq	_ZNSo9_M_insertImEERSoT_@PLT
.Ltmp395:                               # EH_LABEL
# %bb.239:                              #   in Loop: Header=BB1_198 Depth=2
.Ltmp396:                               # EH_LABEL
	movq	%rax, %rbx
	movl	$1, %edx
	movq	%rax, %rdi
	leaq	.L.str.26(%rip), %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp397:                               # EH_LABEL
# %bb.240:                              #   in Loop: Header=BB1_198 Depth=2
	movq	%r15, %r13
	leaq	208(%rsp), %r15
	movq	%r15, %rdi
	callq	strlen@PLT
.Ltmp398:                               # EH_LABEL
	movq	%rbx, %rdi
	movq	%r15, %rsi
	movq	%r13, %r15
	movq	%rax, %rdx
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp399:                               # EH_LABEL
# %bb.241:                              #   in Loop: Header=BB1_198 Depth=2
.Ltmp400:                               # EH_LABEL
	movl	$7, %edx
	movq	%rbx, %rdi
	leaq	.L.str.27(%rip), %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp401:                               # EH_LABEL
# %bb.242:                              #   in Loop: Header=BB1_198 Depth=2
.Ltmp402:                               # EH_LABEL
	movq	%rbx, %rdi
	movl	76(%rsp), %esi                  # 4-byte Reload
	callq	_ZNSolsEi@PLT
.Ltmp403:                               # EH_LABEL
# %bb.243:                              #   in Loop: Header=BB1_198 Depth=2
.Ltmp404:                               # EH_LABEL
	movq	%rax, %rbx
	movl	$4, %edx
	movq	%rax, %rdi
	leaq	.L.str.28(%rip), %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp405:                               # EH_LABEL
# %bb.244:                              #   in Loop: Header=BB1_198 Depth=2
	xorl	%esi, %esi
	cmpl	$0, 84(%rsp)                    # 4-byte Folded Reload
	sete	%sil
.Ltmp406:                               # EH_LABEL
	movq	%rbx, %rdi
	callq	_ZNSolsEi@PLT
.Ltmp407:                               # EH_LABEL
# %bb.245:                              #   in Loop: Header=BB1_198 Depth=2
.Ltmp408:                               # EH_LABEL
	movq	%rax, %rbx
	movl	$12, %edx
	movq	%rax, %rdi
	leaq	.L.str.29(%rip), %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp409:                               # EH_LABEL
# %bb.246:                              #   in Loop: Header=BB1_198 Depth=2
.Ltmp410:                               # EH_LABEL
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	_ZNSo9_M_insertImEERSoT_@PLT
.Ltmp411:                               # EH_LABEL
# %bb.247:                              #   in Loop: Header=BB1_198 Depth=2
.Ltmp412:                               # EH_LABEL
	movq	%rax, %rbx
	movl	$3, %edx
	movq	%rax, %rdi
	leaq	.L.str.30(%rip), %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp413:                               # EH_LABEL
# %bb.248:                              #   in Loop: Header=BB1_198 Depth=2
.Ltmp414:                               # EH_LABEL
	movq	%rbx, %rdi
	movl	20(%rsp), %esi                  # 4-byte Reload
	callq	_ZNSolsEi@PLT
.Ltmp415:                               # EH_LABEL
# %bb.249:                              #   in Loop: Header=BB1_198 Depth=2
.Ltmp416:                               # EH_LABEL
	movl	$1, %edx
	movq	%rax, %rdi
	leaq	.L.str.18(%rip), %rsi
	callq	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.Ltmp417:                               # EH_LABEL
# %bb.250:                              #   in Loop: Header=BB1_198 Depth=2
	cmpl	$0, 84(%rsp)                    # 4-byte Folded Reload
	leaq	.L.str.33(%rip), %r8
	leaq	.L.str.32(%rip), %rax
	cmoveq	%rax, %r8
	leaq	.L.str.35(%rip), %rdi
	movq	112(%rsp), %rsi                 # 8-byte Reload
                                        # kill: def $esi killed $esi killed $rsi
	leaq	208(%rsp), %rdx
	movl	76(%rsp), %ecx                  # 4-byte Reload
	movl	20(%rsp), %r9d                  # 4-byte Reload
	xorl	%eax, %eax
	callq	printf@PLT
	movq	%r12, %rdi
	movq	%r15, %rsi
	callq	_ZdlPvm@PLT
	movq	184(%rsp), %rdi                 # 8-byte Reload
	movq	%r15, %rsi
	callq	_ZdlPvm@PLT
	movl	168(%rsp), %r13d                # 4-byte Reload
	incl	%r13d
	cmpl	$4, %r13d
	movq	296(%rsp), %r12                 # 8-byte Reload
	jne	.LBB1_198
# %bb.251:                              #   in Loop: Header=BB1_140 Depth=1
	movq	104(%rsp), %rdi
.Ltmp419:                               # EH_LABEL
	callq	hipFree@PLT
.Ltmp420:                               # EH_LABEL
# %bb.252:                              #   in Loop: Header=BB1_140 Depth=1
	movq	64(%rsp), %rdi
.Ltmp421:                               # EH_LABEL
	callq	hipFree@PLT
.Ltmp422:                               # EH_LABEL
# %bb.253:                              #   in Loop: Header=BB1_140 Depth=1
	movq	96(%rsp), %rdi
.Ltmp423:                               # EH_LABEL
	callq	hipFree@PLT
.Ltmp424:                               # EH_LABEL
# %bb.254:                              #   in Loop: Header=BB1_140 Depth=1
	movq	128(%rsp), %rdi
.Ltmp425:                               # EH_LABEL
	callq	hipFree@PLT
.Ltmp426:                               # EH_LABEL
# %bb.255:                              #   in Loop: Header=BB1_140 Depth=1
	movq	200(%rsp), %rdi                 # 8-byte Reload
	movq	48(%rsp), %rsi                  # 8-byte Reload
	callq	_ZdlPvm@PLT
	movq	160(%rsp), %rdi                 # 8-byte Reload
	movq	24(%rsp), %rbx                  # 8-byte Reload
	movq	%rbx, %rsi
	callq	_ZdlPvm@PLT
	movq	%rbx, %rdi
	movq	88(%rsp), %rcx                  # 8-byte Reload
	addq	$4, %rcx
	cmpq	$24, %rcx
	jne	.LBB1_140
# %bb.256:
	addq	$488, %rsp                      # imm = 0x1E8
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.LBB1_90:
	.cfi_def_cfa_offset 544
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp256:                               # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp257:                               # EH_LABEL
	jmp	.LBB1_83
.LBB1_93:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp262:                               # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp263:                               # EH_LABEL
# %bb.94:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$684, %r8d                      # imm = 0x2AC
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB1_111:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp280:                               # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp281:                               # EH_LABEL
# %bb.112:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$688, %r8d                      # imm = 0x2B0
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB1_103:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp274:                               # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp275:                               # EH_LABEL
# %bb.104:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$687, %r8d                      # imm = 0x2AF
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB1_82:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp251:                               # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp252:                               # EH_LABEL
.LBB1_83:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$676, %r8d                      # imm = 0x2A4
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB1_207:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp365:                               # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp366:                               # EH_LABEL
	jmp	.LBB1_204
.LBB1_210:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp371:                               # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp372:                               # EH_LABEL
# %bb.211:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$761, %r8d                      # imm = 0x2F9
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB1_220:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp383:                               # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp384:                               # EH_LABEL
# %bb.221:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$764, %r8d                      # imm = 0x2FC
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB1_228:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp389:                               # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp390:                               # EH_LABEL
# %bb.229:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$765, %r8d                      # imm = 0x2FD
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB1_203:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp360:                               # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp361:                               # EH_LABEL
.LBB1_204:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$753, %r8d                      # imm = 0x2F1
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB1_70:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp240:                               # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp241:                               # EH_LABEL
# %bb.71:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$662, %r8d                      # imm = 0x296
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB1_56:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp234:                               # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp235:                               # EH_LABEL
# %bb.57:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$660, %r8d                      # imm = 0x294
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB1_42:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp225:                               # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp226:                               # EH_LABEL
# %bb.43:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$650, %r8d                      # imm = 0x28A
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB1_36:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp219:                               # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp220:                               # EH_LABEL
# %bb.37:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$646, %r8d                      # imm = 0x286
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB1_27:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp213:                               # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp214:                               # EH_LABEL
# %bb.28:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$645, %r8d                      # imm = 0x285
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB1_84:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp246:                               # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp247:                               # EH_LABEL
# %bb.85:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$663, %r8d                      # imm = 0x297
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB1_187:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp349:                               # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp350:                               # EH_LABEL
# %bb.188:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$739, %r8d                      # imm = 0x2E3
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB1_181:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp343:                               # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp344:                               # EH_LABEL
# %bb.182:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$737, %r8d                      # imm = 0x2E1
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB1_170:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp334:                               # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp335:                               # EH_LABEL
# %bb.171:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$727, %r8d                      # imm = 0x2D7
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB1_164:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp328:                               # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp329:                               # EH_LABEL
# %bb.165:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$723, %r8d                      # imm = 0x2D3
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB1_150:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp322:                               # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp323:                               # EH_LABEL
# %bb.151:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$722, %r8d                      # imm = 0x2D2
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB1_193:
	movq	stderr@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbx
.Ltmp355:                               # EH_LABEL
	movl	%eax, %edi
	callq	hipGetErrorString@PLT
.Ltmp356:                               # EH_LABEL
# %bb.194:
	leaq	.L.str.22(%rip), %rsi
	leaq	.L.str.23(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movl	$740, %r8d                      # imm = 0x2E4
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB1_195:
.Ltmp357:                               # EH_LABEL
	jmp	.LBB1_261
.LBB1_161:
.Ltmp324:                               # EH_LABEL
	movq	%rax, %r14
	jmp	.LBB1_263
.LBB1_167:
.Ltmp330:                               # EH_LABEL
	movq	%rax, %r14
	jmp	.LBB1_263
.LBB1_173:
.Ltmp336:                               # EH_LABEL
	movq	%rax, %r14
	jmp	.LBB1_263
.LBB1_184:
.Ltmp345:                               # EH_LABEL
	jmp	.LBB1_261
.LBB1_190:
.Ltmp351:                               # EH_LABEL
	jmp	.LBB1_261
.LBB1_86:
.Ltmp248:                               # EH_LABEL
	jmp	.LBB1_156
.LBB1_33:
.Ltmp215:                               # EH_LABEL
	movq	%rax, %r14
	jmp	.LBB1_158
.LBB1_39:
.Ltmp221:                               # EH_LABEL
	movq	%rax, %r14
	jmp	.LBB1_158
.LBB1_45:
.Ltmp227:                               # EH_LABEL
	movq	%rax, %r14
	jmp	.LBB1_158
.LBB1_67:
.Ltmp236:                               # EH_LABEL
	jmp	.LBB1_156
.LBB1_73:
.Ltmp242:                               # EH_LABEL
	jmp	.LBB1_156
.LBB1_166:
.Ltmp327:                               # EH_LABEL
	movq	%rax, %r14
	jmp	.LBB1_263
.LBB1_172:
.Ltmp333:                               # EH_LABEL
	movq	%rax, %r14
	jmp	.LBB1_263
.LBB1_266:
.Ltmp339:                               # EH_LABEL
	movq	%rax, %r14
	jmp	.LBB1_263
.LBB1_183:
.Ltmp342:                               # EH_LABEL
	jmp	.LBB1_261
.LBB1_189:
.Ltmp348:                               # EH_LABEL
	jmp	.LBB1_261
.LBB1_159:
.Ltmp321:                               # EH_LABEL
	movq	%rax, %r14
	jmp	.LBB1_263
.LBB1_260:
.Ltmp354:                               # EH_LABEL
	jmp	.LBB1_261
.LBB1_38:
.Ltmp218:                               # EH_LABEL
	movq	%rax, %r14
	jmp	.LBB1_158
.LBB1_44:
.Ltmp224:                               # EH_LABEL
	movq	%rax, %r14
	jmp	.LBB1_158
.LBB1_63:
.Ltmp230:                               # EH_LABEL
	movq	%rax, %r14
	jmp	.LBB1_158
.LBB1_66:
.Ltmp233:                               # EH_LABEL
	jmp	.LBB1_156
.LBB1_72:
.Ltmp239:                               # EH_LABEL
	jmp	.LBB1_156
.LBB1_30:
.Ltmp209:                               # EH_LABEL
	movq	%rax, %rdi
	callq	_Unwind_Resume@PLT
.LBB1_155:
.Ltmp245:                               # EH_LABEL
	jmp	.LBB1_156
.LBB1_31:
.Ltmp212:                               # EH_LABEL
	movq	%rax, %r14
	jmp	.LBB1_158
.LBB1_196:
.Ltmp427:                               # EH_LABEL
	jmp	.LBB1_261
.LBB1_87:
.Ltmp318:                               # EH_LABEL
	jmp	.LBB1_156
.LBB1_231:
.Ltmp391:                               # EH_LABEL
	jmp	.LBB1_258
.LBB1_225:
.Ltmp385:                               # EH_LABEL
	jmp	.LBB1_258
.LBB1_215:
.Ltmp373:                               # EH_LABEL
	jmp	.LBB1_261
.LBB1_108:
.Ltmp276:                               # EH_LABEL
	jmp	.LBB1_153
.LBB1_114:
.Ltmp282:                               # EH_LABEL
	jmp	.LBB1_153
.LBB1_98:
.Ltmp264:                               # EH_LABEL
	jmp	.LBB1_156
.LBB1_230:
.Ltmp388:                               # EH_LABEL
	jmp	.LBB1_258
.LBB1_213:
.Ltmp367:                               # EH_LABEL
	jmp	.LBB1_261
.LBB1_224:
.Ltmp382:                               # EH_LABEL
	jmp	.LBB1_258
.LBB1_214:
.Ltmp370:                               # EH_LABEL
	jmp	.LBB1_261
.LBB1_222:
.Ltmp376:                               # EH_LABEL
	jmp	.LBB1_261
.LBB1_223:
.Ltmp379:                               # EH_LABEL
	movq	%rax, %r14
	jmp	.LBB1_259
.LBB1_113:
.Ltmp279:                               # EH_LABEL
	jmp	.LBB1_153
.LBB1_96:
.Ltmp258:                               # EH_LABEL
	jmp	.LBB1_156
.LBB1_97:
.Ltmp261:                               # EH_LABEL
	jmp	.LBB1_156
.LBB1_107:
.Ltmp273:                               # EH_LABEL
	jmp	.LBB1_153
.LBB1_105:
.Ltmp267:                               # EH_LABEL
	jmp	.LBB1_156
.LBB1_106:
.Ltmp270:                               # EH_LABEL
	movq	%rax, %r14
	jmp	.LBB1_154
.LBB1_212:
.Ltmp364:                               # EH_LABEL
.LBB1_261:
	movq	%rax, %r14
	jmp	.LBB1_262
.LBB1_95:
.Ltmp255:                               # EH_LABEL
.LBB1_156:
	movq	%rax, %r14
	jmp	.LBB1_157
.LBB1_257:
.Ltmp418:                               # EH_LABEL
.LBB1_258:
	movq	%rax, %r14
	movq	%r12, %rdi
	movq	%r15, %rsi
	callq	_ZdlPvm@PLT
.LBB1_259:
	movq	184(%rsp), %rdi                 # 8-byte Reload
	movq	%r15, %rsi
	callq	_ZdlPvm@PLT
.LBB1_262:
	movq	200(%rsp), %rdi                 # 8-byte Reload
	movq	48(%rsp), %rsi                  # 8-byte Reload
	callq	_ZdlPvm@PLT
.LBB1_263:
	movq	24(%rsp), %rsi                  # 8-byte Reload
	movq	160(%rsp), %rdi                 # 8-byte Reload
	callq	_ZdlPvm@PLT
	movq	%r14, %rdi
	callq	_Unwind_Resume@PLT
.LBB1_152:
.Ltmp309:                               # EH_LABEL
.LBB1_153:
	movq	%rax, %r14
	movq	%r12, %rdi
	movq	392(%rsp), %rbx                 # 8-byte Reload
	movq	%rbx, %rsi
	callq	_ZdlPvm@PLT
.LBB1_154:
	movq	112(%rsp), %rdi                 # 8-byte Reload
	movq	%rbx, %rsi
	callq	_ZdlPvm@PLT
.LBB1_157:
	movq	192(%rsp), %rdi                 # 8-byte Reload
	movq	48(%rsp), %rsi                  # 8-byte Reload
	callq	_ZdlPvm@PLT
.LBB1_158:
	movq	24(%rsp), %rsi                  # 8-byte Reload
	movq	88(%rsp), %rdi                  # 8-byte Reload
	callq	_ZdlPvm@PLT
	movq	%r14, %rdi
	callq	_Unwind_Resume@PLT
.Lfunc_end1:
	.size	_ZL8verify_eiibRSt14basic_ofstreamIcSt11char_traitsIcEE, .Lfunc_end1-_ZL8verify_eiibRSt14basic_ofstreamIcSt11char_traitsIcEE
	.cfi_endproc
	.section	.gcc_except_table,"a",@progbits
	.p2align	2, 0x0
GCC_except_table1:
.Lexception1:
	.byte	255                             # @LPStart Encoding = omit
	.byte	255                             # @TType Encoding = omit
	.byte	1                               # Call site Encoding = uleb128
	.uleb128 .Lcst_end1-.Lcst_begin1
.Lcst_begin1:
	.uleb128 .Ltmp207-.Lfunc_begin1         # >> Call Site 1 <<
	.uleb128 .Ltmp208-.Ltmp207              #   Call between .Ltmp207 and .Ltmp208
	.uleb128 .Ltmp209-.Lfunc_begin1         #     jumps to .Ltmp209
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp208-.Lfunc_begin1         # >> Call Site 2 <<
	.uleb128 .Ltmp210-.Ltmp208              #   Call between .Ltmp208 and .Ltmp210
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp210-.Lfunc_begin1         # >> Call Site 3 <<
	.uleb128 .Ltmp211-.Ltmp210              #   Call between .Ltmp210 and .Ltmp211
	.uleb128 .Ltmp212-.Lfunc_begin1         #     jumps to .Ltmp212
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp216-.Lfunc_begin1         # >> Call Site 4 <<
	.uleb128 .Ltmp217-.Ltmp216              #   Call between .Ltmp216 and .Ltmp217
	.uleb128 .Ltmp218-.Lfunc_begin1         #     jumps to .Ltmp218
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp222-.Lfunc_begin1         # >> Call Site 5 <<
	.uleb128 .Ltmp223-.Ltmp222              #   Call between .Ltmp222 and .Ltmp223
	.uleb128 .Ltmp224-.Lfunc_begin1         #     jumps to .Ltmp224
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp228-.Lfunc_begin1         # >> Call Site 6 <<
	.uleb128 .Ltmp229-.Ltmp228              #   Call between .Ltmp228 and .Ltmp229
	.uleb128 .Ltmp230-.Lfunc_begin1         #     jumps to .Ltmp230
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp229-.Lfunc_begin1         # >> Call Site 7 <<
	.uleb128 .Ltmp231-.Ltmp229              #   Call between .Ltmp229 and .Ltmp231
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp231-.Lfunc_begin1         # >> Call Site 8 <<
	.uleb128 .Ltmp232-.Ltmp231              #   Call between .Ltmp231 and .Ltmp232
	.uleb128 .Ltmp233-.Lfunc_begin1         #     jumps to .Ltmp233
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp237-.Lfunc_begin1         # >> Call Site 9 <<
	.uleb128 .Ltmp238-.Ltmp237              #   Call between .Ltmp237 and .Ltmp238
	.uleb128 .Ltmp239-.Lfunc_begin1         #     jumps to .Ltmp239
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp243-.Lfunc_begin1         # >> Call Site 10 <<
	.uleb128 .Ltmp244-.Ltmp243              #   Call between .Ltmp243 and .Ltmp244
	.uleb128 .Ltmp245-.Lfunc_begin1         #     jumps to .Ltmp245
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp249-.Lfunc_begin1         # >> Call Site 11 <<
	.uleb128 .Ltmp254-.Ltmp249              #   Call between .Ltmp249 and .Ltmp254
	.uleb128 .Ltmp255-.Lfunc_begin1         #     jumps to .Ltmp255
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp259-.Lfunc_begin1         # >> Call Site 12 <<
	.uleb128 .Ltmp260-.Ltmp259              #   Call between .Ltmp259 and .Ltmp260
	.uleb128 .Ltmp261-.Lfunc_begin1         #     jumps to .Ltmp261
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp265-.Lfunc_begin1         # >> Call Site 13 <<
	.uleb128 .Ltmp266-.Ltmp265              #   Call between .Ltmp265 and .Ltmp266
	.uleb128 .Ltmp267-.Lfunc_begin1         #     jumps to .Ltmp267
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp266-.Lfunc_begin1         # >> Call Site 14 <<
	.uleb128 .Ltmp268-.Ltmp266              #   Call between .Ltmp266 and .Ltmp268
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp268-.Lfunc_begin1         # >> Call Site 15 <<
	.uleb128 .Ltmp269-.Ltmp268              #   Call between .Ltmp268 and .Ltmp269
	.uleb128 .Ltmp270-.Lfunc_begin1         #     jumps to .Ltmp270
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp269-.Lfunc_begin1         # >> Call Site 16 <<
	.uleb128 .Ltmp271-.Ltmp269              #   Call between .Ltmp269 and .Ltmp271
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp271-.Lfunc_begin1         # >> Call Site 17 <<
	.uleb128 .Ltmp272-.Ltmp271              #   Call between .Ltmp271 and .Ltmp272
	.uleb128 .Ltmp273-.Lfunc_begin1         #     jumps to .Ltmp273
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp277-.Lfunc_begin1         # >> Call Site 18 <<
	.uleb128 .Ltmp278-.Ltmp277              #   Call between .Ltmp277 and .Ltmp278
	.uleb128 .Ltmp279-.Lfunc_begin1         #     jumps to .Ltmp279
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp283-.Lfunc_begin1         # >> Call Site 19 <<
	.uleb128 .Ltmp308-.Ltmp283              #   Call between .Ltmp283 and .Ltmp308
	.uleb128 .Ltmp309-.Lfunc_begin1         #     jumps to .Ltmp309
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp310-.Lfunc_begin1         # >> Call Site 20 <<
	.uleb128 .Ltmp317-.Ltmp310              #   Call between .Ltmp310 and .Ltmp317
	.uleb128 .Ltmp318-.Lfunc_begin1         #     jumps to .Ltmp318
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp317-.Lfunc_begin1         # >> Call Site 21 <<
	.uleb128 .Ltmp319-.Ltmp317              #   Call between .Ltmp317 and .Ltmp319
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp319-.Lfunc_begin1         # >> Call Site 22 <<
	.uleb128 .Ltmp320-.Ltmp319              #   Call between .Ltmp319 and .Ltmp320
	.uleb128 .Ltmp321-.Lfunc_begin1         #     jumps to .Ltmp321
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp325-.Lfunc_begin1         # >> Call Site 23 <<
	.uleb128 .Ltmp326-.Ltmp325              #   Call between .Ltmp325 and .Ltmp326
	.uleb128 .Ltmp327-.Lfunc_begin1         #     jumps to .Ltmp327
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp331-.Lfunc_begin1         # >> Call Site 24 <<
	.uleb128 .Ltmp332-.Ltmp331              #   Call between .Ltmp331 and .Ltmp332
	.uleb128 .Ltmp333-.Lfunc_begin1         #     jumps to .Ltmp333
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp337-.Lfunc_begin1         # >> Call Site 25 <<
	.uleb128 .Ltmp338-.Ltmp337              #   Call between .Ltmp337 and .Ltmp338
	.uleb128 .Ltmp339-.Lfunc_begin1         #     jumps to .Ltmp339
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp338-.Lfunc_begin1         # >> Call Site 26 <<
	.uleb128 .Ltmp340-.Ltmp338              #   Call between .Ltmp338 and .Ltmp340
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp340-.Lfunc_begin1         # >> Call Site 27 <<
	.uleb128 .Ltmp341-.Ltmp340              #   Call between .Ltmp340 and .Ltmp341
	.uleb128 .Ltmp342-.Lfunc_begin1         #     jumps to .Ltmp342
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp346-.Lfunc_begin1         # >> Call Site 28 <<
	.uleb128 .Ltmp347-.Ltmp346              #   Call between .Ltmp346 and .Ltmp347
	.uleb128 .Ltmp348-.Lfunc_begin1         #     jumps to .Ltmp348
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp352-.Lfunc_begin1         # >> Call Site 29 <<
	.uleb128 .Ltmp353-.Ltmp352              #   Call between .Ltmp352 and .Ltmp353
	.uleb128 .Ltmp354-.Lfunc_begin1         #     jumps to .Ltmp354
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp358-.Lfunc_begin1         # >> Call Site 30 <<
	.uleb128 .Ltmp363-.Ltmp358              #   Call between .Ltmp358 and .Ltmp363
	.uleb128 .Ltmp364-.Lfunc_begin1         #     jumps to .Ltmp364
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp368-.Lfunc_begin1         # >> Call Site 31 <<
	.uleb128 .Ltmp369-.Ltmp368              #   Call between .Ltmp368 and .Ltmp369
	.uleb128 .Ltmp370-.Lfunc_begin1         #     jumps to .Ltmp370
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp374-.Lfunc_begin1         # >> Call Site 32 <<
	.uleb128 .Ltmp375-.Ltmp374              #   Call between .Ltmp374 and .Ltmp375
	.uleb128 .Ltmp376-.Lfunc_begin1         #     jumps to .Ltmp376
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp375-.Lfunc_begin1         # >> Call Site 33 <<
	.uleb128 .Ltmp377-.Ltmp375              #   Call between .Ltmp375 and .Ltmp377
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp377-.Lfunc_begin1         # >> Call Site 34 <<
	.uleb128 .Ltmp378-.Ltmp377              #   Call between .Ltmp377 and .Ltmp378
	.uleb128 .Ltmp379-.Lfunc_begin1         #     jumps to .Ltmp379
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp378-.Lfunc_begin1         # >> Call Site 35 <<
	.uleb128 .Ltmp380-.Ltmp378              #   Call between .Ltmp378 and .Ltmp380
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp380-.Lfunc_begin1         # >> Call Site 36 <<
	.uleb128 .Ltmp381-.Ltmp380              #   Call between .Ltmp380 and .Ltmp381
	.uleb128 .Ltmp382-.Lfunc_begin1         #     jumps to .Ltmp382
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp386-.Lfunc_begin1         # >> Call Site 37 <<
	.uleb128 .Ltmp387-.Ltmp386              #   Call between .Ltmp386 and .Ltmp387
	.uleb128 .Ltmp388-.Lfunc_begin1         #     jumps to .Ltmp388
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp392-.Lfunc_begin1         # >> Call Site 38 <<
	.uleb128 .Ltmp417-.Ltmp392              #   Call between .Ltmp392 and .Ltmp417
	.uleb128 .Ltmp418-.Lfunc_begin1         #     jumps to .Ltmp418
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp419-.Lfunc_begin1         # >> Call Site 39 <<
	.uleb128 .Ltmp426-.Ltmp419              #   Call between .Ltmp419 and .Ltmp426
	.uleb128 .Ltmp427-.Lfunc_begin1         #     jumps to .Ltmp427
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp256-.Lfunc_begin1         # >> Call Site 40 <<
	.uleb128 .Ltmp257-.Ltmp256              #   Call between .Ltmp256 and .Ltmp257
	.uleb128 .Ltmp258-.Lfunc_begin1         #     jumps to .Ltmp258
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp262-.Lfunc_begin1         # >> Call Site 41 <<
	.uleb128 .Ltmp263-.Ltmp262              #   Call between .Ltmp262 and .Ltmp263
	.uleb128 .Ltmp264-.Lfunc_begin1         #     jumps to .Ltmp264
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp280-.Lfunc_begin1         # >> Call Site 42 <<
	.uleb128 .Ltmp281-.Ltmp280              #   Call between .Ltmp280 and .Ltmp281
	.uleb128 .Ltmp282-.Lfunc_begin1         #     jumps to .Ltmp282
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp274-.Lfunc_begin1         # >> Call Site 43 <<
	.uleb128 .Ltmp275-.Ltmp274              #   Call between .Ltmp274 and .Ltmp275
	.uleb128 .Ltmp276-.Lfunc_begin1         #     jumps to .Ltmp276
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp251-.Lfunc_begin1         # >> Call Site 44 <<
	.uleb128 .Ltmp252-.Ltmp251              #   Call between .Ltmp251 and .Ltmp252
	.uleb128 .Ltmp258-.Lfunc_begin1         #     jumps to .Ltmp258
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp365-.Lfunc_begin1         # >> Call Site 45 <<
	.uleb128 .Ltmp366-.Ltmp365              #   Call between .Ltmp365 and .Ltmp366
	.uleb128 .Ltmp367-.Lfunc_begin1         #     jumps to .Ltmp367
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp371-.Lfunc_begin1         # >> Call Site 46 <<
	.uleb128 .Ltmp372-.Ltmp371              #   Call between .Ltmp371 and .Ltmp372
	.uleb128 .Ltmp373-.Lfunc_begin1         #     jumps to .Ltmp373
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp383-.Lfunc_begin1         # >> Call Site 47 <<
	.uleb128 .Ltmp384-.Ltmp383              #   Call between .Ltmp383 and .Ltmp384
	.uleb128 .Ltmp385-.Lfunc_begin1         #     jumps to .Ltmp385
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp389-.Lfunc_begin1         # >> Call Site 48 <<
	.uleb128 .Ltmp390-.Ltmp389              #   Call between .Ltmp389 and .Ltmp390
	.uleb128 .Ltmp391-.Lfunc_begin1         #     jumps to .Ltmp391
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp360-.Lfunc_begin1         # >> Call Site 49 <<
	.uleb128 .Ltmp361-.Ltmp360              #   Call between .Ltmp360 and .Ltmp361
	.uleb128 .Ltmp367-.Lfunc_begin1         #     jumps to .Ltmp367
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp240-.Lfunc_begin1         # >> Call Site 50 <<
	.uleb128 .Ltmp241-.Ltmp240              #   Call between .Ltmp240 and .Ltmp241
	.uleb128 .Ltmp242-.Lfunc_begin1         #     jumps to .Ltmp242
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp234-.Lfunc_begin1         # >> Call Site 51 <<
	.uleb128 .Ltmp235-.Ltmp234              #   Call between .Ltmp234 and .Ltmp235
	.uleb128 .Ltmp236-.Lfunc_begin1         #     jumps to .Ltmp236
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp225-.Lfunc_begin1         # >> Call Site 52 <<
	.uleb128 .Ltmp226-.Ltmp225              #   Call between .Ltmp225 and .Ltmp226
	.uleb128 .Ltmp227-.Lfunc_begin1         #     jumps to .Ltmp227
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp219-.Lfunc_begin1         # >> Call Site 53 <<
	.uleb128 .Ltmp220-.Ltmp219              #   Call between .Ltmp219 and .Ltmp220
	.uleb128 .Ltmp221-.Lfunc_begin1         #     jumps to .Ltmp221
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp213-.Lfunc_begin1         # >> Call Site 54 <<
	.uleb128 .Ltmp214-.Ltmp213              #   Call between .Ltmp213 and .Ltmp214
	.uleb128 .Ltmp215-.Lfunc_begin1         #     jumps to .Ltmp215
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp246-.Lfunc_begin1         # >> Call Site 55 <<
	.uleb128 .Ltmp247-.Ltmp246              #   Call between .Ltmp246 and .Ltmp247
	.uleb128 .Ltmp248-.Lfunc_begin1         #     jumps to .Ltmp248
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp349-.Lfunc_begin1         # >> Call Site 56 <<
	.uleb128 .Ltmp350-.Ltmp349              #   Call between .Ltmp349 and .Ltmp350
	.uleb128 .Ltmp351-.Lfunc_begin1         #     jumps to .Ltmp351
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp343-.Lfunc_begin1         # >> Call Site 57 <<
	.uleb128 .Ltmp344-.Ltmp343              #   Call between .Ltmp343 and .Ltmp344
	.uleb128 .Ltmp345-.Lfunc_begin1         #     jumps to .Ltmp345
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp334-.Lfunc_begin1         # >> Call Site 58 <<
	.uleb128 .Ltmp335-.Ltmp334              #   Call between .Ltmp334 and .Ltmp335
	.uleb128 .Ltmp336-.Lfunc_begin1         #     jumps to .Ltmp336
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp328-.Lfunc_begin1         # >> Call Site 59 <<
	.uleb128 .Ltmp329-.Ltmp328              #   Call between .Ltmp328 and .Ltmp329
	.uleb128 .Ltmp330-.Lfunc_begin1         #     jumps to .Ltmp330
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp322-.Lfunc_begin1         # >> Call Site 60 <<
	.uleb128 .Ltmp323-.Ltmp322              #   Call between .Ltmp322 and .Ltmp323
	.uleb128 .Ltmp324-.Lfunc_begin1         #     jumps to .Ltmp324
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp355-.Lfunc_begin1         # >> Call Site 61 <<
	.uleb128 .Ltmp356-.Ltmp355              #   Call between .Ltmp355 and .Ltmp356
	.uleb128 .Ltmp357-.Lfunc_begin1         #     jumps to .Ltmp357
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp356-.Lfunc_begin1         # >> Call Site 62 <<
	.uleb128 .Lfunc_end1-.Ltmp356           #   Call between .Ltmp356 and .Lfunc_end1
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
.Lcst_end1:
	.p2align	2, 0x0
                                        # -- End function
	.section	.text._Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj,comdat
	.weak	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj # -- Begin function _Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
	.p2align	4
	.type	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj,@function
_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj: # @_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
	.cfi_startproc
# %bb.0:
	subq	$168, %rsp
	.cfi_def_cfa_offset 176
	movq	%rdi, 88(%rsp)
	movq	%rsi, 80(%rsp)
	movq	%rdx, 72(%rsp)
	movq	%rcx, 64(%rsp)
	movl	%r8d, 12(%rsp)
	movl	%r9d, 8(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, 104(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 112(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 120(%rsp)
	leaq	12(%rsp), %rax
	movq	%rax, 128(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 136(%rsp)
	leaq	176(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	184(%rsp), %rax
	movq	%rax, 152(%rsp)
	leaq	48(%rsp), %rdi
	leaq	32(%rsp), %rsi
	leaq	24(%rsp), %rdx
	leaq	16(%rsp), %rcx
	callq	__hipPopCallConfiguration@PLT
	movq	48(%rsp), %rsi
	movl	56(%rsp), %edx
	movq	32(%rsp), %rcx
	movl	40(%rsp), %r8d
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rdi
	leaq	96(%rsp), %r9
	pushq	16(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	32(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel@PLT
	addq	$184, %rsp
	.cfi_adjust_cfa_offset -184
	retq
.Lfunc_end2:
	.size	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj, .Lfunc_end2-_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
	.cfi_endproc
                                        # -- End function
	.section	.text._Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj,comdat
	.weak	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj # -- Begin function _Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
	.p2align	4
	.type	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj,@function
_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj: # @_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
	.cfi_startproc
# %bb.0:
	subq	$168, %rsp
	.cfi_def_cfa_offset 176
	movq	%rdi, 88(%rsp)
	movq	%rsi, 80(%rsp)
	movq	%rdx, 72(%rsp)
	movq	%rcx, 64(%rsp)
	movl	%r8d, 12(%rsp)
	movl	%r9d, 8(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, 104(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 112(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 120(%rsp)
	leaq	12(%rsp), %rax
	movq	%rax, 128(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 136(%rsp)
	leaq	176(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	184(%rsp), %rax
	movq	%rax, 152(%rsp)
	leaq	48(%rsp), %rdi
	leaq	32(%rsp), %rsi
	leaq	24(%rsp), %rdx
	leaq	16(%rsp), %rcx
	callq	__hipPopCallConfiguration@PLT
	movq	48(%rsp), %rsi
	movl	56(%rsp), %edx
	movq	32(%rsp), %rcx
	movl	40(%rsp), %r8d
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rdi
	leaq	96(%rsp), %r9
	pushq	16(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	32(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel@PLT
	addq	$184, %rsp
	.cfi_adjust_cfa_offset -184
	retq
.Lfunc_end3:
	.size	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj, .Lfunc_end3-_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
	.cfi_endproc
                                        # -- End function
	.section	.text._Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj,comdat
	.weak	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj # -- Begin function _Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
	.p2align	4
	.type	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj,@function
_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj: # @_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
	.cfi_startproc
# %bb.0:
	subq	$168, %rsp
	.cfi_def_cfa_offset 176
	movq	%rdi, 88(%rsp)
	movq	%rsi, 80(%rsp)
	movq	%rdx, 72(%rsp)
	movq	%rcx, 64(%rsp)
	movl	%r8d, 12(%rsp)
	movl	%r9d, 8(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, 104(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 112(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 120(%rsp)
	leaq	12(%rsp), %rax
	movq	%rax, 128(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 136(%rsp)
	leaq	176(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	184(%rsp), %rax
	movq	%rax, 152(%rsp)
	leaq	48(%rsp), %rdi
	leaq	32(%rsp), %rsi
	leaq	24(%rsp), %rdx
	leaq	16(%rsp), %rcx
	callq	__hipPopCallConfiguration@PLT
	movq	48(%rsp), %rsi
	movl	56(%rsp), %edx
	movq	32(%rsp), %rcx
	movl	40(%rsp), %r8d
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rdi
	leaq	96(%rsp), %r9
	pushq	16(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	32(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel@PLT
	addq	$184, %rsp
	.cfi_adjust_cfa_offset -184
	retq
.Lfunc_end4:
	.size	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj, .Lfunc_end4-_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
	.cfi_endproc
                                        # -- End function
	.section	.text._Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj,comdat
	.weak	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj # -- Begin function _Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
	.p2align	4
	.type	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj,@function
_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj: # @_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
	.cfi_startproc
# %bb.0:
	subq	$168, %rsp
	.cfi_def_cfa_offset 176
	movq	%rdi, 88(%rsp)
	movq	%rsi, 80(%rsp)
	movq	%rdx, 72(%rsp)
	movq	%rcx, 64(%rsp)
	movl	%r8d, 12(%rsp)
	movl	%r9d, 8(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, 104(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 112(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 120(%rsp)
	leaq	12(%rsp), %rax
	movq	%rax, 128(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 136(%rsp)
	leaq	176(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	184(%rsp), %rax
	movq	%rax, 152(%rsp)
	leaq	48(%rsp), %rdi
	leaq	32(%rsp), %rsi
	leaq	24(%rsp), %rdx
	leaq	16(%rsp), %rcx
	callq	__hipPopCallConfiguration@PLT
	movq	48(%rsp), %rsi
	movl	56(%rsp), %edx
	movq	32(%rsp), %rcx
	movl	40(%rsp), %r8d
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rdi
	leaq	96(%rsp), %r9
	pushq	16(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	32(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel@PLT
	addq	$184, %rsp
	.cfi_adjust_cfa_offset -184
	retq
.Lfunc_end5:
	.size	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj, .Lfunc_end5-_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
	.cfi_endproc
                                        # -- End function
	.section	.text._Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj,comdat
	.weak	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj # -- Begin function _Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
	.p2align	4
	.type	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj,@function
_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj: # @_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
	.cfi_startproc
# %bb.0:
	subq	$168, %rsp
	.cfi_def_cfa_offset 176
	movq	%rdi, 88(%rsp)
	movq	%rsi, 80(%rsp)
	movq	%rdx, 72(%rsp)
	movq	%rcx, 64(%rsp)
	movl	%r8d, 12(%rsp)
	movl	%r9d, 8(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, 104(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 112(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 120(%rsp)
	leaq	12(%rsp), %rax
	movq	%rax, 128(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 136(%rsp)
	leaq	176(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	184(%rsp), %rax
	movq	%rax, 152(%rsp)
	leaq	48(%rsp), %rdi
	leaq	32(%rsp), %rsi
	leaq	24(%rsp), %rdx
	leaq	16(%rsp), %rcx
	callq	__hipPopCallConfiguration@PLT
	movq	48(%rsp), %rsi
	movl	56(%rsp), %edx
	movq	32(%rsp), %rcx
	movl	40(%rsp), %r8d
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rdi
	leaq	96(%rsp), %r9
	pushq	16(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	32(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel@PLT
	addq	$184, %rsp
	.cfi_adjust_cfa_offset -184
	retq
.Lfunc_end6:
	.size	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj, .Lfunc_end6-_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
	.cfi_endproc
                                        # -- End function
	.section	.text._Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj,comdat
	.weak	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj # -- Begin function _Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
	.p2align	4
	.type	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj,@function
_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj: # @_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
	.cfi_startproc
# %bb.0:
	subq	$168, %rsp
	.cfi_def_cfa_offset 176
	movq	%rdi, 88(%rsp)
	movq	%rsi, 80(%rsp)
	movq	%rdx, 72(%rsp)
	movq	%rcx, 64(%rsp)
	movl	%r8d, 12(%rsp)
	movl	%r9d, 8(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, 104(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 112(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 120(%rsp)
	leaq	12(%rsp), %rax
	movq	%rax, 128(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 136(%rsp)
	leaq	176(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	184(%rsp), %rax
	movq	%rax, 152(%rsp)
	leaq	48(%rsp), %rdi
	leaq	32(%rsp), %rsi
	leaq	24(%rsp), %rdx
	leaq	16(%rsp), %rcx
	callq	__hipPopCallConfiguration@PLT
	movq	48(%rsp), %rsi
	movl	56(%rsp), %edx
	movq	32(%rsp), %rcx
	movl	40(%rsp), %r8d
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rdi
	leaq	96(%rsp), %r9
	pushq	16(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	32(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel@PLT
	addq	$184, %rsp
	.cfi_adjust_cfa_offset -184
	retq
.Lfunc_end7:
	.size	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj, .Lfunc_end7-_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
	.cfi_endproc
                                        # -- End function
	.section	.text._Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,comdat
	.weak	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj # -- Begin function _Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.p2align	4
	.type	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,@function
_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj: # @_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.cfi_startproc
# %bb.0:
	subq	$168, %rsp
	.cfi_def_cfa_offset 176
	movq	%rdi, 88(%rsp)
	movq	%rsi, 80(%rsp)
	movq	%rdx, 72(%rsp)
	movq	%rcx, 64(%rsp)
	movl	%r8d, 12(%rsp)
	movl	%r9d, 8(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, 104(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 112(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 120(%rsp)
	leaq	12(%rsp), %rax
	movq	%rax, 128(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 136(%rsp)
	leaq	176(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	184(%rsp), %rax
	movq	%rax, 152(%rsp)
	leaq	48(%rsp), %rdi
	leaq	32(%rsp), %rsi
	leaq	24(%rsp), %rdx
	leaq	16(%rsp), %rcx
	callq	__hipPopCallConfiguration@PLT
	movq	48(%rsp), %rsi
	movl	56(%rsp), %edx
	movq	32(%rsp), %rcx
	movl	40(%rsp), %r8d
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rdi
	leaq	96(%rsp), %r9
	pushq	16(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	32(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel@PLT
	addq	$184, %rsp
	.cfi_adjust_cfa_offset -184
	retq
.Lfunc_end8:
	.size	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj, .Lfunc_end8-_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.cfi_endproc
                                        # -- End function
	.section	.text._Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,comdat
	.weak	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj # -- Begin function _Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.p2align	4
	.type	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,@function
_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj: # @_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.cfi_startproc
# %bb.0:
	subq	$168, %rsp
	.cfi_def_cfa_offset 176
	movq	%rdi, 88(%rsp)
	movq	%rsi, 80(%rsp)
	movq	%rdx, 72(%rsp)
	movq	%rcx, 64(%rsp)
	movl	%r8d, 12(%rsp)
	movl	%r9d, 8(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, 104(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 112(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 120(%rsp)
	leaq	12(%rsp), %rax
	movq	%rax, 128(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 136(%rsp)
	leaq	176(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	184(%rsp), %rax
	movq	%rax, 152(%rsp)
	leaq	48(%rsp), %rdi
	leaq	32(%rsp), %rsi
	leaq	24(%rsp), %rdx
	leaq	16(%rsp), %rcx
	callq	__hipPopCallConfiguration@PLT
	movq	48(%rsp), %rsi
	movl	56(%rsp), %edx
	movq	32(%rsp), %rcx
	movl	40(%rsp), %r8d
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rdi
	leaq	96(%rsp), %r9
	pushq	16(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	32(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel@PLT
	addq	$184, %rsp
	.cfi_adjust_cfa_offset -184
	retq
.Lfunc_end9:
	.size	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj, .Lfunc_end9-_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.cfi_endproc
                                        # -- End function
	.section	.text._Z28__device_stub__mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z28__device_stub__mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,comdat
	.weak	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj # -- Begin function _Z28__device_stub__mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.p2align	4
	.type	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,@function
_Z28__device_stub__mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj: # @_Z28__device_stub__mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.cfi_startproc
# %bb.0:
	subq	$168, %rsp
	.cfi_def_cfa_offset 176
	movq	%rdi, 88(%rsp)
	movq	%rsi, 80(%rsp)
	movq	%rdx, 72(%rsp)
	movq	%rcx, 64(%rsp)
	movl	%r8d, 12(%rsp)
	movl	%r9d, 8(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, 104(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 112(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 120(%rsp)
	leaq	12(%rsp), %rax
	movq	%rax, 128(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 136(%rsp)
	leaq	176(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	184(%rsp), %rax
	movq	%rax, 152(%rsp)
	leaq	48(%rsp), %rdi
	leaq	32(%rsp), %rsi
	leaq	24(%rsp), %rdx
	leaq	16(%rsp), %rcx
	callq	__hipPopCallConfiguration@PLT
	movq	48(%rsp), %rsi
	movl	56(%rsp), %edx
	movq	32(%rsp), %rcx
	movl	40(%rsp), %r8d
	movq	_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rdi
	leaq	96(%rsp), %r9
	pushq	16(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	32(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel@PLT
	addq	$184, %rsp
	.cfi_adjust_cfa_offset -184
	retq
.Lfunc_end10:
	.size	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj, .Lfunc_end10-_Z28__device_stub__mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.cfi_endproc
                                        # -- End function
	.section	.text._Z28__device_stub__mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z28__device_stub__mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,comdat
	.weak	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj # -- Begin function _Z28__device_stub__mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.p2align	4
	.type	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,@function
_Z28__device_stub__mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj: # @_Z28__device_stub__mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.cfi_startproc
# %bb.0:
	subq	$168, %rsp
	.cfi_def_cfa_offset 176
	movq	%rdi, 88(%rsp)
	movq	%rsi, 80(%rsp)
	movq	%rdx, 72(%rsp)
	movq	%rcx, 64(%rsp)
	movl	%r8d, 12(%rsp)
	movl	%r9d, 8(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, 104(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 112(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 120(%rsp)
	leaq	12(%rsp), %rax
	movq	%rax, 128(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 136(%rsp)
	leaq	176(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	184(%rsp), %rax
	movq	%rax, 152(%rsp)
	leaq	48(%rsp), %rdi
	leaq	32(%rsp), %rsi
	leaq	24(%rsp), %rdx
	leaq	16(%rsp), %rcx
	callq	__hipPopCallConfiguration@PLT
	movq	48(%rsp), %rsi
	movl	56(%rsp), %edx
	movq	32(%rsp), %rcx
	movl	40(%rsp), %r8d
	movq	_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rdi
	leaq	96(%rsp), %r9
	pushq	16(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	32(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel@PLT
	addq	$184, %rsp
	.cfi_adjust_cfa_offset -184
	retq
.Lfunc_end11:
	.size	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj, .Lfunc_end11-_Z28__device_stub__mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.cfi_endproc
                                        # -- End function
	.section	.text._Z28__device_stub__mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z28__device_stub__mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,comdat
	.weak	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj # -- Begin function _Z28__device_stub__mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.p2align	4
	.type	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,@function
_Z28__device_stub__mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj: # @_Z28__device_stub__mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.cfi_startproc
# %bb.0:
	subq	$168, %rsp
	.cfi_def_cfa_offset 176
	movq	%rdi, 88(%rsp)
	movq	%rsi, 80(%rsp)
	movq	%rdx, 72(%rsp)
	movq	%rcx, 64(%rsp)
	movl	%r8d, 12(%rsp)
	movl	%r9d, 8(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	80(%rsp), %rax
	movq	%rax, 104(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 112(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 120(%rsp)
	leaq	12(%rsp), %rax
	movq	%rax, 128(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 136(%rsp)
	leaq	176(%rsp), %rax
	movq	%rax, 144(%rsp)
	leaq	184(%rsp), %rax
	movq	%rax, 152(%rsp)
	leaq	48(%rsp), %rdi
	leaq	32(%rsp), %rsi
	leaq	24(%rsp), %rdx
	leaq	16(%rsp), %rcx
	callq	__hipPopCallConfiguration@PLT
	movq	48(%rsp), %rsi
	movl	56(%rsp), %edx
	movq	32(%rsp), %rcx
	movl	40(%rsp), %r8d
	movq	_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rdi
	leaq	96(%rsp), %r9
	pushq	16(%rsp)
	.cfi_adjust_cfa_offset 8
	pushq	32(%rsp)
	.cfi_adjust_cfa_offset 8
	callq	hipLaunchKernel@PLT
	addq	$184, %rsp
	.cfi_adjust_cfa_offset -184
	retq
.Lfunc_end12:
	.size	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj, .Lfunc_end12-_Z28__device_stub__mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.cfi_endproc
                                        # -- End function
	.section	.text._ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElSt4lessIvEEvT_S9_T0_T1_,"axG",@progbits,_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElSt4lessIvEEvT_S9_T0_T1_,comdat
	.weak	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElSt4lessIvEEvT_S9_T0_T1_ # -- Begin function _ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElSt4lessIvEEvT_S9_T0_T1_
	.p2align	4
	.type	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElSt4lessIvEEvT_S9_T0_T1_,@function
_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElSt4lessIvEEvT_S9_T0_T1_: # @_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElSt4lessIvEEvT_S9_T0_T1_
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	pushq	%rax
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rsi, %rbp
	subq	%rdi, %rbp
	sarq	$3, %rbp
	cmpq	$17, %rbp
	jl	.LBB13_38
# %bb.1:
	movq	%rdx, %r14
	movq	%rdi, %rbx
	leaq	8(%rdi), %r12
	movq	$-8, %r13
	subq	%rdi, %r13
	jmp	.LBB13_2
	.p2align	4
.LBB13_37:                              #   in Loop: Header=BB13_2 Depth=1
	movq	%r15, %rdi
	movq	%r14, %rdx
	callq	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElSt4lessIvEEvT_S9_T0_T1_
	sarq	$3, %rbp
	movq	%r15, %rsi
	cmpq	$16, %rbp
	jle	.LBB13_38
.LBB13_2:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_31 Depth 2
                                        #       Child Loop BB13_32 Depth 3
                                        #       Child Loop BB13_34 Depth 3
	testq	%r14, %r14
	je	.LBB13_3
# %bb.19:                               #   in Loop: Header=BB13_2 Depth=1
	shrq	%rbp
	movsd	8(%rbx), %xmm1                  # xmm1 = mem[0],zero
	movsd	(%rbx,%rbp,8), %xmm2            # xmm2 = mem[0],zero
	ucomisd	%xmm1, %xmm2
	movsd	-8(%rsi), %xmm0                 # xmm0 = mem[0],zero
	jbe	.LBB13_25
# %bb.20:                               #   in Loop: Header=BB13_2 Depth=1
	ucomisd	%xmm2, %xmm0
	jbe	.LBB13_22
# %bb.21:                               #   in Loop: Header=BB13_2 Depth=1
	movsd	(%rbx), %xmm0                   # xmm0 = mem[0],zero
	movsd	%xmm2, (%rbx)
	movsd	%xmm0, (%rbx,%rbp,8)
	jmp	.LBB13_30
	.p2align	4
.LBB13_25:                              #   in Loop: Header=BB13_2 Depth=1
	ucomisd	%xmm1, %xmm0
	jbe	.LBB13_27
# %bb.26:                               #   in Loop: Header=BB13_2 Depth=1
	movsd	(%rbx), %xmm0                   # xmm0 = mem[0],zero
	movsd	%xmm1, (%rbx)
	movsd	%xmm0, 8(%rbx)
	jmp	.LBB13_30
	.p2align	4
.LBB13_22:                              #   in Loop: Header=BB13_2 Depth=1
	ucomisd	%xmm1, %xmm0
	movsd	(%rbx), %xmm2                   # xmm2 = mem[0],zero
	jbe	.LBB13_24
# %bb.23:                               #   in Loop: Header=BB13_2 Depth=1
	movsd	%xmm0, (%rbx)
	movsd	%xmm2, -8(%rsi)
	jmp	.LBB13_30
	.p2align	4
.LBB13_27:                              #   in Loop: Header=BB13_2 Depth=1
	ucomisd	%xmm2, %xmm0
	movsd	(%rbx), %xmm1                   # xmm1 = mem[0],zero
	jbe	.LBB13_29
# %bb.28:                               #   in Loop: Header=BB13_2 Depth=1
	movsd	%xmm0, (%rbx)
	movsd	%xmm1, -8(%rsi)
	jmp	.LBB13_30
.LBB13_24:                              #   in Loop: Header=BB13_2 Depth=1
	movsd	%xmm1, (%rbx)
	movsd	%xmm2, 8(%rbx)
	jmp	.LBB13_30
.LBB13_29:                              #   in Loop: Header=BB13_2 Depth=1
	movsd	%xmm2, (%rbx)
	movsd	%xmm1, (%rbx,%rbp,8)
	.p2align	4
.LBB13_30:                              #   in Loop: Header=BB13_2 Depth=1
	decq	%r14
	movq	%rsi, %rax
	movq	%r12, %rcx
	.p2align	4
.LBB13_31:                              #   Parent Loop BB13_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB13_32 Depth 3
                                        #       Child Loop BB13_34 Depth 3
	movsd	(%rbx), %xmm0                   # xmm0 = mem[0],zero
	leaq	(%rcx,%r13), %rbp
	.p2align	4
.LBB13_32:                              #   Parent Loop BB13_2 Depth=1
                                        #     Parent Loop BB13_31 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movsd	(%rcx), %xmm1                   # xmm1 = mem[0],zero
	addq	$8, %rcx
	addq	$8, %rbp
	ucomisd	%xmm1, %xmm0
	ja	.LBB13_32
# %bb.33:                               #   in Loop: Header=BB13_31 Depth=2
	leaq	-8(%rcx), %r15
	.p2align	4
.LBB13_34:                              #   Parent Loop BB13_2 Depth=1
                                        #     Parent Loop BB13_31 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movsd	-8(%rax), %xmm2                 # xmm2 = mem[0],zero
	addq	$-8, %rax
	ucomisd	%xmm0, %xmm2
	ja	.LBB13_34
# %bb.35:                               #   in Loop: Header=BB13_31 Depth=2
	cmpq	%rax, %r15
	jae	.LBB13_37
# %bb.36:                               #   in Loop: Header=BB13_31 Depth=2
	movsd	%xmm2, (%r15)
	movsd	%xmm1, (%rax)
	jmp	.LBB13_31
.LBB13_3:
	movq	%rbx, %rdi
	movq	%rsi, %r14
	movq	%rsi, %rdx
	callq	_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEESt4lessIvEEvT_S9_S9_T0_
	jmp	.LBB13_4
	.p2align	4
.LBB13_17:                              #   in Loop: Header=BB13_4 Depth=1
	xorl	%ecx, %ecx
.LBB13_18:                              #   in Loop: Header=BB13_4 Depth=1
	movsd	%xmm0, (%rbx,%rcx,8)
	cmpq	$8, %rax
	jle	.LBB13_38
.LBB13_4:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_7 Depth 2
                                        #     Child Loop BB13_15 Depth 2
	movsd	-8(%r14), %xmm0                 # xmm0 = mem[0],zero
	movsd	(%rbx), %xmm1                   # xmm1 = mem[0],zero
	movsd	%xmm1, -8(%r14)
	addq	$-8, %r14
	movq	%r14, %rax
	subq	%rbx, %rax
	movq	%rax, %rdx
	sarq	$3, %rdx
	cmpq	$3, %rdx
	jl	.LBB13_5
# %bb.6:                                #   in Loop: Header=BB13_4 Depth=1
	leaq	-1(%rdx), %rcx
	shrq	$63, %rcx
	leaq	(%rdx,%rcx), %rsi
	decq	%rsi
	sarq	%rsi
	xorl	%edi, %edi
	jmp	.LBB13_7
	.p2align	4
.LBB13_9:                               #   in Loop: Header=BB13_7 Depth=2
	leaq	2(,%rdi,2), %rcx
.LBB13_10:                              #   in Loop: Header=BB13_7 Depth=2
	movsd	(%rbx,%rcx,8), %xmm1            # xmm1 = mem[0],zero
	movsd	%xmm1, (%rbx,%rdi,8)
	movq	%rcx, %rdi
	cmpq	%rsi, %rcx
	jge	.LBB13_11
.LBB13_7:                               #   Parent Loop BB13_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	(%rdi,%rdi), %rcx
	movsd	8(%rbx,%rcx,8), %xmm1           # xmm1 = mem[0],zero
	ucomisd	16(%rbx,%rcx,8), %xmm1
	jbe	.LBB13_9
# %bb.8:                                #   in Loop: Header=BB13_7 Depth=2
	leaq	1(,%rdi,2), %rcx
	jmp	.LBB13_10
	.p2align	4
.LBB13_5:                               #   in Loop: Header=BB13_4 Depth=1
	xorl	%ecx, %ecx
.LBB13_11:                              #   in Loop: Header=BB13_4 Depth=1
	testb	$8, %al
	jne	.LBB13_14
# %bb.12:                               #   in Loop: Header=BB13_4 Depth=1
	addq	$-2, %rdx
	sarq	%rdx
	cmpq	%rdx, %rcx
	jne	.LBB13_14
# %bb.13:                               #   in Loop: Header=BB13_4 Depth=1
	leaq	(%rcx,%rcx), %rdx
	movsd	8(%rbx,%rdx,8), %xmm1           # xmm1 = mem[0],zero
	movsd	%xmm1, (%rbx,%rcx,8)
	leaq	1(,%rcx,2), %rcx
	jmp	.LBB13_15
	.p2align	4
.LBB13_14:                              #   in Loop: Header=BB13_4 Depth=1
	testq	%rcx, %rcx
	je	.LBB13_17
	.p2align	4
.LBB13_15:                              #   Parent Loop BB13_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	-1(%rcx), %rdx
	movq	%rdx, %rsi
	shrq	%rsi
	movsd	(%rbx,%rsi,8), %xmm1            # xmm1 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jbe	.LBB13_18
# %bb.16:                               #   in Loop: Header=BB13_15 Depth=2
	movsd	%xmm1, (%rbx,%rcx,8)
	movq	%rsi, %rcx
	cmpq	$1, %rdx
	ja	.LBB13_15
	jmp	.LBB13_17
.LBB13_38:
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end13:
	.size	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElSt4lessIvEEvT_S9_T0_T1_, .Lfunc_end13-_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElSt4lessIvEEvT_S9_T0_T1_
	.cfi_endproc
                                        # -- End function
	.section	.text._ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEESt4lessIvEEvT_S9_S9_T0_,"axG",@progbits,_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEESt4lessIvEEvT_S9_S9_T0_,comdat
	.weak	_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEESt4lessIvEEvT_S9_S9_T0_ # -- Begin function _ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEESt4lessIvEEvT_S9_S9_T0_
	.p2align	4
	.type	_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEESt4lessIvEEvT_S9_S9_T0_,@function
_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEESt4lessIvEEvT_S9_S9_T0_: # @_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEESt4lessIvEEvT_S9_S9_T0_
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	subq	$16, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdx, %rbx
	movq	%rsi, %r14
	movq	%rdi, %r15
	leaq	15(%rsp), %rdx
	callq	_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEESt4lessIvEEvT_S9_RT0_
	cmpq	%rbx, %r14
	jae	.LBB14_31
# %bb.1:
	movq	%r14, %rax
	subq	%r15, %rax
	movq	%rax, %rdx
	sarq	$3, %rdx
	leaq	-2(%rdx), %rcx
	cmpq	$3, %rdx
	jl	.LBB14_18
# %bb.2:
	leaq	-1(%rdx), %rsi
	shrq	$63, %rsi
	addq	%rsi, %rdx
	decq	%rdx
	sarq	%rdx
	movq	%rcx, %rsi
	sarq	%rsi
	orq	$1, %rcx
	jmp	.LBB14_3
	.p2align	4
.LBB14_15:                              #   in Loop: Header=BB14_3 Depth=1
	xorl	%edi, %edi
.LBB14_16:                              #   in Loop: Header=BB14_3 Depth=1
	movsd	%xmm0, (%r15,%rdi,8)
.LBB14_17:                              #   in Loop: Header=BB14_3 Depth=1
	addq	$8, %r14
	cmpq	%rbx, %r14
	jae	.LBB14_31
.LBB14_3:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB14_5 Depth 2
                                        #     Child Loop BB14_13 Depth 2
	movsd	(%r14), %xmm0                   # xmm0 = mem[0],zero
	movsd	(%r15), %xmm1                   # xmm1 = mem[0],zero
	ucomisd	%xmm0, %xmm1
	jbe	.LBB14_17
# %bb.4:                                #   in Loop: Header=BB14_3 Depth=1
	movsd	%xmm1, (%r14)
	xorl	%r8d, %r8d
	jmp	.LBB14_5
	.p2align	4
.LBB14_7:                               #   in Loop: Header=BB14_5 Depth=2
	leaq	2(,%r8,2), %rdi
.LBB14_8:                               #   in Loop: Header=BB14_5 Depth=2
	movsd	(%r15,%rdi,8), %xmm1            # xmm1 = mem[0],zero
	movsd	%xmm1, (%r15,%r8,8)
	movq	%rdi, %r8
	cmpq	%rdx, %rdi
	jge	.LBB14_9
.LBB14_5:                               #   Parent Loop BB14_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	(%r8,%r8), %rdi
	movsd	8(%r15,%rdi,8), %xmm1           # xmm1 = mem[0],zero
	ucomisd	16(%r15,%rdi,8), %xmm1
	jbe	.LBB14_7
# %bb.6:                                #   in Loop: Header=BB14_5 Depth=2
	leaq	1(,%r8,2), %rdi
	jmp	.LBB14_8
	.p2align	4
.LBB14_9:                               #   in Loop: Header=BB14_3 Depth=1
	testb	$8, %al
	jne	.LBB14_10
# %bb.11:                               #   in Loop: Header=BB14_3 Depth=1
	cmpq	%rsi, %rdi
	jne	.LBB14_10
# %bb.12:                               #   in Loop: Header=BB14_3 Depth=1
	movsd	(%r15,%rcx,8), %xmm1            # xmm1 = mem[0],zero
	movsd	%xmm1, (%r15,%rsi,8)
	movq	%rcx, %rdi
	jmp	.LBB14_13
	.p2align	4
.LBB14_10:                              #   in Loop: Header=BB14_3 Depth=1
	testq	%rdi, %rdi
	je	.LBB14_15
	.p2align	4
.LBB14_13:                              #   Parent Loop BB14_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	-1(%rdi), %r8
	movq	%r8, %r9
	shrq	%r9
	movsd	(%r15,%r9,8), %xmm1             # xmm1 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jbe	.LBB14_16
# %bb.14:                               #   in Loop: Header=BB14_13 Depth=2
	movsd	%xmm1, (%r15,%rdi,8)
	movq	%r9, %rdi
	cmpq	$1, %r8
	ja	.LBB14_13
	jmp	.LBB14_15
.LBB14_18:
	testb	$8, %al
	jne	.LBB14_19
# %bb.23:
	testq	%rcx, %rcx
	je	.LBB14_28
# %bb.24:
	movsd	(%r15), %xmm0                   # xmm0 = mem[0],zero
	jmp	.LBB14_25
	.p2align	4
.LBB14_27:                              #   in Loop: Header=BB14_25 Depth=1
	addq	$8, %r14
	cmpq	%rbx, %r14
	jae	.LBB14_31
.LBB14_25:                              # =>This Inner Loop Header: Depth=1
	movsd	(%r14), %xmm1                   # xmm1 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jbe	.LBB14_27
# %bb.26:                               #   in Loop: Header=BB14_25 Depth=1
	movsd	%xmm0, (%r14)
	movsd	%xmm1, (%r15)
	movapd	%xmm1, %xmm0
	jmp	.LBB14_27
	.p2align	4
.LBB14_30:                              #   in Loop: Header=BB14_28 Depth=1
	addq	$8, %r14
	cmpq	%rbx, %r14
	jae	.LBB14_31
.LBB14_28:                              # =>This Inner Loop Header: Depth=1
	movsd	(%r14), %xmm0                   # xmm0 = mem[0],zero
	movsd	(%r15), %xmm1                   # xmm1 = mem[0],zero
	ucomisd	%xmm0, %xmm1
	jbe	.LBB14_30
# %bb.29:                               #   in Loop: Header=BB14_28 Depth=1
	movsd	%xmm1, (%r14)
	movsd	8(%r15), %xmm1                  # xmm1 = mem[0],zero
	xorl	%eax, %eax
	ucomisd	%xmm1, %xmm0
	movsd	%xmm1, (%r15)
	setbe	%al
	movsd	%xmm0, (%r15,%rax,8)
	jmp	.LBB14_30
.LBB14_19:
	movsd	(%r15), %xmm0                   # xmm0 = mem[0],zero
	jmp	.LBB14_20
	.p2align	4
.LBB14_22:                              #   in Loop: Header=BB14_20 Depth=1
	addq	$8, %r14
	cmpq	%rbx, %r14
	jae	.LBB14_31
.LBB14_20:                              # =>This Inner Loop Header: Depth=1
	movsd	(%r14), %xmm1                   # xmm1 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jbe	.LBB14_22
# %bb.21:                               #   in Loop: Header=BB14_20 Depth=1
	movsd	%xmm0, (%r14)
	movsd	%xmm1, (%r15)
	movapd	%xmm1, %xmm0
	jmp	.LBB14_22
.LBB14_31:
	addq	$16, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end14:
	.size	_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEESt4lessIvEEvT_S9_S9_T0_, .Lfunc_end14-_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEESt4lessIvEEvT_S9_S9_T0_
	.cfi_endproc
                                        # -- End function
	.section	.text._ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEESt4lessIvEEvT_S9_RT0_,"axG",@progbits,_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEESt4lessIvEEvT_S9_RT0_,comdat
	.weak	_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEESt4lessIvEEvT_S9_RT0_ # -- Begin function _ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEESt4lessIvEEvT_S9_RT0_
	.p2align	4
	.type	_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEESt4lessIvEEvT_S9_RT0_,@function
_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEESt4lessIvEEvT_S9_RT0_: # @_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEESt4lessIvEEvT_S9_RT0_
	.cfi_startproc
# %bb.0:
	subq	%rdi, %rsi
	movq	%rsi, %rax
	sarq	$3, %rax
	cmpq	$2, %rax
	jge	.LBB15_2
.LBB15_1:
	retq
.LBB15_2:
	leaq	-2(%rax), %rdx
	movq	%rdx, %rcx
	shrq	%rcx
	decq	%rax
	shrq	%rax
	testb	$8, %sil
	jne	.LBB15_20
# %bb.3:
	orq	$1, %rdx
	movq	%rcx, %rsi
	jmp	.LBB15_6
	.p2align	4
.LBB15_4:                               #   in Loop: Header=BB15_6 Depth=1
	movq	%r8, %r9
.LBB15_5:                               #   in Loop: Header=BB15_6 Depth=1
	movsd	%xmm0, (%rdi,%r9,8)
	subq	$1, %rsi
	jb	.LBB15_1
.LBB15_6:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB15_10 Depth 2
                                        #     Child Loop BB15_15 Depth 2
	movsd	(%rdi,%rsi,8), %xmm0            # xmm0 = mem[0],zero
	movq	%rsi, %r8
	cmpq	%rax, %rsi
	jge	.LBB15_12
# %bb.7:                                #   in Loop: Header=BB15_6 Depth=1
	movq	%rsi, %r9
	jmp	.LBB15_10
	.p2align	4
.LBB15_8:                               #   in Loop: Header=BB15_10 Depth=2
	leaq	2(,%r9,2), %r8
.LBB15_9:                               #   in Loop: Header=BB15_10 Depth=2
	movsd	(%rdi,%r8,8), %xmm1             # xmm1 = mem[0],zero
	movsd	%xmm1, (%rdi,%r9,8)
	movq	%r8, %r9
	cmpq	%rax, %r8
	jge	.LBB15_12
.LBB15_10:                              #   Parent Loop BB15_6 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	(%r9,%r9), %r8
	movsd	8(%rdi,%r8,8), %xmm1            # xmm1 = mem[0],zero
	ucomisd	16(%rdi,%r8,8), %xmm1
	jbe	.LBB15_8
# %bb.11:                               #   in Loop: Header=BB15_10 Depth=2
	leaq	1(,%r9,2), %r8
	jmp	.LBB15_9
	.p2align	4
.LBB15_12:                              #   in Loop: Header=BB15_6 Depth=1
	cmpq	%rcx, %r8
	jne	.LBB15_14
# %bb.13:                               #   in Loop: Header=BB15_6 Depth=1
	movsd	(%rdi,%rdx,8), %xmm1            # xmm1 = mem[0],zero
	movsd	%xmm1, (%rdi,%rcx,8)
	movq	%rdx, %r8
.LBB15_14:                              #   in Loop: Header=BB15_6 Depth=1
	cmpq	%rsi, %r8
	jle	.LBB15_4
	.p2align	4
.LBB15_15:                              #   Parent Loop BB15_6 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	-1(%r8), %r9
	shrq	$63, %r9
	addq	%r8, %r9
	decq	%r9
	sarq	%r9
	movsd	(%rdi,%r9,8), %xmm1             # xmm1 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jbe	.LBB15_4
# %bb.16:                               #   in Loop: Header=BB15_15 Depth=2
	movsd	%xmm1, (%rdi,%r8,8)
	movq	%r9, %r8
	cmpq	%rsi, %r9
	jg	.LBB15_15
	jmp	.LBB15_5
	.p2align	4
.LBB15_18:                              #   in Loop: Header=BB15_20 Depth=1
	movq	%rdx, %rsi
.LBB15_19:                              #   in Loop: Header=BB15_20 Depth=1
	movsd	%xmm0, (%rdi,%rsi,8)
	subq	$1, %rcx
	jb	.LBB15_1
.LBB15_20:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB15_24 Depth 2
                                        #     Child Loop BB15_27 Depth 2
	movsd	(%rdi,%rcx,8), %xmm0            # xmm0 = mem[0],zero
	movq	%rcx, %rsi
	cmpq	%rax, %rcx
	jge	.LBB15_19
# %bb.21:                               #   in Loop: Header=BB15_20 Depth=1
	movq	%rcx, %rsi
	jmp	.LBB15_24
	.p2align	4
.LBB15_22:                              #   in Loop: Header=BB15_24 Depth=2
	leaq	2(,%rsi,2), %rdx
.LBB15_23:                              #   in Loop: Header=BB15_24 Depth=2
	movsd	(%rdi,%rdx,8), %xmm1            # xmm1 = mem[0],zero
	movsd	%xmm1, (%rdi,%rsi,8)
	movq	%rdx, %rsi
	cmpq	%rax, %rdx
	jge	.LBB15_26
.LBB15_24:                              #   Parent Loop BB15_20 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	(%rsi,%rsi), %rdx
	movsd	8(%rdi,%rdx,8), %xmm1           # xmm1 = mem[0],zero
	ucomisd	16(%rdi,%rdx,8), %xmm1
	jbe	.LBB15_22
# %bb.25:                               #   in Loop: Header=BB15_24 Depth=2
	leaq	1(,%rsi,2), %rdx
	jmp	.LBB15_23
	.p2align	4
.LBB15_26:                              #   in Loop: Header=BB15_20 Depth=1
	cmpq	%rcx, %rdx
	jle	.LBB15_18
	.p2align	4
.LBB15_27:                              #   Parent Loop BB15_20 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	-1(%rdx), %rsi
	shrq	$63, %rsi
	addq	%rdx, %rsi
	decq	%rsi
	sarq	%rsi
	movsd	(%rdi,%rsi,8), %xmm1            # xmm1 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jbe	.LBB15_18
# %bb.28:                               #   in Loop: Header=BB15_27 Depth=2
	movsd	%xmm1, (%rdi,%rdx,8)
	movq	%rsi, %rdx
	cmpq	%rcx, %rsi
	jg	.LBB15_27
	jmp	.LBB15_19
.Lfunc_end15:
	.size	_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEESt4lessIvEEvT_S9_RT0_, .Lfunc_end15-_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEESt4lessIvEEvT_S9_RT0_
	.cfi_endproc
                                        # -- End function
	.text
	.p2align	4                               # -- Begin function __hip_module_ctor
	.type	__hip_module_ctor,@function
__hip_module_ctor:                      # @__hip_module_ctor
	.cfi_startproc
# %bb.0:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$32, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -16
	movq	__hip_gpubin_handle_dfe6ff6a84b3117c(%rip), %rbx
	testq	%rbx, %rbx
	jne	.LBB16_2
# %bb.1:
	leaq	__hip_fatbin_wrapper(%rip), %rdi
	callq	__hipRegisterFatBinary@PLT
	movq	%rax, %rbx
	movq	%rax, __hip_gpubin_handle_dfe6ff6a84b3117c(%rip)
.LBB16_2:
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%rsp)
	movups	%xmm0, (%rsp)
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rsi
	leaq	.L__unnamed_1(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rcx, %rdx
	movl	$-1, %r8d
	xorl	%r9d, %r9d
	callq	__hipRegisterFunction@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%rsp)
	movups	%xmm0, (%rsp)
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rsi
	leaq	.L__unnamed_2(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rcx, %rdx
	movl	$-1, %r8d
	xorl	%r9d, %r9d
	callq	__hipRegisterFunction@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%rsp)
	movups	%xmm0, (%rsp)
	movq	_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rsi
	leaq	.L__unnamed_3(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rcx, %rdx
	movl	$-1, %r8d
	xorl	%r9d, %r9d
	callq	__hipRegisterFunction@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%rsp)
	movups	%xmm0, (%rsp)
	movq	_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rsi
	leaq	.L__unnamed_4(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rcx, %rdx
	movl	$-1, %r8d
	xorl	%r9d, %r9d
	callq	__hipRegisterFunction@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%rsp)
	movups	%xmm0, (%rsp)
	movq	_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rsi
	leaq	.L__unnamed_5(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rcx, %rdx
	movl	$-1, %r8d
	xorl	%r9d, %r9d
	callq	__hipRegisterFunction@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%rsp)
	movups	%xmm0, (%rsp)
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rsi
	leaq	.L__unnamed_6(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rcx, %rdx
	movl	$-1, %r8d
	xorl	%r9d, %r9d
	callq	__hipRegisterFunction@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%rsp)
	movups	%xmm0, (%rsp)
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rsi
	leaq	.L__unnamed_7(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rcx, %rdx
	movl	$-1, %r8d
	xorl	%r9d, %r9d
	callq	__hipRegisterFunction@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%rsp)
	movups	%xmm0, (%rsp)
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rsi
	leaq	.L__unnamed_8(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rcx, %rdx
	movl	$-1, %r8d
	xorl	%r9d, %r9d
	callq	__hipRegisterFunction@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%rsp)
	movups	%xmm0, (%rsp)
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rsi
	leaq	.L__unnamed_9(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rcx, %rdx
	movl	$-1, %r8d
	xorl	%r9d, %r9d
	callq	__hipRegisterFunction@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%rsp)
	movups	%xmm0, (%rsp)
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rsi
	leaq	.L__unnamed_10(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rcx, %rdx
	movl	$-1, %r8d
	xorl	%r9d, %r9d
	callq	__hipRegisterFunction@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%rsp)
	movups	%xmm0, (%rsp)
	movq	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj@GOTPCREL(%rip), %rsi
	leaq	.L__unnamed_11(%rip), %rcx
	movq	%rbx, %rdi
	movq	%rcx, %rdx
	movl	$-1, %r8d
	xorl	%r9d, %r9d
	callq	__hipRegisterFunction@PLT
	leaq	__hip_module_dtor(%rip), %rdi
	addq	$32, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	atexit@PLT                      # TAILCALL
.Lfunc_end16:
	.size	__hip_module_ctor, .Lfunc_end16-__hip_module_ctor
	.cfi_endproc
                                        # -- End function
	.p2align	4                               # -- Begin function __hip_module_dtor
	.type	__hip_module_dtor,@function
__hip_module_dtor:                      # @__hip_module_dtor
	.cfi_startproc
# %bb.0:
	movq	__hip_gpubin_handle_dfe6ff6a84b3117c(%rip), %rdi
	testq	%rdi, %rdi
	je	.LBB17_2
# %bb.1:
	pushq	%rax
	.cfi_def_cfa_offset 16
	callq	__hipUnregisterFatBinary@PLT
	movq	$0, __hip_gpubin_handle_dfe6ff6a84b3117c(%rip)
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
.LBB17_2:
	retq
.Lfunc_end17:
	.size	__hip_module_dtor, .Lfunc_end17-__hip_module_dtor
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"usage: %s verify|bench [csv]\n"
	.size	.L.str, 30

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"verify"
	.size	.L.str.1, 7

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"bit_exact_check.log"
	.size	.L.str.2, 20

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"bit-exact check: V0 vs E1/E2/E3 (IQ3_XXS MMVQ, gfx1101)\n"
	.size	.L.str.3, 57

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"integer addition is associative; regrouping dp4a accumulation must be bit-exact\n\n"
	.size	.L.str.4, 82

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"\nRESULT: see above (all ok=1 means ALL_BIT_EXACT)\n"
	.size	.L.str.5, 51

	.type	.L.str.7,@object                # @.str.7
.L.str.7:
	.asciz	"bench"
	.size	.L.str.7, 6

	.type	.L.str.8,@object                # @.str.8
.L.str.8:
	.asciz	"raw_measurements.csv"
	.size	.L.str.8, 21

	.type	.L.str.9,@object                # @.str.9
.L.str.9:
	.asciz	"case,variant,K,N,ncols_dst,fused,median_ms,p10_ms,p90_ms,gbps_weight,gbps_total,regs,occ_blocks\n"
	.size	.L.str.9, 97

	.type	.L.str.10,@object               # @.str.10
.L.str.10:
	.asciz	"ffn_down"
	.size	.L.str.10, 9

	.type	.L.str.11,@object               # @.str.11
.L.str.11:
	.asciz	"ffn_gateup"
	.size	.L.str.11, 11

	.type	.L__const.main.cases,@object    # @__const.main.cases
	.section	.data.rel.ro,"aw",@progbits
	.p2align	4, 0x0
.L__const.main.cases:
	.quad	.L.str.10
	.long	17408                           # 0x4400
	.long	5120                            # 0x1400
	.long	1                               # 0x1
	.byte	0                               # 0x0
	.zero	3
	.quad	.L.str.11
	.long	5120                            # 0x1400
	.long	17408                           # 0x4400
	.long	1                               # 0x1
	.byte	1                               # 0x1
	.zero	3
	.size	.L__const.main.cases, 48

	.type	.L.str.12,@object               # @.str.12
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.12:
	.asciz	"%s"
	.size	.L.str.12, 3

	.type	.L.str.13,@object               # @.str.13
.L.str.13:
	.asciz	"V0"
	.size	.L.str.13, 3

	.type	.L.str.14,@object               # @.str.14
.L.str.14:
	.asciz	"E1"
	.size	.L.str.14, 3

	.type	.L.str.15,@object               # @.str.15
.L.str.15:
	.asciz	"E2"
	.size	.L.str.15, 3

	.type	.L.str.16,@object               # @.str.16
.L.str.16:
	.asciz	"E3"
	.size	.L.str.16, 3

	.type	.L.str.17,@object               # @.str.17
.L.str.17:
	.asciz	","
	.size	.L.str.17, 2

	.type	.L.str.18,@object               # @.str.18
.L.str.18:
	.asciz	"\n"
	.size	.L.str.18, 2

	.type	.L.str.19,@object               # @.str.19
.L.str.19:
	.asciz	"%s %s: median=%.4f ms  GB/s(weight)=%.1f  GB/s(total)=%.1f  regs=%d occ=%d\n"
	.size	.L.str.19, 76

	.type	.L.str.20,@object               # @.str.20
.L.str.20:
	.asciz	"\nbench complete -> %s\n"
	.size	.L.str.20, 23

	.type	.L.str.21,@object               # @.str.21
.L.str.21:
	.asciz	"unknown mode %s\n"
	.size	.L.str.21, 17

	.type	.L.str.22,@object               # @.str.22
.L.str.22:
	.asciz	"HIP error %s at %s:%d\n"
	.size	.L.str.22, 23

	.type	.L.str.23,@object               # @.str.23
.L.str.23:
	.asciz	"mmvq_bench_accum.hip"
	.size	.L.str.23, 21

	.type	.L.str.24,@object               # @.str.24
.L.str.24:
	.asciz	"E%d"
	.size	.L.str.24, 4

	.type	.L.str.25,@object               # @.str.25
.L.str.25:
	.asciz	"sweep_shift="
	.size	.L.str.25, 13

	.type	.L.str.26,@object               # @.str.26
.L.str.26:
	.asciz	" "
	.size	.L.str.26, 2

	.type	.L.str.27,@object               # @.str.27
.L.str.27:
	.asciz	" fused="
	.size	.L.str.27, 8

	.type	.L.str.28,@object               # @.str.28
.L.str.28:
	.asciz	" ok="
	.size	.L.str.28, 5

	.type	.L.str.29,@object               # @.str.29
.L.str.29:
	.asciz	" first_diff="
	.size	.L.str.29, 13

	.type	.L.str.30,@object               # @.str.30
.L.str.30:
	.asciz	" n="
	.size	.L.str.30, 4

	.type	.L.str.31,@object               # @.str.31
.L.str.31:
	.asciz	"verify sweep_shift=%d %s fused=%d -> %s (n=%d)\n"
	.size	.L.str.31, 48

	.type	.L.str.32,@object               # @.str.32
.L.str.32:
	.asciz	"BIT-EXACT"
	.size	.L.str.32, 10

	.type	.L.str.33,@object               # @.str.33
.L.str.33:
	.asciz	"MISMATCH"
	.size	.L.str.33, 9

	.type	.Lconstinit,@object             # @constinit
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
.Lconstinit:
	.long	42                              # 0x2a
	.long	1                               # 0x1
	.long	2                               # 0x2
	.long	3                               # 0x3
	.long	12345                           # 0x3039
	.long	99999                           # 0x1869f
	.size	.Lconstinit, 24

	.type	.L.str.34,@object               # @.str.34
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.34:
	.asciz	"seed="
	.size	.L.str.34, 6

	.type	.L.str.35,@object               # @.str.35
.L.str.35:
	.asciz	"verify seed=%u %s fused=%d -> %s (n=%d)\n"
	.size	.L.str.35, 41

	.type	.L.str.36,@object               # @.str.36
.L.str.36:
	.asciz	"cannot create std::vector larger than max_size()"
	.size	.L.str.36, 49

	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj,@object # @_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
	.section	.data.rel.ro._Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj,"awG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj,comdat
	.weak	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
	.p2align	3, 0x0
_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj:
	.quad	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj, 8

	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj,@object # @_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
	.section	.data.rel.ro._Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj,"awG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj,comdat
	.weak	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
	.p2align	3, 0x0
_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj:
	.quad	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj, 8

	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj,@object # @_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
	.section	.data.rel.ro._Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj,"awG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj,comdat
	.weak	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
	.p2align	3, 0x0
_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj:
	.quad	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj, 8

	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj,@object # @_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
	.section	.data.rel.ro._Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj,"awG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj,comdat
	.weak	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
	.p2align	3, 0x0
_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj:
	.quad	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj, 8

	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj,@object # @_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
	.section	.data.rel.ro._Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj,"awG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj,comdat
	.weak	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
	.p2align	3, 0x0
_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj:
	.quad	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj, 8

	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj,@object # @_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
	.section	.data.rel.ro._Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj,"awG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj,comdat
	.weak	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
	.p2align	3, 0x0
_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj:
	.quad	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj, 8

	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,@object # @_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.section	.data.rel.ro._Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,"awG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,comdat
	.weak	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.p2align	3, 0x0
_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj:
	.quad	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj, 8

	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,@object # @_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.section	.data.rel.ro._Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,"awG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,comdat
	.weak	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.p2align	3, 0x0
_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj:
	.quad	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj, 8

	.type	_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,@object # @_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.section	.data.rel.ro._Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,"awG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,comdat
	.weak	_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.p2align	3, 0x0
_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj:
	.quad	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.size	_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj, 8

	.type	_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,@object # @_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.section	.data.rel.ro._Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,"awG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,comdat
	.weak	_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.p2align	3, 0x0
_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj:
	.quad	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.size	_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj, 8

	.type	_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,@object # @_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.section	.data.rel.ro._Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,"awG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj,comdat
	.weak	_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.p2align	3, 0x0
_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj:
	.quad	_Z28__device_stub__mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.size	_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj, 8

	.type	.L.str.37,@object               # @.str.37
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.37:
	.asciz	"no kernel for accum=%d\n"
	.size	.L.str.37, 24

	.type	.L.str.38,@object               # @.str.38
.L.str.38:
	.asciz	"vector::_M_realloc_append"
	.size	.L.str.38, 26

	.type	.L__unnamed_1,@object           # @0
.L__unnamed_1:
	.asciz	"_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj"
	.size	.L__unnamed_1, 66

	.type	.L__unnamed_2,@object           # @1
.L__unnamed_2:
	.asciz	"_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj"
	.size	.L__unnamed_2, 66

	.type	.L__unnamed_3,@object           # @2
.L__unnamed_3:
	.asciz	"_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj"
	.size	.L__unnamed_3, 66

	.type	.L__unnamed_4,@object           # @3
.L__unnamed_4:
	.asciz	"_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj"
	.size	.L__unnamed_4, 66

	.type	.L__unnamed_5,@object           # @4
.L__unnamed_5:
	.asciz	"_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj"
	.size	.L__unnamed_5, 66

	.type	.L__unnamed_6,@object           # @5
.L__unnamed_6:
	.asciz	"_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj"
	.size	.L__unnamed_6, 66

	.type	.L__unnamed_7,@object           # @6
.L__unnamed_7:
	.asciz	"_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj"
	.size	.L__unnamed_7, 66

	.type	.L__unnamed_8,@object           # @7
.L__unnamed_8:
	.asciz	"_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj"
	.size	.L__unnamed_8, 66

	.type	.L__unnamed_9,@object           # @8
.L__unnamed_9:
	.asciz	"_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj"
	.size	.L__unnamed_9, 66

	.type	.L__unnamed_10,@object          # @9
.L__unnamed_10:
	.asciz	"_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj"
	.size	.L__unnamed_10, 66

	.type	.L__unnamed_11,@object          # @10
.L__unnamed_11:
	.asciz	"_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj"
	.size	.L__unnamed_11, 66

	.type	__hip_fatbin_wrapper,@object    # @__hip_fatbin_wrapper
	.section	.hipFatBinSegment,"aw",@progbits
	.p2align	3, 0x0
__hip_fatbin_wrapper:
	.long	1212764230                      # 0x48495046
	.long	1                               # 0x1
	.quad	__hip_fatbin_dfe6ff6a84b3117c
	.quad	0
	.size	__hip_fatbin_wrapper, 24

	.type	__hip_gpubin_handle_dfe6ff6a84b3117c,@object # @__hip_gpubin_handle_dfe6ff6a84b3117c
	.local	__hip_gpubin_handle_dfe6ff6a84b3117c
	.comm	__hip_gpubin_handle_dfe6ff6a84b3117c,8,8
	.section	.init_array,"aw",@init_array
	.p2align	3, 0x0
	.quad	__hip_module_ctor
	.type	__hip_cuid_dfe6ff6a84b3117c,@object # @__hip_cuid_dfe6ff6a84b3117c
	.bss
	.globl	__hip_cuid_dfe6ff6a84b3117c
__hip_cuid_dfe6ff6a84b3117c:
	.byte	0                               # 0x0
	.size	__hip_cuid_dfe6ff6a84b3117c, 1

	.type	.Lstr,@object                   # @str
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lstr:
	.asciz	"\nverify complete"
	.size	.Lstr, 17

	.hidden	DW.ref.__gxx_personality_v0
	.weak	DW.ref.__gxx_personality_v0
	.section	.data.DW.ref.__gxx_personality_v0,"awG",@progbits,DW.ref.__gxx_personality_v0,comdat
	.p2align	3, 0x0
	.type	DW.ref.__gxx_personality_v0,@object
	.size	DW.ref.__gxx_personality_v0, 8
DW.ref.__gxx_personality_v0:
	.quad	__gxx_personality_v0
	.ident	"AMD clang version 22.0.0git (/srcdest/rocm-llvm f58b06dce1f9c15707c5f808fd002e18c2accf7e)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym __gxx_personality_v0
	.addrsig_sym _Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
	.addrsig_sym _Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
	.addrsig_sym _Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
	.addrsig_sym _Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
	.addrsig_sym _Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
	.addrsig_sym _Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
	.addrsig_sym _Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.addrsig_sym _Z28__device_stub__mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.addrsig_sym _Z28__device_stub__mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.addrsig_sym _Z28__device_stub__mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.addrsig_sym _Z28__device_stub__mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.addrsig_sym __hip_module_ctor
	.addrsig_sym __hip_module_dtor
	.addrsig_sym _Unwind_Resume
	.addrsig_sym _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
	.addrsig_sym _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi1EEvPKvS2_S2_Pfjjjj
	.addrsig_sym _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
	.addrsig_sym _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi2EEvPKvS2_S2_Pfjjjj
	.addrsig_sym _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
	.addrsig_sym _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi3EEvPKvS2_S2_Pfjjjj
	.addrsig_sym _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.addrsig_sym _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.addrsig_sym _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.addrsig_sym _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.addrsig_sym _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0ELi0EEvPKvS2_S2_Pfjjjj
	.addrsig_sym __hip_fatbin_dfe6ff6a84b3117c
	.addrsig_sym __hip_fatbin_wrapper
	.addrsig_sym __hip_cuid_dfe6ff6a84b3117c

# __CLANG_OFFLOAD_BUNDLE____END__ host-x86_64-pc-linux-gnu-
