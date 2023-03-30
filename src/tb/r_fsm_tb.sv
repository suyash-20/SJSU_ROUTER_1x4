module r_fsm_tb();

    reg clk, resetn, pkt_valid;
    //reg [1:0] data_in;
    reg fifo_full, fifo_empty_0, fifo_empty_1, fifo_empty_2, fifo_empty_3;
    reg soft_reset_0, soft_reset_1, soft_reset_2, soft_reset_3, parity_done, low_packet_valid;

    wire write_enb_reg, detect_add, ld_state, laf_state, lfd_state;
    wire full_state, rst_int_reg, busy; 


    r_fsm dut (clk, resetn, pkt_valid, /*data_in,*/ fifo_full, fifo_empty_0, fifo_empty_1, fifo_empty_2, fifo_empty_3, soft_reset_0, soft_reset_1, soft_reset_2, soft_reset_3, parity_done, low_packet_valid,
            write_enb_reg, detect_add, ld_state, laf_state, lfd_state, full_state, rst_int_reg, busy);

    
    always begin
        #5 clk = 1;
        #5 clk = !clk;
    end

    task sys_reset();
        @(negedge clk);
        resetn = 'b0;
        #20;
        @(negedge clk);
        resetn = 'b1;

	
    endtask


    task normal_data_route();
        @(negedge clk);
        pkt_valid = 'b1;
        @(negedge clk);
        {fifo_empty_0, fifo_empty_1, fifo_empty_2, fifo_empty_3} = 'b1;
        

        #10;
        @(negedge clk);
        pkt_valid = 'b0;
        @(negedge clk);
        fifo_full = 'b0;

//        @(negedge clk);
//        fifo_full = 'b0;
    
    endtask

    task fifo_full_condition();
        @(negedge clk);
        pkt_valid = 'b1;
        @(negedge clk);
        fifo_empty_0 = 'b1;

        #10;
        @(negedge clk);
        pkt_valid = 'b0;
        @(negedge clk);
        fifo_full = 'b0;

        @(negedge clk);
        fifo_full = 'b1;

        #20;
        @(negedge clk);
        fifo_full = 'b0;
    	
	@(negedge clk);
	parity_done = 'b1;
    endtask

    task soft_reset_loop_back();
        @(negedge clk);
        soft_reset_0 = 'b1;
        @(negedge clk);
        soft_reset_1 = 'b1;
        @(negedge clk);
        soft_reset_2 = 'b1;
        @(negedge clk);
        soft_reset_3 = 'b1;


	@(negedge clk);
        soft_reset_0 = 'b0;
        @(negedge clk);
        soft_reset_1 = 'b0;
        @(negedge clk);
        soft_reset_2 = 'b0;
        @(negedge clk);
        soft_reset_3 = 'b0;

    endtask

    task long_packet();
        @(negedge clk);
        pkt_valid = 'b1;
        @(negedge clk);
        fifo_empty_0 = 'b1;

        @(negedge clk);
        fifo_full = 'b1;

        #50;
        @(negedge clk);
        fifo_full = 'b0;

        #50;
        @(negedge clk);
       low_packet_valid = 'b0;
        @(negedge clk);
        parity_done = 'b0;


	@(negedge clk);
	fifo_full = 'b0;
	@(negedge clk);
	pkt_valid = 'b0;
	

    endtask

    task wait_until_empty();

	@(negedge clk);
	{pkt_valid, fifo_full, fifo_empty_0, fifo_empty_1, fifo_empty_2, fifo_empty_3, soft_reset_0, soft_reset_1, soft_reset_2, soft_reset_3, parity_done, low_packet_valid} = 0;

        @(negedge clk);
        pkt_valid = 'b1;
        @(negedge clk);
        fifo_empty_0 = 'b0;


	#30;
	@(negedge clk);
	fifo_empty_0 = 'b1;

	@(negedge clk);
	fifo_full = 0;
	@(negedge clk);
	pkt_valid = 0;

    endtask



    initial begin

        sys_reset();
        #20;

        normal_data_route();

        #100;
	sys_reset();

	#30;

        fifo_full_condition();

        #50;

	sys_reset();
	#30;

        soft_reset_loop_back();

        #20;
        long_packet();
        #20;

	sys_reset();
        #30;
	wait_until_empty();
        
    end

    initial begin
        $monitor("FSM STATE: ", dut.current_state," at time: %t", $time);
	
	$dumpfile("fsm.vcd");
	$dumpvars();

        #10000 $finish();
    end

endmodule
