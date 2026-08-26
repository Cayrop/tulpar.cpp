	.amdgcn_target "amdgcn-amd-amdhsa--gfx1101"
	.amdhsa_code_object_version 6
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj
; %bb.0:
	v_bfe_u32 v14, v0, 10, 10
	v_and_b32_e32 v12, 0x3ff, v0
	s_mov_b32 s6, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v2, v14, 5, v12
	v_cmpx_gt_u32_e32 0x100, v2
	s_cbranch_execz .LBB0_9
; %bb.1:                                ; %.lr.ph.preheader
	v_lshlrev_b32_e32 v3, 2, v2
	s_getpc_b64 s[4:5]
	s_add_u32 s4, s4, _ZL11iq3xxs_grid@rel32@lo+4
	s_addc_u32 s5, s5, _ZL11iq3xxs_grid@rel32@hi+12
	v_cmp_gt_u32_e32 vcc_lo, 0xe0, v2
	global_load_b32 v0, v3, s[4:5]
	s_waitcnt vmcnt(0)
	ds_store_b32 v3, v0
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB0_9
; %bb.2:                                ; %.lr.ph.1
	v_add_co_u32 v0, s4, s4, v3
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v1, null, s5, 0, s4
	s_mov_b32 s4, exec_lo
	global_load_b32 v4, v[0:1], off offset:128
	s_waitcnt vmcnt(0)
	ds_store_b32 v3, v4 offset:128
	v_cmpx_gt_u32_e32 0xc0, v2
	s_xor_b32 s4, exec_lo, s4
	s_cbranch_execz .LBB0_9
; %bb.3:                                ; %.lr.ph.2
	global_load_b32 v4, v[0:1], off offset:256
	s_mov_b32 s4, exec_lo
	s_waitcnt vmcnt(0)
	ds_store_b32 v3, v4 offset:256
	v_cmpx_gt_u32_e32 0xa0, v2
	s_xor_b32 s4, exec_lo, s4
	s_cbranch_execz .LBB0_9
; %bb.4:                                ; %.lr.ph.3
	global_load_b32 v4, v[0:1], off offset:384
	s_mov_b32 s4, exec_lo
	s_waitcnt vmcnt(0)
	ds_store_b32 v3, v4 offset:384
	v_cmpx_gt_u32_e32 0x80, v2
	s_xor_b32 s4, exec_lo, s4
	s_cbranch_execz .LBB0_9
; %bb.5:                                ; %.lr.ph.4
	global_load_b32 v4, v[0:1], off offset:512
	s_mov_b32 s4, exec_lo
	s_waitcnt vmcnt(0)
	ds_store_b32 v3, v4 offset:512
	v_cmpx_gt_u32_e32 0x60, v2
	s_xor_b32 s4, exec_lo, s4
	s_cbranch_execz .LBB0_9
; %bb.6:                                ; %.lr.ph.5
	global_load_b32 v4, v[0:1], off offset:640
	s_mov_b32 s4, exec_lo
	s_waitcnt vmcnt(0)
	ds_store_b32 v3, v4 offset:640
	v_cmpx_gt_u32_e32 64, v2
	s_xor_b32 s4, exec_lo, s4
	s_cbranch_execz .LBB0_9
; %bb.7:                                ; %.lr.ph.6
	global_load_b32 v0, v[0:1], off offset:768
	s_mov_b32 s4, exec_lo
	s_waitcnt vmcnt(0)
	ds_store_b32 v3, v0 offset:768
	v_cmpx_gt_u32_e32 32, v2
	s_xor_b32 s4, exec_lo, s4
	s_cbranch_execz .LBB0_9
; %bb.8:                                ; %.lr.ph.7
	v_lshlrev_b32_e32 v0, 2, v12
	s_getpc_b64 s[4:5]
	s_add_u32 s4, s4, _ZL11iq3xxs_grid@rel32@lo+900
	s_addc_u32 s5, s5, _ZL11iq3xxs_grid@rel32@hi+908
	global_load_b32 v1, v0, s[4:5]
	s_waitcnt vmcnt(0)
	ds_store_b32 v0, v1 offset:896
.LBB0_9:                                ; %._crit_edge
	s_or_b32 exec_lo, exec_lo, s6
	s_clause 0x1
	s_load_b128 s[20:23], s[0:1], 0x20
	s_load_b256 s[24:31], s[0:1], 0x0
	v_lshrrev_b32_e32 v16, 3, v2
	v_mov_b32_e32 v13, 0
	v_mov_b32_e32 v15, 0
	s_mov_b32 s34, exec_lo
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_lshr_b32 s33, s20, 8
	s_delay_alu instid0(SALU_CYCLE_1)
	v_cmpx_gt_u32_e64 s33, v16
	s_cbranch_execz .LBB0_13
; %bb.10:                               ; %.lr.ph138
	v_lshl_add_u32 v0, v14, 5, v12
	s_mul_i32 s0, s22, s3
	v_dual_mov_b32 v15, 0 :: v_dual_and_b32 v4, 7, v12
	s_mul_hi_u32 s1, s0, 36
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_lshrrev_b32_e32 v2, 3, v0
	s_mul_i32 s0, s0, 36
	v_mov_b32_e32 v13, 0
	v_mad_u64_u32 v[0:1], null, 0x120, v2, s[0:1]
	v_lshlrev_b32_e32 v2, 1, v12
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_and_b32_e32 v5, 14, v2
	v_mad_u64_u32 v[2:3], null, v4, 36, v[0:1]
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_lshlrev_b32_e32 v0, 1, v5
	v_lshlrev_b32_e32 v17, 1, v5
	v_add_co_u32 v1, vcc_lo, s28, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_add_co_ci_u32_e64 v2, null, s29, v3, vcc_lo
	v_lshlrev_b32_e32 v18, 1, v0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v8, vcc_lo, v1, 32
	v_add_co_ci_u32_e64 v9, null, 0, v2, vcc_lo
	s_mul_i32 s29, s21, s2
	s_mov_b32 s28, 0
.LBB0_11:                               ; %.preheader127
                                        ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v29, s29, v16
	s_clause 0x2
	global_load_b32 v20, v[8:9], off
	global_load_b128 v[0:3], v[8:9], off offset:-32
	global_load_b128 v[4:7], v[8:9], off offset:-16
	v_mov_b16_e32 v19.l, 0
	v_add_nc_u32_e32 v16, 4, v16
	v_mad_i64_i32 v[10:11], null, 0x42, v29, s[24:25]
	v_mad_i64_i32 v[36:37], null, 0x42, v29, s[26:27]
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_4) | instid1(VALU_DEP_1)
	v_mov_b16_e32 v29.h, v19.l
	v_mov_b16_e32 v30.h, v19.l
	v_mov_b16_e32 v33.h, v19.l
	v_mov_b16_e32 v35.h, v19.l
	v_add_co_u32 v31, vcc_lo, v10, v18
	v_add_co_ci_u32_e64 v32, null, 0, v11, vcc_lo
	v_add_co_u32 v38, vcc_lo, v10, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v39, null, 0, v11, vcc_lo
	v_add_co_u32 v40, vcc_lo, v36, v18
	v_add_co_ci_u32_e64 v41, null, 0, v37, vcc_lo
	v_add_co_u32 v42, vcc_lo, v36, v17
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v43, null, 0, v37, vcc_lo
	s_clause 0x1
	global_load_b64 v[44:45], v[31:32], off
	global_load_b32 v32, v[38:39], off offset:64
	s_clause 0x1
	global_load_b64 v[38:39], v[40:41], off
	global_load_b32 v31, v[42:43], off offset:64
	global_load_d16_hi_b16 v0, v[10:11], off offset:64
	global_load_d16_b16 v10, v[36:37], off offset:64
	v_mov_b16_e32 v34.h, v19.l
	v_mov_b16_e32 v21.h, v19.l
	v_mov_b16_e32 v22.h, v19.l
	v_mov_b16_e32 v23.h, v19.l
	v_mov_b16_e32 v24.h, v19.l
	v_mov_b16_e32 v26.h, v19.l
	v_mov_b16_e32 v25.h, v19.l
	v_mov_b16_e32 v27.h, v19.l
	v_mov_b16_e32 v28.h, v19.l
	s_waitcnt vmcnt(5)
	v_and_b32_e32 v11, 0xff, v44
	s_waitcnt vmcnt(4)
	v_and_b32_e32 v37, 0xff, v32
	v_lshrrev_b32_e32 v36, 6, v44
	v_lshrrev_b32_e32 v40, 14, v44
	v_lshrrev_b32_e32 v41, 22, v44
	v_bfe_u32 v48, v32, 21, 8
	v_bcnt_u32_b32 v51, v37, 0
	v_and_b32_e32 v43, 0xff, v45
	v_lshrrev_b32_e32 v44, 6, v45
	v_bfe_u32 v42, v32, 7, 8
	v_bfe_u32 v46, v32, 14, 8
	v_lshrrev_b32_e32 v47, 14, v45
	v_lshrrev_b32_e32 v45, 22, v45
	v_lshlrev_b32_e32 v11, 2, v11
	v_and_b32_e32 v51, 1, v51
	v_and_b32_e32 v36, 0x3fc, v36
	v_and_b32_e32 v40, 0x3fc, v40
	v_and_b32_e32 v41, 0x3fc, v41
	v_bcnt_u32_b32 v62, v48, 0
	v_lshlrev_b32_e32 v43, 2, v43
	v_and_b32_e32 v44, 0x3fc, v44
	s_waitcnt vmcnt(3)
	v_and_b32_e32 v52, 0xff, v38
	v_lshrrev_b32_e32 v53, 6, v38
	v_lshrrev_b32_e32 v54, 14, v38
	v_lshrrev_b32_e32 v55, 22, v38
	s_waitcnt vmcnt(2)
	v_bfe_u32 v38, v31, 7, 8
	v_bfe_u32 v50, v31, 14, 8
	v_bcnt_u32_b32 v60, v42, 0
	v_bcnt_u32_b32 v61, v46, 0
	v_and_b32_e32 v47, 0x3fc, v47
	v_and_b32_e32 v45, 0x3fc, v45
	ds_load_b32 v67, v11
	ds_load_b32 v68, v36
	ds_load_b32 v69, v40
	ds_load_b32 v70, v41
	ds_load_b32 v71, v43
	ds_load_b32 v72, v44
	ds_load_b32 v73, v47
	ds_load_b32 v74, v45
	v_lshlrev_b32_e32 v44, 7, v51
	v_and_b32_e32 v49, 0xff, v31
	v_and_b32_e32 v56, 0xff, v39
	v_lshrrev_b32_e32 v57, 6, v39
	v_lshrrev_b32_e32 v58, 14, v39
	v_lshrrev_b32_e32 v59, 22, v39
	v_bfe_u32 v39, v31, 21, 8
	v_and_b32_e32 v11, 1, v62
	v_bcnt_u32_b32 v64, v38, 0
	v_bcnt_u32_b32 v65, v50, 0
	v_and_b32_e32 v60, 1, v60
	v_and_b32_e32 v61, 1, v61
	v_xor_b32_e32 v37, v44, v37
	v_bcnt_u32_b32 v63, v49, 0
	v_bcnt_u32_b32 v66, v39, 0
	v_lshlrev_b32_e32 v11, 7, v11
	v_and_b32_e32 v40, 1, v64
	v_and_b32_e32 v41, 1, v65
	v_lshlrev_b32_e32 v45, 7, v60
	v_lshlrev_b32_e32 v47, 7, v61
	v_mul_lo_u32 v37, 0x1010101, v37
	v_and_b32_e32 v36, 1, v63
	v_and_b32_e32 v43, 1, v66
	v_xor_b32_e32 v11, v11, v48
	v_lshlrev_b32_e32 v40, 7, v40
	v_lshlrev_b32_e32 v41, 7, v41
	v_xor_b32_e32 v42, v45, v42
	v_xor_b32_e32 v44, v47, v46
	v_lshlrev_b32_e32 v36, 7, v36
	v_lshlrev_b32_e32 v43, 7, v43
	v_mul_lo_u32 v61, 0x1010101, v11
	v_and_b32_e32 v11, 0x8040201, v37
	v_xor_b32_e32 v38, v40, v38
	v_xor_b32_e32 v40, v41, v50
	v_mul_lo_u32 v41, 0x1010101, v42
	v_mul_lo_u32 v60, 0x1010101, v44
	v_xor_b32_e32 v36, v36, v49
	v_xor_b32_e32 v39, v43, v39
	v_lshrrev_b32_e32 v85, 24, v11
	v_mul_lo_u32 v63, 0x1010101, v38
	v_bfe_i32 v38, v37, 0, 1
	v_mul_lo_u32 v62, 0x1010101, v36
	v_mul_lo_u32 v65, 0x1010101, v39
	v_lshrrev_b32_e32 v36, 18, v37
	v_and_b32_e32 v39, 0x80402010, v37
	v_lshrrev_b32_e32 v37, 22, v37
	v_and_b32_e32 v44, 0x80402010, v41
	v_bfe_i32 v47, v60, 0, 1
	s_waitcnt vmcnt(0)
	v_lshrrev_b16 v10.h, 8, v11.l
	v_cmp_ne_u16_e64 s7, 0, v85.l
	v_mul_lo_u32 v64, 0x1010101, v40
	v_and_b32_e32 v40, 0x8040201, v41
	v_and_b32_e32 v49, 0x8040201, v61
	v_lshrrev_b32_e32 v87, 24, v39
	v_lshrrev_b16 v11.h, 8, v39.l
	v_lshrrev_b16 v29.l, 4, v39.l
	v_bfe_i32 v88, v37, 0, 1
	v_lshrrev_b32_e32 v39, 24, v44
	v_mov_b16_e32 v37.l, v47.l
	v_cndmask_b32_e64 v47, 0, -1, s7
	v_cmp_ne_u16_e64 s7, 0, v10.h
	v_lshrrev_b32_e32 v42, 18, v41
	v_bfe_i32 v43, v41, 0, 1
	v_lshrrev_b32_e32 v41, 22, v41
	v_and_b32_e32 v45, 0x8040201, v60
	v_and_b32_e32 v48, 0x80402010, v60
	v_bfe_i32 v50, v61, 0, 1
	v_and_b32_e32 v66, 0x8040201, v62
	v_and_b32_e32 v82, 0x80402010, v64
	v_mov_b16_e32 v11.l, v38.l
	v_lshrrev_b32_e32 v38, 24, v40
	v_lshrrev_b16 v19.h, 8, v40.l
	v_cmp_ne_u16_e64 s12, 0, v39.l
	v_lshrrev_b32_e32 v39, 24, v49
	v_lshrrev_b16 v24.l, 8, v49.l
	v_cndmask_b32_e64 v49, 0, -1, s7
	v_cmp_ne_u16_e64 s7, 0, v87.l
	v_and_b32_e32 v76, 0x80402010, v62
	v_lshrrev_b16 v21.l, 8, v44.l
	v_bfe_i32 v90, v41, 0, 1
	v_lshrrev_b32_e32 v40, 24, v45
	v_lshrrev_b16 v22.l, 8, v45.l
	v_lshrrev_b32_e32 v41, 24, v48
	v_cmp_ne_u16_e64 s11, 0, v38.l
	v_mov_b16_e32 v38.l, v50.l
	v_lshrrev_b16 v26.l, 8, v66.l
	v_lshrrev_b32_e32 v45, 24, v82
	v_cndmask_b32_e64 v50, 0, -1, s7
	v_cmp_ne_u16_e64 s7, 0, v11.h
	v_cmp_ne_u16_e64 s8, 0, v19.h
	v_and_b32_e32 v51, 0x80402010, v61
	v_and_b32_e32 v77, 0x8040201, v63
	v_and_b32_e32 v79, 0x80402010, v63
	v_cmp_ne_u16_e64 s14, 0, v41.l
	v_lshrrev_b32_e32 v41, 24, v66
	v_cmp_ne_u16_e64 s15, 0, v26.l
	v_lshrrev_b16 v26.l, 8, v76.l
	v_cndmask_b32_e64 v66, 0, -1, s7
	v_cmp_ne_u16_e64 s7, 0, v45.l
	v_cndmask_b32_e64 v45, 0, -1, s8
	v_cmp_ne_u16_e64 s8, 0, v21.l
	v_bfe_i32 v75, v62, 0, 1
	v_bfe_i32 v78, v63, 0, 1
	v_and_b32_e32 v83, 0x8040201, v65
	v_bfe_i32 v89, v42, 0, 1
	v_lshrrev_b16 v30.l, 4, v44.l
	v_lshrrev_b16 v23.l, 8, v48.l
	v_cmp_ne_u16_e64 s13, 0, v40.l
	v_lshrrev_b32_e32 v40, 24, v51
	v_lshrrev_b32_e32 v42, 24, v76
	v_lshrrev_b16 v35.l, 4, v76.l
	v_lshrrev_b16 v27.l, 8, v77.l
	v_cmp_ne_u16_e64 s16, 0, v26.l
	v_lshrrev_b32_e32 v44, 24, v79
	v_cndmask_b32_e64 v76, 0, -1, s8
	v_cmp_ne_u16_e64 s8, 0, v22.l
	v_mov_b16_e32 v21.l, v47.l
	v_and_b32_e32 v80, 0x8040201, v64
	v_bfe_i32 v86, v36, 0, 1
	v_mov_b16_e32 v36.l, v43.l
	v_lshrrev_b16 v33.l, 4, v48.l
	v_cmp_ne_u16_e64 s10, 0, v39.l
	v_mov_b16_e32 v39.l, v75.l
	v_cmp_ne_u16_e64 s5, 0, v40.l
	v_lshrrev_b32_e32 v43, 24, v77
	v_mov_b16_e32 v40.l, v78.l
	v_lshrrev_b16 v26.l, 8, v79.l
	v_cmp_ne_u16_e64 s17, 0, v27.l
	v_cmp_ne_u16_e64 s6, 0, v44.l
	v_lshrrev_b32_e32 v44, 24, v83
	v_bfe_i32 v75, v29, 0, 1
	v_bfe_i32 v77, v30, 0, 1
	v_cndmask_b32_e64 v78, 0, -1, s8
	v_cmp_ne_u16_e64 s8, 0, v23.l
	v_lshlrev_b16 v36.h, 8, v21.l
	v_mov_b16_e32 v21.l, v49.l
	v_cndmask_b32_e64 v49, 0, -1, s16
	v_mov_b16_e32 v23.l, v45.l
	v_cmp_ne_u16_e64 s0, 0, v42.l
	v_lshrrev_b16 v48.l, 4, v79.l
	v_lshrrev_b32_e32 v42, 24, v80
	v_lshrrev_b16 v27.l, 8, v80.l
	v_cmp_ne_u16_e64 s18, 0, v26.l
	v_and_b16 v10.h, 0xff, v36.l
	v_cndmask_b32_e64 v79, 0, -1, s8
	v_bfe_i32 v80, v33, 0, 1
	v_cmp_ne_u16_e64 s8, 0, v44.l
	v_cmp_ne_u16_e64 s9, 0, v24.l
	v_mov_b16_e32 v44.l, v75.l
	v_mov_b16_e32 v24.l, v76.l
	v_mov_b16_e32 v45.l, v77.l
	v_lshlrev_b16 v39.h, 8, v23.l
	v_cndmask_b32_e64 v75, 0, -1, s17
	v_mov_b16_e32 v33.l, v49.l
	v_lshrrev_b32_e32 v46, 18, v60
	v_and_b32_e32 v84, 0x80402010, v65
	v_lshrrev_b16 v34.l, 4, v51.l
	v_cmp_ne_u16_e64 s19, 0, v27.l
	v_mov_b16_e32 v22.l, v66.l
	v_bfe_i32 v66, v35, 0, 1
	v_lshlrev_b16 v40.h, 8, v24.l
	v_or_b16 v23.l, v10.h, v39.h
	v_and_b16 v10.h, 0xff, v45.l
	v_cndmask_b32_e64 v76, 0, -1, s18
	v_bfe_i32 v77, v48, 0, 1
	v_lshlrev_b16 v45.h, 8, v33.l
	v_mov_b16_e32 v33.l, v75.l
	v_bfe_i32 v91, v46, 0, 1
	v_lshrrev_b32_e32 v46, 24, v84
	v_bfe_i32 v81, v64, 0, 1
	v_lshrrev_b16 v26.l, 8, v82.l
	v_lshrrev_b16 v28.l, 8, v83.l
	v_cmp_ne_u16_e64 s1, 0, v42.l
	v_mov_b16_e32 v42.l, v86.l
	v_bfe_i32 v83, v34, 0, 1
	v_or_b16 v24.l, v10.h, v40.h
	v_and_b16 v10.h, 0xff, v40.l
	v_mov_b16_e32 v48.l, v66.l
	v_cndmask_b32_e64 v66, 0, -1, s19
	v_mov_b16_e32 v34.l, v76.l
	v_mov_b16_e32 v49.l, v77.l
	v_lshlrev_b16 v46.h, 8, v33.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v41.l
	v_mov_b16_e32 v41.l, v81.l
	v_cmp_ne_u16_e64 s20, 0, v26.l
	v_and_b16 v26.l, 0xff, v11.l
	v_and_b16 v19.h, 0xff, v42.l
	v_lshlrev_b16 v37.h, 8, v21.l
	v_lshlrev_b16 v47.h, 8, v34.l
	v_or_b16 v33.l, v10.h, v46.h
	v_and_b16 v10.h, 0xff, v49.l
	v_mov_b16_e32 v35.l, v66.l
	v_cmp_ne_u16_e64 s4, 0, v43.l
	v_mov_b16_e32 v43.l, v88.l
	v_or_b16 v19.h, v19.h, v36.h
	v_or_b16 v21.l, v26.l, v37.h
	v_or_b16 v34.l, v10.h, v47.h
	v_and_b16 v10.h, 0xff, v41.l
	v_lshlrev_b16 v48.h, 8, v35.l
	v_lshlrev_b16 v38.h, 8, v22.l
	v_and_b16 v22.l, 0xff, v44.l
	v_lshlrev_b16 v49.h, 8, v50.l
	v_or_b32_e32 v66, v21, v19
	v_or_b16 v35.l, v10.h, v48.h
	v_and_b16 v10.h, 0xff, v43.l
	v_cndmask_b32_e64 v50, 0, -1, s11
	v_mov_b16_e32 v21.l, v89.l
	v_or_b16 v22.l, v22.l, v38.h
	s_waitcnt lgkmcnt(7)
	v_xor_b32_e32 v66, v67, v66
	v_or_b16 v19.h, v10.h, v49.h
	v_lshlrev_b16 v21.h, 8, v50.l
	v_and_b16 v10.h, 0xff, v21.l
	v_cndmask_b32_e64 v50, 0, -1, s12
	v_lshrrev_b16 v25.l, 8, v51.l
	v_or_b32_e32 v67, v22, v19
	v_lshrrev_b16 v51.l, 4, v82.l
	v_or_b16 v19.h, v10.h, v21.h
	v_lshlrev_b16 v10.h, 8, v11.l
	v_mov_b16_e32 v11.l, v90.l
	v_lshlrev_b16 v50.l, 8, v50.l
	s_waitcnt lgkmcnt(6)
	v_xor_b32_e32 v67, v68, v67
	v_or_b32_e32 v68, v23, v19
	v_cndmask_b32_e64 v81, 0, -1, s9
	v_and_b16 v22.h, 0xff, v11.l
	v_cmp_ne_u16_e64 s9, 0, v25.l
	v_mov_b16_e32 v25.l, v78.l
	v_mov_b16_e32 v22.l, v91.l
	v_cndmask_b32_e64 v23, 0, -1, s13
	v_or_b16 v19.h, v22.h, v50.l
	v_and_b16 v22.h, 0xff00, v66.l
	v_cndmask_b32_e64 v78, 0, -1, s20
	v_bfe_i32 v51, v51, 0, 1
	v_cmp_ne_u16_e64 s21, 0, v28.l
	v_and_b16 v11.h, 0xff, v37.l
	v_sub_nc_i16 v75.l, v22.h, v37.h clamp
	v_lshlrev_b16 v22.h, 8, v66.l
	v_mov_b16_e32 v26.l, v79.l
	v_lshlrev_b16 v41.h, 8, v25.l
	s_waitcnt lgkmcnt(5)
	v_xor_b32_e32 v68, v69, v68
	v_or_b32_e32 v69, v24, v19
	v_sub_nc_i16 v66.l, v22.h, v10.h clamp
	v_and_b16 v10.h, 0xff00, v66.h
	v_lshlrev_b16 v22.h, 8, v66.h
	v_and_b16 v23.h, 0xff00, v67.l
	v_lshlrev_b16 v42.h, 8, v26.l
	v_or_b16 v26.l, v11.h, v41.h
	v_sub_nc_i16 v76.l, v10.h, v36.h clamp
	v_lshlrev_b16 v10.h, 8, v42.l
	v_mov_b16_e32 v42.l, v78.l
	v_lshrrev_b32_e32 v24, 22, v60
	v_perm_b32 v60, v66, v75, 0xc0c0105
	v_bfe_i32 v66, v65, 0, 1
	v_sub_nc_i16 v77.l, v22.h, v10.h clamp
	v_and_b16 v10.h, 0xff, v22.l
	v_lshlrev_b16 v22.h, 8, v23.l
	v_lshlrev_b16 v23.l, 8, v42.l
	v_cndmask_b32_e64 v79, 0, -1, s21
	v_lshrrev_b16 v27.l, 8, v84.l
	v_bfe_i32 v75, v24, 0, 1
	v_or_b16 v19.h, v10.h, v22.h
	v_and_b16 v10.h, 0xff, v51.l
	v_mov_b16_e32 v24.l, v66.l
	v_perm_b32 v66, v77, v76, 0xc0c0105
	v_cndmask_b32_e64 v76, 0, -1, s14
	s_waitcnt lgkmcnt(4)
	v_xor_b32_e32 v69, v70, v69
	v_or_b16 v78.l, v10.h, v23.l
	v_lshlrev_b16 v10.h, 8, v44.l
	v_sub_nc_i16 v44.l, v23.h, v38.h clamp
	v_lshlrev_b16 v23.h, 8, v67.l
	v_or_b32_e32 v70, v26, v19
	v_mov_b16_e32 v26.l, v79.l
	v_cndmask_b32_e64 v82, 0, -1, s9
	v_cmp_ne_u16_e64 s22, 0, v27.l
	v_sub_nc_i16 v67.l, v23.h, v10.h clamp
	v_and_b16 v10.h, 0xff00, v67.h
	v_mov_b16_e32 v42.l, v75.l
	v_lshlrev_b16 v23.h, 8, v67.h
	v_lshlrev_b16 v24.h, 8, v26.l
	v_lshrrev_b16 v26.l, 4, v84.l
	v_sub_nc_i16 v75.l, v10.h, v49.h clamp
	v_lshlrev_b16 v10.h, 8, v43.l
	v_mov_b16_e32 v43.l, v76.l
	v_cndmask_b32_e64 v85, 0, -1, s15
	v_mov_b16_e32 v30.l, v82.l
	v_lshl_or_b32 v60, v66, 16, v60
	v_sub_nc_i16 v77.l, v23.h, v10.h clamp
	v_and_b16 v10.h, 0xff, v42.l
	v_lshlrev_b16 v23.h, 8, v43.l
	v_cndmask_b32_e64 v66, 0, -1, s22
	v_bfe_i32 v79, v26, 0, 1
	v_lshlrev_b16 v43.h, 8, v30.l
	v_mov_b16_e32 v30.l, v85.l
	v_or_b16 v19.h, v10.h, v23.h
	v_and_b16 v10.h, 0xff, v24.l
	v_mov_b16_e32 v26.l, v66.l
	v_mov_b16_e32 v43.l, v79.l
	v_lshlrev_b16 v44.h, 8, v30.l
	v_cmp_ne_u16_e64 s9, 0, v46.l
	v_or_b16 v76.l, v10.h, v24.h
	v_lshlrev_b16 v10.h, 8, v26.l
	v_and_b16 v26.l, 0xff, v43.l
	v_perm_b32 v66, v67, v44, 0xc0c0105
	v_mov_b16_e32 v46.l, v80.l
	v_lshlrev_b16 v21.l, 8, v21.l
	v_cndmask_b32_e64 v79, 0, -1, s10
	v_or_b16 v67.l, v26.l, v10.h
	v_lshlrev_b32_e32 v26, 2, v52
	v_and_b32_e32 v52, 0x3fc, v53
	v_and_b32_e32 v53, 0x3fc, v54
	v_and_b32_e32 v54, 0x3fc, v55
	v_lshlrev_b32_e32 v55, 2, v56
	v_and_b32_e32 v56, 0x3fc, v57
	v_and_b32_e32 v57, 0x3fc, v58
	v_and_b32_e32 v58, 0x3fc, v59
	ds_load_b32 v59, v26
	ds_load_b32 v52, v52
	ds_load_b32 v53, v53
	ds_load_b32 v54, v54
	ds_load_b32 v55, v55
	ds_load_b32 v56, v56
	ds_load_b32 v57, v57
	ds_load_b32 v58, v58
	v_and_b16 v26.h, 0xff00, v68.l
	v_lshlrev_b16 v26.l, 8, v36.l
	v_perm_b32 v36, v77, v75, 0xc0c0105
	v_and_b16 v11.h, 0xff, v46.l
	s_waitcnt lgkmcnt(11)
	v_xor_b32_e32 v70, v71, v70
	v_sub_nc_i16 v44.l, v26.h, v39.h clamp
	v_lshlrev_b16 v26.h, 8, v68.l
	v_lshl_or_b32 v66, v36, 16, v66
	v_or_b16 v25.l, v11.h, v42.h
	v_lshrrev_b32_e32 v36, 18, v63
	v_lshrrev_b32_e32 v63, 22, v63
	v_sub_nc_i16 v68.l, v26.h, v26.l clamp
	v_and_b16 v26.l, 0xff00, v68.h
	v_or_b32_e32 v71, v25, v19
	v_and_b16 v25.l, 0xff00, v69.l
	v_bfe_i32 v63, v63, 0, 1
	v_lshlrev_b16 v11.l, 8, v11.l
	v_sub_nc_i16 v75.l, v26.l, v21.h clamp
	v_lshrrev_b32_e32 v26, 18, v61
	v_lshlrev_b16 v21.h, 8, v68.h
	v_perm_b32 v68, v68, v44, 0xc0c0105
	v_sub_nc_i16 v44.l, v25.l, v40.h clamp
	v_lshlrev_b16 v25.l, 8, v69.l
	v_bfe_i32 v26, v26, 0, 1
	v_sub_nc_i16 v77.l, v21.h, v21.l clamp
	v_lshrrev_b32_e32 v61, 22, v61
	v_and_b16 v28.l, 0xff, v38.l
	v_mov_b16_e32 v27.l, v81.l
	v_mov_b16_e32 v21.l, v26.l
	v_mov_b16_e32 v26.l, v79.l
	v_lshrrev_b32_e32 v79, 18, v62
	v_perm_b32 v75, v77, v75, 0xc0c0105
	v_bfe_i32 v61, v61, 0, 1
	v_and_b16 v21.h, 0xff, v21.l
	v_lshlrev_b16 v26.l, 8, v26.l
	v_bfe_i32 v77, v79, 0, 1
	v_bfe_i32 v79, v36, 0, 1
	v_and_b16 v36.h, 0xff00, v70.l
	v_cndmask_b32_e64 v82, 0, -1, s5
	v_or_b16 v19.h, v21.h, v26.l
	v_lshlrev_b16 v21.h, 8, v45.l
	v_mov_b16_e32 v47.l, v83.l
	v_lshlrev_b16 v11.h, 8, v27.l
	v_lshrrev_b32_e32 v80, 18, v64
	v_lshrrev_b32_e32 v64, 22, v64
	v_sub_nc_i16 v45.l, v25.l, v21.h clamp
	v_and_b16 v21.h, 0xff00, v69.h
	v_lshrrev_b32_e32 v25, 18, v65
	v_or_b16 v27.l, v28.l, v11.h
	v_and_b16 v28.l, 0xff, v47.l
	v_lshrrev_b32_e32 v65, 22, v65
	v_sub_nc_i16 v50.l, v21.h, v50.l clamp
	v_lshlrev_b16 v21.h, 8, v69.h
	v_bfe_i32 v81, v25, 0, 1
	v_mov_b16_e32 v25.l, v61.l
	s_waitcnt lgkmcnt(10)
	v_xor_b32_e32 v61, v72, v71
	v_cndmask_b32_e64 v72, 0, -1, vcc_lo
	v_sub_nc_i16 v69.l, v21.h, v11.l clamp
	v_lshlrev_b16 v11.l, 8, v37.l
	v_lshlrev_b16 v21.h, 8, v38.l
	v_mov_b16_e32 v38.l, v63.l
	v_perm_b32 v63, v45, v44, 0xc0c0105
	v_sub_nc_i16 v44.l, v36.h, v41.h clamp
	v_lshlrev_b16 v36.h, 8, v70.l
	v_mov_b16_e32 v37.l, v82.l
	v_bfe_i32 v64, v64, 0, 1
	v_mov_b16_e32 v36.l, v77.l
	v_and_b16 v25.h, 0xff, v25.l
	v_sub_nc_i16 v45.l, v36.h, v11.l clamp
	v_and_b16 v11.l, 0xff00, v70.h
	v_lshlrev_b16 v26.h, 8, v37.l
	v_perm_b32 v50, v69, v50, 0xc0c0105
	v_lshlrev_b16 v22.l, 8, v22.l
	v_or_b16 v28.l, v28.l, v43.h
	v_sub_nc_i16 v69.l, v11.l, v22.h clamp
	v_lshlrev_b16 v11.l, 8, v41.l
	v_lshlrev_b16 v22.h, 8, v70.h
	v_mov_b16_e32 v41.l, v72.l
	v_lshrrev_b32_e32 v62, 22, v62
	v_bfe_i32 v65, v65, 0, 1
	v_or_b32_e32 v71, v27, v19
	v_or_b16 v19.h, v25.h, v26.h
	v_lshlrev_b16 v27.h, 8, v40.l
	v_mov_b16_e32 v40.l, v64.l
	v_sub_nc_i16 v64.l, v22.h, v22.l clamp
	v_and_b16 v22.h, 0xff, v36.l
	v_lshlrev_b16 v36.h, 8, v41.l
	v_and_b16 v39.h, 0xff00, v61.l
	v_bfe_i32 v62, v62, 0, 1
	v_dot4_i32_iu8 v37, v60, v1, 0 neg_lo:[1,1,0]
	v_or_b32_e32 v72, v28, v19
	v_or_b16 v19.h, v22.h, v36.h
	v_lshlrev_b16 v22.h, 8, v24.l
	v_mov_b16_e32 v24.l, v65.l
	v_lshlrev_b16 v38.h, 8, v46.l
	v_sub_nc_i16 v65.l, v39.h, v42.h clamp
	v_lshlrev_b16 v39.h, 8, v61.l
	v_bfe_i32 v80, v80, 0, 1
	v_mov_b16_e32 v27.l, v62.l
	v_dot4_i32_iu8 v60, v66, v2, v37 neg_lo:[1,1,0]
	v_cndmask_b32_e64 v62, 0, -1, s0
	v_lshl_or_b32 v66, v75, 16, v68
	v_sub_nc_i16 v61.l, v39.h, v38.h clamp
	v_and_b16 v38.h, 0xff00, v61.h
	v_and_b16 v29.l, 0xff, v39.l
	v_lshlrev_b16 v25.h, 8, v39.l
	v_cndmask_b32_e64 v68, 0, -1, s4
	v_cndmask_b32_e64 v75, 0, -1, s6
	v_mov_b16_e32 v39.l, v80.l
	v_lshlrev_b16 v28.l, 8, v42.l
	v_dot4_i32_iu8 v60, v66, v3, v60 neg_lo:[1,1,0]
	v_mov_b16_e32 v41.l, v62.l
	v_sub_nc_i16 v66.l, v38.h, v23.h clamp
	v_lshlrev_b16 v38.h, 8, v61.h
	v_or_b16 v29.l, v29.l, v44.h
	v_and_b16 v30.l, 0xff, v48.l
	v_mov_b16_e32 v37.l, v79.l
	v_cndmask_b32_e64 v70, 0, -1, s7
	s_waitcnt lgkmcnt(9)
	v_xor_b32_e32 v71, v73, v71
	v_lshl_or_b32 v50, v50, 16, v63
	v_lshlrev_b16 v28.h, 8, v36.l
	v_and_b16 v36.l, 0xff, v27.l
	v_perm_b32 v62, v45, v44, 0xc0c0105
	v_mov_b16_e32 v42.l, v68.l
	v_mov_b16_e32 v44.l, v75.l
	v_sub_nc_i16 v68.l, v38.h, v28.l clamp
	v_and_b16 v28.l, 0xff, v39.l
	v_lshlrev_b16 v38.h, 8, v39.l
	v_and_b16 v39.l, 0xff, v40.l
	v_lshlrev_b16 v39.h, 8, v40.l
	v_lshlrev_b16 v40.l, 8, v41.l
	v_or_b16 v30.l, v30.l, v45.h
	v_cndmask_b32_e64 v77, 0, -1, s1
	v_cndmask_b32_e64 v63, 0, -1, s9
	v_lshlrev_b16 v21.l, 8, v21.l
	v_and_b16 v37.h, 0xff, v37.l
	v_perm_b32 v64, v64, v69, 0xc0c0105
	s_waitcnt lgkmcnt(8)
	v_xor_b32_e32 v69, v74, v72
	v_mov_b16_e32 v46.l, v70.l
	v_or_b32_e32 v70, v29, v19
	v_or_b16 v19.h, v36.l, v40.l
	v_dot4_i32_iu8 v60, v50, v4, v60 neg_lo:[1,1,0]
	v_lshlrev_b16 v41.h, 8, v48.l
	v_lshlrev_b16 v42.l, 8, v42.l
	v_lshlrev_b16 v42.h, 8, v44.l
	v_lshlrev_b16 v44.l, 8, v49.l
	v_and_b16 v48.l, 0xff00, v71.l
	v_lshlrev_b16 v49.l, 8, v71.l
	v_and_b16 v49.h, 0xff00, v71.h
	v_lshlrev_b16 v50.l, 8, v71.h
	v_lshlrev_b16 v25.l, 8, v25.l
	v_and_b16 v23.h, 0xff, v38.l
	v_mov_b16_e32 v45.l, v77.l
	v_mov_b16_e32 v41.l, v63.l
	v_lshlrev_b16 v40.h, 8, v47.l
	v_lshlrev_b16 v47.l, 8, v51.l
	v_lshl_or_b32 v51, v64, 16, v62
	v_perm_b32 v61, v61, v65, 0xc0c0105
	v_perm_b32 v62, v68, v66, 0xc0c0105
	v_sub_nc_i16 v48.l, v48.l, v11.h clamp
	v_sub_nc_i16 v49.l, v49.l, v21.h clamp
	v_sub_nc_i16 v63.l, v49.h, v26.l clamp
	v_sub_nc_i16 v50.l, v50.l, v21.l clamp
	v_and_b16 v11.h, 0xff00, v69.l
	v_lshlrev_b16 v21.l, 8, v69.l
	v_and_b16 v21.h, 0xff00, v69.h
	v_lshlrev_b16 v26.l, 8, v69.h
	s_waitcnt lgkmcnt(7)
	v_xor_b32_e32 v59, v59, v70
	v_or_b32_e32 v30, v30, v19
	v_or_b16 v19.h, v37.h, v42.l
	v_cndmask_b32_e64 v73, 0, -1, s8
	v_lshlrev_b16 v45.l, 8, v45.l
	v_lshl_or_b32 v61, v62, 16, v61
	v_dot4_i32_iu8 v51, v51, v5, v60 neg_lo:[1,1,0]
	v_perm_b32 v49, v49, v48, 0xc0c0105
	v_perm_b32 v50, v50, v63, 0xc0c0105
	v_sub_nc_i16 v48.l, v11.h, v43.h clamp
	v_sub_nc_i16 v60.l, v21.l, v40.h clamp
	v_sub_nc_i16 v62.l, v21.h, v26.h clamp
	v_sub_nc_i16 v26.l, v26.l, v25.l clamp
	v_and_b16 v11.h, 0xff00, v59.l
	v_lshlrev_b16 v21.l, 8, v59.l
	v_and_b16 v21.h, 0xff00, v59.h
	v_lshlrev_b16 v25.l, 8, v59.h
	s_waitcnt lgkmcnt(6)
	v_xor_b32_e32 v30, v52, v30
	v_or_b32_e32 v33, v33, v19
	v_or_b16 v19.h, v23.h, v42.h
	v_mov_b16_e32 v22.l, v81.l
	v_lshlrev_b16 v27.l, 8, v27.l
	v_mov_b16_e32 v36.l, v73.l
	v_lshlrev_b16 v46.l, 8, v46.l
	v_lshl_or_b32 v49, v50, 16, v49
	v_perm_b32 v50, v60, v48, 0xc0c0105
	v_sub_nc_i16 v48.l, v11.h, v44.h clamp
	v_sub_nc_i16 v52.l, v21.l, v25.h clamp
	v_sub_nc_i16 v59.l, v21.h, v36.h clamp
	v_sub_nc_i16 v25.l, v25.l, v28.h clamp
	v_and_b16 v11.h, 0xff00, v30.l
	v_lshlrev_b16 v21.l, 8, v30.l
	v_and_b16 v21.h, 0xff00, v30.h
	v_lshlrev_b16 v23.h, 8, v30.h
	s_waitcnt lgkmcnt(5)
	v_xor_b32_e32 v30, v53, v33
	v_or_b32_e32 v33, v34, v19
	v_or_b16 v19.h, v28.l, v45.l
	v_mov_b16_e32 v78.h, v19.l
	v_lshlrev_b16 v37.l, 8, v37.l
	v_and_b16 v29.l, 0xff, v22.l
	v_lshlrev_b16 v36.l, 8, v36.l
	v_perm_b32 v28, v52, v48, 0xc0c0105
	v_perm_b32 v25, v25, v59, 0xc0c0105
	v_sub_nc_i16 v34.l, v11.h, v45.h clamp
	v_sub_nc_i16 v48.l, v21.l, v41.h clamp
	v_sub_nc_i16 v40.l, v21.h, v40.l clamp
	v_sub_nc_i16 v27.l, v23.h, v27.l clamp
	v_and_b16 v11.h, 0xff00, v30.l
	v_lshlrev_b16 v21.l, 8, v30.l
	v_and_b16 v21.h, 0xff00, v30.h
	v_lshlrev_b16 v23.h, 8, v30.h
	s_waitcnt lgkmcnt(4)
	v_xor_b32_e32 v30, v54, v33
	v_or_b32_e32 v33, v35, v19
	v_or_b16 v19.h, v39.l, v46.l
	v_mov_b16_e32 v76.h, v19.l
	v_lshlrev_b16 v38.l, 8, v38.l
	v_and_b16 v29.h, 0xff, v24.l
	v_lshlrev_b16 v41.l, 8, v41.l
	v_lshl_or_b32 v25, v25, 16, v28
	v_perm_b32 v28, v48, v34, 0xc0c0105
	v_perm_b32 v34, v27, v40, 0xc0c0105
	v_sub_nc_i16 v27.l, v11.h, v46.h clamp
	v_sub_nc_i16 v35.l, v21.l, v27.h clamp
	v_sub_nc_i16 v39.l, v21.h, v42.l clamp
	v_sub_nc_i16 v37.l, v23.h, v37.l clamp
	v_and_b16 v11.h, 0xff00, v30.l
	v_lshlrev_b16 v21.l, 8, v30.l
	v_and_b16 v21.h, 0xff00, v30.h
	v_lshlrev_b16 v23.h, 8, v30.h
	s_waitcnt lgkmcnt(3)
	v_xor_b32_e32 v30, v55, v33
	v_or_b32_e32 v33, v78, v19
	v_or_b16 v19.h, v29.l, v36.l
	v_mov_b16_e32 v67.h, v19.l
	v_lshl_or_b32 v28, v34, 16, v28
	v_dot4_i32_iu8 v25, v25, v1, 0 neg_lo:[1,1,0]
	v_perm_b32 v27, v35, v27, 0xc0c0105
	v_perm_b32 v34, v37, v39, 0xc0c0105
	v_sub_nc_i16 v29.l, v11.h, v47.h clamp
	v_sub_nc_i16 v35.l, v21.l, v44.l clamp
	v_sub_nc_i16 v37.l, v21.h, v42.h clamp
	v_sub_nc_i16 v38.l, v23.h, v38.l clamp
	v_and_b16 v1.l, 0xff00, v30.l
	v_lshlrev_b16 v1.h, 8, v30.l
	v_and_b16 v11.h, 0xff00, v30.h
	v_lshlrev_b16 v21.l, 8, v30.h
	s_waitcnt lgkmcnt(2)
	v_xor_b32_e32 v30, v56, v33
	v_or_b32_e32 v33, v76, v19
	v_or_b16 v19.h, v29.h, v41.l
	v_dot4_i32_iu8 v25, v28, v2, v25 neg_lo:[1,1,0]
	v_lshl_or_b32 v27, v34, 16, v27
	v_perm_b32 v28, v35, v29, 0xc0c0105
	v_perm_b32 v29, v38, v37, 0xc0c0105
	v_sub_nc_i16 v34.l, v1.l, v48.h clamp
	v_sub_nc_i16 v11.l, v1.h, v11.l clamp
	v_sub_nc_i16 v35.l, v11.h, v45.l clamp
	v_sub_nc_i16 v21.l, v21.l, v38.h clamp
	v_and_b16 v1.l, 0xff00, v30.l
	v_lshlrev_b16 v1.h, 8, v30.l
	v_and_b16 v2.l, 0xff00, v30.h
	v_lshlrev_b16 v2.h, 8, v30.h
	s_waitcnt lgkmcnt(1)
	v_xor_b32_e32 v30, v57, v33
	v_or_b32_e32 v19, v67, v19
	v_lshlrev_b16 v22.l, 8, v22.l
	v_lshl_or_b32 v28, v29, 16, v28
	v_dot4_i32_iu8 v3, v27, v3, v25 neg_lo:[1,1,0]
	v_perm_b32 v11, v11, v34, 0xc0c0105
	v_perm_b32 v21, v21, v35, 0xc0c0105
	v_sub_nc_i16 v23.l, v1.l, v23.l clamp
	v_sub_nc_i16 v25.l, v1.h, v47.l clamp
	v_sub_nc_i16 v27.l, v2.l, v46.l clamp
	v_sub_nc_i16 v29.l, v2.h, v39.h clamp
	v_and_b16 v1.l, 0xff00, v30.l
	v_lshlrev_b16 v1.h, 8, v30.l
	v_and_b16 v2.l, 0xff00, v30.h
	v_lshlrev_b16 v2.h, 8, v30.h
	s_waitcnt lgkmcnt(0)
	v_xor_b32_e32 v19, v58, v19
	v_lshlrev_b16 v24.l, 8, v24.l
	v_lshlrev_b16 v43.l, 8, v43.l
	v_dot4_i32_iu8 v3, v28, v4, v3 neg_lo:[1,1,0]
	v_lshl_or_b32 v4, v21, 16, v11
	v_perm_b32 v11, v25, v23, 0xc0c0105
	v_perm_b32 v21, v29, v27, 0xc0c0105
	v_sub_nc_i16 v23.l, v1.l, v24.h clamp
	v_sub_nc_i16 v25.l, v1.h, v22.h clamp
	v_sub_nc_i16 v27.l, v2.l, v36.l clamp
	v_sub_nc_i16 v22.l, v2.h, v22.l clamp
	v_and_b16 v1.l, 0xff00, v19.l
	v_lshlrev_b16 v1.h, 8, v19.l
	v_and_b16 v2.l, 0xff00, v19.h
	v_lshlrev_b16 v2.h, 8, v19.h
	v_lshl_or_b32 v11, v21, 16, v11
	v_dot4_i32_iu8 v3, v4, v5, v3 neg_lo:[1,1,0]
	v_perm_b32 v4, v25, v23, 0xc0c0105
	v_sub_nc_i16 v1.l, v1.l, v10.h clamp
	v_sub_nc_i16 v5.l, v1.h, v43.l clamp
	v_sub_nc_i16 v2.l, v2.l, v41.l clamp
	v_sub_nc_i16 v19.l, v2.h, v24.l clamp
	v_perm_b32 v21, v22, v27, 0xc0c0105
	v_dot4_i32_iu8 v51, v61, v6, v51 neg_lo:[1,1,0]
	v_perm_b32 v26, v26, v62, 0xc0c0105
	v_dot4_i32_iu8 v3, v11, v6, v3 neg_lo:[1,1,0]
	v_perm_b32 v1, v5, v1, 0xc0c0105
	v_perm_b32 v2, v19, v2, 0xc0c0105
	v_lshl_or_b32 v4, v21, 16, v4
	v_lshl_or_b32 v5, v26, 16, v50
	v_dot4_i32_iu8 v6, v49, v7, v51 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v11, 28, v31
	v_lshl_or_b32 v1, v2, 16, v1
	v_dot4_i32_iu8 v2, v4, v7, v3 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v7, 28, v32
	v_dot4_i32_iu8 v5, v5, v20, v6 neg_lo:[1,1,0]
	v_add_co_u32 v8, vcc_lo, 0x480, v8
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_4)
	v_dot4_i32_iu8 v6, v1, v20, v2 neg_lo:[1,1,0]
	v_cmp_le_u32_e64 s0, s33, v16
	v_lshrrev_b32_e32 v1, 31, v5
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshrrev_b32_e32 v2, 31, v6
	s_or_b32 s28, s0, s28
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_nc_u32_e32 v1, v5, v1
	v_add_nc_u32_e32 v2, v6, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_ashrrev_i32_e32 v1, 1, v1
	v_ashrrev_i32_e32 v2, 1, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mad_u64_u32 v[3:4], null, v5, v7, v[1:2]
	v_mad_u64_u32 v[4:5], null, v6, v11, v[2:3]
	v_lshrrev_b32_e32 v1, 31, v3
	v_cvt_f32_f16_e32 v5, v0.l
	v_cvt_f32_f16_e32 v0, v0.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_4)
	v_add_nc_u32_e32 v1, v3, v1
	v_lshrrev_b32_e32 v2, 31, v4
	v_cvt_f32_f16_e32 v3, v10.l
	v_mul_f32_e32 v0, v0, v5
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_ashrrev_i32_e32 v1, 1, v1
	v_dual_mul_f32 v3, v5, v3 :: v_dual_add_nc_u32 v2, v4, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_cvt_f32_i32_e32 v1, v1
	v_ashrrev_i32_e32 v2, 1, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_fmac_f32_e32 v15, v0, v1
	v_cvt_f32_i32_e32 v2, v2
	s_delay_alu instid0(VALU_DEP_1)
	v_fmac_f32_e32 v13, v3, v2
	s_and_not1_b32 exec_lo, exec_lo, s28
	s_cbranch_execnz .LBB0_11
