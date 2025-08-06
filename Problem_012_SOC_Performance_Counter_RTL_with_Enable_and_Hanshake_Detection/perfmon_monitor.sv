class perfmon_monitor extends uvm_monitor;
    `uvm_component_utils(perfmon_monitor)

    //Virtual interface to AXI signals(user - defined)
    virtual perfmon_if vif;

   int observed_count;

    function new(string name, uvm_component parent);
        super.new(name, parent);
       observed_count = 0;
    endfunction

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db#(virtual perfmon_if)::get(this, "", "vif", vif))
        `uvm_fatal("PERFMON_MON", "No virtual interface set for perfmon_monitor")
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            @(posedge vif.clk);
            if(vif.reset)
            observed_count = 0;

            else if (vif.enable && vif.valid && vif.ready) begin
               observed_count++

              `uvm_info(get_type_name(),
        $sformatf("Monitor observed count = %0d", observed_count),
        UVM_LOW)
             end

            end
          
    endtask
endclass
