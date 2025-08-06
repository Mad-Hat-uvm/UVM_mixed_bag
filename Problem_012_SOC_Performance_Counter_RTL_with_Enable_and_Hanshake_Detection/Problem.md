# Problem 012 – SoC Performance Counter RTL with Enable and Handshake Detection

## 📝 Problem Statement

You are verifying a **performance monitoring block** inside an SoC.  
One of the internal modules counts how many **successful transactions** occurred on an internal bus.

Design the RTL for a **4-bit synchronous counter** with the following behavior:

### ✅ Counter Requirements
- Increments **only when `enable` is high AND a `valid & ready` handshake occurs**
- Synchronous, active-high reset
- Wraps from 15 back to 0 (i.e., modulo-16)
- Output: `count[3:0]`

---

## 📦 Input/Output Ports

| Signal   | Direction | Width | Description                             |
|----------|-----------|--------|-----------------------------------------|
| `clk`    | input     | 1      | Clock input                             |
| `reset`  | input     | 1      | Synchronous active-high reset           |
| `enable` | input     | 1      | Enables counting                        |
| `valid`  | input     | 1      | Transaction is valid                    |
| `ready`  | input     | 1      | Receiver is ready                       |
| `count`  | output    | 4      | Current 4-bit transaction count         |

---

## 🧠 Design Goals

- Ensure counter increments only on real handshakes (`valid && ready`)
- Allow `enable` gating to control whether counting is active
- Use **synthesizable** SystemVerilog or Verilog
- Wrap counter value after 15 back to 0

---

## 🔍 Related Concepts

- `always_ff` usage for sequential logic
- Clock/reset safety
- Wrap-around counters in hardware
- Performance counters inside SoC IP blocks

---

## 🔗 Tags

`rtl_counter`, `soc_block`, `valid_ready_handshake`, `synchronous_reset`, `uvm_monitor_reference`, `wraparound_counter`, `problem012`