; %bb.12:                               ; %Flow214
	s_or_b32 exec_lo, exec_lo, s28
.LBB0_13:                               ; %Flow215
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s34
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v14
	v_cmpx_ne_u32_e32 0, v14
	s_cbranch_execz .LBB0_15
; %bb.14:                               ; %.preheader
	v_lshlrev_b32_e32 v0, 7, v14
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_add_u32 v0, v12, 2, v0
	v_add_nc_u32_e32 v0, 0x200, v0
	ds_store_2addr_b32 v0, v15, v13 offset0:96 offset1:128
.LBB0_15:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB0_61
; %bb.16:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB0_19
; %bb.17:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB0_20
.LBB0_18:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr4
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr0
	s_branch .LBB0_35
.LBB0_19:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB0_18
.LBB0_20:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i
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
	ds_bpermute_b32 v3, v2, v15
	s_cbranch_scc0 .LBB0_23
; %bb.21:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB0_24
.LBB0_22:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr4
                                        ; implicit-def: $vgpr3
	s_branch .LBB0_35
.LBB0_23:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB0_22
.LBB0_24:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i
	v_xor_b32_e32 v4, 8, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	s_waitcnt lgkmcnt(0)
	v_dual_cndmask_b32 v5, v0, v4 :: v_dual_add_f32 v4, v15, v3
	v_lshlrev_b32_e32 v3, 2, v5
	ds_bpermute_b32 v5, v3, v4
	s_cbranch_scc0 .LBB0_27
; %bb.25:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB0_28
.LBB0_26:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr4
	s_branch .LBB0_35
.LBB0_27:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB0_26
.LBB0_28:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i
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
	s_cbranch_scc0 .LBB0_31
; %bb.29:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB0_32
.LBB0_30:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
	s_branch .LBB0_35
.LBB0_31:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB0_30
.LBB0_32:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i
	v_xor_b32_e32 v7, 2, v0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v7
	s_waitcnt lgkmcnt(0)
	v_dual_cndmask_b32 v8, v0, v7 :: v_dual_add_f32 v7, v5, v6
	v_lshlrev_b32_e32 v5, 2, v8
	ds_bpermute_b32 v6, v5, v7
	s_cbranch_scc0 .LBB0_34
; %bb.33:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_branch .LBB0_35
.LBB0_34:
	s_mov_b32 s0, 0
	s_mov_b32 s4, -1
.LBB0_35:                               ; %Flow191
	s_mov_b32 s1, 0
	s_and_b32 vcc_lo, exec_lo, s0
	s_mov_b32 s0, 0
	s_cbranch_vccnz .LBB0_48
; %bb.36:                               ; %Flow199
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB0_50
.LBB0_37:                               ; %_ZL15warp_reduce_sumILi32EEff.exit
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
	s_cbranch_scc0 .LBB0_39
; %bb.38:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB0_40
	s_branch .LBB0_55
.LBB0_39:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB0_55
.LBB0_40:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i105
	ds_bpermute_b32 v2, v2, v13
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB0_42
; %bb.41:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB0_43
	s_branch .LBB0_55
.LBB0_42:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB0_55
.LBB0_43:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i108
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v13, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v3, v3, v2
	s_cbranch_scc0 .LBB0_45
; %bb.44:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB0_46
	s_branch .LBB0_55
.LBB0_45:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB0_55
.LBB0_46:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i111
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v2, v3
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v3, v4, v2
	s_cbranch_scc0 .LBB0_51
; %bb.47:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_branch .LBB0_52
.LBB0_48:
	s_cbranch_execnz .LBB0_62
; %bb.49:
	s_mov_b32 s0, -1
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB0_37
.LBB0_50:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr1
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB0_57
	s_branch .LBB0_58
.LBB0_51:
	s_mov_b32 s4, 0
.LBB0_52:                               ; %Flow207
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB0_55
; %bb.53:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i114
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v2, v3
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v5, v3
	s_cbranch_scc0 .LBB0_64
; %bb.54:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB0_56
	s_branch .LBB0_65
.LBB0_55:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB0_65
.LBB0_56:                               ; %Flow200
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB0_58
.LBB0_57:                               ; %UnifiedUnreachableBlock
	; divergent unreachable
.LBB0_58:                               ; %Flow211
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB0_61
; %bb.59:                               ; %_ZL15warp_reduce_sumILi32EEff.exit118
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v3, v2
	v_cmp_eq_u32_e32 vcc_lo, 0, v12
	s_mov_b32 s1, 0
	ds_bpermute_b32 v3, v6, v2
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB0_61
; %bb.60:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v2, v3
	s_mul_i32 s0, s23, s3
	v_add_f32_e32 v0, v1, v0
	s_lshl_b64 s[0:1], s[0:1], 2
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_mul_f32_e32 v3, 0xbfb8aa3b, v2
	s_add_u32 s4, s30, s0
	s_addc_u32 s5, s31, s1
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
.LBB0_61:                               ; %UnifiedReturnBlock
	s_endpgm
.LBB0_62:
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
.LBB0_63:                               ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB0_63
.LBB0_64:
	s_mov_b32 s1, -1
	s_branch .LBB0_56
.LBB0_65:
	s_cbranch_execnz .LBB0_67
; %bb.66:
	s_cbranch_execnz .LBB0_57
	s_branch .LBB0_58
.LBB0_67:
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
.LBB0_68:                               ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB0_68
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj
		.amdhsa_group_segment_fixed_size 1280
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
		.amdhsa_next_free_vgpr 92
		.amdhsa_next_free_sgpr 35
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
		.amdhsa_inst_pref_size 60
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end0:
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj, .Lfunc_end0-_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj.num_vgpr, 92
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 35
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 7644
; TotalNumSgprs: 37
; NumVgprs: 92
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 1280 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 11
; NumSGPRsForWavesPerEU: 37
; NumVGPRsForWavesPerEU: 92
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj
; %bb.0:
	v_bfe_u32 v11, v0, 10, 10
	v_and_b32_e32 v10, 0x3ff, v0
	s_mov_b32 s6, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v2, v11, 5, v10
	v_cmpx_gt_u32_e32 0x100, v2
	s_cbranch_execz .LBB1_9
; %bb.1:                                ; %.lr.ph.preheader
	v_lshlrev_b32_e32 v3, 2, v2
	s_getpc_b64 s[4:5]
	s_add_u32 s4, s4, _ZL11iq3xxs_grid@rel32@lo+4
	s_addc_u32 s5, s5, _ZL11iq3xxs_grid@rel32@hi+12
	v_cmp_gt_u32_e32 vcc_lo, 0xe0, v2
	global_load_b32 v0, v3, s[4:5]
	s_waitcnt vmcnt(0)
	ds_store_b32 v3, v0
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB1_9
; %bb.2:                                ; %.lr.ph.1
	v_add_co_u32 v0, s4, s4, v3
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v1, null, s5, 0, s4
	s_mov_b32 s4, exec_lo
	global_load_b32 v4, v[0:1], off offset:128
	s_waitcnt vmcnt(0)
	ds_store_b32 v3, v4 offset:128
	v_cmpx_gt_u32_e32 0xc0, v2
	s_xor_b32 s4, exec_lo, s4
	s_cbranch_execz .LBB1_9
; %bb.3:                                ; %.lr.ph.2
	global_load_b32 v4, v[0:1], off offset:256
	s_mov_b32 s4, exec_lo
	s_waitcnt vmcnt(0)
	ds_store_b32 v3, v4 offset:256
	v_cmpx_gt_u32_e32 0xa0, v2
	s_xor_b32 s4, exec_lo, s4
	s_cbranch_execz .LBB1_9
; %bb.4:                                ; %.lr.ph.3
	global_load_b32 v4, v[0:1], off offset:384
	s_mov_b32 s4, exec_lo
	s_waitcnt vmcnt(0)
	ds_store_b32 v3, v4 offset:384
	v_cmpx_gt_u32_e32 0x80, v2
	s_xor_b32 s4, exec_lo, s4
	s_cbranch_execz .LBB1_9
; %bb.5:                                ; %.lr.ph.4
	global_load_b32 v4, v[0:1], off offset:512
	s_mov_b32 s4, exec_lo
	s_waitcnt vmcnt(0)
	ds_store_b32 v3, v4 offset:512
	v_cmpx_gt_u32_e32 0x60, v2
	s_xor_b32 s4, exec_lo, s4
	s_cbranch_execz .LBB1_9
; %bb.6:                                ; %.lr.ph.5
	global_load_b32 v4, v[0:1], off offset:640
	s_mov_b32 s4, exec_lo
	s_waitcnt vmcnt(0)
	ds_store_b32 v3, v4 offset:640
	v_cmpx_gt_u32_e32 64, v2
	s_xor_b32 s4, exec_lo, s4
	s_cbranch_execz .LBB1_9
; %bb.7:                                ; %.lr.ph.6
	global_load_b32 v0, v[0:1], off offset:768
	s_mov_b32 s4, exec_lo
	s_waitcnt vmcnt(0)
	ds_store_b32 v3, v0 offset:768
	v_cmpx_gt_u32_e32 32, v2
	s_xor_b32 s4, exec_lo, s4
	s_cbranch_execz .LBB1_9
; %bb.8:                                ; %.lr.ph.7
	v_lshlrev_b32_e32 v0, 2, v10
	s_getpc_b64 s[4:5]
	s_add_u32 s4, s4, _ZL11iq3xxs_grid@rel32@lo+900
	s_addc_u32 s5, s5, _ZL11iq3xxs_grid@rel32@hi+908
	global_load_b32 v1, v0, s[4:5]
	s_waitcnt vmcnt(0)
	ds_store_b32 v0, v1 offset:896
.LBB1_9:                                ; %._crit_edge
	s_or_b32 exec_lo, exec_lo, s6
	s_load_b256 s[4:11], s[0:1], 0x10
	v_lshrrev_b32_e32 v13, 3, v2
	v_mov_b32_e32 v12, 0
	s_mov_b32 s14, exec_lo
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_lshr_b32 s8, s8, 8
	s_delay_alu instid0(SALU_CYCLE_1)
	v_cmpx_gt_u32_e64 s8, v13
	s_cbranch_execz .LBB1_13
; %bb.10:                               ; %.lr.ph85
	v_lshl_add_u32 v0, v11, 5, v10
	s_mul_i32 s10, s10, s3
	v_and_b32_e32 v4, 7, v10
	s_mul_hi_u32 s13, s10, 36
	s_mul_i32 s12, s10, 36
	v_lshrrev_b32_e32 v2, 3, v0
	v_dual_mov_b32 v12, 0 :: v_dual_lshlrev_b32 v5, 1, v10
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_4) | instid1(VALU_DEP_1)
	v_mad_u64_u32 v[0:1], null, 0x120, v2, s[12:13]
	s_load_b64 s[12:13], s[0:1], 0x0
	s_mov_b32 s1, 0
	v_mad_u64_u32 v[2:3], null, v4, 36, v[0:1]
	v_and_b32_e32 v0, 14, v5
	v_lshlrev_b32_e32 v1, 1, v0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v2, vcc_lo, s4, v2
	v_add_co_ci_u32_e64 v3, null, s5, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_lshlrev_b32_e32 v14, 1, v1
	v_add_co_u32 v8, vcc_lo, v2, 32
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v9, null, 0, v3, vcc_lo
	v_lshlrev_b32_e32 v15, 1, v0
	s_mul_i32 s4, s9, s2
.LBB1_11:                               ; %.preheader77
                                        ; =>This Inner Loop Header: Depth=1
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_3) | instid1(VALU_DEP_3)
	v_add_nc_u32_e32 v0, s4, v13
	v_mov_b16_e32 v18.l, 0
	v_add_nc_u32_e32 v13, 4, v13
	s_waitcnt lgkmcnt(0)
	v_mad_i64_i32 v[22:23], null, 0x42, v0, s[12:13]
	s_delay_alu instid0(VALU_DEP_3)
	v_mov_b16_e32 v19.h, v18.l
	v_mov_b16_e32 v20.h, v18.l
	v_mov_b16_e32 v21.h, v18.l
	v_mov_b16_e32 v46.h, v18.l
	v_mov_b16_e32 v47.h, v18.l
	v_mov_b16_e32 v48.h, v18.l
	v_add_co_u32 v0, vcc_lo, v22, v14
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v1, null, 0, v23, vcc_lo
	v_add_co_u32 v2, vcc_lo, v22, v15
	v_add_co_ci_u32_e64 v3, null, 0, v23, vcc_lo
	s_clause 0x1
	global_load_b64 v[24:25], v[0:1], off
	global_load_b32 v16, v[2:3], off offset:64
	s_clause 0x2
	global_load_b128 v[0:3], v[8:9], off offset:-32
	global_load_b32 v17, v[8:9], off
	global_load_b128 v[4:7], v[8:9], off offset:-16
	global_load_d16_hi_b16 v0, v[22:23], off offset:64
	v_mov_b16_e32 v49.h, v18.l
	v_mov_b16_e32 v50.h, v18.l
	v_cmp_le_u32_e64 s0, s8, v13
	s_or_b32 s1, s0, s1
	s_waitcnt vmcnt(5)
	v_and_b32_e32 v22, 0xff, v24
	s_waitcnt vmcnt(4)
	v_and_b32_e32 v26, 0xff, v16
	v_lshrrev_b32_e32 v23, 6, v24
	v_lshrrev_b32_e32 v27, 14, v24
	v_lshrrev_b32_e32 v24, 22, v24
	v_and_b32_e32 v29, 0xff, v25
	v_bcnt_u32_b32 v34, v26, 0
	v_bfe_u32 v28, v16, 7, 8
	v_lshrrev_b32_e32 v30, 6, v25
	v_bfe_u32 v31, v16, 14, 8
	v_lshrrev_b32_e32 v32, 14, v25
	v_lshrrev_b32_e32 v25, 22, v25
	v_bfe_u32 v33, v16, 21, 8
	v_lshlrev_b32_e32 v22, 2, v22
	v_and_b32_e32 v34, 1, v34
	v_and_b32_e32 v23, 0x3fc, v23
	v_and_b32_e32 v27, 0x3fc, v27
	v_and_b32_e32 v24, 0x3fc, v24
	v_lshlrev_b32_e32 v29, 2, v29
	v_bcnt_u32_b32 v35, v28, 0
	v_and_b32_e32 v30, 0x3fc, v30
	v_bcnt_u32_b32 v36, v31, 0
	v_and_b32_e32 v32, 0x3fc, v32
	v_and_b32_e32 v25, 0x3fc, v25
	v_bcnt_u32_b32 v37, v33, 0
	ds_load_b32 v51, v22
	ds_load_b32 v52, v23
	ds_load_b32 v53, v27
	ds_load_b32 v54, v24
	ds_load_b32 v55, v29
	ds_load_b32 v56, v30
	ds_load_b32 v57, v32
	ds_load_b32 v58, v25
	v_lshlrev_b32_e32 v23, 7, v34
	v_and_b32_e32 v35, 1, v35
	v_and_b32_e32 v36, 1, v36
	v_and_b32_e32 v22, 1, v37
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_xor_b32_e32 v23, v23, v26
	v_lshlrev_b32_e32 v24, 7, v35
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_lshlrev_b32_e32 v25, 7, v36
	v_lshlrev_b32_e32 v22, 7, v22
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_mul_lo_u32 v23, 0x1010101, v23
	v_xor_b32_e32 v24, v24, v28
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_xor_b32_e32 v25, v25, v31
	v_xor_b32_e32 v22, v22, v33
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_mul_lo_u32 v24, 0x1010101, v24
	v_mul_lo_u32 v25, 0x1010101, v25
	v_and_b32_e32 v26, 0x8040201, v23
	s_delay_alu instid0(VALU_DEP_4)
	v_mul_lo_u32 v22, 0x1010101, v22
	v_lshrrev_b32_e32 v27, 18, v23
	v_bfe_i32 v28, v23, 0, 1
	v_and_b32_e32 v29, 0x80402010, v23
	v_lshrrev_b32_e32 v43, 24, v26
	v_lshrrev_b32_e32 v23, 22, v23
	v_and_b32_e32 v30, 0x8040201, v24
	v_lshrrev_b32_e32 v31, 18, v24
	v_bfe_i32 v32, v24, 0, 1
	v_and_b32_e32 v33, 0x80402010, v24
	v_lshrrev_b32_e32 v24, 22, v24
	v_and_b32_e32 v34, 0x8040201, v25
	v_lshrrev_b32_e32 v35, 18, v25
	v_bfe_i32 v36, v25, 0, 1
	v_and_b32_e32 v37, 0x80402010, v25
	v_lshrrev_b32_e32 v25, 22, v25
	v_and_b32_e32 v38, 0x8040201, v22
	v_lshrrev_b32_e32 v39, 18, v22
	v_bfe_i32 v40, v22, 0, 1
	v_and_b32_e32 v41, 0x80402010, v22
	v_lshrrev_b32_e32 v42, 22, v22
	v_lshrrev_b16 v18.h, 8, v26.l
	v_cmp_ne_u16_e32 vcc_lo, 0, v43.l
	v_mov_b16_e32 v19.l, v28.l
	v_lshrrev_b32_e32 v28, 24, v29
	v_bfe_i32 v44, v23, 0, 1
	v_lshrrev_b32_e32 v45, 24, v30
	v_lshrrev_b16 v21.l, 8, v30.l
	v_bfe_i32 v30, v31, 0, 1
	v_mov_b16_e32 v22.l, v32.l
	v_lshrrev_b32_e32 v31, 24, v33
	v_lshrrev_b16 v22.h, 8, v33.l
	v_lshrrev_b16 v32.l, 4, v33.l
	v_bfe_i32 v33, v24, 0, 1
	v_lshrrev_b32_e32 v59, 24, v34
	v_lshrrev_b16 v23.l, 8, v34.l
	v_bfe_i32 v34, v35, 0, 1
	v_mov_b16_e32 v24.l, v36.l
	v_lshrrev_b32_e32 v35, 24, v37
	v_lshrrev_b16 v23.h, 8, v37.l
	v_lshrrev_b16 v36.l, 4, v37.l
	v_bfe_i32 v37, v25, 0, 1
	v_lshrrev_b32_e32 v60, 24, v38
	v_lshrrev_b16 v24.h, 8, v38.l
	v_bfe_i32 v38, v39, 0, 1
	v_mov_b16_e32 v25.l, v40.l
	v_lshrrev_b32_e32 v39, 24, v41
	v_lshrrev_b16 v25.h, 8, v41.l
	v_lshrrev_b16 v40.l, 4, v41.l
	v_bfe_i32 v41, v42, 0, 1
	v_cndmask_b32_e64 v42, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v18.h
	v_lshrrev_b16 v20.l, 8, v29.l
	v_bfe_i32 v26, v27, 0, 1
	v_and_b16 v26.h, 0xff, v19.l
	v_lshlrev_b16 v27.l, 8, v19.l
	v_cndmask_b32_e64 v43, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v28.l
	v_mov_b16_e32 v19.l, v44.l
	v_lshrrev_b16 v29.l, 4, v29.l
	v_bfe_i32 v66, v32, 0, 1
	v_mov_b16_e32 v28.l, v34.l
	v_cndmask_b32_e64 v44, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v20.l
	v_bfe_i32 v62, v29, 0, 1
	v_mov_b16_e32 v20.l, v30.l
	v_mov_b16_e32 v30.l, v42.l
	v_and_b16 v18.h, 0xff, v26.l
	v_cndmask_b32_e64 v61, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v45.l
	v_mov_b16_e32 v32.l, v44.l
	v_mov_b16_e32 v34.l, v62.l
	v_lshlrev_b16 v28.h, 8, v19.l
	v_lshlrev_b16 v30.l, 8, v30.l
	v_cndmask_b32_e64 v45, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v21.l
	v_mov_b16_e32 v21.l, v33.l
	v_mov_b16_e32 v33.l, v61.l
	v_and_b16 v29.h, 0xff, v20.l
	v_lshlrev_b16 v30.h, 8, v20.l
	v_cndmask_b32_e64 v63, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v31.l
	v_mov_b16_e32 v31.l, v43.l
	v_lshlrev_b16 v32.l, 8, v32.l
	v_lshlrev_b16 v33.l, 8, v33.l
	v_and_b16 v37.h, 0xff, v34.l
	v_cndmask_b32_e64 v64, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v22.h
	v_lshlrev_b16 v31.l, 8, v31.l
	v_or_b16 v18.h, v18.h, v30.l
	v_and_b16 v27.h, 0xff, v22.l
	v_mov_b16_e32 v20.l, v64.l
	v_cndmask_b32_e64 v65, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v59.l
	v_and_b16 v22.h, 0xff, v24.l
	v_bfe_i32 v70, v36, 0, 1
	v_bfe_i32 v74, v40, 0, 1
	v_and_b16 v31.h, 0xff, v21.l
	v_cndmask_b32_e64 v59, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v23.l
	v_lshlrev_b16 v23.l, 8, v24.l
	v_mov_b16_e32 v24.l, v37.l
	v_mov_b16_e32 v36.l, v65.l
	v_mov_b16_e32 v37.l, v66.l
	v_cndmask_b32_e64 v67, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v35.l
	v_mov_b16_e32 v35.l, v63.l
	v_lshlrev_b16 v32.h, 8, v21.l
	v_mov_b16_e32 v21.l, v59.l
	v_lshlrev_b16 v39.h, 8, v20.l
	v_cndmask_b32_e64 v68, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v23.h
	v_lshlrev_b16 v35.l, 8, v35.l
	v_or_b16 v20.l, v37.h, v33.l
	v_mov_b16_e32 v29.l, v38.l
	v_mov_b16_e32 v38.l, v67.l
	v_cndmask_b32_e64 v69, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v60.l
	v_mov_b16_e32 v46.l, v74.l
	v_lshlrev_b16 v36.l, 8, v36.l
	v_and_b16 v40.h, 0xff, v37.l
	v_lshlrev_b16 v41.h, 8, v21.l
	v_cndmask_b32_e64 v60, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v24.h
	v_or_b16 v21.l, v27.h, v35.l
	v_and_b16 v23.h, 0xff, v25.l
	v_lshlrev_b16 v24.h, 8, v25.l
	v_mov_b16_e32 v25.l, v41.l
	v_cndmask_b32_e64 v71, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v39.l
	v_and_b16 v33.h, 0xff, v28.l
	v_mov_b16_e32 v39.l, v68.l
	v_mov_b16_e32 v40.l, v69.l
	v_mov_b16_e32 v41.l, v70.l
	v_cndmask_b32_e64 v72, 0, -1, vcc_lo
	v_cmp_ne_u16_e32 vcc_lo, 0, v25.h
	v_lshlrev_b16 v25.h, 8, v26.l
	v_and_b16 v26.l, 0xff, v19.l
	v_mov_b16_e32 v19.l, v45.l
	v_mov_b16_e32 v44.l, v72.l
	v_cndmask_b32_e64 v73, 0, -1, vcc_lo
	v_lshlrev_b16 v38.l, 8, v38.l
	v_and_b16 v44.h, 0xff, v46.l
	v_lshlrev_b16 v38.h, 8, v19.l
	v_or_b16 v19.l, v26.h, v31.l
	v_mov_b16_e32 v45.l, v73.l
	v_lshlrev_b16 v43.h, 8, v44.l
	v_and_b16 v34.h, 0xff, v24.l
	v_mov_b16_e32 v42.l, v60.l
	v_or_b32_e32 v19, v19, v18
	v_or_b16 v18.h, v26.l, v32.l
	v_lshlrev_b16 v44.l, 8, v45.l
	v_lshlrev_b16 v45.l, 8, v46.l
	v_or_b16 v46.l, v40.h, v36.l
	s_waitcnt lgkmcnt(7)
	v_xor_b32_e32 v26, v51, v19
	v_or_b32_e32 v51, v20, v18
	v_or_b16 v18.h, v29.h, v38.h
	v_mov_b16_e32 v43.l, v71.l
	v_lshlrev_b16 v34.l, 8, v34.l
	v_and_b16 v19.l, 0xff00, v26.l
	v_lshlrev_b16 v19.h, 8, v26.l
	v_and_b16 v20.l, 0xff00, v26.h
	v_lshlrev_b16 v20.h, 8, v26.h
	s_waitcnt lgkmcnt(6)
	v_xor_b32_e32 v26, v52, v51
	v_or_b32_e32 v21, v21, v18
	v_or_b16 v18.h, v31.h, v39.h
	v_lshlrev_b16 v39.l, 8, v39.l
	v_lshlrev_b16 v40.l, 8, v40.l
	v_and_b16 v42.h, 0xff, v41.l
	v_or_b16 v47.l, v22.h, v38.l
	v_sub_nc_i16 v31.l, v19.l, v31.l clamp
	v_sub_nc_i16 v27.l, v19.h, v27.l clamp
	v_sub_nc_i16 v30.l, v20.l, v30.l clamp
	v_sub_nc_i16 v51.l, v20.h, v25.h clamp
	v_and_b16 v19.l, 0xff00, v26.l
	v_lshlrev_b16 v19.h, 8, v26.l
	v_and_b16 v20.l, 0xff00, v26.h
	v_lshlrev_b16 v20.h, 8, v26.h
	s_waitcnt lgkmcnt(5)
	v_xor_b32_e32 v21, v53, v21
	v_or_b32_e32 v26, v46, v18
	v_or_b16 v18.h, v33.h, v41.h
	v_lshlrev_b16 v22.l, 8, v22.l
	v_and_b16 v35.h, 0xff, v29.l
	v_lshlrev_b16 v42.l, 8, v42.l
	v_lshlrev_b16 v43.l, 8, v43.l
	v_or_b16 v48.l, v42.h, v40.l
	v_perm_b32 v27, v27, v31, 0xc0c0105
	v_perm_b32 v31, v51, v30, 0xc0c0105
	v_sub_nc_i16 v30.l, v19.l, v33.l clamp
	v_sub_nc_i16 v33.l, v19.h, v34.l clamp
	v_sub_nc_i16 v32.l, v20.l, v32.l clamp
	v_sub_nc_i16 v34.l, v20.h, v28.h clamp
	v_and_b16 v19.l, 0xff00, v21.l
	v_lshlrev_b16 v19.h, 8, v21.l
	v_and_b16 v20.l, 0xff00, v21.h
	v_lshlrev_b16 v20.h, 8, v21.h
	s_waitcnt lgkmcnt(4)
	v_xor_b32_e32 v21, v54, v26
	v_or_b32_e32 v26, v47, v18
	v_or_b16 v18.h, v34.h, v39.l
	v_and_b16 v36.h, 0xff, v25.l
	v_lshlrev_b16 v37.l, 8, v37.l
	v_or_b16 v49.l, v23.h, v43.l
	v_lshl_or_b32 v27, v31, 16, v27
	v_perm_b32 v31, v33, v30, 0xc0c0105
	v_perm_b32 v33, v34, v32, 0xc0c0105
	v_sub_nc_i16 v30.l, v19.l, v35.l clamp
	v_sub_nc_i16 v22.l, v19.h, v22.l clamp
	v_sub_nc_i16 v32.l, v20.l, v38.h clamp
	v_sub_nc_i16 v34.l, v20.h, v30.h clamp
	v_and_b16 v19.l, 0xff00, v21.l
	v_lshlrev_b16 v19.h, 8, v21.l
	v_and_b16 v20.l, 0xff00, v21.h
	v_lshlrev_b16 v20.h, 8, v21.h
	s_waitcnt lgkmcnt(3)
	v_xor_b32_e32 v21, v55, v26
	v_or_b32_e32 v26, v48, v18
	v_or_b16 v18.h, v35.h, v42.l
	v_lshlrev_b16 v28.l, 8, v28.l
	v_or_b16 v50.l, v44.h, v44.l
	v_lshl_or_b32 v31, v33, 16, v31
	s_waitcnt vmcnt(3)
	v_dot4_i32_iu8 v27, v27, v1, 0 neg_lo:[1,1,0]
	v_perm_b32 v22, v22, v30, 0xc0c0105
	v_perm_b32 v30, v34, v32, 0xc0c0105
	v_sub_nc_i16 v32.l, v19.l, v36.l clamp
	v_sub_nc_i16 v33.l, v19.h, v37.l clamp
	v_sub_nc_i16 v20.l, v20.l, v39.h clamp
	v_sub_nc_i16 v34.l, v20.h, v32.h clamp
	v_and_b16 v1.l, 0xff00, v21.l
	v_lshlrev_b16 v1.h, 8, v21.l
	v_and_b16 v19.l, 0xff00, v21.h
	v_lshlrev_b16 v19.h, 8, v21.h
	s_waitcnt lgkmcnt(2)
	v_xor_b32_e32 v21, v56, v26
	v_or_b32_e32 v26, v49, v18
	v_or_b16 v18.h, v36.h, v43.h
	v_lshlrev_b16 v24.l, 8, v24.l
	v_lshlrev_b16 v41.l, 8, v41.l
	v_dot4_i32_iu8 v27, v31, v2, v27 neg_lo:[1,1,0]
	v_lshl_or_b32 v22, v30, 16, v22
	v_perm_b32 v30, v33, v32, 0xc0c0105
	v_perm_b32 v20, v34, v20, 0xc0c0105
	v_sub_nc_i16 v31.l, v1.l, v38.l clamp
	v_sub_nc_i16 v23.l, v1.h, v23.l clamp
	v_sub_nc_i16 v19.l, v19.l, v41.h clamp
	v_sub_nc_i16 v28.l, v19.h, v28.l clamp
	v_and_b16 v1.l, 0xff00, v21.l
	v_lshlrev_b16 v1.h, 8, v21.l
	v_and_b16 v2.l, 0xff00, v21.h
	v_lshlrev_b16 v2.h, 8, v21.h
	s_waitcnt lgkmcnt(1)
	v_xor_b32_e32 v21, v57, v26
	v_or_b32_e32 v18, v50, v18
	v_lshlrev_b16 v29.l, 8, v29.l
	v_lshl_or_b32 v20, v20, 16, v30
	v_dot4_i32_iu8 v3, v22, v3, v27 neg_lo:[1,1,0]
	v_perm_b32 v22, v23, v31, 0xc0c0105
	v_perm_b32 v19, v28, v19, 0xc0c0105
	v_sub_nc_i16 v23.l, v1.l, v40.l clamp
	v_sub_nc_i16 v26.l, v1.h, v41.l clamp
	v_sub_nc_i16 v27.l, v2.l, v39.l clamp
	v_sub_nc_i16 v24.l, v2.h, v24.l clamp
	v_and_b16 v1.l, 0xff00, v21.l
	v_lshlrev_b16 v1.h, 8, v21.l
	v_and_b16 v2.l, 0xff00, v21.h
	v_lshlrev_b16 v2.h, 8, v21.h
	s_waitcnt lgkmcnt(0)
	v_xor_b32_e32 v18, v58, v18
	v_lshlrev_b16 v25.l, 8, v25.l
	s_waitcnt vmcnt(1)
	v_dot4_i32_iu8 v3, v20, v4, v3 neg_lo:[1,1,0]
	v_lshl_or_b32 v4, v19, 16, v22
	v_perm_b32 v19, v26, v23, 0xc0c0105
	v_perm_b32 v20, v24, v27, 0xc0c0105
	v_sub_nc_i16 v21.l, v1.l, v43.l clamp
	v_sub_nc_i16 v22.l, v1.h, v24.h clamp
	v_sub_nc_i16 v23.l, v2.l, v42.l clamp
	v_sub_nc_i16 v24.l, v2.h, v29.l clamp
	v_and_b16 v1.l, 0xff00, v18.l
	v_lshlrev_b16 v1.h, 8, v18.l
	v_and_b16 v2.l, 0xff00, v18.h
	v_lshlrev_b16 v2.h, 8, v18.h
	v_lshl_or_b32 v18, v20, 16, v19
	v_dot4_i32_iu8 v3, v4, v5, v3 neg_lo:[1,1,0]
	v_perm_b32 v4, v22, v21, 0xc0c0105
	v_sub_nc_i16 v1.l, v1.l, v44.l clamp
	v_sub_nc_i16 v5.l, v1.h, v45.l clamp
	v_sub_nc_i16 v2.l, v2.l, v43.h clamp
	v_sub_nc_i16 v19.l, v2.h, v25.l clamp
	v_perm_b32 v20, v24, v23, 0xc0c0105
	v_dot4_i32_iu8 v3, v18, v6, v3 neg_lo:[1,1,0]
	v_perm_b32 v1, v5, v1, 0xc0c0105
	v_lshrrev_b32_e32 v5, 28, v16
	v_perm_b32 v2, v19, v2, 0xc0c0105
	v_lshl_or_b32 v4, v20, 16, v4
	v_add_co_u32 v8, vcc_lo, 0x480, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_add_co_ci_u32_e64 v9, null, 0, v9, vcc_lo
	v_lshl_or_b32 v1, v2, 16, v1
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v2, v4, v7, v3 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v4, v1, v17, v2 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v1, 31, v4
	v_add_nc_u32_e32 v1, v4, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_ashrrev_i32_e32 v1, 1, v1
	v_mad_u64_u32 v[2:3], null, v4, v5, v[1:2]
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshrrev_b32_e32 v1, 31, v2
	v_add_nc_u32_e32 v1, v2, v1
	s_waitcnt vmcnt(0)
	v_cvt_f32_f16_e32 v2, v0.l
	v_cvt_f32_f16_e32 v0, v0.h
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_ashrrev_i32_e32 v1, 1, v1
	v_mul_f32_e32 v0, v0, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cvt_f32_i32_e32 v1, v1
	v_fmac_f32_e32 v12, v0, v1
	s_and_not1_b32 exec_lo, exec_lo, s1
	s_cbranch_execnz .LBB1_11
