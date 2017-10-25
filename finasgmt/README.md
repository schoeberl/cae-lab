# Final Assignment

For this final assignment you will implement a RISC-V simulator. You can write the simulator in the language of your choice, but we have to be able to run the simulator on a x64 machine running Ubuntu 16.04.3 LTS.   

## Simulator Architecture

The simulator has to read a binary file containing RISC-V instructions (what about registry and memory files?). The program counter (PC) should start at the first instruction and otherwise execute according to the instructions, i.e., increase the PC by 1 and in the case of branches, update the PC to the instruction specified location.

Depending on the complexity of the input program it might execute arithmetic instructions, as well as load and store results in memory. In addition to the PC, you will therefore have to track registers, and potential memory content, throughout program execution.

When you reach the end of the program, i.e., when the PC moves past the last instruction, you have to write out the content of all the registers. 

You are NOT required to simulate the pipeline stages. 

## Input and Output

The binary input file contains the program to be executed. Each instruction is 32 bits.

## Tasks

## Testing

## Deliverables

You will be working in groups of 3-4.

Code

report


