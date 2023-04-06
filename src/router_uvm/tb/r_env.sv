class r_env extends uvm_env;

    `uvm_component_utils(r_env)

    wr_agent wr_agt;
    rd_agent rd_agt[];

    r_scoreboard r_scb;

    r_env_config m_cfg; 

    r_virtual_seqr r_vir_seqr;


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


    if(!uvm_config_db #(r_env_config)::get(this,"","r_env_config",m_cfg)) //getting from test
	    `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
	
    if(m_cfg.has_wagent) begin
        uvm_config_db #(wr_agent_config)::set(this,"*","wr_agent_config", m_cfg.m_wr_cfg);
        wr_agt = wr_agent::type_id::create("wr_agt", this);

    end


    if(m_cfg.has_ragent == 1) begin

        foreach(m_cfg.m_rd_cfg[i])begin	
            uvm_config_db#(rd_agent_config)::set(this,$sformatf("rd_agt[%0d]*",i),"rd_agent_config",m_cfg.m_rd_cfg[i]);
        
        end
        
        rd_agt = new[m_cfg.no_of_read_agents];

        foreach(rd_agt[i])
            rd_agt[i] = rd_agent::type_id::create($sformatf("rd_agt[%0d]", i), this);

	end

    if(m_cfg.has_virtual_sequencer)begin
		r_vir_seqr = r_virtual_seqr::type_id::create("r_vir_seqr",this);
    end
 
    if(m_cfg.has_scoreboard) begin
        r_scb = r_scoreboard::type_id::create("r_scb",this);
    end

endfunction


function void r_env::connect_phase(uvm_phase phase);

    super.connect_phase(phase);

    //monitor and scoreboard connections ===> foreach loop

    if(m_cfg.has_virtual_sequencer) begin
        if(m_cfg.has_wagent)
		r_vir_seqr.wr_seqr = wr_agt.wr_seqr;
        
        if(m_cfg.has_ragent) begin
            foreach(rd_agt[i])
			r_vir_seqr.rd_seqr[i] = rd_agt[i].rd_seqr;

        $display("==============================================================================================================hagga?",rd_agt[0]);

        end
    end

	//SCOREBOARD CONNECTION TO WRITE AND READ MONITORS
			
   	if(m_cfg.has_scoreboard)begin
        wr_agt.wr_monh.monitor_port.connect(r_scb.fifo_wrh.analysis_export);
		
		foreach(rd_agt[i])
            rd_agt[i].rd_monh.monitor_port.connect(r_scb.fifo_rdh[i].analysis_export);
	end

endfunction


task r_env::run_phase(uvm_phase phase);	
	    uvm_top.print_topology();
	
endtask 