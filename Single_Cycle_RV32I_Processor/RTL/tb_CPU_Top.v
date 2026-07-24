//====================================================================
// tb_CPU_Top.v - self-checking testbench for the single-cycle core.
// Set NUM_CYCLES and VERBOSE per test before compiling.
//====================================================================
`timescale 1ns / 1ps

module tb_CPU_Top;

parameter NUM_CYCLES = 20;   // <-- set per test program
parameter VERBOSE    = 0;    // 1 = full per-cycle trace, 0 = summary only

reg clk, rst;
integer cycle    = 0;
integer errors   = 0;
integer i;
reg     sim_done = 0;

CPU_Top dut (
    .clk(clk),
    .rst(rst)
);

always #5 clk = ~clk;

reg [31:0] expected [0:31];
reg        check_reg [0:31];
reg        check_mem [0:7];
reg [31:0] mem_addr  [0:7];
reg [31:0] expected_mem [0:7];

initial begin
    for (i = 0; i <= 31; i = i + 1) check_reg[i] = 0;
    for (i = 0; i <= 7;  i = i + 1) check_mem[i]  = 0;

`ifdef TEST_ALU
    // program_alu.s
    check_reg[1]  = 1; expected[1]  = 32'd10;
    check_reg[2]  = 1; expected[2]  = 32'd20;
    check_reg[3]  = 1; expected[3]  = 32'd30;
    check_reg[4]  = 1; expected[4]  = 32'd10;
    check_reg[5]  = 1; expected[5]  = 32'd0;
    check_reg[6]  = 1; expected[6]  = 32'd30;
    check_reg[7]  = 1; expected[7]  = 32'd30;
    check_reg[8]  = 1; expected[8]  = 32'h00A00000;
    check_reg[9]  = 1; expected[9]  = 32'd0;
    check_reg[10] = 1; expected[10] = 32'd0;
    check_reg[11] = 1; expected[11] = 32'd1;
    check_reg[12] = 1; expected[12] = 32'd1;
    check_reg[13] = 1; expected[13] = 32'd30;
    check_reg[14] = 1; expected[14] = 32'h12345000;
    check_reg[15] = 1; expected[15] = 32'h0000003c;  // ASSUMPTION: AUIPC routes
                                                       // through WB_MUX Added_data_in
                                                       // for Result_Src=100 -- not
                                                       // yet confirmed from WB_MUX.v
    check_mem[0] = 1; mem_addr[0] = 32'd100; expected_mem[0] = 32'd30;

`elsif TEST_BRANCH
    // program_branch.s (fixed - guard/target separated)
    check_reg[3]  = 1; expected[3]  = 32'd0;
    check_reg[4]  = 1; expected[4]  = 32'd123;
    check_reg[7]  = 1; expected[7]  = 32'd0;
    check_reg[8]  = 1; expected[8]  = 32'd123;
    check_reg[11] = 1; expected[11] = 32'd0;
    check_reg[12] = 1; expected[12] = 32'd123;
    check_reg[15] = 1; expected[15] = 32'd0;
    check_reg[16] = 1; expected[16] = 32'd123;
    check_reg[19] = 1; expected[19] = 32'd0;
    check_reg[20] = 1; expected[20] = 32'd123;
    check_reg[23] = 1; expected[23] = 32'd0;
    check_reg[24] = 1; expected[24] = 32'd123;

`elsif TEST_JUMP
    // program_jump_system.s (fixed - call/return pattern)
    check_reg[1] = 1; expected[1] = 32'd4;
    check_reg[2] = 1; expected[2] = 32'd0;
    check_reg[3] = 1; expected[3] = 32'd123;
    check_reg[4] = 1; expected[4] = 32'd16;
    check_reg[5] = 1; expected[5] = 32'd55;
    check_reg[6] = 1; expected[6] = 32'd1;
    check_reg[7] = 1; expected[7] = 32'd0;

`elsif TEST_ISA_COVERAGE
    // program_isa_coverage.s : distinguishing AND/OR/XOR, byte/halfword
    // loads with sign/zero extension, large-value LW diagnostic, I-type ALU
    check_reg[3]  = 1; expected[3]  = 32'd8;
    check_reg[4]  = 1; expected[4]  = 32'd14;
    check_reg[5]  = 1; expected[5]  = 32'd6;
    check_reg[8]  = 1; expected[8]  = 32'hFFFFFFC8;
    check_reg[9]  = 1; expected[9]  = 32'd200;
    check_reg[10] = 1; expected[10] = 32'd200;
    check_reg[11] = 1; expected[11] = 32'hFFFFFFFF;
    check_reg[12] = 1; expected[12] = 32'h0000FFFF;
    check_reg[15] = 1; expected[15] = 32'd3;
    check_reg[16] = 1; expected[16] = 32'd15;
    check_reg[17] = 1; expected[17] = 32'd8;
    check_reg[18] = 1; expected[18] = 32'd28;
    check_reg[19] = 1; expected[19] = 32'd3;
    check_reg[20] = 1; expected[20] = 32'd3;
    check_reg[21] = 1; expected[21] = 32'd1;
    check_reg[22] = 1; expected[22] = 32'd0;

    check_mem[0] = 1; mem_addr[0] = 32'd0; expected_mem[0] = 32'd200;
    check_mem[1] = 1; mem_addr[1] = 32'd4; expected_mem[1] = 32'hFFFFFFFF;

`else
    $display("*** WARNING: no TEST_* macro defined for this build.");
    $display("*** Self-check will verify ZERO registers this run.");
