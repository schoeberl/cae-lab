.data
n: .word 3

.text
main:
la t0, n
lw a0, 0(t0)
jal ra, factorial
    
addi a1, a0, 0
addi a0, x0, 1
ecall # print pesult
    
addi a0, x0, 10
ecall # exit

factorial:
# put your solution here
li a0, 15 # dummy return value
jalr x0,0(x1) # return
