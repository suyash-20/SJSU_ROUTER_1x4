class wr_driver extends uvm_driver #(wr_trans_xtn);

    `uvm_component_utils(wr_driver)

    // objects for virtualinterface
    virtual r_if.WDR_MP vif;


    extern function new(string name="wr_driver", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    
    extern task drive_dut(wr_trans_xtn xtn);
    extern task run_phase(uvm_phase phase);

    //agent config handles
    wr_agent_config m_cfg;


endclass


function wr_driver::new(string name="wr_driver", uvm_component parent);
    super.new(name, parent);

endfunction

function void wr_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(wr_agent_config)::get(this,"","wr_agent_config",m_cfg))
        `uvm_fatal("RD_DRIVER","Cannot get the config from uvm-config-db, have yu set it")


endfunction


function void wr_driver::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    //virtual interface connections
    vif = m_cfg.vif;
endfunction

task wr_driver::run_phase(uvm_phase phase);
    super.run_phase(phase);

    @(vif.write_driver_cb);
    vif.write_driver_cb.resetn <= 1'b0;
    @(vif.write_driver_cb);
    vif.write_driver_cb.resetn <= 1'b1;

    forever begin
        seq_item_port.get_next_item(req);
        drive_dut(req);
        seq_item_port.item_done();
    end

endtask


task wr_driver::drive_dut(wr_trans_xtn xtn);

    @(vif.write_driver_cb);
    wait(~vif.write_driver_cb.busy)
    vif.write_driver_cb.pkt_valid <= 1'b1;
    vif.write_driver_cb.data_in <= xtn.header;

    @(vif.write_driver_cb);
    foreach(xtn.payload[i]) begin
        wait(~vif.write_driver_cb.busy)
        vif.write_driver_cb.data_in <= xtn.payload[i];

        @(vif.write_driver_cb);
    end
    
    wait(~vif.write_driver_cb.busy)

    vif.write_driver_cb.pkt_valid <= 1'b0;
    vif.write_driver_cb.data_in <= xtn.parity;
    //@(vif.write_driver_cb);
    `uvm_info("ROUTER_WR_DRIVER",$sformatf("printing from Write Driver \n %s", xtn.sprint()),UVM_LOW) 

endtask
