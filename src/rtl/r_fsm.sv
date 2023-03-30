module r_fsm(clk, resetn, pkt_valid, /*data_in,*/ fifo_full, fifo_empty_0, fifo_empty_1, fifo_empty_2, fifo_empty_3, soft_reset_0, soft_reset_1, soft_reset_2, soft_reset_3, parity_done, low_packet_valid,
            write_enb_reg, detect_add, ld_state, laf_state, lfd_state, full_state, rst_int_reg, busy);


            input clk, resetn, pkt_valid;
            //input [1:0] data_in;
            input fifo_full, fifo_empty_0, fifo_empty_1, fifo_empty_2, fifo_empty_3;
            input soft_reset_0, soft_reset_1, soft_reset_2, soft_reset_3, parity_done, low_packet_valid;

            output reg write_enb_reg, detect_add, ld_state, laf_state, lfd_state;
            output reg full_state, rst_int_reg, busy;



            typedef enum {DECODE_ADDRESS, LOAD_FIRST_DATA, LOAD_DATA, LOAD_PARITY, FIFO_FULL_STATE, LOAD_AFTER_FULL, WAIT_TILL_EMPTY, CHECK_PARITY_ERROR} r_state;

            r_state current_state, next_state;


            always @(posedge clk) begin
                if(~resetn) begin

                {write_enb_reg, detect_add, ld_state, laf_state, lfd_state, full_state, rst_int_reg, busy} <= 0;

                    current_state <= DECODE_ADDRESS; 
                end
                else if(soft_reset_0 || soft_reset_1 || soft_reset_2 || soft_reset_3)
                    current_state <= DECODE_ADDRESS;
                
                else begin
                    current_state <= next_state;
                end
            end


            always@(*) begin

                case(current_state)

                DECODE_ADDRESS: begin
                    detect_add = 'b1;

                    if(pkt_valid && (fifo_empty_0 || fifo_empty_1 || fifo_empty_2 || fifo_empty_3)) begin
                        next_state = LOAD_FIRST_DATA;
                    end

                    else if(pkt_valid && (~fifo_empty_0 || ~fifo_empty_1 || ~fifo_empty_2 || ~fifo_empty_3)) begin
                        next_state = WAIT_TILL_EMPTY;
                    end
                        
                    else begin
                        next_state = DECODE_ADDRESS;
                    end
                end

                LOAD_FIRST_DATA: begin
                    lfd_state = 'b1;
                    busy = 'b1;

                    next_state = LOAD_DATA;
                end

                LOAD_DATA: begin
                    ld_state = 'b1;
                    busy = 'b0;
                    write_enb_reg = 'b1;

                    if(~pkt_valid && ~fifo_full) begin
                        next_state = LOAD_PARITY;
                    end
                    else if (fifo_full) begin
                        next_state = FIFO_FULL_STATE;
                    end

                    else begin
                        next_state = LOAD_DATA;

                    end
                end

                LOAD_PARITY: begin
                    busy = 'b1;
                    write_enb_reg = 'b1;
                    next_state = CHECK_PARITY_ERROR;
                end

                FIFO_FULL_STATE: begin
                    
                    busy = 'b1;
                    write_enb_reg = 'b0;

                    if(~fifo_full) begin
                        next_state = LOAD_AFTER_FULL;
                    end

                    else begin
                        next_state = FIFO_FULL_STATE;
                    end 
                end

                LOAD_AFTER_FULL: begin
                    laf_state = 'b1;
                    busy = 'b1;
                    write_enb_reg = 'b1;

                    if(parity_done) begin
                        next_state = DECODE_ADDRESS;
                    end

                    else if (~parity_done && low_packet_valid) begin
                        next_state = LOAD_PARITY;
                    end
                    
                    
                    else if (~parity_done && ~low_packet_valid) begin
                        next_state = LOAD_DATA;
                    end

                    else
                        next_state = LOAD_AFTER_FULL;

                end

                WAIT_TILL_EMPTY: begin
                    busy = 'b1;
                    write_enb_reg = 'b0;

                    if (fifo_empty_0||fifo_empty_1||fifo_empty_2||fifo_empty_3) begin
                        next_state = LOAD_FIRST_DATA;
                    end    

                    else if (~fifo_empty_0||~fifo_empty_1||~fifo_empty_2||~fifo_empty_3) begin
                        next_state = WAIT_TILL_EMPTY;
                        
                    end    

                    else
                        next_state = WAIT_TILL_EMPTY;
                        
                end

                CHECK_PARITY_ERROR : begin

                    rst_int_reg = 'b1;
                    busy = 'b1;
                    if(fifo_full)
                        next_state = FIFO_FULL_STATE;

                    else 
                        next_state = DECODE_ADDRESS;

                end
        
            endcase
        
        end

endmodule
