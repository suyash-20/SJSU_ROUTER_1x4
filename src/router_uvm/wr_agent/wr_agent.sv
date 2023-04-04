class wr_agent extends uvm_agent;

    `uvm_component_utils(wr_agent)

    wr_driver wr_drv;
    wr_monitor wr_monh;
    wr_sequencer wr_seqr;

    //agent config object

    //scoreboard object

    extern function new(string name="wr_agent", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    

endclass



function wr_agent::new(string name="wr_agent", uvm_component parent);

    super.new(name, parent);
endfunction


function void wr_agent::build_phase(uvm_phase phase);

    super.build_phase(phase);

    //get the cfg object

    wr_monh = wr_monitor::type_id::create("monh", this);

    wr_drv = wr_driver::type_id::create("wr_drv", this);

    wr_seqr = wr_sequencer::type_id::create("wr_seqr", this);

endfunction


function void wr_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    wr_drv.seq_item_port.connect(wr_seqr.seq_item_export);

endfunction

    