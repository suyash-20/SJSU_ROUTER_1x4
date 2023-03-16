module r_sync_tb();

    reg [1:0] data_in;
    reg clk, resetn, detect_add;
    reg full_0, full_1, full_2, full_3, empty_0, empty_1, empty_2, empty_3;
    reg write_enb_reg, read_enb_0, read_enb_1, read_enb_2, read_enb_3;

    wire [3:0] write_enb;
    wire fifo_full;
    wire vld_out_0, vld_out_1, vld_out_2, vld_out_3;
    wire soft_reset_0, soft_reset_1, soft_reset_2, soft_reset_3;



    r_sync dut (clk, resetn, data_in, detect_add, full_0, full_1, full_2, full_3, empty_0, empty_1, empty_2, empty_3, write_enb_reg, read_enb_0, read_enb_1, read_enb_2, read_enb_3, write_enb, fifo_full, vld_out_0, vld_out_1, vld_out_2, vld_out_3, soft_reset_0, soft_reset_1, soft_reset_2, soft_reset_3);
    
    //router_sync dut(clk, resetn, data_in, detect_add, full_0,full_1,full_2, empty_0,empty_1,empty_2, write_enb_reg, read_enb_0,read_enb_1,read_enb_2,write_enb, fifo_full, vld_out_0,vld_out_1,vld_out_2, soft_reset_0,soft_reset_1,soft_reset_2);

    always begin
        #5 clk = 1'b1;
        #5 clk = ~clk;
    end

    task reset();
        @(negedge clk);
        resetn = 1'b0;
        #20;
        @(negedge clk);
        resetn = 1'b1;
    endtask


    task vld_out();
        @(negedge clk);
            empty_0 = 1;
        #100;
        @(negedge clk);
            empty_0 = 0;
        

        @(negedge clk);
            empty_1 = 1;
        #100;
        @(negedge clk);
            empty_1 = 0;


        @(negedge clk);
            empty_2 = 1;      
        #50;
        @(negedge clk);
            empty_2 = 0;


        @(negedge clk);

            empty_3 = 1;        
        #90;
            empty_3 = 0;

    endtask

    task write_enable();
        
        @(negedge clk);
        detect_add <= 1;
        @(negedge clk);
        full_0 <= 1'b1;
        @(negedge clk);
        data_in <= 2'b00;
        @(negedge clk);
        write_enb_reg <= 1'b1;


        @(negedge clk);
        data_in <= 2'b01;
        @(negedge clk);
        detect_add <= 1;
        @(negedge clk);
        full_1 <= 1'b1;
        @(negedge clk);
        data_in <= 2'b01;
        @(negedge clk);
        write_enb_reg <= 1'b1;

        #100;
        @(negedge clk);
        detect_add <= 1;
        @(negedge clk);
        full_3 <= 1'b1;
        @(negedge clk);
        data_in <= 2'b11;
        @(negedge clk);
        write_enb_reg <= 1'b1;

        #100;

        @(negedge clk);
        detect_add <= 1;
        @(negedge clk);
        full_2 <= 1'b1;
        @(negedge clk);
        data_in <= 2'b10;
        @(negedge clk);
        write_enb_reg <= 1'b1;
    endtask

    task soft_rst();
        @(negedge clk);
        empty_0 = 0;
        repeat(20) begin
            @(negedge clk) read_enb_0 = 0;
        end
    
        @(negedge clk);
        read_enb_0 = 1;
        @(negedge clk);
        empty_0 = 1;


        #50;

        @(negedge clk);
        empty_1 = 0;
        repeat(20) begin
            @(negedge clk) read_enb_1 = 0;
        end
    
        @(negedge clk);
        read_enb_1 = 1;
        @(negedge clk);
        empty_1 = 1;

        #50;

        @(negedge clk);
        empty_2 = 0;
        repeat(20) begin
            @(negedge clk) read_enb_2 = 0;
        end
    
        @(negedge clk);
        read_enb_2 = 1;
        @(negedge clk);
        empty_2 = 1;


        #50;

        @(negedge clk);
        empty_3 = 0;
        repeat(20) begin
            @(negedge clk) read_enb_3 = 0;
        end
    
        @(negedge clk);
        read_enb_3 = 1;
        @(negedge clk);
        empty_3 = 1;

    endtask



    initial begin
        reset();
        #5;

        vld_out();
        #5;
        reset();
        #5;
        write_enable();

        #10;

        soft_rst();

        #20;
        
        reset();

    end


    initial begin
        $dumpfile("sync_wave.vcd");
        $dumpvars();
        $monitor(dut.data_temp, dut.detect_add);
        $monitor("LOLOLOLOL",write_enb, dut.write_enb);

        #80000 $finish();
    end

endmodule