
`timescale 1ns / 1ps

module tb_WB_MUX;
reg [31:0] ALU_Result_in;
reg [31:0] Loaded_data_in;
reg [31:0] PC_plus4_in;
reg [31:0] Imm_in;
reg [2:0]  Result_Src_in;
wire [31:0]WB_Data_Out;

//module instantiation
WB_MUX u_WBmux(
.ALU_Result_in(ALU_Result_in),
.Loaded_data_in(Loaded_data_in),
.PC_plus4_in(PC_plus4_in),
.Imm_in(Imm_in),
.Result_Src_in(Result_Src_in),
.WB_Data_Out(ALU_Result_in)
);

//initial block

initial begin

//for waveforms
$dumpfile("WB_MUX.vcd");
$dumpvars(0,tb_WB_MUX);


//Test case 000
Result_Src_in = 3'b000;            #10;

//TEST-1 for ALU_Result_in
ALU_Result_in = 32'h11111111;      #20;

//for self-checking
if(WB_Data_Out == ALU_Result_in)
   $display("PASS : ALU Result");
else
   $display("FAIL : ALU Result"); 


//Test case 001
Result_Src_in = 3'b001;             #10;

//TEST-2 for Loaded_data_in
Loaded_data_in = 32'h22222222;      #20;

if(WB_Data_Out == Loaded_data_in)
   $display("PASS : Loaded data ");
else 
   $display("FAIL : Loaded data ");  
   

//Test case 010
Result_Src_in = 3'b010;              #10;

//TEST-3 for PC+4
PC_plus4_in = 32'h33333333;          #20;

if(WB_Data_Out == PC_plus4_in)
   $display("PASS : PC+4 ");
else 
   $display("FAIL : PC+4 "); 
   

//Test case 011
Result_Src_in = 3'b011;              #10;

//TEST-4 for Immediate
Imm_in = 32'h44444444;               #20;

if(WB_Data_Out == Imm_in)
   $display("PASS : Immediate ");
else 
   $display("FAIL : Immediate "); 
   
$finish;

end
endmodule   

 
