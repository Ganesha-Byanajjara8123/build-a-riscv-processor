`timescale 1ns / 1ps

module tb_Decoder;

reg  [6:0] opcode_in;
reg  [2:0] funct3_in;
reg  [6:0] funct7_in;

wire       Reg_WrEn_Out;
wire [2:0] Imm_Type_Out;
wire       ladder_Src_Out;
wire       ALU_Src_Out;
wire [3:0] ALU_Control_Out;
wire       DM_WrEn_Out;
wire [7:0] Branch_Cond_Out;
wire       Load_Unsigned_Out;
wire [1:0] Load_Size_Out;
wire [2:0] Result_Src_Out;

Decoder dut(
    .opcode_in(opcode_in),
    .funct3_in(funct3_in),
    .funct7_in(funct7_in),

    .Reg_WrEn_Out(Reg_WrEn_Out),
    .Imm_Type_Out(Imm_Type_Out),
    .ladder_Src_Out(ladder_Src_Out),
    .ALU_Src_Out(ALU_Src_Out),
    .ALU_Control_Out(ALU_Control_Out),
    .DM_WrEn_Out(DM_WrEn_Out),
    .Branch_Cond_Out(Branch_Cond_Out),
    .Load_Unsigned_Out(Load_Unsigned_Out),
    .Load_Size_Out(Load_Size_Out),
    .Result_Src_Out(Result_Src_Out)
);

initial begin

    $dumpfile("decoder_wave.vcd");
    $dumpvars(0, tb_Decoder);

    // ADD
    opcode_in = 7'b0110011;
    funct3_in = 3'b000;
    funct7_in = 7'b0000000;
    #10;

    // LOAD
    opcode_in = 7'b0000011;
    funct3_in = 3'b010;
    funct7_in = 7'b0000000;
    #10;

    // STORE
    opcode_in = 7'b0100011;
    funct3_in = 3'b010;
    funct7_in = 7'b0000000;
    #10;

    // BRANCH
    opcode_in = 7'b1100011;
    funct3_in = 3'b000;
    funct7_in = 7'b0000000;
    #10;

    // JAL
    opcode_in = 7'b1101111;
    #10;

    // JALR
    opcode_in = 7'b1100111;
    #10;

    // LUI
    opcode_in = 7'b0110111;
    #10;

    // AUIPC
    opcode_in = 7'b0010111;
    #10;

    $finish;

end

endmodule
