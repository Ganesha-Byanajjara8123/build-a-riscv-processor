`timescale 1ns / 1ps

module tb_Instruction_memory;
reg [31:0] PC_in;            
wire [31:0] Instruction_Out; 


//module instantiation
Instruction_memory u_instrmem(
.PC_in(PC_in),
.Instruction_Out(Instruction_Out)
);


//$readmemh("program.hex", u_instrmem.Instruction_mem);

initial begin

$dumpfile("Instruction_memory.vcd");
$dumpvars(0,tb_Instruction_memory);

    PC_in = 32'd0;
	#1;
	
    u_instrmem.Instruction_mem[0] = 8'h93;
    u_instrmem.Instruction_mem[1] = 8'h00;
    u_instrmem.Instruction_mem[2] = 8'hA0;
    u_instrmem.Instruction_mem[3] = 8'h00;
	#10;
	
	$display("instantiation_mem[0] = %h", u_instrmem.Instruction_mem[0]);
	$display("instantiation_mem[1] = %h", u_instrmem.Instruction_mem[1]);
	$display("instantiation_mem[2] = %h", u_instrmem.Instruction_mem[2]);
	$display("instantiation_mem[3] = %h", u_instrmem.Instruction_mem[3]);
	
	
		
if(Instruction_Out == 32'h00A00093)
$display("PASS : Instruction's PC 0");
else
$display("FAIL : Instruction's PC 0");


$finish;

end
endmodule







/*
For example, if the instruction is:

32'h00A00093    // addi x1, x0, 10

Then Instruction Memory stores:

memory[8]  = 8'h93
memory[9]  = 8'h00
memory[10] = 8'hA0
memory[11] = 8'h00

When PC = 8, the output should be reconstructed as:

instruction_out = { memory[11],
                    memory[10],
                    memory[9],
                    memory[8] };

which gives back:

32'h00A00093
/*
