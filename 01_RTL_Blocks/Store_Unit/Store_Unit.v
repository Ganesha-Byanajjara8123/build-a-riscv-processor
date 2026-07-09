`timescale 1ns / 1ps

module Store_Unit(

    input         DM_WrEn_In,
    input  [2:0]  Func3_In,
    input  [31:0] Added_Data_In,
    input  [31:0] Src_Data2_In,

    output [31:0] DM_Addr_Out,
    output reg [31:0] DM_WrData_Out,
    output reg [3:0]  DM_WrMask_Out,
    output            DM_WrEn_Out

);

assign DM_Addr_Out = Added_Data_In;
assign DM_WrEn_Out = DM_WrEn_In;

always @(*) begin

    DM_WrData_Out = Src_Data2_In;
    DM_WrMask_Out = 4'b0000;

    case(Func3_In)

        3'b000: begin          // SB-store byte
            DM_WrMask_Out = 4'b0001;
        end
		 3'b001: begin          // SH-store halfword
            DM_WrMask_Out = 4'b0011;
        end

        3'b010: begin          // SW-store word
            DM_WrMask_Out = 4'b1111;
        end

        default: begin
            DM_WrMask_Out = 4'b0000;
        end

    endcase

end

endmodule
