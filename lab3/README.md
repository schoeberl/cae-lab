# Lab Session 3

## Introduction to RISC-V ISA and Venus Simulator

The lab session uses the [Venus RISC-V simulator](https://kvakil.github.io/venus/).

Start by pasting following [minimal.s](minimal.s) assembler program into Venus.

Venus contains a simulation of low level operating system functions.
The functions in Venus have been inspired by the MIPS simulator MARS.
System functions in RISC-V are invoked with the `ecall` instruction,
where `ecall` stands for environment call.
However, the concrete semantics of those functions is operating system
dependent.
Arguments to the system function are passed via the normal argument
register `a0` and `a1`, where `a0` contains the function code.
Explore [io.s](io.s) to print a integer value.
You can use this simple print function for `printf` debugging.

A list of implemented ecall functions can be found in the
[env. calls](https://github.com/kvakil/venus/wiki/Environmental-Calls)
section in the
[Venus documentation](https://github.com/kvakil/venus/wiki).
