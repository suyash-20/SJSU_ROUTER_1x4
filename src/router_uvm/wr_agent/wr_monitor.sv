class wr_monitor extends uvm_monitor; //#(trans_xtn);

    `uvm_component_utils(wr_monitor)

    //virtual interfaceobject

    //scoreboard and agent config handles?

    extern function new(string name="wr_monitor", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    
    //extern task run_phase(uvm_phase phase);
    //extern task collect_data();

endclass


function wr_monitor::new(string name="wr_monitor", uvm_component parent);
    super.new(name, parent);
endfunction

function void wr_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);

endfunction

function void wr_monitor::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    //virtual interface connections

endfunction


// run phase and collect data task logic

