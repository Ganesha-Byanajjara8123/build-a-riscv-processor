`timescale 1ns / 1ps

module Decoder(
    input  [6:0] opcode_in,
    input  [2:0] funct3_in,
    input  [6:0] funct7_in,

    output reg       Reg_WrEn_Out,
    output reg [2:0] Imm_Type_Out,
    output reg       ladder_Src_Out,
    output reg       ALU_Src_Out,
    output reg [3:0] ALU_Control_Out,
    output reg       DM_WrEn_Out,
    output reg [7:0] Branch_Cond_Out,
    output reg       Load_Unsigned_Out,
    output reg [1:0] Load_Size_Out,
    output reg [2:0] Result_Src_Out,
	output reg Jump_Out
);


always @(*) begin

    // Default values
    Reg_WrEn_Out      = 1'b0;
    Imm_Type_Out      = 3'b000;
    ladder_Src_Out    = 1'b0;
    ALU_Src_Out       = 1'b0;
    ALU_Control_Out   = 4'b0000;
    DM_WrEn_Out       = 1'b0;
    Branch_Cond_Out   = 8'b00000000;
    Load_Unsigned_Out = 1'b0;
    Load_Size_Out     = 2'b00;
    Result_Src_Out    = 3'b000;
	Jump_Out          = 1'b0;   // Default

    case(opcode_in)

    // R-Type
    7'b0110011: begin

        Reg_WrEn_Out = 1'b1;
        ALU_Src_Out  = 1'b0;

        case({funct7_in,funct3_in})

             //10bits = funct3 + funct7
            10'b0000000_000: ALU_Control_Out = 4'b0000; // ADD & about 10bits funct3=000 funct7=0000000 = 10'b0000000_000
            10'b0100000_000: ALU_Control_Out = 4'b0001; // SUB & about 10bits funct3=000 funct7=0100000 = 10'b0100000_000 (same for remaining cases)
            10'b0000000_111: ALU_Control_Out = 4'b0010; // AND
            10'b0000000_110: ALU_Control_Out = 4'b0011; // OR
            10'b0000000_100: ALU_Control_Out = 4'b0100; // XOR
            10'b0000000_001: ALU_Control_Out = 4'b0101; // SLL
            10'b0000000_101: ALU_Control_Out = 4'b0110; // SRL
            10'b0100000_101: ALU_Control_Out = 4'b0111; // SRA
            10'b0000000_010: ALU_Control_Out = 4'b1000; // SLT
            10'b0000000_011: ALU_Control_Out = 4'b1001; // SLTU

            default: ALU_Control_Out = 4'b0000;

        endcase
    end

    // I-Type ALU
    7'b0010011: begin
        Reg_WrEn_Out = 1'b1;
        ALU_Src_Out  = 1'b1;
        Imm_Type_Out = 3'b000;
		
		case(funct3_in)
		
		3'b000: ALU_Control_Out = 4'b0000; // ADDI
		3'b111: ALU_Control_Out = 4'b0010; // ANDI
		3'b110: ALU_Control_Out = 4'b0011; // ORI
		3'b100: ALU_Control_Out = 4'b0100; // XORI
		3'b001: ALU_Control_Out = 4'b0101; // SLLI
		
		3'b101: begin
		    if(funct7_in == 7'b0000000)
			   ALU_Control_Out = 4'b0110; // SRLI
			else if(funct7_in == 7'b0100000)
			    ALU_Control_Out = 4'b0111; // SRAI
				
		end
		
		3'b010: ALU_Control_Out = 4'b1000; // SLTI
		3'b011: ALU_Control_Out = 4'b1001; // SLTU
		endcase
	
    end


    // STORE
    7'b0100011: begin
        DM_WrEn_Out    = 1'b1;
        ALU_Src_Out    = 1'b1;
        Imm_Type_Out   = 3'b001;   // S-Type
        ALU_Control_Out = 4'b0000; // Always ADD
	
    end
    //LOAD
    7'b0000011: begin
    Reg_WrEn_Out    = 1'b1;      // Write loaded data to register
    DM_WrEn_Out     = 1'b0;      // Do NOT write memory
    ALU_Src_Out     = 1'b1;
    Imm_Type_Out    = 3'b000;    // I-Type immediate
    ALU_Control_Out = 4'b0000;   // Address = rs1 + imm
    Result_Src_Out  = 3'b001;    // Select Data Memory output
	
    end	

    // BRANCH
    7'b1100011: begin
    Imm_Type_Out    = 3'b010;
    Branch_Cond_Out = 8'b00000001;
    ladder_Src_Out  = 1'b1;    
		
		case(funct3_in)

        3'b000 : ALU_Control_Out = 4'b0000; //BEQ
        3'b001 : ALU_Control_Out = 4'b0101; //BNE
        3'b100 : ALU_Control_Out = 4'b0100; //BLT
        3'b101 : ALU_Control_Out = 4'b0110; //BGE
        3'b110 : ALU_Control_Out = 4'b0011; //BLTU
        3'b111 : ALU_Control_Out = 4'b0010; //BGEU
		
		default: ALU_Control_Out = 4'b0000;

endcase
    end

// JAL
7'b1101111: begin
    Reg_WrEn_Out   = 1'b1;
    Imm_Type_Out   = 3'b100;   // J-type
    Result_Src_Out = 3'b010;   // PC+4
    ladder_Src_Out = 1'b1;     // PC + Imm
    Jump_Out       = 1'b1;
end

// JALR
7'b1100111: begin
    Reg_WrEn_Out   = 1'b1;
    Imm_Type_Out   = 3'b000;   // I-type immediate
    Result_Src_Out = 3'b010;   // PC+4
    ALU_Src_Out    = 1'b1;
    Jump_Out       = 1'b1;
end

    // LUI
  7'b0110111: begin
    Reg_WrEn_Out = 1'b1;
    Imm_Type_Out = 3'b101;
    Result_Src_Out = 3'b011;
  end

    // AUIPC
7'b0010111: begin
    Reg_WrEn_Out = 1'b1;
    Imm_Type_Out = 3'b101;
    ladder_Src_Out = 1'b1;
    Result_Src_Out = 3'b100;
end
    end

    default: begin
    end

    endcase

end

endmodule
