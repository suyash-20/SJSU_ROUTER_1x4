class r_test extends uvm_test;

    `uvm_component_utils(r_test)

    r_env env;
    r_env_config env_cfg;

    //agent config objects

    //data members

    extern function new(string name="r_test", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    //extern task run_phase(uvm_phase phase);
    //config function
endclass

function r_test::new(string name="r_test", uvm_component parent);
    super.new(name, parent);
endfunction


function void r_test::build_phase(uvm_phase phase);
    super.build_phase(phase);

    env_cfg=r_env_config::type_id::create("env_cfg", this);

    //config task logic

    env = r_env::type_id::create("env", this);

endfunction


//====================================== EXTENDED TEST CASES =========================================//



