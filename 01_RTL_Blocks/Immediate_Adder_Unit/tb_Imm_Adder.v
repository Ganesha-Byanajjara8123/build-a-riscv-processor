
//tb code for Imm_Adder
module tb_Imm_Adder();
reg ladder_src_in;
reg [31:0] PC_in;
reg [31:0] Src_Data1_in;
reg [31:0] imm_Data_in;
wire [31:0] Added_data_out;

Imm_Adder dut(
    .ladder_src_in(ladder_src_in),
    .PC_in(PC_in),
    .Src_Data1_in(Src_Data1_in),
    .imm_Data_in(imm_Data_in),
    .Added_data_out(Added_data_out)
);

initial begin
$dumpfile("Imm_Adder.vcd");
$dumpvars(0,tb_Imm_Adder);
//declare default values for the inputs
PC_in        = 0;
Src_Data1_in = 0;
imm_Data_in  = 0;

//Test for ladder_src_in = 0
ladder_src_in = 0;
PC_in = 32'h00000010;
imm_Data_in = 32'h00000020;
#10;
$display("ladder_src_in = 0, Added_data_out = %h", Added_data_out);

//Test for ladder_src_in = 1
ladder_src_in = 1;
Src_Data1_in = 32'h00000030;
imm_Data_in = 32'h00000040;
#10;
$display("ladder_src_in = 1, Added_data_out = %h", Added_data_out);     
$finish;
end
endmodule
