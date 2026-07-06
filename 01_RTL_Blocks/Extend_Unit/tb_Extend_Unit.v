//TB code for Extend_Unit
`timescale 1ns / 1ps

module tb_Extend_Unit();
reg [31:0] instr_in;
reg [2:0] Imm_type_in;
wire [31:0] Imm_out;

Extend_Unit dut (
.instr_in(instr_in),
.Imm_type_in(Imm_type_in),
.Imm_out(Imm_out)
);

//here we are going to test the extend unit for all the 7 types of instructions
initial begin

$dumpfile("Extend_Unit.vcd");
$dumpvars(0,tb_Extend_Unit);

    //Test for I-type instr
    instr_in = 32'h00A00093; //Imm_out = 0000000A
    Imm_type_in = 3'b000; //I-type
    #10;
    $display("I-Type = %h", Imm_out);
   

    //Test for S-type instr
    Imm_type_in = 3'b001; //S-type and Imm_out = 00000008
    #10;
    $display("S-Type = %h", Imm_out);
  
    Imm_type_in = 3'b010; //B-type and Imm_out = 00000010 
    #10;
    $display("B-Type = %h", Imm_out);
    

    //Test for U-type instr
    Imm_type_in = 3'b011; //U-type & Imm_out = 12345000
    #10;
    $display("U-Type = %h", Imm_out);
    

    //Test for J-type instr
    Imm_type_in = 3'b100; //J-type & Imm_out = 00000014
    #10;
    $display("J-Type = %h", Imm_out);
    
    $finish;

    end
endmodule

