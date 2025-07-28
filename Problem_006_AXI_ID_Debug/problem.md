# Problem 008 – AXI Read ID Mismatch Debug

## 📝 Problem Statement

You are monitoring an AXI4 interface and encounter a protocol violation:
- A `read response` (R channel) arrives with `rid = 2`
- But no prior `read address` (AR channel) with `arid = 2` was seen

As a senior verification engineer, you're tasked with detecting and reporting this issue inside a UVM testbench.

---

## ✅ Objectives

1. Build a simple UVM monitor that:
   - Observes `arid` on the AR channel
   - Observes `rid` on the R channel
   - Tracks active IDs (outstanding reads)

2. Add logic to:
   - Store observed `arid` values in a dynamic queue or associative array
   - On receiving `rid`, check if it was expected
   - If `rid` is missing, report a UVM_ERROR

3. Create a lightweight scoreboard or checker that logs the error:
   - "Unexpected read response with rid = X"
   - Or: "Duplicate rid = X"

---

## 🔍 Requirements
- Use `uvm_monitor` or a self-contained class with AR and R channel hooks
- Track and remove IDs once response is received (FIFO or associative model)
- Output errors using `uvm_error`

---

## 🧠 Bonus
- Add tracking for response latency per ID
- Add support for `rlast` and burst response correlation

---

## 🎯 Interview Purpose
- Tests debugging mindset and real-world triage capability
- Evaluates associative array usage and protocol tracking logic
- Demonstrates scoreboard independence from DUT

---

## 🟧 Difficulty
Intermediate to Advanced – real-world debugging and state modeling
