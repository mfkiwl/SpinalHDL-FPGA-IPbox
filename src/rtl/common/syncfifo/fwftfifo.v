// Generator : SpinalHDL v1.4.2    git head : 804c7bd7b7feaddcc1d25ecef6c208fd5f776f79
// Component : fwftfifo
// Git hash  : 0c6cc446875c79a4e98a7ce1badf18fc097464bf



module fwftfifo (
  input               write,
  input               read,
  input      [15:0]   din,
  output     [15:0]   dout,
  output              full,
  output              empty,
  input               clk,
  input               reset
);
  wire       [15:0]   fifo_1_io_dout;
  wire                fifo_1_io_full;
  wire                fifo_1_io_empty;
  reg                 prefetched;
  wire                read_int;

  fifo fifo_1 (
    .io_write    (write                 ), //i
    .io_read     (read_int              ), //i
    .io_din      (din[15:0]             ), //i
    .io_dout     (fifo_1_io_dout[15:0]  ), //o
    .io_full     (fifo_1_io_full        ), //o
    .io_empty    (fifo_1_io_empty       ), //o
    .clk         (clk                   ), //i
    .reset       (reset                 )  //i
  );
  assign read_int = (((! prefetched) && (! fifo_1_io_empty)) || (read && (! fifo_1_io_empty)));
  assign dout = fifo_1_io_dout;
  assign full = fifo_1_io_full;
  assign empty = (! prefetched);
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      prefetched <= 1'b0;
    end else begin
      prefetched <= (read_int || (prefetched && (! read)));
    end
  end


endmodule

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
