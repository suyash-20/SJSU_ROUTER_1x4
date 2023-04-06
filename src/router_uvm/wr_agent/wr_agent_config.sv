class wr_agent_config extends uvm_object;

    `uvm_object_utils(wr_agent_config)

    uvm_active_passive_enum is_active = UVM_ACTIVE;
    virtual r_if vif;



    extern function new(string name="wr_agent_config");

endclass


function wr_agent_config::new(string name="wr_agent_config");
    super.new(name);

endfunction
