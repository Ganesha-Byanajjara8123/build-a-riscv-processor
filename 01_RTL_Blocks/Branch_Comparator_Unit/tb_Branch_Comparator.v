//tb code for Branch_Comparator
`timescale 1ns / 1ps

module tb_Branch_Comparator;
reg[31:0] RD1_in;           
reg[31:0] RD2_in;           
reg[2:0]  Branch_Type_sel;  
wire      Branch_Taken_Out;

//module instantiation
Branch_Comparator u_BC(
.RD1_in(RD1_in),
.RD2_in(RD2_in),
.Branch_Type_sel(Branch_Type_sel),
.Branch_Taken_Out(Branch_Taken_Out)
); 

initial begin

//for waveform 
$dumpfile("Branch_Comparator.vcd");
$dumpvars(0, tb_Branch_Comparator);


//test for BEQ & BNQ
RD1_in = 32'd50;
RD2_in = 32'd50;  
#20;

//for BEQ
Branch_Type_sel = 3'b000;
#10;
// Test : BEQ (50 == 50)
// Expected : Branch_Taken_Out = 1
if (Branch_Taken_Out)
    $display("PASS : BEQ");
else
    $display("FAIL : BEQ");

//for BNQ
Branch_Type_sel = 3'b001;
#10;
// Test : BNQ (50 != 50)
// Expected : Branch_Taken_Out = 0
if (Branch_Taken_Out == 1'b0)
    $display("PASS : BNQ");
else
    $display("FAIL : BNQ");


//test for BLT and BGE
RD1_in = 32'd20;
RD2_in = 32'd50;
#20;

//for BLT
Branch_Type_sel = 3'b100;
#10;

// Test : BLT 
// Expected : Branch_Taken_Out = 1
if (Branch_Taken_Out)
    $display("PASS : BLT");
else
    $display("FAIL : BLT");

//for BGE
Branch_Type_sel = 3'b101;
#10;

// Test : BGE
// Expected : Branch_Taken_Out = 0
if (Branch_Taken_Out == 1'b0)
    $display("PASS : BGE");
else
    $display("FAIL : BGE");
	
	
//input for Unsigned values- BGEU & BLTU
RD1_in = 32'hFFFFFFFF;      //for - signed
RD2_in = 32'h00000001;      //for + Unsigned
#20;
	
//for BLTU
Branch_Type_sel = 3'b110;
#10;

// Test : BLTU
// Expected : Branch_Taken_Out = 0
if (Branch_Taken_Out == 1'b0)
    $display("PASS : BLTU");
else
    $display("FAIL : BLTU");

//for BGEU
Branch_Type_sel = 3'b111;
#10;

// Test : BGEU
// Expected : Branch_Taken_Out = 1
if (Branch_Taken_Out)
    $display("PASS : BGEU");
else
    $display("FAIL : BGEU");

$finish;

end
endmodule