; %bb.12:                               ; %Flow132
	s_or_b32 exec_lo, exec_lo, s1
.LBB1_13:                               ; %Flow133
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s14
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v11
	v_cmpx_ne_u32_e32 0, v11
; %bb.14:                               ; %.preheader
	v_lshlrev_b32_e32 v0, 2, v10
	s_delay_alu instid0(VALU_DEP_1)
	v_lshl_add_u32 v0, v11, 7, v0
	ds_store_b32 v0, v12 offset:896
; %bb.15:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB1_33
; %bb.16:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, 0
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB1_19
; %bb.17:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB1_20
.LBB1_18:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr0
	s_branch .LBB1_29
.LBB1_19:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB1_18
.LBB1_20:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i
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
	ds_bpermute_b32 v2, v1, v12
	v_mov_b32_e32 v1, 32
	s_cbranch_scc0 .LBB1_22
; %bb.21:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB1_23
	s_branch .LBB1_28
.LBB1_22:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB1_28
.LBB1_23:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i
	v_xor_b32_e32 v3, 8, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v3
	v_cndmask_b32_e32 v3, v0, v3, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v2, v12, v2 :: v_dual_lshlrev_b32 v3, 2, v3
	ds_bpermute_b32 v3, v3, v2
	s_cbranch_scc0 .LBB1_25
; %bb.24:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB1_26
	s_branch .LBB1_28
.LBB1_25:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB1_28
.LBB1_26:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i
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
	s_cbranch_scc0 .LBB1_34
; %bb.27:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB1_35
.LBB1_28:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
.LBB1_29:                               ; %Flow121
	s_and_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB1_37
; %bb.30:                               ; %Flow129
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB1_33
.LBB1_31:                               ; %_ZL15warp_reduce_sumILi32EEff.exit
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
	s_cbranch_execz .LBB1_33
; %bb.32:
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
.LBB1_33:                               ; %UnifiedReturnBlock
	s_endpgm
.LBB1_34:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB1_28
.LBB1_35:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i
	v_xor_b32_e32 v4, 2, v0
	s_cmp_lg_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v2, v3
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v4, v0, v4, vcc_lo
	v_lshlrev_b32_e32 v2, 2, v4
	ds_bpermute_b32 v2, v2, v3
	s_cbranch_scc0 .LBB1_41
; %bb.36:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_branch .LBB1_29
.LBB1_37:
	s_cbranch_execnz .LBB1_39
; %bb.38:
	; divergent unreachable
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB1_31
	s_branch .LBB1_33
.LBB1_39:
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
.LBB1_40:                               ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB1_40
.LBB1_41:
	s_mov_b32 s1, 0
	s_mov_b32 s0, -1
	s_branch .LBB1_29
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj
		.amdhsa_group_segment_fixed_size 1152
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
		.amdhsa_next_free_vgpr 75
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
		.amdhsa_inst_pref_size 33
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end1:
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj, .Lfunc_end1-_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj.num_vgpr, 75
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 15
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 4160
; TotalNumSgprs: 17
; NumVgprs: 75
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 1152 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 9
; NumSGPRsForWavesPerEU: 17
; NumVGPRsForWavesPerEU: 75
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj
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
	s_cbranch_execz .LBB2_4
; %bb.1:                                ; %.lr.ph
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
.LBB2_2:                                ; %.preheader120
                                        ; =>This Inner Loop Header: Depth=1
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
	s_cbranch_execnz .LBB2_2
; %bb.3:                                ; %Flow202
	s_or_b32 exec_lo, exec_lo, s13
.LBB2_4:                                ; %Flow203
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s1
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v17
	v_cmpx_ne_u32_e32 0, v17
	s_cbranch_execz .LBB2_6
; %bb.5:                                ; %.preheader
	v_lshlrev_b32_e32 v0, 7, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_add_u32 v0, v14, 2, v0
	v_add_nc_u32_e32 v1, 0xffffff80, v0
	ds_store_b32 v1, v16
	ds_store_b32 v0, v15
.LBB2_6:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB2_52
; %bb.7:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB2_10
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB2_11
.LBB2_9:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr4
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr0
	s_branch .LBB2_26
.LBB2_10:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB2_9
.LBB2_11:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i
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
	s_cbranch_scc0 .LBB2_14
; %bb.12:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB2_15
.LBB2_13:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr4
                                        ; implicit-def: $vgpr3
	s_branch .LBB2_26
.LBB2_14:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB2_13
.LBB2_15:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i
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
	s_cbranch_scc0 .LBB2_18
; %bb.16:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB2_19
.LBB2_17:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr4
	s_branch .LBB2_26
.LBB2_18:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB2_17
.LBB2_19:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i
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
	s_cbranch_scc0 .LBB2_22
; %bb.20:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB2_23
.LBB2_21:
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr7
	s_branch .LBB2_26
.LBB2_22:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB2_21
.LBB2_23:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i
	v_xor_b32_e32 v7, 2, v0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v7
	s_waitcnt lgkmcnt(0)
	v_dual_cndmask_b32 v8, v0, v7 :: v_dual_add_f32 v7, v5, v6
	v_lshlrev_b32_e32 v5, 2, v8
	ds_bpermute_b32 v6, v5, v7
	s_cbranch_scc0 .LBB2_25
; %bb.24:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_branch .LBB2_26
.LBB2_25:
	s_mov_b32 s0, 0
	s_mov_b32 s4, -1
.LBB2_26:                               ; %Flow179
	s_mov_b32 s1, 0
	s_and_b32 vcc_lo, exec_lo, s0
	s_mov_b32 s0, 0
	s_cbranch_vccnz .LBB2_39
; %bb.27:                               ; %Flow187
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB2_41
.LBB2_28:                               ; %_ZL15warp_reduce_sumILi32EEff.exit
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
	s_cbranch_scc0 .LBB2_30
; %bb.29:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB2_31
	s_branch .LBB2_46
.LBB2_30:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB2_46
.LBB2_31:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i98
	ds_bpermute_b32 v2, v2, v15
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB2_33
; %bb.32:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB2_34
	s_branch .LBB2_46
.LBB2_33:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB2_46
.LBB2_34:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i101
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v15, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v3, v3, v2
	s_cbranch_scc0 .LBB2_36
; %bb.35:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB2_37
	s_branch .LBB2_46
.LBB2_36:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB2_46
.LBB2_37:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i104
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v2, v3
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v3, v4, v2
	s_cbranch_scc0 .LBB2_42
; %bb.38:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_branch .LBB2_43
.LBB2_39:
	s_cbranch_execnz .LBB2_53
; %bb.40:
	s_mov_b32 s0, -1
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB2_28
.LBB2_41:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr1
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB2_48
	s_branch .LBB2_49
.LBB2_42:
	s_mov_b32 s4, 0
.LBB2_43:                               ; %Flow195
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB2_46
; %bb.44:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i107
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v2, v3
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v5, v3
	s_cbranch_scc0 .LBB2_55
; %bb.45:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB2_47
	s_branch .LBB2_56
.LBB2_46:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB2_56
.LBB2_47:                               ; %Flow188
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB2_49
.LBB2_48:                               ; %UnifiedUnreachableBlock
	; divergent unreachable
.LBB2_49:                               ; %Flow199
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB2_52
; %bb.50:                               ; %_ZL15warp_reduce_sumILi32EEff.exit111
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v3, v2
	v_cmp_eq_u32_e32 vcc_lo, 0, v14
	s_mov_b32 s1, 0
	ds_bpermute_b32 v3, v6, v2
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB2_52
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
.LBB2_52:                               ; %UnifiedReturnBlock
	s_endpgm
.LBB2_53:
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
.LBB2_54:                               ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB2_54
.LBB2_55:
	s_mov_b32 s1, -1
	s_branch .LBB2_47
.LBB2_56:
	s_cbranch_execnz .LBB2_58
; %bb.57:
	s_cbranch_execnz .LBB2_48
	s_branch .LBB2_49
.LBB2_58:
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
.LBB2_59:                               ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB2_59
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj
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
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end2:
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj, .Lfunc_end2-_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_vgpr, 33
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 18
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
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
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
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
	s_cbranch_execz .LBB3_4
; %bb.1:                                ; %.lr.ph
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
.LBB3_2:                                ; %.preheader70
                                        ; =>This Inner Loop Header: Depth=1
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
	s_cbranch_execnz .LBB3_2
; %bb.3:                                ; %Flow120
	s_or_b32 exec_lo, exec_lo, s4
.LBB3_4:                                ; %Flow121
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s8
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v12
	v_cmpx_ne_u32_e32 0, v12
	s_cbranch_execz .LBB3_6
; %bb.5:                                ; %.preheader
	v_lshlrev_b32_e32 v0, 7, v12
	v_lshlrev_b32_e32 v1, 2, v10
	s_delay_alu instid0(VALU_DEP_1)
	v_add3_u32 v0, v0, v1, 0xffffff80
	ds_store_b32 v0, v11
.LBB3_6:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB3_24
; %bb.7:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, 0
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB3_10
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB3_11
.LBB3_9:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr0
	s_branch .LBB3_20
.LBB3_10:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB3_9
.LBB3_11:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i
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
	s_cbranch_scc0 .LBB3_13
; %bb.12:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB3_14
	s_branch .LBB3_19
.LBB3_13:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB3_19
.LBB3_14:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i
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
	s_cbranch_scc0 .LBB3_16
; %bb.15:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB3_17
	s_branch .LBB3_19
.LBB3_16:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB3_19
.LBB3_17:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i
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
	s_cbranch_scc0 .LBB3_25
; %bb.18:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB3_26
.LBB3_19:
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
.LBB3_20:                               ; %Flow109
	s_and_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB3_28
; %bb.21:                               ; %Flow117
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB3_24
.LBB3_22:                               ; %_ZL15warp_reduce_sumILi32EEff.exit
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
	s_cbranch_execz .LBB3_24
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
.LBB3_24:                               ; %UnifiedReturnBlock
	s_endpgm
.LBB3_25:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB3_19
.LBB3_26:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i
	v_xor_b32_e32 v4, 2, v0
	s_cmp_lg_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v2, v3
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v4, v0, v4, vcc_lo
	v_lshlrev_b32_e32 v2, 2, v4
	ds_bpermute_b32 v2, v2, v3
	s_cbranch_scc0 .LBB3_32
; %bb.27:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_branch .LBB3_20
.LBB3_28:
	s_cbranch_execnz .LBB3_30
; %bb.29:
	; divergent unreachable
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB3_22
	s_branch .LBB3_24
.LBB3_30:
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
.LBB3_31:                               ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB3_31
.LBB3_32:
	s_mov_b32 s1, 0
	s_mov_b32 s0, -1
	s_branch .LBB3_20
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
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
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end3:
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj, .Lfunc_end3-_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_vgpr, 76
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 15
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
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
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
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
	s_cbranch_execz .LBB4_4
; %bb.1:                                ; %.lr.ph
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
.LBB4_2:                                ; %.preheader73
                                        ; =>This Inner Loop Header: Depth=1
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
	s_cbranch_execnz .LBB4_2
; %bb.3:                                ; %Flow146
	s_or_b32 exec_lo, exec_lo, s4
.LBB4_4:                                ; %Flow147
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s8
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v7
	v_cmpx_ne_u32_e32 0, v7
	s_cbranch_execz .LBB4_6
; %bb.5:                                ; %.preheader
	v_lshlrev_b32_e32 v0, 8, v7
	v_lshlrev_b32_e32 v1, 2, v5
	s_delay_alu instid0(VALU_DEP_1)
	v_add3_u32 v0, v0, v1, 0xffffff00
	ds_store_2addr_b32 v0, v6, v4 offset1:32
.LBB4_6:                                ; %.loopexit72
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB4_35
; %bb.7:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, 0
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB4_9
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB4_10
	s_branch .LBB4_30
.LBB4_9:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB4_30
.LBB4_10:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i
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
	s_cbranch_scc0 .LBB4_12
; %bb.11:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB4_13
	s_branch .LBB4_30
.LBB4_12:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB4_30
.LBB4_13:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i
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
	s_cbranch_scc0 .LBB4_15
; %bb.14:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB4_16
	s_branch .LBB4_30
.LBB4_15:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB4_30
.LBB4_16:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i
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
	s_cbranch_scc0 .LBB4_18
; %bb.17:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB4_19
	s_branch .LBB4_30
.LBB4_18:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB4_30
.LBB4_19:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i
	v_xor_b32_e32 v8, 2, v1
	s_cmp_lg_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v6, v7
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v8
	v_cndmask_b32_e32 v8, v1, v8, vcc_lo
	v_lshlrev_b32_e32 v6, 2, v8
	ds_bpermute_b32 v8, v6, v7
	s_cbranch_scc0 .LBB4_21
; %bb.20:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_branch .LBB4_22
.LBB4_21:
	s_mov_b32 s4, -1
	s_mov_b32 s1, 0
.LBB4_22:                               ; %Flow133
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB4_30
; %bb.23:                               ; %_ZL15warp_reduce_sumILi32EEff.exit
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
	s_cbranch_execz .LBB4_25
; %bb.24:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v5, v7, v8
	v_mov_b32_e32 v7, 0
	global_store_b32 v7, v5, s[2:3]
.LBB4_25:
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s0, -1, 0
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB4_27
; %bb.26:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s0, -1, 0
.LBB4_27:                               ; %Flow135
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB4_40
; %bb.28:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.1
	ds_bpermute_b32 v0, v0, v4
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB4_41
; %bb.29:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s5, -1, 0
	s_branch .LBB4_42
.LBB4_30:
                                        ; implicit-def: $sgpr4
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $sgpr2_sgpr3
                                        ; implicit-def: $vgpr0
.LBB4_31:                               ; %Flow126
	s_and_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB4_36
; %bb.32:                               ; %Flow144
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB4_35
.LBB4_33:                               ; %_ZL15warp_reduce_sumILi32EEff.exit.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v3, v2
	ds_bpermute_b32 v3, v1, v2
	s_and_b32 exec_lo, exec_lo, s4
	s_cbranch_execz .LBB4_35
; %bb.34:
	s_waitcnt lgkmcnt(0)
	v_dual_mov_b32 v1, 0 :: v_dual_add_f32 v2, v2, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	v_add_co_u32 v0, vcc_lo, s2, v0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v1, null, s3, v1, vcc_lo
	global_store_b32 v[0:1], v2, off
.LBB4_35:                               ; %UnifiedReturnBlock
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
	s_mov_b32 s0, 0
	s_branch .LBB4_53
.LBB4_41:
	s_mov_b32 s1, 0
.LBB4_42:                               ; %Flow137
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB4_53
; %bb.43:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v0, v4, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v2, v0
	s_cbranch_scc0 .LBB4_45
; %bb.44:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s5, -1, 0
	s_branch .LBB4_46
.LBB4_45:
	s_mov_b32 s1, 0
.LBB4_46:                               ; %Flow139
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB4_53
; %bb.47:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v0, v0, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v3, v0
	s_cbranch_scc0 .LBB4_49
; %bb.48:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s5, -1, 0
	s_branch .LBB4_50
.LBB4_49:
	s_mov_b32 s1, 0
.LBB4_50:                               ; %Flow141
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB4_53
; %bb.51:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v0, v2
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s1, 0
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v6, v3
	s_cbranch_scc0 .LBB4_54
; %bb.52:
	s_cmp_lg_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	v_mov_b32_e32 v0, s11
	s_branch .LBB4_31
.LBB4_53:                               ; %Flow136
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
.LBB4_54:                               ; %Flow136
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v0, s11
	s_branch .LBB4_31
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
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
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end4:
	.size	_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj, .Lfunc_end4-_Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_vgpr, 90
	.set _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 18
	.set _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
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
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
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
	s_cbranch_execz .LBB5_4
; %bb.1:                                ; %.lr.ph
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
.LBB5_2:                                ; %.preheader73
                                        ; =>This Inner Loop Header: Depth=1
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
	s_cbranch_execnz .LBB5_2
; %bb.3:                                ; %Flow178
	s_or_b32 exec_lo, exec_lo, s1
.LBB5_4:                                ; %Flow179
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s8
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v10
	v_cmpx_ne_u32_e32 0, v10
	s_cbranch_execz .LBB5_6
; %bb.5:                                ; %.preheader
	v_lshlrev_b32_e32 v0, 9, v10
	v_lshlrev_b32_e32 v1, 2, v8
	s_delay_alu instid0(VALU_DEP_1)
	v_add3_u32 v0, v0, v1, 0xfffffe00
	ds_store_2addr_b32 v0, v9, v7 offset1:32
	ds_store_2addr_b32 v0, v6, v5 offset0:64 offset1:96
.LBB5_6:                                ; %.loopexit72
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB5_35
; %bb.7:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB5_9
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB5_10
	s_branch .LBB5_30
.LBB5_9:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB5_30
.LBB5_10:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i
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
	s_cbranch_scc0 .LBB5_12
; %bb.11:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB5_13
	s_branch .LBB5_30
.LBB5_12:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB5_30
.LBB5_13:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i
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
	s_cbranch_scc0 .LBB5_15
; %bb.14:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB5_16
	s_branch .LBB5_30
.LBB5_15:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB5_30
.LBB5_16:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i
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
	s_cbranch_scc0 .LBB5_18
; %bb.17:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB5_19
	s_branch .LBB5_30
.LBB5_18:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB5_30
.LBB5_19:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i
	v_xor_b32_e32 v10, 2, v0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v10
	v_cndmask_b32_e32 v10, v0, v10, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v9, v4, v9 :: v_dual_lshlrev_b32 v4, 2, v10
	ds_bpermute_b32 v10, v4, v9
	s_cbranch_scc0 .LBB5_21
; %bb.20:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_branch .LBB5_22
.LBB5_21:
	s_mov_b32 s0, -1
	s_mov_b32 s5, 0
.LBB5_22:                               ; %Flow145
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB5_30
; %bb.23:                               ; %_ZL15warp_reduce_sumILi32EEff.exit
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
	s_cbranch_execz .LBB5_25
; %bb.24:
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v8, v9, v10 :: v_dual_mov_b32 v9, 0
	global_store_b32 v9, v8, s[0:1]
.LBB5_25:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB5_27
; %bb.26:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
.LBB5_27:                               ; %Flow147
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB5_40
; %bb.28:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.1
	ds_bpermute_b32 v8, v1, v7
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB5_41
; %bb.29:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB5_42
.LBB5_30:
                                        ; implicit-def: $sgpr2
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $sgpr0_sgpr1
                                        ; implicit-def: $vgpr3
.LBB5_31:                               ; %Flow138
	s_and_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB5_36
; %bb.32:                               ; %Flow176
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB5_35
.LBB5_33:                               ; %_ZL15warp_reduce_sumILi32EEff.exit.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v2, v1
	ds_bpermute_b32 v0, v0, v1
	s_and_b32 exec_lo, exec_lo, s2
	s_cbranch_execz .LBB5_35
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
.LBB5_35:                               ; %UnifiedReturnBlock
	s_endpgm
.LBB5_36:
	s_cbranch_execnz .LBB5_38
; %bb.37:
	; divergent unreachable
	s_cbranch_execz .LBB5_33
	s_branch .LBB5_35
.LBB5_38:
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
.LBB5_39:                               ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB5_39
.LBB5_40:
	s_mov_b32 s4, 0
	s_branch .LBB5_97
.LBB5_41:
	s_mov_b32 s5, 0
.LBB5_42:                               ; %Flow149
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB5_97
; %bb.43:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v2, v7
	s_cbranch_scc0 .LBB5_45
; %bb.44:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB5_46
.LBB5_45:
	s_mov_b32 s5, 0
.LBB5_46:                               ; %Flow151
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB5_97
; %bb.47:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v3, v7
	s_cbranch_scc0 .LBB5_49
; %bb.48:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB5_50
.LBB5_49:
	s_mov_b32 s5, 0
.LBB5_50:                               ; %Flow153
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB5_97
; %bb.51:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v4, v7
	s_cbranch_scc0 .LBB5_53
; %bb.52:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB5_54
.LBB5_53:
	s_mov_b32 s5, 0
.LBB5_54:                               ; %Flow155
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB5_97
; %bb.55:                               ; %_ZL15warp_reduce_sumILi32EEff.exit.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	ds_bpermute_b32 v8, v0, v7
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB5_57
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
.LBB5_57:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB5_59
; %bb.58:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB5_60
.LBB5_59:
	s_mov_b32 s5, 0
.LBB5_60:                               ; %Flow157
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB5_97
; %bb.61:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.2
	ds_bpermute_b32 v7, v1, v6
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB5_63
; %bb.62:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB5_64
.LBB5_63:
	s_mov_b32 s5, 0
.LBB5_64:                               ; %Flow159
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB5_97
; %bb.65:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v6, v6, v7
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v7, v2, v6
	s_cbranch_scc0 .LBB5_67
; %bb.66:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB5_68
.LBB5_67:
	s_mov_b32 s5, 0
.LBB5_68:                               ; %Flow161
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB5_97
; %bb.69:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v6, v6, v7
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v7, v3, v6
	s_cbranch_scc0 .LBB5_71
; %bb.70:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB5_72
.LBB5_71:
	s_mov_b32 s5, 0
.LBB5_72:                               ; %Flow163
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB5_97
; %bb.73:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v6, v6, v7
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v7, v4, v6
	s_cbranch_scc0 .LBB5_75
; %bb.74:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB5_76
.LBB5_75:
	s_mov_b32 s5, 0
.LBB5_76:                               ; %Flow165
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB5_97
; %bb.77:                               ; %_ZL15warp_reduce_sumILi32EEff.exit.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v6, v6, v7
	ds_bpermute_b32 v7, v0, v6
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB5_79
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
.LBB5_79:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB5_81
; %bb.80:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB5_82
.LBB5_81:
	s_mov_b32 s5, 0
.LBB5_82:                               ; %Flow167
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB5_97
; %bb.83:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.3
	ds_bpermute_b32 v1, v1, v5
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB5_85
; %bb.84:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB5_86
.LBB5_85:
	s_mov_b32 s5, 0
.LBB5_86:                               ; %Flow169
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB5_97
; %bb.87:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v5, v1
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v2, v1
	s_cbranch_scc0 .LBB5_89
; %bb.88:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB5_90
.LBB5_89:
	s_mov_b32 s5, 0
.LBB5_90:                               ; %Flow171
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB5_97
; %bb.91:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v3, v1
	s_cbranch_scc0 .LBB5_93
; %bb.92:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB5_94
.LBB5_93:
	s_mov_b32 s5, 0
.LBB5_94:                               ; %Flow173
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB5_97
; %bb.95:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s5, 0
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v1, v4, v2
	s_cbranch_scc0 .LBB5_98
; %bb.96:
	s_cmp_lg_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	v_mov_b32_e32 v3, s11
	s_branch .LBB5_31
.LBB5_97:                               ; %Flow148
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr2
.LBB5_98:                               ; %Flow148
	v_mov_b32_e32 v3, s11
	s_branch .LBB5_31
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
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
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end5:
	.size	_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj, .Lfunc_end5-_Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_vgpr, 93
	.set _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 15
	.set _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
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
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
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
	s_cbranch_execz .LBB6_4
; %bb.1:                                ; %.lr.ph
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
.LBB6_2:                                ; %.preheader73
                                        ; =>This Inner Loop Header: Depth=1
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
	s_cbranch_execnz .LBB6_2
; %bb.3:                                ; %Flow230
	s_or_b32 exec_lo, exec_lo, s19
.LBB6_4:                                ; %Flow231
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s8
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v13
	v_cmpx_ne_u32_e32 0, v13
	s_cbranch_execz .LBB6_6
; %bb.5:                                ; %.preheader
	v_lshlrev_b32_e32 v0, 10, v13
	v_lshlrev_b32_e32 v1, 2, v10
	s_delay_alu instid0(VALU_DEP_1)
	v_add3_u32 v0, v0, v1, 0xfffffc00
	ds_store_2addr_b32 v0, v12, v11 offset1:32
	ds_store_2addr_b32 v0, v9, v8 offset0:64 offset1:96
	ds_store_2addr_b32 v0, v7, v6 offset0:128 offset1:160
	ds_store_2addr_b32 v0, v5, v4 offset0:192 offset1:224
.LBB6_6:                                ; %.loopexit72
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB6_35
; %bb.7:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB6_9
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB6_10
	s_branch .LBB6_30
.LBB6_9:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB6_30
.LBB6_10:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i
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
	s_cbranch_scc0 .LBB6_12
; %bb.11:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB6_13
	s_branch .LBB6_30
.LBB6_12:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB6_30
.LBB6_13:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i
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
	s_cbranch_scc0 .LBB6_15
; %bb.14:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB6_16
	s_branch .LBB6_30
.LBB6_15:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB6_30
.LBB6_16:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i
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
	s_cbranch_scc0 .LBB6_18
; %bb.17:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB6_19
	s_branch .LBB6_30
.LBB6_18:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB6_30
.LBB6_19:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i
	v_xor_b32_e32 v14, 2, v0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v14
	v_cndmask_b32_e32 v14, v0, v14, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v13, v12, v13 :: v_dual_lshlrev_b32 v12, 2, v14
	ds_bpermute_b32 v14, v12, v13
	s_cbranch_scc0 .LBB6_21
; %bb.20:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_branch .LBB6_22
.LBB6_21:
	s_mov_b32 s0, -1
	s_mov_b32 s5, 0
.LBB6_22:                               ; %Flow157
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB6_30
; %bb.23:                               ; %_ZL15warp_reduce_sumILi32EEff.exit
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
	s_cbranch_execz .LBB6_25
; %bb.24:
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v10, v13, v14 :: v_dual_mov_b32 v13, 0
	global_store_b32 v13, v10, s[0:1]
.LBB6_25:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_27
; %bb.26:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
.LBB6_27:                               ; %Flow159
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_40
; %bb.28:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.1
	ds_bpermute_b32 v10, v1, v11
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB6_41
; %bb.29:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_42
.LBB6_30:
                                        ; implicit-def: $sgpr2
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $sgpr0_sgpr1
                                        ; implicit-def: $vgpr3
.LBB6_31:                               ; %Flow150
	s_and_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB6_36
; %bb.32:                               ; %Flow228
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB6_35
.LBB6_33:                               ; %_ZL15warp_reduce_sumILi32EEff.exit.7
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v2, v1
	ds_bpermute_b32 v0, v0, v1
	s_and_b32 exec_lo, exec_lo, s2
	s_cbranch_execz .LBB6_35
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
.LBB6_35:                               ; %UnifiedReturnBlock
	s_endpgm
.LBB6_36:
	s_cbranch_execnz .LBB6_38
; %bb.37:
	; divergent unreachable
	s_cbranch_execz .LBB6_33
	s_branch .LBB6_35
.LBB6_38:
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
.LBB6_39:                               ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB6_39
.LBB6_40:
	s_mov_b32 s4, 0
	s_branch .LBB6_185
.LBB6_41:
	s_mov_b32 s5, 0
.LBB6_42:                               ; %Flow161
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.43:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v10, v11, v10
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v11, v2, v10
	s_cbranch_scc0 .LBB6_45
; %bb.44:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_46
.LBB6_45:
	s_mov_b32 s5, 0
.LBB6_46:                               ; %Flow163
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.47:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v10, v10, v11
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v11, v3, v10
	s_cbranch_scc0 .LBB6_49
; %bb.48:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_50
.LBB6_49:
	s_mov_b32 s5, 0
.LBB6_50:                               ; %Flow165
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.51:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v10, v10, v11
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v11, v12, v10
	s_cbranch_scc0 .LBB6_53
; %bb.52:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_54
.LBB6_53:
	s_mov_b32 s5, 0
.LBB6_54:                               ; %Flow167
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.55:                               ; %_ZL15warp_reduce_sumILi32EEff.exit.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v10, v10, v11
	ds_bpermute_b32 v11, v0, v10
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB6_57
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
.LBB6_57:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_59
; %bb.58:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_60
.LBB6_59:
	s_mov_b32 s5, 0
.LBB6_60:                               ; %Flow169
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.61:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.2
	ds_bpermute_b32 v10, v1, v9
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB6_63
; %bb.62:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_64
.LBB6_63:
	s_mov_b32 s5, 0
.LBB6_64:                               ; %Flow171
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.65:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v9, v9, v10
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v10, v2, v9
	s_cbranch_scc0 .LBB6_67
; %bb.66:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_68
.LBB6_67:
	s_mov_b32 s5, 0
.LBB6_68:                               ; %Flow173
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.69:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v9, v9, v10
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v10, v3, v9
	s_cbranch_scc0 .LBB6_71
; %bb.70:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_72
.LBB6_71:
	s_mov_b32 s5, 0
.LBB6_72:                               ; %Flow175
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.73:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v9, v9, v10
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v10, v12, v9
	s_cbranch_scc0 .LBB6_75
; %bb.74:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_76
.LBB6_75:
	s_mov_b32 s5, 0
.LBB6_76:                               ; %Flow177
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.77:                               ; %_ZL15warp_reduce_sumILi32EEff.exit.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v9, v9, v10
	ds_bpermute_b32 v10, v0, v9
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB6_79
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
.LBB6_79:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_81
; %bb.80:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_82
.LBB6_81:
	s_mov_b32 s5, 0
.LBB6_82:                               ; %Flow179
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.83:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.3
	ds_bpermute_b32 v9, v1, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB6_85
; %bb.84:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_86
.LBB6_85:
	s_mov_b32 s5, 0
.LBB6_86:                               ; %Flow181
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.87:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v8, v8, v9
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v9, v2, v8
	s_cbranch_scc0 .LBB6_89
; %bb.88:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_90
.LBB6_89:
	s_mov_b32 s5, 0
.LBB6_90:                               ; %Flow183
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.91:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v8, v8, v9
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v9, v3, v8
	s_cbranch_scc0 .LBB6_93
; %bb.92:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_94
.LBB6_93:
	s_mov_b32 s5, 0
.LBB6_94:                               ; %Flow185
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.95:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v8, v8, v9
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v9, v12, v8
	s_cbranch_scc0 .LBB6_97
; %bb.96:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_98
.LBB6_97:
	s_mov_b32 s5, 0
.LBB6_98:                               ; %Flow187
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.99:                               ; %_ZL15warp_reduce_sumILi32EEff.exit.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v8, v8, v9
	ds_bpermute_b32 v9, v0, v8
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB6_101
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
.LBB6_101:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_103
; %bb.102:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_104
.LBB6_103:
	s_mov_b32 s5, 0
.LBB6_104:                              ; %Flow189
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.105:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.4
	ds_bpermute_b32 v8, v1, v7
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB6_107
; %bb.106:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_108
.LBB6_107:
	s_mov_b32 s5, 0
.LBB6_108:                              ; %Flow191
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.109:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.4
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v2, v7
	s_cbranch_scc0 .LBB6_111
; %bb.110:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_112
.LBB6_111:
	s_mov_b32 s5, 0
.LBB6_112:                              ; %Flow193
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.113:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.4
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v3, v7
	s_cbranch_scc0 .LBB6_115
; %bb.114:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_116
.LBB6_115:
	s_mov_b32 s5, 0
.LBB6_116:                              ; %Flow195
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.117:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.4
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v12, v7
	s_cbranch_scc0 .LBB6_119
; %bb.118:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_120
.LBB6_119:
	s_mov_b32 s5, 0
.LBB6_120:                              ; %Flow197
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.121:                              ; %_ZL15warp_reduce_sumILi32EEff.exit.4
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	ds_bpermute_b32 v8, v0, v7
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB6_123
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
.LBB6_123:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_125
; %bb.124:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_126
.LBB6_125:
	s_mov_b32 s5, 0
.LBB6_126:                              ; %Flow199
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.127:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.5
	ds_bpermute_b32 v7, v1, v6
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB6_129
; %bb.128:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_130
.LBB6_129:
	s_mov_b32 s5, 0
