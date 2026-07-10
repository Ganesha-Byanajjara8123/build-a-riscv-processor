// TB code for Load_Unit

module tb_Load_Unit();

reg [31:0] Read_Data_In;
reg [1:0]  Load_Size_In;
reg        Load_Unsigned_In;

wire [31:0] Loaded_Data_Out;


// DUT Instantiation

Load_Unit dut(

    .Read_Data_In(Read_Data_In),
    .Load_Size_In(Load_Size_In),
    .Load_Unsigned_In(Load_Unsigned_In),

    .Loaded_Data_Out(Loaded_Data_Out)

);


initial begin

    $dumpfile("Load_Unit.vcd");
    $dumpvars(0,tb_Load_Unit);
	
	Read_Data_In = 32'h12345678;

    // Load Byte (LB)

    Load_Size_In = 2'b00;
    Load_Unsigned_In = 1'b0;

    #10;

    $display("LB  = %h",Loaded_Data_Out);

    // Load Byte Unsigned (LBU)

    Load_Size_In = 2'b00;
    Load_Unsigned_In = 1'b1;

    #10;

    $display("LBU = %h",Loaded_Data_Out);

    // Load Halfword (LH)

    Load_Size_In = 2'b01;
    Load_Unsigned_In = 1'b0;

    #10;

    $display("LH  = %h",Loaded_Data_Out);
	
	// Load Halfword Unsigned (LHU)
    Load_Size_In = 2'b01;
    Load_Unsigned_In = 1'b1;

    #10;

    $display("LHU = %h",Loaded_Data_Out);

    // Load Word (LW)
    Load_Size_In = 2'b10;
    Load_Unsigned_In = 1'b0;

    #10;

    $display("LW  = %h",Loaded_Data_Out);


    $finish;

end

endmodule
