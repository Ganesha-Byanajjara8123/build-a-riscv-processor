`timescale 1ns / 1ps

module Instruction_memory(
input  [31:0] PC_in,             //PC+4
output [31:0] Instruction_Out  //like ADD x5, x1, x2
);

reg[7:0] Instruction_mem[0:1023];//Memory

initial begin
    $readmemh("program.hex", Instruction_mem);

    $display("mem[0]  = %h", Instruction_mem[0]);
    $display("mem[1]  = %h", Instruction_mem[1]);
    $display("mem[2]  = %h", Instruction_mem[2]);
    $display("mem[3]  = %h", Instruction_mem[3]);

    $display("mem[4]  = %h", Instruction_mem[4]);
    $display("mem[5]  = %h", Instruction_mem[5]);
    $display("mem[6]  = %h", Instruction_mem[6]);
    $display("mem[7]  = %h", Instruction_mem[7]);

    $display("mem[8]  = %h", Instruction_mem[8]);
    $display("mem[9]  = %h", Instruction_mem[9]);
    $display("mem[10] = %h", Instruction_mem[10]);
    $display("mem[11] = %h", Instruction_mem[11]);
end
    
assign Instruction_Out = {
   Instruction_mem [PC_in + 3],
   Instruction_mem [PC_in + 2],
   Instruction_mem [PC_in + 1],
   Instruction_mem [PC_in]
};	  
						 
endmodule





















/*
Difference between Instruction Memory and Data Memory

Instruction Memory	         Data Memory
Stores instructions	         Stores data
Read only (for our CPU)	     Read & Write
Uses PC as address	         Uses ALU/Imm_Adder address

Whenever the PC changes, the instruction should appear immediately.like
PC = 0  ---> Instruction[0]
PC = 4  ---> Instruction[1]
PC = 8  ---> Instruction[2]

Accessing data from PC
Instruction 0  -> Address 0-PC
Instruction 1  -> Address 4-PC
Instruction 2  -> Address 8-PC
Instruction 3  -> Address 12-PC

each mem stores 1-byte(8-bit)
memory[8]  = Byte 0 (8 bits)
memory[9]  = Byte 1 (8 bits)
memory[10] = Byte 2 (8 bits)
memory[11] = Byte 3 (8 bits)

if the instruction is:

32'h00A00093    // addi x1, x0, 10
Then Instruction Memory stores:
memory[8]  = 8'h93
memory[9]  = 8'h00
memory[10] = 8'hA0
memory[11] = 8'h00

When PC = 8, the output should be reconstructed as:
/*

instruction_out = { memory[11],
                    memory[10],
                    memory[9],
                    memory[8] };

which gives back:

32'h00A00093
