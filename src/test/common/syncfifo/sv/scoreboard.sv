class scoreboard;
  
  transaction trans = new();
  mailbox mbx = new();
  bit [15:0] fifo[$];
  bit [15:0] rd_data;
  bit        has_read = 0;
  bit        err_cnt = 0;
  
  function void pass;
    $display("=======================================");
    $display("            TEST PASSED                ");
    $display("=======================================");
  endfunction
    
  function void fail;
    $display("=======================================");
    $display("            TEST FAILED                ");
    $display("=======================================");
  endfunction
  
  function void result();
    if (err_cnt == 0) pass();
    else fail();
  endfunction
    
  task run();
    forever begin
      mbx.get(trans);
      if (trans.write) fifo.push_back(trans.wr_data);
      if (has_read) begin
        has_read = 0;
        rd_data = fifo.pop_front();
        if (rd_data != trans.rd_data) begin
          err_cnt++;
          $display("Scoreboard: Error: Expected read data %0d from FIFO, but get %0d", rd_data, trans.rd_data);
        end
        else $display("Scoreboard: Get expected read data %0d from FIFO", rd_data);
      end
      if (trans.read) has_read = 1;
    end
  endtask
  
endclass