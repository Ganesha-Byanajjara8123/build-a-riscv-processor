// TB code for Store_Unit
`timescale 1ns / 1ps

module tb_Store_Unit();

reg         DM_WrEn_In;
reg  [2:0]  Func3_In;
reg  [31:0] Added_Data_In;
reg  [31:0] Src_Data2_In;

wire [31:0] DM_Addr_Out;
wire [31:0] DM_WrData_Out;
wire [3:0]  DM_WrMask_Out;
wire        DM_WrEn_Out;


// DUT Instantiation

Store_Unit dut(

    .DM_WrEn_In(DM_WrEn_In),
    .Func3_In(Func3_In),
    .Added_Data_In(Added_Data_In),
    .Src_Data2_In(Src_Data2_In),

    .DM_Addr_Out(DM_Addr_Out),
    .DM_WrData_Out(DM_WrData_Out),
    .DM_WrMask_Out(DM_WrMask_Out),
    .DM_WrEn_Out(DM_WrEn_Out)
	);


initial begin

    $dumpfile("Store_Unit.vcd");
    $dumpvars(0,tb_Store_Unit);


    // Test Store Byte (SB)

    DM_WrEn_In    = 1'b1;
    Func3_In      = 3'b000;
    Added_Data_In = 32'h00000100;
    Src_Data2_In  = 32'h12345678;

    #10;

    $display("SB");
    $display("Address  = %h",DM_Addr_Out);
    $display("Data     = %h",DM_WrData_Out);
    $display("Mask     = %b",DM_WrMask_Out);


    // Test Store Halfword (SH)
    Func3_In = 3'b001;

    #10;

    $display("SH");
    $display("Address  = %h",DM_Addr_Out);
    $display("Data     = %h",DM_WrData_Out);
    $display("Mask     = %b",DM_WrMask_Out);



    // Test Store Word (SW)
    Func3_In = 3'b010;

    #10;

    $display("SW");
    $display("Address  = %h",DM_Addr_Out);
    $display("Data     = %h",DM_WrData_Out);
    $display("Mask     = %b",DM_WrMask_Out);


    $finish;

end

endmodule
