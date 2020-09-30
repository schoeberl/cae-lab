import chisel3._
import chisel3.util._

/**
  * Author Martin Schoeberl (martin@jopdesign.com)
  *
  * A single-cycle implementation of RISC-V is practically an ISA simulator.
  */
class SingleCycleRiscV extends Module {
  val io = IO(new Bundle{
    val regDeb = Output(Vec(4, UInt(32.W))) // debug output for the tester
    val done = Output(Bool())
  })

  val pc = RegInit(0.U(32.W))
  val reg = Reg(Vec(4, UInt(32.W)))

  // This program should be read in from a file
  val program = Array[Int](
  0x00200093, // addi x1 x0 2
  0x00300113, // addi x2 x0 3
  0x002081b3) // add x3 x1 x2


  // A little bit of functional magic to convert the Int Array for a Vec of UInt
  val imem = VecInit(program.map(_.U(32.W)))

  reg(0) := 0.U

  // print the register contents
  // Maybe this should
  def printReg(): Unit = {
    for (i <- 0 until 4) {
      printf("%d ", reg(i))
    }
    printf("\n")
  }

  val instr = imem(pc(31, 2))
  // printf starts in second clock cycle, first clock cycle is not shown
  // printf("instr: %x\n", instr)
  // printReg()

  val opcode = instr(6, 0)
  val rd = instr(11, 7)
  val rs1 = instr(19, 15)
  val imm = instr(31, 20) // TODO sign extend

  switch(opcode) {
    is (0x13.U) {
      reg(rd) := reg(rs1) + imm
    }
  }

  pc := pc + 4.U

  // done should be set when the program ends => the tester shall stop
  io.done := true.B

  for (i <- 0 until 4) {
    io.regDeb(i) := reg(i)
  }
}


