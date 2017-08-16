# Lab Session 3

## Introduction to RISC-V ISA and the Venus Simulator

The lab session uses the [Venus RISC-V simulator](https://kvakil.github.io/venus/),
which can execute in a browser with JavaScript enabled.
We will explore basic machine instructions on the RISC-V instruction set.

After the lab you will have a good overview of _n_ out of _m_ RISC-V
instructions (RV32I).
You will be able to simulate small to medium size programs on a RISC-V
instruction set simulator.

### A Minimal Assembler Program
#### (And How to Start Everything Off with Loading Constants)

Start by pasting following [minimal.s](minimal.s) assembler program into Venus,
in the Editor pane:
```
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
```
# Use of pseudo instructions to load immediates
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

### Computing with ALU Instructions

A computer can compute. "Of course!", you will say.
However, how do you compute on a RISC processor?

You compute with just a handful of instructions in the arithmetic logic unit (ALU).
Operations for ALU instructions are provided in registers and
the result is put into a register as well.

TODO: provide an example for ALU instructions.
Do we need to cover all of them in the example?

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

### A RISC Machine is also Called a Load/Store Architecture


### We can Say Hello World to the World

A list of implemented ecall functions can be found in the
[env. calls](https://github.com/kvakil/venus/wiki/Environmental-Calls)
section in the
[Venus documentation](https://github.com/kvakil/venus/wiki).

You can print strings that are allocated in the static data segment.
Explore [hello.s](hello.s).

### Making Decisions

TODO: conditional branches

### A Larger Example

TODO: provide some code to read and execute.

### A Final Exercise

TODO: Find a small problem to be solved and provide a template to start with.

### More Instructions

TODO: other instructions, data access, assembler directives, branch,...
See ISA manual for all instructions (and COD).






