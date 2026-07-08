//code for Imm_Adder
 
module Imm_Adder(
    input ladder_src_in,
    input [31:0] PC_in,
    input [31:0] Src_Data1_in,
    input [31:0] imm_Data_in,
    output reg [31:0] Added_data_out
);

always @(*) begin

    if (ladder_src_in)
        Added_data_out = PC_in + imm_Data_in;

    else
        Added_data_out = Src_Data1_in + imm_Data_in;

end
       
 endmodule
