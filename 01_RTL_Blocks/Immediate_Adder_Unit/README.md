
Immediate Adder
What is the Immediate Adder?

The Immediate Adder is responsible for generating addresses required during instruction execution.

Depending on the instruction type, it performs one of two operations:

PC + Immediate → Used for branch and jump target generation.
Register + Immediate → Used for effective address calculation in instructions such as JALR, Load, and Store.

This module provides the datapath with the address required for control flow and memory access.
---
The Block-Diagram of Immediate Adder:


---

Why is it Required?

Several RISC-V instructions require address calculation rather than arithmetic computation.

Examples include:

Branch Instructions
JAL
JALR
Load Instructions
Store Instructions

The Immediate Adder ensures that the correct target or effective address is generated before execution continues.
---
RTL Features:

Pure combinational logic

Two selectable input paths

PC-relative address generation

Register-relative address generation

32-bit output

Interface

Signal	Width	Description

ladder_src_in	1	Selects the base address source

PC_in	32	Program Counter

Src_Data1_in	32	Register operand

imm_Data_in	32	Immediate value

Added_data_out	32	Generated address

RTL Operation

Mode 1 — PC Relative Address

Added_data_out = PC + Immediate
---
Used for:

Branch

JAL

AUIPC

Mode 2 — Register Relative Address

Added_data_out = Register + Immediate
---
Used for:

JALR

Load

Store
---
Verification Strategy:



The module was verified using two functional test cases:

✔ Test Case 1

ladder_src_in = 0

Register = 0x00000000

Immediate = 0x00000020

Output = 0x00000020

✔ Test Case 2

ladder_src_in = 1

PC = 0x00000010

Immediate = 0x00000040

Output = 0x00000050

The waveform confirms correct switching between the two address generation paths.
---
Waveform Analysis:

The GTKWave simulation:


Correct source selection

Proper combinational address generation

Immediate propagation without sequential delay
---
Key Learnings
Address generation in RISC-V
PC-relative addressing
Register-relative addressing
Datapath control signal selection
Combinational RTL implementation
Functional verification using GTKWave
---
➡️Next Module: Branch Comparator
---
Building Digital Hardware, One RTL Module at a Time.
