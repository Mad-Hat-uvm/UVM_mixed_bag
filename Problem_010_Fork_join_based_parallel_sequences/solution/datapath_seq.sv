class datapath_seq extends uvm_sequence;
    `uvm_object_utils(datapath_seq)


    function new(string name = "datapath_seq");
        super.new(name);
    endfunction

    virtual task body();
        reg_seq_item seq;
        bit [31:0] datapath_base = 32'h0000_3000;

       
        `uvm_info(get_full_name(), "Starting datapath transaction"), UVM_NONE)

        //Send 3 data payloads as examples
        foreach(int i[3]) begin
            req = reg_seq_item::type_id::create($sformatf"dp_pkt_%0d", i);
            req.addr = datapath_base + i * 4;
            req.data = 32'hCAFEBABE + i;
            req.read_write = 0;

            start_item(req);
            finish_item(req);
        end

        `uvm_info(get_type_name(),
        $sformatf("Wrote datapath word 0x%0h to 0x%0h", req.data, req.addr),
        UVM_LOW)
        
        
    endtask
endclass