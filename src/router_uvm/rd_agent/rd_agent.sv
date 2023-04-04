class rd_agent extends uvm_agent;

    `uvm_component_utils(rd_agent)

    rd_driver rd_drv;
    rd_monitor rd_monh;
    rd_sequencer rd_seqr;

    //agent config object

    //scoreboard object

    extern function new(string name="rd_agent", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    

endclass



function rd_agent::new(string name="rd_agent", uvm_component parent);

    super.new(name, parent);
endfunction


function void rd_agent::build_phase(uvm_phase phase);

    super.build_phase(phase);

    //get the cfg object

    rd_monh = rd_monitor::type_id::create("rd_monh", this);

    rd_drv = rd_driver::type_id::create("rd_drv", this);

    rd_seqr = rd_sequencer::type_id::create("rd_seqr", this);

endfunction


function void rd_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    rd_drv.seq_item_port.connect(rd_seqr.seq_item_export);

endfunction

    