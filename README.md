# Lab Material for CAE

This repository collects lab material for the 2017 Computer Architecture and Engineering course (02155) at DTU.

# Resources

## Links

 * [Venus RV32 simulator](https://kvakil.github.io/venus/)
 * [SPIM system calls](https://www.doc.ic.ac.uk/lab/secondyear/spim/node8.html)
 * [Bare metal program on spike](https://github.com/schoeberl/cae-examples)

### Some More Unchecked Links

 * [Eclipse plugin](https://gnu-mcu-eclipse.github.io/plugins/features/)
 * <https://stackoverflow.com/questions/31390127/how-can-i-compile-c-code-to-get-a-bare-metal-skeleton-of-a-minimal-risc-v-assemb>

## Tool Installation

Just random notes on my installation experiments (on top of Ubuntu/patmos VM)

 * Install additional Ubuntu packages (after rm lock file)
 * create risc-v
 * Follow <https://github.com/riscv/riscv-tools>
 * clone tools, cd, and install submodules
 * Another round of apt-get
 * Set RISCV and PATH
 * sudo apt-get install libusb-1.0-0-dev
 * ./build.sh

Changes: better use local for the installation folder.
Maybe use Rocket as more complete tool set.
