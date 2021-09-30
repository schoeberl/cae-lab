#
# Use ecall to print out a number
#  = poor man's debugger
#

.text
addi a7, zero, 1  # function for integer print
addi a0, zero, 42 # the integer value to print
ecall             # call the environment for printing

