class wr_sequencer extends uvm_sequencer;

    `uvm_component_utils(wr_sequencer)

    extern function new(string name="wr_sequencer", uvm_component parent);
    extern function void build_phase(uvm_phase phase);


endclass


function wr_sequencer::new(string name="wr_sequencer", uvm_component parent);

    super.new(name, parent);

endfunction

function void wr_sequencer::build_phase(uvm_phase phase);

    super.build_phase(phase);

endfunction


