import chisel3._
import chisel3.util._

/**
  * Author Martin Schoeberl (martin@jopdesign.com)
  *
  * A single-cycle implementation of RISC-V is practically an ISA simulator.
  */
class SingleCycleRiscV extends Module {
  val io = IO(new Bundle {
    val regDeb = Output(Vec(4, UInt(32.W))) // debug output for the tester
    val done = Output(Bool())
  })


  // TODO: the program should be read in from a file
  val program = Array[Int](
    0x00200093, // addi x1 x0 2
    0x00300113, // addi x2 x0 3
    0x002081b3) // add x3 x1 x2

  // A little bit of functional magic to convert the Scala Int Array to a Chisel Vec of UInt
  val imem = VecInit(program.map(_.U(32.W)))


  val pc = RegInit(0.U(32.W))

  // TODO: there should be an elegant way to express this
  val vec = Wire(Vec(4, UInt(32.W)))
  for (i <- 0 until 4) vec(i) := 0.U
  // We initialize the register file to 0 for a nicer display
  // In a real processor this is usually not done
  val reg = RegInit(vec)

  val instr = imem(pc(31, 2))

  val opcode = instr(6, 0)
  val rd = instr(11, 7)
  val rs1 = instr(19, 15)
  val imm = instr(31, 20) // TODO sign extend

  switch(opcode) {
    is(0x13.U) {
      reg(rd) := reg(rs1) + imm
    }
  }

  pc := pc + 4.U

  // done should be set when the program ends, and the tester shall stop
  io.done := true.B

  // Make the register file visible to the tester
  for (i <- 0 until 4) io.regDeb(i) := reg(i)
}


