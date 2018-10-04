# Lab Session 6

During this lab session you will install and explore the official RISC-V
tools.

## RISC-V C Compiler and Spike

In this lab you will explore the full RISC-V toolchain, including a port of `gcc` and the `spike` simulator.

If you are using Ubuntu (or any other Linux version) or a Mac OS X laptop, you can install the tools
natively on your machine. However, to simplify life we provide a virtual machine (VM) with Ubuntu
and all needed tools installed. You need about 18 GB of free disk space for the VM and another
temporary space of 7 GB for the .zip file

 * An Ubuntu VM with RISC-V tools installed
   * [caelab.zip](http://patmos.compute.dtu.dk/caelab.zip)
   * user: cae-lab pwd: cae-lab
 * Use the free [VMWare Workstation Player](https://my.vmware.com/en/web/vmware/free#desktop_end_user_computing/vmware_workstation_player/12_0)

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

### Test the Compiler

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


Write, compile, and run the _Hello World_ program on RISC-V `spike` as follows:
```
echo -e '#include <stdio.h>\n int main(void) { printf("Hello world!\\n"); return 0; }' > hello.c
riscv32-unknown-elf-gcc -o hello hello.c
spike pk hello
```


## Exploring Compiled C Code

Write some small C functions, such as

```C
int foo(int a, int b) {
  return a + b;
}
```

and save it as `foo.c`. Compile it with the RISC-V compiler to assembler with
```bash
riscv32-unknown-elf-gcc -S foo.c -o foo.s
```

and explore the assembler output in `foo.s`.
Are you surprised about the many instructions generated?
Without specifying any optimization level a compiler does a direct
translation of your code including calling conventions and
allocation of all variables in stack slots.
Try to optimize it with option `-O2` and see the difference.

## Compiling to an executable

To compile to an executable (an ELF file) the C program needs to contain
a `main` function. Explore something like:

```C
int main() {

  int a = 1;
  int b = 2;

  return a+b;
}
```

and compile it with
```bash
riscv32-unknown-elf-gcc main.c
```
creates the executable `a.out`. You can run it on the spike simulator
with `spike pk a.out`. As this program does not print any results
you can get the return value with
```bash
echo $?
```

You can again compile this tiny program to an assembler file with
the `-S` option.

Another option to explore a compiled program is with an object dump:
```bash
riscv32-unknown-elf-objdump -d a.out
```
This will give you long output as a lot of library code is linked
into the final program. Redirect that output into a file with
```bash
riscv32-unknown-elf-objdump -d a.out > dump.txt
```

Open this file with an editor (e.g., `gedit dump.txt`) and try to
find the `main` function.

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
of the ELF file. With `objectcopy` you can extract that part.
```bash
riscv32-unknown-elf-objcopy foo.o --dump-section .text=output.bin
```
which generated an `output.bin` containing the RISC-V instructions
in plain binary. You can display a binary file with `hexdump -C output.bin`
or `xxd output.bin`.
