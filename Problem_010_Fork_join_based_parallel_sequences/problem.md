# Problem 010 – Fork-Join Based Parallel Sequences Using a Virtual Sequencer

## 📝 Problem Statement

Design a UVM virtual sequence that performs the following tasks **in parallel**:

1. Configures **Block A** by writing 5 control registers.
2. Configures **Block B** by writing 5 control registers.
3. After both configurations are done, initiates a **datapath traffic sequence**.

---

## 🧠 Objective

Demonstrate the use of `fork...join` to launch **independent sequences in parallel** using a **virtual sequencer** and `uvm_do_on` / `start()`.

---

## 🧩 Assumptions

- Each block has its own agent and sequencer:
  - `blockA_seqr`
  - `blockB_seqr`
- A datapath sequencer (`datapath_seqr`) is available for traffic after config.
- The virtual sequencer connects all three sub-sequencers.
- Basic configuration sequences (`block_config_seq`) and a datapath sequence (`datapath_seq`) already exist.

---

## ✅ Requirements

- Use `fork...join` to run Block A and B config in parallel.
- Ensure datapath traffic starts **only after both config sequences complete**.
- Code must be UVM-compliant and extend `uvm_sequence`.

---

## 📌 Deliverables

- `virtual_sequencer.sv`: containing handles to all 3 sub-sequencers
- `top_virtual_sequence.sv`: that performs forked config + post-join datapath
- `block_config_seq.sv`: basic configurable sequence with 5 register writes
- `datapath_seq.sv`: dummy datapath write sequence

---

## 🔗 Tags

`uvm_sequence`, `virtual_sequence`, `virtual_sequencer`, `fork_join`, `uvm_do_on`, `parallel_execution`, `config_sequence`, `synchronization`
