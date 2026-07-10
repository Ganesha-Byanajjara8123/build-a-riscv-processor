Load Unit
What is the Load Unit?

The Load Unit processes data read from Data Memory and converts it into the correct 32-bit value before it is written back to the Register File.

Since RISC-V supports loading data of different sizes, the Load Unit determines whether the value should be sign-extended or zero-extended based on the instruction.

Why is it Required?

Memory can return:

8-bit values
16-bit values
32-bit values

The processor must interpret these values correctly depending on the instruction.

For example:

LB loads a signed byte.
LBU loads an unsigned byte.
LH loads a signed halfword.
LHU loads an unsigned halfword.
LW loads an entire 32-bit word.

Without this unit, the Register File could receive incorrect values.

Supported Instructions
Instruction	Description
LB	Load Byte
LBU	Load Byte Unsigned
LH	Load Halfword
LHU	Load Halfword Unsigned
LW	Load Word
RTL Features
Pure combinational logic
Byte extraction
Halfword extraction
Word loading
Sign extension
Zero extension
32-bit write-back output
Interface
Signal	Width	Description
Read_Data_In	32	Data returned from memory
Load_Size_In	2	Load size selector
Load_Unsigned_In	1	Selects sign or zero extension
Loaded_Data_Out	32	Formatted write-back data
RTL Operation
Load Byte (LB)
Sign Extend 8-bit value
Load Byte Unsigned (LBU)
Zero Extend 8-bit value
Load Halfword (LH)
Sign Extend 16-bit value
Load Halfword Unsigned (LHU)
Zero Extend 16-bit value
Load Word (LW)
Pass complete 32-bit data
Verification Strategy

The module was verified using dedicated test cases covering every supported load instruction.

✔ LB

Signed byte extension

✔ LBU

Unsigned byte extension

✔ LH

Signed halfword extension

✔ LHU

Unsigned halfword extension

✔ LW

32-bit word loading

Each case was validated through GTKWave simulation.

Waveform Analysis

The waveform confirms:

Correct byte extraction
Correct halfword extraction
Proper sign extension
Proper zero extension
Direct 32-bit word loading
Correct output selection based on instruction type

Key Learnings
RISC-V load instruction behavior
Sign extension techniques
Zero extension techniques
Memory read datapath
Write-back data formatting
Combinational RTL implementation
Functional verification using GTKWave
Next Module

➡️ Data Memory

Building Digital Hardware, One RTL Module at a Time.
