# SpinalHDL FPGA IPbox

Some useful FPGA IP written in SpinalHDL for SoC.

## Purpose

I am creating this repo to experiment and learn SpinalHDL and see how well it works compared to writing the traditional Verilog RTL code directly. The current plan is to rewrite all my IPs in my other repo `FPGA-IPbox` using SpinalHDL.

On the verification part, I wil choose systemverilog based testbenches. Since there is no good support on the the open source systemverilog simulator, I will mainly use EDA playground (<https://www.edaplayground.com/>) to run simulation.

## Getting Started

All the source code (HDL) are written in Scala. The Scala environment is based on sbt so the directory structure follow the sbt directory structure.

## IP Lists

These section Lists all the IPs that are written in the SpinalHDL in this repo. The list is not complete yet.

### Common File

This section includes some small components/building blocks for the larger IPs

- [ ] **FIFO / FWFT FIFO**
  - FIFO and First Word Fall Through FIFO
- [ ] **Async FIFO / FWFT Async FIFO**
  - Asynchronous FIFO and First Word Fall Through Asynchronous FIFO
- [ ] **Weighted Round Robin Arbiter**

### IPs To be completed

- [ ] **SRAM Controller**
  - [ ] **1RW Port**
  - [ ] **2RW Ports**
- [ ] **I2C**
- [ ] **I2S**
- [ ] **WM8731/WM8731L Audio Controller**
- [ ] **VGA**
- [ ] **PS2**