`endif
end

always @(posedge clk) begin
    #1;
    cycle = cycle + 1;

    if (VERBOSE && !sim_done) begin
        $display("\n----- CYCLE %0d -----", cycle);
        $display("PC=%h  Instr=%h", dut.PC_out, dut.Instruction_Out);
        $display("BranchTaken=%b  JumpOut=%b  NextPC=%h",
                  dut.Branch_Taken_Out, dut.Jump_Out, dut.Next_PC_Out);
        $display("x1=%h x2=%h x3=%h x4=%h x5=%h x6=%h x7=%h x8=%h",
                  dut.u_rf.my_regs[1], dut.u_rf.my_regs[2], dut.u_rf.my_regs[3], dut.u_rf.my_regs[4],
                  dut.u_rf.my_regs[5], dut.u_rf.my_regs[6], dut.u_rf.my_regs[7], dut.u_rf.my_regs[8]);
        $display("x9=%h x10=%h x11=%h x12=%h x13=%h x14=%h x15=%h x16=%h",
                  dut.u_rf.my_regs[9], dut.u_rf.my_regs[10], dut.u_rf.my_regs[11], dut.u_rf.my_regs[12],
                  dut.u_rf.my_regs[13], dut.u_rf.my_regs[14], dut.u_rf.my_regs[15], dut.u_rf.my_regs[16]);
        $display("x17=%h x18=%h x19=%h x20=%h x21=%h x22=%h x23=%h x24=%h",
                  dut.u_rf.my_regs[17], dut.u_rf.my_regs[18], dut.u_rf.my_regs[19], dut.u_rf.my_regs[20],
                  dut.u_rf.my_regs[21], dut.u_rf.my_regs[22], dut.u_rf.my_regs[23], dut.u_rf.my_regs[24]);
    end
end

initial begin
    $dumpfile("CPU_Top.vcd");
    $dumpvars(0, tb_CPU_Top);

    rst = 1;
    clk = 0;
    #10;
    rst = 0;

    repeat (NUM_CYCLES) @(posedge clk);
    #1;
    sim_done = 1;

    $display("\n========== FINAL REGISTER VALUES ==========");
    for (i = 0; i <= 24; i = i + 1)
        $display("x%0d = %h", i, dut.u_rf.my_regs[i]);

    $display("\n========== SELF-CHECK: REGISTERS ==========");
    for (i = 0; i <= 31; i = i + 1) begin
        if (check_reg[i]) begin
            if (dut.u_rf.my_regs[i] === expected[i])
                $display("PASS  x%0d = %0d (expected %0d)", i, dut.u_rf.my_regs[i], expected[i]);
            else begin
                $display("FAIL  x%0d = %0d (expected %0d)", i, dut.u_rf.my_regs[i], expected[i]);
                errors = errors + 1;
            end
        end
    end

    $display("\n========== SELF-CHECK: MEMORY ==========");
    for (i = 0; i <= 7; i = i + 1) begin
        if (check_mem[i]) begin
            if ({dut.u_DM.memory[mem_addr[i]+3], dut.u_DM.memory[mem_addr[i]+2],
                 dut.u_DM.memory[mem_addr[i]+1], dut.u_DM.memory[mem_addr[i]]} === expected_mem[i])
                $display("PASS  mem[%0d] = %0d (expected %0d)", mem_addr[i],
                          {dut.u_DM.memory[mem_addr[i]+3], dut.u_DM.memory[mem_addr[i]+2],
                           dut.u_DM.memory[mem_addr[i]+1], dut.u_DM.memory[mem_addr[i]]}, expected_mem[i]);
            else begin
                $display("FAIL  mem[%0d] = %0d (expected %0d)", mem_addr[i],
                          {dut.u_DM.memory[mem_addr[i]+3], dut.u_DM.memory[mem_addr[i]+2],
                           dut.u_DM.memory[mem_addr[i]+1], dut.u_DM.memory[mem_addr[i]]}, expected_mem[i]);
                errors = errors + 1;
            end
        end
    end

    $display("\n========== SUMMARY ==========");
    if (errors == 0)
        $display(">>> ALL CHECKS PASSED <<<");
    else
        $display(">>> %0d CHECK(S) FAILED <<<", errors);

    $finish;
end

endmodule
