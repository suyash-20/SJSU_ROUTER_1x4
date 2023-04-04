/* 

//`include "r_defs.sv"

`define DATA_WIDTH 9

`define FIFO_PTR_WIDTH 4
`define FIFO_DEPTH 16
`define FIFO_FULL_BIT 4
`define PTR_WIDTH 3

`define PACKET_LEN_MSB 7
`define PACKET_LEN_LSB 2



module r_fifo(
    input clk, resetn, soft_reset, write_enb, read_enb, lfd_state,
    input [7:0] data_in,

    output full, empty,
    output reg [7:0] data_out);

    reg [`FIFO_PTR_WIDTH : 0] write_ptr, read_ptr;

    reg [`DATA_WIDTH-1 : 0] fifo_mem [`FIFO_DEPTH-1 : 0];

    reg [6 : 0]packet_len_count;

    reg lfd_temp;

    //reg [`DATA_WIDTH-1 : 0] data_out_t;
    //reg full_t, empty_t; 

always@(posedge clk) begin
    if(~resetn) begin
        lfd_temp <= 0;

    end

    else begin
        lfd_temp <= lfd_state;
    end
end

//============ WRITE OPERATION ============//

   always@(posedge clk) begin
        if(~resetn) begin
            for(int i=0; i< `FIFO_DEPTH; i=i+1) begin
                fifo_mem[i] <= 0;
            end            

        end

        else if(soft_reset) begin
            for(int i=0; i< `FIFO_DEPTH; i=i+1) begin
                fifo_mem[i] <= 0;
            end            

        end

        else if (write_enb && ~full) begin
            {fifo_mem[write_ptr[3:0]][8], fifo_mem[write_ptr[3:0]][7:0]} <= {lfd_temp, data_in};
        end
   end

//============ READ OPERATION ============//

   always@(posedge clk) begin
        if(~resetn) begin
            data_out <= 0;
        end
        
        else if(soft_reset || (packet_len_count==0)) begin
            data_out <= 'bz;
        end

        else if(read_enb && ~empty) begin
            data_out <= fifo_mem[read_ptr[3:0]];
        end
   end

   always @(posedge clk) begin
        if(~resetn) begin
            packet_len_count <= 0;
        end

        else if(read_enb && ~empty) begin
            if(fifo_mem[read_ptr[3:0]][8]) begin
                packet_len_count <= fifo_mem[read_ptr[3:0]][7:2];
            end

            else if(packet_len_count == 0) begin
                packet_len_count <= packet_len_count;
            end

            else 
                packet_len_count <= packet_len_count - 1;
        end
   end

   always@(posedge clk) begin
        if(~resetn) begin
            write_ptr <= 0;
            read_ptr <= 0;
        end

        else begin
            if(write_enb && ~full) begin
                write_ptr <= write_ptr + 1;
            end

            if(read_enb && ~empty) begin
                read_ptr <= read_ptr + 1;
            end
        end
   end

   assign full = ((write_ptr[4] != read_ptr[4]) && (write_ptr[3:0] == read_ptr[3:0]));
   assign empty = ((write_ptr == read_ptr));

endmodule



//=========================================================================================================================================================================================



module r_fsm(clk, resetn, pkt_valid, fifo_full, fifo_empty_0, fifo_empty_1, fifo_empty_2, fifo_empty_3, soft_reset_0, soft_reset_1, soft_reset_2, soft_reset_3, parity_done, low_packet_valid,
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

                    current_state <= DECODE_ADDRESS; 
                end
                else if(soft_reset_0 || soft_reset_1 || soft_reset_2 || soft_reset_3)
                    current_state <= DECODE_ADDRESS;
                
                else begin
                    current_state <= next_state;
                end
            end


            always@(*) begin
                
                write_enb_reg = 0;
                detect_add = 0;
                ld_state = 0;
                laf_state = 0;
                lfd_state = 0;
                full_state = 0;
                rst_int_reg = 0;
                busy = 0;
                
                next_state = DECODE_ADDRESS;
                
                
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


//=====================================================================================================================================================================================================


module r_reg(clk, resetn, pkt_valid, data_in, fifo_full,
		  detect_add, ld_state, laf_state,full_state, lfd_state, rst_int_reg,
		  err, parity_done, low_packet_valid, dout);


    input clk, resetn, pkt_valid, fifo_full, detect_add,
        ld_state, laf_state,full_state, lfd_state, rst_int_reg;

    input [7:0] data_in;


    output reg err, parity_done, low_packet_valid;
    output reg [7:0] dout;

    reg [7:0] header_reg, full_reg, parity_reg, packet_parity;


                    
    ////////////////RESET AND PARITY DONE\\\\\\\\\\\\\\\\\\

    always@(posedge clk)    
    begin
        if(~resetn)
            begin
            //dout<= 8'd0;
            //err<= 1'd0;
            parity_done<= 1'd0;
            //low_pkt_valid<= 1'd0;
            end
        else
            begin
            if((ld_state && ~fifo_full && ~pkt_valid) || (laf_state && low_packet_valid && ~parity_done))
            parity_done<=1'd1;
                else if(detect_add)
            parity_done<= 1'd0;
            end
    end


    ///////////////LOW PACKET VALID\\\\\\\\\\\\\\\\\\\\

    always@(posedge clk)
    begin
        if(~resetn)
            low_packet_valid<= 1'd0;
        else if(~pkt_valid && ld_state)
            low_packet_valid<= 1'd1;
        else if(rst_int_reg)
            low_packet_valid<= 1'd0;
    end


    //////////////////////HEADER BYTE LOGIC\\\\\\\\\\\\\\\\\\\\\

    always@(posedge clk)
    begin

        if(~resetn)
            begin
            dout<= 0;
            header_reg<= 8'd0;
            full_reg<= 8'd0;
            end

        else if(detect_add && pkt_valid)
            header_reg<= data_in;

        else if(lfd_state)
            dout<= header_reg;
            
        else if(ld_state && (~fifo_full))
            dout<= data_in;

        else if(ld_state && fifo_full)
            full_reg<= data_in;

        else if(laf_state)
            dout<= full_reg;

    end
        

    ////////////////PARITY CALC\\\\\\\\\\\\\\\\\\\\\
    always@(posedge clk)
    begin
        if(~resetn)
            parity_reg<= 8'd0;
        else if(detect_add)
        parity_reg<=0;
        else if(lfd_state && pkt_valid)
            parity_reg<= parity_reg ^ header_reg;
        else if(full_state==0 && ld_state && pkt_valid)
            parity_reg<= parity_reg ^ data_in; 
    end

    ////////////////////////ERR\\\\\\\\\\\\\\\\\\\\\\\\

    always@(posedge clk)
    begin
        if(~resetn)
            err<=1'd0;
        else
            
            if(parity_done)
            begin
                if(packet_parity == parity_reg)
                err<= 1'd0;
                else 
                err<= 1'd1;
            end
            else 
            err<=1'd0;
        
    end


    /////////////////////PACKET_PARITY\\\\\\\\\\\\\\\\\\\\\\\\\

    always@(posedge clk)
    begin
        if(~resetn)
            packet_parity<= 8'd0;
        else if(detect_add)
        packet_parity<=0;
        else if((~fifo_full && ~pkt_valid) || (~parity_done && low_packet_valid))
            packet_parity<= data_in;
    end

endmodule



//=====================================================================================================================================================================================================



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


//=====================================================================================================================================================================================================



 module r_top(clk, data_in, pkt_valid, resetn, read_enb,
             data_out, vld_out, err, busy);

    input clk, pkt_valid, resetn;
    input [3:0] read_enb;
    input [7:0] data_in;

    //output reg [7:0] data_out_0, data_out_1, data_out_2, data_out_3;
    output reg [7:0] data_out[4];
    
    output reg [3:0] vld_out;
    output reg err, busy;


    // WIRES FOR CONNECTING SUB-MODULES
    wire [3:0]soft_rst, wrt_enb;
    wire lfd_st;
    wire[7:0] din;
    wire [3:0] full_temp, empty_temp;
    wire fifo_full_temp;
    wire parity_done_temp, low_pkt_valid_temp;
    wire write_enb_reg_temp, detect_addr_temp, ld_state_temp, laf_state_temp, lfd_state_temp, full_state_temp, rst_int_reg_temp, busy_temp;

    genvar i;

    generate

        for(i=0; i<4; i=i+1) begin
            r_fifo fifo(
                .clk(clk), .resetn(resetn), .soft_reset(soft_rst[i]), .write_enb(wrt_enb[i]), .read_enb(read_enb[i]),
                .lfd_state(lfd_st), .data_in(din), .full(full_temp[i]), .empty(empty_temp[i]), .data_out(data_out[i])
            );
        end

    endgenerate


    
    r_fsm fsm(
            .clk(clk), .resetn(resetn), .pkt_valid(pkt_valid), .fifo_full(fifo_full_temp), .fifo_empty_0(empty_temp[0]), .fifo_empty_1(empty_temp[1]), .fifo_empty_2(empty_temp[2]), .fifo_empty_3(empty_temp[3]), 
            .soft_reset_0(soft_rst[0]), .soft_reset_1(soft_rst[1]), .soft_reset_2(soft_rst[2]), .soft_reset_3(soft_rst[3]), .parity_done(parity_done_temp), .low_packet_valid(low_pkt_valid_temp),
            .write_enb_reg(write_enb_reg_temp), .detect_add(detect_addr_temp), .ld_state(ld_state_temp), .laf_state(laf_state_temp), .lfd_state(lfd_st), .full_state(full_state_temp), .rst_int_reg(rst_int_reg_temp), .busy(busy)  
        );



    r_reg regg(
            .clk(clk), .resetn(resetn), .pkt_valid(pkt_valid), .data_in(data_in), .fifo_full(fifo_full_temp),
            .detect_add(detect_addr_temp), .ld_state(ld_state_temp), .laf_state(laf_state_temp),.full_state(full_state_temp), .lfd_state(lfd_st), .rst_int_reg(rst_int_reg_temp),
            .err(err), .parity_done(parity_done_temp), .low_packet_valid(low_pkt_valid_temp), .dout(din)
        );
    

    r_sync sync (
            .clk(clk), .resetn(resetn), .data_in(data_in[1:0]), .detect_add(detect_addr_temp), .full_0(full_temp[0]), .full_1(full_temp[1]), .full_2(full_temp[2]), .full_3(full_temp[3]), 
            .empty_0(empty_temp[0]), .empty_1(empty_temp[1]), .empty_2(empty_temp[2]), .empty_3(empty_temp[3]), .write_enb_reg(write_enb_reg_temp), 
            .read_enb_0(read_enb[0]), .read_enb_1(read_enb[1]), .read_enb_2(read_enb[2]), .read_enb_3(read_enb[3]),
            .write_enb(wrt_enb), .fifo_full(fifo_full_temp), .vld_out_0(vld_out[0]), .vld_out_1(vld_out[1]), .vld_out_2(vld_out[2]), .vld_out_3(vld_out[3]), 
            .soft_reset_0(soft_rst[0]), .soft_reset_1(soft_rst[1]), .soft_reset_2(soft_rst[2]), .soft_reset_3(soft_rst[3])
        );




 endmodule
    
 */