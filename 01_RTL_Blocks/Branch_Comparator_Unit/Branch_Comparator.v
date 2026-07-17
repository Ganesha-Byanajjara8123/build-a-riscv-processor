`timescale 1ns / 1ps

module Branch_Comparator(
input[31:0] RD1_in,           // (Register value 1)
input[31:0] RD2_in,           //(Register value 2)
input[2:0]  Branch_Type_sel,  //funct3-Decoder
input       Branch_Enable,
output reg  Branch_Taken_Out // go to PC_Src_MUX
);

always@(*)begin

Branch_Taken_Out = 1'b0;


if(Branch_Enable) begin

    case(Branch_Type_sel)

3'b000: Branch_Taken_Out = (RD1_in == RD2_in);                    //BEQ-Branch if Equal
3'b001: Branch_Taken_Out = (RD1_in != RD2_in);                    //BNE-Branch if Not Equal
3'b100: Branch_Taken_Out = ($signed(RD1_in) < $signed(RD2_in));   //BLT-Branch if Less Than (signed)
3'b101: Branch_Taken_Out = ($signed(RD1_in) >=  $signed(RD2_in)); //BGE-Branch if Greater or Equal (signed)
3'b110: Branch_Taken_Out = (RD1_in < RD2_in);                     // BLTU-Branch if Less Than (unsigned)
3'b111: Branch_Taken_Out = (RD1_in >= RD2_in);                    //BGEU-Branch if Greater or Equal (unsigned) 

default : Branch_Taken_Out = 1'b0;                              //for default case
endcase
end
end
endmodule












  /*
What branch instructions exist?

In RV32I

Instruction	Meaning
BEQ  	Branch if Equal
BNE  	Branch if Not Equal
BLT  	Branch if Less Than (signed)
BGE  	Branch if Greater or Equal (signed) - $signed(RD1) >= $signed(RD2)
BLTU	Branch if Less Than (unsigned)      - RD1 < RD2
BGEU	Branch if Greater or Equal (unsigned) - RD1 >= RD2

These are the six comparisons your comparator should support.

coding notes:
Input-1 - RD1 (Register value 1)
Input-2 - RD2(Register value 2)
Decoder already outputs - Branch_Cond_Out[7:0] but For now, we can use a simpler signal like  - Branch_Type[2:0]
Output - Branch_Taken

Truth table:
Suppose
RD1 = 20
RD2 = 20

Branch	Output(XNOR)
BEQ	      1
BNE	      0
BLT	      0
BGE	      1

Suppose:
RD1 = 10
RD2 = 20

Branch	Output(XOR)
BEQ	      0
BNE	      1
BLT	      1
BGE	      0

What hardware is inside?
== , != , <, > , >=

conceptually:
RD1 -----\
           \
            == ----\
RD2 -----/          \
                     \
            != -------\
                       \
            < ----------> MUX ---> Branch_Taken
                       /
            >= -------/
			
The Decoder tells the MUX:
Choose the equality result
or
Choose the less-than result	

RISC-V already defines:
funct3	Branch
000	    BEQ
001	    BNE
100	    BLT
101	    BGE
110	    BLTU 
111    	BGEU		

I'd use funct3.
Why?
Because it removes unnecessary logic from the Decoder.
The Decoder doesn't have to invent another encoding.
It simply forwards what the ISA already provides.


for tb:
Test-1
RD1 = 10                      
RD2 = 10                      
BEQ                      
Expected = 1   

Test-2
RD1 = 10
RD2 = 20
BNE
Expected = 1   

Test-3
RD1 = -5
RD2 = 3
BLT
Expected = 1

Test-4
RD1 = -5
RD2 = 3
BLTU
Expected = 0                
/*
