class monitor;
  
  transaction trans;
  mailbox mbx = new();
  virtual fifo_intf mif;
  
  function new(virtual fifo_intf mif);
    this.mif = mif;
  endfunction
  
  task run();
    forever begin
      @(posedge mif.clk)
      trans = new();
      trans.write = mif.io_write;
      trans.read = mif.io_read;
      trans.wr_data = mif.io_din;
      trans.rd_data = mif.io_dout; // the read data is actually one clock after the read op
      trans.full = mif.io_full;
      trans.empty = mif.io_empty;
      mbx.put(trans);
    end
  endtask
  
endclass