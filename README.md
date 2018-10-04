# Lab Material for Computer Architecture

This repository provides lab material for the 2017
[Computer Architecture and Engineering course (02155)](http://www2.imm.dtu.dk/courses/02155/) at DTU.
Although this lab is customized for the DTU course, it can also serve as
introduction lab for computer architecture in general and the RISC-V
instruction set specifically.

The lab is based on COD: [Computer Organization and Design RISC-V Edition](https://www.amazon.com/Computer-Organization-Design-RISC-V-Architecture/dp/0128122757):
The Hardware Software Interface, 1st Edition,
by David A. Patterson (Author), John L. Hennessy (Author).

To use this material you can: (1) just browse it online on GitHub,
(2) clone the repo to have all material offline (using it also
for your solutions),
or (3) fork the repo (and clone locally), to be able to contribute back with changes.

**Contributions:** We are happily accepting contributions in the form of
pull requests. Even the fix of a small typo is appreciated.

## Lab Overview

The following list gives an overview of all lab sessions and assignments.
For lab sessions where no link is given, we will provide the material in CampusNet.

 * week 1: Number representation and performance
 * week 2: [Lab 2](lab2)
 * week 3: [Lab 3](lab3)
 * week 4: Exercises from Chapter 3
 * week 5: work on first assignment
 * week 6: [Lab 6](lab6)
 * week 7: [Lab 7](lab7)

## Resources

### RISC-V Simple Simulator

For the first labs we will use the web based RISC-V simulator [Venus](https://kvakil.github.io/venus/).
Venus executes in your browser and there is no need to install any tools
on your laptop. You can also save that web page to have a local copy of
the simulator to work when offline.

### RISC-V C Compiler and Spike

However, for later lab exercises and your final project we need the full RISC-V toolchain, including a port of gcc and the `spike` simulator.

If you are using Ubuntu (or any other Linux version) or a Mac OS X laptop, you can install the tools
natively on your machine. However, to simplify life we provide a virtual machine (VM) with Ubuntu
and all needed tools installed. You need about 18 GB of free disk space for the VM and another
temporary space of 7 GB for the .zip file

 * An Ubuntu VM with RISC-V tools installed
   * [cae-lab.zip](http://patmos.compute.dtu.dk/cae-lab.zip)
   * user: cae-lab pwd: cae-lab
 * Use the free [VMWare Workstation Player](https://my.vmware.com/en/web/vmware/free#desktop_end_user_computing/vmware_workstation_player/12_0)

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


For the more curious, you can sneak ahead and compile and run 
_Hello World_ program on RISC-V `spike` as follows:
```
echo -e '#include <stdio.h>\n int main(void) { printf("Hello world!\\n"); return 0; }' > hello.c
riscv32-unknown-elf-gcc -o hello hello.c
spike pk hello
```

## Links

 * [The RISC-V Instruction Set Manual](https://riscv.org/specifications/)
 * [Venus RV32I simulator](https://kvakil.github.io/venus/)
 * [RISC-V Green Card](https://www.cl.cam.ac.uk/teaching/1617/ECAD+Arch/files/docs/RISCVGreenCardv8-20151013.pdf)
 * [RISC-V Tools (GNU Toolchain, ISA Simulator, Tests)](https://github.com/riscv/riscv-tools)
 * [Rocket Chip Generator (including the RISC- tools)](https://github.com/freechipsproject/rocket-chip)
 * [Wildcat RV32I simulator](https://github.com/schoeberl/wildcat)
 * [SPIM system calls](https://www.doc.ic.ac.uk/lab/secondyear/spim/node8.html)
 * [Bare metal program on spike](https://github.com/schoeberl/cae-examples)

### Other University Courses using RISC-V

 * [UC Berkeley: CS61C: Great Ideas in Computer Architecture (Machine Structures)](http://inst.eecs.berkeley.edu/~cs61c/fa17/)
 * [MIT: 6.175: Constructive Computer Architecture](http://csg.csail.mit.edu/6.175/index.html)
 * [Cornell: ECE 4750: Computer Architecture](http://www.csl.cornell.edu/courses/ece4750/2016f/)

### Some More (Unchecked) Links

 * [Eclipse plugin](https://gnu-mcu-eclipse.github.io/plugins/features/)
 * <https://stackoverflow.com/questions/31390127/how-can-i-compile-c-code-to-get-a-bare-metal-skeleton-of-a-minimal-risc-v-assemb>
 * [Assembler appendix from H&P](http://pages.cs.wisc.edu/~larus/HP_AppA.pdf)
 * [MARS docu](http://courses.missouristate.edu/KenVollmar/mars/CCSC-CP%20material/MARS%20Tutorial.doc)
 * [CS61C summer lab 3](http://www-inst.eecs.berkeley.edu/~cs61c/su17/labs/03/)

## VM and Tool Installation

This is a log how I prepared the Ubuntu VM for the CAE lab. It might be useful for your own installation of the RISC-V tools.

_Please note that this is a log on how I prepared the Ubuntu VM for the CAE lab.
This instructions might be out of date soon. Please refer to the original README
documents of the RISC-V tools._

 * Use VMware Workstation 15 Player
 * Use Ubuntu 18.04 desktop
 * Do not use VMware easy install
 * Do not use LVM
 * Settings: turn off screen locking
 
Install VM tools for clipboard support adn restart VM
```bash
sudo apt install open-vm-tools
```

Install git
```bash
sudo apt install git
```

Follow the instructions for installing the RISC-V tools [here](https://github.com/riscv/riscv-tools),
except do not execute 
```bash
./build.sh
```
Instead, change all references in `build-rv32ima.sh` from `rv32ima` to `rv32i`.
Set the RISCV variable and path by adding this into `.profile`
(including logout and login to update your environment variables):
```
# RISC-V tools
export RISCV=$HOME/riscv
export PATH=$PATH:$RISCV/bin
```
Then run
```bash
./build-rv32ima.sh
```

Create a file `linker.ld` in the $HOME directory containing the following:
```
SECTIONS {
.text :{*(*)}
}
```

Download the RISCV pipeline simulator Ripes from [here](https://github.com/mortbopet/Ripes/releases).
No installation is required, however, enable the file's execute bit to make it executable.

This is the END of the tiny RISC-V tool intro.

Martin
