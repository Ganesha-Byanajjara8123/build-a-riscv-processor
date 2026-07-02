module tb_register_file;

reg clk;
reg rst;

reg WrEn_in;

reg [4:0] des_addr_in;
reg [31:0] des_data_in;

reg [4:0] src_addr1_in;
reg [4:0] src_addr2_in;

wire [31:0] src_data1_out;
wire [31:0] src_data2_out;


reg_file dut(
    .clk(clk),
    .rst(rst),
    .WrEn_in(WrEn_in),
    .des_addr_in(des_addr_in),
    .des_data_in(des_data_in),
    .src_addr1_in(src_addr1_in),
    .src_addr2_in(src_addr2_in),
    .src_data1_out(src_data1_out),
    .src_data2_out(src_data2_out)
);


always #5 clk = ~clk;


initial begin

    clk = 0;
    rst = 1;

    WrEn_in = 0;
    des_addr_in = 0;
    des_data_in = 0;

    src_addr1_in = 0;
    src_addr2_in = 0;

    #10;
    rst = 0;


    // Write 100 into x1
    WrEn_in = 1;
    des_addr_in = 5'd1;
    des_data_in = 32'd100;

    #10;


    // Write 200 into x2
    des_addr_in = 5'd2;
    des_data_in = 32'd200;

    #10;


    // Stop writing
    WrEn_in = 0;


    // Read x1 and x2
    src_addr1_in = 5'd1;
    src_addr2_in = 5'd2;

    #10;

    $display("x1 = %d", src_data1_out);
    $display("x2 = %d", src_data2_out);


    // Try writing to x0
    WrEn_in = 1;
    des_addr_in = 5'd0;
    des_data_in = 32'd999;

    #10;

    WrEn_in = 0;

    src_addr1_in = 5'd0;

    #10;

    $display("x0 = %d", src_data1_out);


    $finish;

end

endmodule
