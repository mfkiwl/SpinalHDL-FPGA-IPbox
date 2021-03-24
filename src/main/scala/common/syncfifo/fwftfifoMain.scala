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
//  Main function for fwftfifo
//
///////////////////////////////////////////////////////////////////////////////////////////////////

package common.syncfifo

import spinal.core._

// Run this main to generate the RTL

object fwftfifoMain{
  def main(args: Array[String]) {
    SpinalConfig(
      targetDirectory = "src/rtl/common/syncfifo"
    ).generateVerilog(new fwftfifo(16, 16))
  }
}