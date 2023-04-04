module top;
  
    //import router_pkg.sv
    import r_package::*;
    
    // import the UVM package
  	import uvm_pkg::*; 

    `include "uvm_macros.svh"
    
    bit clock;
    always
      #10 clock = !clock;

    //Instantiating the router interface

   // router_if in(clock);
    //router_if in0(clock);
    //router_if in1(clock);
    //router_if in2(clock);
    //router_if in3(clock);

	//Instantiating the Router DUV with the interfaces
	//router_top DUV(.clock(clock),.resetn(in.resetn), .data_in(in.data_in), .pkt_valid(in.pkt_valid),.err(in.err), .busy(in.busy), .vld_out_0(in0.vld_out), .read_enb_0(in0.read_enb), .data_out_0(in0.data_out),  .vld_out_1(in1.vld_out), .read_enb_1(in1.read_enb), .data_out_1(in1.data_out),  .vld_out_2(in2.vld_out), .read_enb_2(in2.read_enb), .data_out_2(in2.data_out));

	initial begin
        /* uvm_config_db#(virtual router_if)::set(null,"*","vif",in);
        uvm_config_db#(virtual router_if)::set(null,"*","vif_0",in0);
        uvm_config_db#(virtual router_if)::set(null,"*","vif_1",in1);
        uvm_config_db#(virtual router_if)::set(null,"*","vif_2",in2);
        uvm_config_db#(virtual router_if)::set(null,"*","vif_3",in3); */

        run_test();

	end

endmodule