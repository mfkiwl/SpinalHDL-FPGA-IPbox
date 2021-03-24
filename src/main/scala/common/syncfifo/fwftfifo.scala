///////////////////////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 by Heqing Huang (feipenghhq@gamil.com)
//
// ~~~ Hardware in SpinalHDL ~~~
//
// Module Name: fwftfifo
//
// Author: Heqing Huang
// Date Created: 03/17/2021
//
// ================== Description ==================
//
//  A First Word Fall Through (FWFT) FIFO.
//  Added the FWFT logic on top of the original FIFO
//
//  Feature:
//  - full/empty flag.
//  - Read latency is still 1.
//  - The current data on the top will be available at the output data port
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package common.syncfifo

import spinal.core._
import spinal.lib._
import common.syncfifo.fifo

case class fwftfifo(WIDTH: Int, DEPTH: Int) extends Component {
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

    noIoPrefix()

    val fifo        = new fifo(WIDTH, DEPTH)
    val prefetched  = Reg(Bool) init(False)
    val read_int    = Bool


    prefetched      := read_int | (prefetched & ~io.read)
    read_int        := (~prefetched & ~fifo.io.empty) | (io.read & ~fifo.io.empty)
    io.dout         := fifo.io.dout
    io.full         := fifo.io.full
    io.empty        := ~prefetched
    fifo.io.write   := io.write
    fifo.io.read    := read_int
    fifo.io.din     := io.din
}