//------------------------------------------
// CLASS DESCRIPTION
//------------------------------------------

class rd_trans_xtn extends uvm_sequence_item;

`uvm_object_utils(rd_trans_xtn)

//------------------------------------------
// Data Members
//------------------------------------------

bit[7:0] header;
bit[7:0] payload[];
bit[7:0] parity;

bit read_enb = 1'd1;
rand bit[7:0] no_of_cycles;

//Constraints for rand variables
constraint c1{soft no_of_cycles<30;}  //FIFO 30 cycles TIMEOUT CONDITION SIMULATION

//------------------------------------------
// Methods
//------------------------------------------
extern function new(string name = "rd_trans_xtn");
extern function void do_print(uvm_printer printer);

endclass

//-----------------  constructor new method  -------------------//

function rd_trans_xtn:: new(string name = "rd_trans_xtn");
super.new(name);
endfunction


  //-----------------  do_print method  -------------------//

// follow the order : string name ==> bitstream value ==> size ==> radix type

function void rd_trans_xtn::do_print(uvm_printer printer);
super.do_print(printer);
printer.print_field("header", this.header, 8, UVM_DEC);

foreach(payload[i])
printer.print_field($sformatf("payload[%0d]",i), this.payload[i], 8, UVM_DEC);

printer.print_field("parity", this.parity, 8, UVM_DEC);
printer.print_field("no_of_cycles", this.no_of_cycles, 8, UVM_DEC);

endfunction
