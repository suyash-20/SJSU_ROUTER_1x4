class rd_seq extends uvm_sequence #(rd_trans_xtn);

    `uvm_object_utils(rd_seq)

    extern function new(string name="rd_seq");


endclass

function rd_seq::new(string name="rd_seq");
    super.new(name);

endfunction


// Extended Write sequences

class no_timeout_seq extends rd_seq;

    `uvm_object_utils(no_timeout_seq)

    extern function new(string name = "no_timeout_seq");
    extern task body();

endclass

function no_timeout_seq::new(string name = "no_timeout_seq");

    super.new(name);

endfunction


task no_timeout_seq::body();

    req = rd_trans_xtn::type_id::create("this");

    start_item(req);

    assert(req.randomize with {no_of_cycles <= 20;});

    finish_item(req);


endtask
