/**
 * RISC-V Instruction Set Simulator
 * <p>
 * A tiny first step to get the simulator started. Can execute just a single
 * RISC-V instruction.
 * 
 * To run this program: 
 *      mkdir build
 *      cd build
 *      cmake ..
 *      make
 *      ./isasim
 *
 * @author Martin Schoeberl (martin@jopdesign.com), Andrew Dobis (andrew.dobis@alumni.epfl.ch)
 */

#include <iostream>
#include <array>
#include <cstdint>

#define NO_ERR 0;

using namespace std;

int main(void) {

    uint32_t pc(0);
    array<uint32_t, 4> reg = array<uint32_t, 4>();

    // Here the first program hard coded as an array
    array<uint32_t, 3> progr = {
        // As minimal RISC-V assembler example
        0x00200093, // addi x1 x0 2
        0x00300113, // addi x2 x0 3
        0x002081b3, // add x3 x1 x2
    };

    cout << "Hello RISC-V World!" << endl;

    //Simulation loop
    while(1) {

        uint32_t instr = progr[pc >> 2];
        uint32_t opcode = instr & 0x7f;
        uint32_t rd = (instr >> 7) & 0x01f;
        uint32_t rs1 = (instr >> 15) & 0x01f;
        uint32_t imm = (instr >> 20);

        switch (opcode) {

            case 0x13:
                reg[rd] = reg[rs1] + imm;
                break;
            default:
                cout << "Opcode " << opcode << " not yet implemented" << endl;
                break;
        }

        pc += 4; // One instruction is four bytes

        if ((pc >> 2) >= progr.size()) {
            break;
        }

        for (size_t i(0); i < reg.size(); ++i) {
            cout << reg[i] << " ";
        }
        cout << endl;
    }

    cout << "Program exit" << endl;

    return NO_ERR;
}
