# Final Assignment

For this final assignment you will implement a RISC-V simulator. You can write the simulator in the language of your choice, but we have to be able to run the simulator on a x64 machine running Ubuntu 16.04.3 LTS.   

## Simulator Architecture

The simulator has to read a binary file containing RISC-V instructions (what about registry and memory files?). The program counter (PC) should start at the first instruction and otherwise execute according to the instructions, i.e., increase the PC by 1 and in the case of branches, update the PC to the instruction specified location.

Depending on the complexity of the input program it might execute arithmetic instructions, as well as load and store results in memory. In addition to the PC, you will therefore have to track registers, and potential memory content, throughout program execution.

When you reach the end of the program, i.e., when the PC moves past the last instruction, you have to write out the content of all the registers. We will compare this output to the expected results, thereby verifying the correctness of your simulator. 

You are NOT required to simulate the pipeline stages? 

### Input

The binary input files contain the programs to be executed. Each instruction is 32 bits, so you read and store them as Java (or similar) ints in your program. Bit shifting the integer and AND'ing with a bit mask will give you the required fields of the instruction, such as the opcode and the RD.

### Output

The output files must be binary and contain the content of registers x0-x31, in that order. Remember that registers in RISC-V are 64 bits, which means they can be stored and written from your program as Java (or similar) longs.

## Tasks

In this assingment you have x tasks to fulfill

### Task 1

In this task you have to write the main simulator. Your simulator must support reading an input file containing a RISC-V program and write the output file after execution. It must also support executing the progrtam instructions in order and support the base arithmetic instructions.

### Task 2

In this task you must extend your simulator by adding a PC and support reading instructions based on it. Furthermore, you must support all the base branching instructions, i.e., in case a branch should be taken your simulator must update the PC according to the instruction.

### Task 3

Multiplication?

### Task 4

Pipelined?

## Testing

## Deliverables

You will be working in groups of 3-4.

Source code.

Binary?

Report.


