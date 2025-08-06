class block_config_seq extends uvm_sequence;
    `uvm_object_utils(block_config_seq)

    bit block_id;   //Optional: for logging (0 = A, 1 = B)

    function new(string name = "block_config_seq");
        super.new(name);
    endfunction

    virtual task body();
        reg_seq_item seq;
        bit [31:0] base_addr;

        //Just for illustration - Block A v/s Block B base address
        base_addr = (block_id == 0) ? 32'h0000_1000 : 32'h0000_2000;

        `uvm_info(get_full_name(), $sformatf("Starting config for Block %s", block_id), UVM_NONE)

        //Write to 5 registers
        foreach(int i[5]) begin
            req = reg_seq_item::type_id::create("req");
            req.addr = base_addr + i * 4;
            req.data = 32'h1000 + i;
            req.read_write = 0;

            start_item(req);
            finish_item(req);
        end

        `uvm_info(get_full_name(), $sformatf("Block %s: Wrote 0x%0h to addr 0x%0h", block_id == 0 ? "A" : "B", req.data, req.addr), UVM_LOW)
        
        
    endtask
endclass