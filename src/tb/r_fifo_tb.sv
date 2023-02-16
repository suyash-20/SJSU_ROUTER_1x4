`define DATA_WIDTH 8


module r_fifo_tb();

    reg clk, resetn, soft_reset, write_enb, read_enb, lfd_state;
    reg [`DATA_WIDTH-1 : 0] data_in;

    reg full, empty;
    wire [`DATA_WIDTH-1 : 0] data_out;


r_fifo dut (clk, resetn, soft_reset, write_enb, read_enb, lfd_state, data_in, full, empty, data_out);

//r_fifo dut(clk, resetn, soft_reset, write_enb, read_enb, lfd_state, data_in,data_out, full, empty);

  
    always begin
        #5 clk = 1;
        #5 clk = !clk;
    end
    
    initial begin 
        
            @(negedge clk);
            resetn = 0;
            @(negedge clk);
            resetn = 1;


            @(negedge clk);
            lfd_state = 1;
                
            repeat(20) begin
                @(negedge clk);
                write_enb = 1;   
                
                @(negedge clk);
                data_in = $random;
                @(negedge clk);
                lfd_state = 0;    
                @(negedge clk);
                read_enb = 1;   
                  
            end

            @(negedge clk);
            write_enb = 0;
            
            @(negedge clk);
            read_enb = 0;
                     
    end

    initial begin

	

      $dumpfile("file.vcd");
      $dumpvars();
        #1000;
	$display(dut.fifo_mem);	
	$finish();
    end
    

endmodule
