import chisel3.iotesters._
import org.scalatest._

class RiscVSpec extends FlatSpec with Matchers {
  "RiscV" should "pass" in {
    chisel3.iotesters.Driver.execute(Array("--generate-vcd-output", "on"), () => new SingleCycleRiscV()) { c =>
      new PeekPokeTester(c) {

        def printReg() = {
          for (i <- 0 until 4) {
            print(peek(dut.io.regDeb(i)).toString + " ")
          }
          println()
        }

        for (i <- 0 until 4) {
          printReg()
          step(1)
        }
      }
    }
  }
}