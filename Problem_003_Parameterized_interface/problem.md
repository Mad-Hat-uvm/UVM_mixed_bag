# Problem 005 – Parameterized Interface for UVM Reuse

## 📝 Problem Statement

You are building a reusable UVM testbench for a streaming datapath. The DUT interface includes:
- A vector of signed 8-bit data elements
- A `valid` signal to indicate when input is active

The number of data elements (`N`) should be configurable (e.g., 4, 8, 16) without changing the interface structure.

---

## ✅ Objectives

1. Create a **SystemVerilog interface** named `stream_if` with parameter `N`
2. The interface should include:
   - `bit signed [7:0] data [N]`   // unpacked array of 8-bit elements
   - `bit valid`                   // control signal
3. Add a **clocking block** named `cb` to encapsulate all signals
4. Define a **modport** that can be used by both the UVM driver and monitor
5. Ensure the interface is compatible with both module-level and subsystem-level reuse

---

## 🔍 Requirements
- Use parameter `N` to define data bus width
- Use a clock and optional reset inside the interface
- UVM driver should be able to use `stream_if.cb.data` and `cb.valid`
- Write the interface to be future-proof for multi-agent environments

---

## 🎯 Interview Purpose
- Tests ability to write parameterized, reusable interfaces
- Evaluates understanding of clocking blocks, modports, and UVM component integration
- Ensures clarity in UVM-to-DUT connection modeling

---

## 🟨 Difficulty
Intermediate – requires understanding of clocking blocks, unpacked arrays, and modport design
