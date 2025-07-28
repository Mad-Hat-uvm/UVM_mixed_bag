//=========================================================
// stream_if.sv
//=========================================================
interface stream_if #(parameter int N = 4) (
    input logic clk;
    input logic rst_n;
);

logic valid;
logic [7:0] data[N];

//clcoking block
clocking cb @(posedge clk);
    default input #1step output #1step;
    output valid, data;
endclocking

//Modports
modport drv (input clk, input rst_n, output valid, output data, clocking cb);
modport mon (input clk, input rst_n, input valid,  input data,  clocking cb);

endinterface

//=============================================================
// stream_agent.sv
//=============================================================
typedef enum {ACTIVE, PASSIVE} agent_mode_e;

class stream_agent extends uvm_agent;
    `uvm_component_utils(stream_agent)

    //Mode and virtual interface
    agent_mode_e mode;
    virtual stream_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        //Get mode and raw interface
         if(!uvm_config_db#(agent_mode_e)::get(this, "", "mode", mode)) 
         `uvm_fatal(get_full_name(), "No mode found")

        if(!uvm_config_db#(virtual stream_if#(4))::get(this, "", "vif", vif)) 
         `uvm_fatal(get_full_name(), "STREAM_VIF not found")

        //Type - checking modport at runtime
        case (mode)
            ACTIVE: begin
                virtual stream_if#(4)::drv vif_drv;
                $cast(vif_drv, vif);
                if(!vif_drv)
                `uvm_fatal("MODPORT", "Could not cast to drv modport")
        `uvm_info(get_type_name(), "Agent running in ACTIVE mode", UVM_LOW)
        // Connect to driver here
            end

            PASSIVE: begin
                virtual stream_if#(4)::mon vif_mon;
                $cast(vif_mon, vif);
                if(!vif_mon)
                `uvm_fatal("MODPORT", "Could not cast to mon modport")
        `uvm_info(get_type_name(), "Agent running in PASSIVE mode", UVM_LOW)
        // Connect to driver here
            end
        endcase
    endfunction

endclass

//=============================================
// tb_top.sv
//=============================================
module tb_top;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    logic clk = 0;
    logic rst_n;

    //Two interface instances
    stream_if #(4) if0(clk, rst_n);
    stream_if #(4) if1(clk, rst_n);

    always #5 clk = ~clk;

    initial begin
        rst_n = 0;
        #20 rst_n = 1;

         //Set global config 
         uvm_config_db#(virtual stream_if#(4))::set(null, "*", "if0", if0 );
         uvm_config_db#(virtual stream_if#(4))::set(null, "*", "if1", if1 );

        run_test("top_test");
    end

endmodule

//==============================================
//top_test.sv
//==============================================
class top_test extends uvm_test;
    `uvm_component_utils(top_test)

    stream_env env;

     function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

     function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        env = stream_env::type_id::create("env", this);

       //Retrieve the interface handles
        if(!uvm_config_db::(virtual stream_if#(4))::get(this, "", "if0", if0))
        `uvm_fatal("IF0_MISSING", "if0 not found in config_db")

         if(!uvm_config_db::(virtual stream_if#(4))::get(this, "", "if1", if1))
        `uvm_fatal("IF0_MISSING", "if1 not found in config_db")

      //Assign interfaces to agents
         uvm_config_db#(virtual stream_if#(4))::set(this, "env.agent0", "vif", if0);
         uvm_config_db#(virtual stream_if#(4))::set(this, "env.agent1", "vif", if1);

      //Set agent mode(ACTIVE / PASSIVE)
         uvm_config_db#(agent_mode_e)::set(this, "env.agent0", "mode", ACTIVE);
         uvm_config_db#(agent_mode_e)::set(this, "env.agent1", "mode", PASSIVE);
     endfunction
endclass