.LBB6_130:                              ; %Flow201
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.131:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.5
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v6, v6, v7
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v7, v2, v6
	s_cbranch_scc0 .LBB6_133
; %bb.132:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_134
.LBB6_133:
	s_mov_b32 s5, 0
.LBB6_134:                              ; %Flow203
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.135:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.5
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v6, v6, v7
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v7, v3, v6
	s_cbranch_scc0 .LBB6_137
; %bb.136:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_138
.LBB6_137:
	s_mov_b32 s5, 0
.LBB6_138:                              ; %Flow205
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.139:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.5
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v6, v6, v7
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v7, v12, v6
	s_cbranch_scc0 .LBB6_141
; %bb.140:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_142
.LBB6_141:
	s_mov_b32 s5, 0
.LBB6_142:                              ; %Flow207
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.143:                              ; %_ZL15warp_reduce_sumILi32EEff.exit.5
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v6, v6, v7
	ds_bpermute_b32 v7, v0, v6
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB6_145
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
.LBB6_145:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_147
; %bb.146:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_148
.LBB6_147:
	s_mov_b32 s5, 0
.LBB6_148:                              ; %Flow209
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.149:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.6
	ds_bpermute_b32 v6, v1, v5
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB6_151
; %bb.150:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_152
.LBB6_151:
	s_mov_b32 s5, 0
.LBB6_152:                              ; %Flow211
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.153:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.6
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v5, v5, v6
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v6, v2, v5
	s_cbranch_scc0 .LBB6_155
; %bb.154:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_156
.LBB6_155:
	s_mov_b32 s5, 0
.LBB6_156:                              ; %Flow213
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.157:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.6
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v5, v5, v6
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v6, v3, v5
	s_cbranch_scc0 .LBB6_159
; %bb.158:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_160
.LBB6_159:
	s_mov_b32 s5, 0
.LBB6_160:                              ; %Flow215
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.161:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.6
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v5, v5, v6
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v6, v12, v5
	s_cbranch_scc0 .LBB6_163
; %bb.162:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_164
.LBB6_163:
	s_mov_b32 s5, 0
.LBB6_164:                              ; %Flow217
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.165:                              ; %_ZL15warp_reduce_sumILi32EEff.exit.6
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v5, v5, v6
	ds_bpermute_b32 v6, v0, v5
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB6_167
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
.LBB6_167:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_169
; %bb.168:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_170
.LBB6_169:
	s_mov_b32 s5, 0
.LBB6_170:                              ; %Flow219
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.171:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.7
	ds_bpermute_b32 v1, v1, v4
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB6_173
; %bb.172:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_174
.LBB6_173:
	s_mov_b32 s5, 0
.LBB6_174:                              ; %Flow221
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.175:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.7
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v4, v1
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v2, v1
	s_cbranch_scc0 .LBB6_177
; %bb.176:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_178
.LBB6_177:
	s_mov_b32 s5, 0
.LBB6_178:                              ; %Flow223
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.179:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.7
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v3, v1
	s_cbranch_scc0 .LBB6_181
; %bb.180:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB6_182
.LBB6_181:
	s_mov_b32 s5, 0
.LBB6_182:                              ; %Flow225
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB6_185
; %bb.183:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.7
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s5, 0
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v1, v12, v2
	s_cbranch_scc0 .LBB6_186
; %bb.184:
	s_cmp_lg_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	v_mov_b32_e32 v3, s11
	s_branch .LBB6_31
.LBB6_185:                              ; %Flow160
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr2
.LBB6_186:                              ; %Flow160
	v_mov_b32_e32 v3, s11
	s_branch .LBB6_31
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
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
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end6:
	.size	_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj, .Lfunc_end6-_Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_vgpr, 37
	.set _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 21
	.set _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
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
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_clause 0x1
	s_load_b128 s[12:15], s[0:1], 0x20
	s_load_b256 s[4:11], s[0:1], 0x0
	v_bfe_u32 v17, v0, 10, 10
	v_dual_mov_b32 v15, 0 :: v_dual_and_b32 v14, 0x3ff, v0
	v_mov_b32_e32 v16, 0
	s_mov_b32 s1, exec_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_add_u32 v0, v17, 5, v14
	v_lshrrev_b32_e32 v18, 3, v0
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s12, s12, 8
	s_delay_alu instid0(VALU_DEP_1) | instid1(SALU_CYCLE_1)
	v_cmpx_gt_u32_e64 s12, v18
	s_cbranch_execz .LBB7_4
; %bb.1:                                ; %.lr.ph
	v_lshrrev_b32_e32 v2, 3, v0
	s_mul_i32 s0, s14, s3
	v_and_b32_e32 v4, 7, v14
	s_mul_hi_u32 s17, s0, 36
	s_mul_i32 s16, s0, 36
	v_mov_b32_e32 v15, 0
	v_mad_u64_u32 v[0:1], null, 0x120, v2, s[16:17]
	v_lshlrev_b32_e32 v2, 1, v14
	s_mul_i32 s14, s13, s2
	v_mov_b32_e32 v16, 0
	s_mov_b32 s13, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_and_b32_e32 v5, 14, v2
	v_mad_u64_u32 v[2:3], null, v4, 36, v[0:1]
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_lshlrev_b32_e32 v0, 1, v5
	v_lshlrev_b32_e32 v19, 1, v5
	v_add_co_u32 v1, vcc_lo, s8, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_add_co_ci_u32_e64 v2, null, s9, v3, vcc_lo
	v_lshlrev_b32_e32 v20, 1, v0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v8, vcc_lo, v1, 32
	v_add_co_ci_u32_e64 v9, null, 0, v2, vcc_lo
.LBB7_2:                                ; %.preheader123
                                        ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v23, s14, v18
	s_getpc_b64 s[8:9]
	s_add_u32 s8, s8, _ZL11iq3xxs_grid@rel32@lo+4
	s_addc_u32 s9, s9, _ZL11iq3xxs_grid@rel32@hi+12
	v_mov_b16_e32 v21.l, 0
	v_add_nc_u32_e32 v18, 8, v18
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
	v_add_co_u32 v8, vcc_lo, 0x900, v8
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
	s_cbranch_execnz .LBB7_2
; %bb.3:                                ; %Flow207
	s_or_b32 exec_lo, exec_lo, s13
.LBB7_4:                                ; %Flow208
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s1
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v17
	v_cmpx_ne_u32_e32 0, v17
	s_cbranch_execz .LBB7_6
; %bb.5:                                ; %.preheader121
	v_lshlrev_b32_e32 v0, 7, v17
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_add_u32 v0, v14, 2, v0
	v_add_nc_u32_e32 v1, 0xffffff80, v0
	ds_store_b32 v1, v16
	ds_store_b32 v0, v15
.LBB7_6:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB7_52
; %bb.7:                                ; %.preheader
	v_lshlrev_b32_e32 v0, 2, v14
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s1
	ds_load_2addr_b32 v[0:1], v0 offset1:32
	s_cbranch_vccnz .LBB7_10
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB7_11
.LBB7_9:
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr8
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr4
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $vgpr2
	s_branch .LBB7_26
.LBB7_10:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB7_9
.LBB7_11:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i
	v_mbcnt_lo_u32_b32 v2, -1, 0
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_xor_b32_e32 v3, 16, v2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v4, v16, v0
	v_mov_b32_e32 v0, 32
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v3
	v_cndmask_b32_e32 v3, v2, v3, vcc_lo
	v_lshlrev_b32_e32 v3, 2, v3
	ds_bpermute_b32 v5, v3, v4
	s_cbranch_scc0 .LBB7_14
; %bb.12:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB7_15
.LBB7_13:
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr8
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr4
	s_branch .LBB7_26
.LBB7_14:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB7_13
.LBB7_15:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i
	v_xor_b32_e32 v6, 8, v2
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v5, v4, v5
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v6
	v_cndmask_b32_e32 v6, v2, v6, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v4, 2, v6
	ds_bpermute_b32 v6, v4, v5
	s_cbranch_scc0 .LBB7_18
; %bb.16:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB7_19
.LBB7_17:
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr8
                                        ; implicit-def: $vgpr5
	s_branch .LBB7_26
.LBB7_18:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB7_17
.LBB7_19:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i
	v_xor_b32_e32 v7, 4, v2
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v6, v5, v6
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v7
	v_cndmask_b32_e32 v7, v2, v7, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v5, 2, v7
	ds_bpermute_b32 v7, v5, v6
	s_cbranch_scc0 .LBB7_22
; %bb.20:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB7_23
.LBB7_21:
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr8
	s_branch .LBB7_26
.LBB7_22:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB7_21
.LBB7_23:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i
	v_xor_b32_e32 v8, 2, v2
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_cmp_gt_i32_e32 vcc_lo, 32, v8
	v_cndmask_b32_e32 v9, v2, v8, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v8, v6, v7
	v_lshlrev_b32_e32 v6, 2, v9
	ds_bpermute_b32 v7, v6, v8
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
.LBB7_26:                               ; %Flow184
	s_mov_b32 s1, 0
	s_and_b32 vcc_lo, exec_lo, s0
	s_mov_b32 s0, 0
	s_cbranch_vccnz .LBB7_39
; %bb.27:                               ; %Flow192
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB7_41
.LBB7_28:                               ; %_ZL15warp_reduce_sumILi32EEff.exit
	v_xor_b32_e32 v9, 1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_cmp_lt_i32_e32 vcc_lo, v9, v0
	v_cndmask_b32_e32 v0, v2, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_add_f32 v2, v8, v7 :: v_dual_lshlrev_b32 v7, 2, v0
	ds_bpermute_b32 v0, v7, v2
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
.LBB7_31:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i98
	v_add_f32_e32 v1, v15, v1
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v3, v3, v1
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
.LBB7_34:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i101
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v1, v3
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v3, v4, v1
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
.LBB7_37:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i104
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v1, v3
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v3, v5, v1
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
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr2
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB7_48
	s_branch .LBB7_49
.LBB7_42:
	s_mov_b32 s4, 0
.LBB7_43:                               ; %Flow200
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB7_46
; %bb.44:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i107
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v1, v3
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v1, v6, v3
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
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr3
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB7_56
.LBB7_47:                               ; %Flow193
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB7_49
.LBB7_48:                               ; %UnifiedUnreachableBlock
	; divergent unreachable
.LBB7_49:                               ; %Flow204
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB7_52
; %bb.50:                               ; %_ZL15warp_reduce_sumILi32EEff.exit111
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v3, v1
	v_cmp_eq_u32_e32 vcc_lo, 0, v14
	s_mov_b32 s1, 0
	ds_bpermute_b32 v3, v7, v1
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB7_52
; %bb.51:
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v1, v1, v3 :: v_dual_add_f32 v0, v2, v0
	s_mul_i32 s0, s15, s3
	v_mov_b32_e32 v2, 0
	s_lshl_b64 s[0:1], s[0:1], 2
	s_delay_alu instid0(VALU_DEP_2)
	v_mul_f32_e32 v3, 0xbfb8aa3b, v1
	v_cmp_nlt_f32_e32 vcc_lo, 0x42ce8ed0, v1
	s_add_u32 s4, s10, s0
	s_addc_u32 s5, s11, s1
	s_ashr_i32 s3, s2, 31
	v_fma_f32 v4, 0xbfb8aa3b, v1, -v3
	v_rndne_f32_e32 v5, v3
	s_lshl_b64 s[0:1], s[2:3], 2
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	s_add_u32 s0, s4, s0
	v_dual_fmamk_f32 v4, v1, 0xb2a5705f, v4 :: v_dual_sub_f32 v3, v3, v5
	s_addc_u32 s1, s5, s1
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_add_f32_e32 v3, v3, v4
	v_cvt_i32_f32_e32 v4, v5
	v_exp_f32_e32 v3, v3
	s_waitcnt_depctr 0xfff
	v_ldexp_f32 v3, v3, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cndmask_b32_e32 v3, 0, v3, vcc_lo
	v_cmp_ngt_f32_e32 vcc_lo, 0xc2b17218, v1
	v_cndmask_b32_e32 v3, 0x7f800000, v3, vcc_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_f32_e32 v3, 1.0, v3
	v_div_scale_f32 v4, null, v3, v3, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_rcp_f32_e32 v5, v4
	s_waitcnt_depctr 0xfff
	v_fma_f32 v6, -v4, v5, 1.0
	v_fmac_f32_e32 v5, v6, v5
	v_div_scale_f32 v6, vcc_lo, v1, v3, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v7, v6, v5
	v_fma_f32 v8, -v4, v7, v6
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmac_f32_e32 v7, v8, v5
	v_fma_f32 v4, -v4, v7, v6
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_div_fmas_f32 v4, v4, v5, v7
	v_div_fixup_f32 v1, v4, v3, v1
	s_delay_alu instid0(VALU_DEP_1)
	v_mul_f32_e32 v0, v0, v1
	global_store_b32 v2, v0, s[0:1]
.LBB7_52:                               ; %UnifiedReturnBlock
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
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj
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
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end7:
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj, .Lfunc_end7-_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj.num_vgpr, 33
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 18
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 7780
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
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_load_b256 s[4:11], s[0:1], 0x10
	v_bfe_u32 v12, v0, 10, 10
	v_dual_mov_b32 v11, 0 :: v_dual_and_b32 v10, 0x3ff, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_add_u32 v0, v12, 5, v10
	v_lshrrev_b32_e32 v13, 3, v0
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s14, s8, 8
	s_mov_b32 s8, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_gt_u32_e64 s14, v13
	s_cbranch_execz .LBB8_4
; %bb.1:                                ; %.lr.ph
	v_lshrrev_b32_e32 v2, 3, v0
	s_mul_i32 s10, s10, s3
	v_dual_mov_b32 v11, 0 :: v_dual_and_b32 v4, 7, v10
	s_mul_hi_u32 s13, s10, 36
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
.LBB8_2:                                ; %.preheader72
                                        ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v18, s5, v13
	s_clause 0x2
	global_load_b32 v16, v[8:9], off
	global_load_b128 v[0:3], v[8:9], off offset:-32
	global_load_b128 v[4:7], v[8:9], off offset:-16
	s_getpc_b64 s[0:1]
	s_add_u32 s0, s0, _ZL11iq3xxs_grid@rel32@lo+4
	s_addc_u32 s1, s1, _ZL11iq3xxs_grid@rel32@hi+12
	v_mov_b16_e32 v17.l, 0
	v_add_nc_u32_e32 v13, 8, v13
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
	v_add_co_u32 v8, vcc_lo, 0x900, v8
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
	s_cbranch_execnz .LBB8_2
; %bb.3:                                ; %Flow123
	s_or_b32 exec_lo, exec_lo, s4
.LBB8_4:                                ; %Flow124
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s8
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v12
	v_cmpx_ne_u32_e32 0, v12
	s_cbranch_execz .LBB8_6
; %bb.5:                                ; %.preheader70
	v_lshlrev_b32_e32 v0, 7, v12
	v_lshlrev_b32_e32 v1, 2, v10
	s_delay_alu instid0(VALU_DEP_1)
	v_add3_u32 v0, v0, v1, 0xffffff80
	ds_store_b32 v0, v11
.LBB8_6:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB8_24
; %bb.7:                                ; %.preheader
	v_lshlrev_b32_e32 v0, 2, v10
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, 0
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s4
	ds_load_b32 v1, v0
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
.LBB8_11:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i
	v_mbcnt_lo_u32_b32 v0, -1, 0
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_xor_b32_e32 v2, 16, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v2
	s_waitcnt lgkmcnt(0)
	v_dual_cndmask_b32 v3, v0, v2 :: v_dual_add_f32 v2, v11, v1
	v_lshlrev_b32_e32 v1, 2, v3
	ds_bpermute_b32 v3, v1, v2
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
.LBB8_14:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i
	v_xor_b32_e32 v4, 8, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v4, v0, v4, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v2, v2, v3 :: v_dual_lshlrev_b32 v3, 2, v4
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
.LBB8_17:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i
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
.LBB8_20:                               ; %Flow112
	s_and_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB8_28
; %bb.21:                               ; %Flow120
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB8_24
.LBB8_22:                               ; %_ZL15warp_reduce_sumILi32EEff.exit
	v_xor_b32_e32 v4, 1, v0
	s_mov_b32 s1, 0
	s_waitcnt lgkmcnt(0)
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_cmp_lt_i32_e32 vcc_lo, v4, v1
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
.LBB8_24:                               ; %UnifiedReturnBlock
	s_endpgm
.LBB8_25:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB8_19
.LBB8_26:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i
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
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj
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
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end8:
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj, .Lfunc_end8-_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj.num_vgpr, 76
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 15
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 3812
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
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_clause 0x1
	s_load_b128 s[12:15], s[0:1], 0x20
	s_load_b256 s[4:11], s[0:1], 0x0
	v_bfe_u32 v17, v0, 10, 10
	v_dual_mov_b32 v15, 0 :: v_dual_and_b32 v14, 0x3ff, v0
	v_mov_b32_e32 v16, 0
	s_mov_b32 s1, exec_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_add_u32 v0, v17, 5, v14
	v_lshrrev_b32_e32 v18, 3, v0
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s12, s12, 8
	s_delay_alu instid0(VALU_DEP_1) | instid1(SALU_CYCLE_1)
	v_cmpx_gt_u32_e64 s12, v18
	s_cbranch_execz .LBB9_4
; %bb.1:                                ; %.lr.ph
	v_lshrrev_b32_e32 v2, 3, v0
	s_mul_i32 s0, s14, s3
	v_and_b32_e32 v4, 7, v14
	s_mul_hi_u32 s17, s0, 36
	s_mul_i32 s16, s0, 36
	v_mov_b32_e32 v15, 0
	v_mad_u64_u32 v[0:1], null, 0x120, v2, s[16:17]
	v_lshlrev_b32_e32 v2, 1, v14
	s_mul_i32 s14, s13, s2
	v_mov_b32_e32 v16, 0
	s_mov_b32 s13, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_and_b32_e32 v5, 14, v2
	v_mad_u64_u32 v[2:3], null, v4, 36, v[0:1]
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_lshlrev_b32_e32 v0, 1, v5
	v_lshlrev_b32_e32 v19, 1, v5
	v_add_co_u32 v1, vcc_lo, s8, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_add_co_ci_u32_e64 v2, null, s9, v3, vcc_lo
	v_lshlrev_b32_e32 v20, 1, v0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v8, vcc_lo, v1, 32
	v_add_co_ci_u32_e64 v9, null, 0, v2, vcc_lo
.LBB9_2:                                ; %.preheader123
                                        ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v23, s14, v18
	s_getpc_b64 s[8:9]
	s_add_u32 s8, s8, _ZL11iq3xxs_grid@rel32@lo+4
	s_addc_u32 s9, s9, _ZL11iq3xxs_grid@rel32@hi+12
	v_mov_b16_e32 v21.l, 0
	v_add_nc_u32_e32 v18, 16, v18
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
	v_add_co_u32 v8, vcc_lo, 0x1200, v8
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
	s_cbranch_execnz .LBB9_2
; %bb.3:                                ; %Flow214
	s_or_b32 exec_lo, exec_lo, s13
.LBB9_4:                                ; %Flow215
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s1
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v17
	v_cmpx_ne_u32_e32 0, v17
; %bb.5:                                ; %.preheader121
	v_lshl_add_u32 v0, v17, 7, 0xffffff80
	s_delay_alu instid0(VALU_DEP_1)
	v_lshl_add_u32 v0, v14, 2, v0
	ds_store_2addr_b32 v0, v16, v15 offset1:96
; %bb.6:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB9_52
; %bb.7:                                ; %.preheader
	v_lshlrev_b32_e32 v0, 2, v14
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s1, -1, 0
	ds_load_2addr_b32 v[4:5], v0 offset1:32
	ds_load_2addr_b32 v[2:3], v0 offset0:64 offset1:96
	ds_load_2addr_b32 v[0:1], v0 offset0:128 offset1:160
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
                                        ; implicit-def: $vgpr4
                                        ; implicit-def: $vgpr8
                                        ; implicit-def: $vgpr10
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr6
                                        ; implicit-def: $vgpr5
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr9
	s_branch .LBB9_26
.LBB9_10:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB9_9
.LBB9_11:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i
	v_mbcnt_lo_u32_b32 v9, -1, 0
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_xor_b32_e32 v6, 16, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v6
	s_waitcnt lgkmcnt(2)
	v_add_f32_e32 v4, v16, v4
	v_dual_add_f32 v4, v4, v5 :: v_dual_cndmask_b32 v5, v9, v6
	s_waitcnt lgkmcnt(1)
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_add_f32 v4, v4, v2 :: v_dual_lshlrev_b32 v5, 2, v5
	v_mov_b32_e32 v2, 32
	ds_bpermute_b32 v6, v5, v4
	s_cbranch_scc0 .LBB9_14
; %bb.12:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB9_15
.LBB9_13:
                                        ; implicit-def: $vgpr4
                                        ; implicit-def: $vgpr8
                                        ; implicit-def: $vgpr10
                                        ; implicit-def: $vgpr7
                                        ; implicit-def: $vgpr6
	s_branch .LBB9_26
.LBB9_14:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB9_13
.LBB9_15:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i
	v_xor_b32_e32 v7, 8, v9
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v4, v4, v6
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v7
	v_cndmask_b32_e32 v7, v9, v7, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v6, 2, v7
	ds_bpermute_b32 v7, v6, v4
	s_cbranch_scc0 .LBB9_18
; %bb.16:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB9_19
.LBB9_17:
                                        ; implicit-def: $vgpr4
                                        ; implicit-def: $vgpr8
                                        ; implicit-def: $vgpr10
                                        ; implicit-def: $vgpr7
	s_branch .LBB9_26
.LBB9_18:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB9_17
.LBB9_19:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i
	v_xor_b32_e32 v8, 4, v9
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v8
	v_cndmask_b32_e32 v8, v9, v8, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v4, v4, v7 :: v_dual_lshlrev_b32 v7, 2, v8
	ds_bpermute_b32 v8, v7, v4
	s_cbranch_scc0 .LBB9_22
; %bb.20:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB9_23
.LBB9_21:
                                        ; implicit-def: $vgpr4
                                        ; implicit-def: $vgpr8
                                        ; implicit-def: $vgpr10
	s_branch .LBB9_26
.LBB9_22:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB9_21
.LBB9_23:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i
	v_xor_b32_e32 v10, 2, v9
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v10
	s_waitcnt lgkmcnt(0)
	v_dual_cndmask_b32 v11, v9, v10 :: v_dual_add_f32 v10, v4, v8
	v_lshlrev_b32_e32 v8, 2, v11
	ds_bpermute_b32 v4, v8, v10
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
.LBB9_26:                               ; %Flow191
	s_mov_b32 s1, 0
	s_and_b32 vcc_lo, exec_lo, s0
	s_mov_b32 s0, 0
	s_cbranch_vccnz .LBB9_39
; %bb.27:                               ; %Flow199
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB9_41
.LBB9_28:                               ; %_ZL15warp_reduce_sumILi32EEff.exit
	v_xor_b32_e32 v11, 1, v9
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_waitcnt lgkmcnt(1)
	v_cmp_lt_i32_e32 vcc_lo, v11, v2
	v_cndmask_b32_e32 v2, v9, v11, vcc_lo
	s_waitcnt lgkmcnt(0)
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_add_f32 v4, v10, v4 :: v_dual_lshlrev_b32 v9, 2, v2
	ds_bpermute_b32 v2, v9, v4
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
.LBB9_31:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i98
	v_add_f32_e32 v3, v15, v3
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_f32_e32 v0, v3, v0
	v_add_f32_e32 v0, v0, v1
	ds_bpermute_b32 v1, v5, v0
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
.LBB9_34:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i101
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v0, v0, v1
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v1, v6, v0
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
.LBB9_37:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i104
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v0, v0, v1
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v1, v7, v0
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
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr9
                                        ; implicit-def: $vgpr4
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB9_48
	s_branch .LBB9_49
.LBB9_42:
	s_mov_b32 s4, 0
.LBB9_43:                               ; %Flow207
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB9_46
; %bb.44:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i107
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v0, v1
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v0, v8, v1
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
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $vgpr1
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB9_56
.LBB9_47:                               ; %Flow200
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB9_49
.LBB9_48:                               ; %UnifiedUnreachableBlock
	; divergent unreachable
.LBB9_49:                               ; %Flow211
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB9_52
; %bb.50:                               ; %_ZL15warp_reduce_sumILi32EEff.exit111
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v0, v1, v0
	v_cmp_eq_u32_e32 vcc_lo, 0, v14
	s_mov_b32 s1, 0
	ds_bpermute_b32 v1, v9, v0
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB9_52
; %bb.51:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v0, v0, v1
	s_mul_i32 s0, s15, s3
	s_ashr_i32 s3, s2, 31
	s_lshl_b64 s[0:1], s[0:1], 2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_dual_add_f32 v2, v4, v2 :: v_dual_mul_f32 v1, 0xbfb8aa3b, v0
	s_add_u32 s4, s10, s0
	s_addc_u32 s5, s11, s1
	s_lshl_b64 s[0:1], s[2:3], 2
	s_add_u32 s0, s4, s0
	v_fma_f32 v3, 0xbfb8aa3b, v0, -v1
	v_rndne_f32_e32 v5, v1
	s_addc_u32 s1, s5, s1
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_fmamk_f32 v3, v0, 0xb2a5705f, v3
	v_sub_f32_e32 v1, v1, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_add_f32_e32 v1, v1, v3
	v_cvt_i32_f32_e32 v3, v5
	v_cmp_nlt_f32_e32 vcc_lo, 0x42ce8ed0, v0
	v_exp_f32_e32 v1, v1
	s_waitcnt_depctr 0xfff
	v_ldexp_f32 v1, v1, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cndmask_b32_e32 v1, 0, v1, vcc_lo
	v_cmp_ngt_f32_e32 vcc_lo, 0xc2b17218, v0
	v_cndmask_b32_e32 v1, 0x7f800000, v1, vcc_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_f32_e32 v1, 1.0, v1
	v_div_scale_f32 v3, null, v1, v1, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_rcp_f32_e32 v5, v3
	s_waitcnt_depctr 0xfff
	v_fma_f32 v6, -v3, v5, 1.0
	v_fmac_f32_e32 v5, v6, v5
	v_div_scale_f32 v6, vcc_lo, v0, v1, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_mul_f32_e32 v7, v6, v5
	v_fma_f32 v8, -v3, v7, v6
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fmac_f32_e32 v7, v8, v5
	v_fma_f32 v3, -v3, v7, v6
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_div_fmas_f32 v3, v3, v5, v7
	v_div_fixup_f32 v0, v3, v1, v0
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_mov_b32 v1, 0 :: v_dual_mul_f32 v0, v2, v0
	global_store_b32 v1, v0, s[0:1]
.LBB9_52:                               ; %UnifiedReturnBlock
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
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj
		.amdhsa_group_segment_fixed_size 768
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
		.amdhsa_inst_pref_size 62
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end9:
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj, .Lfunc_end9-_Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj.num_vgpr, 33
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 18
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 7812
; TotalNumSgprs: 20
; NumVgprs: 33
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 768 bytes/workgroup (compile time only)
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
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_load_b256 s[4:11], s[0:1], 0x10
	v_bfe_u32 v12, v0, 10, 10
	v_dual_mov_b32 v11, 0 :: v_dual_and_b32 v10, 0x3ff, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_add_u32 v0, v12, 5, v10
	v_lshrrev_b32_e32 v13, 3, v0
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s14, s8, 8
	s_mov_b32 s8, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_gt_u32_e64 s14, v13
	s_cbranch_execz .LBB10_4
; %bb.1:                                ; %.lr.ph
	v_lshrrev_b32_e32 v2, 3, v0
	s_mul_i32 s10, s10, s3
	v_dual_mov_b32 v11, 0 :: v_dual_and_b32 v4, 7, v10
	s_mul_hi_u32 s13, s10, 36
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
.LBB10_2:                               ; %.preheader72
                                        ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v18, s5, v13
	s_clause 0x2
	global_load_b32 v16, v[8:9], off
	global_load_b128 v[0:3], v[8:9], off offset:-32
	global_load_b128 v[4:7], v[8:9], off offset:-16
	s_getpc_b64 s[0:1]
	s_add_u32 s0, s0, _ZL11iq3xxs_grid@rel32@lo+4
	s_addc_u32 s1, s1, _ZL11iq3xxs_grid@rel32@hi+12
	v_mov_b16_e32 v17.l, 0
	v_add_nc_u32_e32 v13, 16, v13
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
	v_add_co_u32 v8, vcc_lo, 0x1200, v8
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
	s_cbranch_execnz .LBB10_2
; %bb.3:                                ; %Flow127
	s_or_b32 exec_lo, exec_lo, s4
.LBB10_4:                               ; %Flow128
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s8
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v12
	v_cmpx_ne_u32_e32 0, v12
	s_cbranch_execz .LBB10_6
; %bb.5:                                ; %.preheader70
	v_lshlrev_b32_e32 v0, 7, v12
	v_lshlrev_b32_e32 v1, 2, v10
	s_delay_alu instid0(VALU_DEP_1)
	v_add3_u32 v0, v0, v1, 0xffffff80
	ds_store_b32 v0, v11
.LBB10_6:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB10_24
; %bb.7:                                ; %.preheader
	v_lshlrev_b32_e32 v2, 2, v10
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, 0
	s_cselect_b32 s4, -1, 0
	ds_load_2addr_b32 v[0:1], v2 offset1:32
	ds_load_b32 v3, v2 offset:256
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
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $vgpr2
	s_branch .LBB10_20
.LBB10_10:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB10_9
.LBB10_11:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i
	v_mbcnt_lo_u32_b32 v2, -1, 0
	s_waitcnt lgkmcnt(1)
	v_add_f32_e32 v0, v11, v0
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	v_xor_b32_e32 v4, 16, v2
	v_add_f32_e32 v0, v0, v1
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v1, v0, v3 :: v_dual_cndmask_b32 v4, v2, v4
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v0, 2, v4
	ds_bpermute_b32 v3, v0, v1
	v_mov_b32_e32 v0, 32
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
.LBB10_14:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i
	v_xor_b32_e32 v4, 8, v2
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v1, v3
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v4, v2, v4, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v3, 2, v4
	ds_bpermute_b32 v3, v3, v1
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
.LBB10_17:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i
	v_xor_b32_e32 v4, 4, v2
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v1, v3
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v4, v2, v4, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v3, 2, v4
	ds_bpermute_b32 v3, v3, v1
	s_cbranch_scc0 .LBB10_25
; %bb.18:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB10_26
.LBB10_19:
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr3
.LBB10_20:                              ; %Flow116
	s_and_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB10_28
; %bb.21:                               ; %Flow124
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB10_24
.LBB10_22:                              ; %_ZL15warp_reduce_sumILi32EEff.exit
	v_xor_b32_e32 v4, 1, v2
	s_mov_b32 s1, 0
	s_waitcnt lgkmcnt(1)
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_4) | instid1(VALU_DEP_3)
	v_cmp_lt_i32_e32 vcc_lo, v4, v0
	v_cndmask_b32_e32 v2, v2, v4, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v0, v3, v1
	v_cmp_eq_u32_e32 vcc_lo, 0, v10
	v_lshlrev_b32_e32 v1, 2, v2
	ds_bpermute_b32 v1, v1, v0
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB10_24
; %bb.23:
	s_mul_i32 s0, s11, s3
	s_ashr_i32 s3, s2, 31
	s_lshl_b64 s[0:1], s[0:1], 2
	v_mov_b32_e32 v2, 0
	s_add_u32 s4, s6, s0
	s_addc_u32 s5, s7, s1
	s_lshl_b64 s[0:1], s[2:3], 2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v0, v0, v1
	s_add_u32 s0, s4, s0
	s_addc_u32 s1, s5, s1
	global_store_b32 v2, v0, s[0:1]
.LBB10_24:                              ; %UnifiedReturnBlock
	s_endpgm
.LBB10_25:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB10_19
.LBB10_26:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i
	v_xor_b32_e32 v4, 2, v2
	s_cmp_lg_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v1, v3
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v4, v2, v4, vcc_lo
	v_lshlrev_b32_e32 v1, 2, v4
	ds_bpermute_b32 v1, v1, v3
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
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj
		.amdhsa_group_segment_fixed_size 384
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
	.section	.text._Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end10:
	.size	_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj, .Lfunc_end10-_Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj.num_vgpr, 76
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 15
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 3832
; TotalNumSgprs: 17
; NumVgprs: 76
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 384 bytes/workgroup (compile time only)
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
	.section	.text._Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_load_b128 s[12:15], s[0:1], 0x20
	v_bfe_u32 v2, v0, 10, 10
	s_load_b256 s[4:11], s[0:1], 0x0
	v_dual_mov_b32 v15, 0 :: v_dual_and_b32 v14, 0x3ff, v0
	v_mov_b16_e32 v3.h, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_lshlrev_b32_e32 v0, 5, v2
	v_mov_b32_e32 v16, 0
	v_add_nc_u16 v0.l, v0.l, v14.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	v_lshrrev_b16 v3.l, 1, v0.l
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s1, s12, 5
	s_mov_b32 s12, exec_lo
	v_cmpx_gt_u32_e64 s1, v3
	s_cbranch_execz .LBB11_4
; %bb.1:                                ; %.lr.ph
	v_dual_mov_b32 v15, 0 :: v_dual_lshlrev_b32 v0, 2, v14
	s_mul_i32 s0, s14, s3
	v_and_b32_e32 v4, 1, v14
	s_mul_i32 s14, s0, 36
	s_mul_hi_u32 s0, s0, 36
	s_add_u32 s8, s8, s14
	v_dual_mov_b32 v16, 0 :: v_dual_and_b32 v5, 4, v0
	s_addc_u32 s9, s9, s0
	v_lshlrev_b32_e32 v4, 3, v4
	v_mad_u64_u32 v[0:1], null, v3, 36, s[8:9]
	s_delay_alu instid0(VALU_DEP_3)
	v_lshlrev_b32_e32 v5, 1, v5
	s_mul_i32 s9, s13, s2
	s_mov_b32 s8, 0
.LBB11_2:                               ; %.preheader115
                                        ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v7, s9, v3
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_3)
	v_add_co_u32 v6, vcc_lo, v0, v4
	v_add_nc_u32_e32 v3, 0x80, v3
	v_mad_i64_i32 v[8:9], null, v7, 18, s[4:5]
	v_mad_i64_i32 v[10:11], null, v7, 18, s[6:7]
	v_add_co_ci_u32_e64 v7, null, 0, v1, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v12, s0, v8, v5
	v_add_co_ci_u32_e64 v13, null, 0, v9, s0
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v17, s0, v10, v5
	v_add_co_ci_u32_e64 v18, null, 0, v11, s0
	global_load_b64 v[12:13], v[12:13], off offset:2
	global_load_b64 v[17:18], v[17:18], off offset:2
	s_clause 0x2
	global_load_b64 v[19:20], v[6:7], off offset:4
	global_load_b64 v[6:7], v[6:7], off offset:20
	global_load_b32 v21, v[0:1], off
	global_load_d16_b16 v8, v[8:9], off
	global_load_d16_b16 v9, v[10:11], off
	v_add_co_u32 v0, vcc_lo, 0x1200, v0
	v_cmp_le_u32_e64 s0, s1, v3
	v_add_co_ci_u32_e64 v1, null, 0, v1, vcc_lo
	s_or_b32 s8, s0, s8
	s_waitcnt vmcnt(6)
	v_lshrrev_b32_e32 v10, 4, v12
	v_and_b32_e32 v11, 0xf0f0f0f, v12
	s_waitcnt vmcnt(5)
	v_lshrrev_b32_e32 v12, 4, v17
	v_and_b32_e32 v17, 0xf0f0f0f, v17
	v_and_b32_e32 v22, 0xf0f0f0f, v13
	v_and_b32_e32 v10, 0xf0f0f0f, v10
	s_waitcnt vmcnt(4)
	v_dot4_i32_iu8 v11, v11, v19, 0 neg_lo:[1,1,0]
	v_and_b32_e32 v12, 0xf0f0f0f, v12
	v_dot4_i32_iu8 v17, v17, v19, 0 neg_lo:[1,1,0]
	v_lshrrev_b32_e32 v13, 4, v13
	v_and_b32_e32 v19, 0xf0f0f0f, v18
	v_lshrrev_b32_e32 v18, 4, v18
	s_waitcnt vmcnt(3)
	v_dot4_i32_iu8 v10, v10, v6, v11 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v6, v12, v6, v17 neg_lo:[1,1,0]
	v_and_b32_e32 v11, 0xf0f0f0f, v13
	s_waitcnt vmcnt(2)
	v_cvt_f32_f16_e32 v13, v21.h
	v_and_b32_e32 v12, 0xf0f0f0f, v18
	v_dot4_i32_iu8 v10, v22, v20, v10 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v6, v19, v20, v6 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_dot4_i32_iu8 v10, v11, v7, v10 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v6, v12, v7, v6 neg_lo:[1,1,0]
	v_mul_f32_e32 v7, -4.0, v13
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cvt_f32_i32_e32 v10, v10
	v_cvt_f32_i32_e32 v6, v6
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_fma_mix_f32 v10, v10, v21, v7 op_sel_hi:[0,1,0]
	v_fma_mix_f32 v6, v21, v6, v7 op_sel_hi:[1,0,0]
	s_waitcnt vmcnt(1)
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_fma_mix_f32 v16, v10, v8, v16 op_sel_hi:[0,1,0]
	s_waitcnt vmcnt(0)
	v_fma_mix_f32 v15, v6, v9, v15 op_sel_hi:[0,1,0]
	s_and_not1_b32 exec_lo, exec_lo, s8
	s_cbranch_execnz .LBB11_2
; %bb.3:                                ; %Flow203
	s_or_b32 exec_lo, exec_lo, s8
.LBB11_4:                               ; %Flow204
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s12
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v2
	v_cmpx_ne_u32_e32 0, v2
; %bb.5:                                ; %.preheader113
	v_lshl_add_u32 v0, v2, 7, 0xffffff80
	s_delay_alu instid0(VALU_DEP_1)
	v_lshl_add_u32 v0, v14, 2, v0
	ds_store_2addr_b32 v0, v16, v15 offset1:224
