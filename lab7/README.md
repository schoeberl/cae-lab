# Lab Session 7

During this lab session you will explore [Ripes](https://github.com/mortbopet/Ripes), 
a graphical 5-stage processor pipeline simulator.

Ripes is already installed in the Home directory on the Ubuntu VM. Start it by double clicking
the Ripes AppImage.

## Exploring Ripes 

## Compiling a Program

You can write c programs and compile them for Ripes. Note, that this procedure can also
be used when you want to compile programs for your own simulator.

Ripes starts from the first instruction in the file, and
your c program won't necessarily have `main` in the beginning.
To make sure that `main` runs first, add the following jump in the beginning of your c program,
which simulates startup code (usually called ```_start```):
```c
// This is our minimal startup code (usually in _startup)
asm("jal main");          // call main
asm("add x11, x10, x0");  // save return value in x11
asm("addi x10, x0, 10");  // prepare ecall exit
asm("ecall");             // now your simlator should stop
```

You can now compile your c program to an executable using
```bash
riscv32-unknown-elf-gcc -nostartfiles -march=rv32i -mabi=ilp32 -Wl,--script=$HOME/linker.ld foo.c -o foo.out
```
Extract the `.text` segment as before using
```bash
riscv32-unknown-elf-objcopy foo.out --dump-section .text=foo.bin
```

Try compiling the factorial example program `fact.c` and open `fact.bin` with Ripes. 
Set a breakpoint at the first instruction (the jump) and click run. The program executes
and the return in the main returns to the first instruction. The value returned in the
`main` is stored as a return value in register `a0`.
