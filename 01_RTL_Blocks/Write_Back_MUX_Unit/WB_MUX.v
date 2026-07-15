
`timescale 1ns / 1ps

module WB_MUX(
input[31:0] ALU_Result_in,  //from ALU_Result_out(ALU)
input[31:0] Loaded_data_in, //from Loaded_data_out(Load_unit)
input[31:0] PC_plus4_in,    //from PC+4(PC_unit)
input[31:0] Imm_in,         //from Imm_Unit
input [31:0] Added_data_in,
input[2:0]  Result_Src_in,  //select line from Decoder
output reg [31:0]WB_Data_Out      //goes to Register file/unit
); 

always@(*)begin

case(Result_Src_in)

3'b000 : WB_Data_Out = ALU_Result_in;
3'b001 : WB_Data_Out = Loaded_data_in;
3'b010 : WB_Data_Out = PC_plus4_in;
3'b011 : WB_Data_Out = Imm_in;
3'b100 : WB_Data_Out = Added_data_in; 

default : WB_Data_Out = 32'b0;

endcase
end
endmodule










/*
who controls - Decoder- Result_Src_Out

*** how it works like if get a sallary from a company they will send money through- UPI, Salary, Cash Deposit, Cheque

Exactly like
ALU?
Memory?
PC+4?
Immediate?
The Register File is the bank account.

about code:
i/ps:
ALU Result
Loaded Data
PC+4
Immediate
select line - Result_Src_Out[2:0]
o/p- WriteBack_Data_Out this goes directly into Register File - des_data_in

Hardware view inside: 4:1mux

          ALU
           │
           │
Memory─────┤

PC+4───────┤

Imm────────┤

         4x1 MUX

             │

       WriteBack_Data
	   
TB-code:
Test-1
Result_Src = 000
Expect
ALU Result

Test-2
001
Expect
Memory Data

Test-3
010
Expect
PC+4

Test-4
011
Expect
Immediate
/*

