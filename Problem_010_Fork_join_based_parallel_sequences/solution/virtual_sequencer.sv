class virtual_sequencer extends uvm_sequencer;
    `uvm_component_utils(virtual_sequencer)

    //Sub-sequencers
    reg_sequencer blockA_sequencer;
    reg_sequencer blockB_sequencer;
    reg_sequencer datapath_seqr;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
endclass