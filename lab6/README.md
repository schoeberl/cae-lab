# Lab Session 6

During this lab session you will install and explore the official RISC-V tools. You will also be exploring [Ripes](https://github.com/mortbopet/ripes), a graphical RISC-V simulator.

## RISC-V C Compiler and Spike

In this lab you will explore the full RISC-V toolchain, including a port of `gcc` and the `spike` simulator.

If you are using Ubuntu (or any other Linux version) or a Mac OS X laptop, you can install the tools
natively on your machine. However, to simplify life we provide a virtual machine (VM) with Ubuntu
and all needed tools installed. You need about 18 GB of free disk space for the VM and another
temporary space of 7 GB for the .zip file

 * An Ubuntu VM with RISC-V tools installed
   * [caelab.zip](https://patmos-download.compute.dtu.dk/caelab.zip)
   * user: cae-lab pwd: cae-lab
 * Use the free [VMWare Workstation Player](https://www.vmware.com/products/workstation-player.html)
 * Before launching the VM for the first time, ensure that enough RAM has been allocated to it. At least 2GB should be allocated, preferably +4GB.

 If you wish to install the RISC-V toolchain on your own computer, you can either download the [official toolchain](https://github.com/riscv-collab/riscv-gnu-toolchain) or the [SiFive version](https://github.com/sifive/freedom-tools). See the respective GitHub repositories for installation instructions. If you are not used to working in the command line, we recommend using the provided VM.

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

## Test the Compiler

Test the VM by opening a terminal and starting the compiler with:
```
riscv32-unknown-elf-gcc
```

You should get an error, similar to following
```
riscv32-unknown-elf-gcc: fatal error: no input files
compilation terminated.
```
which is good as you know the the compiler is installed.
You are now prepared for all RISC-V based lab work and projects.


Write, compile, and run the _Hello World_ program on RISC-V `spike`, the official RISC-V simulator, as follows:
```
echo -e '#include <stdio.h>\n int main(void) { printf("Hello world!\\n"); return 0; }' > hello.c
riscv32-unknown-elf-gcc -o hello hello.c
spike pk hello
```

## Exploring Compiled C Code

We will now explore very small C functions, such as

```C
int foo(int a, int b) {
  return a + b;
}
```
Copy the above into a new file, and save it as `foo.c`. Then compile it with the RISC-V compiler using the below command.
```bash
riscv32-unknown-elf-gcc -S foo.c -o foo.s
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
riscv32-unknown-elf-gcc -o main.out main.c
```
This creates the executable file `main.out`. You can run it on the spike simulator
with `spike pk main.out`.

Notice that running this program does not generate any output, as we didn't print the value of `a+b`. You can get the return value from a program by running
```bash
echo $?
```
on the terminal.

Remember that you can always compile a program into an assembly file with the `-S` option.
Another option to explore a compiled program is with an object dump:
```bash
riscv32-unknown-elf-objdump -d a.out
```
This will give you a long output as a lot of library code is linked
into the final program. To make it easier to navigate the output, you can use the operator `>` to redirect the output into a file.
```bash
riscv32-unknown-elf-objdump -d a.out > dump.txt
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

### Using Ripes to run C-code
Ripes also supports compiling C-code into RISC-V assembly and simulating the programs directly in Ripes. Go back to the Editor tab, set the Input type to C-code, paste in the following program
```C
#include <stdio.h>
int main() {
  printf("Hello, world");
  return 0;
}
```

and compile it by pressing the hammer icon or pressing `ctrl+B`. Look at the generated assembly - that's a lot of instructions to print a single line of text!

If you are unable to paste in or compile the program, open the Settings menu (`Edit -> Settings`) and select the Compiler tab. Ensure that the following options are used:
* Compiler path: `/home/caelab/riscv/bin/riscv32-unknown-elf-gcc`
* Compiler arguments: `-O0`
* Linker arguments: `-static-libgcc -lm`

Running the above program will take a long time on Ripes. We can speed up execution by using environment calls instead. Paste in the following program instead
```C
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

Notice that we can include assembly instructions directly in our C code. Compiling this code, you will see that the generated program is smaller. Running this on the simulator, the output "Hello, world" should be printed in the console after a couple of seconds.

To run a "bare-metal" version of the above program, you can update the Compiler arguments to include `-nostdlib`. This will strip out all C standard-library related calls, further reducing program size.

Take your `factorial` program from Lab 3, and adapt it to print the result of the `factorial` subroutine every time it is finished. Remember to use the correct environment calls to run it on Ripes. 

## Using the Assembler

For the final project (your RISC-V instruction set simulator) it will be convenient to
use an assembler (or even some C code) to write your test cases.

As an example compile your function `foo.s` to an object file with
```bash
riscv32-unknown-elf-gcc -c foo.s -o foo.o
```
You can explore this object file (`foo.o`) with `objdump` to get
the instructions in hexadecimal display.
```
riscv32-unknown-elf-objdump -d foo.o
```

However, what you really interested in is the `.text` segment part
of the ELF file. With `objcopy` you can extract that part.
```bash
riscv32-unknown-elf-objcopy foo.o --dump-section .text=output.bin
```
which generates a file `output.bin` containing the RISC-V instructions
in plain binary. You can display a binary file with `hexdump -C output.bin`
or `xxd output.bin`.
Do you recognize the instructions shown in the hexdump?
