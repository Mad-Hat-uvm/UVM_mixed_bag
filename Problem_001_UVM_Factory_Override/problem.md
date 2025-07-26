// ===============================
// Problem 001 – UVM Factory Override with Priority Packet
// ===============================

// 📝 Problem Statement
// You are verifying a network-on-chip (NoC) router using UVM. The existing testbench uses a base transaction:

class packet extends uvm_sequence_item;
  rand bit [7:0] src_id, dst_id;
  rand bit [15:0] payload;
  `uvm_object_utils(packet)

  function new(string name = "packet");
    super.new(name);
  endfunction
endclass

// Your task is to extend this setup by introducing packet prioritization — without modifying any existing agent or sequence code.

// ✅ Objectives:
// 1. Create a new class `priority_packet` that:
//    - Inherits from `packet`
//    - Adds a new field: `rand bit [1:0] priority`
//    - Registers using `uvm_object_utils(priority_packet)`
//    - Enforces the following constraint:
//        If `dst_id == 8'hFF` (broadcast), then `priority != 0`

// 2. In your test or environment, use the UVM factory to override `packet` with `priority_packet` at runtime:

//     factory.set_type_override_by_type(packet::get_type(), priority_packet::get_type());

// 🔍 Constraints Logic:
// - `priority` can be 0, 1, 2, or 3 (default)
// - If `dst_id == 255`, `priority` must not be 0
// - For unicast packets, `priority` can be any value

// 🎯 Deliverables:
// - `priority_packet.sv` class
// - Demonstrate override with a small snippet in `build_phase()`
// - Optional: call `.convert2string()` or log the transaction during simulation

// 🧠 Interview Purpose
// This problem tests:
// - Knowledge of UVM factory mechanism
// - Class inheritance and constraint layering
// - Non-intrusive testbench extension — critical in scalable DV environments

// 🟧 Difficulty: Intermediate to Advanced
