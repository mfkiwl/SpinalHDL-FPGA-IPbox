`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
    virtual fifo_intf eif;
    mailbox mbx;
    generator gen;
    driver drv;
  
    monitor m;
    scoreboard s;
    mailbox mbxms;

    function new(virtual fifo_intf eif, int fifo_depth);
        this.eif = eif;
        this.mbx = new();
        this.gen = new(mbx, fifo_depth);
        this.drv = new(eif, mbx);
        this.mbxms = new();
        this.m = new(eif);
        this.s = new();
        $display("Environment: Create a new env");
    endfunction

    task pretest();
        drv.reset();
        m.mbx = this.mbxms;
        s.mbx = this.mbxms;
    endtask

    task test();
        fork
            gen.main();
            drv.main();
            m.run();
            s.run();
        join_any
    endtask

    task posttest();
        wait(gen.complete.triggered);
        wait(drv.drv_cnt == gen.count);
        wait(s.mbx.num() == 0);
        s.result();
    endtask

    task run();
      	pretest();
        test();
        posttest();
    endtask

endclass
