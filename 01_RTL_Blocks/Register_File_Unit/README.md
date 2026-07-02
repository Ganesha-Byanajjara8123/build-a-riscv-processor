# Register File

## Overview

The Register File is a fundamental component of the RISC-V datapath, responsible for storing and supplying operands during instruction execution.

This module implements **32 general-purpose registers**, each **32 bits wide**, following the RISC-V ISA convention where register **x0** is hardwired to zero.

---


## Features

* 32 × 32-bit Register File
* Two asynchronous read ports
* One synchronous write port
* Active-high reset
* Write Enable control
* Protection against writes to register x0

---

## Interface

### Inputs

| Signal       | Description                  |
| ------------ | ---------------------------- |
| clk          | System Clock                 |
| rst          | Active-high Reset            |
| WrEn_in      | Register Write Enable        |
| des_addr_in  | Destination Register Address |
| des_data_in  | Data to be Written           |
| src_addr1_in | Source Register Address 1    |
| src_addr2_in | Source Register Address 2    |

### Outputs

| Signal        | Description      |
| ------------- | ---------------- |
| src_data1_out | Read Data Port 1 |
| src_data2_out | Read Data Port 2 |

---

## Design

The register file is implemented as an array of **32 registers**, each 32 bits wide.

* Register writes occur on the **positive edge of the clock** when `WrEn_in` is asserted.
* Reads are **asynchronous**, allowing immediate access to register contents.
* Any attempt to write to **register x0** is ignored, preserving the RISC-V architectural requirement that x0 always reads as zero.

---

## Verification

The module was verified using a dedicated Verilog testbench.

### Test Cases

✔ Reset all registers

✔ Write `100` to register `x1`

✔ Write `200` to register `x2`

✔ Read back `x1`

✔ Read back `x2`

✔ Attempt to write `999` to register `x0`

✔ Verify `x0` remains zero

---

## GTKwaveform Simulation:

<img width="1887" height="857" alt="register_file" src="https://github.com/user-attachments/assets/a2ce46e4-aea8-40f0-a7b2-afc10c6cb50c" />

---

The waveform confirms:

* Correct synchronous write behavior
* Successful asynchronous reads
* Proper reset operation
* Register x0 write protection

---

## Key Learnings

* Register array implementation in Verilog
* Synchronous write vs asynchronous read
* Multi-port register file architecture
* RISC-V register conventions
* RTL simulation and waveform analysis

---

## Next Module

➡️ Program Counter (PC)

---

**Building Digital Hardware, One RTL Module at a Time.**
