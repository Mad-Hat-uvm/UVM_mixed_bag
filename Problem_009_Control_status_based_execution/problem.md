# Problem 009 – Control-Status-Based Sequence Execution

## 📝 Problem Statement

Write a UVM sequence that:

1. Programs a control register at address `CTRL_REG_ADDR` with a given `ctrl_value`.
2. Polls a status register at address `STATUS_REG_ADDR` until a specific `ready` bit is set (bit 0 = 1).
3. Once status indicates ready, initiates a datapath transaction (e.g., sending a command/data pair to the DUT).

---

## 💡 Concept

Polling is the act of continuously checking a condition — in this case, reading a status register in a loop until the DUT indicates it is ready. This is commonly used when waiting for hardware to complete an operation or reach a known state.

---

## 🧩 Assumptions

- There exists a sequence item class `reg_seq_item` with fields: `addr`, `data`, and `read_write`.
- The DUT uses memory-mapped registers.
- A sequencer is already connected to a bus agent that can handle the `reg_seq_item`.
- The sequence will be responsible for writing the control register, polling the status, and finally performing a datapath write.

---

## ✅ Deliverables

- A UVM sequence class that performs the above flow
- Proper use of `start_item`, `randomize`, and `finish_item`
- Optional: timeout handling while polling the status register

---

## 📦 Extensions (Optional)

- Parameterize the `ready_bit_mask`
- Add coverage hooks for control and datapath transactions
- Add timeout watchdog or assertion failure on polling limit

---

## 🔗 Tags

`uvm_sequence`, `register_programming`, `polling`, `status_bit`, `uvm`
