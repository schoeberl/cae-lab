# Lab Session 7

During this lab session you will explore [Ripes](https://github.com/mortbopet/Ripes), 
a graphical 5-stage processor pipeline simulator.

Ripes is already installed in the Home directory on the Ubuntu VM. However, you might want to
download the latest version from [here](https://github.com/mortbopet/Ripes/releases).
Start Ripes by double clicking the AppImage file.

## Exploring Ripes 

Throughout the exercises you can see the values of the wires by marking the 'Display all signal values'
checkbox. The colors identify the bit value of an input or, in the case of the Muxes, the selected input.

### Double Data Hazard

Paste the following code into the `Editor` window of Ripes:
```asm
li x1, 1
li x2, 2
li x3, 3
li x4, 4
nop
nop
nop
nop
nop
add x1,x1,x2
add x1,x1,x3
add x1,x1,x4
```
Go to the `Processor` window and step until there are `nop`s in all pipeline stages.
Now step whilst paying attention to the state in each stage. Notice how the destination 
register after the EX stage is forwarded to the EX stage.

### Load-Use Hazard

Paste the following code into the `Editor` window of Ripes:
```asm
.data
nr:
	.word 16
.text
	la x1, nr
	lw x2, 20(x1)
	and x4, x2, x5
	or x8, x2, x6
	add x9, x4, x2
```
While stepping through the program, notice how the `and` right after the `lw` needs the loaded
value, so the processor inserts a `nop` in between. When the `lw` reaches the WB stage,
the value is written to the register file, but is also forwarded to the `and` in the EX
stage.

### Branch Hazards

Paste the following code into the `Editor` window of Ripes:
```asm
.data
nr:
	.word 16
.text
  la x7, nr
	li x1, 1
	li x3, 1
	nop
	nop
	nop
	nop
	nop
	sub  x10, x4, x8
	beq  x1,  x3, jmp
	and  x12, x2, x5
	or   x13, x2, x6
	add  x14, x4, x2
	sub  x15, x6, x7
	nop
	nop
	nop
jmp:
	lw   x4, 0(x7)
```
Step until the pipeline is filled with `nop`s. Then step while noticing the behaviour of
`beq` as the branch is taken. During the ID stage the new PC is correctly calculated.
However, since the PC register takes a cycle to be updated, the `and` instruction after
the `beq` is fetched. In the next cycle, the PC contains the right address so the the `lw` 
instruction is fetched. A `nop` is inserted into the ID stage to prevent the `and` from
polluting the pipeline.

Try to write your own sequence of instructions where you mix the different hazards.

## Compiling a Program

You can write c programs and compile them for Ripes. Note, that this procedure can also
be used when you want to compile programs for your own simulator.

Ripes starts from the first instruction in the file, and
your c program won't necessarily have `main` in the beginning.
To make sure that `main` runs first, add the following code to the beginning of your c program,
which simulates startup code (usually called ```_start```):
```c
// This is our minimal startup code (usually in _start)
asm("li sp, 0x100000"); // SP set to 1 MB
asm("jal main");        // call main
asm("mv a1, a0");       // save return value in a1
asm("li a0, 10");       // prepare ecall exit
asm("ecall");           // now your simulator should stop
```

You can now compile your c program to an executable using following linker
script ```linker.ld``` (already placed in your home folder in the VM):
```
SECTIONS {
.text :{*(*)}
}
```

Compile with following options:

```bash
riscv32-unknown-elf-gcc -nostartfiles -march=rv32i -mabi=ilp32 -Wl,--script=$HOME/linker.ld foo.c -o foo.out
```
Extract the `.text` segment as before using
```bash
riscv32-unknown-elf-objcopy foo.out --dump-section .text=foo.bin
```

Try writing your own simple c program where you add some numbers and return the
result. sSee how it executes in Ripes. Can you see your result? 
Try expanding the program by moving the calculations to
a separate function which is called by the `main`.
