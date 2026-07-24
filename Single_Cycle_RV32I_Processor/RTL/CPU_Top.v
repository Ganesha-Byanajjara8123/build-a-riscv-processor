
`timescale 1ns / 1ps

module CPU_Top(
    //decalreing external wires
    input         clk,
    input         rst
);

//decalreing internal wire of each Units

//PC_Unit.v wires
wire [31:0] PC_out;
wire	    Branch_Taken;
wire [31:0] Target_Address; 
wire [31:0] PC_plus4_out;

//PC_Src_MUX.v wires
wire [31:0] Next_PC_Out;
wire PC_Sel;

assign PC_Sel =
    Jump_Out |
    (Branch_Enable & Branch_Taken_Out);

//Instruction_memory.v wire
wire [31:0] Instruction_Out;

//4)Decoder.v wires
wire 	   Reg_WrEn_Out;
wire [2:0] Imm_Type_Out;
wire 	   ladder_Src_Out;
wire       ALU_Src_Out;
wire [3:0] ALU_Control_Out;
wire       decoder_dm_wren;
wire [7:0] Branch_Cond_Out;
wire       Load_Unsigned_Out;
wire [1:0] Load_Size_Out;
wire [2:0] Result_Src_Out;
wire       Jump_Out;

//register_file.v wires
wire [31:0] src_data1_out;
wire [31:0] src_data2_out;

//ALU_Src_MUX.v wire
wire [31:0] src2_out;

//ALU.v wire
wire [31:0] ALU_Result_out; 

//Branch_Comparator.v
wire Branch_Taken_Out;
wire Branch_Enable;

assign Branch_Enable = (Instruction_Out[6:0] == 7'b1100011);

//Extend_Unit.v wires
wire [31:0] Imm_out;

//Imm_adder.v wires
wire [31:0] Added_data_out;

//Store_Unit.v wires
wire [31:0] DM_Addr_Out;
wire [31:0] DM_WrData_Out;
wire [3:0]  DM_WrMask_Out;
wire        store_dm_wren;

//from WrBack MUX wire
wire [31:0]WB_Data_Out;

//Data_memory.v wire 
wire [31:0] Read_Data_Out;

//Load_Unit.v wires
wire [31:0] Loaded_Data_Out;

//these 2 for Branch instr.
//assign Branch_Taken   = Branch_Taken_Out;
//assign Target_Address = Next_PC_Out;

//these 2 for JAL & JALR
assign Branch_Taken   = PC_Sel;
assign Target_Address = Next_PC_Out;

//module instantiation

//PC_unit.v
PC_Unit u_pc (
.clk(clk),
.rst(rst),
.PC_out(PC_out),
.Branch_Taken(Branch_Taken),
.Target_Address(Target_Address),
.PC_plus4_out(PC_plus4_out)
);   

//PC_Src_MUX.v 
PC_Src_MUX u_PCsrcmux(
    .PC_plus4_in(PC_plus4_out),
    .Added_data_in(Added_data_out),
    .PC_Sel(PC_Sel),
    .Next_PC_Out(Next_PC_Out)
);

//Instruction_memory.v
Instruction_memory u_instrmem(
.PC_in(PC_out),
.Instruction_Out(Instruction_Out)
);


//Decoder.v
Decoder u_decoder (
.opcode_in(Instruction_Out[6:0]),
.funct3_in(Instruction_Out[14:12]),
.funct7_in(Instruction_Out[31:25]),
.Reg_WrEn_Out(Reg_WrEn_Out),
.Imm_Type_Out(Imm_Type_Out),
.ladder_Src_Out(ladder_Src_Out),
.ALU_Src_Out(ALU_Src_Out),
.ALU_Control_Out(ALU_Control_Out),
.DM_WrEn_Out(decoder_dm_wren),
.Branch_Cond_Out(Branch_Cond_Out),
.Load_Unsigned_Out(Load_Unsigned_Out),
.Load_Size_Out(Load_Size_Out),
.Result_Src_Out(Result_Src_Out),
.Jump_Out(Jump_Out)
);

//register_file.v
register_file u_rf(
.clk(clk),
.rst(rst),
.WrEn_in(Reg_WrEn_Out),
.des_addr_in(Instruction_Out[11:7]),
.des_data_in(WB_Data_Out),
.src_addr1_in(Instruction_Out[19:15]),
.src_addr2_in(Instruction_Out[24:20]),
.src_data1_out(src_data1_out),
.src_data2_out(src_data2_out)
);

//ALU_Src_MUX.v
ALU_Src_MUX u_alusrc(
.reg_data_in(src_data2_out),
.imm_data_in(Imm_out),
.ALU_Src_Sel(ALU_Src_Out),
.src2_out(src2_out )
);

//ALU 
ALU u_alu (
.src1_in(src_data1_out),
.src2_in(src2_out ),
.ALU_Control_in(ALU_Control_Out),
.ALU_Result_out(ALU_Result_out) 
);


//Branch_Comparator.v
Branch_Comparator u_BranchComp(
.RD1_in(src_data1_out),
.RD2_in(src_data2_out),
.Branch_Type_sel(Instruction_Out[14:12]),
.Branch_Enable(Branch_Enable),
.Branch_Taken_Out(Branch_Taken_Out)
);

//Extend_Unit.v
Extend_Unit u_ext(
.instr_in(Instruction_Out),
.Imm_type_in(Imm_Type_Out),
.Imm_out(Imm_out)
);

//Imm_adder.v
Imm_Adder u_immadd (
.ladder_src_in(ladder_Src_Out),
.PC_in(PC_out),
.Src_Data1_in(src_data1_out), //by MUX
.imm_Data_in(Imm_out),
.Added_data_out(Added_data_out)
);

// Store_Unit.v 
 Store_Unit u_store (
.DM_WrEn_In(decoder_dm_wren),
.Func3_In(Instruction_Out[14:12]),
.Added_Data_In(Added_data_out),
.Src_Data2_In(src_data2_out),
.DM_Addr_Out(DM_Addr_Out),
.DM_WrData_Out(DM_WrData_Out),
.DM_WrMask_Out(DM_WrMask_Out),
.DM_WrEn_Out(store_dm_wren)     
 );
 
//WB_MUX.v
WB_MUX u_WBmux(
.ALU_Result_in(ALU_Result_out),
.Loaded_data_in(Loaded_Data_Out),
.PC_plus4_in(PC_plus4_out),
.Imm_in(Imm_out),
.Added_data_in(Added_data_out),
.Result_Src_in(Result_Src_Out),
.WB_Data_Out(WB_Data_Out)
); 
 
 //Data_memory.v
 Data_Memory u_DM(
 .clk(clk),
 .DM_Addr_in(DM_Addr_Out),
 .DM_WrData_in(DM_WrData_Out),
 .DM_WrMask_in(DM_WrMask_Out),
 .DM_WrEn_in(store_dm_wren),
 .Read_Data_Out(Read_Data_Out)
 );
 
 //Load_Unit.v
 Load_Unit u_load(
 .Read_Data_In(Read_Data_Out),
 .Load_Size_In(Load_Size_Out),
 .Load_Unsigned_In(Load_Unsigned_Out),
 .Loaded_Data_Out(Loaded_Data_Out)
 );
 
 endmodule
