class rd_monitor extends uvm_monitor; 
    `uvm_component_utils(rd_monitor)

    uvm_analysis_port #(rd_trans_xtn) monitor_port;
    rd_agent_config m_cfg;


    //virtual interface object
    virtual r_if.RMON_MP vif;

    extern function new(string name="rd_monitor", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    
    extern task run_phase(uvm_phase phase);
    extern task collect_data();

endclass


function rd_monitor::new(string name="rd_monitor", uvm_component parent);
    super.new(name, parent);
    monitor_port = new("monitor_port",this);

endfunction

function void rd_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db #(rd_agent_config)::get(this,"","rd_agent_config",m_cfg))
        `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")

endfunction

function void rd_monitor::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    //virtual interface connection
    vif = m_cfg.vif;


endfunction


task rd_monitor::run_phase(uvm_phase phase);
	
	forever
	collect_data();

endtask

//--------------- collect_data() task  -------------------//

task rd_monitor::collect_data();

rd_trans_xtn xtn;

xtn = rd_trans_xtn::type_id::create("xtn");



//@(vif.read_monitor_cb);

wait(vif.read_monitor_cb.read_enb)
@(vif.read_monitor_cb);
//$display("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$",vif.read_monitor_cb.read_enb);
xtn.header = vif.read_monitor_cb.data_out;

xtn.payload = new[xtn.header[7:2]];
 @(vif.read_monitor_cb);

foreach(xtn.payload[i])
begin
xtn.payload[i] = vif.read_monitor_cb.data_out;
@(vif.read_monitor_cb);
end

xtn.parity = vif.read_monitor_cb.data_out;
if(xtn.payload.size != 0)
begin
`uvm_info("ROUTER_RD_MONITOR",$sformatf("printing from Read Monitor \n %s", xtn.sprint()),UVM_LOW)

//sending read packet to scoreboard
monitor_port.write(xtn);


end

endtask

