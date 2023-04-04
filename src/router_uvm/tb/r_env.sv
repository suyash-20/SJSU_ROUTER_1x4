class r_env extends uvm_env;

    `uvm_component_utils(r_env)

    wr_agent wr_agt;
    rd_agent rd_agt;

    //scoreboard handle


    extern function new(string name="r_env", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
endclass


function r_env::new(string name="r_env", uvm_component parent);
    super.new(name, parent);
endfunction


function void r_env::build_phase(uvm_phase phase);
    super.build_phase(phase);

    wr_agt = wr_agent::type_id::create("wr_agt", this);
    rd_agt = rd_agent::type_id::create("rd_agt", this);

    // scoreboard object creation
endfunction


function void r_env::connect_phase(uvm_phase phase);

    super.connect_phase(phase);

    //monitor and scoreboard connections ===> foreach loop?

endfunction


task r_env::run_phase(uvm_phase phase);	
	    uvm_top.print_topology();
	
endtask 