# Problem 007 – Functional Coverage with Cross and Constraints

## 📝 Problem Statement

You are verifying a memory access interface that operates with three variables:
- `addr`        : 8-bit address field
- `access_type` : enum with values {READ, WRITE}
- `burst_len`   : Integer value between 1 and 8 (inclusive)

Your verification goals include:
1. Randomizing these values for transactions
2. Constraining `burst_len` based on `access_type`
3. Capturing detailed coverage with crosspoints

---

## ✅ Objectives

1. Create a UVM sequence item `mem_txn` with fields:
   - `rand bit [7:0] addr;`
   - `rand access_e access_type;`
   - `rand int burst_len;`

2. Add constraints:
   - If `access_type == WRITE`, then `burst_len` must be 1, 4, or 8
   - If `access_type == READ`, then `burst_len` can be any value 1–8

3. Define a covergroup that:
   - Covers `access_type`, `burst_len`, and `addr`
   - Adds a cross between `access_type` and `burst_len`

---

## 🔍 Requirements
- Use an enum type for `access_type`
- Include a `sample()` method to trigger coverage
- Apply constraints using implication (`->`) or `if`-based logic

---

## 🧠 Bonus
- Create illegal bins for burst_len values that violate the constraints (for observability)
- Track the percentage of WRITE transactions with burst_len == 1

---

## 🎯 Interview Purpose
- Tests constraint coding skills and conditionally bounded value sets
- Assesses ability to define meaningful cross coverage and enforce legal traffic
- Reinforces coverage modeling and observability of corner cases

---

## 🟨 Difficulty
Intermediate – constraint logic + coverage planning
