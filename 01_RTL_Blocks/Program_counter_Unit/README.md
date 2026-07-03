

Program Counter (PC)
What is a Program Counter?

The Program Counter (PC) is one of the fundamental blocks of a processor. It stores the address of the instruction currently being executed and determines which instruction will be fetched next.

In a RISC-V processor, the PC normally increments by 4 bytes (one instruction) after every clock cycle. When a branch or jump instruction is taken, the PC is redirected to the target instruction address instead of continuing sequentially.

Why is it Required?

Without the Program Counter, the processor would have no way to know which instruction to fetch next.

---
Block diagram of PC:

<img width="928" height="501" alt="Screenshot 2026-05-25 162148" src="https://github.com/user-attachments/assets/eacdefbd-51ec-4444-99e5-7955cc3a1252" />

---

The PC enables:

Sequential instruction execution
Branch handling
Program flow control
Instruction fetching
RTL Features
32-bit Program Counter
Positive-edge triggered register
Active-high asynchronous reset
Sequential update (PC = PC + 4)
Branch target selection
PC + 4 output generation
Interface
Signal	Width	Description
clk	1	System Clock
rst	1	Active-high Reset
Branch_Taken	1	Branch control signal
Target_Address	32	Branch target address
PC_out	32	Current Program Counter
PC_plus4_out	32	Next sequential address
RTL Operation
Reset
PC = 0x00000000
Sequential Execution
PC = PC + 4

Example

0x00000000
↓

0x00000004
↓

0x00000008
Branch Execution

When

Branch_Taken = 1

the PC immediately loads

Target_Address

instead of incrementing.

Example

PC = 0x00000008

↓

Target = 0x00000100

↓

PC = 0x00000100
Verification Strategy

The module was verified using a dedicated Verilog testbench.

Test Cases

✔ Reset PC to zero

✔ Sequential counting

✔ Verify PC + 4

✔ Branch to 0x00000100

✔ Branch to 0x00000200

✔ Continue sequential execution after the branch

---
GTKWaveform Analysis:

<img width="1877" height="923" alt="PC_Unit" src="https://github.com/user-attachments/assets/81dbccf9-643b-485b-bfd8-57bd9ba820fe" />


The simulation confirms:

PC resets to 0x00000000
Sequential updates occur in 4-byte increments
Branch control correctly redirects the PC
PC_plus4_out always reflects the next sequential address

---
Learning Outcome:

Through this module, I gained practical understanding of:

1.Program flow in processors

2.Sequential instruction execution

3.Branch redirection

4.Clocked RTL design

5.Reset logic

6.RTL simulation using GTKWave

Next Module

➡️ Decoder

Building Digital Hardware, One RTL Module at a Time.
