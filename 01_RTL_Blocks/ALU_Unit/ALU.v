module ALU(
input [31:0] src1_in,
input [31:0] src2_in,
input [3:0]  ALU_Control_in,
output[31:0] ALU_Result_out
);

reg [31:0] ALU_Result;

always@(*) begin
case(ALU_Control_in) 

    4'b0000 : ALU_Result = src1_in + src2_in; //ADD
    4'b0001 : ALU_Result = src1_in - src2_in; //SUB
    4'b0010 : ALU_Result = src1_in & src2_in; //AND
    4'b0011 : ALU_Result = src1_in | src2_in; //OR
    4'b0100 : ALU_Result = src1_in ^ src2_in; //XOR
    4'b0101 : ALU_Result = src1_in << src2_in[4:0]; //Shift Left Logical 
    4'b0110 : ALU_Result = src1_in >> src2_in[4:0]; //Shift Right Logical
    4'b0111 : ALU_Result = $signed(src1_in) >>> src2_in[4:0]; //Shift right Arithmetic
    4'b1000 : ALU_Result = ($signed(src1_in) < $signed(src2_in)) ? 32'b1 : 32'b0; // SLT signed compare  
    4'b1001 : ALU_Result = (src1_in < src2_in) ? 32'b1 : 32'b0; //SLTU unsigned compare
    
    default : ALU_Result =32'b0; //default case

    endcase
    end

    assign ALU_Result_out = ALU_Result; //output the result of the ALU operation 
    
    endmodule



