class r_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(r_scoreboard)

    //tlm analysis port

    extern function new(string name="r_scoreboard", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void check_phase(uvm_phase phase);

    //extern task run_phase(uvm_phase phase);
    //extern task check_data();
     
endclass


function r_scoreboard::new(string name="r_scoreboard", uvm_component parent);
    super.new(name, parent);


    //tlm port object
endfunction

function void r_scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);

endfunction

function void r_scoreboard::check_phase(uvm_phase phase);
    super.check_phase(phase);

    //check logic if no check data task is implemented

endfunction

//task check_data();