; %bb.6:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB11_52
; %bb.7:                                ; %.preheader
	v_lshlrev_b32_e32 v2, 2, v14
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s1
	v_add_nc_u32_e32 v3, 0x400, v2
	ds_load_2addr_b32 v[10:11], v2 offset1:32
	ds_load_2addr_b32 v[0:1], v2 offset0:192 offset1:224
	ds_load_2addr_b32 v[12:13], v2 offset0:64 offset1:96
	ds_load_2addr_b32 v[8:9], v2 offset0:128 offset1:160
	ds_load_2addr_b32 v[6:7], v3 offset1:32
	ds_load_2addr_b32 v[4:5], v3 offset0:64 offset1:96
	ds_load_2addr_b32 v[2:3], v3 offset0:128 offset1:160
	s_cbranch_vccnz .LBB11_10
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB11_11
.LBB11_9:
                                        ; implicit-def: $vgpr8
                                        ; implicit-def: $vgpr12
                                        ; implicit-def: $vgpr16
                                        ; implicit-def: $vgpr11
                                        ; implicit-def: $vgpr10
                                        ; implicit-def: $vgpr9
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $vgpr13
	s_branch .LBB11_26
.LBB11_10:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB11_9
.LBB11_11:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i
	s_waitcnt lgkmcnt(6)
	v_add_f32_e32 v10, v16, v10
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_add_f32_e32 v10, v10, v11
	s_waitcnt lgkmcnt(4)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_f32_e32 v10, v10, v12
	v_add_f32_e32 v10, v10, v13
	v_mbcnt_lo_u32_b32 v13, -1, 0
	s_waitcnt lgkmcnt(3)
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_f32_e32 v8, v10, v8
	v_xor_b32_e32 v10, 16, v13
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_f32_e32 v8, v8, v9
	v_cmp_gt_i32_e32 vcc_lo, 32, v10
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_add_f32 v8, v8, v0 :: v_dual_cndmask_b32 v9, v13, v10
	v_dual_mov_b32 v0, 32 :: v_dual_lshlrev_b32 v9, 2, v9
	ds_bpermute_b32 v10, v9, v8
	s_cbranch_scc0 .LBB11_14
; %bb.12:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB11_15
.LBB11_13:
                                        ; implicit-def: $vgpr8
                                        ; implicit-def: $vgpr12
                                        ; implicit-def: $vgpr16
                                        ; implicit-def: $vgpr11
                                        ; implicit-def: $vgpr10
	s_branch .LBB11_26
.LBB11_14:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB11_13
.LBB11_15:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i
	v_xor_b32_e32 v11, 8, v13
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v8, v8, v10
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v11
	v_cndmask_b32_e32 v11, v13, v11, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v10, 2, v11
	ds_bpermute_b32 v11, v10, v8
	s_cbranch_scc0 .LBB11_18
; %bb.16:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB11_19
.LBB11_17:
                                        ; implicit-def: $vgpr8
                                        ; implicit-def: $vgpr12
                                        ; implicit-def: $vgpr16
                                        ; implicit-def: $vgpr11
	s_branch .LBB11_26
.LBB11_18:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB11_17
.LBB11_19:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i
	v_xor_b32_e32 v12, 4, v13
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v12
	v_cndmask_b32_e32 v12, v13, v12, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v8, v8, v11 :: v_dual_lshlrev_b32 v11, 2, v12
	ds_bpermute_b32 v12, v11, v8
	s_cbranch_scc0 .LBB11_22
; %bb.20:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB11_23
.LBB11_21:
                                        ; implicit-def: $vgpr8
                                        ; implicit-def: $vgpr12
                                        ; implicit-def: $vgpr16
	s_branch .LBB11_26
.LBB11_22:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB11_21
.LBB11_23:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i
	v_xor_b32_e32 v16, 2, v13
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_cmp_gt_i32_e32 vcc_lo, 32, v16
	v_cndmask_b32_e32 v17, v13, v16, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v16, v8, v12
	v_lshlrev_b32_e32 v12, 2, v17
	ds_bpermute_b32 v8, v12, v16
	s_cbranch_scc0 .LBB11_25
; %bb.24:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_branch .LBB11_26
.LBB11_25:
	s_mov_b32 s0, 0
	s_mov_b32 s4, -1
.LBB11_26:                              ; %Flow180
	s_mov_b32 s1, 0
	s_and_b32 vcc_lo, exec_lo, s0
	s_mov_b32 s0, 0
	s_cbranch_vccnz .LBB11_39
; %bb.27:                               ; %Flow188
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB11_41
.LBB11_28:                              ; %_ZL15warp_reduce_sumILi32EEff.exit
	s_waitcnt lgkmcnt(4)
	v_xor_b32_e32 v17, 1, v13
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v8, v16, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	v_cmp_lt_i32_e32 vcc_lo, v17, v0
	s_cmp_lg_u32 exec_lo, 0
	v_cndmask_b32_e32 v0, v13, v17, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v13, 2, v0
	ds_bpermute_b32 v0, v13, v8
	s_cbranch_scc0 .LBB11_30
; %bb.29:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB11_31
	s_branch .LBB11_46
.LBB11_30:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB11_46
.LBB11_31:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i90
	v_add_f32_e32 v1, v15, v1
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_f32_e32 v1, v1, v6
	v_add_f32_e32 v1, v1, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_f32_e32 v1, v1, v4
	v_add_f32_e32 v1, v1, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_f32_e32 v1, v1, v2
	v_add_f32_e32 v1, v1, v3
	ds_bpermute_b32 v2, v9, v1
	s_cbranch_scc0 .LBB11_33
; %bb.32:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB11_34
	s_branch .LBB11_46
.LBB11_33:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB11_46
.LBB11_34:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i93
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v10, v1
	s_cbranch_scc0 .LBB11_36
; %bb.35:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB11_37
	s_branch .LBB11_46
.LBB11_36:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB11_46
.LBB11_37:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i96
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v11, v1
	s_cbranch_scc0 .LBB11_42
; %bb.38:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_branch .LBB11_43
.LBB11_39:
	s_cbranch_execnz .LBB11_53
; %bb.40:
	s_mov_b32 s0, -1
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB11_28
.LBB11_41:
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $vgpr13
                                        ; implicit-def: $vgpr8
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB11_48
	s_branch .LBB11_49
.LBB11_42:
	s_mov_b32 s4, 0
.LBB11_43:                              ; %Flow196
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB11_46
; %bb.44:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i99
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v1, v2
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v1, v12, v2
	s_cbranch_scc0 .LBB11_55
; %bb.45:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB11_47
	s_branch .LBB11_56
.LBB11_46:
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr2
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB11_56
.LBB11_47:                              ; %Flow189
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB11_49
.LBB11_48:                              ; %UnifiedUnreachableBlock
	; divergent unreachable
.LBB11_49:                              ; %Flow200
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB11_52
; %bb.50:                               ; %_ZL15warp_reduce_sumILi32EEff.exit103
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v2, v1
	v_cmp_eq_u32_e32 vcc_lo, 0, v14
	s_mov_b32 s1, 0
	ds_bpermute_b32 v2, v13, v1
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB11_52
; %bb.51:
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v1, v1, v2 :: v_dual_add_f32 v0, v8, v0
	s_mul_i32 s0, s15, s3
	s_ashr_i32 s3, s2, 31
	s_lshl_b64 s[0:1], s[0:1], 2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_mul_f32_e32 v2, 0xbfb8aa3b, v1
	s_add_u32 s4, s10, s0
	s_addc_u32 s5, s11, s1
	s_lshl_b64 s[0:1], s[2:3], 2
	s_add_u32 s0, s4, s0
	v_fma_f32 v3, 0xbfb8aa3b, v1, -v2
	v_rndne_f32_e32 v4, v2
	s_addc_u32 s1, s5, s1
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_f32_e32 v2, v2, v4
	v_cmp_nlt_f32_e32 vcc_lo, 0x42ce8ed0, v1
	v_fmamk_f32 v3, v1, 0xb2a5705f, v3
	v_add_f32_e32 v2, v2, v3
	v_cvt_i32_f32_e32 v3, v4
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_exp_f32_e32 v2, v2
	s_waitcnt_depctr 0xfff
	v_ldexp_f32 v2, v2, v3
	v_cndmask_b32_e32 v2, 0, v2, vcc_lo
	v_cmp_ngt_f32_e32 vcc_lo, 0xc2b17218, v1
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cndmask_b32_e32 v2, 0x7f800000, v2, vcc_lo
	v_add_f32_e32 v2, 1.0, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_div_scale_f32 v3, null, v2, v2, v1
	v_rcp_f32_e32 v4, v3
	s_waitcnt_depctr 0xfff
	v_fma_f32 v5, -v3, v4, 1.0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_fmac_f32_e32 v4, v5, v4
	v_div_scale_f32 v5, vcc_lo, v1, v2, v1
	v_mul_f32_e32 v6, v5, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fma_f32 v7, -v3, v6, v5
	v_fmac_f32_e32 v6, v7, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fma_f32 v3, -v3, v6, v5
	v_div_fmas_f32 v3, v3, v4, v6
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_div_fixup_f32 v1, v3, v2, v1
	v_mov_b32_e32 v2, 0
	v_mul_f32_e32 v0, v0, v1
	global_store_b32 v2, v0, s[0:1]
.LBB11_52:                              ; %UnifiedReturnBlock
	s_endpgm
.LBB11_53:
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
.LBB11_54:                              ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB11_54
.LBB11_55:
	s_mov_b32 s1, -1
	s_branch .LBB11_47
.LBB11_56:
	s_cbranch_execnz .LBB11_58
; %bb.57:
	s_cbranch_execnz .LBB11_48
	s_branch .LBB11_49
.LBB11_58:
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
.LBB11_59:                              ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB11_59
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj
		.amdhsa_group_segment_fixed_size 1792
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
		.amdhsa_next_free_vgpr 23
		.amdhsa_next_free_sgpr 16
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
		.amdhsa_inst_pref_size 17
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end11:
	.size	_Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj, .Lfunc_end11-_Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj.num_vgpr, 23
	.set _Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 16
	.set _Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 2096
; TotalNumSgprs: 18
; NumVgprs: 23
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 1792 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 2
; NumSGPRsForWavesPerEU: 18
; NumVGPRsForWavesPerEU: 23
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.section	.text._Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_load_b256 s[4:11], s[0:1], 0x10
	v_bfe_u32 v2, v0, 10, 10
	v_dual_mov_b32 v7, 0 :: v_dual_and_b32 v6, 0x3ff, v0
	v_mov_b16_e32 v3.h, 0
	s_mov_b32 s14, exec_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v0, 5, v2
	v_add_nc_u16 v0.l, v0.l, v6.l
	s_delay_alu instid0(VALU_DEP_1)
	v_lshrrev_b16 v3.l, 1, v0.l
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s8, s8, 5
	s_delay_alu instid0(VALU_DEP_1) | instid1(SALU_CYCLE_1)
	v_cmpx_gt_u32_e64 s8, v3
	s_cbranch_execz .LBB12_4
; %bb.1:                                ; %.lr.ph
	s_load_b64 s[12:13], s[0:1], 0x0
	v_dual_mov_b32 v7, 0 :: v_dual_lshlrev_b32 v0, 2, v6
	s_mul_i32 s0, s10, s3
	v_and_b32_e32 v4, 1, v6
	s_mul_i32 s1, s0, 36
	s_mul_hi_u32 s10, s0, 36
	s_add_u32 s0, s4, s1
	v_and_b32_e32 v5, 4, v0
	s_addc_u32 s1, s5, s10
	v_lshlrev_b32_e32 v4, 3, v4
	v_mad_u64_u32 v[0:1], null, v3, 36, s[0:1]
	s_delay_alu instid0(VALU_DEP_3)
	v_lshlrev_b32_e32 v5, 1, v5
	s_mul_i32 s4, s9, s2
	s_mov_b32 s1, 0
.LBB12_2:                               ; %.preheader72
                                        ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v10, s4, v3
	v_add_nc_u32_e32 v3, 0x80, v3
	s_waitcnt lgkmcnt(0)
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_mad_i64_i32 v[8:9], null, v10, 18, s[12:13]
	v_add_co_u32 v10, vcc_lo, v0, v4
	v_add_co_ci_u32_e64 v11, null, 0, v1, vcc_lo
	v_cmp_le_u32_e32 vcc_lo, s8, v3
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v12, s0, v8, v5
	v_add_co_ci_u32_e64 v13, null, 0, v9, s0
	s_or_b32 s1, vcc_lo, s1
	global_load_b64 v[12:13], v[12:13], off offset:2
	s_clause 0x2
	global_load_b64 v[14:15], v[10:11], off offset:4
	global_load_b64 v[10:11], v[10:11], off offset:20
	global_load_b32 v16, v[0:1], off
	global_load_d16_b16 v8, v[8:9], off
	v_add_co_u32 v0, s0, 0x1200, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v1, null, 0, v1, s0
	s_waitcnt vmcnt(4)
	v_lshrrev_b32_e32 v9, 4, v12
	v_and_b32_e32 v12, 0xf0f0f0f, v12
	v_and_b32_e32 v9, 0xf0f0f0f, v9
	s_waitcnt vmcnt(3)
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_3) | instid1(VALU_DEP_3)
	v_dot4_i32_iu8 v12, v12, v14, 0 neg_lo:[1,1,0]
	v_and_b32_e32 v14, 0xf0f0f0f, v13
	v_lshrrev_b32_e32 v13, 4, v13
	s_waitcnt vmcnt(2)
	v_dot4_i32_iu8 v9, v9, v10, v12 neg_lo:[1,1,0]
	s_waitcnt vmcnt(1)
	v_cvt_f32_f16_e32 v12, v16.h
	v_and_b32_e32 v10, 0xf0f0f0f, v13
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dot4_i32_iu8 v9, v14, v15, v9 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v9, v10, v11, v9 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_mul_f32_e32 v10, -4.0, v12
	v_cvt_f32_i32_e32 v9, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_fma_mix_f32 v9, v9, v16, v10 op_sel_hi:[0,1,0]
	s_waitcnt vmcnt(0)
	v_fma_mix_f32 v7, v9, v8, v7 op_sel_hi:[0,1,0]
	s_and_not1_b32 exec_lo, exec_lo, s1
	s_cbranch_execnz .LBB12_2
; %bb.3:                                ; %Flow124
	s_or_b32 exec_lo, exec_lo, s1
.LBB12_4:                               ; %Flow125
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s14
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v2
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB12_6
; %bb.5:                                ; %.preheader70
	v_lshlrev_b32_e32 v0, 7, v2
	v_lshlrev_b32_e32 v1, 2, v6
	s_delay_alu instid0(VALU_DEP_1)
	v_add3_u32 v0, v0, v1, 0xffffff80
	ds_store_b32 v0, v7
.LBB12_6:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB12_24
; %bb.7:                                ; %.preheader
	v_lshlrev_b32_e32 v8, 2, v6
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, 0
	s_cselect_b32 s4, -1, 0
	ds_load_2addr_b32 v[4:5], v8 offset1:32
	ds_load_2addr_b32 v[2:3], v8 offset0:64 offset1:96
	ds_load_2addr_b32 v[0:1], v8 offset0:128 offset1:160
	ds_load_b32 v8, v8 offset:768
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB12_10
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB12_11
.LBB12_9:
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $vgpr2
	s_branch .LBB12_20
.LBB12_10:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB12_9
.LBB12_11:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i
	s_waitcnt lgkmcnt(3)
	v_add_f32_e32 v4, v7, v4
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_add_f32_e32 v4, v4, v5
	s_waitcnt lgkmcnt(2)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_f32_e32 v2, v4, v2
	v_add_f32_e32 v3, v2, v3
	v_mbcnt_lo_u32_b32 v2, -1, 0
	s_waitcnt lgkmcnt(1)
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_f32_e32 v0, v3, v0
	v_xor_b32_e32 v3, 16, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_f32_e32 v0, v0, v1
	v_cmp_gt_i32_e32 vcc_lo, 32, v3
	v_cndmask_b32_e32 v3, v2, v3, vcc_lo
	s_waitcnt lgkmcnt(0)
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_add_f32 v1, v0, v8 :: v_dual_lshlrev_b32 v0, 2, v3
	ds_bpermute_b32 v3, v0, v1
	v_mov_b32_e32 v0, 32
	s_cbranch_scc0 .LBB12_13
; %bb.12:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB12_14
	s_branch .LBB12_19
.LBB12_13:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB12_19
.LBB12_14:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i
	v_xor_b32_e32 v4, 8, v2
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v1, v3
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v4, v2, v4, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v3, 2, v4
	ds_bpermute_b32 v3, v3, v1
	s_cbranch_scc0 .LBB12_16
; %bb.15:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB12_17
	s_branch .LBB12_19
.LBB12_16:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB12_19
.LBB12_17:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i
	v_xor_b32_e32 v4, 4, v2
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v1, v3
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v4, v2, v4, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v3, 2, v4
	ds_bpermute_b32 v3, v3, v1
	s_cbranch_scc0 .LBB12_25
; %bb.18:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB12_26
.LBB12_19:
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr3
.LBB12_20:                              ; %Flow113
	s_and_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB12_28
; %bb.21:                               ; %Flow121
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB12_24
.LBB12_22:                              ; %_ZL15warp_reduce_sumILi32EEff.exit
	s_waitcnt lgkmcnt(2)
	v_xor_b32_e32 v4, 1, v2
	s_mov_b32 s1, 0
	s_waitcnt lgkmcnt(1)
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_4) | instid1(VALU_DEP_3)
	v_cmp_lt_i32_e32 vcc_lo, v4, v0
	v_cndmask_b32_e32 v2, v2, v4, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v0, v3, v1
	v_cmp_eq_u32_e32 vcc_lo, 0, v6
	v_lshlrev_b32_e32 v1, 2, v2
	ds_bpermute_b32 v1, v1, v0
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB12_24
; %bb.23:
	s_mul_i32 s0, s11, s3
	s_ashr_i32 s3, s2, 31
	s_lshl_b64 s[0:1], s[0:1], 2
	v_mov_b32_e32 v2, 0
	s_add_u32 s4, s6, s0
	s_addc_u32 s5, s7, s1
	s_lshl_b64 s[0:1], s[2:3], 2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v0, v0, v1
	s_add_u32 s0, s4, s0
	s_addc_u32 s1, s5, s1
	global_store_b32 v2, v0, s[0:1]
.LBB12_24:                              ; %UnifiedReturnBlock
	s_endpgm
.LBB12_25:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB12_19
.LBB12_26:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i
	v_xor_b32_e32 v4, 2, v2
	s_cmp_lg_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v1, v3
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v4, v2, v4, vcc_lo
	v_lshlrev_b32_e32 v1, 2, v4
	ds_bpermute_b32 v1, v1, v3
	s_cbranch_scc0 .LBB12_32
; %bb.27:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_branch .LBB12_20
.LBB12_28:
	s_cbranch_execnz .LBB12_30
; %bb.29:
	; divergent unreachable
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB12_22
	s_branch .LBB12_24
.LBB12_30:
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
.LBB12_31:                              ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB12_31
.LBB12_32:
	s_mov_b32 s1, 0
	s_mov_b32 s0, -1
	s_branch .LBB12_20
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj
		.amdhsa_group_segment_fixed_size 896
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
		.amdhsa_next_free_vgpr 17
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
		.amdhsa_inst_pref_size 10
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end12:
	.size	_Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj, .Lfunc_end12-_Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj.num_vgpr, 17
	.set _Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 15
	.set _Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 1236
; TotalNumSgprs: 17
; NumVgprs: 17
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 896 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 2
; NumSGPRsForWavesPerEU: 17
; NumVGPRsForWavesPerEU: 17
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.section	.text._Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_load_b256 s[4:11], s[0:1], 0x10
	v_bfe_u32 v5, v0, 10, 10
	v_dual_mov_b32 v2, 0 :: v_dual_and_b32 v3, 0x3ff, v0
	v_mov_b16_e32 v6.h, 0
	v_mov_b32_e32 v4, 0
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_lshlrev_b32_e32 v0, 5, v5
	s_mov_b32 s14, exec_lo
	v_add_nc_u16 v0.l, v0.l, v3.l
	s_delay_alu instid0(VALU_DEP_1)
	v_lshrrev_b16 v6.l, 1, v0.l
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s8, s8, 5
	s_delay_alu instid0(VALU_DEP_1) | instid1(SALU_CYCLE_1)
	v_cmpx_gt_u32_e64 s8, v6
	s_cbranch_execz .LBB13_4
; %bb.1:                                ; %.lr.ph
	v_lshlrev_b32_e32 v0, 1, v3
	s_load_b64 s[12:13], s[0:1], 0x0
	s_mul_i32 s0, s10, s3
	v_dual_mov_b32 v4, 0 :: v_dual_and_b32 v1, 1, v3
	s_delay_alu instid0(VALU_DEP_2)
	v_and_b32_e32 v2, 2, v0
	s_mul_i32 s1, s0, 36
	s_mul_hi_u32 s0, s0, 36
	s_add_u32 s4, s4, s1
	s_addc_u32 s5, s5, s0
	v_lshlrev_b32_e32 v9, 1, v2
	v_lshlrev_b32_e32 v7, 3, v1
	v_mad_u64_u32 v[0:1], null, v6, 36, s[4:5]
	v_lshlrev_b32_e32 v8, 2, v2
	s_delay_alu instid0(VALU_DEP_4)
	v_dual_mov_b32 v2, 0 :: v_dual_lshlrev_b32 v9, 1, v9
	s_mul_i32 s9, s9, s2
	s_mov_b32 s1, 0
.LBB13_2:                               ; %.preheader73
                                        ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v14, s9, v6
	v_add_nc_u32_e32 v16, s10, v6
	v_add_co_u32 v10, vcc_lo, v0, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_4) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v11, null, 0, v1, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_mad_i64_i32 v[12:13], null, v14, 18, s[12:13]
	v_mad_u64_u32 v[14:15], null, v16, 36, s[4:5]
	v_add_nc_u32_e32 v6, 16, v6
	v_add_co_u32 v16, vcc_lo, v12, v9
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_add_co_ci_u32_e64 v17, null, 0, v13, vcc_lo
	v_add_co_u32 v18, vcc_lo, v14, v8
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v19, null, 0, v15, vcc_lo
	global_load_b64 v[16:17], v[16:17], off offset:2
	global_load_b64 v[20:21], v[10:11], off offset:4
	global_load_b64 v[22:23], v[18:19], off offset:4
	global_load_b64 v[10:11], v[10:11], off offset:20
	global_load_b64 v[18:19], v[18:19], off offset:20
	global_load_b32 v24, v[0:1], off
	global_load_b32 v14, v[14:15], off
	global_load_d16_b16 v12, v[12:13], off
	v_add_co_u32 v0, vcc_lo, 0x240, v0
	v_cmp_le_u32_e64 s0, s8, v6
	v_add_co_ci_u32_e64 v1, null, 0, v1, vcc_lo
	s_or_b32 s1, s0, s1
	s_waitcnt vmcnt(7)
	v_lshrrev_b32_e32 v13, 4, v16
	v_and_b32_e32 v15, 0xf0f0f0f, v16
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_and_b32_e32 v13, 0xf0f0f0f, v13
	s_waitcnt vmcnt(6)
	v_dot4_i32_iu8 v16, v15, v20, 0 neg_lo:[1,1,0]
	s_waitcnt vmcnt(5)
	v_dot4_i32_iu8 v15, v15, v22, 0 neg_lo:[1,1,0]
	v_and_b32_e32 v20, 0xf0f0f0f, v17
	v_lshrrev_b32_e32 v17, 4, v17
	s_waitcnt vmcnt(4)
	v_dot4_i32_iu8 v10, v13, v10, v16 neg_lo:[1,1,0]
	s_waitcnt vmcnt(3)
	v_dot4_i32_iu8 v13, v13, v18, v15 neg_lo:[1,1,0]
	s_waitcnt vmcnt(2)
	v_cvt_f32_f16_e32 v16, v24.h
	v_and_b32_e32 v15, 0xf0f0f0f, v17
	s_waitcnt vmcnt(1)
	v_cvt_f32_f16_e32 v17, v14.h
	v_dot4_i32_iu8 v10, v20, v21, v10 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v13, v20, v23, v13 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_dot4_i32_iu8 v10, v15, v11, v10 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v11, v15, v19, v13 neg_lo:[1,1,0]
	v_mul_f32_e32 v13, 4.0, v16
	v_mul_f32_e32 v15, 4.0, v17
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_cvt_f32_i32_e32 v10, v10
	v_cvt_f32_i32_e32 v11, v11
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_fma_mix_f32 v10, v10, v24, -v13 op_sel_hi:[0,1,0]
	v_fma_mix_f32 v11, v11, v14, -v15 op_sel_hi:[0,1,0]
	s_waitcnt vmcnt(0)
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_fma_mix_f32 v4, v10, v12, v4 op_sel_hi:[0,1,0]
	v_fma_mix_f32 v2, v11, v12, v2 op_sel_hi:[0,1,0]
	s_and_not1_b32 exec_lo, exec_lo, s1
	s_cbranch_execnz .LBB13_2
; %bb.3:                                ; %Flow141
	s_or_b32 exec_lo, exec_lo, s1
.LBB13_4:                               ; %Flow142
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s14
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v5
	v_cmpx_ne_u32_e32 0, v5
	s_cbranch_execz .LBB13_6
; %bb.5:                                ; %.preheader
	v_lshlrev_b32_e32 v0, 8, v5
	v_lshlrev_b32_e32 v1, 2, v3
	s_delay_alu instid0(VALU_DEP_1)
	v_add3_u32 v0, v0, v1, 0xffffff00
	ds_store_2addr_b32 v0, v4, v2 offset1:32
.LBB13_6:                               ; %.loopexit72
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB13_35
; %bb.7:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, 0
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB13_9
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB13_10
	s_branch .LBB13_30
.LBB13_9:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB13_30
.LBB13_10:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i
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
	ds_bpermute_b32 v5, v0, v4
	s_cbranch_scc0 .LBB13_12
; %bb.11:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB13_13
	s_branch .LBB13_30
.LBB13_12:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB13_30
.LBB13_13:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i
	v_xor_b32_e32 v6, 8, v1
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v5, v4, v5
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v6
	v_cndmask_b32_e32 v6, v1, v6, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v4, 2, v6
	ds_bpermute_b32 v6, v4, v5
	s_cbranch_scc0 .LBB13_15
; %bb.14:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB13_16
	s_branch .LBB13_30
.LBB13_15:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB13_30
.LBB13_16:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i
	v_xor_b32_e32 v7, 4, v1
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v7
	v_cndmask_b32_e32 v7, v1, v7, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v6, v5, v6 :: v_dual_lshlrev_b32 v5, 2, v7
	ds_bpermute_b32 v7, v5, v6
	s_cbranch_scc0 .LBB13_18
; %bb.17:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB13_19
	s_branch .LBB13_30
.LBB13_18:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB13_30
.LBB13_19:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i
	v_xor_b32_e32 v8, 2, v1
	s_cmp_lg_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v6, v7
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v8
	v_cndmask_b32_e32 v8, v1, v8, vcc_lo
	v_lshlrev_b32_e32 v6, 2, v8
	ds_bpermute_b32 v8, v6, v7
	s_cbranch_scc0 .LBB13_21
; %bb.20:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_branch .LBB13_22
.LBB13_21:
	s_mov_b32 s4, -1
	s_mov_b32 s1, 0
.LBB13_22:                              ; %Flow128
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB13_30
; %bb.23:                               ; %_ZL15warp_reduce_sumILi32EEff.exit
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
	v_cmp_eq_u32_e64 s4, 0, v3
	v_cndmask_b32_e32 v1, v1, v9, vcc_lo
	s_lshl_b64 s[2:3], s[2:3], 2
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	s_add_u32 s2, s0, s2
	s_addc_u32 s3, s5, s3
	v_lshlrev_b32_e32 v1, 2, v1
	ds_bpermute_b32 v8, v1, v7
	s_and_saveexec_b32 s0, s4
	s_cbranch_execz .LBB13_25
; %bb.24:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v7, v8
	v_mov_b32_e32 v7, 0
	global_store_b32 v7, v3, s[2:3]
.LBB13_25:
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s0, -1, 0
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB13_27
; %bb.26:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s0, -1, 0
.LBB13_27:                              ; %Flow130
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB13_40
; %bb.28:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.1
	ds_bpermute_b32 v0, v0, v2
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB13_41
; %bb.29:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s5, -1, 0
	s_branch .LBB13_42
.LBB13_30:
                                        ; implicit-def: $sgpr4
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $sgpr2_sgpr3
                                        ; implicit-def: $vgpr0
.LBB13_31:                              ; %Flow121
	s_and_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB13_36
; %bb.32:                               ; %Flow139
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB13_35
.LBB13_33:                              ; %_ZL15warp_reduce_sumILi32EEff.exit.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v3, v2
	ds_bpermute_b32 v3, v1, v2
	s_and_b32 exec_lo, exec_lo, s4
	s_cbranch_execz .LBB13_35
; %bb.34:
	s_waitcnt lgkmcnt(0)
	v_dual_mov_b32 v1, 0 :: v_dual_add_f32 v2, v2, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	v_add_co_u32 v0, vcc_lo, s2, v0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v1, null, s3, v1, vcc_lo
	global_store_b32 v[0:1], v2, off
.LBB13_35:                              ; %UnifiedReturnBlock
	s_endpgm
.LBB13_36:
	s_cbranch_execnz .LBB13_38
; %bb.37:
	; divergent unreachable
	s_cbranch_execz .LBB13_33
	s_branch .LBB13_35
.LBB13_38:
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
.LBB13_39:                              ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB13_39
.LBB13_40:
	s_mov_b32 s0, 0
	s_branch .LBB13_53
.LBB13_41:
	s_mov_b32 s1, 0
.LBB13_42:                              ; %Flow132
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB13_53
; %bb.43:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v0, v2, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v4, v0
	s_cbranch_scc0 .LBB13_45
; %bb.44:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s5, -1, 0
	s_branch .LBB13_46
.LBB13_45:
	s_mov_b32 s1, 0
.LBB13_46:                              ; %Flow134
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB13_53
; %bb.47:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v0, v0, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v5, v0
	s_cbranch_scc0 .LBB13_49
; %bb.48:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s5, -1, 0
	s_branch .LBB13_50
.LBB13_49:
	s_mov_b32 s1, 0
.LBB13_50:                              ; %Flow136
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB13_53
; %bb.51:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v0, v2
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s1, 0
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v6, v3
	s_cbranch_scc0 .LBB13_54
; %bb.52:
	s_cmp_lg_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	v_mov_b32_e32 v0, s11
	s_branch .LBB13_31
.LBB13_53:                              ; %Flow131
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
.LBB13_54:                              ; %Flow131
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v0, s11
	s_branch .LBB13_31
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
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
		.amdhsa_next_free_vgpr 25
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
		.amdhsa_inst_pref_size 13
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end13:
	.size	_Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj, .Lfunc_end13-_Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_vgpr, 25
	.set _Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 15
	.set _Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 1660
; TotalNumSgprs: 17
; NumVgprs: 25
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 256 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 3
; NumSGPRsForWavesPerEU: 17
; NumVGPRsForWavesPerEU: 25
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.section	.text._Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_load_b256 s[4:11], s[0:1], 0x10
	v_bfe_u32 v5, v0, 10, 10
	v_dual_mov_b32 v3, 0 :: v_dual_and_b32 v8, 0x3ff, v0
	v_mov_b16_e32 v6.h, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_dual_mov_b32 v7, 0 :: v_dual_lshlrev_b32 v0, 5, v5
	v_mov_b32_e32 v2, 0
	v_mov_b32_e32 v4, 0
	v_add_nc_u16 v0.l, v0.l, v8.l
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	v_lshrrev_b16 v6.l, 1, v0.l
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s12, s8, 5
	s_mov_b32 s8, exec_lo
	v_cmpx_gt_u32_e64 s12, v6
	s_cbranch_execz .LBB14_4
; %bb.1:                                ; %.lr.ph
	v_dual_mov_b32 v7, 0 :: v_dual_lshlrev_b32 v0, 1, v8
	s_load_b64 s[0:1], s[0:1], 0x0
	s_mul_i32 s13, s10, s3
	s_mul_i32 s9, s9, s2
	s_delay_alu instid0(VALU_DEP_1)
	v_and_b32_e32 v2, 2, v0
	v_and_b32_e32 v0, 1, v8
	s_mul_i32 s14, s13, 36
	s_mul_hi_u32 s13, s13, 36
	s_add_u32 s4, s4, s14
	v_dual_mov_b32 v4, 0 :: v_dual_lshlrev_b32 v3, 1, v2
	s_addc_u32 s5, s5, s13
	v_lshlrev_b32_e32 v9, 3, v0
	v_mad_u64_u32 v[0:1], null, v6, 36, s[4:5]
	s_delay_alu instid0(VALU_DEP_3)
	v_dual_mov_b32 v3, 0 :: v_dual_lshlrev_b32 v10, 1, v3
	v_dual_mov_b32 v2, 0 :: v_dual_lshlrev_b32 v11, 2, v2
	s_lshl_b32 s13, s10, 1
	s_mul_i32 s15, s10, 3
	s_mov_b32 s14, 0
.LBB14_2:                               ; %.preheader73
                                        ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v16, s9, v6
	v_add_nc_u32_e32 v20, s10, v6
	v_add_nc_u32_e32 v22, s13, v6
	v_add_nc_u32_e32 v24, s15, v6
	v_add_co_u32 v12, vcc_lo, v0, v9
	s_waitcnt lgkmcnt(0)
	v_mad_i64_i32 v[14:15], null, v16, 18, s[0:1]
	v_mad_u64_u32 v[18:19], null, v20, 36, s[4:5]
	v_mad_u64_u32 v[20:21], null, v22, 36, s[4:5]
	v_mad_u64_u32 v[22:23], null, v24, 36, s[4:5]
	v_add_co_ci_u32_e64 v13, null, 0, v1, vcc_lo
	v_add_co_u32 v24, vcc_lo, v14, v10
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v25, null, 0, v15, vcc_lo
	v_add_co_u32 v26, vcc_lo, v18, v11
	v_add_co_ci_u32_e64 v27, null, 0, v19, vcc_lo
	v_add_co_u32 v28, vcc_lo, v20, v11
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v29, null, 0, v21, vcc_lo
	v_add_co_u32 v30, vcc_lo, v22, v11
	v_add_co_ci_u32_e64 v31, null, 0, v23, vcc_lo
	s_clause 0x2
	global_load_b32 v34, v[0:1], off
	global_load_b64 v[16:17], v[12:13], off offset:4
	global_load_b64 v[12:13], v[12:13], off offset:20
	global_load_b64 v[24:25], v[24:25], off offset:2
	s_clause 0x8
	global_load_b64 v[32:33], v[26:27], off offset:4
	global_load_b64 v[26:27], v[26:27], off offset:20
	global_load_b32 v35, v[20:21], off
	global_load_b32 v36, v[18:19], off
	global_load_b64 v[18:19], v[30:31], off offset:20
	global_load_b64 v[20:21], v[28:29], off offset:4
	global_load_b64 v[28:29], v[28:29], off offset:20
	global_load_b64 v[30:31], v[30:31], off offset:4
	global_load_b32 v22, v[22:23], off
	global_load_d16_b16 v14, v[14:15], off
	v_add_nc_u32_e32 v6, 16, v6
	v_add_co_u32 v0, vcc_lo, 0x240, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v1, null, 0, v1, vcc_lo
	v_cmp_le_u32_e32 vcc_lo, s12, v6
	s_or_b32 s14, vcc_lo, s14
	s_waitcnt vmcnt(7)
	v_cvt_f32_f16_e32 v39, v35.h
	s_waitcnt vmcnt(6)
	v_cvt_f32_f16_e32 v38, v36.h
	v_and_b32_e32 v23, 0xf0f0f0f, v24
	v_lshrrev_b32_e32 v24, 4, v24
	v_cvt_f32_f16_e32 v15, v34.h
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_mul_f32_e32 v38, 4.0, v38
	v_dot4_i32_iu8 v16, v23, v16, 0 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_4)
	v_and_b32_e32 v24, 0xf0f0f0f, v24
	v_dot4_i32_iu8 v32, v23, v32, 0 neg_lo:[1,1,0]
	s_waitcnt vmcnt(4)
	v_dot4_i32_iu8 v20, v23, v20, 0 neg_lo:[1,1,0]
	s_waitcnt vmcnt(2)
	v_dot4_i32_iu8 v23, v23, v30, 0 neg_lo:[1,1,0]
	s_waitcnt vmcnt(1)
	v_cvt_f32_f16_e32 v40, v22.h
	v_and_b32_e32 v37, 0xf0f0f0f, v25
	v_lshrrev_b32_e32 v25, 4, v25
	v_dot4_i32_iu8 v12, v24, v12, v16 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v16, v24, v26, v32 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v20, v24, v28, v20 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v18, v24, v18, v23 neg_lo:[1,1,0]
	v_dual_mul_f32 v30, 4.0, v40 :: v_dual_and_b32 v25, 0xf0f0f0f, v25
	v_dot4_i32_iu8 v12, v37, v17, v12 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v16, v37, v33, v16 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v17, v37, v21, v20 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v18, v37, v31, v18 neg_lo:[1,1,0]
	v_mul_f32_e32 v15, 4.0, v15
	v_dot4_i32_iu8 v12, v25, v13, v12 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v13, v25, v27, v16 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v16, v25, v29, v17 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v17, v25, v19, v18 neg_lo:[1,1,0]
	v_mul_f32_e32 v39, 4.0, v39
	v_cvt_f32_i32_e32 v12, v12
	v_cvt_f32_i32_e32 v13, v13
	v_cvt_f32_i32_e32 v16, v16
	v_cvt_f32_i32_e32 v17, v17
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_fma_mix_f32 v12, v12, v34, -v15 op_sel_hi:[0,1,0]
	v_fma_mix_f32 v13, v13, v36, -v38 op_sel_hi:[0,1,0]
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_fma_mix_f32 v15, v16, v35, -v39 op_sel_hi:[0,1,0]
	v_fma_mix_f32 v16, v17, v22, -v30 op_sel_hi:[0,1,0]
	s_waitcnt vmcnt(0)
	v_fma_mix_f32 v4, v12, v14, v4 op_sel_hi:[0,1,0]
	v_fma_mix_f32 v7, v13, v14, v7 op_sel_hi:[0,1,0]
	v_fma_mix_f32 v3, v15, v14, v3 op_sel_hi:[0,1,0]
	v_fma_mix_f32 v2, v16, v14, v2 op_sel_hi:[0,1,0]
	s_and_not1_b32 exec_lo, exec_lo, s14
	s_cbranch_execnz .LBB14_2
; %bb.3:                                ; %Flow167
	s_or_b32 exec_lo, exec_lo, s14
.LBB14_4:                               ; %Flow168
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s8
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v5
	v_cmpx_ne_u32_e32 0, v5
	s_cbranch_execz .LBB14_6
; %bb.5:                                ; %.preheader
	v_lshlrev_b32_e32 v0, 9, v5
	v_lshlrev_b32_e32 v1, 2, v8
	s_delay_alu instid0(VALU_DEP_1)
	v_add3_u32 v0, v0, v1, 0xfffffe00
	ds_store_2addr_b32 v0, v4, v7 offset1:32
	ds_store_2addr_b32 v0, v3, v2 offset0:64 offset1:96
