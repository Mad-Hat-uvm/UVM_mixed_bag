# Problem 009 – Reusable UVM Agent with Configurable Interface via uvm_config_db

## 📝 Problem Statement

You are verifying a DUT that has multiple identical interfaces, for example:
- `stream_if` for `agent0` (uses modport `drv`)
- `stream_if` for `agent1` (uses modport `mon`)

Each agent instance must:
- Connect to the correct virtual interface + modport
- Use a shared, reusable UVM agent class
- Be configured dynamically from the environment or test

Your goal is to build a reusable agent structure that can work for any named instance.

---

## ✅ Objectives

1. Create a parameterized interface `stream_if` with modports `drv`, `mon`
2. In the environment:
   - Instantiate two (or more) agent instances with unique names (`agent0`, `agent1`)
   - Use `uvm_config_db#(virtual stream_if)::set(...)` to assign each interface

3. In the agent:
   - Use `uvm_config_db::get(...)` in `build_phase()` to fetch the interface
   - Use that interface for driver/monitor binding

---

## 🔍 Requirements
- Interface must be declared with modports
- Interface must be type-cast in testbench to modport before passing
- Use hierarchical path strings (e.g. "env.agent0", "env.agent1") for config_db

---

## 🧠 Bonus
- Support reuse for 4 or more agents
- Add a config object that holds "is_active" or "mode" (ACTIVE/PASSIVE)

---

## 🎯 Interview Purpose
- Tests your UVM layering and modularity skills
- Demonstrates correct use of virtual interfaces and `uvm_config_db`
- Validates how you scale UVM environments cleanly and flexibly

---

## 🟨 Difficulty
Intermediate to Advanced – key skill for system-level reuse and integration