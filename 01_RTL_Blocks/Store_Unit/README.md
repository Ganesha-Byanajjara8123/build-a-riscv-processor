Store Unit
What is the Store Unit?

The Store Unit prepares memory write operations for the Data Memory.

It receives the computed memory address, the data to be written, and the store instruction type, then generates the appropriate byte-enable mask required for memory updates.

This module implements the RISC-V store datapath.

Why is it Required?

Different RISC-V store instructions write different amounts of data:

Instruction	Data Width

SB	8 bits

SH	16 bits

SW	32 bits

Instead of always writing an entire word, the Store Unit generates the correct write mask, ensuring that only the intended bytes are updated in memory.
---
RTL Features:
Combinational RTL implementation

Supports SB, SH, and SW

Generates memory write masks

Passes computed memory address to Data Memory

Forwards register write data

Memory write enable propagation
---
Interface:

Signal	Width	Description

DM_WrEn_In	1	Memory write enable

Func3_In	3	Store instruction type

Added_Data_In	32	Computed memory address

Src_Data2_In	32	Data to store

DM_Addr_Out	32	Memory address output

DM_WrData_Out	32	Data forwarded to memory

DM_WrMask_Out	4	Byte-enable mask

DM_WrEn_Out	1	Memory write enable output
---
RTL Operation:
Store Byte (SB)

Write Mask = 0001

Writes only one byte.

Store Halfword (SH)
Write Mask = 0011

Writes two bytes.

Store Word (SW)

Write Mask = 1111

Writes all four bytes.
---
Verification Strategy

The Store Unit was verified using three directed test cases.

✔ Store Byte (SB)

Address generation

Data forwarding

Byte-enable mask = 0001

✔ Store Halfword (SH)

Address generation

Data forwarding

Byte-enable mask = 0011

✔ Store Word (SW)

Address generation

Data forwarding

Byte-enable mask = 1111
---
All outputs were validated through GTKWave simulation.

 GTKWaveform Analysis:
 

The simulation confirms:

Correct propagation of memory address

Correct forwarding of write data

Proper byte-mask generation for SB, SH, and SW

Memory write enable passed correctly to the Data Memory interface
---
Key Learnings:

RISC-V memory store operations

Byte-enable mask generation

Memory interface design

Datapath integration

Combinational RTL implementation

Functional verification using GTKWave
---
Next Module: ➡️ Load Unit

---
Building Digital Hardware, One RTL Module at a Time.
