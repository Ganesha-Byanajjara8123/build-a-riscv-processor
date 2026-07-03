module tb_PC_Unit;

reg clk;
reg rst;
reg Branch_Taken;
reg [31:0] Target_Address;

wire [31:0] PC_out;
wire [31:0] PC_plus4_out;

PC_Unit dut(
    .clk(clk),
    .rst(rst),
    .Branch_Taken(Branch_Taken),
    .Target_Address(Target_Address),
    .PC_out(PC_out),
    .PC_plus4_out(PC_plus4_out)
);

always #5 clk = ~clk;

initial begin

    // Generate waveform
    $dumpfile("pc_wave.vcd");
    $dumpvars(0, tb_PC_Unit);

    clk = 0;
    rst = 1;
    Branch_Taken = 0;
    Target_Address = 32'h00000000;

    #10;
    rst = 0;

    // PC = 0 -> 4 -> 8
    #20;
  
    // Branch to 0x100
    Branch_Taken = 1;
    Target_Address = 32'h00000100;

    #10;

      // Branch to 0x200
    Branch_Taken = 1;
    Target_Address = 32'h00000200;
    #10;

    // Continue from 0x100
    Branch_Taken = 0;

    #20;

    $finish;

end

endmodule
