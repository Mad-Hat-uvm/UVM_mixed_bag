// ====================================
// mac_txn.sv
// ====================================

class mac_txn extends uvm_sequence_item;
    `uvm_object_utils(mac_txn)

    rand bit signed [7:0]  a;
    rand bit signed [7:0]  b;
    rand bit signed [15:0] acc_in;
         bit signed [15:0] acc_out;

    function new(string name = "mac_txn");
        super.new(name);
    endfunction

    function string convert2string();
    return $sformatf("a=%0d, b=%0d, acc_in=%0d, acc_out=%0d", a, b, acc_in, acc_out);
  endfunction

endclass

//======================================
// mac_scoreboard.sv
//======================================

class mac_scoreboard extends uvm_component;
    `uvm_component_utils(mac_scoreboard)

    uvm_analysis_imp #(mac_txn, mac_scoreboard) analysis_export;

    //Queue to handle 1-cycle delay of DUT
    bit signed [15:0] expect_q[$];

    function new(string name, uvm_component parent);
        super.new(name, parent);
        analysis_export = new("analysis_export", this);
    endfunction

    //Golden model function
    function bit signed [15:0] golden_model(mac_txn tr);
        return tr.a * tr.b + tr.acc_in;
    endfunction

    //Write method: receives monitored transactions
    function void write(mac_txn tr);
        //Compute and push expected result for future comparison
        bit signed [15:0] expected = golden_model(tr);
        expect_q.push_back(expected);

        //Only compare when enough delay has passed (1 - cycle delay)
        if(expect_q.size() > 1) begin
            bit signed [15:0] ref = expect_q.pop_front(); //expected result from 1 cycle ago

            if(tr.acc_out != ref) begin
                 `uvm_error(get_type_name(),
          $sformatf("Mismatch: expected=%0d, got=%0d | txn: %s", ref, tr.acc_out, tr.convert2string()))
            end else begin
             `uvm_info(get_type_name(),
          $sformatf("Match: acc_out=%0d is correct | txn: %s", tr.acc_out, tr.convert2string()), UVM_LOW)
            end

        end
    endfunction
endclass