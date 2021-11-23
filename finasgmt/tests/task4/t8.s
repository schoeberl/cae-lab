li t0, -123
li t1, -123
li t2, 122
beq t0, t1, b6
b1:
li a2, 2
blt t1, t2, b5
b2:
li a4, 4
bltu t2, t0, b4
b4:
li a5, 5
bgeu t1, t2, end
b5:
li a3, 3
bge t2, t0, b2
b6:
li a1, 1
bne t0, t2, b1
li a0, 0
li a1, 0
li a2, 0
li a3, 0
li a4, 0
li a5, 0
li a6, 0
li a7, 0
end:
li a7, 10
ecall