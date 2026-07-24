<div align="center">

# 🚀 Single-Cycle RV32I RISC-V Processor
### *A Modular Verilog Implementation of the RV32I ISA with Directed Self-Checking Verification*

<p align="center">

![Verilog](https://img.shields.io/badge/Language-Verilog-blue?style=for-the-badge)
![Architecture](https://img.shields.io/badge/Architecture-RV32I-success?style=for-the-badge)
![Processor](https://img.shields.io/badge/Processor-Single--Cycle-orange?style=for-the-badge)
![Verification](https://img.shields.io/badge/Verification-Self--Checking-brightgreen?style=for-the-badge)
![Simulator](https://img.shields.io/badge/Simulator-Verilator-red?style=for-the-badge)
![Waveforms](https://img.shields.io/badge/Waveform-GTKWave-purple?style=for-the-badge)

</p>

---

### 📖 Building a RISC-V Processor One RTL Module at a Time

*A complete modular implementation of a **32-bit Single-Cycle RV32I Processor** written in Verilog HDL, verified using directed assembly programs and a self-checking verification environment.*

This project serves as the **foundation for my upcoming 5-Stage Pipelined RV32I Processor**, where hazard detection, forwarding, stalls, and pipeline control will be added.

---

## 🖼️ Processor Architecture

> **📌 Insert your complete Single-Cycle Datapath image here**

<p align="center">
<img src="Images/SingleCycle_Datapath.png" width="900">
</p>

---

</div>

# 📑 Table of Contents

- [📖 Project Overview](#-project-overview)
- [✨ Key Features](#-key-features)
- [🏗️ Processor Architecture](#️-processor-architecture)
- [🧩 RTL Modules](#-rtl-modules)
- [⚙️ Datapath Flow](#️-datapath-flow)
- [📚 Supported RV32I Instructions](#-supported-rv32i-instructions)
- [🧪 Verification Methodology](#-verification-methodology)
- [📂 Test Programs](#-test-programs)
- [📊 Verification Results](#-verification-results)
- [🐞 Engineering Challenges](#-engineering-challenges)
- [📁 Project Structure](#-project-structure)
- [🛠️ Tools Used](#️-tools-used)
- [🚀 Future Work](#-future-work)

---

# 📖 Project Overview

The **Single-Cycle RV32I Processor** is a complete implementation of the base **RISC-V RV32I Instruction Set Architecture (ISA)** using **Verilog HDL**.

Unlike a pipelined processor where multiple instructions execute simultaneously, a **Single-Cycle Processor completes every instruction in one clock cycle**. Each instruction passes through the complete datapath—including instruction fetch, decode, execute, memory access, and write-back—before the next instruction begins.

Rather than designing the processor as one large module, the architecture was developed using a **modular design methodology**. Every functional block was individually designed, simulated, and verified before integrating the complete processor.

This approach made debugging easier, improved design readability, and ensured each module behaved correctly before system-level integration.

---

# 🎯 Project Objectives

✔ Understand the complete RV32I datapath

✔ Design every processor block in Verilog HDL

✔ Learn processor integration from individual RTL modules

✔ Implement a complete Single-Cycle CPU

✔ Verify processor functionality using assembly programs

✔ Build a reusable foundation for a 5-Stage Pipeline Processor

---

# ✨ Key Features

### 🖥️ Processor Features

- ✅ 32-bit RV32I Processor
- ✅ Single-Cycle Datapath
- ✅ Modular RTL Design
- ✅ Harvard Architecture
- ✅ Byte Addressable Memory
- ✅ Register File with 32 Registers
- ✅ Immediate Generator
- ✅ Branch & Jump Support
- ✅ Load & Store Instructions
- ✅ Modular Control Logic

---

### 🧪 Verification Features

- ✅ Directed Assembly Verification
- ✅ Self-Checking Testbench
- ✅ Automatic PASS / FAIL Reporting
- ✅ Verilator Simulation
- ✅ GTKWave Analysis
- ✅ Register & Memory Validation
- ✅ Instruction-Level Verification

---

# 📈 Project Statistics

| Category | Details |
|-----------|----------|
| ISA | RV32I |
| Processor Type | Single-Cycle |
| RTL Language | Verilog HDL |
| RTL Modules | 14+ |
| Register Width | 32-bit |
| Register Count | 32 |
| Verification | Self-Checking Testbench |
| Test Programs | 4 |
| Assertions | 53 |
| Simulation | Verilator |
| Waveform Viewer | GTKWave |
| Next Project | 5-Stage Pipelined RV32I Processor |

---

# 🌟 Why This Project?

Modern processors are built by integrating many independent hardware blocks into a complete datapath.

This project was created to gain a **deep understanding of processor architecture**, rather than only learning individual RTL modules.

Throughout this project, every major component—including the Program Counter, Decoder, Register File, ALU, Immediate Generator, Branch Comparator, Memory Units, and Write-Back logic—was first designed and verified independently before integrating them into the final processor.

The final result is a complete Single-Cycle RV32I Processor capable of executing arithmetic, logical, memory, branch, jump, and upper-immediate instructions with functional verification using directed assembly test programs.

---

<div align="center">

## 🚀 Next Section

**🏗️ Processor Architecture & RTL Module Descriptions**

*(Continued in Part 2)*

</div>
