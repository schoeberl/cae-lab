	.text
	li t0, 0x12345678
	li t1, 0xABCDEFAB
	xor a1, t0, t1
	or a2, t0, t1
	and a3, t0, t1
	xori a4, t0, 1313
	ori a5, t0, 1313
	andi a6, t0, 1313
	li a7, 10
	ecall
