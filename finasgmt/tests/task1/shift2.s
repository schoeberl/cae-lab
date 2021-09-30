	.text
	li t0, 1
	li a0, 0xABCDEFAB
	sll a1, a0, t0
	srl a2, a0, t0
	sra a3, a0, t0
	slli a4, a0, 3
	srli a5, a0, 3
	srai a6, a0, 3
	li a7, 10
	ecall
