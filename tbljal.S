	.macro decbnez reg,target
	#ifndef TBL
	addi \reg, \reg, -1
	bnez \reg,\target
	#else
	# maximum loop size in this version is 32 bytes
	regoff = \reg*32
	tgtoff = .-\target
	off = (regoff+tgtoff)*2
	jalr t0,off(s11)
	#endif
	.endm

	# void* memcpy(void *dst, void *src, long sz)
	.globl memcpy
memcpy:
	beqz a2,2f
	mv a3,a0
1:
	lbu a4,0(a1)
	addi a1,a1,1
	sb a4,0(a3)
	addi a3,a3,1
	#ifdef TBL
	decbnez 4,1b # 4 is RVC number for a2
	#else
	decbnez a2,1b
	#endif
2:	
	ret

	.globl init_tbl
init_tbl:
	#ifdef TBL
	la s11,jump_tbl
	#endif
	ret

jump_tbl:
	jal t1,decbnez_s0
	jal t1,decbnez_s0
	jal t1,decbnez_s0
	jal t1,decbnez_s0
	jal t1,decbnez_s0
	jal t1,decbnez_s0
	jal t1,decbnez_s0
	jal t1,decbnez_s0
	jal t1,decbnez_s0
	jal t1,decbnez_s0
	jal t1,decbnez_s0
	jal t1,decbnez_s0
	jal t1,decbnez_s0
	jal t1,decbnez_s0
	jal t1,decbnez_s0
	jal t1,decbnez_s0

	jal t1,decbnez_s1
	jal t1,decbnez_s1
	jal t1,decbnez_s1
	jal t1,decbnez_s1
	jal t1,decbnez_s1
	jal t1,decbnez_s1
	jal t1,decbnez_s1
	jal t1,decbnez_s1
	jal t1,decbnez_s1
	jal t1,decbnez_s1
	jal t1,decbnez_s1
	jal t1,decbnez_s1
	jal t1,decbnez_s1
	jal t1,decbnez_s1
	jal t1,decbnez_s1
	jal t1,decbnez_s1

	jal t1,decbnez_a0
	jal t1,decbnez_a0
	jal t1,decbnez_a0
	jal t1,decbnez_a0
	jal t1,decbnez_a0
	jal t1,decbnez_a0
	jal t1,decbnez_a0
	jal t1,decbnez_a0
	jal t1,decbnez_a0
	jal t1,decbnez_a0
	jal t1,decbnez_a0
	jal t1,decbnez_a0
	jal t1,decbnez_a0
	jal t1,decbnez_a0
	jal t1,decbnez_a0
	jal t1,decbnez_a0

	jal t1,decbnez_a1
	jal t1,decbnez_a1
	jal t1,decbnez_a1
	jal t1,decbnez_a1
	jal t1,decbnez_a1
	jal t1,decbnez_a1
	jal t1,decbnez_a1
	jal t1,decbnez_a1
	jal t1,decbnez_a1
	jal t1,decbnez_a1
	jal t1,decbnez_a1
	jal t1,decbnez_a1
	jal t1,decbnez_a1
	jal t1,decbnez_a1
	jal t1,decbnez_a1
	jal t1,decbnez_a1

	jal t1,decbnez_a2
	jal t1,decbnez_a2
	jal t1,decbnez_a2
	jal t1,decbnez_a2
	jal t1,decbnez_a2
	jal t1,decbnez_a2
	jal t1,decbnez_a2
	jal t1,decbnez_a2
	jal t1,decbnez_a2
	jal t1,decbnez_a2
	jal t1,decbnez_a2
	jal t1,decbnez_a2
	jal t1,decbnez_a2
	jal t1,decbnez_a2
	jal t1,decbnez_a2
	jal t1,decbnez_a2

# entries for a3..a5 omitted

decbnez_s0:
	addi s0,s0,-1
	bnez s0,branch_tail
	jr t0

decbnez_s1:
	addi s1,s1,-1
	bnez s1,branch_tail
	jr t0

decbnez_a0:
	addi a0,a0,-1
	bnez a0,branch_tail
	jr t0

decbnez_a1:
	addi a1,a1,-1
	bnez a1,branch_tail
	jr t0

decbnez_a2:
	addi a2,a2,-1
	bnez a2,branch_tail
	jr t0

decbnez_a3:
	addi a3,a3,-1
	bnez a3,branch_tail
	jr t0

decbnez_a4:
	addi a4,a4,-1
	bnez a4,branch_tail
	jr t0

decbnez_a5:
	addi a5,a5,-1
	bnez a5,branch_tail
	jr t0

branch_tail:
	sub t1,t1,s11 # we just want bits 5..2 of this 
	srli t1,t1,1 
	andi t1,t1,0x1e
	addi t1,t1,2 # fudge factor
	sub t1,t0,t1
	jr t1 # don't try to use the return address stack
