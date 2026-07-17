# Branch Comparator

The **Branch Comparator** is responsible for evaluating branch conditions in the RV32I processor.

It compares two register operands and determines whether a branch instruction should update the Program Counter or continue sequential execution.

---

# Overview

Branch instructions change the program flow only when a specified comparison evaluates to true.

The Branch Comparator performs this comparison and generates a single control signal:

```text
Branch_Taken_Out
```

This signal is forwarded to the **PC Source MUX**, which selects either:

- PC + 4 (Sequential Execution)
- Branch Target Address

---

# Supported Branch Instructions

| Instruction | Operation |
|-------------|-----------|
| BEQ | Branch if Equal |
| BNE | Branch if Not Equal |
| BLT | Branch if Less Than (Signed) |
| BGE | Branch if Greater or Equal (Signed) |
| BLTU | Branch if Less Than (Unsigned) |
| BGEU | Branch if Greater or Equal (Unsigned) |

---

# Why is it Required?

Every branch instruction must answer one question:

> **Should the processor jump or continue?**

The Branch Comparator performs this decision in hardware.

Without this module, conditional branches could never execute correctly.

---

# Features

- Supports all RV32I conditional branches
- Signed and unsigned comparisons
- Pure combinational logic
- Decoder-controlled operation
- Synthesizable Verilog HDL

---

# Interface

| Signal | Width | Description |
|---------|------:|-------------|
| `RD1_in` | 32 | Register Operand 1 |
| `RD2_in` | 32 | Register Operand 2 |
| `Branch_Type_sel` | 3 | Branch Type (funct3) |
| `Branch_Enable` | 1 | Enables branch evaluation |
| `Branch_Taken_Out` | 1 | Branch decision output |

---

# RTL Operation

## BEQ

```text
RD1 == RD2
```

---

## BNE

```text
RD1 != RD2
```

---

## BLT

```text
Signed(RD1) < Signed(RD2)
```

---

## BGE

```text
Signed(RD1) >= Signed(RD2)
```

---

## BLTU

```text
Unsigned(RD1) < Unsigned(RD2)
```

---

## BGEU

```text
Unsigned(RD1) >= Unsigned(RD2)
```

---

# Verification

Directed test cases were created for every supported branch instruction.

### Verified Operations

- ✅ BEQ
- ✅ BNE
- ✅ BLT
- ✅ BGE
- ✅ BLTU
- ✅ BGEU

Both signed and unsigned comparisons were validated using GTKWave.

---

# Waveform

<p align="center">
<img src="Waveforms/Branch_Comparator.png" width="900">
</p>

The waveform confirms:

- Correct branch comparison
- Proper signed and unsigned evaluation
- Accurate `Branch_Taken_Out` generation
- Correct control signal for PC update

---

# Datapath Position

```text
           Register File
            │         │
            │         │
            ▼         ▼
      ┌────────────────────┐
      │ Branch Comparator  │
      └─────────┬──────────┘
                │
        Branch_Taken
                │
                ▼
          PC Source MUX
                │
                ▼
           Program Counter
```

---

# Project Structure

```text
Branch_Comparator/
│
├── RTL/
│   └── Branch_Comparator.v
│
├── Testbench/
│   └── tb_Branch_Comparator.v
│
├── Waveforms/
│   └── Branch_Comparator.png
│
└── README.md
```

---

# Key Learnings

- Branch Decision Logic
- Signed vs Unsigned Comparisons
- Control Path Design
- Program Counter Control
- Conditional Execution
- RV32I Branch Instructions
- Functional Verification using GTKWave

---

# Next Module

➡️ **Single-Cycle RV32I Processor Integration**

---

### Building a RISC-V Processor Completely from Scratch 🚀
