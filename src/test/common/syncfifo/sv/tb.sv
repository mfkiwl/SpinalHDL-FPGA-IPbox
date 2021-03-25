`include "test.sv"
`include "fifo_intf.sv"

module tb;
    bit clk;
    bit reset;
    fifo_intf tbi(clk, reset);
    const int FIFO_DEPTH = 16;

    test(tbi, FIFO_DEPTH);

    fifo fifo_DUT(
        .io_write(tbi.io_write),
        .io_read(tbi.io_read),
        .io_din(tbi.io_din),
        .io_dout(tbi.io_dout),
        .io_full(tbi.io_full),
        .io_empty(tbi.io_empty),
        .clk(clk),
        .reset(reset)
    );

    always #5 clk = ~clk;

    initial begin
        reset = 1;
        #25 reset = 0;
    end

    initial begin
        $dumpfile("dump.vcd"); $dumpvars;
    end

endmodule