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
//  Main function for Fifo
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package common.syncfifo

import spinal.core._

// Run this main to generate the RTL

object fifoMain{
  def main(args: Array[String]) {
    // Create a new FIFO with depth 16 and width 16 for simulation
    SpinalConfig(
      targetDirectory = "src/rtl/common/syncfifo"
    ).generateVerilog(new fifo(16, 16))
  }
}