# ===================================================
# Problem 002 – Scoreboard with Golden Model for MAC
# ===================================================

## 📝 Problem Statement:
 You are verifying a streaming MAC (Multiply-Accumulate) unit.
 On each clock cycle, the DUT receives inputs:
   - a: signed 8-bit
   - b: signed 8-bit
   - acc_in: signed 16-bit
 And produces output:
   - acc_out = a * b + acc_in (delayed by one cycle)

## ✅ Objectives:
 1. Create a transaction class `mac_txn` with:
    - rand bit signed [7:0] a, b;
    - rand bit signed [15:0] acc_in;
    - bit signed [15:0] acc_out;
 2. Create a UVM scoreboard `mac_scoreboard` that:
    - Implements `uvm_analysis_imp#(mac_txn, mac_scoreboard)`
    - Recalculates `a*b + acc_in` as golden model
    - Compares it to `acc_out`
    - Reports mismatches using `uvm_error`

## 🔍 Requirements:
 - Use `write()` method to receive incoming transactions
 - Scoreboard must be reusable
 - Include convert2string() or logs for debug visibility

## 🧠 Bonus:
 - Queue incoming transactions to support one-cycle delay alignment
 - Use golden model function for clean comparison

## 🎯 Interview Purpose:
 - Tests understanding of reference modeling, scoreboard reuse, and transaction checking
 - Practical for MACs, ALUs, and DSP block testing

## 🟧 Difficulty: Intermediate
