# Lab Session 2

## Introduction to RISC-V ISA and the Venus Simulator

The lab session uses the [Venus RISC-V simulator](https://kvakil.github.io/venus/),
which can execute in a browser with JavaScript enabled.
We will explore basic machine instructions on the RISC-V instruction set.

After the lab you will have a good overview of the first RISC-V instructions (RV32I).
You will be able to simulate small to medium size programs on a RISC-V
instruction set simulator.

Note: For a simple start we point to the web-based Venus RISC-V simulator.
However, in later labs we will use [Ripes](https://github.com/mortbopet/ripes),
a graphical RISC-V simulator. Feel free to already use Ripes in the initial labs
in single cycle simulation mode, if you prefer.

When using Ripes, note that the environment call convention is different from Venus!
Check [this page](https://github.com/mortbopet/Ripes/wiki/Environment-calls) for a list of the supported environment calls in Ripes.

### A Minimal Assembler Program
#### (And How to Start Everything Off with Loading Constants)

Start by pasting following [minimal.s](minimal.s) assembler program into Venus,
in the Editor pane:
```asm
# As minimal RISC-V assembler example
addi x1, x0, 2
addi x2, x0, 3
add x3, x1, x2
```
Change to the Simulator and step through the code with the `Step` button.
Watch how the register `x1`, `x2`, and `x3` change. Adding immediate values
to register `x0`, which is always 0, is one way to load constants (immediate values)
into registers. Loading immediate values is so basic to get a program started
that RISC-V defines a pseudo instruction, `li`, as a shortcut.
Enter following code into the editor and switch to the simulation pane.  
```asm
# Use of pseudo instructions to load immediate values
li x1, 2
li x2, 3
add x3, x1, x2
```

You will notice that your code is listed under _Original Code_, but the
_real_ RISC-V instructions are listed under _Basic Code_.
Those instructions are the very same as you entered with [minimal.s](minimal.s).

RISC-V immediate values for ALU operations are 12-bit wide.
Try to use larger constants in your program (you can also use the 0xabcd
notion for hexadecimal values). What happens when the constant does
not fit into sign extended 12 bits?

Lookup the `lui` instruction in the [The RISC-V Instruction Set Manual](https://riscv.org/specifications/).

Why is immediate loading so fundamental?

### Step, Breakpoint, and Run

Extend you program with a handful of more instructions to
explore the functions of the Venus simulator.
You can clear the registers and the program counter by pressing _Reset_.
Step through your program with _Step_ or run you program to completion
with _Run_.

Another important concept is a breakpoint. You can set a breakpoint by
clicking into the instruction. A breakpoint is marked by coloring it red.
Another click into the instruction will clear the breakpoint.

With a breakpoint you can _Run_ he program until it reaches the breakpoint.
There you might explore some values in the registers.

### Computing with ALU Instructions

A computer can compute. "Of course!", you will say.
However, how do you compute on a RISC processor?

You compute with just a handful of instructions in the arithmetic logic unit (ALU).
Operations for ALU instructions are provided in registers and
the result is put into a register as well.

Locate all integer ALU instructions of RISC-V and explore them in the
simulator.

### Interlude: Talking to the World

Venus contains a simulation of low level operating system functions.
The functions in Venus have been inspired by the MIPS simulator MARS,
which itself has been inspired by SPIM.

System functions in RISC-V are invoked with the `ecall` instruction,
where `ecall` stands for _environment call_.
However, the concrete semantics of those functions is operating system
dependent.
Arguments to the system function are passed via the normal argument
register `a0` and `a1`, where `a0` contains the function code.
Explore [io.s](io.s) to print a integer value.
You can use this simple print function for `printf` debugging.

### Assembler Directives

Beside instructions in assembler format, an assembler also accepts
so-called _assembler directives_. The code start is usually marked
with `.text`. You can initialize data in the data segment with `.data`.
Each assembler instruction can start with a label such as
`main`: or `loop:`.
This label can then be used as destination for a branch instruction.
Also data can be addressed by using a label. See below some examples:

```asm
.text
main:
la a1, hello
loop: li, x3, 123
... more code
.data
hello:
.asciiz "Hello"
```

Add a `main:` label to the start of your program and add following
instruction at the end of your program:

```
j main
```

What happens when you step through your code? What happens when
you press _Run_?

### A RISC Machine is also Called a Load/Store Architecture

Operands for ALU instructions are always taken from registers and
the result is also put into registers in a RISC machine.
How can we then take operands from the memory or write results
into memory?

We need to use load and store instructions. That's why a RISC machine
is also called a load/store architecture.

Use a store instruction to store `0xdeadbeef` into the memory.
The simulator can display memory. Click on the _Memory_ field,
scroll down and _Jump to_ _Data_. The simulator choses to start
the data segment at `0x10000000`. Now write into that location
the `0xdeadbeef`.

How do you get that address into a register at first place?
Remember immediate values?

After storing that value into the main memory also read it back
into a register.

### We can Say Hello World to the World

As a final exercise we will say "Hello World".

A list of implemented `ecall` functions can be found in the
[env. calls](https://github.com/kvakil/venus/wiki/Environmental-Calls)
section in the
[Venus documentation](https://github.com/kvakil/venus/wiki).

You can print strings that are allocated in the static data segment.
Explore [hello.s](hello.s).

### Final Questions

To summarize the lab try to answer the following questions:

* Can the computer execute an assembly instruction? 
* How does the computer know that a bit pattern is an instruction?
* How many bytes are used to store one instruction? 
* How can the computer jump to a symbolic label, such as it
occurs in the instruction `j main`? 
* Which registers are affected by a jump instruction?
 
  





