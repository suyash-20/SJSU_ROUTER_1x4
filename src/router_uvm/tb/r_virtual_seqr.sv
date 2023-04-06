class r_virtual_seqr extends uvm_sequencer #(uvm_sequence_item);

    `uvm_component_utils(r_virtual_seqr)

    wr_sequencer wr_seqr;
    rd_sequencer rd_seqr[];

    r_env_config m_cfg;


    extern function new(string name="r_virtual_seqr", uvm_component parent);
    extern function void build_phase(uvm_phase phase);

endclass


function r_virtual_seqr::new(string name="r_virtual_seqr", uvm_component parent);
    super.new(name, parent);

endfunction

function void r_virtual_seqr::build_phase(uvm_phase phase);

    super.build_phase(phase);

    if(!uvm_config_db#(r_env_config)::get(this, "", "r_env_config", m_cfg))
        `uvm_fatal("Virtual_Sequencer", "cannot get the config, check if it is set")

    rd_seqr = new[m_cfg.no_of_read_agents];

endfunction
