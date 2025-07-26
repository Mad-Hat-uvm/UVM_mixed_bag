//==============================
// priority_packet.sv
//==============================

class priority_packet extends packet;
    `uvm_object_utils(priority_packet)

    rand bit [1:0] priority;  //2-bit priority (0 = low, 3 = high)

    //Constraint: If broadcast, priority must be non-zero
    constraint c_priority{
        (dst_id == 8'hFF) -> (priority != 0);
    }

    function new(string name = "priority_packet");
        super.new(name);
    endfunction

     function string convert2string();
    return $sformatf("src=%0d, dst=%0d, payload=0x%h, priority=%0d", src_id, dst_id, payload, priority);
  endfunction

endclass

//=================================================
// Factory Override Example (in test class or env)
// ================================================

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_factory::get().set_type_override_by_type(packet::get_type(), priority_packet::get_type();)
endfunction
