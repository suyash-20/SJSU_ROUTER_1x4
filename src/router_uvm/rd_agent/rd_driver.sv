class rd_driver extends uvm_driver #(rd_trans_xtn);

    `uvm_component_utils(rd_driver)

    // objects for virtualinterface
    virtual r_if.RDR_MP vif;


    extern function new(string name="rd_driver", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    
    extern task drive_dut(rd_trans_xtn xtn);
    extern task run_phase(uvm_phase phase);

    //agent config handles
    rd_agent_config m_cfg;


endclass


function rd_driver::new(string name="rd_driver", uvm_component parent);
    super.new(name, parent);

endfunction

function void rd_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db#(rd_agent_config)::get(this,"","rd_agent_config",m_cfg))
        `uvm_fatal("RD_DRIVER","Cannot get the config from uvm-config-db, have yu set it")

endfunction


function void rd_driver::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    //virtual interface connections
    vif = m_cfg.vif;

endfunction

task rd_driver::run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
        seq_item_port.get_next_item(req);
        drive_dut(req);
        seq_item_port.item_done();
        end
        

endtask


task rd_driver::drive_dut(rd_trans_xtn xtn);

fork

begin
@(vif.read_driver_cb);

wait(vif.read_driver_cb.vld_out)

repeat(xtn.no_of_cycles) @(vif.read_driver_cb);
vif.read_driver_cb.read_enb <= 1'd1;

wait(~vif.read_driver_cb.vld_out)
vif.read_driver_cb.read_enb <= 1'd0;
`uvm_info("ROUTER_RD_MONITOR",$sformatf("printing from Read Driver\n %s", xtn.sprint()),UVM_LOW)
xtn.print();
end

//WATCH DOG TIMER
begin
repeat(100) @(vif.read_driver_cb);
end

join_any
disable fork;
endtask

