# Lab Session 3

This lab session continues to use the [Venus RISC-V simulator](https://kvakil.github.io/venus/).


### Making Decisions

Last week you used the `ecall` number 4 to print a string. However, this
abstracts already some functionality in a form of operating system.
Assume that you have just a device where you can print out single characters
(such as a serial device). Use you last Hello World example and print
your individual character with `ecall` number 11 (see
[env. calls](https://github.com/kvakil/venus/wiki/Environmental-Calls)).

For this exercise you need branches to form a loop and to loop through
the characters and make a decision when to exit the loop (at the end of
the string). How do you know about the end of the string?
Hint: lookup what `.asciiz` means in the [Venus documentation](https://github.com/kvakil/venus/wiki)

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
The instruction `lw x1, aa` is not a native RISC-V instruction.
It is an assembler pseudo instruction that makes assembler programmers
live easier. Find out what the `auipc` instruction does.

### Calling Functions

Now that you implemented an addition you find this is a very great thing
and want to wrap it into a function. Implement a leave function that performs
addition and call it from your main program with the parameters in the
correct argument register. Take care that you use the right registers
according to the calling conventions of RISC-V. If you use saved registers
save them on the stack.

Note that the syntax of the `jalr` instruction for returning from a function
in Venus is a little bit different: `jalr x0, x1, 0`


### A Non-Leave Function

Non-leave functions need to perform a little bit more work on function entry
and return.
You will explore a non-leave function by implementing the factorial function
as a recursive function in RISC-V assembly.

See the following code for factorial in C:


```C
int fact (int n)
{ 
  if (n < 1) return 1;
  else return n * fact(n - 1);
}
```

Use following template [fact.s](fact.s) as a starting point and substitute
the instruction `li a0, 15 # dummy return value` by your implementation of
factorial.

```asm
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
```
