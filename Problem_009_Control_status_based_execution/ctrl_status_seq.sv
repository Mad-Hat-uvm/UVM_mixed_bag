class ctrl_status_seq extends uvm_sequence #(reg_seq_item);
    `uvm_component_utils(ctrl_status_seq)

    rand bit [31:0] ctrl_value;

    //Register addresses (hardcoded for now)
    localparam bit [31:0] CTRL_REG_ADDR   = 32'h0000_0000;
    localparam bit [31:0] STATUS_REG_ADDR = 32'h0000_0004;

    function new(string name = "ctrl_status_seq");
        super.new(name);
    endfunction

    virtual task body();
        reg_seq_item req;
        bit [31:0] status;
        int max_poll = 100;

        `uvm_info(get_full_name(), "Starting control-status sequence", UVM_MEDIUM)

        //STEP 1: WRITE TO CONTROL REGISTER
        req = reg_seq_item::type_id::create("ctrl_write");
        req.addr    = CTRL_REG_ADDR;
        req.data    = ctrl_value;
        req.read_write = 0;  // write
        start_item(req);
        finish_item(req);
        `uvm_info(get_full_name(), $sformatf("Wrote 0x0%h to CTRL_REG", ctrl_value), UVM_MEDIUM)

        //Step 2: Poll Status Register
        int poll_count = 0;
        do begin
            req = reg_seq_item::type_id::create("status_req");
            req.addr = STATUS_REG_ADDR;
            req.read_write = 1; // read

            start_item(req);
            finish_item(req);

            status = req.data;

            `uvm_info(get_full_name(), $sformatf("Read 0x0%h from STATUS_REG", status), UVM_MEDIUM)
            poll_count++;

            if(poll_count >= max_poll) begin
                `uvm_error(get_full_name(), "Polling STATUS_REG timed out!")
                return;
            end

        end while (status[0] == 0);
            
        //Step 3: Proceed with Datapath transaction
        req = reg_seq_item::type_id::create("data_path_write");
        req.addr    = 32'h0000_0008;  //Example datapath address
        req.data    = 32'hDEAD_BEEF;
        req.read_write = 0;  // write
        start_item(req);
        finish_item(req);
        
        `uvm_info(get_full_name(), "Datapath transaction completed", UVM_MEDIUM)
        
    endtask
endclass