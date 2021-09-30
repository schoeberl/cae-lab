.data
n: .word 3

.text
main:
la t0, n
lw a0, 0(t0)
jal ra, factorial
    
addi a7, x0, 1
ecall # print result
    
addi a7, x0, 10
ecall # exit

factorial:
# put your solution here
li a0, 15 # dummy return value
jalr x0, x1, 0 # return
