// Generator : SpinalHDL v1.4.2    git head : 804c7bd7b7feaddcc1d25ecef6c208fd5f776f79
// Component : fifo
// Git hash  : 0c6cc446875c79a4e98a7ce1badf18fc097464bf



module fifo (
  input               io_write,
  input               io_read,
  input      [15:0]   io_din,
  output     [15:0]   io_dout,
  output              io_full,
  output              io_empty,
  input               clk,
  input               reset
);
  reg        [15:0]   _zz_1;
  wire                fifo_ctrl_wen;
  wire                fifo_ctrl_ren;
  reg        [4:0]    fifo_ctrl_rdptr;
  reg        [4:0]    fifo_ctrl_wrptr;
  wire       [4:0]    fifo_ctrl_ptr_diff;
  wire       [3:0]    ram_ctrl_rd_addr;
  wire       [3:0]    ram_ctrl_wr_addr;
  reg [15:0] ram_ctrl_ram [0:15];

  always @ (posedge clk) begin
    if(fifo_ctrl_wen) begin
      ram_ctrl_ram[ram_ctrl_wr_addr] <= io_din;
    end
  end

  always @ (posedge clk) begin
    if(fifo_ctrl_ren) begin
      _zz_1 <= ram_ctrl_ram[ram_ctrl_rd_addr];
    end
  end

  assign fifo_ctrl_wen = ((! io_full) && io_write);
  assign fifo_ctrl_ren = ((! io_empty) && io_read);
  assign fifo_ctrl_ptr_diff = (fifo_ctrl_wrptr - fifo_ctrl_rdptr);
  assign io_full = (fifo_ctrl_ptr_diff == 5'h10);
  assign io_empty = (fifo_ctrl_ptr_diff == 5'h0);
  assign ram_ctrl_rd_addr = fifo_ctrl_rdptr[3 : 0];
  assign ram_ctrl_wr_addr = fifo_ctrl_wrptr[3 : 0];
  assign io_dout = _zz_1;
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      fifo_ctrl_rdptr <= 5'h0;
      fifo_ctrl_wrptr <= 5'h0;
    end else begin
      if(fifo_ctrl_ren)begin
        fifo_ctrl_rdptr <= (fifo_ctrl_rdptr + 5'h01);
      end
      if(fifo_ctrl_wen)begin
        fifo_ctrl_wrptr <= (fifo_ctrl_wrptr + 5'h01);
      end
    end
  end


endmodule
