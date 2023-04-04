class rd_sequencer extends uvm_sequencer;

    `uvm_component_utils(rd_sequencer)

    extern function new(string name="rd_sequencer", uvm_component parent);
    extern function void build_phase(uvm_phase phase);


endclass


function rd_sequencer::new(string name="rd_sequencer", uvm_component parent);

    super.new(name, parent);

endfunction

function void rd_sequencer::build_phase(uvm_phase phase);

    super.build_phase(phase);

endfunction


