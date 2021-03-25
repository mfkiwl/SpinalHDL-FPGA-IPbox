`include "environment.sv"

program test(fifo_intf tif, input int fifo_depth);

    environment env;

    initial begin
        env = new(tif, fifo_depth);
        env.gen.count = 16;
        env.run();
    end

endprogram
