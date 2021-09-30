	.text
	li t0, 0xABCDEFAB
	li t1, 127
	sb t0, 0(t1)
	sh t0, 1(t1)
	sw t0, 3(t1)
	lb a1, 0(t1)
	lh a2, 1(t1)
	lw a3, 3(t1)
	lbu a4, 0(t1)
	lhu a5, 1(t1)
	lw a6, 0(t1)
	li a7, 10
	ecall
