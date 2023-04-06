//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

class r_env_config extends uvm_object;

  `uvm_object_utils(r_env_config)


//------------------------------------------
// Data Members
//------------------------------------------
    bit has_wagent = 1;
    bit has_ragent = 1;
    bit has_virtual_sequencer = 1;
    bit has_scoreboard = 1;
    int no_of_read_agents = 4;

    
    wr_agent_config m_wr_cfg;
    rd_agent_config m_rd_cfg[];


//------------------------------------------
// Methods
//------------------------------------------
    extern function new(string name = "r_env_config");

endclass

//-----------------  constructor new method  -------------------//

function r_env_config::new(string name = "r_env_config");
  super.new(name);
endfunction