.LBB14_6:                               ; %.loopexit72
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB14_35
; %bb.7:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB14_9
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB14_10
	s_branch .LBB14_30
.LBB14_9:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB14_30
.LBB14_10:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i
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
	ds_bpermute_b32 v5, v1, v4
	s_cbranch_scc0 .LBB14_12
; %bb.11:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB14_13
	s_branch .LBB14_30
.LBB14_12:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB14_30
.LBB14_13:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i
	v_xor_b32_e32 v6, 8, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v6
	v_cndmask_b32_e32 v6, v0, v6, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v5, v4, v5 :: v_dual_lshlrev_b32 v4, 2, v6
	ds_bpermute_b32 v6, v4, v5
	s_cbranch_scc0 .LBB14_15
; %bb.14:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB14_16
	s_branch .LBB14_30
.LBB14_15:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB14_30
.LBB14_16:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i
	v_xor_b32_e32 v9, 4, v0
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v6, v5, v6
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v9
	v_cndmask_b32_e32 v9, v0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v5, 2, v9
	ds_bpermute_b32 v9, v5, v6
	s_cbranch_scc0 .LBB14_18
; %bb.17:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB14_19
	s_branch .LBB14_30
.LBB14_18:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB14_30
.LBB14_19:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i
	v_xor_b32_e32 v10, 2, v0
	s_cmp_lg_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v9, v6, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v10
	v_cndmask_b32_e32 v10, v0, v10, vcc_lo
	v_lshlrev_b32_e32 v6, 2, v10
	ds_bpermute_b32 v10, v6, v9
	s_cbranch_scc0 .LBB14_21
; %bb.20:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_branch .LBB14_22
.LBB14_21:
	s_mov_b32 s0, -1
	s_mov_b32 s5, 0
.LBB14_22:                              ; %Flow134
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB14_30
; %bb.23:                               ; %_ZL15warp_reduce_sumILi32EEff.exit
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
	s_cbranch_execz .LBB14_25
; %bb.24:
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v8, v9, v10 :: v_dual_mov_b32 v9, 0
	global_store_b32 v9, v8, s[0:1]
.LBB14_25:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB14_27
; %bb.26:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
.LBB14_27:                              ; %Flow136
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB14_40
; %bb.28:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.1
	ds_bpermute_b32 v8, v1, v7
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB14_41
; %bb.29:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB14_42
.LBB14_30:
                                        ; implicit-def: $sgpr2
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $sgpr0_sgpr1
                                        ; implicit-def: $vgpr3
.LBB14_31:                              ; %Flow127
	s_and_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB14_36
; %bb.32:                               ; %Flow165
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB14_35
.LBB14_33:                              ; %_ZL15warp_reduce_sumILi32EEff.exit.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v2, v1
	ds_bpermute_b32 v0, v0, v1
	s_and_b32 exec_lo, exec_lo, s2
	s_cbranch_execz .LBB14_35
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
.LBB14_35:                              ; %UnifiedReturnBlock
	s_endpgm
.LBB14_36:
	s_cbranch_execnz .LBB14_38
; %bb.37:
	; divergent unreachable
	s_cbranch_execz .LBB14_33
	s_branch .LBB14_35
.LBB14_38:
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
.LBB14_39:                              ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB14_39
.LBB14_40:
	s_mov_b32 s4, 0
	s_branch .LBB14_97
.LBB14_41:
	s_mov_b32 s5, 0
.LBB14_42:                              ; %Flow138
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB14_97
; %bb.43:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v4, v7
	s_cbranch_scc0 .LBB14_45
; %bb.44:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB14_46
.LBB14_45:
	s_mov_b32 s5, 0
.LBB14_46:                              ; %Flow140
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB14_97
; %bb.47:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v5, v7
	s_cbranch_scc0 .LBB14_49
; %bb.48:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB14_50
.LBB14_49:
	s_mov_b32 s5, 0
.LBB14_50:                              ; %Flow142
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB14_97
; %bb.51:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v6, v7
	s_cbranch_scc0 .LBB14_53
; %bb.52:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB14_54
.LBB14_53:
	s_mov_b32 s5, 0
.LBB14_54:                              ; %Flow144
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB14_97
; %bb.55:                               ; %_ZL15warp_reduce_sumILi32EEff.exit.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	ds_bpermute_b32 v8, v0, v7
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB14_57
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
.LBB14_57:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB14_59
; %bb.58:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB14_60
.LBB14_59:
	s_mov_b32 s5, 0
.LBB14_60:                              ; %Flow146
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB14_97
; %bb.61:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.2
	ds_bpermute_b32 v7, v1, v3
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB14_63
; %bb.62:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB14_64
.LBB14_63:
	s_mov_b32 s5, 0
.LBB14_64:                              ; %Flow148
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB14_97
; %bb.65:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v3, v7
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v7, v4, v3
	s_cbranch_scc0 .LBB14_67
; %bb.66:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB14_68
.LBB14_67:
	s_mov_b32 s5, 0
.LBB14_68:                              ; %Flow150
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB14_97
; %bb.69:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v3, v7
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v7, v5, v3
	s_cbranch_scc0 .LBB14_71
; %bb.70:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB14_72
.LBB14_71:
	s_mov_b32 s5, 0
.LBB14_72:                              ; %Flow152
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB14_97
; %bb.73:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v3, v7
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v7, v6, v3
	s_cbranch_scc0 .LBB14_75
; %bb.74:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB14_76
.LBB14_75:
	s_mov_b32 s5, 0
.LBB14_76:                              ; %Flow154
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB14_97
; %bb.77:                               ; %_ZL15warp_reduce_sumILi32EEff.exit.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v3, v7
	ds_bpermute_b32 v7, v0, v3
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB14_79
; %bb.78:
	s_lshl_b32 s4, s11, 1
	s_mov_b32 s5, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v3, v7
	s_lshl_b64 s[4:5], s[4:5], 2
	v_mov_b32_e32 v7, 0
	s_add_u32 s4, s0, s4
	s_addc_u32 s5, s1, s5
	global_store_b32 v7, v3, s[4:5]
.LBB14_79:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB14_81
; %bb.80:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB14_82
.LBB14_81:
	s_mov_b32 s5, 0
.LBB14_82:                              ; %Flow156
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB14_97
; %bb.83:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.3
	ds_bpermute_b32 v1, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB14_85
; %bb.84:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB14_86
.LBB14_85:
	s_mov_b32 s5, 0
.LBB14_86:                              ; %Flow158
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB14_97
; %bb.87:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v2, v1
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v4, v1
	s_cbranch_scc0 .LBB14_89
; %bb.88:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB14_90
.LBB14_89:
	s_mov_b32 s5, 0
.LBB14_90:                              ; %Flow160
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB14_97
; %bb.91:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v5, v1
	s_cbranch_scc0 .LBB14_93
; %bb.92:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB14_94
.LBB14_93:
	s_mov_b32 s5, 0
.LBB14_94:                              ; %Flow162
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB14_97
; %bb.95:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s5, 0
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v1, v6, v2
	s_cbranch_scc0 .LBB14_98
; %bb.96:
	s_cmp_lg_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	v_mov_b32_e32 v3, s11
	s_branch .LBB14_31
.LBB14_97:                              ; %Flow137
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr2
.LBB14_98:                              ; %Flow137
	v_mov_b32_e32 v3, s11
	s_branch .LBB14_31
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
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
		.amdhsa_next_free_vgpr 41
		.amdhsa_next_free_sgpr 16
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
		.amdhsa_inst_pref_size 21
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end14:
	.size	_Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj, .Lfunc_end14-_Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_vgpr, 41
	.set _Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 16
	.set _Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 2608
; TotalNumSgprs: 18
; NumVgprs: 41
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 512 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 5
; NumSGPRsForWavesPerEU: 18
; NumVGPRsForWavesPerEU: 41
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.section	.text._Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_load_b256 s[4:11], s[0:1], 0x10
	v_bfe_u32 v6, v0, 10, 10
	v_dual_mov_b32 v3, 0 :: v_dual_and_b32 v12, 0x3ff, v0
	v_mov_b16_e32 v7.h, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_dual_mov_b32 v9, 0 :: v_dual_lshlrev_b32 v0, 5, v6
	v_dual_mov_b32 v2, 0 :: v_dual_mov_b32 v11, 0
	v_dual_mov_b32 v4, 0 :: v_dual_mov_b32 v5, 0
	v_add_nc_u16 v0.l, v0.l, v12.l
	v_mov_b32_e32 v8, 0
	v_mov_b32_e32 v10, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	v_lshrrev_b16 v7.l, 1, v0.l
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s12, s8, 5
	s_mov_b32 s8, exec_lo
	v_cmpx_gt_u32_e64 s12, v7
	s_cbranch_execz .LBB15_4
; %bb.1:                                ; %.lr.ph
	v_dual_mov_b32 v5, 0 :: v_dual_lshlrev_b32 v0, 1, v12
	s_load_b64 s[0:1], s[0:1], 0x0
	s_mul_i32 s13, s10, s3
	v_dual_mov_b32 v10, 0 :: v_dual_and_b32 v1, 1, v12
	s_delay_alu instid0(VALU_DEP_2)
	v_dual_mov_b32 v11, 0 :: v_dual_and_b32 v2, 2, v0
	s_mul_i32 s14, s13, 36
	s_mul_hi_u32 s13, s13, 36
	s_add_u32 s4, s4, s14
	s_addc_u32 s5, s5, s13
	v_dual_mov_b32 v8, 0 :: v_dual_lshlrev_b32 v3, 1, v2
	v_dual_mov_b32 v4, 0 :: v_dual_lshlrev_b32 v13, 3, v1
	v_mad_u64_u32 v[0:1], null, v7, 36, s[4:5]
	s_delay_alu instid0(VALU_DEP_3)
	v_dual_mov_b32 v9, 0 :: v_dual_lshlrev_b32 v14, 1, v3
	v_dual_mov_b32 v2, 0 :: v_dual_lshlrev_b32 v15, 2, v2
	v_mov_b32_e32 v3, 0
	s_mul_i32 s9, s9, s2
	s_lshl_b32 s13, s10, 1
	s_mul_i32 s14, s10, 3
	s_lshl_b32 s15, s10, 2
	s_mul_i32 s16, s10, 5
	s_mul_i32 s17, s10, 6
	s_mul_i32 s19, s10, 7
	s_mov_b32 s18, 0
.LBB15_2:                               ; %.preheader73
                                        ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v20, s9, v7
	v_add_nc_u32_e32 v24, s10, v7
	v_add_nc_u32_e32 v26, s13, v7
	v_add_nc_u32_e32 v28, s14, v7
	v_add_nc_u32_e32 v30, s15, v7
	s_waitcnt lgkmcnt(0)
	v_mad_i64_i32 v[18:19], null, v20, 18, s[0:1]
	v_mad_u64_u32 v[22:23], null, v24, 36, s[4:5]
	v_add_nc_u32_e32 v32, s16, v7
	v_add_nc_u32_e32 v34, s17, v7
	v_add_nc_u32_e32 v36, s19, v7
	v_mad_u64_u32 v[24:25], null, v26, 36, s[4:5]
	v_add_co_u32 v16, vcc_lo, v0, v13
	v_mad_u64_u32 v[26:27], null, v28, 36, s[4:5]
	v_add_co_ci_u32_e64 v17, null, 0, v1, vcc_lo
	v_mad_u64_u32 v[28:29], null, v30, 36, s[4:5]
	v_mad_u64_u32 v[30:31], null, v32, 36, s[4:5]
	v_mad_u64_u32 v[32:33], null, v34, 36, s[4:5]
	v_mad_u64_u32 v[34:35], null, v36, 36, s[4:5]
	v_add_co_u32 v36, vcc_lo, v18, v14
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v37, null, 0, v19, vcc_lo
	v_add_co_u32 v38, vcc_lo, v22, v15
	v_add_co_ci_u32_e64 v39, null, 0, v23, vcc_lo
	v_add_co_u32 v40, vcc_lo, v24, v15
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v41, null, 0, v25, vcc_lo
	v_add_co_u32 v42, vcc_lo, v26, v15
	v_add_co_ci_u32_e64 v43, null, 0, v27, vcc_lo
	v_add_co_u32 v44, vcc_lo, v28, v15
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_4) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v45, null, 0, v29, vcc_lo
	v_add_co_u32 v46, vcc_lo, v30, v15
	global_load_b32 v54, v[0:1], off
	v_add_co_ci_u32_e64 v47, null, 0, v31, vcc_lo
	v_add_co_u32 v48, vcc_lo, v32, v15
	v_add_co_ci_u32_e64 v49, null, 0, v33, vcc_lo
	v_add_co_u32 v50, vcc_lo, v34, v15
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v51, null, 0, v35, vcc_lo
	s_clause 0x1
	global_load_b64 v[20:21], v[16:17], off offset:4
	global_load_b64 v[16:17], v[16:17], off offset:20
	global_load_b64 v[36:37], v[36:37], off offset:2
	s_clause 0x14
	global_load_b64 v[52:53], v[38:39], off offset:4
	global_load_b64 v[38:39], v[38:39], off offset:20
	global_load_b32 v55, v[24:25], off
	global_load_b32 v56, v[22:23], off
	global_load_b64 v[22:23], v[40:41], off offset:4
	global_load_b64 v[24:25], v[40:41], off offset:20
	global_load_b64 v[40:41], v[42:43], off offset:4
	global_load_b32 v57, v[26:27], off
	global_load_b64 v[26:27], v[42:43], off offset:20
	global_load_b64 v[42:43], v[44:45], off offset:4
	global_load_b64 v[44:45], v[44:45], off offset:20
	global_load_b32 v58, v[28:29], off
	global_load_b64 v[28:29], v[46:47], off offset:4
	global_load_b64 v[46:47], v[46:47], off offset:20
	global_load_b32 v59, v[32:33], off
	global_load_b32 v60, v[30:31], off
	global_load_b64 v[30:31], v[50:51], off offset:20
	global_load_b64 v[32:33], v[48:49], off offset:4
	global_load_b64 v[48:49], v[48:49], off offset:20
	global_load_b64 v[50:51], v[50:51], off offset:4
	global_load_b32 v34, v[34:35], off
	global_load_d16_b16 v18, v[18:19], off
	v_add_co_u32 v0, vcc_lo, 0x240, v0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v1, null, 0, v1, vcc_lo
	s_waitcnt vmcnt(19)
	v_cvt_f32_f16_e32 v63, v55.h
	s_waitcnt vmcnt(18)
	v_cvt_f32_f16_e32 v62, v56.h
	v_add_nc_u32_e32 v7, 16, v7
	s_waitcnt vmcnt(14)
	v_cvt_f32_f16_e32 v64, v57.h
	v_and_b32_e32 v61, 0xf0f0f0f, v37
	v_cvt_f32_f16_e32 v19, v54.h
	v_lshrrev_b32_e32 v37, 4, v37
	s_waitcnt vmcnt(10)
	v_cvt_f32_f16_e32 v65, v58.h
	v_mul_f32_e32 v64, 4.0, v64
	v_mul_f32_e32 v62, 4.0, v62
	s_waitcnt vmcnt(7)
	v_cvt_f32_f16_e32 v67, v59.h
	s_waitcnt vmcnt(6)
	v_cvt_f32_f16_e32 v66, v60.h
	v_and_b32_e32 v35, 0xf0f0f0f, v36
	v_lshrrev_b32_e32 v36, 4, v36
	v_mul_f32_e32 v19, 4.0, v19
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
	v_dual_mul_f32 v63, 4.0, v63 :: v_dual_mul_f32 v66, 4.0, v66
	v_dot4_i32_iu8 v20, v35, v20, 0 neg_lo:[1,1,0]
	s_delay_alu instid0(VALU_DEP_4)
	v_and_b32_e32 v36, 0xf0f0f0f, v36
	v_dot4_i32_iu8 v52, v35, v52, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v22, v35, v22, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v40, v35, v40, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v42, v35, v42, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v28, v35, v28, 0 neg_lo:[1,1,0]
	s_waitcnt vmcnt(4)
	v_dot4_i32_iu8 v32, v35, v32, 0 neg_lo:[1,1,0]
	s_waitcnt vmcnt(2)
	v_dot4_i32_iu8 v35, v35, v50, 0 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v16, v36, v16, v20 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v20, v36, v38, v52 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v22, v36, v24, v22 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v24, v36, v26, v40 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v26, v36, v44, v42 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v28, v36, v46, v28 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v32, v36, v48, v32 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v30, v36, v30, v35 neg_lo:[1,1,0]
	s_waitcnt vmcnt(1)
	v_cvt_f32_f16_e32 v68, v34.h
	v_and_b32_e32 v37, 0xf0f0f0f, v37
	v_dot4_i32_iu8 v16, v61, v21, v16 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v20, v61, v53, v20 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v21, v61, v23, v22 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v22, v61, v41, v24 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v23, v61, v43, v26 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v24, v61, v29, v28 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v26, v61, v33, v32 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v28, v61, v51, v30 neg_lo:[1,1,0]
	v_mul_f32_e32 v50, 4.0, v68
	v_dot4_i32_iu8 v16, v37, v17, v16 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v17, v37, v39, v20 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v20, v37, v25, v21 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v21, v37, v27, v22 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v22, v37, v45, v23 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v23, v37, v47, v24 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v24, v37, v49, v26 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v25, v37, v31, v28 neg_lo:[1,1,0]
	v_mul_f32_e32 v65, 4.0, v65
	v_mul_f32_e32 v67, 4.0, v67
	v_cvt_f32_i32_e32 v16, v16
	v_cvt_f32_i32_e32 v17, v17
	v_cvt_f32_i32_e32 v20, v20
	v_cvt_f32_i32_e32 v21, v21
	v_cvt_f32_i32_e32 v22, v22
	v_cvt_f32_i32_e32 v23, v23
	v_cvt_f32_i32_e32 v24, v24
	v_cvt_f32_i32_e32 v25, v25
	v_fma_mix_f32 v16, v16, v54, -v19 op_sel_hi:[0,1,0]
	v_fma_mix_f32 v17, v17, v56, -v62 op_sel_hi:[0,1,0]
	v_fma_mix_f32 v19, v20, v55, -v63 op_sel_hi:[0,1,0]
	v_fma_mix_f32 v20, v21, v57, -v64 op_sel_hi:[0,1,0]
	v_fma_mix_f32 v21, v22, v58, -v65 op_sel_hi:[0,1,0]
	v_fma_mix_f32 v22, v23, v60, -v66 op_sel_hi:[0,1,0]
	v_fma_mix_f32 v23, v24, v59, -v67 op_sel_hi:[0,1,0]
	v_fma_mix_f32 v24, v25, v34, -v50 op_sel_hi:[0,1,0]
	v_cmp_le_u32_e32 vcc_lo, s12, v7
	s_waitcnt vmcnt(0)
	v_fma_mix_f32 v5, v16, v18, v5 op_sel_hi:[0,1,0]
	v_fma_mix_f32 v11, v17, v18, v11 op_sel_hi:[0,1,0]
	v_fma_mix_f32 v10, v19, v18, v10 op_sel_hi:[0,1,0]
	v_fma_mix_f32 v9, v20, v18, v9 op_sel_hi:[0,1,0]
	v_fma_mix_f32 v8, v21, v18, v8 op_sel_hi:[0,1,0]
	v_fma_mix_f32 v4, v22, v18, v4 op_sel_hi:[0,1,0]
	v_fma_mix_f32 v3, v23, v18, v3 op_sel_hi:[0,1,0]
	v_fma_mix_f32 v2, v24, v18, v2 op_sel_hi:[0,1,0]
	s_or_b32 s18, vcc_lo, s18
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 exec_lo, exec_lo, s18
	s_cbranch_execnz .LBB15_2
; %bb.3:                                ; %Flow219
	s_or_b32 exec_lo, exec_lo, s18
.LBB15_4:                               ; %Flow220
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s8
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v6
	v_cmpx_ne_u32_e32 0, v6
	s_cbranch_execz .LBB15_6
; %bb.5:                                ; %.preheader
	v_lshlrev_b32_e32 v0, 10, v6
	v_lshlrev_b32_e32 v1, 2, v12
	s_delay_alu instid0(VALU_DEP_1)
	v_add3_u32 v0, v0, v1, 0xfffffc00
	ds_store_2addr_b32 v0, v5, v11 offset1:32
	ds_store_2addr_b32 v0, v10, v9 offset0:64 offset1:96
	ds_store_2addr_b32 v0, v8, v4 offset0:128 offset1:160
	ds_store_2addr_b32 v0, v3, v2 offset0:192 offset1:224
.LBB15_6:                               ; %.loopexit72
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB15_35
; %bb.7:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB15_9
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB15_10
	s_branch .LBB15_30
.LBB15_9:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB15_30
.LBB15_10:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i
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
	ds_bpermute_b32 v6, v1, v5
	s_cbranch_scc0 .LBB15_12
; %bb.11:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB15_13
	s_branch .LBB15_30
.LBB15_12:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB15_30
.LBB15_13:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i
	v_xor_b32_e32 v7, 8, v0
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v6, v5, v6
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v7
	v_cndmask_b32_e32 v7, v0, v7, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v5, 2, v7
	ds_bpermute_b32 v7, v5, v6
	s_cbranch_scc0 .LBB15_15
; %bb.14:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB15_16
	s_branch .LBB15_30
.LBB15_15:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB15_30
.LBB15_16:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i
	v_xor_b32_e32 v13, 4, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v13
	v_cndmask_b32_e32 v13, v0, v13, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v7, v6, v7 :: v_dual_lshlrev_b32 v6, 2, v13
	ds_bpermute_b32 v13, v6, v7
	s_cbranch_scc0 .LBB15_18
; %bb.17:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB15_19
	s_branch .LBB15_30
.LBB15_18:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB15_30
.LBB15_19:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i
	v_xor_b32_e32 v14, 2, v0
	s_cmp_lg_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v13, v7, v13
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v14
	v_cndmask_b32_e32 v14, v0, v14, vcc_lo
	v_lshlrev_b32_e32 v7, 2, v14
	ds_bpermute_b32 v14, v7, v13
	s_cbranch_scc0 .LBB15_21
; %bb.20:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_branch .LBB15_22
.LBB15_21:
	s_mov_b32 s0, -1
	s_mov_b32 s5, 0
.LBB15_22:                              ; %Flow146
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB15_30
; %bb.23:                               ; %_ZL15warp_reduce_sumILi32EEff.exit
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
	v_cmp_eq_u32_e64 s2, 0, v12
	s_add_u32 s0, s4, s0
	s_addc_u32 s1, s6, s1
	v_lshlrev_b32_e32 v0, 2, v0
	ds_bpermute_b32 v14, v0, v13
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB15_25
; %bb.24:
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v12, v13, v14 :: v_dual_mov_b32 v13, 0
	global_store_b32 v13, v12, s[0:1]
.LBB15_25:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_27
; %bb.26:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
.LBB15_27:                              ; %Flow148
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_40
; %bb.28:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.1
	ds_bpermute_b32 v12, v1, v11
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB15_41
; %bb.29:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_42
.LBB15_30:
                                        ; implicit-def: $sgpr2
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $sgpr0_sgpr1
                                        ; implicit-def: $vgpr3
.LBB15_31:                              ; %Flow139
	s_and_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB15_36
; %bb.32:                               ; %Flow217
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB15_35
.LBB15_33:                              ; %_ZL15warp_reduce_sumILi32EEff.exit.7
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v2, v1
	ds_bpermute_b32 v0, v0, v1
	s_and_b32 exec_lo, exec_lo, s2
	s_cbranch_execz .LBB15_35
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
.LBB15_35:                              ; %UnifiedReturnBlock
	s_endpgm
.LBB15_36:
	s_cbranch_execnz .LBB15_38
; %bb.37:
	; divergent unreachable
	s_cbranch_execz .LBB15_33
	s_branch .LBB15_35
.LBB15_38:
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
.LBB15_39:                              ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB15_39
.LBB15_40:
	s_mov_b32 s4, 0
	s_branch .LBB15_185
.LBB15_41:
	s_mov_b32 s5, 0
.LBB15_42:                              ; %Flow150
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.43:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v11, v11, v12
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v12, v5, v11
	s_cbranch_scc0 .LBB15_45
; %bb.44:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_46
.LBB15_45:
	s_mov_b32 s5, 0
.LBB15_46:                              ; %Flow152
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.47:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v11, v11, v12
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v12, v6, v11
	s_cbranch_scc0 .LBB15_49
; %bb.48:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_50
.LBB15_49:
	s_mov_b32 s5, 0
.LBB15_50:                              ; %Flow154
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.51:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v11, v11, v12
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v12, v7, v11
	s_cbranch_scc0 .LBB15_53
; %bb.52:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_54
.LBB15_53:
	s_mov_b32 s5, 0
.LBB15_54:                              ; %Flow156
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.55:                               ; %_ZL15warp_reduce_sumILi32EEff.exit.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v11, v11, v12
	ds_bpermute_b32 v12, v0, v11
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB15_57
; %bb.56:
	s_mov_b32 s5, 0
	s_mov_b32 s4, s11
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v11, v11, v12 :: v_dual_mov_b32 v12, 0
	s_lshl_b64 s[4:5], s[4:5], 2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_add_u32 s4, s0, s4
	s_addc_u32 s5, s1, s5
	global_store_b32 v12, v11, s[4:5]
.LBB15_57:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_59
; %bb.58:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_60
.LBB15_59:
	s_mov_b32 s5, 0
.LBB15_60:                              ; %Flow158
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.61:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.2
	ds_bpermute_b32 v11, v1, v10
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB15_63
; %bb.62:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_64
.LBB15_63:
	s_mov_b32 s5, 0
.LBB15_64:                              ; %Flow160
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.65:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v10, v10, v11
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v11, v5, v10
	s_cbranch_scc0 .LBB15_67
; %bb.66:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_68
.LBB15_67:
	s_mov_b32 s5, 0
.LBB15_68:                              ; %Flow162
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.69:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v10, v10, v11
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v11, v6, v10
	s_cbranch_scc0 .LBB15_71
; %bb.70:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_72
.LBB15_71:
	s_mov_b32 s5, 0
.LBB15_72:                              ; %Flow164
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.73:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v10, v10, v11
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v11, v7, v10
	s_cbranch_scc0 .LBB15_75
; %bb.74:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_76
.LBB15_75:
	s_mov_b32 s5, 0
.LBB15_76:                              ; %Flow166
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.77:                               ; %_ZL15warp_reduce_sumILi32EEff.exit.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v10, v10, v11
	ds_bpermute_b32 v11, v0, v10
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB15_79
; %bb.78:
	s_lshl_b32 s4, s11, 1
	s_mov_b32 s5, 0
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v10, v10, v11 :: v_dual_mov_b32 v11, 0
	s_lshl_b64 s[4:5], s[4:5], 2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_add_u32 s4, s0, s4
	s_addc_u32 s5, s1, s5
	global_store_b32 v11, v10, s[4:5]
.LBB15_79:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_81
; %bb.80:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_82
.LBB15_81:
	s_mov_b32 s5, 0
.LBB15_82:                              ; %Flow168
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.83:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.3
	ds_bpermute_b32 v10, v1, v9
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB15_85
; %bb.84:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_86
.LBB15_85:
	s_mov_b32 s5, 0
.LBB15_86:                              ; %Flow170
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.87:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v9, v9, v10
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v10, v5, v9
	s_cbranch_scc0 .LBB15_89
; %bb.88:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_90
.LBB15_89:
	s_mov_b32 s5, 0
.LBB15_90:                              ; %Flow172
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.91:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v9, v9, v10
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v10, v6, v9
	s_cbranch_scc0 .LBB15_93
; %bb.92:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_94
.LBB15_93:
	s_mov_b32 s5, 0
.LBB15_94:                              ; %Flow174
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.95:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v9, v9, v10
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v10, v7, v9
	s_cbranch_scc0 .LBB15_97
; %bb.96:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_98
.LBB15_97:
	s_mov_b32 s5, 0
.LBB15_98:                              ; %Flow176
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.99:                               ; %_ZL15warp_reduce_sumILi32EEff.exit.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v9, v9, v10
	ds_bpermute_b32 v10, v0, v9
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB15_101
; %bb.100:
	s_mul_i32 s4, s11, 3
	s_mov_b32 s5, 0
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v9, v9, v10 :: v_dual_mov_b32 v10, 0
	s_lshl_b64 s[4:5], s[4:5], 2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_add_u32 s4, s0, s4
	s_addc_u32 s5, s1, s5
	global_store_b32 v10, v9, s[4:5]
.LBB15_101:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_103
; %bb.102:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_104
.LBB15_103:
	s_mov_b32 s5, 0
.LBB15_104:                             ; %Flow178
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.105:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.4
	ds_bpermute_b32 v9, v1, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB15_107
; %bb.106:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_108
.LBB15_107:
	s_mov_b32 s5, 0
.LBB15_108:                             ; %Flow180
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.109:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.4
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v8, v8, v9
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v9, v5, v8
	s_cbranch_scc0 .LBB15_111
; %bb.110:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_112
.LBB15_111:
	s_mov_b32 s5, 0
.LBB15_112:                             ; %Flow182
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.113:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.4
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v8, v8, v9
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v9, v6, v8
	s_cbranch_scc0 .LBB15_115
; %bb.114:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_116
.LBB15_115:
	s_mov_b32 s5, 0
.LBB15_116:                             ; %Flow184
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.117:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.4
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v8, v8, v9
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v9, v7, v8
	s_cbranch_scc0 .LBB15_119
; %bb.118:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_120
.LBB15_119:
	s_mov_b32 s5, 0
.LBB15_120:                             ; %Flow186
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.121:                              ; %_ZL15warp_reduce_sumILi32EEff.exit.4
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v8, v8, v9
	ds_bpermute_b32 v9, v0, v8
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB15_123
; %bb.122:
	s_lshl_b32 s4, s11, 2
	s_mov_b32 s5, 0
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v8, v8, v9 :: v_dual_mov_b32 v9, 0
	s_lshl_b64 s[4:5], s[4:5], 2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_add_u32 s4, s0, s4
	s_addc_u32 s5, s1, s5
	global_store_b32 v9, v8, s[4:5]
.LBB15_123:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_125
; %bb.124:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_126
.LBB15_125:
	s_mov_b32 s5, 0
.LBB15_126:                             ; %Flow188
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.127:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.5
	ds_bpermute_b32 v8, v1, v4
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB15_129
; %bb.128:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_130
.LBB15_129:
	s_mov_b32 s5, 0
.LBB15_130:                             ; %Flow190
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.131:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.5
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v4, v4, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v5, v4
	s_cbranch_scc0 .LBB15_133
; %bb.132:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_134
.LBB15_133:
	s_mov_b32 s5, 0
.LBB15_134:                             ; %Flow192
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.135:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.5
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v4, v4, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v6, v4
	s_cbranch_scc0 .LBB15_137
; %bb.136:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_138
.LBB15_137:
	s_mov_b32 s5, 0
.LBB15_138:                             ; %Flow194
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.139:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.5
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v4, v4, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v7, v4
	s_cbranch_scc0 .LBB15_141
; %bb.140:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_142
.LBB15_141:
	s_mov_b32 s5, 0
.LBB15_142:                             ; %Flow196
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.143:                              ; %_ZL15warp_reduce_sumILi32EEff.exit.5
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v4, v4, v8
	ds_bpermute_b32 v8, v0, v4
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB15_145
; %bb.144:
	s_mul_i32 s4, s11, 5
	s_mov_b32 s5, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v4, v4, v8
	s_lshl_b64 s[4:5], s[4:5], 2
	v_mov_b32_e32 v8, 0
	s_add_u32 s4, s0, s4
	s_addc_u32 s5, s1, s5
	global_store_b32 v8, v4, s[4:5]
.LBB15_145:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_147
; %bb.146:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_148
.LBB15_147:
	s_mov_b32 s5, 0
.LBB15_148:                             ; %Flow198
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.149:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.6
	ds_bpermute_b32 v4, v1, v3
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB15_151
; %bb.150:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_152
.LBB15_151:
	s_mov_b32 s5, 0
.LBB15_152:                             ; %Flow200
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.153:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.6
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v3, v4
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v4, v5, v3
	s_cbranch_scc0 .LBB15_155
; %bb.154:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_156
.LBB15_155:
	s_mov_b32 s5, 0
.LBB15_156:                             ; %Flow202
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.157:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.6
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v3, v4
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v4, v6, v3
	s_cbranch_scc0 .LBB15_159
; %bb.158:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_160
.LBB15_159:
	s_mov_b32 s5, 0
.LBB15_160:                             ; %Flow204
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.161:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.6
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v3, v4
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v4, v7, v3
	s_cbranch_scc0 .LBB15_163
; %bb.162:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_164
.LBB15_163:
	s_mov_b32 s5, 0
.LBB15_164:                             ; %Flow206
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.165:                              ; %_ZL15warp_reduce_sumILi32EEff.exit.6
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v3, v4
	ds_bpermute_b32 v4, v0, v3
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB15_167
; %bb.166:
	s_mul_i32 s4, s11, 6
	s_mov_b32 s5, 0
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v3, v3, v4 :: v_dual_mov_b32 v4, 0
	s_lshl_b64 s[4:5], s[4:5], 2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_add_u32 s4, s0, s4
	s_addc_u32 s5, s1, s5
	global_store_b32 v4, v3, s[4:5]
.LBB15_167:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_169
; %bb.168:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_170
.LBB15_169:
	s_mov_b32 s5, 0
.LBB15_170:                             ; %Flow208
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.171:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.7
	ds_bpermute_b32 v1, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB15_173
; %bb.172:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_174
.LBB15_173:
	s_mov_b32 s5, 0
.LBB15_174:                             ; %Flow210
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.175:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.7
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v2, v1
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v5, v1
	s_cbranch_scc0 .LBB15_177
; %bb.176:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_178
.LBB15_177:
	s_mov_b32 s5, 0
.LBB15_178:                             ; %Flow212
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.179:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.7
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v6, v1
	s_cbranch_scc0 .LBB15_181
; %bb.180:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB15_182
.LBB15_181:
	s_mov_b32 s5, 0
.LBB15_182:                             ; %Flow214
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB15_185
; %bb.183:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.7
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s5, 0
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v1, v7, v2
	s_cbranch_scc0 .LBB15_186
; %bb.184:
	s_cmp_lg_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	v_mov_b32_e32 v3, s11
	s_branch .LBB15_31
.LBB15_185:                             ; %Flow149
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr2
.LBB15_186:                             ; %Flow149
	v_mov_b32_e32 v3, s11
	s_branch .LBB15_31
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
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
		.amdhsa_next_free_vgpr 69
		.amdhsa_next_free_sgpr 20
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
		.amdhsa_inst_pref_size 36
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end15:
	.size	_Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj, .Lfunc_end15-_Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_vgpr, 69
	.set _Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 20
	.set _Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 4564
; TotalNumSgprs: 22
; NumVgprs: 69
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 1024 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 8
; NumSGPRsForWavesPerEU: 22
; NumVGPRsForWavesPerEU: 69
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.section	.text._Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_clause 0x1
	s_load_b128 s[12:15], s[0:1], 0x20
	s_load_b256 s[4:11], s[0:1], 0x0
	v_bfe_u32 v2, v0, 10, 10
	v_dual_mov_b32 v15, 0 :: v_dual_and_b32 v14, 0x3ff, v0
	v_mov_b32_e32 v16, 0
	s_mov_b32 s1, exec_lo
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_add_u32 v0, v2, 5, v14
	v_lshrrev_b32_e32 v3, 2, v0
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s12, s12, 5
	s_delay_alu instid0(VALU_DEP_1) | instid1(SALU_CYCLE_1)
	v_cmpx_gt_u32_e64 s12, v3
	s_cbranch_execz .LBB16_4
; %bb.1:                                ; %.lr.ph
	v_dual_mov_b32 v16, 0 :: v_dual_lshlrev_b32 v1, 1, v14
	s_mul_i32 s0, s14, s3
	v_lshrrev_b32_e32 v5, 2, v0
	s_mul_i32 s14, s0, 36
	s_mul_hi_u32 s0, s0, 36
	s_add_u32 s8, s8, s14
	v_dual_mov_b32 v15, 0 :: v_dual_and_b32 v4, 3, v14
	v_and_b32_e32 v6, 6, v1
	s_addc_u32 s9, s9, s0
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_mad_u64_u32 v[0:1], null, v5, 36, s[8:9]
	v_lshlrev_b32_e32 v4, 3, v4
	s_delay_alu instid0(VALU_DEP_3)
	v_lshlrev_b32_e32 v5, 2, v6
	s_mul_i32 s9, s13, s2
	s_mov_b32 s8, 0
.LBB16_2:                               ; %.preheader114
                                        ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v12, s9, v3
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v6, vcc_lo, v0, v4
	v_add_co_ci_u32_e64 v7, null, 0, v1, vcc_lo
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_mad_i64_i32 v[8:9], null, v12, 34, s[4:5]
	v_mad_i64_i32 v[10:11], null, v12, 34, s[6:7]
	v_add_co_u32 v12, vcc_lo, v8, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v13, null, 0, v9, vcc_lo
	v_add_co_u32 v17, vcc_lo, v10, v5
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v18, null, 0, v11, vcc_lo
	s_clause 0x1
	global_load_b32 v21, v[0:1], off
	global_load_b64 v[19:20], v[6:7], off offset:4
	global_load_b64 v[12:13], v[12:13], off offset:2
	global_load_b64 v[17:18], v[17:18], off offset:2
	global_load_d16_b16 v6, v[8:9], off
	global_load_d16_hi_b16 v6, v[10:11], off
	v_add_co_u32 v0, vcc_lo, 0x900, v0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v1, null, 0, v1, vcc_lo
	s_waitcnt vmcnt(5)
	v_cvt_f32_f16_e32 v7, v21.l
	s_waitcnt vmcnt(3)
	v_dot4_i32_iu8 v8, v12, v19, 0 neg_lo:[1,1,0]
	s_waitcnt vmcnt(2)
	v_dot4_i32_iu8 v9, v17, v19, 0 neg_lo:[1,1,0]
	s_waitcnt vmcnt(0)
	v_cvt_f32_f16_e32 v10, v6.l
	v_cvt_f32_f16_e32 v6, v6.h
	v_add_nc_u32_e32 v3, 64, v3
	v_dot4_i32_iu8 v8, v13, v20, v8 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v9, v18, v20, v9 neg_lo:[1,1,0]
	v_mul_f32_e32 v10, v10, v7
	v_mul_f32_e32 v6, v7, v6
	v_cmp_le_u32_e64 s0, s12, v3
	v_cvt_f32_i32_e32 v7, v8
	v_cvt_f32_i32_e32 v8, v9
	s_or_b32 s8, s0, s8
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_fmac_f32_e32 v16, v10, v7
	v_fmac_f32_e32 v15, v6, v8
	s_and_not1_b32 exec_lo, exec_lo, s8
	s_cbranch_execnz .LBB16_2
