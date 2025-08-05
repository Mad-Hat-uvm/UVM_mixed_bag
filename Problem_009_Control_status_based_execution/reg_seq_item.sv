class reg_seq_item extends uvm_seq_item;
    `uvm_object_utils(reg_seq_item)

    rand bit [31:0] addr;
    rand bit [31:0] data;
    rand bit        read_write;  //0 = write, 1 = read

    function new(string name = "reg_seq_item");
        super.new(name);
    endfunction

    function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field_int("addr", addr, 32);
    printer.print_field_int("data", data, 32);
    printer.print_field_int("read_write", read_write, 1);
  endfunction
    
 
endclass