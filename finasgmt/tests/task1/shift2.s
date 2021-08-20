	.text
	li t0,1
	li a1,0xABCDEFAB
	sll a2,a1,t0
	srl a3,a1,t0
	sra a4,a1,t0
	slli a5,a1,3
	srli a6,a1,3
	srai a7,a1,3
	li a0,10
	ecall
