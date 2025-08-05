class ctrl_status_test extends uvm_test;
    `uvm_component_utils(ctrl_status_test)

    reg_env env; // your enc should contain sequencer + driver

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(uvm_phase phase);
        env = reg_env::type_id::create("env");
    endfunction

    task run_phase(uvm_phase phase);
        ctrl_status_seq seq;
        seq = ctrl_status_seq::type_id::create("seq");

        phase.raise_objection(this);

        seq.ctrl_value = 32'h1234_5678;
        seq.start(sequencer);
        
        phase.drop_objection(this);
        endtask
endclass