//=======================================
// mem_txn.sv
//=======================================
typedef enum {READ, WRITE} access_e;

class mem_txn extends uvm_sequence_item;
   `uvm_object_utils(mem_txn)

    rand bit [7:0] addr;
    rand access_e access_type;
    rand int burst_len;

    function new(string name = "mem_txn");
        super.new(name);
        cov = new();
    endfunction

    //Constraint: burst_len depends on access_type
    constraint c_access_constraints{
        if(access_type == WRITE)
         burst_len inside {1, 4, 8};
        else
         burst_len inside {[1:8]};
      }

    //Covergroup with cross
      covergroup cov;
        addr_cp:       coverpoint addr {bins addr_vals[] = {[0:255]}; }
        access_cp:     coverpoint access_type {bins all = {READ, WRITE}; }
        burst_len_cp:  coverpoint burst_len {bins length[] = {[1:8]}; }

        cross access_cp, burst_len_cp;

    //Optional: burst_len == 1 with access_type = WRITE
       wr_len1_cp:     coverpoint burst_len iff (access_type == WRITE) {bins wr_len1 = {1};
    } 
    //Optional illegal bin
        burst_len_cp_illegal: coverpoint burst_len{
            illegal_bins bad_wr_len = burst_len with ((access_type == WRITE) && !(burst_len inside {1, 4, 8}));
        }
      endgroup

    //Coverage sampling
      function void sample();
        cov.sample();
      endfunction

    function string convert2string();
    return $sformatf("addr=0x%0h, access=%s, burst_len=%0d", addr, access_type.name(), burst_len);
  endfunction

endclass