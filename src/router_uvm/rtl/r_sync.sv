 module r_sync (clk, resetn, data_in, detect_add, full_0, full_1, full_2, full_3, empty_0, empty_1, empty_2, empty_3, write_enb_reg, read_enb_0, read_enb_1, read_enb_2, read_enb_3,
                write_enb, fifo_full, vld_out_0, vld_out_1, vld_out_2, vld_out_3, soft_reset_0, soft_reset_1, soft_reset_2, soft_reset_3);
            
            input [1:0] data_in;
            input clk, resetn, detect_add;
            input full_0, full_1, full_2, full_3, empty_0, empty_1, empty_2, empty_3;
            input write_enb_reg, read_enb_0, read_enb_1, read_enb_2, read_enb_3;

            output reg [3:0] write_enb;
            output reg fifo_full;
            output reg vld_out_0, vld_out_1, vld_out_2, vld_out_3;
            output reg soft_reset_0, soft_reset_1, soft_reset_2, soft_reset_3;

            reg [1:0] data_temp;
            reg [4:0] soft_rst_count_0, soft_rst_count_1, soft_rst_count_2, soft_rst_count_3;

            //======================== FIFO FULL LGOIC ========================//
 

            always@(posedge clk) begin
                if(~resetn) begin
                    data_temp <= 'b0;
                end
                else if(detect_add)begin
                    data_temp <= data_in;
                end
            end

        always@(*) begin

                        case(data_temp)
                        

                            2'b00: begin

                                fifo_full <= full_0;
                                if(write_enb_reg) begin
                                    write_enb <= 4'b0001;
                                end                      
                                else begin
                                    write_enb <= 'b0;
                                end      
                                $display("cjbsjcb: %b",fifo_full);

                            end 

                            2'b01: begin
                                fifo_full <= full_1;

                                if(write_enb_reg) begin
                                    write_enb <= 4'b0010;
                                end                      
                                else begin
                                    write_enb <= 'b0;
                                end      
                            end

                            2'b10: begin
                                fifo_full <= full_2;

                                if(write_enb_reg) begin
                                    write_enb <= 4'b0100;
                                end                      
                                else begin
                                    write_enb <= 'b0;
                                end      
                            end

                            2'b11: begin
                                fifo_full <= full_3;

                                if(write_enb_reg) begin
                                    write_enb <= 4'b1000;
                                end                      
                                else begin
                                    write_enb <= 'b0;
                                end      
                            end

                        endcase
        end
            //=================================================================//





            //======================== SOFT RESET LGOIC ========================//

            
            always@(posedge clk) begin
                if(~resetn) begin
                    soft_reset_0 <= 1'b0;
                end

                else if(vld_out_0) begin
                        if(~read_enb_0) begin
                            if(soft_rst_count_0 == 29) begin
                                soft_reset_0 <= 1'b1;
                                soft_rst_count_0 <= 'd0;
                            end

                            else begin
                                soft_reset_0 <= 1'b0;
                                soft_rst_count_0 <= soft_rst_count_0 + 1;
                            end
                        end

                        else begin
                                soft_reset_0 <= 1'b0;
                                soft_rst_count_0 <= 'd0;
                        end
                end 
            end



            always@(posedge clk) begin
                if(~resetn) begin
                    soft_reset_1 <= 1'b0;
                end

                else if(vld_out_1) begin
                        if(~read_enb_1) begin
                            if(soft_rst_count_1 == 29) begin
                                soft_reset_1 <= 1'b1;
                                soft_rst_count_1 <= 'd0;
                            end

                            else begin
                                soft_reset_1 <= 1'b0;
                                soft_rst_count_1 <= soft_rst_count_1 + 1;
                            end
                        end

                        else begin
                                soft_reset_1 <= 1'b0;
                                soft_rst_count_1 <= 'd0;
                        end
                end 
            end


            always@(posedge clk) begin
                if(~resetn) begin
                    soft_reset_2 <= 1'b0;
                end

                else if(vld_out_2) begin
                        if(~read_enb_2) begin
                            if(soft_rst_count_2 == 29) begin
                                soft_reset_2 <= 1'b1;
                                soft_rst_count_2 <= 'd0;
                            end

                            else begin
                                soft_reset_2 <= 1'b0;
                                soft_rst_count_2 <= soft_rst_count_2 + 1;
                            end
                        end

                        else begin
                                soft_reset_2 <= 1'b0;
                                soft_rst_count_2 <= 'd0;
                        end
                end 
            end

            always@(posedge clk) begin
                if(~resetn) begin
                    soft_reset_3 <= 1'b0;
                end

                else if(vld_out_3) begin
                        if(~read_enb_3) begin
                            if(soft_rst_count_3 == 29) begin
                                soft_reset_3 <= 1'b1;
                                soft_rst_count_3 <= 'd0;
                            end

                            else begin
                                soft_reset_3 <= 1'b0;
                                soft_rst_count_3 <= soft_rst_count_3 + 1;
                            end
                        end

                        else begin
                                soft_reset_3 <= 1'b0;
                                soft_rst_count_3 <= 'd0;
                        end
                end 
            end


            //=================================================================//


            //======================== VLD_OUT LGOIC ========================//


            assign vld_out_0 = ~empty_0;
            assign vld_out_1 = ~empty_1;
            assign vld_out_2 = ~empty_2;
            assign vld_out_3 = ~empty_3;



endmodule

