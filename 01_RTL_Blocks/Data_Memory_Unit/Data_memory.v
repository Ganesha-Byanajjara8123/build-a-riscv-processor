
`timescale 1ns / 1ps

module Data_Memory(
input clk,
input[31:0]DM_Addr_in,
input[31:0]DM_WrData_in,
input[3:0] DM_WrMask_in,
input      DM_WrEn_in,

output reg [31:0] Read_Data_Out
);

reg [7:0] memory [0:1023];

always @(posedge clk) begin 
	
if(DM_WrEn_in)
 
    case (DM_WrMask_in)
    
	4'b1111 : begin                                 //for SW(Store Word)
	memory[DM_Addr_in]     <= DM_WrData_in[7:0];  
	memory[DM_Addr_in + 1] <= DM_WrData_in[15:8];
	memory[DM_Addr_in + 2] <= DM_WrData_in[23:16];
	memory[DM_Addr_in + 3] <= DM_WrData_in[31:24];
	end
	
    
    4'b0011 : begin	                                 //for SH (Store HalfWord) 
	memory[DM_Addr_in]     <= DM_WrData_in[7:0];  
	memory[DM_Addr_in + 1] <= DM_WrData_in[15:8];
	end
	
	4'b0001 : begin                                    //for SB (Store Byte)
	memory[DM_Addr_in]     <= DM_WrData_in[7:0];  
	end
	default : begin
	end
               
endcase
end

always@(*)begin

Read_Data_Out  = {memory[DM_Addr_in + 3], memory[DM_Addr_in + 2], 
						memory[DM_Addr_in + 1], memory[DM_Addr_in]
                        
};
end

endmodule









/*
Address     = 100
WriteData   = 0x12345678
WriteMask   = 1111
WriteEnable = 1

SB=0001(Mask), SH=0011(Mask),
Let's understand the complete flow
Store (SW)
Instruction:

SW x5,8(x1)
↓
Register File
x1 = 100
x5 = ABCD1234
↓
Immediate
8
↓
Imm Adder
100 + 8 = 108
↓
Store Unit
Address =108
WriteData =ABCD1234
Mask =1111
WrEn=1
↓
Data Memory
Memory[108]=34
Memory[109]=12
Memory[110]=CD
Memory[111]=AB

Notice...
Data Memory stores bytes.
Load (LW)
LW x6,8(x1)
↓
Imm Adder
Address=108
↓
Data Memory
Reads
34
12
CD
AB
↓
Combines
ABCD1234
↓
Load Unit
Since it is LW
No sign extension required.
↓
WB MUX
↓
Register File
x6=ABCD1234
Now you can finally see why we built
Store Unit
Data Memory
Load Unit
as three separate blocks.
Each has a unique responsibility.

Why do we need Data Memory?
The Register File has only 32 registers.
x0
x1
...
x31

That isn't enough for real programs.
Suppose:
int array[1000];
Can we store 1000 integers in 32 registers?
❌ No.
So the CPU stores them in Data Memory.
Registers are for fast temporary values.
Memory is for large amounts of data
Step 3: Who talks to Data Memory?
Look at your architecture.
Register File
      │
      ▼
 Imm Adder
      │
 Address
      │
      ▼
 Store Unit
      │
      ▼
 Data Memory
      │
      ▼
 Load Unit
      │
      ▼
 WB MUX
      │
      ▼
 Register File

 /*
