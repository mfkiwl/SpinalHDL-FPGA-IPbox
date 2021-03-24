///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: Fifo
//
// Author: Heqing Huang
// Date Created: 03/17/2021
//
// ================== Description ==================
//
//  A Basic FIFO. Feature:
//  - full/empty flag.
//  - Read latency is 1
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package common.syncfifo

import spinal.core._
import spinal.lib._

case class fifo(WIDTH: Int, DEPTH: Int) extends Component {
    require(isPow2(DEPTH))
    val AWIDTH = log2Up(DEPTH)

    val io = new Bundle {
        val write = in Bool
        val read  = in Bool
        val din   = in Bits(WIDTH bits)
        val dout  = out Bits(WIDTH bits)
        val full  = out Bool
        val empty = out Bool
    }

    val fifo_ctrl = new Area {
        val wen = ~io.full & io.write
        val ren = ~io.empty & io.read
        val rdptr = Reg(UInt(AWIDTH+1 bits)) init(0)
        val wrptr = Reg(UInt(AWIDTH+1 bits)) init(0)
        when(ren) {rdptr := rdptr + 1}
        when(wen) {wrptr := wrptr + 1}
        val ptr_diff = wrptr - rdptr
        io.full  := ptr_diff === DEPTH
        io.empty := ptr_diff === 0
    }

    val ram_ctrl = new Area {
        val rd_addr = fifo_ctrl.rdptr(AWIDTH -1 downto 0)
        val wr_addr = fifo_ctrl.wrptr(AWIDTH -1 downto 0)
        val ram = Mem(Bits(WIDTH bits), wordCount = DEPTH)
        ram.write (
            address = wr_addr,
            data    = io.din,
            enable  = fifo_ctrl.wen
        )
        io.dout := ram.readSync (
            address = rd_addr,
            enable  = fifo_ctrl.ren
        )
    }
}