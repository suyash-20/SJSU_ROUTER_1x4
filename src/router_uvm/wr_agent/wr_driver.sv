class wr_driver extends uvm_driver; //#(trans_xtn);

    `uvm_component_utils(wr_driver)

    // objects for virtualinterface

    extern function new(string name="wr_driver", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    
    //extern task drive();
    //extern task run_phase(uvm_phase phase);

    //agent config handles?

endclass


function wr_driver::new(string name="wr_driver", uvm_component parent);
    super.new(name, parent);

endfunction

function void wr_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);

endfunction


function void wr_driver::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    //virtual interface connections

endfunction

//run_phase and drive task logic