; %bb.3:                                ; %Flow198
	s_or_b32 exec_lo, exec_lo, s8
.LBB16_4:                               ; %Flow199
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s1
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v2
	v_cmpx_ne_u32_e32 0, v2
; %bb.5:                                ; %.preheader112
	v_lshl_add_u32 v0, v2, 7, 0xffffff80
	s_delay_alu instid0(VALU_DEP_1)
	v_lshl_add_u32 v0, v14, 2, v0
	ds_store_2addr_b32 v0, v16, v15 offset1:224
; %bb.6:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB16_52
; %bb.7:                                ; %.preheader
	v_lshlrev_b32_e32 v2, 2, v14
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s1
	v_add_nc_u32_e32 v3, 0x400, v2
	ds_load_2addr_b32 v[10:11], v2 offset1:32
	ds_load_2addr_b32 v[0:1], v2 offset0:192 offset1:224
	ds_load_2addr_b32 v[12:13], v2 offset0:64 offset1:96
	ds_load_2addr_b32 v[8:9], v2 offset0:128 offset1:160
	ds_load_2addr_b32 v[6:7], v3 offset1:32
	ds_load_2addr_b32 v[4:5], v3 offset0:64 offset1:96
	ds_load_2addr_b32 v[2:3], v3 offset0:128 offset1:160
	s_cbranch_vccnz .LBB16_10
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB16_11
.LBB16_9:
                                        ; implicit-def: $vgpr8
                                        ; implicit-def: $vgpr12
                                        ; implicit-def: $vgpr16
                                        ; implicit-def: $vgpr11
                                        ; implicit-def: $vgpr10
                                        ; implicit-def: $vgpr9
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $vgpr13
	s_branch .LBB16_26
.LBB16_10:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB16_9
.LBB16_11:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i
	s_waitcnt lgkmcnt(6)
	v_add_f32_e32 v10, v16, v10
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_add_f32_e32 v10, v10, v11
	s_waitcnt lgkmcnt(4)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_f32_e32 v10, v10, v12
	v_add_f32_e32 v10, v10, v13
	v_mbcnt_lo_u32_b32 v13, -1, 0
	s_waitcnt lgkmcnt(3)
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_f32_e32 v8, v10, v8
	v_xor_b32_e32 v10, 16, v13
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_f32_e32 v8, v8, v9
	v_cmp_gt_i32_e32 vcc_lo, 32, v10
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_dual_add_f32 v8, v8, v0 :: v_dual_cndmask_b32 v9, v13, v10
	v_dual_mov_b32 v0, 32 :: v_dual_lshlrev_b32 v9, 2, v9
	ds_bpermute_b32 v10, v9, v8
	s_cbranch_scc0 .LBB16_14
; %bb.12:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB16_15
.LBB16_13:
                                        ; implicit-def: $vgpr8
                                        ; implicit-def: $vgpr12
                                        ; implicit-def: $vgpr16
                                        ; implicit-def: $vgpr11
                                        ; implicit-def: $vgpr10
	s_branch .LBB16_26
.LBB16_14:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB16_13
.LBB16_15:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i
	v_xor_b32_e32 v11, 8, v13
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v8, v8, v10
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v11
	v_cndmask_b32_e32 v11, v13, v11, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v10, 2, v11
	ds_bpermute_b32 v11, v10, v8
	s_cbranch_scc0 .LBB16_18
; %bb.16:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB16_19
.LBB16_17:
                                        ; implicit-def: $vgpr8
                                        ; implicit-def: $vgpr12
                                        ; implicit-def: $vgpr16
                                        ; implicit-def: $vgpr11
	s_branch .LBB16_26
.LBB16_18:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB16_17
.LBB16_19:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i
	v_xor_b32_e32 v12, 4, v13
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v12
	v_cndmask_b32_e32 v12, v13, v12, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v8, v8, v11 :: v_dual_lshlrev_b32 v11, 2, v12
	ds_bpermute_b32 v12, v11, v8
	s_cbranch_scc0 .LBB16_22
; %bb.20:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccz .LBB16_23
.LBB16_21:
                                        ; implicit-def: $vgpr8
                                        ; implicit-def: $vgpr12
                                        ; implicit-def: $vgpr16
	s_branch .LBB16_26
.LBB16_22:
	s_mov_b32 s0, 0
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB16_21
.LBB16_23:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i
	v_xor_b32_e32 v16, 2, v13
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_cmp_gt_i32_e32 vcc_lo, 32, v16
	v_cndmask_b32_e32 v17, v13, v16, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v16, v8, v12
	v_lshlrev_b32_e32 v12, 2, v17
	ds_bpermute_b32 v8, v12, v16
	s_cbranch_scc0 .LBB16_25
; %bb.24:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_branch .LBB16_26
.LBB16_25:
	s_mov_b32 s0, 0
	s_mov_b32 s4, -1
.LBB16_26:                              ; %Flow175
	s_mov_b32 s1, 0
	s_and_b32 vcc_lo, exec_lo, s0
	s_mov_b32 s0, 0
	s_cbranch_vccnz .LBB16_39
; %bb.27:                               ; %Flow183
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB16_41
.LBB16_28:                              ; %_ZL15warp_reduce_sumILi32EEff.exit
	s_waitcnt lgkmcnt(4)
	v_xor_b32_e32 v17, 1, v13
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v8, v16, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	v_cmp_lt_i32_e32 vcc_lo, v17, v0
	s_cmp_lg_u32 exec_lo, 0
	v_cndmask_b32_e32 v0, v13, v17, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v13, 2, v0
	ds_bpermute_b32 v0, v13, v8
	s_cbranch_scc0 .LBB16_30
; %bb.29:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB16_31
	s_branch .LBB16_46
.LBB16_30:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB16_46
.LBB16_31:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i89
	v_add_f32_e32 v1, v15, v1
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_f32_e32 v1, v1, v6
	v_add_f32_e32 v1, v1, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_f32_e32 v1, v1, v4
	v_add_f32_e32 v1, v1, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_f32_e32 v1, v1, v2
	v_add_f32_e32 v1, v1, v3
	ds_bpermute_b32 v2, v9, v1
	s_cbranch_scc0 .LBB16_33
; %bb.32:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB16_34
	s_branch .LBB16_46
.LBB16_33:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB16_46
.LBB16_34:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i92
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v10, v1
	s_cbranch_scc0 .LBB16_36
; %bb.35:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccz .LBB16_37
	s_branch .LBB16_46
.LBB16_36:
	s_mov_b32 s4, 0
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB16_46
.LBB16_37:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i95
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v11, v1
	s_cbranch_scc0 .LBB16_42
; %bb.38:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	s_branch .LBB16_43
.LBB16_39:
	s_cbranch_execnz .LBB16_53
; %bb.40:
	s_mov_b32 s0, -1
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB16_28
.LBB16_41:
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $vgpr13
                                        ; implicit-def: $vgpr8
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB16_48
	s_branch .LBB16_49
.LBB16_42:
	s_mov_b32 s4, 0
.LBB16_43:                              ; %Flow191
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB16_46
; %bb.44:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i98
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v1, v2
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v1, v12, v2
	s_cbranch_scc0 .LBB16_55
; %bb.45:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB16_47
	s_branch .LBB16_56
.LBB16_46:
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr2
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB16_56
.LBB16_47:                              ; %Flow184
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB16_49
.LBB16_48:                              ; %UnifiedUnreachableBlock
	; divergent unreachable
.LBB16_49:                              ; %Flow195
	s_and_not1_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB16_52
; %bb.50:                               ; %_ZL15warp_reduce_sumILi32EEff.exit102
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v2, v1
	v_cmp_eq_u32_e32 vcc_lo, 0, v14
	s_mov_b32 s1, 0
	ds_bpermute_b32 v2, v13, v1
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB16_52
; %bb.51:
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v1, v1, v2 :: v_dual_add_f32 v0, v8, v0
	s_mul_i32 s0, s15, s3
	s_ashr_i32 s3, s2, 31
	s_lshl_b64 s[0:1], s[0:1], 2
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(SALU_CYCLE_1)
	v_mul_f32_e32 v2, 0xbfb8aa3b, v1
	s_add_u32 s4, s10, s0
	s_addc_u32 s5, s11, s1
	s_lshl_b64 s[0:1], s[2:3], 2
	s_add_u32 s0, s4, s0
	v_fma_f32 v3, 0xbfb8aa3b, v1, -v2
	v_rndne_f32_e32 v4, v2
	s_addc_u32 s1, s5, s1
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_sub_f32_e32 v2, v2, v4
	v_cmp_nlt_f32_e32 vcc_lo, 0x42ce8ed0, v1
	v_fmamk_f32 v3, v1, 0xb2a5705f, v3
	v_add_f32_e32 v2, v2, v3
	v_cvt_i32_f32_e32 v3, v4
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_exp_f32_e32 v2, v2
	s_waitcnt_depctr 0xfff
	v_ldexp_f32 v2, v2, v3
	v_cndmask_b32_e32 v2, 0, v2, vcc_lo
	v_cmp_ngt_f32_e32 vcc_lo, 0xc2b17218, v1
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_cndmask_b32_e32 v2, 0x7f800000, v2, vcc_lo
	v_add_f32_e32 v2, 1.0, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_div_scale_f32 v3, null, v2, v2, v1
	v_rcp_f32_e32 v4, v3
	s_waitcnt_depctr 0xfff
	v_fma_f32 v5, -v3, v4, 1.0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_fmac_f32_e32 v4, v5, v4
	v_div_scale_f32 v5, vcc_lo, v1, v2, v1
	v_mul_f32_e32 v6, v5, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fma_f32 v7, -v3, v6, v5
	v_fmac_f32_e32 v6, v7, v4
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_fma_f32 v3, -v3, v6, v5
	v_div_fmas_f32 v3, v3, v4, v6
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
	v_div_fixup_f32 v1, v3, v2, v1
	v_mov_b32_e32 v2, 0
	v_mul_f32_e32 v0, v0, v1
	global_store_b32 v2, v0, s[0:1]
.LBB16_52:                              ; %UnifiedReturnBlock
	s_endpgm
.LBB16_53:
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
.LBB16_54:                              ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB16_54
.LBB16_55:
	s_mov_b32 s1, -1
	s_branch .LBB16_47
.LBB16_56:
	s_cbranch_execnz .LBB16_58
; %bb.57:
	s_cbranch_execnz .LBB16_48
	s_branch .LBB16_49
.LBB16_58:
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
.LBB16_59:                              ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB16_59
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj
		.amdhsa_group_segment_fixed_size 1792
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
		.amdhsa_next_free_vgpr 22
		.amdhsa_next_free_sgpr 16
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
		.amdhsa_inst_pref_size 16
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end16:
	.size	_Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj, .Lfunc_end16-_Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj.num_vgpr, 22
	.set _Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 16
	.set _Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 1944
; TotalNumSgprs: 18
; NumVgprs: 22
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 1792 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 2
; NumSGPRsForWavesPerEU: 18
; NumVGPRsForWavesPerEU: 22
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.section	.text._Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_load_b256 s[4:11], s[0:1], 0x10
	v_bfe_u32 v2, v0, 10, 10
	v_dual_mov_b32 v7, 0 :: v_dual_and_b32 v6, 0x3ff, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_add_u32 v0, v2, 5, v6
	v_lshrrev_b32_e32 v3, 2, v0
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s14, s8, 5
	s_mov_b32 s8, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_gt_u32_e64 s14, v3
	s_cbranch_execz .LBB17_4
; %bb.1:                                ; %.lr.ph
	s_load_b64 s[12:13], s[0:1], 0x0
	v_lshlrev_b32_e32 v1, 1, v6
	s_mul_i32 s0, s10, s3
	v_lshrrev_b32_e32 v7, 2, v0
	s_mul_i32 s1, s0, 36
	s_mul_hi_u32 s10, s0, 36
	s_add_u32 s0, s4, s1
	v_and_b32_e32 v5, 6, v1
	v_and_b32_e32 v4, 3, v6
	s_addc_u32 s1, s5, s10
	s_mul_i32 s4, s9, s2
	v_mad_u64_u32 v[0:1], null, v7, 36, s[0:1]
	s_delay_alu instid0(VALU_DEP_2)
	v_dual_mov_b32 v7, 0 :: v_dual_lshlrev_b32 v4, 3, v4
	v_lshlrev_b32_e32 v5, 2, v5
	s_mov_b32 s1, 0
	s_set_inst_prefetch_distance 0x1
	.p2align	6
.LBB17_2:                               ; %.preheader72
                                        ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v12, s4, v3
	s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_co_u32 v8, vcc_lo, v0, v4
	v_add_co_ci_u32_e64 v9, null, 0, v1, vcc_lo
	s_waitcnt lgkmcnt(0)
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_mad_i64_i32 v[10:11], null, v12, 34, s[12:13]
	global_load_b64 v[12:13], v[8:9], off offset:4
	v_add_co_u32 v8, vcc_lo, v10, v5
	v_add_co_ci_u32_e64 v9, null, 0, v11, vcc_lo
	global_load_b32 v16, v[0:1], off
	s_clause 0x1
	global_load_b64 v[14:15], v[8:9], off offset:2
	global_load_d16_b16 v8, v[10:11], off
	v_add_co_u32 v0, s0, 0x900, v0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v1, null, 0, v1, s0
	s_waitcnt vmcnt(2)
	v_cvt_f32_f16_e32 v9, v16.l
	s_waitcnt vmcnt(1)
	v_dot4_i32_iu8 v10, v14, v12, 0 neg_lo:[1,1,0]
	s_waitcnt vmcnt(0)
	v_cvt_f32_f16_e32 v8, v8.l
	v_add_nc_u32_e32 v3, 64, v3
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_dot4_i32_iu8 v10, v15, v13, v10 neg_lo:[1,1,0]
	v_mul_f32_e32 v8, v8, v9
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_cmp_le_u32_e32 vcc_lo, s14, v3
	v_cvt_f32_i32_e32 v9, v10
	s_or_b32 s1, vcc_lo, s1
	s_delay_alu instid0(VALU_DEP_1)
	v_fmac_f32_e32 v7, v8, v9
	s_and_not1_b32 exec_lo, exec_lo, s1
	s_cbranch_execnz .LBB17_2
; %bb.3:                                ; %Flow120
	s_set_inst_prefetch_distance 0x2
	s_or_b32 exec_lo, exec_lo, s1
.LBB17_4:                               ; %Flow121
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s8
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v2
	v_cmpx_ne_u32_e32 0, v2
	s_cbranch_execz .LBB17_6
; %bb.5:                                ; %.preheader70
	v_lshlrev_b32_e32 v0, 7, v2
	v_lshlrev_b32_e32 v1, 2, v6
	s_delay_alu instid0(VALU_DEP_1)
	v_add3_u32 v0, v0, v1, 0xffffff80
	ds_store_b32 v0, v7
.LBB17_6:
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB17_24
; %bb.7:                                ; %.preheader
	v_lshlrev_b32_e32 v8, 2, v6
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, 0
	s_cselect_b32 s4, -1, 0
	ds_load_2addr_b32 v[4:5], v8 offset1:32
	ds_load_2addr_b32 v[2:3], v8 offset0:64 offset1:96
	ds_load_2addr_b32 v[0:1], v8 offset0:128 offset1:160
	ds_load_b32 v8, v8 offset:768
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB17_10
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB17_11
.LBB17_9:
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $vgpr2
	s_branch .LBB17_20
.LBB17_10:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB17_9
.LBB17_11:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i
	s_waitcnt lgkmcnt(3)
	v_add_f32_e32 v4, v7, v4
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_add_f32_e32 v4, v4, v5
	s_waitcnt lgkmcnt(2)
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_f32_e32 v2, v4, v2
	v_add_f32_e32 v3, v2, v3
	v_mbcnt_lo_u32_b32 v2, -1, 0
	s_waitcnt lgkmcnt(1)
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_f32_e32 v0, v3, v0
	v_xor_b32_e32 v3, 16, v2
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_f32_e32 v0, v0, v1
	v_cmp_gt_i32_e32 vcc_lo, 32, v3
	v_cndmask_b32_e32 v3, v2, v3, vcc_lo
	s_waitcnt lgkmcnt(0)
	s_delay_alu instid0(VALU_DEP_1)
	v_dual_add_f32 v1, v0, v8 :: v_dual_lshlrev_b32 v0, 2, v3
	ds_bpermute_b32 v3, v0, v1
	v_mov_b32_e32 v0, 32
	s_cbranch_scc0 .LBB17_13
; %bb.12:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB17_14
	s_branch .LBB17_19
.LBB17_13:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB17_19
.LBB17_14:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i
	v_xor_b32_e32 v4, 8, v2
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v1, v3
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v4, v2, v4, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v3, 2, v4
	ds_bpermute_b32 v3, v3, v1
	s_cbranch_scc0 .LBB17_16
; %bb.15:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB17_17
	s_branch .LBB17_19
.LBB17_16:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB17_19
.LBB17_17:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i
	v_xor_b32_e32 v4, 4, v2
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v1, v3
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v4, v2, v4, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v3, 2, v4
	ds_bpermute_b32 v3, v3, v1
	s_cbranch_scc0 .LBB17_25
; %bb.18:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB17_26
.LBB17_19:
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr3
.LBB17_20:                              ; %Flow109
	s_and_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB17_28
; %bb.21:                               ; %Flow117
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB17_24
.LBB17_22:                              ; %_ZL15warp_reduce_sumILi32EEff.exit
	s_waitcnt lgkmcnt(2)
	v_xor_b32_e32 v4, 1, v2
	s_mov_b32 s1, 0
	s_waitcnt lgkmcnt(1)
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_4) | instid1(VALU_DEP_3)
	v_cmp_lt_i32_e32 vcc_lo, v4, v0
	v_cndmask_b32_e32 v2, v2, v4, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v0, v3, v1
	v_cmp_eq_u32_e32 vcc_lo, 0, v6
	v_lshlrev_b32_e32 v1, 2, v2
	ds_bpermute_b32 v1, v1, v0
	s_and_b32 exec_lo, exec_lo, vcc_lo
	s_cbranch_execz .LBB17_24
; %bb.23:
	s_mul_i32 s0, s11, s3
	s_ashr_i32 s3, s2, 31
	s_lshl_b64 s[0:1], s[0:1], 2
	v_mov_b32_e32 v2, 0
	s_add_u32 s4, s6, s0
	s_addc_u32 s5, s7, s1
	s_lshl_b64 s[0:1], s[2:3], 2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v0, v0, v1
	s_add_u32 s0, s4, s0
	s_addc_u32 s1, s5, s1
	global_store_b32 v2, v0, s[0:1]
.LBB17_24:                              ; %UnifiedReturnBlock
	s_endpgm
.LBB17_25:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB17_19
.LBB17_26:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i
	v_xor_b32_e32 v4, 2, v2
	s_cmp_lg_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v1, v3
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v4
	v_cndmask_b32_e32 v4, v2, v4, vcc_lo
	v_lshlrev_b32_e32 v1, 2, v4
	ds_bpermute_b32 v1, v1, v3
	s_cbranch_scc0 .LBB17_32
; %bb.27:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, -1
	s_cselect_b32 s1, -1, 0
	s_branch .LBB17_20
.LBB17_28:
	s_cbranch_execnz .LBB17_30
; %bb.29:
	; divergent unreachable
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB17_22
	s_branch .LBB17_24
.LBB17_30:
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
.LBB17_31:                              ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB17_31
.LBB17_32:
	s_mov_b32 s1, 0
	s_mov_b32 s0, -1
	s_branch .LBB17_20
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj
		.amdhsa_group_segment_fixed_size 896
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
		.amdhsa_next_free_vgpr 17
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
		.amdhsa_inst_pref_size 9
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end17:
	.size	_Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj, .Lfunc_end17-_Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj.num_vgpr, 17
	.set _Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 15
	.set _Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 1144
; TotalNumSgprs: 17
; NumVgprs: 17
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 896 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 2
; NumSGPRsForWavesPerEU: 17
; NumVGPRsForWavesPerEU: 17
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.section	.text._Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_load_b256 s[4:11], s[0:1], 0x10
	v_bfe_u32 v5, v0, 10, 10
	v_dual_mov_b32 v2, 0 :: v_dual_and_b32 v3, 0x3ff, v0
	v_mov_b32_e32 v4, 0
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v0, v5, 5, v3
	v_lshrrev_b32_e32 v6, 2, v0
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s14, s8, 5
	s_mov_b32 s8, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_gt_u32_e64 s14, v6
	s_cbranch_execz .LBB18_4
; %bb.1:                                ; %.lr.ph
	s_load_b64 s[12:13], s[0:1], 0x0
	v_lshl_add_u32 v0, v5, 5, v3
	s_mul_i32 s15, s10, s3
	v_dual_mov_b32 v4, 0 :: v_dual_lshlrev_b32 v1, 1, v3
	s_mul_hi_u32 s0, s15, 36
	s_mul_i32 s15, s15, 36
	v_lshrrev_b32_e32 v2, 2, v0
	s_add_u32 s4, s4, s15
	s_addc_u32 s5, s5, s0
	v_and_b32_e32 v7, 3, v3
	v_and_b32_e32 v8, 6, v1
	v_mad_u64_u32 v[0:1], null, v2, 36, s[4:5]
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_dual_mov_b32 v2, 0 :: v_dual_lshlrev_b32 v7, 3, v7
	v_lshlrev_b32_e32 v8, 2, v8
	s_mul_i32 s9, s9, s2
	s_mov_b32 s1, 0
.LBB18_2:                               ; %.preheader73
                                        ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v13, s9, v6
	v_add_nc_u32_e32 v15, s10, v6
	v_add_co_u32 v9, vcc_lo, v0, v7
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_3) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v10, null, 0, v1, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_mad_i64_i32 v[11:12], null, v13, 34, s[12:13]
	v_mad_u64_u32 v[13:14], null, v15, 36, s[4:5]
	v_add_co_u32 v15, vcc_lo, v11, v8
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v16, null, 0, v12, vcc_lo
	v_add_co_u32 v17, vcc_lo, v13, v8
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v18, null, 0, v14, vcc_lo
	s_clause 0x1
	global_load_b32 v21, v[0:1], off
	global_load_b64 v[19:20], v[9:10], off offset:4
	global_load_b64 v[15:16], v[15:16], off offset:2
	global_load_b64 v[17:18], v[17:18], off offset:4
	global_load_d16_b16 v9, v[11:12], off
	global_load_b32 v10, v[13:14], off
	v_add_co_u32 v0, vcc_lo, 0x120, v0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v1, null, 0, v1, vcc_lo
	s_waitcnt vmcnt(5)
	v_cvt_f32_f16_e32 v11, v21.l
	s_waitcnt vmcnt(3)
	v_dot4_i32_iu8 v12, v15, v19, 0 neg_lo:[1,1,0]
	s_waitcnt vmcnt(2)
	v_dot4_i32_iu8 v13, v15, v17, 0 neg_lo:[1,1,0]
	s_waitcnt vmcnt(1)
	v_cvt_f32_f16_e32 v9, v9.l
	s_waitcnt vmcnt(0)
	v_cvt_f32_f16_e32 v10, v10.l
	v_add_nc_u32_e32 v6, 8, v6
	v_dot4_i32_iu8 v12, v16, v20, v12 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v13, v16, v18, v13 neg_lo:[1,1,0]
	v_mul_f32_e32 v11, v9, v11
	v_mul_f32_e32 v9, v9, v10
	v_cmp_le_u32_e64 s0, s14, v6
	v_cvt_f32_i32_e32 v10, v12
	v_cvt_f32_i32_e32 v12, v13
	s_or_b32 s1, s0, s1
	s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_fmac_f32_e32 v4, v11, v10
	v_fmac_f32_e32 v2, v9, v12
	s_and_not1_b32 exec_lo, exec_lo, s1
	s_cbranch_execnz .LBB18_2
; %bb.3:                                ; %Flow137
	s_or_b32 exec_lo, exec_lo, s1
.LBB18_4:                               ; %Flow138
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s8
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v5
	v_cmpx_ne_u32_e32 0, v5
	s_cbranch_execz .LBB18_6
; %bb.5:                                ; %.preheader
	v_lshlrev_b32_e32 v0, 8, v5
	v_lshlrev_b32_e32 v1, 2, v3
	s_delay_alu instid0(VALU_DEP_1)
	v_add3_u32 v0, v0, v1, 0xffffff00
	ds_store_2addr_b32 v0, v4, v2 offset1:32
.LBB18_6:                               ; %.loopexit72
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB18_35
; %bb.7:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, 0
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB18_9
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB18_10
	s_branch .LBB18_30
.LBB18_9:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB18_30
.LBB18_10:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i
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
	ds_bpermute_b32 v5, v0, v4
	s_cbranch_scc0 .LBB18_12
; %bb.11:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB18_13
	s_branch .LBB18_30
.LBB18_12:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB18_30
.LBB18_13:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i
	v_xor_b32_e32 v6, 8, v1
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v5, v4, v5
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v6
	v_cndmask_b32_e32 v6, v1, v6, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v4, 2, v6
	ds_bpermute_b32 v6, v4, v5
	s_cbranch_scc0 .LBB18_15
; %bb.14:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB18_16
	s_branch .LBB18_30
.LBB18_15:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB18_30
.LBB18_16:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i
	v_xor_b32_e32 v7, 4, v1
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v7
	v_cndmask_b32_e32 v7, v1, v7, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v6, v5, v6 :: v_dual_lshlrev_b32 v5, 2, v7
	ds_bpermute_b32 v7, v5, v6
	s_cbranch_scc0 .LBB18_18
; %bb.17:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccz .LBB18_19
	s_branch .LBB18_30
.LBB18_18:
	s_mov_b32 s1, 0
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB18_30
.LBB18_19:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i
	v_xor_b32_e32 v8, 2, v1
	s_cmp_lg_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v6, v7
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v8
	v_cndmask_b32_e32 v8, v1, v8, vcc_lo
	v_lshlrev_b32_e32 v6, 2, v8
	ds_bpermute_b32 v8, v6, v7
	s_cbranch_scc0 .LBB18_21
; %bb.20:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s4, -1, 0
	s_branch .LBB18_22
.LBB18_21:
	s_mov_b32 s4, -1
	s_mov_b32 s1, 0
.LBB18_22:                              ; %Flow124
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB18_30
; %bb.23:                               ; %_ZL15warp_reduce_sumILi32EEff.exit
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
	v_cmp_eq_u32_e64 s4, 0, v3
	v_cndmask_b32_e32 v1, v1, v9, vcc_lo
	s_lshl_b64 s[2:3], s[2:3], 2
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	s_add_u32 s2, s0, s2
	s_addc_u32 s3, s5, s3
	v_lshlrev_b32_e32 v1, 2, v1
	ds_bpermute_b32 v8, v1, v7
	s_and_saveexec_b32 s0, s4
	s_cbranch_execz .LBB18_25
; %bb.24:
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v7, v8
	v_mov_b32_e32 v7, 0
	global_store_b32 v7, v3, s[2:3]
.LBB18_25:
	s_or_b32 exec_lo, exec_lo, s0
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s0, -1, 0
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB18_27
; %bb.26:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s0, -1, 0
.LBB18_27:                              ; %Flow126
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB18_40
; %bb.28:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.1
	ds_bpermute_b32 v0, v0, v2
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s0, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB18_41
; %bb.29:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s5, -1, 0
	s_branch .LBB18_42
.LBB18_30:
                                        ; implicit-def: $sgpr4
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $sgpr2_sgpr3
                                        ; implicit-def: $vgpr0
.LBB18_31:                              ; %Flow117
	s_and_b32 vcc_lo, exec_lo, s1
	s_cbranch_vccnz .LBB18_36
; %bb.32:                               ; %Flow135
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB18_35
.LBB18_33:                              ; %_ZL15warp_reduce_sumILi32EEff.exit.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v3, v2
	ds_bpermute_b32 v3, v1, v2
	s_and_b32 exec_lo, exec_lo, s4
	s_cbranch_execz .LBB18_35
; %bb.34:
	s_waitcnt lgkmcnt(0)
	v_dual_mov_b32 v1, 0 :: v_dual_add_f32 v2, v2, v3
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshlrev_b64 v[0:1], 2, v[0:1]
	v_add_co_u32 v0, vcc_lo, s2, v0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v1, null, s3, v1, vcc_lo
	global_store_b32 v[0:1], v2, off
.LBB18_35:                              ; %UnifiedReturnBlock
	s_endpgm
.LBB18_36:
	s_cbranch_execnz .LBB18_38
; %bb.37:
	; divergent unreachable
	s_cbranch_execz .LBB18_33
	s_branch .LBB18_35
.LBB18_38:
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
.LBB18_39:                              ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB18_39
.LBB18_40:
	s_mov_b32 s0, 0
	s_branch .LBB18_53
.LBB18_41:
	s_mov_b32 s1, 0
.LBB18_42:                              ; %Flow128
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB18_53
; %bb.43:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v0, v2, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v4, v0
	s_cbranch_scc0 .LBB18_45
; %bb.44:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s5, -1, 0
	s_branch .LBB18_46
.LBB18_45:
	s_mov_b32 s1, 0
.LBB18_46:                              ; %Flow130
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB18_53
; %bb.47:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v0, v0, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s5, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v5, v0
	s_cbranch_scc0 .LBB18_49
; %bb.48:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s1, -1
	s_cselect_b32 s5, -1, 0
	s_branch .LBB18_50
.LBB18_49:
	s_mov_b32 s1, 0
.LBB18_50:                              ; %Flow132
	s_and_not1_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB18_53
; %bb.51:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v0, v2
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s1, 0
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v6, v3
	s_cbranch_scc0 .LBB18_54
; %bb.52:
	s_cmp_lg_u32 exec_lo, -1
	s_mov_b32 s0, -1
	s_cselect_b32 s1, -1, 0
	v_mov_b32_e32 v0, s11
	s_branch .LBB18_31
.LBB18_53:                              ; %Flow127
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr3
.LBB18_54:                              ; %Flow127
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v0, s11
	s_branch .LBB18_31
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
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
		.amdhsa_next_free_vgpr 22
		.amdhsa_next_free_sgpr 16
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
		.amdhsa_inst_pref_size 12
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end18:
	.size	_Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj, .Lfunc_end18-_Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_vgpr, 22
	.set _Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 16
	.set _Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 1516
; TotalNumSgprs: 18
; NumVgprs: 22
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 256 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 2
; NumSGPRsForWavesPerEU: 18
; NumVGPRsForWavesPerEU: 22
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.section	.text._Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_load_b256 s[4:11], s[0:1], 0x10
	v_bfe_u32 v5, v0, 10, 10
	v_dual_mov_b32 v3, 0 :: v_dual_and_b32 v8, 0x3ff, v0
	v_dual_mov_b32 v2, 0 :: v_dual_mov_b32 v7, 0
	v_mov_b32_e32 v4, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_lshl_or_b32 v0, v5, 5, v8
	v_lshrrev_b32_e32 v6, 2, v0
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s12, s8, 5
	s_mov_b32 s8, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_gt_u32_e64 s12, v6
	s_cbranch_execz .LBB19_4
; %bb.1:                                ; %.lr.ph
	s_load_b64 s[0:1], s[0:1], 0x0
	v_lshl_add_u32 v0, v5, 5, v8
	s_mul_i32 s13, s10, s3
	v_dual_mov_b32 v4, 0 :: v_dual_lshlrev_b32 v1, 1, v8
	s_mul_i32 s14, s13, 36
	s_delay_alu instid0(VALU_DEP_2)
	v_lshrrev_b32_e32 v3, 2, v0
	s_mul_hi_u32 s13, s13, 36
	s_add_u32 s4, s4, s14
	s_addc_u32 s5, s5, s13
	v_and_b32_e32 v2, 3, v8
	v_and_b32_e32 v7, 6, v1
	v_mad_u64_u32 v[0:1], null, v3, 36, s[4:5]
	v_mov_b32_e32 v3, 0
	s_mul_i32 s9, s9, s2
	s_delay_alu instid0(VALU_DEP_3)
	v_dual_mov_b32 v7, 0 :: v_dual_lshlrev_b32 v10, 2, v7
	v_dual_mov_b32 v2, 0 :: v_dual_lshlrev_b32 v9, 3, v2
	s_lshl_b32 s13, s10, 1
	s_mul_i32 s15, s10, 3
	s_mov_b32 s14, 0
.LBB19_2:                               ; %.preheader73
                                        ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v15, s9, v6
	v_add_nc_u32_e32 v19, s10, v6
	v_add_nc_u32_e32 v21, s13, v6
	v_add_co_u32 v11, vcc_lo, v0, v9
	s_waitcnt lgkmcnt(0)
	v_mad_i64_i32 v[13:14], null, v15, 34, s[0:1]
	v_add_nc_u32_e32 v23, s15, v6
	v_mad_u64_u32 v[17:18], null, v19, 36, s[4:5]
	v_add_co_ci_u32_e64 v12, null, 0, v1, vcc_lo
	v_mad_u64_u32 v[19:20], null, v21, 36, s[4:5]
	s_delay_alu instid0(VALU_DEP_4) | instskip(SKIP_4) | instid1(VALU_DEP_1)
	v_mad_u64_u32 v[21:22], null, v23, 36, s[4:5]
	s_clause 0x1
	global_load_b32 v31, v[0:1], off
	global_load_b64 v[15:16], v[11:12], off offset:4
	v_add_co_u32 v11, vcc_lo, v13, v10
	v_add_co_ci_u32_e64 v12, null, 0, v14, vcc_lo
	v_add_co_u32 v23, vcc_lo, v17, v10
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v24, null, 0, v18, vcc_lo
	v_add_co_u32 v25, vcc_lo, v19, v10
	v_add_co_ci_u32_e64 v26, null, 0, v20, vcc_lo
	v_add_co_u32 v27, vcc_lo, v21, v10
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v28, null, 0, v22, vcc_lo
	s_clause 0x1
	global_load_b64 v[29:30], v[11:12], off offset:2
	global_load_d16_b16 v11, v[13:14], off
	s_clause 0x5
	global_load_b64 v[12:13], v[23:24], off offset:4
	global_load_b32 v14, v[19:20], off
	global_load_b32 v23, v[17:18], off
	global_load_b64 v[17:18], v[25:26], off offset:4
	global_load_b64 v[19:20], v[27:28], off offset:4
	global_load_b32 v21, v[21:22], off
	v_add_co_u32 v0, vcc_lo, 0x120, v0
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v1, null, 0, v1, vcc_lo
	s_waitcnt vmcnt(9)
	v_cvt_f32_f16_e32 v22, v31.l
	s_waitcnt vmcnt(7)
	v_dot4_i32_iu8 v15, v29, v15, 0 neg_lo:[1,1,0]
	s_waitcnt vmcnt(6)
	v_cvt_f32_f16_e32 v11, v11.l
	s_waitcnt vmcnt(5)
	v_dot4_i32_iu8 v12, v29, v12, 0 neg_lo:[1,1,0]
	s_waitcnt vmcnt(4)
	v_cvt_f32_f16_e32 v14, v14.l
	s_waitcnt vmcnt(3)
	v_cvt_f32_f16_e32 v23, v23.l
	s_waitcnt vmcnt(2)
	v_dot4_i32_iu8 v17, v29, v17, 0 neg_lo:[1,1,0]
	s_waitcnt vmcnt(1)
	v_dot4_i32_iu8 v19, v29, v19, 0 neg_lo:[1,1,0]
	s_waitcnt vmcnt(0)
	v_cvt_f32_f16_e32 v21, v21.l
	v_dot4_i32_iu8 v15, v30, v16, v15 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v12, v30, v13, v12 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v17, v30, v18, v17 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v18, v30, v20, v19 neg_lo:[1,1,0]
	v_dual_mul_f32 v13, v11, v23 :: v_dual_add_nc_u32 v6, 8, v6
	v_mul_f32_e32 v14, v11, v14
	v_cvt_f32_i32_e32 v15, v15
	v_cvt_f32_i32_e32 v12, v12
	v_mul_f32_e32 v16, v11, v22
	v_mul_f32_e32 v11, v11, v21
	v_cvt_f32_i32_e32 v17, v17
	v_cvt_f32_i32_e32 v18, v18
	v_cmp_le_u32_e32 vcc_lo, s12, v6
	v_dual_fmac_f32 v7, v13, v12 :: v_dual_fmac_f32 v4, v16, v15
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	v_dual_fmac_f32 v3, v14, v17 :: v_dual_fmac_f32 v2, v11, v18
	s_or_b32 s14, vcc_lo, s14
	s_and_not1_b32 exec_lo, exec_lo, s14
	s_cbranch_execnz .LBB19_2
; %bb.3:                                ; %Flow163
	s_or_b32 exec_lo, exec_lo, s14
.LBB19_4:                               ; %Flow164
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s8
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v5
	v_cmpx_ne_u32_e32 0, v5
	s_cbranch_execz .LBB19_6
; %bb.5:                                ; %.preheader
	v_lshlrev_b32_e32 v0, 9, v5
	v_lshlrev_b32_e32 v1, 2, v8
	s_delay_alu instid0(VALU_DEP_1)
	v_add3_u32 v0, v0, v1, 0xfffffe00
	ds_store_2addr_b32 v0, v4, v7 offset1:32
	ds_store_2addr_b32 v0, v3, v2 offset0:64 offset1:96
.LBB19_6:                               ; %.loopexit72
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB19_35
; %bb.7:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB19_9
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB19_10
	s_branch .LBB19_30
.LBB19_9:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB19_30
.LBB19_10:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i
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
	ds_bpermute_b32 v5, v1, v4
	s_cbranch_scc0 .LBB19_12
; %bb.11:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB19_13
	s_branch .LBB19_30
.LBB19_12:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB19_30
.LBB19_13:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i
	v_xor_b32_e32 v6, 8, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v6
	v_cndmask_b32_e32 v6, v0, v6, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v5, v4, v5 :: v_dual_lshlrev_b32 v4, 2, v6
	ds_bpermute_b32 v6, v4, v5
	s_cbranch_scc0 .LBB19_15
; %bb.14:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB19_16
	s_branch .LBB19_30
.LBB19_15:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB19_30
.LBB19_16:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i
	v_xor_b32_e32 v9, 4, v0
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v6, v5, v6
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v9
	v_cndmask_b32_e32 v9, v0, v9, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v5, 2, v9
	ds_bpermute_b32 v9, v5, v6
	s_cbranch_scc0 .LBB19_18
; %bb.17:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB19_19
	s_branch .LBB19_30
.LBB19_18:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB19_30
.LBB19_19:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i
	v_xor_b32_e32 v10, 2, v0
	s_cmp_lg_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v9, v6, v9
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v10
	v_cndmask_b32_e32 v10, v0, v10, vcc_lo
	v_lshlrev_b32_e32 v6, 2, v10
	ds_bpermute_b32 v10, v6, v9
	s_cbranch_scc0 .LBB19_21
