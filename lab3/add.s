# Simple Integer Arithmetic
.data
aa: .word 5
bb: .word 7
.text
main:
lw x1, aa
lw x2, bb
add x3, x1, x2
