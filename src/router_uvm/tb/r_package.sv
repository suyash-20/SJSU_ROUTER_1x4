package r_package;

  	import uvm_pkg::*; 

	`include "uvm_macros.svh"
   
	//`include "write_xtn.sv"
	//`include "router_wr_agent_config.sv"
	//`include "router_rd_agent_config.sv"

	`include "r_env_config.sv"

	`include "wr_driver.sv"
	`include "wr_monitor.sv"
	`include "wr_sequencer.sv"
	`include "wr_agent.sv"
	//`include "router_wr_seqs.sv"
	
	//`include "read_xtn.sv"

	`include "rd_driver.sv"
	`include "rd_monitor.sv"
	`include "rd_sequencer.sv"
	`include "rd_agent.sv"
	//`include "router_rd_seqs.sv"

	//`include "router_virtual_sequencer.sv"
	//`include "router_virtual_seqs.sv"
	`include "r_scoreboard.sv"

	`include "r_env.sv"
	`include "r_test.sv"



endpackage
