<div align="center">

# 🚀 Single-Cycle RV32I RISC-V Processor

### A Modular Verilog Implementation of the Base RV32I ISA

<p>

![Verilog](https://img.shields.io/badge/Language-Verilog-blue?style=for-the-badge)
![ISA](https://img.shields.io/badge/ISA-RV32I-success?style=for-the-badge)
![Processor](https://img.shields.io/badge/CPU-Single--Cycle-orange?style=for-the-badge)
![Verification](https://img.shields.io/badge/Verification-Self--Checking-brightgreen?style=for-the-badge)
![Simulator](https://img.shields.io/badge/Simulator-Verilator-red?style=for-the-badge)
![Waveforms](https://img.shields.io/badge/Waveforms-GTKWave-purple?style=for-the-badge)

</p>

*A complete 32-bit RV32I processor built in Verilog HDL and verified using directed assembly programs with a self-checking testbench.*

</div>

---

# 📖 Project Overview

This project implements a **32-bit Single-Cycle RV32I Processor** following a modular RTL design methodology.

Each hardware block was designed, verified, and tested independently before integrating the complete processor.

The processor executes every instruction in a **single clock cycle**, supporting arithmetic, logical, memory, branch, jump, and upper-immediate instructions.

> 🎯 **Next Goal:** Extend this design into a **5-Stage Pipelined RV32I Processor** with forwarding, hazard detection, stalls, and flush logic.

---

# 🏗️ Processor Architecture

> **📷 Replace this with your complete datapath image**

<p align="center">
<img src="Images/SingleCycle_Datapath.png" width="900">
</p>

---

# ✨ Features

### Processor

- ✅ RV32I Base ISA
- ✅ 32-bit Single-Cycle Datapath
- ✅ Modular RTL Design
- ✅ Harvard Architecture
- ✅ 32 × 32-bit Register File
- ✅ Branch & Jump Support
- ✅ Load / Store Support
- ✅ Immediate Generator
- ✅ Write-Back Multiplexer

### Verification

- ✅ Directed Assembly Programs
- ✅ Self-Checking Testbench
- ✅ Automatic PASS / FAIL Results
- ✅ Verilator Simulation
- ✅ GTKWave Waveforms

---

# 🧩 RTL Modules

| Module | Function |
|---------|----------|
| Program Counter | Maintains current instruction address |
| PC Source MUX | Selects next program counter |
| Instruction Memory | Fetches instructions |
| Decoder | Generates processor control signals |
| Register File | Stores 32 general-purpose registers |
| ALU Source MUX | Selects ALU operand |
| ALU | Arithmetic & logical operations |
| Immediate Generator | Generates I/S/B/U/J immediates |
| Immediate Adder | Computes branch & jump targets |
| Branch Comparator | Evaluates branch conditions |
| Store Unit | Generates store data & write mask |
| Data Memory | Memory read/write operations |
| Load Unit | Sign/Zero extension for loads |
| Write-Back MUX | Selects register write-back data |

---

# 📚 Supported RV32I Instructions

| Category | Instructions |
|----------|--------------|
| Arithmetic | ADD, ADDI, SUB |
| Logic | AND, ANDI, OR, ORI, XOR, XORI |
| Shift | SLL, SLLI, SRL, SRLI, SRA, SRAI |
| Comparison | SLT, SLTI, SLTU, SLTIU |
| Memory | LB, LH, LW, LBU, LHU, SB, SH, SW |
| Branch | BEQ, BNE, BLT, BGE, BLTU, BGEU |
| Jump | JAL, JALR |
| Upper Immediate | LUI, AUIPC |

---

# 🧪 Verification Methodology

Every instruction group is verified using dedicated assembly test programs.

```
Assembly Program
       │
       ▼
 GNU RISC-V Toolchain
       │
       ▼
     HEX File
       │
       ▼
 Instruction Memory
       │
       ▼
 Single-Cycle CPU
       │
       ▼
 Self-Checking Testbench
       │
       ▼
     PASS / FAIL
```

---

# 📂 Test Programs

| Test Program | Instructions Covered | Status |
|--------------|----------------------|--------|
| `program_alu.s` | ALU, Load/Store, LUI, AUIPC | ✅ PASS |
| `program_branch.s` | BEQ, BNE, BLT, BGE, BLTU, BGEU | ✅ PASS |
| `program_jump_system.s` | JAL, JALR, ECALL, EBREAK | ✅ PASS |
| `program_isa_coverage.s` | Additional ISA Verification | ✅ PASS |

---

# 📊 Verification Summary

| Metric | Result |
|---------|--------|
| RTL Modules | 14+ |
| Assembly Programs | 4 |
| Self-Checking Assertions | 53 |
| ISA Coverage | RV32I |
| Simulation | Verilator |
| Waveforms | GTKWave |
| Result | ✅ All Tests Passed |

---

# 🖼️ Results

## 🏗️ Processor Datapath

> *(Insert architecture image)*

---

## ✅ Verilator Output

> *(Insert simulation PASS screenshot)*

---

## 📈 GTKWave Verification

> *(Insert waveform screenshot)*

---

## 📝 Final Register Verification

> *(Insert register dump screenshot)*

---

# 📁 Repository Structure

```text
Single_Cycle_RISCV/
│
├── RTL/
├── Testbench/
├── Test_Programs/
├── HEX/
├── Waveforms/
├── Images/
└── README.md
```

---

# 🛠️ Tools Used

- Verilog HDL
- Verilator
- GTKWave
- GNU RISC-V Toolchain
- Visual Studio Code
- Git & GitHub

---

# 🚀 Future Work

The next phase of this project is a **5-Stage Pipelined RV32I Processor**, adding:

- ✅ Pipeline Registers
- ✅ Hazard Detection Unit
- ✅ Data Forwarding Unit
- ✅ Stall Logic
- ✅ Flush Logic
- ✅ Branch Handling
- ✅ Performance Improvements

---

<div align="center">

### ⭐ If you found this project interesting, consider giving it a Star!

**Building Processors, One RTL Module at a Time.**

</div>
