import chisel3.iotesters._
import org.scalatest._


class SingleCycleRiscVTester(dut: SingleCycleRiscV) extends PeekPokeTester(dut) {

  step(2)
}

class RiscVSpec extends FlatSpec with Matchers {
  "RiscV" should "pass" in {
    chisel3.iotesters.Driver(() => new SingleCycleRiscV()) {
      c => new SingleCycleRiscVTester(c)
    } should be (true)
  }
}