`timescale 1ns / 1ps

module tb_Dual_port_ram;

  integer i;
  parameter DATA_WIDTH = 8;
  parameter MEM_LENGTH = 64;

  reg clk;
  reg rst;
  reg wen_a;
  reg wen_b;
  reg [DATA_WIDTH-1:0] data_in_a;
  reg [DATA_WIDTH-1:0] data_in_b;
  reg [$clog2(MEM_LENGTH)-1:0] write_address_a;
  reg [$clog2(MEM_LENGTH)-1:0] read_address_a;
  reg [$clog2(MEM_LENGTH)-1:0] write_address_b;
  reg [$clog2(MEM_LENGTH)-1:0] read_address_b;
  wire [DATA_WIDTH-1:0] data_out_a;
  wire [DATA_WIDTH-1:0] data_out_b;

  Dual_port_ram #(DATA_WIDTH, MEM_LENGTH) uut (
    .data_out_a(data_out_a),
    .data_out_b(data_out_b),
    .clk(clk),
    .rst(rst),
    .wen_a(wen_a),
    .wen_b(wen_b),
    .data_in_a(data_in_a),
    .data_in_b(data_in_b),
    .write_address_a(write_address_a),
    .read_address_a(read_address_a),
    .write_address_b(write_address_b),
    .read_address_b(read_address_b)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    wen_a = 0;
    wen_b = 0;
    data_in_a = 0;
    data_in_b = 0;
    write_address_a = 0;
    read_address_a = 0;
    write_address_b = 0;
    read_address_b = 0;

    #10 rst = 0;
    #10 rst = 1;

    write_address_a = 7'd0;
    data_in_a = 8'd42;
    wen_a = 1;
    #10 wen_a = 0;
    read_address_a = 7'd0;
    #10;

    write_address_b = 7'd1;
    data_in_b = 8'd84;
    wen_b = 1;
    #10 wen_b = 0;
    read_address_b = 7'd1;
    #10;

    write_address_a = 7'd2;
    data_in_a = 8'd126;
    wen_a = 1;
    #10 wen_a = 0;
    read_address_a = 7'd2;
    #10;

    write_address_b = 7'd3;
    data_in_b = 8'd168;
    wen_b = 1;
    #10 wen_b = 0;
    read_address_b = 7'd3;
    #10;

    #10;
    $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,tb_Dual_port_ram);
  end
  
  always @(uut.RAM) begin
    for(i=0;i<64;i=i+1)
      $display("RAM[%0d]=%d",i,uut.RAM[i]);
    $display();
  end
endmodule
