#
# Print Hello World
#

.text
la a1, hello
li a7, 4
ecall
.data
hello:
.asciz "Hello World"
