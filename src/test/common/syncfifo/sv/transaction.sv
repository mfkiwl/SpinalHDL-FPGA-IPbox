class transaction;
    rand bit            read, write;
    rand bit [15:0]     wr_data;
    bit                 full, empty;
    bit [15:0]          rd_data;
  
    constraint read_c { 
       empty -> read == 0;
    }
  
    constraint write_c {
       full -> write == 0;
    }

endclass