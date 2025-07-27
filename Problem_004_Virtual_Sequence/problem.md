# Problem 004 – Virtual Sequence for Multi-Agent Coordination

## 📝 Problem Statement

You are verifying a DUT that accepts inputs from two independent interfaces:
- A **command stream** (e.g., opcodes or control signals)
- A **data stream** (e.g., operands or data payloads)

Each interface has its own UVM agent with:
- A dedicated `uvm_sequencer` and `uvm_sequence_item`
- Transaction classes: `cmd_txn` and `data_txn`

Your test must:
- Coordinate activity across both agents
- Use a **virtual sequencer** that holds handles to both lower-level sequencers
- Implement a **virtual sequence** that drives both agents in parallel or order

---

## ✅ Objectives

1. Define a virtual sequencer:
   - `virtual_sequencer` with:
     - `cmd_sequencer` (handle to sequencer for command agent)
     - `data_sequencer` (handle to sequencer for data agent)

2. Define a virtual sequence:
   - `layered_sequence` that:
     - Randomizes or configures a series of `cmd_sequence` and `data_sequence`
     - Starts them via `start(cmd_seqr)` and `start(data_seqr)`

3. Launch the virtual sequence from your test’s `run_phase`

---

## 🔍 Requirements
- Use `uvm_do_on()` or `.start()` calls
- `layered_sequence` must extend `uvm_sequence` and be parameterized with `uvm_sequence_item`
- Virtual sequencer must extend `uvm_sequencer_base`

---

## 🧠 Bonus
- Add configurable delay between command and data stream launches
- Randomize both sequences using local knobs

---

## 🎯 Interview Purpose
- Tests understanding of virtual sequencer architecture in UVM
- Demonstrates how to coordinate multiple protocol streams
- Encourages scalable test design with layered sequences

---

## 🟨 Difficulty
Intermediate to Advanced – requires UVM sequencing, virtual handles, and test-layer control
