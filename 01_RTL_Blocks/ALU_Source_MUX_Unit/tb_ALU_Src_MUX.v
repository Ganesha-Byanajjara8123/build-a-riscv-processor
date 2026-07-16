//code for tb_ALU_Src_MUX.v
`timescale 1ns / 1ps

module tb_ALU_Src_MUX; 
reg [31:0] reg_data_in;
reg [31:0] imm_data_in;
reg        ALU_Src_Sel; 
wire[31:0] src2_out;

//module instantiation
ALU_Src_MUX u_ALUmux(
.reg_data_in(reg_data_in),
.imm_data_in(imm_data_in),
.ALU_Src_Sel(ALU_Src_Sel),
.src2_out(src2_out)
);

initial begin

$dumpfile("ALU_Src_MUX.vcd");
$dumpvars(0,tb_ALU_Src_MUX);


reg_data_in = 32'h12345678 ; imm_data_in = 32'hABCDEF00 ; ALU_Src_Sel = 1'b1;   //it should be sel ABCDEF00 as o/p

#10;

reg_data_in = 32'h12345678 ; imm_data_in = 32'hABCDEF00 ; ALU_Src_Sel = 1'b0;  //it should be sel 12345678 as o/p

#10;

ALU_Src_Sel = 0;
#10;

//Test for Register Path
if(src2_out == reg_data_in)
$display("PASS: The Register Path");
else
$display("FAIL: The Register Path");

ALU_Src_Sel = 1;
#10;

//Test for Immediate Path
if(src2_out == imm_data_in)
$display("PASS: The Immediate Path");
else
$display("FAIL: The Immediate Path");

$finish;

end
endmodule
