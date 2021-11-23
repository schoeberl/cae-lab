	.file	"loop.c"
	.option nopic
	.attribute arch, "rv32i2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
 #APP
	li sp, 0x100000
	jal main
	li a7, 10
	ecall
 #NO_APP
	.align	2
	.globl	sum
	.type	sum, @function
sum:
	addi	sp,sp,-48
	sw	s0,44(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	sw	zero,-20(s0)
	sw	zero,-24(s0)
	j	.L2
.L3:
	lw	a5,-24(s0)
	slli	a5,a5,2
	lw	a4,-36(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	lw	a4,-20(s0)
	add	a5,a4,a5
	sw	a5,-20(s0)
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L2:
	lw	a4,-24(s0)
	lw	a5,-40(s0)
	blt	a4,a5,.L3
	lw	a5,-20(s0)
	mv	a0,a5
	lw	s0,44(sp)
	addi	sp,sp,48
	jr	ra
	.size	sum, .-sum
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	sw	s1,20(sp)
	addi	s0,sp,32
	mv	t1,sp
	mv	s1,t1
	li	t1,100
	sw	t1,-24(s0)
	lw	t1,-24(s0)
	addi	t3,t1,-1
	sw	t3,-28(s0)
	mv	t3,t1
	mv	a6,t3
	li	a7,0
	srli	t3,a6,27
	slli	a3,a7,5
	or	a3,t3,a3
	slli	a2,a6,5
	mv	a3,t1
	mv	a0,a3
	li	a1,0
	srli	a3,a0,27
	slli	a5,a1,5
	or	a5,a3,a5
	slli	a4,a0,5
	mv	a5,t1
	slli	a5,a5,2
	addi	a5,a5,15
	srli	a5,a5,4
	slli	a5,a5,4
	sub	sp,sp,a5
	mv	a5,sp
	addi	a5,a5,3
	srli	a5,a5,2
	slli	a5,a5,2
	sw	a5,-32(s0)
	sw	zero,-20(s0)
	j	.L6
.L7:
	lw	a4,-32(s0)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,-20(s0)
	sw	a4,0(a5)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L6:
	lw	a4,-20(s0)
	lw	a5,-24(s0)
	blt	a4,a5,.L7
	lw	a1,-24(s0)
	lw	a0,-32(s0)
	call	sum
	mv	a5,a0
	mv	sp,s1
	mv	a0,a5
	addi	sp,s0,-32
	lw	ra,28(sp)
	lw	s0,24(sp)
	lw	s1,20(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (SiFive GCC 10.1.0-2020.08.2) 10.1.0"
