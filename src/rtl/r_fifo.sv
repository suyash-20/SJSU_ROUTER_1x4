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

