# SPDX-FileCopyrightText: © 2023 Uri Shaked <uri@tinytapeout.com>
# SPDX-License-Identifier: MIT

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_7seg(dut):
  dut._log.info("Start")
  
  # Our example module doesn't use clock and reset, but we show how to use them here anyway.
  clock = Clock(dut.clk, 10, units="us")
  cocotb.start_soon(clock.start())

  # Reset
  dut._log.info("Reset")
  dut.ena.value = 1
  dut.ui_in.value = 1
  dut.uio_in.value = 0
  dut.rst_n.value = 0
  await ClockCycles(dut.clk, 10)
  dut.rst_n.value = 1

  # the compare value is shifted 10 bits inside the design to allow slower counting
  max_count = dut.ui_in.value << 10
  dut._log.info(f"check all segments with MAX_COUNT set to {max_count}")
  # check all segments and roll over
  for i in range(15):
      dut._log.info("check segment {}".format(i))
      await ClockCycles(dut.clk, max_count)
      # assert int(dut.segments.value) == segments[i % 10]
  
      # all bidirectionals are set to output
      # assert dut.uio_oe == 0xFF

  # reset
  dut.rst_n.value = 0
  # set a different compare value
  dut.ui_in.value = 3
  await ClockCycles(dut.clk, 10)
  dut.rst_n.value = 1

  max_count = dut.ui_in.value << 10
  dut._log.info(f"check all segments with MAX_COUNT set to {max_count}")
  # check all segments and roll over
  for i in range(15):
      dut._log.info("check segment {}".format(i))
      await ClockCycles(dut.clk, max_count)
      # assert int(dut.segments.value) == segments[i % 10]

