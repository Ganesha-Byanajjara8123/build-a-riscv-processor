
# 🚀 5-Stage Pipelined RISC-V RV32I Processor

<p align="center">
  <b>A fully RTL-designed 32-bit RISC-V RV32I processor implementing a classic 5-stage pipeline.</b><br>
  <sub>IF → ID → EX → MEM → WB | Hazard Detection | Data Forwarding | Branch/Jump Handling</sub>
</p>

--- 

## 📌 Overview

A **32-bit RISC-V RV32I processor** built at the RTL level in Verilog, implementing a classic **5-stage pipeline**. Individual blocks were designed and verified independently before integration into the full pipelined CPU.

The project focuses on how a real pipelined processor handles data hazards, load-use hazards, data forwarding, stalls, flushing, branches, JAL/JALR control flow, and the RISC-V `x0` architectural rule.

---

## 🧠 Processor Architecture

```text
                    ┌──────────────────────────────┐
                    │        Instruction Memory    │
                    └──────────────┬───────────────┘
                                   │
                                   ▼
┌─────────┐     ┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐
│   IF    │ ──► │   ID    │ ─► │   EX    │ ─► │   MEM   │ ─► │   WB    │
│  PC     │     │Decoder  │    │  ALU    │    │  Data   │    │Register │
│ PC+4    │     │Reg File │    │Branch   │    │ Memory  │    │  Write  │
│         │     │Imm Ext. │    │Compare  │    │         │    │  Back   │
└─────────┘     └─────────┘    └─────────┘    └─────────┘    └─────────┘
     │               │              │              │              │
     ▼               ▼              ▼              ▼              ▼
  IF/ID           ID/EX          EX/MEM         MEM/WB
 Register        Register        Register       Register
                    ▲
                    │
          ┌─────────┴──────────┐
          │ Hazard Detection   │
          │ & Forwarding Unit  │
          └────────────────────┘
```
Image:

<img width="3695" height="1681" alt="5Stage_pipeline-Page-1 drawio" src="https://github.com/user-attachments/assets/22cbd0da-afe0-4760-b4e7-4748f0159aa6" />

---

## ⚙️ Pipeline Stages

| Stage | Function |
|-------|----------|
| **IF** | Fetch instruction and calculate next PC |
| **ID** | Decode instruction, read registers, generate immediate |
| **EX** | ALU operation, address calculation, branch comparison |
| **MEM** | Load/store data memory operations |
| **WB** | Write result back into register file |

**Pipeline registers:** IF/ID · ID/EX · EX/MEM · MEM/WB

---

## 🧩 Major RTL Blocks

**Processor Core**
PC Unit · Instruction Fetch/Decode · Control Unit · Register File · Immediate/Extend Unit · ALU · ALU Source MUX · Branch Comparator · PC Source MUX · Store Unit · Data Memory · Writeback Logic

**Pipeline Infrastructure**
IF/ID, ID/EX, EX/MEM, MEM/WB pipeline registers

**Hazard & Control**
Hazard Detection Unit · Forwarding Unit · Forward A/B MUX · Branch Flush Unit · Stall/Flush Control

---

## 🧮 Supported RV32I Instructions

| Category | Instructions |
|----------|--------------|
| R-Type | ADD, SUB, AND, OR, XOR, SLL, SRL, SRA, SLT, SLTU |
| I-Type | ADDI, ANDI, ORI, XORI, SLLI, SRLI, SRAI, SLTI, SLTIU |
| Load/Store | LW, SW |
| Branches | BEQ, BNE, BLT, BGE, BLTU, BGEU |
| Jumps | JAL, JALR |
| System | ECALL |

---

## 🔥 Hazard Handling

**1. Data Forwarding** — Results from EX/MEM and MEM/WB are forwarded directly to EX, letting dependent instructions execute without unnecessary stalls.

**2. Load-Use Hazard** — When an instruction depends on data from an immediately preceding load, the Hazard Unit inserts a single-cycle stall so the value can be forwarded afterward (`LW → STALL → ADD`).

**3. Branch Hazard** — On a taken branch, younger fetched instructions are flushed and the PC is redirected to the branch target. Both taken and not-taken paths are verified.

**4. JAL / JALR Handling** — JAL stores `PC + 4` as the return address; JALR computes the target from a register plus immediate. Incorrectly fetched instructions are flushed on control transfer.

---

## 🛡️ x0 Protection

Per the RISC-V spec, `x0` must always read as `0`, regardless of writes. Verified with tests including:

```asm
addi x0, x0, 5
add  x0, x1, x1
sub  x0, x2, x1
lw   x0, 0(x0)
```

Expected result after execution: `x0 = 0`.

---

## 🧪 Verification

Assembly programs are assembled to machine code/HEX and run on the RTL processor via a **self-checking testbench** that compares final register/memory state against expected values.

```text
Assembly Program → RISC-V Assembler → HEX → 5-Stage Pipeline CPU
                                              │
                                    Register / Memory State
                                              │
                                    Self-Checking Testbench
                                          ├── PASS
                                          └── FAIL
```

**Coverage:**
- ALU & immediate operations (all R-type/I-type instructions)
- Memory operations (LW, SW)
- Hazards — load-use, EX-EX/WB-EX forwarding, forwarding chains
- Branches — taken and not-taken, all 6 conditions
- Jumps — target redirection, return address, pipeline flushing, call/return
- `x0` architectural protection

Waveforms are inspected in **GTKWave** for PC progression, pipeline movement, forwarding, stalls, flushes, branch/jump decisions, and memory/writeback activity.

---

## 🖥️ Tools

| Tool | Purpose |
|------|---------|
| Verilog | RTL implementation |
| Verilator | RTL simulation |
| GTKWave | Waveform analysis |
| RISC-V GNU Toolchain | Assembly → machine code |
| Yosys | Synthesis / inspection |
| Linux / WSL | Development environment |

---


**Representative test programs:** `alu_ops.s`, `branches_taken.s`, `branches_not_taken.s`, `jumps.s`, `x0_protect.s`, `Combined_test.s` (integrates multiple features in one run).

---

## 📈 Verification Results

Tested at both **block level** (ALU, Register File, PC Unit, Immediate Generator, MUXes, Branch Comparator, Forwarding Unit, Hazard Unit, Pipeline Registers) and **processor level** (full instruction-level assembly programs).

All checks confirmed:
✓ Register values · ✓ Memory values · ✓ Branch behavior · ✓ Jump behavior
✓ Pipeline flushing · ✓ Hazard handling · ✓ Data forwarding · ✓ x0 protection

```
>>> ALL CHECKS PASSED <<<
```

---

## 🎯 Key Concepts Demonstrated

RISC-V RV32I ISA · RTL/datapath/control-path design · 5-stage pipelining · Data & control hazards · Load-use hazards · Data forwarding · Pipeline stalls & flushing · Branch resolution · Jump/return handling · Register-file & memory interface design · Self-checking verification · Waveform-based debugging

---

## 🚧 Future Improvements

- Full RV32I instruction coverage (byte/halfword load-store)
- CSR support, exceptions & interrupts, performance counters
- Branch prediction, cache integration

---

## 👨‍💻 Project Focus

Built with an emphasis on RTL-level processor design — understanding the interplay between datapath and control logic, and debugging real pipeline behavior through simulation waveforms, rather than treating the CPU as a black box.



<p align="center">
  <b>Designed at RTL • Simulated with Verilator • Debugged with GTKWave • Built around RISC-V RV32I</b>
</p>
