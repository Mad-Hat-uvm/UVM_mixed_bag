class top_virtual_sequence extends uvm_sequence;
    `uvm_object_utils(top_virtual_sequence)
    `uvm_declare_psequencer(virtual_sequencer) // Access sub- sequencers

    function new(string name = "top_virtual_sequence");
        super.new(name);
    endfunction

    virtual task body();

        //Create sequences for Block A and Block B
        block_config_seq blockA_cfg = block_config_seq::type_id::create("blockA_cfg");
        block_config_seq blockB_cfg = block_config_seq::type_id::create("blockB_cfg");
        datapath_seq     dp_seq     = datapath_seq::type_id::create("")

        //Set block_id for logging /base addr logic
        blockA_cfg.block_id = 0;
        blockB_cfg.block_id = 1;

        `uvm_info(get_type_name(), "Starting parallel configuration for Block A and Block B", UVM_MEDIUM)

        fork 
            blockA_cfg.start(psequencer.blockA_sequencer);
            blockB_cfg.start(psequencer.blockB_sequencer);
        join  //Wait for both to finish

        `uvm_info(get_type_name(), "Both configs done. Starting datapath sequence.", UVM_MEDIUM)

        dp_seq.start(psequencer.datapath_seqr);

         `uvm_info(get_type_name(), "top_virtual_sequence completed", UVM_MEDIUM)

    endtask

endclass