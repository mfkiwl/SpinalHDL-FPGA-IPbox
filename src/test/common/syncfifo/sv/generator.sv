class generator;
    transaction trans;
    mailbox mbx;
    event complete;
    int count;
    int fifo_depth;
    int fifo_level;  // current fifo level

    function new(mailbox mbx, int fifo_depth);
        this.mbx = mbx;
        this.fifo_depth = fifo_depth;
        this.fifo_level = 0;
    endfunction

    task main();
        repeat(count) begin
            trans = new();
            trans.full = (fifo_level == fifo_depth);
            trans.empty = (fifo_level == 0);
            assert(trans.randomize()) else $display("generator::trans.randomize() failed");
            // post process, make sure not to write in FIFO full
            // and not to read in fifo empty
            trans.read = trans.read;
            trans.write = trans.write;
            mbx.put(trans);
            fifo_level = fifo_level - trans.read + trans.write;
            $display("generator: new transaction generated! read = %0b, write = %0b, w data = %0d", trans.read, trans.write, trans.wr_data);
        end
        -> complete;
    endtask

endclass
