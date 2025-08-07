class irq_monitor extends uvm_monitor;
    `uvm_component_utils(irq_monitor)

    //Virtual interface to AXI signals(user - defined)
    virtual irq_if vif;

  typedef struct{
    bit [7:0] irq_req;
    bit [2:0] irq_id;
    bit       valid;
  } irq_txn;

  uvm_analysis_port #(irq_txn) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db#(virtual perfmon_if)::get(this, "", "vif", vif))
        `uvm_fatal("PERFMON_MON", "No virtual interface set for irq_monitor")
    endfunction

    task run_phase(uvm_phase phase);
        irq_txn tx;
        forever @(posedge vif.clk) begin
           //Assuming synchronous capture
            tx.irq_req = vif.irq_req;
            tx.irq_id  = vif.irq_id;
            tx.valid   = vif.valid;
          
        `uvm_info(get_type_name(), $sformatf("Monitor observed count = %0d", observed_count),UVM_LOW)
             end
          
    endtask
endclass

interface irq_if(input logic clk);
  logic [7:0] irq_req;
  logic [2:0] irq_id;
  logic       valid;
endinterface
