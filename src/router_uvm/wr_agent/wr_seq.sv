class wr_seq extends uvm_sequence #(wr_trans_xtn);

    `uvm_object_utils(wr_seq)

    extern function new(string name="wr_seq");


endclass

function wr_seq::new(string name="wr_seq");
    super.new(name);

endfunction


// Extended Write sequences

class wr_norm_case_seq extends wr_seq;

    //== Normal Test Case ==> Basic Router operation (valid destination address and payload size)

    `uvm_object_utils(wr_norm_case_seq)

    extern function new(string name="wr_norm_case_seq");
    extern task body();

endclass


function wr_norm_case_seq::new(string name="wr_norm_case_seq");
    super.new(name);

endfunction


task wr_norm_case_seq::body();

    req = wr_trans_xtn::type_id::create("req");

    start_item(req);

    assert(req.randomize with {header[1:0] == 'b01; payload.size == 16;});
        `uvm_info("WRITE SEQUENCE ==> Normal Test case(Payload size is 16, destination is 'b10)", $sformatf("%s", req.sprint()), UVM_HIGH)

    finish_item(req);

endtask




