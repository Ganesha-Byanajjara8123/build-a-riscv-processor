//tb code for tb_PC_Src_MUX.v
`timescale 1ns / 1ps

module tb_PC_Src_MUX;
reg [31:0] PC_plus4_in;
reg [31:0] Added_data_in;
reg        PC_Sel;
wire[31:0] Next_PC_Out;

//module instantiation 
PC_Src_MUX u_PCmux(
.PC_plus4_in(PC_plus4_in),
.Added_data_in(Added_data_in),
.PC_Sel(PC_Sel),
.Next_PC_Out(Next_PC_Out)
);

initial begin

$dumpfile("PC_Src_MUX.vcd");
$dumpvars(0, tb_PC_Src_MUX);

//i/ps for testing
 Added_data_in = 32'hABCDEF00 ; PC_plus4_in = 32'h12345678 ; PC_Sel = 1'b0;

#10;

 Added_data_in = 32'hABCDEF00 ; PC_plus4_in = 32'h12345678 ; PC_Sel = 1'b1;

#10;

PC_Sel = 1'b0;

#10;

//test for PC+4 Path
if (Next_PC_Out == PC_plus4_in)
$display("PASS: The PC+4 Path");

else
$display("FAIL: The PC+4 Path");


PC_Sel = 1'b1;

#10;

//test for Immediate Path
if(Next_PC_Out == Added_data_in)
$display("PASS: The Immediate Path");

else
$display("FAIL: The Immediate Path");

$finish;
end
endmodule


