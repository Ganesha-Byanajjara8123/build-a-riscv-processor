`timescale 1ns / 1ps

module PC_Src_MUX(
input[31:0] PC_plus4_in,   // from PC + 4
input[31:0] Added_data_in,  // from Imm_Adder
input PC_Sel,               // controlled by branch comparator
output[31:0] Next_PC_Out    //goes again to PC_Unit
);  

assign Next_PC_Out = PC_Sel ?  Added_data_in : PC_plus4_in;


endmodule



 


/* notes
                 PC+4
                  │
                  │
                  ▼
             ┌────────┐
Added_data──►│        │
             │ PC MUX │──────► Next_PC
 PC_Sel ----►│        │
             └────────┘
			


Always design hardware first.

PC_Sel	| Selected Input	|   Output
0|      	PC+4	             PC+4
1|	     Added_data_out   	  Added_data_out			
*/			 
