interface fifo_intf (input clk, input reset);

  logic              io_write;
  logic              io_read;
  logic     [15:0]   io_din;
  logic     [15:0]   io_dout;
  logic              io_full;
  logic              io_empty;

endinterface