; %bb.20:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_branch .LBB19_22
.LBB19_21:
	s_mov_b32 s0, -1
	s_mov_b32 s5, 0
.LBB19_22:                              ; %Flow130
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB19_30
; %bb.23:                               ; %_ZL15warp_reduce_sumILi32EEff.exit
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
	s_cbranch_execz .LBB19_25
; %bb.24:
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v8, v9, v10 :: v_dual_mov_b32 v9, 0
	global_store_b32 v9, v8, s[0:1]
.LBB19_25:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB19_27
; %bb.26:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
.LBB19_27:                              ; %Flow132
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB19_40
; %bb.28:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.1
	ds_bpermute_b32 v8, v1, v7
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB19_41
; %bb.29:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB19_42
.LBB19_30:
                                        ; implicit-def: $sgpr2
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $sgpr0_sgpr1
                                        ; implicit-def: $vgpr3
.LBB19_31:                              ; %Flow123
	s_and_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB19_36
; %bb.32:                               ; %Flow161
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB19_35
.LBB19_33:                              ; %_ZL15warp_reduce_sumILi32EEff.exit.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v2, v1
	ds_bpermute_b32 v0, v0, v1
	s_and_b32 exec_lo, exec_lo, s2
	s_cbranch_execz .LBB19_35
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
.LBB19_35:                              ; %UnifiedReturnBlock
	s_endpgm
.LBB19_36:
	s_cbranch_execnz .LBB19_38
; %bb.37:
	; divergent unreachable
	s_cbranch_execz .LBB19_33
	s_branch .LBB19_35
.LBB19_38:
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
.LBB19_39:                              ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB19_39
.LBB19_40:
	s_mov_b32 s4, 0
	s_branch .LBB19_97
.LBB19_41:
	s_mov_b32 s5, 0
.LBB19_42:                              ; %Flow134
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB19_97
; %bb.43:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v4, v7
	s_cbranch_scc0 .LBB19_45
; %bb.44:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB19_46
.LBB19_45:
	s_mov_b32 s5, 0
.LBB19_46:                              ; %Flow136
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB19_97
; %bb.47:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v5, v7
	s_cbranch_scc0 .LBB19_49
; %bb.48:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB19_50
.LBB19_49:
	s_mov_b32 s5, 0
.LBB19_50:                              ; %Flow138
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB19_97
; %bb.51:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v6, v7
	s_cbranch_scc0 .LBB19_53
; %bb.52:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB19_54
.LBB19_53:
	s_mov_b32 s5, 0
.LBB19_54:                              ; %Flow140
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB19_97
; %bb.55:                               ; %_ZL15warp_reduce_sumILi32EEff.exit.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v7, v7, v8
	ds_bpermute_b32 v8, v0, v7
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB19_57
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
.LBB19_57:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB19_59
; %bb.58:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB19_60
.LBB19_59:
	s_mov_b32 s5, 0
.LBB19_60:                              ; %Flow142
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB19_97
; %bb.61:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.2
	ds_bpermute_b32 v7, v1, v3
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB19_63
; %bb.62:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB19_64
.LBB19_63:
	s_mov_b32 s5, 0
.LBB19_64:                              ; %Flow144
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB19_97
; %bb.65:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v3, v7
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v7, v4, v3
	s_cbranch_scc0 .LBB19_67
; %bb.66:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB19_68
.LBB19_67:
	s_mov_b32 s5, 0
.LBB19_68:                              ; %Flow146
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB19_97
; %bb.69:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v3, v7
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v7, v5, v3
	s_cbranch_scc0 .LBB19_71
; %bb.70:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB19_72
.LBB19_71:
	s_mov_b32 s5, 0
.LBB19_72:                              ; %Flow148
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB19_97
; %bb.73:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v3, v7
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v7, v6, v3
	s_cbranch_scc0 .LBB19_75
; %bb.74:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB19_76
.LBB19_75:
	s_mov_b32 s5, 0
.LBB19_76:                              ; %Flow150
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB19_97
; %bb.77:                               ; %_ZL15warp_reduce_sumILi32EEff.exit.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v3, v7
	ds_bpermute_b32 v7, v0, v3
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB19_79
; %bb.78:
	s_lshl_b32 s4, s11, 1
	s_mov_b32 s5, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v3, v7
	s_lshl_b64 s[4:5], s[4:5], 2
	v_mov_b32_e32 v7, 0
	s_add_u32 s4, s0, s4
	s_addc_u32 s5, s1, s5
	global_store_b32 v7, v3, s[4:5]
.LBB19_79:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB19_81
; %bb.80:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB19_82
.LBB19_81:
	s_mov_b32 s5, 0
.LBB19_82:                              ; %Flow152
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB19_97
; %bb.83:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.3
	ds_bpermute_b32 v1, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB19_85
; %bb.84:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB19_86
.LBB19_85:
	s_mov_b32 s5, 0
.LBB19_86:                              ; %Flow154
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB19_97
; %bb.87:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v2, v1
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v4, v1
	s_cbranch_scc0 .LBB19_89
; %bb.88:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB19_90
.LBB19_89:
	s_mov_b32 s5, 0
.LBB19_90:                              ; %Flow156
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB19_97
; %bb.91:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v5, v1
	s_cbranch_scc0 .LBB19_93
; %bb.92:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB19_94
.LBB19_93:
	s_mov_b32 s5, 0
.LBB19_94:                              ; %Flow158
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB19_97
; %bb.95:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s5, 0
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v1, v6, v2
	s_cbranch_scc0 .LBB19_98
; %bb.96:
	s_cmp_lg_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	v_mov_b32_e32 v3, s11
	s_branch .LBB19_31
.LBB19_97:                              ; %Flow133
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr2
.LBB19_98:                              ; %Flow133
	v_mov_b32_e32 v3, s11
	s_branch .LBB19_31
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
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
		.amdhsa_next_free_vgpr 32
		.amdhsa_next_free_sgpr 16
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
		.amdhsa_inst_pref_size 19
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end19:
	.size	_Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj, .Lfunc_end19-_Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_vgpr, 32
	.set _Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 16
	.set _Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 2428
; TotalNumSgprs: 18
; NumVgprs: 32
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 512 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 3
; NumSGPRsForWavesPerEU: 18
; NumVGPRsForWavesPerEU: 32
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 2
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 1
	.section	.text._Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,comdat
	.protected	_Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj ; -- Begin function _Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
	.globl	_Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
	.p2align	8
	.type	_Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,@function
_Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj: ; @_Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
; %bb.0:
	s_load_b256 s[4:11], s[0:1], 0x10
	v_bfe_u32 v6, v0, 10, 10
	v_dual_mov_b32 v3, 0 :: v_dual_and_b32 v12, 0x3ff, v0
	v_dual_mov_b32 v2, 0 :: v_dual_mov_b32 v9, 0
	v_dual_mov_b32 v4, 0 :: v_dual_mov_b32 v11, 0
	s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_2) | instid1(VALU_DEP_3)
	v_lshl_or_b32 v0, v6, 5, v12
	v_dual_mov_b32 v8, 0 :: v_dual_mov_b32 v5, 0
	v_mov_b32_e32 v10, 0
	v_lshrrev_b32_e32 v7, 2, v0
	s_waitcnt lgkmcnt(0)
	s_lshr_b32 s12, s8, 5
	s_mov_b32 s8, exec_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmpx_gt_u32_e64 s12, v7
	s_cbranch_execz .LBB20_4
; %bb.1:                                ; %.lr.ph
	s_load_b64 s[0:1], s[0:1], 0x0
	v_lshl_add_u32 v0, v6, 5, v12
	s_mul_i32 s13, s10, s3
	v_dual_mov_b32 v10, 0 :: v_dual_lshlrev_b32 v1, 1, v12
	s_mul_i32 s14, s13, 36
	s_delay_alu instid0(VALU_DEP_2)
	v_lshrrev_b32_e32 v3, 2, v0
	s_mul_hi_u32 s13, s13, 36
	s_add_u32 s4, s4, s14
	s_addc_u32 s5, s5, s13
	v_dual_mov_b32 v5, 0 :: v_dual_and_b32 v2, 3, v12
	v_dual_mov_b32 v11, 0 :: v_dual_and_b32 v4, 6, v1
	v_mad_u64_u32 v[0:1], null, v3, 36, s[4:5]
	s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_dual_mov_b32 v8, 0 :: v_dual_lshlrev_b32 v13, 3, v2
	v_dual_mov_b32 v9, 0 :: v_dual_lshlrev_b32 v14, 2, v4
	v_dual_mov_b32 v4, 0 :: v_dual_mov_b32 v3, 0
	v_mov_b32_e32 v2, 0
	s_mul_i32 s9, s9, s2
	s_lshl_b32 s13, s10, 1
	s_mul_i32 s14, s10, 3
	s_lshl_b32 s15, s10, 2
	s_mul_i32 s16, s10, 5
	s_mul_i32 s17, s10, 6
	s_mul_i32 s19, s10, 7
	s_mov_b32 s18, 0
.LBB20_2:                               ; %.preheader73
                                        ; =>This Inner Loop Header: Depth=1
	v_add_nc_u32_e32 v19, s9, v7
	v_add_nc_u32_e32 v23, s10, v7
	v_add_nc_u32_e32 v25, s13, v7
	v_add_co_u32 v15, vcc_lo, v0, v13
	s_waitcnt lgkmcnt(0)
	v_mad_i64_i32 v[17:18], null, v19, 34, s[0:1]
	v_add_nc_u32_e32 v27, s14, v7
	v_mad_u64_u32 v[21:22], null, v23, 36, s[4:5]
	v_add_co_ci_u32_e64 v16, null, 0, v1, vcc_lo
	v_add_nc_u32_e32 v29, s15, v7
	v_mad_u64_u32 v[23:24], null, v25, 36, s[4:5]
	v_add_nc_u32_e32 v31, s16, v7
	v_add_nc_u32_e32 v33, s17, v7
	v_add_nc_u32_e32 v35, s19, v7
	v_mad_u64_u32 v[25:26], null, v27, 36, s[4:5]
	s_clause 0x1
	global_load_b32 v51, v[0:1], off
	global_load_b64 v[19:20], v[15:16], off offset:4
	v_mad_u64_u32 v[27:28], null, v29, 36, s[4:5]
	v_add_co_u32 v15, vcc_lo, v17, v14
	v_mad_u64_u32 v[29:30], null, v31, 36, s[4:5]
	v_mad_u64_u32 v[31:32], null, v33, 36, s[4:5]
	v_mad_u64_u32 v[33:34], null, v35, 36, s[4:5]
	v_add_co_ci_u32_e64 v16, null, 0, v18, vcc_lo
	v_add_co_u32 v35, vcc_lo, v21, v14
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v36, null, 0, v22, vcc_lo
	v_add_co_u32 v37, vcc_lo, v23, v14
	v_add_co_ci_u32_e64 v38, null, 0, v24, vcc_lo
	v_add_co_u32 v39, vcc_lo, v25, v14
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v40, null, 0, v26, vcc_lo
	v_add_co_u32 v41, vcc_lo, v27, v14
	v_add_co_ci_u32_e64 v42, null, 0, v28, vcc_lo
	v_add_co_u32 v43, vcc_lo, v29, v14
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_co_ci_u32_e64 v44, null, 0, v30, vcc_lo
	v_add_co_u32 v45, vcc_lo, v31, v14
	v_add_co_ci_u32_e64 v46, null, 0, v32, vcc_lo
	v_add_co_u32 v47, vcc_lo, v33, v14
	s_delay_alu instid0(VALU_DEP_1)
	v_add_co_ci_u32_e64 v48, null, 0, v34, vcc_lo
	s_clause 0x1
	global_load_b64 v[49:50], v[15:16], off offset:2
	global_load_d16_b16 v15, v[17:18], off
	s_clause 0xd
	global_load_b64 v[16:17], v[35:36], off offset:4
	global_load_b32 v18, v[23:24], off
	global_load_b32 v35, v[21:22], off
	global_load_b64 v[21:22], v[37:38], off offset:4
	global_load_b64 v[23:24], v[39:40], off offset:4
	global_load_b32 v36, v[27:28], off
	global_load_b32 v37, v[25:26], off
	global_load_b64 v[25:26], v[41:42], off offset:4
	global_load_b64 v[27:28], v[43:44], off offset:4
	global_load_b32 v38, v[31:32], off
	global_load_b32 v39, v[29:30], off
	global_load_b64 v[29:30], v[45:46], off offset:4
	global_load_b64 v[31:32], v[47:48], off offset:4
	global_load_b32 v33, v[33:34], off
	v_add_nc_u32_e32 v7, 8, v7
	v_add_co_u32 v0, vcc_lo, 0x120, v0
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
	v_add_co_ci_u32_e64 v1, null, 0, v1, vcc_lo
	v_cmp_le_u32_e32 vcc_lo, s12, v7
	s_or_b32 s18, vcc_lo, s18
	s_waitcnt vmcnt(17)
	v_cvt_f32_f16_e32 v34, v51.l
	s_waitcnt vmcnt(15)
	v_dot4_i32_iu8 v19, v49, v19, 0 neg_lo:[1,1,0]
	s_waitcnt vmcnt(14)
	v_cvt_f32_f16_e32 v15, v15.l
	s_waitcnt vmcnt(13)
	v_dot4_i32_iu8 v16, v49, v16, 0 neg_lo:[1,1,0]
	s_waitcnt vmcnt(12)
	v_cvt_f32_f16_e32 v18, v18.l
	s_waitcnt vmcnt(11)
	v_cvt_f32_f16_e32 v35, v35.l
	s_waitcnt vmcnt(10)
	v_dot4_i32_iu8 v21, v49, v21, 0 neg_lo:[1,1,0]
	s_waitcnt vmcnt(9)
	v_dot4_i32_iu8 v23, v49, v23, 0 neg_lo:[1,1,0]
	s_waitcnt vmcnt(8)
	v_cvt_f32_f16_e32 v36, v36.l
	s_waitcnt vmcnt(7)
	v_cvt_f32_f16_e32 v37, v37.l
	s_waitcnt vmcnt(6)
	v_dot4_i32_iu8 v25, v49, v25, 0 neg_lo:[1,1,0]
	s_waitcnt vmcnt(5)
	v_dot4_i32_iu8 v27, v49, v27, 0 neg_lo:[1,1,0]
	s_waitcnt vmcnt(4)
	v_cvt_f32_f16_e32 v38, v38.l
	s_waitcnt vmcnt(3)
	v_cvt_f32_f16_e32 v39, v39.l
	s_waitcnt vmcnt(2)
	v_dot4_i32_iu8 v29, v49, v29, 0 neg_lo:[1,1,0]
	s_waitcnt vmcnt(1)
	v_dot4_i32_iu8 v31, v49, v31, 0 neg_lo:[1,1,0]
	s_waitcnt vmcnt(0)
	v_cvt_f32_f16_e32 v33, v33.l
	v_dot4_i32_iu8 v19, v50, v20, v19 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v16, v50, v17, v16 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v21, v50, v22, v21 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v22, v50, v24, v23 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v24, v50, v26, v25 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v26, v50, v28, v27 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v28, v50, v30, v29 neg_lo:[1,1,0]
	v_dot4_i32_iu8 v30, v50, v32, v31 neg_lo:[1,1,0]
	v_mul_f32_e32 v20, v15, v34
	v_mul_f32_e32 v17, v15, v35
	v_mul_f32_e32 v18, v15, v18
	v_mul_f32_e32 v23, v15, v37
	v_mul_f32_e32 v25, v15, v36
	v_mul_f32_e32 v27, v15, v39
	v_mul_f32_e32 v29, v15, v38
	v_mul_f32_e32 v15, v15, v33
	v_cvt_f32_i32_e32 v19, v19
	v_cvt_f32_i32_e32 v16, v16
	v_cvt_f32_i32_e32 v21, v21
	v_cvt_f32_i32_e32 v22, v22
	v_cvt_f32_i32_e32 v24, v24
	v_cvt_f32_i32_e32 v26, v26
	v_cvt_f32_i32_e32 v28, v28
	v_cvt_f32_i32_e32 v30, v30
	v_fmac_f32_e32 v5, v20, v19
	v_dual_fmac_f32 v11, v17, v16 :: v_dual_fmac_f32 v10, v18, v21
	v_dual_fmac_f32 v9, v23, v22 :: v_dual_fmac_f32 v8, v25, v24
	v_dual_fmac_f32 v4, v27, v26 :: v_dual_fmac_f32 v3, v29, v28
	v_fmac_f32_e32 v2, v15, v30
	s_and_not1_b32 exec_lo, exec_lo, s18
	s_cbranch_execnz .LBB20_2
; %bb.3:                                ; %Flow215
	s_or_b32 exec_lo, exec_lo, s18
.LBB20_4:                               ; %Flow216
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 exec_lo, exec_lo, s8
	s_mov_b32 s1, exec_lo
	v_cmp_eq_u32_e32 vcc_lo, 0, v6
	v_cmpx_ne_u32_e32 0, v6
	s_cbranch_execz .LBB20_6
; %bb.5:                                ; %.preheader
	v_lshlrev_b32_e32 v0, 10, v6
	v_lshlrev_b32_e32 v1, 2, v12
	s_delay_alu instid0(VALU_DEP_1)
	v_add3_u32 v0, v0, v1, 0xfffffc00
	ds_store_2addr_b32 v0, v5, v11 offset1:32
	ds_store_2addr_b32 v0, v10, v9 offset0:64 offset1:96
	ds_store_2addr_b32 v0, v8, v4 offset0:128 offset1:160
	ds_store_2addr_b32 v0, v3, v2 offset0:192 offset1:224
.LBB20_6:                               ; %.loopexit72
	s_or_b32 exec_lo, exec_lo, s1
	s_waitcnt lgkmcnt(0)
	; wave barrier
	buffer_gl0_inv
	s_and_saveexec_b32 s0, vcc_lo
	s_cbranch_execz .LBB20_35
; %bb.7:
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB20_9
; %bb.8:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB20_10
	s_branch .LBB20_30
.LBB20_9:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB20_30
.LBB20_10:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i
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
	ds_bpermute_b32 v6, v1, v5
	s_cbranch_scc0 .LBB20_12
; %bb.11:
	s_cmp_eq_u32 exec_lo, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB20_13
	s_branch .LBB20_30
.LBB20_12:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB20_30
.LBB20_13:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i
	v_xor_b32_e32 v7, 8, v0
	s_cmp_eq_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v6, v5, v6
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	v_cmp_gt_i32_e32 vcc_lo, 32, v7
	v_cndmask_b32_e32 v7, v0, v7, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_lshlrev_b32_e32 v5, 2, v7
	ds_bpermute_b32 v7, v5, v6
	s_cbranch_scc0 .LBB20_15
; %bb.14:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB20_16
	s_branch .LBB20_30
.LBB20_15:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB20_30
.LBB20_16:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i
	v_xor_b32_e32 v13, 4, v0
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s0, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v13
	v_cndmask_b32_e32 v13, v0, v13, vcc_lo
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v7, v6, v7 :: v_dual_lshlrev_b32 v6, 2, v13
	ds_bpermute_b32 v13, v6, v7
	s_cbranch_scc0 .LBB20_18
; %bb.17:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccz .LBB20_19
	s_branch .LBB20_30
.LBB20_18:
	s_mov_b32 s5, 0
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB20_30
.LBB20_19:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i
	v_xor_b32_e32 v14, 2, v0
	s_cmp_lg_u32 exec_lo, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v13, v7, v13
	s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_cmp_gt_i32_e32 vcc_lo, 32, v14
	v_cndmask_b32_e32 v14, v0, v14, vcc_lo
	v_lshlrev_b32_e32 v7, 2, v14
	ds_bpermute_b32 v14, v7, v13
	s_cbranch_scc0 .LBB20_21
; %bb.20:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s0, -1, 0
	s_branch .LBB20_22
.LBB20_21:
	s_mov_b32 s0, -1
	s_mov_b32 s5, 0
.LBB20_22:                              ; %Flow142
	s_and_not1_b32 vcc_lo, exec_lo, s0
	s_cbranch_vccnz .LBB20_30
; %bb.23:                               ; %_ZL15warp_reduce_sumILi32EEff.exit
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
	v_cmp_eq_u32_e64 s2, 0, v12
	s_add_u32 s0, s4, s0
	s_addc_u32 s1, s6, s1
	v_lshlrev_b32_e32 v0, 2, v0
	ds_bpermute_b32 v14, v0, v13
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB20_25
; %bb.24:
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v12, v13, v14 :: v_dual_mov_b32 v13, 0
	global_store_b32 v13, v12, s[0:1]
.LBB20_25:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_27
; %bb.26:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
.LBB20_27:                              ; %Flow144
	s_delay_alu instid0(SALU_CYCLE_1)
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_40
; %bb.28:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.1
	ds_bpermute_b32 v12, v1, v11
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB20_41
; %bb.29:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_42
.LBB20_30:
                                        ; implicit-def: $sgpr2
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr2
                                        ; implicit-def: $vgpr0
                                        ; implicit-def: $sgpr0_sgpr1
                                        ; implicit-def: $vgpr3
.LBB20_31:                              ; %Flow135
	s_and_b32 vcc_lo, exec_lo, s5
	s_cbranch_vccnz .LBB20_36
; %bb.32:                               ; %Flow213
	s_and_not1_b32 vcc_lo, exec_lo, s4
	s_cbranch_vccnz .LBB20_35
.LBB20_33:                              ; %_ZL15warp_reduce_sumILi32EEff.exit.7
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v2, v1
	ds_bpermute_b32 v0, v0, v1
	s_and_b32 exec_lo, exec_lo, s2
	s_cbranch_execz .LBB20_35
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
.LBB20_35:                              ; %UnifiedReturnBlock
	s_endpgm
.LBB20_36:
	s_cbranch_execnz .LBB20_38
; %bb.37:
	; divergent unreachable
	s_cbranch_execz .LBB20_33
	s_branch .LBB20_35
.LBB20_38:
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
.LBB20_39:                              ; =>This Inner Loop Header: Depth=1
	s_sethalt 5
	s_branch .LBB20_39
.LBB20_40:
	s_mov_b32 s4, 0
	s_branch .LBB20_185
.LBB20_41:
	s_mov_b32 s5, 0
.LBB20_42:                              ; %Flow146
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.43:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v11, v11, v12
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v12, v5, v11
	s_cbranch_scc0 .LBB20_45
; %bb.44:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_46
.LBB20_45:
	s_mov_b32 s5, 0
.LBB20_46:                              ; %Flow148
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.47:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v11, v11, v12
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v12, v6, v11
	s_cbranch_scc0 .LBB20_49
; %bb.48:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_50
.LBB20_49:
	s_mov_b32 s5, 0
.LBB20_50:                              ; %Flow150
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.51:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v11, v11, v12
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v12, v7, v11
	s_cbranch_scc0 .LBB20_53
; %bb.52:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_54
.LBB20_53:
	s_mov_b32 s5, 0
.LBB20_54:                              ; %Flow152
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.55:                               ; %_ZL15warp_reduce_sumILi32EEff.exit.1
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v11, v11, v12
	ds_bpermute_b32 v12, v0, v11
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB20_57
; %bb.56:
	s_mov_b32 s5, 0
	s_mov_b32 s4, s11
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v11, v11, v12 :: v_dual_mov_b32 v12, 0
	s_lshl_b64 s[4:5], s[4:5], 2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_add_u32 s4, s0, s4
	s_addc_u32 s5, s1, s5
	global_store_b32 v12, v11, s[4:5]
.LBB20_57:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_59
; %bb.58:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_60
.LBB20_59:
	s_mov_b32 s5, 0
.LBB20_60:                              ; %Flow154
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.61:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.2
	ds_bpermute_b32 v11, v1, v10
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB20_63
; %bb.62:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_64
.LBB20_63:
	s_mov_b32 s5, 0
.LBB20_64:                              ; %Flow156
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.65:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v10, v10, v11
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v11, v5, v10
	s_cbranch_scc0 .LBB20_67
; %bb.66:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_68
.LBB20_67:
	s_mov_b32 s5, 0
.LBB20_68:                              ; %Flow158
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.69:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v10, v10, v11
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v11, v6, v10
	s_cbranch_scc0 .LBB20_71
; %bb.70:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_72
.LBB20_71:
	s_mov_b32 s5, 0
.LBB20_72:                              ; %Flow160
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.73:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v10, v10, v11
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v11, v7, v10
	s_cbranch_scc0 .LBB20_75
; %bb.74:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_76
.LBB20_75:
	s_mov_b32 s5, 0
.LBB20_76:                              ; %Flow162
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.77:                               ; %_ZL15warp_reduce_sumILi32EEff.exit.2
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v10, v10, v11
	ds_bpermute_b32 v11, v0, v10
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB20_79
; %bb.78:
	s_lshl_b32 s4, s11, 1
	s_mov_b32 s5, 0
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v10, v10, v11 :: v_dual_mov_b32 v11, 0
	s_lshl_b64 s[4:5], s[4:5], 2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_add_u32 s4, s0, s4
	s_addc_u32 s5, s1, s5
	global_store_b32 v11, v10, s[4:5]
.LBB20_79:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_81
; %bb.80:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_82
.LBB20_81:
	s_mov_b32 s5, 0
.LBB20_82:                              ; %Flow164
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.83:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.3
	ds_bpermute_b32 v10, v1, v9
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB20_85
; %bb.84:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_86
.LBB20_85:
	s_mov_b32 s5, 0
.LBB20_86:                              ; %Flow166
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.87:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v9, v9, v10
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v10, v5, v9
	s_cbranch_scc0 .LBB20_89
; %bb.88:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_90
.LBB20_89:
	s_mov_b32 s5, 0
.LBB20_90:                              ; %Flow168
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.91:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v9, v9, v10
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v10, v6, v9
	s_cbranch_scc0 .LBB20_93
; %bb.92:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_94
.LBB20_93:
	s_mov_b32 s5, 0
.LBB20_94:                              ; %Flow170
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.95:                               ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v9, v9, v10
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v10, v7, v9
	s_cbranch_scc0 .LBB20_97
; %bb.96:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_98
.LBB20_97:
	s_mov_b32 s5, 0
.LBB20_98:                              ; %Flow172
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.99:                               ; %_ZL15warp_reduce_sumILi32EEff.exit.3
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v9, v9, v10
	ds_bpermute_b32 v10, v0, v9
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB20_101
; %bb.100:
	s_mul_i32 s4, s11, 3
	s_mov_b32 s5, 0
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v9, v9, v10 :: v_dual_mov_b32 v10, 0
	s_lshl_b64 s[4:5], s[4:5], 2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_add_u32 s4, s0, s4
	s_addc_u32 s5, s1, s5
	global_store_b32 v10, v9, s[4:5]
.LBB20_101:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_103
; %bb.102:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_104
.LBB20_103:
	s_mov_b32 s5, 0
.LBB20_104:                             ; %Flow174
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.105:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.4
	ds_bpermute_b32 v9, v1, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB20_107
; %bb.106:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_108
.LBB20_107:
	s_mov_b32 s5, 0
.LBB20_108:                             ; %Flow176
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.109:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.4
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v8, v8, v9
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v9, v5, v8
	s_cbranch_scc0 .LBB20_111
; %bb.110:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_112
.LBB20_111:
	s_mov_b32 s5, 0
.LBB20_112:                             ; %Flow178
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.113:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.4
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v8, v8, v9
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v9, v6, v8
	s_cbranch_scc0 .LBB20_115
; %bb.114:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_116
.LBB20_115:
	s_mov_b32 s5, 0
.LBB20_116:                             ; %Flow180
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.117:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.4
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v8, v8, v9
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v9, v7, v8
	s_cbranch_scc0 .LBB20_119
; %bb.118:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_120
.LBB20_119:
	s_mov_b32 s5, 0
.LBB20_120:                             ; %Flow182
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.121:                              ; %_ZL15warp_reduce_sumILi32EEff.exit.4
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v8, v8, v9
	ds_bpermute_b32 v9, v0, v8
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB20_123
; %bb.122:
	s_lshl_b32 s4, s11, 2
	s_mov_b32 s5, 0
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v8, v8, v9 :: v_dual_mov_b32 v9, 0
	s_lshl_b64 s[4:5], s[4:5], 2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_add_u32 s4, s0, s4
	s_addc_u32 s5, s1, s5
	global_store_b32 v9, v8, s[4:5]
.LBB20_123:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_125
; %bb.124:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_126
.LBB20_125:
	s_mov_b32 s5, 0
.LBB20_126:                             ; %Flow184
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.127:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.5
	ds_bpermute_b32 v8, v1, v4
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB20_129
; %bb.128:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_130
.LBB20_129:
	s_mov_b32 s5, 0
.LBB20_130:                             ; %Flow186
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.131:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.5
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v4, v4, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v5, v4
	s_cbranch_scc0 .LBB20_133
; %bb.132:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_134
.LBB20_133:
	s_mov_b32 s5, 0
.LBB20_134:                             ; %Flow188
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.135:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.5
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v4, v4, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v6, v4
	s_cbranch_scc0 .LBB20_137
; %bb.136:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_138
.LBB20_137:
	s_mov_b32 s5, 0
.LBB20_138:                             ; %Flow190
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.139:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.5
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v4, v4, v8
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v8, v7, v4
	s_cbranch_scc0 .LBB20_141
; %bb.140:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_142
.LBB20_141:
	s_mov_b32 s5, 0
.LBB20_142:                             ; %Flow192
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.143:                              ; %_ZL15warp_reduce_sumILi32EEff.exit.5
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v4, v4, v8
	ds_bpermute_b32 v8, v0, v4
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB20_145
; %bb.144:
	s_mul_i32 s4, s11, 5
	s_mov_b32 s5, 0
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v4, v4, v8
	s_lshl_b64 s[4:5], s[4:5], 2
	v_mov_b32_e32 v8, 0
	s_add_u32 s4, s0, s4
	s_addc_u32 s5, s1, s5
	global_store_b32 v8, v4, s[4:5]
.LBB20_145:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_147
; %bb.146:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_148
.LBB20_147:
	s_mov_b32 s5, 0
.LBB20_148:                             ; %Flow194
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.149:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.6
	ds_bpermute_b32 v4, v1, v3
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB20_151
; %bb.150:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_152
.LBB20_151:
	s_mov_b32 s5, 0
.LBB20_152:                             ; %Flow196
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.153:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.6
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v3, v4
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v4, v5, v3
	s_cbranch_scc0 .LBB20_155
; %bb.154:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_156
.LBB20_155:
	s_mov_b32 s5, 0
.LBB20_156:                             ; %Flow198
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.157:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.6
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v3, v4
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v4, v6, v3
	s_cbranch_scc0 .LBB20_159
; %bb.158:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_160
.LBB20_159:
	s_mov_b32 s5, 0
.LBB20_160:                             ; %Flow200
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.161:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.6
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v3, v4
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v4, v7, v3
	s_cbranch_scc0 .LBB20_163
; %bb.162:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_164
.LBB20_163:
	s_mov_b32 s5, 0
.LBB20_164:                             ; %Flow202
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.165:                              ; %_ZL15warp_reduce_sumILi32EEff.exit.6
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v3, v3, v4
	ds_bpermute_b32 v4, v0, v3
	s_and_saveexec_b32 s3, s2
	s_cbranch_execz .LBB20_167
; %bb.166:
	s_mul_i32 s4, s11, 6
	s_mov_b32 s5, 0
	s_waitcnt lgkmcnt(0)
	v_dual_add_f32 v3, v3, v4 :: v_dual_mov_b32 v4, 0
	s_lshl_b64 s[4:5], s[4:5], 2
	s_delay_alu instid0(SALU_CYCLE_1)
	s_add_u32 s4, s0, s4
	s_addc_u32 s5, s1, s5
	global_store_b32 v4, v3, s[4:5]
.LBB20_167:
	s_or_b32 exec_lo, exec_lo, s3
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s4, 0
	s_cselect_b32 s3, -1, 0
	s_and_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_169
; %bb.168:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_170
.LBB20_169:
	s_mov_b32 s5, 0
.LBB20_170:                             ; %Flow204
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.171:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.i.7
	ds_bpermute_b32 v1, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	s_cbranch_scc0 .LBB20_173
; %bb.172:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_174
.LBB20_173:
	s_mov_b32 s5, 0
.LBB20_174:                             ; %Flow206
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.175:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.1.i.7
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v2, v1
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v5, v1
	s_cbranch_scc0 .LBB20_177
; %bb.176:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_178
.LBB20_177:
	s_mov_b32 s5, 0
.LBB20_178:                             ; %Flow208
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.179:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.2.i.7
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v1, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_cselect_b32 s3, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v2, v6, v1
	s_cbranch_scc0 .LBB20_181
; %bb.180:
	s_cmp_eq_u32 exec_lo, -1
	s_mov_b32 s5, -1
	s_cselect_b32 s3, -1, 0
	s_branch .LBB20_182
.LBB20_181:
	s_mov_b32 s5, 0
.LBB20_182:                             ; %Flow210
	s_and_not1_b32 vcc_lo, exec_lo, s3
	s_cbranch_vccnz .LBB20_185
; %bb.183:                              ; %_Z15__shfl_xor_syncIyfET0_T_S0_ii.exit.3.i.7
	s_waitcnt lgkmcnt(0)
	v_add_f32_e32 v2, v1, v2
	s_cmp_eq_u32 exec_lo, 0
	s_mov_b32 s5, 0
	s_cselect_b32 s4, -1, 0
	s_cmp_lg_u32 exec_lo, 0
	ds_bpermute_b32 v1, v7, v2
	s_cbranch_scc0 .LBB20_186
; %bb.184:
	s_cmp_lg_u32 exec_lo, -1
	s_mov_b32 s4, -1
	s_cselect_b32 s5, -1, 0
	v_mov_b32_e32 v3, s11
	s_branch .LBB20_31
.LBB20_185:                             ; %Flow145
                                        ; implicit-def: $vgpr1
                                        ; implicit-def: $vgpr2
.LBB20_186:                             ; %Flow145
	v_mov_b32_e32 v3, s11
	s_branch .LBB20_31
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel _Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
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
		.amdhsa_next_free_vgpr 52
		.amdhsa_next_free_sgpr 20
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
		.amdhsa_inst_pref_size 34
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.section	.text._Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,"axG",@progbits,_Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj,comdat
.Lfunc_end20:
	.size	_Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj, .Lfunc_end20-_Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
                                        ; -- End function
	.set _Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_vgpr, 52
	.set _Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_agpr, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.numbered_sgpr, 20
	.set _Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.num_named_barrier, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.private_seg_size, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.uses_vcc, 1
	.set _Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.uses_flat_scratch, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_dyn_sized_stack, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_recursion, 0
	.set _Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.has_indirect_call, 0
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 4252
; TotalNumSgprs: 22
; NumVgprs: 52
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 1024 bytes/workgroup (compile time only)
; SGPRBlocks: 0
; VGPRBlocks: 6
; NumSGPRsForWavesPerEU: 22
; NumVGPRsForWavesPerEU: 52
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

	.type	__hip_cuid_f95d21602dfa792a,@object ; @__hip_cuid_f95d21602dfa792a
	.section	.bss,"aw",@nobits
	.globl	__hip_cuid_f95d21602dfa792a
__hip_cuid_f95d21602dfa792a:
	.byte	0                               ; 0x0
	.size	__hip_cuid_f95d21602dfa792a, 1

	.ident	"AMD clang version 22.0.0git (/srcdest/rocm-llvm f58b06dce1f9c15707c5f808fd002e18c2accf7e)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym __hip_cuid_f95d21602dfa792a
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
    .group_segment_fixed_size: 1280
    .kernarg_segment_align: 8
    .kernarg_segment_size: 48
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 32
    .name:           _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     37
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb1EEvPKvS2_S2_Pfjjjj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     92
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
    .group_segment_fixed_size: 1152
    .kernarg_segment_align: 8
    .kernarg_segment_size: 48
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 32
    .name:           _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     17
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb1EEvPKvS2_S2_Pfjjjj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     75
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
    .name:           _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     20
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi1ELb0EEvPKvS2_S2_Pfjjjj.kd
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
    .name:           _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     17
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.kd
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
    .name:           _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     20
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType18ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.kd
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
    .name:           _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     17
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType18ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.kd
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
    .name:           _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     23
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType18ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.kd
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
    .max_flat_workgroup_size: 64
    .name:           _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     20
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi2ELb0EEvPKvS2_S2_Pfjjjj.kd
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
    .max_flat_workgroup_size: 64
    .name:           _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     17
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi2ELb0EEvPKvS2_S2_Pfjjjj.kd
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
    .group_segment_fixed_size: 768
    .kernarg_segment_align: 8
    .kernarg_segment_size: 48
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 128
    .name:           _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     20
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType18ELi1ELb1ELi4ELb0EEvPKvS2_S2_Pfjjjj.kd
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
    .group_segment_fixed_size: 384
    .kernarg_segment_align: 8
    .kernarg_segment_size: 48
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 128
    .name:           _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     17
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType18ELi1ELb0ELi4ELb0EEvPKvS2_S2_Pfjjjj.kd
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
    .group_segment_fixed_size: 1792
    .kernarg_segment_align: 8
    .kernarg_segment_size: 48
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 256
    .name:           _Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     18
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType2ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     23
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
    .group_segment_fixed_size: 896
    .kernarg_segment_align: 8
    .kernarg_segment_size: 48
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 256
    .name:           _Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     17
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType2ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     17
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
    .name:           _Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     17
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType2ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     25
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
    .name:           _Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     18
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType2ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     41
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
    .name:           _Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     22
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType2ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     69
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
    .group_segment_fixed_size: 1792
    .kernarg_segment_align: 8
    .kernarg_segment_size: 48
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 256
    .name:           _Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     18
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType8ELi1ELb1ELi8ELb0EEvPKvS2_S2_Pfjjjj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     22
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
    .group_segment_fixed_size: 896
    .kernarg_segment_align: 8
    .kernarg_segment_size: 48
    .language:       OpenCL C
    .language_version:
      - 2
      - 0
    .max_flat_workgroup_size: 256
    .name:           _Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     17
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType8ELi1ELb0ELi8ELb0EEvPKvS2_S2_Pfjjjj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     17
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
    .name:           _Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     18
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType8ELi2ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     22
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
    .name:           _Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     18
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType8ELi4ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     32
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
    .name:           _Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj
    .private_segment_fixed_size: 0
    .sgpr_count:     22
    .sgpr_spill_count: 0
    .symbol:         _Z13mul_mat_vec_qIL5MType8ELi8ELb0ELi1ELb0EEvPKvS2_S2_Pfjjjj.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     52
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
amdhsa.target:   amdgcn-amd-amdhsa--gfx1101
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
