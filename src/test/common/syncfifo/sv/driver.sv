class driver;
    mailbox mbx;
    virtual fifo_intf dif;
    transaction trans;
    int drv_cnt;

    function new(virtual fifo_intf dif, mailbox mbx);
        this.mbx = mbx;
        this.dif = dif;
        this.drv_cnt = 0;
    endfunction

    // set the initial value on reset
    task reset();
        wait(dif.reset);
        dif.io_write <= 'b0;
        dif.io_read <= 'b0;
        dif.io_din <= 'b0;
        dif.io_dout <= 'b0;
        dif.io_full <= 'b0;
        dif.io_empty <= 'b0;
        wait(!dif.reset);
        $display("Driver: reset complete!");
    endtask

    task main();
        forever begin
            trans = new();
            mbx.get(trans);
            @(posedge dif.clk);
            dif.io_write = trans.write;
            dif.io_read = trans.read;
            dif.io_din = trans.wr_data;
            trans.full = dif.io_full;
            trans.empty = dif.io_empty;
            if (trans.write) begin
                $display("Driver: push FIFO with data %0d", trans.wr_data);
            end
            drv_cnt++;
        end
    endtask

endclass