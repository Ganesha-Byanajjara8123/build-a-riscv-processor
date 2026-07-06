//code for Extend_Unit 
//functionality: extends immediate values present in the instr. into 32-bits value
`timescale 1ns / 1ps

module Extend_Unit(
    input [31:0] instr_in,  //opcode bits [6:0] are not needed for immediate extraction
    input [2:0] Imm_type_in,
    output reg [31:0] Imm_out
);

always @(*) begin
    case(Imm_type_in)
        3'b000: Imm_out = {{20{instr_in[31]}}, instr_in[31:20]}; // I-type 
        3'b001: Imm_out ={{20{instr_in[31]}}, instr_in[31:25], instr_in[11:7]}; // S-type
        3'b010: Imm_out ={{19{instr_in[31]}}, instr_in[31], instr_in[7], instr_in[30:25], instr_in[11:8], 1'b0}; // B-type
        3'b101: Imm_out = {instr_in[31:12],12'b0}; // U-type
        3'b100: Imm_out ={{11{instr_in[31]}}, instr_in[31], instr_in[19:12], instr_in[20], instr_in[30:21], 1'b0}; // J-type
        default: Imm_out = 32'b0;
    endcase
end 
endmodule



/* Notes

1)for I - type- Sign Extension - {{20{instr_in[31]}}
Suppose:  instr_in[31] = 1
then   
       {{20{1'b1}}} = becomes: 
11111111111111111111(20 ones.)

instr_in[31] = 0  = 00000000000000000000

3'b000:
Imm_out = {{20{instr_in[31]}},instr_in[31:20]};
Used by:
ADDI
LW
JALR

Instruction bits:

31........20
Immediate
Example:
000000000101
(decimal 5)
Extend: 00000000000000000000000000000101

2)S-Type
3'b001:
Imm_out = {{20{instr_in[31]}},
           instr_in[31:25],
           instr_in[11:7]};

Used by:
SB
SH
SW

Store instructions.
Immediate is split.
Upper part:
31:25
Lower part:
11:7
Hardware joins them:
31:25 + 11:7
to reconstruct immediate.
Example
SW x5,16(x1)
offset:16
stored in two pieces.
Extend Unit joins them.


3)B-Type
3'b010:
Imm_out =
{{20{instr_in[31]}},
 instr_in[31],
 instr_in[7],
 instr_in[30:25],
 instr_in[11:8]};

Used by:
BEQ
BNE
BLT
BGE

Branch immediates are weird.
RISC-V scatters the bits.

Example:
BEQ x1,x2,label
Branch offset is stored in:
31
7
30:25
11:8
not contiguous.
Extend Unit collects them.
Without Extend Unit:
CPU cannot know branch distance

4)U-Type
3'b011:
Imm_out = {{12{instr_in[31]}},
           instr_in[31:12]};

Used by:
LUI
AUIPC
Example:
LUI x5,0x12345
Immediate occupies:
31:12
20 bits.
Purpose:
Load large constants

5)J-Type
3'b100:
Imm_out =
{{12{instr_in[31]}},
 instr_in[31],
 instr_in[19:12],
 instr_in[20],
 instr_in[30:21]};

Used by:
JAL
Again RISC-V scatters bits.
Offset stored as:
31
19:12
20
30:21
Extend Unit rebuilds:
Jump Offset
*/
	   
