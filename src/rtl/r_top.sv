/* module r_top(clk, data_in, pkt_valid, resetn, read_enb_0, read_enb_1, read_enb_2, read_enb_3,
            data_out_0, data_out_1, data_out_2, data_out_3, vld_out_0, vld_out_1, vld_out_2, vld_out_3, err, busy);
 */

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
    