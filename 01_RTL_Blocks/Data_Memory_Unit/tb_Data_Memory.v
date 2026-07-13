
`timescale 1ns / 1ps

module tb_Data_Memory;
reg clk;
reg[31:0]DM_Addr_in;
reg[31:0]DM_WrData_in;
reg[3:0] DM_WrMask_in;
reg      DM_WrEn_in;

wire [31:0] Read_Data_Out;


Data_Memory u_DM(
.clk(clk),
.DM_Addr_in(DM_Addr_in),
.DM_WrData_in(DM_WrData_in),
.DM_WrMask_in(DM_WrMask_in),
.DM_WrEn_in(DM_WrEn_in),
.Read_Data_Out(Read_Data_Out)
);

always #5 clk = ~clk;

initial begin

$dumpfile("Data_Memory.vcd");
$dumpvars(0, tb_Data_Memory);

clk = 0;

//SW
DM_Addr_in   = 32'd100;      
DM_WrData_in = 32'h12345678;
DM_WrMask_in = 4'b1111;          
DM_WrEn_in   = 1'b1;             
#10;

DM_WrEn_in   = 1'b0;
#1;

$display("Read_Data_Out = %h", Read_Data_Out);

if(Read_Data_Out == 32'h12345678)
   $display("PASS : Read");
else
   $display("FAIL : Read"); 

$display("memory[100] = %h",u_DM.memory[100]);
$display("memory[101] = %h",u_DM.memory[101]);
$display("memory[102] = %h",u_DM.memory[102]);
$display("memory[103] = %h",u_DM.memory[103]);

if(u_DM.memory[100] == 8'h78 &&
   u_DM.memory[101] == 8'h56 &&
   u_DM.memory[102] == 8'h34 &&
   u_DM.memory[103] == 8'h12 
   )
   $display("PASS : SW write");
   else
   $display("FAIL : SW write");
   
//SH   
DM_Addr_in   = 32'd101;
DM_WrData_in = 32'h12345678;
DM_WrMask_in = 4'b0011;        
DM_WrEn_in   = 1'b1;
#10;

$display("memory[101] = %h",u_DM.memory[101]);
$display("memory[102] = %h",u_DM.memory[102]);

if(u_DM.memory[101] == 8'h78 &&
   u_DM.memory[102] == 8'h56 
   )
   $display("PASS : SH write");
   else
   $display("FAIL : SH write");

//SB
DM_Addr_in   = 32'd102;
DM_WrData_in = 32'h12345678;
DM_WrMask_in = 4'b0001;      
DM_WrEn_in   = 1'b1;
#10;

$display("memory[100] = %h",u_DM.memory[102]);

if(u_DM.memory[102] == 8'h78)
   $display("PASS : SB write");
   else
   $display("FAIL : SB write"); 

$finish;

end
endmodule
