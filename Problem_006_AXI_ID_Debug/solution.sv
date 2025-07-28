//==============================================
// axi_monitor.sv
//==============================================
class axi_monitor extends uvm_monitor;
    `uvm_component_utils(axi_monitor)

    //Virtual interface to AXI signals(user - defined)
    virtual axi_if vif;

    //Analysis port to send rid + arid checks
    uvm_analysis_port #(bit [7:0]) arid_ap;
    uvm_analysis_port #(bit [7:0]) rid_ap;

    //Associative array: maps arid to 1 if seen
    bit outstanding_ids[bit [7:0]];

    function new(string name, uvm_component parent);
        super.new(name, parent);
        arid_ap = new("arid_ap", this);
        rid_ap = new("rid_ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db#(virtual axi_if)::get(this, "", "vif", vif))
        `uvm_fatal("AXI_MON", "No virtual interface set for axi_monitor")
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            @(posedge vif.clk);

            //------------- Capture read address (AR)------
            if (vif.arvalid && vif.arready) begin
               arid_ap.write(vif.arid);
                `uvm_info("AXI_MON", $sformatf("ARID seen: %0d", vif.arid ), UVM_LOW); 
             end


            //Capture R channel
            if(vif.rvalid && vif.rready) begin
                 rid_ap.write(vif.rid);
                    `uvm_info("AXI_MON", $sformatf("RID matched: %0d", rid), UVM_LOW);
                  
                end
            end
    endtask
endclass

//==========================================================
// axi_scoreboard.sv
//==========================================================
class axi_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(axi_scoreboard)


    //Analysis imports
    uvm_analysis_imp #(bit [7:0], axi_scoreboard) arid_impp;
    uvm_analysis_imp #(bit [7:0], axi_scoreboard) rid_imp;

    //Associative array: maps arid to 1 if seen
    bit outstanding_ids[bit [7:0]];

    function new(string name, uvm_component parent);
        super.new(name, parent);
        arid_imp = new("arid_imp", this);
        rid_imp = new("rid_imp", this);
    endfunction

function void write_arid(bit [7:0] id)
    outstanding_ids[id] = 1;
                `uvm_info("SB", $sformatf("ARID recorded: %0d", vif.arid ), UVM_LOW); 
endfunction
    
function void write_rid(bit[7:0] rid);
         if(!outstanding_ids.exists(rid)) begin
                     `uvm_error("SB", $sformatf("RID %0d has no matching ARID!", rid));
         end else begin
            `uvm_info("SB", $sformatf("RID matched: %0d", rid), UVM_LOW);
             outstanding_ids.delete[rid];  //Remove after match
        end
endfunction
    
endclass

// =========================================
// Hook up in the environment connect phase
// =========================================
monitor.arid_ap.connect(axi_scoreboard.arid_imp);
monitor.rid_ap.connect(axi_scoreboard.rid_imp);