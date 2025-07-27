//==========================================
// Virtual Sequencer
// =========================================
class virtual_sequencer extends uvm_sequencer;
    `uvm_component_utils(virtual_sequencer)

    //Handles to lower level sequencers
    cmd_sequencer  cmd_seqr;
    data_sequencer data_seqr;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

endclass

//============================================
// layered_sequence.sv
//============================================
class layered_sequence extends uvm_sequence;
    `uvm_component_utils(layered_sequence)

    function new(string name = "layered_sequence");
        super.new(name);
    endfunction

    //Declare p_sequencer with the correct type
    virtual_sequencer p_sequencer;

    task body();
       
     //Create sequences for each agent
        cmd_sequence  cmd_seq;
        data_sequence data_seq;

        cmd_seq  = cmd_sequence::type_id::create("cmd_seq");
        data_seq = data_sequence::type_id::create("data_seq");

     //Optional: randomize with constraint
        assert(cmd_seq.randomize());
        assert(data_seq.randomize());

     //Start sequence in parallel or sequentially
        fork
            cmd_seq.start(p_sequencer.cmd_seqr);
            data_seq.start(p_sequencer.data_seqr);
        join
    endtask
endclass

//===============================================
// top_test.sv
//===============================================
class top_test extends uvm_test;
    `uvm_component_utils(top_test)

    virtual_sequencer vseqr;

     function new(string name, uvm_component parent);
        super.new(name, parent);
     endfunction

     function void build_phase(uvm_phase phase);
        super.build_phase(uvm_phase phase);
        vseqr = virtual_sequencer::type_id::create("vseqr", this);
     endfunction

     task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        
        layered_sequence seq = layered_sequence::type_id::create("seq");

        seq.p_sequencer = vseqr;
        seq.start(vseqr);
        
        phase.drop_objection(this);
     endtask

endclass