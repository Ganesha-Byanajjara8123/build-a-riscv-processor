 
// tb code for ALU_file.v
`timescale 1ns / 1ps

module tb_ALU;
reg [31:0] src1_in;
reg [31:0] src2_in;
reg [3:0]  ALU_Control_in;
wire[31:0] ALU_Result_out;

ALU dut(
    .src1_in(src1_in),
    .src2_in(src2_in),
    .ALU_Control_in(ALU_Control_in),
    .ALU_Result_out(ALU_Result_out)
);
initial begin

    $dumpfile("wave.vcd");
    $dumpvars(0, tb_ALU);

    //src1_in = 32'hFFFFFFFF;  // -1 signed
    //src2_in = 32'h00000001;  // +1

    src1_in = 32'd3;
    src2_in = 32'd5;

    // ADD
    ALU_Control_in = 4'b0000;
    #10;
    $display("ADD  Result = %d", ALU_Result_out);

    // SUB
    ALU_Control_in = 4'b0001;
    #10;
    $display("SUB  Result = %d", ALU_Result_out);

    // AND
    ALU_Control_in = 4'b0010;
    #10;
    $display("AND  Result = %d", ALU_Result_out);

    // OR
    ALU_Control_in = 4'b0011;
    #10;
    $display("OR   Result = %d", ALU_Result_out);

    // XOR
    ALU_Control_in = 4'b0100;
    #10;
    $display("XOR  Result = %d", ALU_Result_out);

    // SLL
    ALU_Control_in = 4'b0101;
    #10;
    $display("SLL  Result = %d", ALU_Result_out);

    // SRL
    ALU_Control_in = 4'b0110;
    #10;
    $display("SRL  Result = %d", ALU_Result_out);

    // SRA
    ALU_Control_in = 4'b0111;
    #10;
    $display("SRA  Result = %d", ALU_Result_out);

    // SLT
    ALU_Control_in = 4'b1000;
    #10;
    $display("SLT  Result = %d", ALU_Result_out);

    // SLTU
    ALU_Control_in = 4'b1001;
    #10;
    $display("SLTU Result = %d", ALU_Result_out);

    $finish;

end
endmodule
