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
 * week 2: Exercises from Chapter 3
 * week 3: [Lab 3](lab3)

## Resources

### RISC-V Simple Simulator

For the first labs we will use the web based RISC-V simulator [Venus](https://kvakil.github.io/venus/).
Venus executes in your browser and there is no need to install any tools
on your laptop.

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

 * Use Ubuntu 16.04 desktop
 * Settings: lock to turn off screen locking
 * Settings: fix timezone as it is not correctly detected
 * We will use Rocket as a starting point <https://github.com/freechipsproject/rocket-chip>
 * Remove the lock file
 * Install Ubuntu packages according to riscv-tools and Chisel 3:

```
sudo apt-get install autoconf automake autotools-dev curl device-tree-compiler libmpc-dev libmpfr-dev libgmp-dev libusb-1.0-0-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev
```

```
sudo apt-get install default-jdk
```

```
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
sudo apt-get update
sudo apt-get install sbt
```

```
sudo apt-get install git make autoconf g++ flex bison
```

```
git clone http://git.veripool.org/git/verilator
cd verilator
git pull
git checkout verilator_3_886
unset VERILATOR_ROOT # For bash, unsetenv for csh
autoconf # Create ./configure script
./configure
make
sudo make install
```

Set RISCV and update your path by adding this into `.profile`
(including logout and login to update your environment variables):

```
# RISC-V tools
export RISCV=$HOME/rocket-chip/riscv-tools/local
export PATH=$PATH:$RISCV/bin
```

Checkout all code:

```
git clone https://github.com/ucb-bar/rocket-chip.git
cd rocket-chip
git submodule update --init
```

Build the RISC-V tools:
```
cd riscv-tools
git submodule update --init --recursive
./build.sh
./build-rv32ima.sh # if you are using RV32
```

After executing `./build-rv32ima.sh` spikes default is at rv32ima (was 64 bit before).
VM size increased to 19 GB from 16 GB before 32-bit support.

Danger!!! Be aware that 32 or 64-bit compilation need to be in sync with the spike simulation. 32-bit hello world is:

```
echo -e '#include <stdio.h>\n int main(void) { printf("Hello world!\\n"); return 0; }' > hello.c
riscv32-unknown-elf-gcc -o hello hello.c
spike pk hello
```

This is than the END of the tiny RISC-V tool intro.

Martin
