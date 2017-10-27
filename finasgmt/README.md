# Final Assignment

For this final assignment you will implement a RISC-V simulator. You can write the simulator in the language of your choice, but we have to be able to run the simulator on a x64 machine running Ubuntu 16.04.3 LTS.   

## Simulator Architecture

TODO: Start with easy words and the 32-bit version

The simulator has to read a binary file containing RISC-V instructions. The program counter (PC) should start at the first instruction (address 0) and otherwise execute according to the instructions, i.e., increase the PC by 4 bytes (1 32-bit word) and in the case of branches, update the PC to the instruction specified location.

Depending on the complexity of the input program it might execute arithmetic instructions, as well as load and store results in memory. In addition to the PC, you will therefore have to track registers, and potential memory content, throughout program execution.

When you reach the end of the program, i.e., when the PC moves past the last instruction or exits the program with an exit `ecall 10` (see [Venus env. call](https://github.com/kvakil/venus/wiki/Environmental-Calls), you have to write out the content of all the registers. We will compare this output to the expected results, thereby verifying the correctness of your simulator.

For debugging it will also be a good idea to write out the register contents after each instruction.

You are *NOT* required to simulate the pipeline stages? 

### Input

The binary input files contain the programs to be executed. Each instruction is 32 bits, so you read and store them as Java (or similar) ints in your program. Bit shifting the integer and AND'ing with a bit mask will give you the required fields of the instruction, such as the opcode and the RD.

### Output

You should print out the register content at the program end. Additional for the final check you shall implement a binary dump of the register contents of registers x0-x31, in that order.

## Tasks

In this assignment you have x tasks to fulfill.

### Task 1

In this task you have to write the main simulator. Your simulator must support reading an input file containing a RISC-V program and write the output file after execution. It must also support executing the program instructions in order and support the base arithmetic instructions.

### Task 2

In this task you must extend your simulator by adding a PC and support reading instructions based on it. Furthermore, you must support all the base branching instructions, i.e., in case a branch should be taken your simulator must update the PC according to the instruction.

### Task 3

Function calls.


## Testing

We have provided test programs that you can execute with simulator and then compare your output with our provided output files. The test files are located under [/tests](./tests) in folders corresponding to the tasks. Tests under a specific task folder will only test functionality related to those tasks, e.g., tests under [./tests/task1](./tests/task1) will not make use of branching.

## Deliverables

For this assignment you will be working in groups of 1-2. You will not receive extra credits by doing all the work by yourself, so there is no benefit in working alone.

Similar to the other assignments, you have to hand in a report using the front page specified in assignment 1. The report should contain a description of your simulator, and also describe how you extended it for each task.

In addition to the report, you should hand in your simulator source code as well as a binary that can execute on Ubuntu x64. You only have to hand in one set of source code and binary, i.e., not one for each stage in the tasks. These additional deliverables should be uploaded as a single zip file.