module module PC_Unit(
    input clk,
    input rst,
    input Branch_Taken,
    input [31:0] Target_Address,

    output reg [31:0] PC_out,
    output [31:0] PC_plus4_out
);

always @(posedge clk or posedge rst) begin
    if (rst)
        PC_out <= 32'b0;
    else if (Branch_Taken)
        PC_out <= Target_Address;
    else
        PC_out <= PC_out + 4;
end


assign PC_plus4_out = PC_out + 4;

endmodule
