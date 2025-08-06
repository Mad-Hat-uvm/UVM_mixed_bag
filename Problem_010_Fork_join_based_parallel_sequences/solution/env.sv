//Only the code snippet for hooking up the virtual sequencer in the environment
class env extends uvm_component;

    virtual_sequencer virt_seqr;

   function void build_phase(uvm_phase phase);
    super.build_phase(uvm_phase phase);
    virt_seqr = virtual_sequencer::type_id::create("virt_seqr");

    //Connect the sub-sequencers
    virt_seqr.blockA_sequencer = blockA_agent.sequencer;
    virt_seqr.blockB_sequencer = blockB_agent.sequencer;
    virt_seqr.datapath_seqr    = datapath_agent.sequencer;
   endfunction


endclass
