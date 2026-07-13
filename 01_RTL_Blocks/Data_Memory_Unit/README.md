Data Memory
What is Data Memory?

The Data Memory stores data generated and used during program execution.

Unlike the Register File, which contains only 32 registers, Data Memory provides a much larger storage space for variables, arrays, stack data, and other program information.

This module implements the memory system used by Load and Store instructions in the RISC-V processor.

Why is it Required?

Registers are limited in number and intended for temporary values.

Programs often need to store much larger datasets.

Example:

int numbers[1000];

A processor cannot store 1000 integers in its Register File alone. Instead:

Registers hold temporary operands.
Data Memory stores the actual program data.

This separation enables efficient computation while supporting large applications.

Supported Operations
Instruction	Operation	Status
SB	Store Byte	✅
SH	Store Halfword	✅
SW	Store Word	✅
Read	32-bit Read	✅
RTL Features
1024-byte memory array
Byte-addressable architecture
Little-endian storage
Byte-enable write masking
Synchronous write operation
Combinational read operation
Compatible with Store Unit and Load Unit interfaces
Interface
Signal	Width	Description
clk	1	System clock
DM_Addr_in	32	Memory address
DM_WrData_in	32	Data to write
DM_WrMask_in	4	Byte-enable mask
DM_WrEn_in	1	Write enable
Read_Data_Out	32	Read data output
RTL Operation
Store Word (SW)
Address = 100
Write Data = 0x12345678

Memory[100] = 0x78
Memory[101] = 0x56
Memory[102] = 0x34
Memory[103] = 0x12

The bytes are stored in little-endian order, matching the RISC-V memory model.

Store Halfword (SH)
Write Mask = 0011

Writes only:
Memory[Addr]
Memory[Addr+1]
Store Byte (SB)
Write Mask = 0001

Writes only:
Memory[Addr]
Read Operation

The module reconstructs a 32-bit word by combining four consecutive bytes from memory:

Read_Data_Out =
{
Memory[Addr+3],
Memory[Addr+2],
Memory[Addr+1],
Memory[Addr]
}
Verification Strategy

The module was verified with directed test cases for:

✔ Store Word (SW)
✔ Store Halfword (SH)
✔ Store Byte (SB)
✔ Memory read reconstruction
✔ Little-endian byte ordering

Simulation results confirmed:

Correct byte-mask operation
Proper address mapping
Accurate data reconstruction
Expected memory contents after each write
Waveform Analysis

The waveform confirms:

Successful Store Word write
Correct byte-enable masking
Stable memory address during write
Correct write data propagation
Proper read-back of stored data

The verification log also confirms successful execution of all directed test cases.

Integration
                Register File
                     │
               Source Data (rs2)
                     │
                     ▼
               Immediate Adder
                     │
             Computed Address
                     │
                     ▼
                Store Unit
                     │
      ┌──────────────┼──────────────┐
      │              │              │
 Address        Write Data      Write Mask
      │              │              │
      └──────────────┴──────────────┘
                     │
                     ▼
                Data Memory
                     │
              Read Data (32-bit)
                     │
                     ▼
                 Load Unit
                     │
                     ▼
              Write-Back MUX
                     │
                     ▼
               Register File

Key Learnings
RISC-V data memory architecture
Byte-addressable memory organization
Little-endian data storage
Byte-enable write masking
Memory read reconstruction
Load/Store datapath integration
Functional verification using Verilator and GTKWave
Next Module

➡️ Write-Back Multiplexer

Building Digital Hardware, One RTL Module at a Time.
