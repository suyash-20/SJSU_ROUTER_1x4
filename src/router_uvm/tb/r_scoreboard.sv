class r_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(r_scoreboard)

    //tlm analysis port
    uvm_tlm_analysis_fifo#(rd_trans_xtn)fifo_rdh[];
    uvm_tlm_analysis_fifo#(wr_trans_xtn)fifo_wrh;

    r_env_config m_cfg; 



    extern function new(string name="r_scoreboard", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void check_phase(uvm_phase phase);

    //extern task run_phase(uvm_phase phase);
    //extern task check_data();
     
endclass


function r_scoreboard::new(string name="r_scoreboard", uvm_component parent);
    super.new(name, parent);

        //coverage handles

endfunction

function void r_scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);


    if(!uvm_config_db#(r_env_config)::get(this,"","r_env_config",m_cfg))
    `uvm_fatal("ROUTER_SCOREBOARD","cannot get the config, have you set it -__-")

    fifo_wrh=new("fifo_wrh",this);

    fifo_rdh = new[m_cfg.no_of_read_agents];

    foreach(fifo_rdh[i])
        fifo_rdh[i]= new($sformatf("fifo_rdh[%0d]",i),this);


endfunction



function void r_scoreboard::check_phase(uvm_phase phase);
    super.check_phase(phase);

    //check logic if no check data task is implemented

endfunction

//task check_data();


