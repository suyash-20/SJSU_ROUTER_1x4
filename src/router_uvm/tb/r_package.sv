package r_package;

  	import uvm_pkg::*; 

	`include "uvm_macros.svh"
   
	`include "wr_trans_xtn.sv"
	`include "wr_agent_config.sv"
	`include "rd_agent_config.sv"

	`include "r_env_config.sv"

	`include "wr_driver.sv"
	`include "wr_monitor.sv"
	`include "wr_sequencer.sv"
	`include "wr_agent.sv"
	`include "wr_seq.sv"
	
	`include "rd_trans_xtn.sv"

	`include "rd_driver.sv"
	`include "rd_monitor.sv"
	`include "rd_sequencer.sv"
	`include "rd_agent.sv"
	`include "rd_seq.sv"

	`include "r_virtual_seqr.sv"
	`include "r_virtual_seq.sv"
	`include "r_scoreboard.sv"

	`include "r_env.sv"
	`include "r_test.sv"



endpackage
