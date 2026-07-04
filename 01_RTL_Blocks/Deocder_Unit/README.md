
Decoder
What is an Instruction Decoder?

The Instruction Decoder is the control unit of the processor. It interprets the instruction fields and generates the control signals required for the datapath to execute the instruction correctly.

Instead of performing arithmetic itself, the decoder tells every hardware block what operation to perform.

---
**The Block-Diagram of Decoder:**
<img width="1114" height="565" alt="Screenshot 2026-05-26 211032" src="https://github.com/user-attachments/assets/f8d65b9b-d1fb-401e-bfdf-1b70e7bb0878" />

---

Why is it Required?

Without a decoder, the processor cannot determine:

Which ALU operation to execute
Whether to read or write memory
Whether a register should be written
Which immediate format to use
Whether the instruction changes the Program Counter
Which result should be written back

The decoder is responsible for converting instruction encoding into processor control signals.

Supported Instruction Types

Instruction	Supported

R-Type	        ✅

I-Type ALU	✅

Load	        ✅

Store	        ✅

Branch	        ✅

JAL	        ✅

JALR	        ✅

LUI	        ✅

AUIPC	        ✅

Generated Control Signals

The decoder generates:

Register Write Enable

Immediate Type

ALU Source Selection

ALU Control

Data Memory Write Enable

Branch Condition

Load Size

Load Unsigned

Result Source

PC Selection (Jump)

Adder Source Selection

These signals coordinate the operation of the datapath.

RTL Features

Pure combinational logic

Default-safe outputs

Opcode-based instruction decoding

ALU operation decoding using funct3 and funct7

Control generation for arithmetic, memory, branch, and jump instructions

Verification Strategy

---
## Integration

Inputs:
Instruction Memory
        │
        ▼
Instruction Decoder

Outputs:
├── Register File
├── ALU
├── Immediate Generator
├── Data Memory
└── Program Counter

---
The decoder was verified by applying representative instructions for:

R-Type

Load

Store

Branch

JAL

JALR

LUI

AUIPC

---
The resulting control signals were examined in GTKWave to confirm correct decoding.

GTKWaveform Analysis:

<img width="1918" height="812" alt="Decoder" src="https://github.com/user-attachments/assets/b37ef5e2-d884-40c2-a74a-2a953fd0e3f8" />

---
The waveform demonstrates that changing the instruction opcode updates the corresponding control outputs.

Examples include:

Register write enabled for arithmetic and load instructions

Memory write enabled only for store instructions

Branch control asserted for branch instructions

Jump control asserted for JAL and JALR

Immediate type changes according to instruction format

Result source changes correctly for load, jump, and upper-immediate instructions

This verifies that the decoder correctly translates instruction encodings into processor control signals.
---
Key Learnings

RISC-V instruction encoding

Control signal generation

Opcode decoding

ALU operation selection

Processor control path design

Combinational RTL design

Waveform-based verification

---

➡️Next Module:Extend Unit 
---
Building Digital Hardware, One RTL Module at a Time.
