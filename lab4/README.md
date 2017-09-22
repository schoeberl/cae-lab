# Lab Session 4

This lab session continues to use the [Venus RISC-V simulator](https://kvakil.github.io/venus/).


### Making Decisions

Last week you used the `ecall` number 4 to print a string. However, this
abstracts already some functionality in a form of operating system.
Assume that you have just a device where you can print out single characters
(such as a serial device). Use you last Hello World example and print
your individual character with `ecall` number 11 (see
[env. calls](https://github.com/kvakil/venus/wiki/Environmental-Calls)).

For this exercise you need branches to form a loop and looping through
the characters and make a decision when to exit the loop (at the end of
the string).

### Simple Integer Arithmetic

You will now explore how the computer can perform integer arithmetic operations.
In the computer memory, both data and code are represented as numbers.
The CPU has no way of knowing which numbers are data and which are instructions.
It is just trying to execute whatever instruction the program courter (PC) is pointing at.
To solve this problem, data and code are stored separately in different memory areas called code segment and data segment.
If you want to save something as data, then you have to put the `.data` directive before that line in your assembly code.
If you want to save something as code, then you have to use the `.text directive.


Use following code [add.s](add.s):

```asm
.data
aa: .word 5
bb: .word 7
.text
main:
lw x1, aa
lw x2, bb
add x3, x1, x2
```

See how the code and the data are saved in the Text  and Data segment.
Run the example step by step. Observe what real instructions are executed.
The instruction `lw, x1, aa` is not a native RISC-V instruction.
It is an assembler pseudo instruction that makes assembler programmers
live easier.

### A Final Exercise

TODO: Find a small problem to be solved and provide a template to start with.

### More Instructions

TODO: other instructions, data access, assembler directives, branch,...
See ISA manual for all instructions (and COD).
