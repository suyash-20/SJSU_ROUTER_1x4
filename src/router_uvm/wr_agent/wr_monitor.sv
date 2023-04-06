class wr_monitor extends uvm_monitor;

    `uvm_component_utils(wr_monitor)

    uvm_analysis_port #(wr_trans_xtn) monitor_port;
    wr_agent_config m_cfg;


    //virtual interface object
    virtual r_if.WMON_MP vif;



    extern function new(string name="wr_monitor", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    
    extern task run_phase(uvm_phase phase);
    extern task collect_data();

endclass


function wr_monitor::new(string name="wr_monitor", uvm_component parent);
    super.new(name, parent);

    monitor_port = new("monitor_port",this);

endfunction

function void wr_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db #(wr_agent_config)::get(this,"","wr_agent_config",m_cfg))
        `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")

endfunction

function void wr_monitor::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    //virtual interface connection
    vif = m_cfg.vif;


endfunction


task wr_monitor::run_phase(uvm_phase phase);
	forever
    	collect_data();
endtask


//---------------collect_data task()------------------//

task wr_monitor::collect_data();
    wr_trans_xtn xtn;

	xtn = wr_trans_xtn::type_id::create("xtn");
	
    @(vif.write_monitor_cb);
	wait(~vif.write_monitor_cb.busy && vif.write_monitor_cb.pkt_valid)
	xtn.header = vif.write_monitor_cb.data_in;
	
	//PAYLOAD IS DYNAMIC ARRAY

	xtn.payload = new[xtn.header[7:2]];

	@(vif.write_monitor_cb);

	foreach(xtn.payload[i])
	begin
	wait(~vif.write_monitor_cb.busy)

	xtn.payload[i] = vif.write_monitor_cb.data_in;
	@(vif.write_monitor_cb);
	end
	wait(~vif.write_monitor_cb.busy && ~vif.write_monitor_cb.pkt_valid)

	xtn.parity = vif.write_monitor_cb.data_in;
    //@(vif.write_monitor_cb);
    `uvm_info("ROUTER_WR_MONITOR",$sformatf("printing from Write Monitor \n %s", xtn.sprint()),UVM_LOW)

    //sending write packet to the scoreboard
    monitor_port.write(xtn);

endtask

