# Problem 013 – SoC Interrupt Priority Encoder RTL

## 📝 Problem Statement

You are designing a block within an SoC that handles **interrupt requests** from up to 8 peripherals.

Design a **3-bit fixed-priority encoder** that:
- Accepts an 8-bit input `irq_req[7:0]`, where each bit represents an interrupt request
- Outputs a 3-bit `irq_id[2:0]` indicating the index of the **highest-priority active interrupt**
- Uses fixed priority: `irq_req[7]` is highest, `irq_req[0]` is lowest
- Also outputs a `valid` signal:
  - `valid = 1` if **any** interrupt is active
  - `valid = 0` if **no** interrupt is active
- If multiple requests are active, only the **highest** is reflected in `irq_id`

---

## ✅ Inputs and Outputs

| Signal     | Direction | Width | Description                                      |
|------------|-----------|-------|--------------------------------------------------|
| `irq_req`  | input     | 8     | Interrupt request lines from peripherals         |
| `irq_id`   | output    | 3     | Encoded ID of highest-priority active interrupt  |
| `valid`    | output    | 1     | High when any interrupt is pending               |

---

## 🧠 Real-World Relevance

This logic is typically part of:
- Interrupt controllers (CLINT, PLIC, GIC)
- Arbitration systems in DMA or bus fabric
- CPU pipeline control for exceptions

---

## ✅ Constraints

- Priorities are **fixed**, not programmable
- Design must be **synthesizable**
- Should handle the **no-active-interrupt** case cleanly (set `valid=0`)

---

## 🔗 Tags

`rtl_encoder`, `interrupt_controller`, `priority_logic`, `soc_block`, `irq`, `problem013`, `fixed_priority`, `rtl_design`
