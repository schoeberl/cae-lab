# Lab Session 6

During this lab session you will install and explore the official RISC-V tools. You will also be exploring [Ripes](https://github.com/mortbopet/ripes), a graphical RISC-V simulator.

## RISC-V C Compiler and Ripes

In this lab you will explore the full RISC-V toolchain, including a port of `gcc`,
and the RISC-V simulator Ripes.

Follow the instructions for installing the tools [here](../)

## Basic Linux/Unix Skills

If you have never used Linux/Unix and a command line it is now a good time
to start to learn how to drive a computer from the terminal/command line.

First you have to open a terminal, which gives you a shell to work with.

Here some of the basic commands at the command line:

`ls`, `cd`, `cp`, `mv`, `mkdir`

Find out what those commands do (Google is your friend).

You also need an editor, `gedit` is one of the easier ones to use.

For further Unix/Linux learning you can use following free book:
[Ten Steps to Linux Survival](http://www.oreilly.com/programming/free/files/ten-steps-to-linux-survival.pdf)

## Exploring Compiled C Code

We will now explore very small C functions, such as

```C
int foo(int a, int b) {
  return a + b;
}
```
Copy the above into a new file, and save it as `foo.c`. Then compile it with the RISC-V compiler using the below command.
```bash
riscv64-linux-gnu-gcc -march=rv32i -mabi=ilp32 -S foo.c -o foo.s
```
This generates a file named `foo.s` containing the corresponding assembly for your C program. Explore the assembler output in `foo.s`.

Are you surprised about the many instructions generated?
Without specifying an *optimization level* a compiler does a direct translation of your code including calling conventions and allocation of all variables in stack slots.

Try to optimize it by passing the option `-O2` and seeing the difference when the compiler is allowed to optimize your code.

## Compiling to an executable

To compile to an executable (an ELF file) the C program needs to contain
a `main` function. We will now explore the following simple program, saved into a file named `main.c`.

```C
int main() {

  int a = 1;
  int b = 2;

  return a+b;
}
```

Compile it with
```bash
riscv64-linux-gnu-gcc main.c -o main.out
```
This creates the executable file `main.out`.

Remember that you can always compile a program into an assembly file with the `-S` option.
Another option to explore a compiled program is with an object dump:
```bash
riscv64-linux-gnu-objdump -d main.out
```
This will give you a long output as a lot of library code is linked
into the final program. To make it easier to navigate the output, you can use the operator `>` to redirect the output into a file.
```bash
riscv64-linux-gnu-objdump -d main.out > dump.txt
```

Open this file with an editor (e.g., `gedit dump.txt`) and try to find the `main` function.

## Using Ripes
Ripes is a graphical RISC-V simulator, allowing you to see how values are passed between the submodules of the processor. When you open Ripes, you are presented with the "Processor" tab. Click the "chip" icon in the upper-left corner and ensure that the currently selected version of the processor is `RISC-V -> 32-bit -> Single cycle processor`.

Navigate to the "Editor" tab and input a simple RISC-V assembly program
```asm
li t0, 5
li t1, 7
li a7, x //You must decide the value of X
add a0, t0, t1
ecall
```
For the above program to run correctly, you must select the value to load into a7. Check [this page](https://github.com/mortbopet/Ripes/wiki/Environment-calls) for a list of the supported environment calls in Ripes. Note that these are not the same as in Venus!

Go back to the Processor tab and run the program, either by stepping through it `>`, or by running all instructions `>>`.
What is happening? Do you see the output in the console?

### Using Ripes to execute a program
Ripes also supports executing a program compiled with the RISC-V compiler, either from an ELF file
or as a flat binary. The latter format is what you will use for your final project.

Create a `hello.c` file containing the following code:
```C
asm("li sp, 0x100000"); // SP set to 1 MB
asm("jal main");        // call main
asm("li a7, 10");       // prepare ecall exit
asm("ecall");           // now your simulator should stop
void prints(volatile char* ptr);

void main() {
  char* str = "Hello world";
  prints(str);
}

void prints(volatile char* ptr){ // ptr is passed through register a0
  asm("li a7, x"); //You must decide the value of x
  asm("ecall");
}
```
Compile it by executing
```bash
riscv64-linux-gnu-gcc -nostartfiles -nostdlib -march=rv32i -mabi=ilp32 -T $HOME/linker.ld hello.c -o hello.out
```
and then extract the program by executing
```bash
riscv64-linux-gnu-objcopy -O binary hello.out hello.bin
```
Now load the program in Ripes as a `Flat binary`. Note, that there are a lot of unknown instructions
listed in the Editor window. These may be strings, constants and comments from the ELF file.
Run the program and notice how `Hello world` is printed in the console. Also notice how the program
never executes any of the strings, simply based on the execution flow.

Take your `factorial` program from Lab 3, and adapt it to print the result of the `factorial` subroutine every time it is finished. Remember to use the correct environment calls to run it on Ripes. 

## Using the Assembler

For the final project (your RISC-V instruction set simulator) it will be convenient to
use an assembler (or even some C code) to write your test cases.

As an example compile your function `foo.s` to an object file with
```bash
riscv64-linux-gnu-gcc -march=rv32i -mabi=ilp32 -c foo.s -o foo.o
```
You can explore this object file (`foo.o`) with `objdump` to get
the instructions in hexadecimal display.
```
riscv64-linux-gnu-objdump -d foo.o
```

However, what you really interested in is the `.text` segment part
of the ELF file. With `objcopy` you can extract that part.
```bash
riscv64-linux-gnu-objcopy -O binary foo.o output.bin
```
which generates a file `output.bin` containing the RISC-V instructions
in plain binary. You can display a binary file with `hexdump -C output.bin`
or `xxd output.bin`.
Do you recognize the instructions shown in the hexdump?
