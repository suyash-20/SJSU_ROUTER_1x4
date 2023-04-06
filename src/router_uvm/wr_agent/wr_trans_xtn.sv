class wr_trans_xtn extends uvm_sequence_item;

    `uvm_object_utils(wr_trans_xtn)


    rand bit [7:0]header;
    rand bit [7:0]payload[];
    bit [7:0]parity;


    //Enumerated data type variable for good tranx and bad tranxs


    constraint c_payload{payload.size inside{[1:63]};}
    constraint c{header[7:2]==payload.size;}
    constraint c6{foreach(payload[i])
            payload[i] inside {[5:255]};}


    //UVM METHODS
    extern function new(string name = "wr_trans_xtn");
    extern function void do_print(uvm_printer printer);
    extern function void post_randomize();
endclass

//constructor method

function wr_trans_xtn::new(string name = "wr_trans_xtn");
    super.new(name);

endfunction



//POST_RANDOMIZE

function void wr_trans_xtn::post_randomize();

    parity = parity ^ header;

    foreach(payload[i])
    parity = parity^payload[i];

endfunction




function void  wr_trans_xtn::do_print (uvm_printer printer);
    super.do_print(printer);

    printer.print_field( "header", this.header, 8, UVM_BIN);

    foreach(payload[i])
        printer.print_field( $sformatf("payload[%0d]",i), this.payload[i], 8, UVM_DEC);

	printer.print_field( "parity", this.parity, 8, UVM_DEC);
   
endfunction





