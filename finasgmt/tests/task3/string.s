	.data
data:
	.string "Is it me you're looking for?"
	.text
	la a0, data
	lb x1, 0(a0)
	addi a0, a0, 1
	lb x2, 0(a0)
	addi a0, a0, 1
	lb x3, 0(a0)
	addi a0, a0, 1
	lb x4, 0(a0)
	addi a0, a0, 1
	lb x5, 0(a0)
	addi a0, a0, 1
	lb x6, 0(a0)
	addi a0, a0, 1
	lb x7, 0(a0)
	addi a0, a0, 1
	lb x8, 0(a0)
	addi a0, a0, 1
	lb x9, 0(a0)
	addi a0, a0, 1
	lb x11, 0(a0)
	addi a0, a0, 1
	lb x12, 0(a0)
	addi a0, a0, 1
	lb x13, 0(a0)
	addi a0, a0, 1
	lb x14, 0(a0)
	addi a0, a0, 1
	lb x15, 0(a0)
	addi a0, a0, 1
	lb x16, 0(a0)
	addi a0, a0, 1
	lb x18, 0(a0)
	addi a0, a0, 1
	lb x19, 0(a0)
	addi a0, a0, 1
	lb x20, 0(a0)
	addi a0, a0, 1
	lb x21, 0(a0)
	addi a0, a0, 1
	lb x22, 0(a0)
	addi a0, a0, 1
	lb x23, 0(a0)
	addi a0, a0, 1
	lb x24, 0(a0)
	addi a0, a0, 1
	lb x25, 0(a0)
	addi a0, a0, 1
	lb x26, 0(a0)
	addi a0, a0, 1
	lb x27, 0(a0)
	addi a0, a0, 1
	lb x28, 0(a0)
	addi a0, a0, 1
	lb x29, 0(a0)
	addi a0, a0, 1
	lb x30, 0(a0)
	addi a0, a0, 1
	lb x31, 0(a0)
	li a7, 10
	ecall
