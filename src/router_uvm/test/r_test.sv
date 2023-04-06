class r_test extends uvm_test;

    `uvm_component_utils(r_test)

    r_env env;
    r_env_config env_cfg;

    //agent config objects
    wr_agent_config m_wr_cfg;
    rd_agent_config m_rd_cfg[];

    //data members

    int no_of_read_agents = 4;
	int has_ragent = 1;
	int has_wagent = 1;

    extern function new(string name="r_test", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void config_function();
endclass

function r_test::new(string name="r_test", uvm_component parent);
    super.new(name, parent);
endfunction


function void r_test::config_function();

    if(has_wagent) begin

    m_wr_cfg = wr_agent_config::type_id::create("m_wr_cfg");


    if(!uvm_config_db#(virtual r_if)::get(this,"","vif",m_wr_cfg.vif))
    `uvm_fatal("VIF_CONFIG","cannot get the interface vif from uvm_config_db")

    m_wr_cfg.is_active = UVM_ACTIVE;
    env_cfg.m_wr_cfg = m_wr_cfg;

    end



    if (has_ragent) begin
        m_rd_cfg = new[no_of_read_agents];

        foreach(m_rd_cfg[i]) begin
            m_rd_cfg[i] = rd_agent_config::type_id::create($sformatf("m_rd_cfg[%0d]",i));
            
            if(!uvm_config_db#(virtual r_if)::get(this,"",$sformatf("vif_%0d",i),m_rd_cfg[i].vif))
                `uvm_fatal("VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?")
            m_rd_cfg[i].is_active = UVM_ACTIVE;
            env_cfg.m_rd_cfg[i] = m_rd_cfg[i];               
        end
    end
    env_cfg.no_of_read_agents = no_of_read_agents;
    env_cfg.has_ragent = has_ragent;
    env_cfg.has_wagent = has_wagent;
    
endfunction


function void r_test::build_phase(uvm_phase phase);
    super.build_phase(phase);

    env_cfg=r_env_config::type_id::create("env_cfg", this);

    if(has_ragent)
        env_cfg.m_rd_cfg = new[no_of_read_agents];

    config_function();

    uvm_config_db #(r_env_config)::set(this,"*","r_env_config",env_cfg);


    env = r_env::type_id::create("env", this);

endfunction


//====================================== EXTENDED TEST CASES =========================================//



class r_normal_test extends r_test;

    `uvm_component_utils(r_normal_test)

    extern function new(string name="r_normal_test", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);

    r_normal_vseq r_norm;


endclass

function r_normal_test::new(string name="r_normal_test", uvm_component parent);
    super.new(name, parent);

endfunction


function void r_normal_test::build_phase(uvm_phase phase);

    super.build_phase(phase);

endfunction



task r_normal_test::run_phase(uvm_phase phase);

    phase.raise_objection(this);
    r_norm = r_normal_vseq::type_id::create("r_norm");

    r_norm.start(env.r_vir_seqr);

    #5000;
    phase.drop_objection(this);


endtask
