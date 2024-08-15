`timescale 1ns / 1ps

module tb_Single_port_ram;

  // Parameters
  parameter DATA_WIDTH = 8;
  parameter MEM_LENGTH = 64;

  // Inputs
  reg clk;
  reg rst;
  reg write_en;
  reg [DATA_WIDTH-1:0] data_in;
  reg [$clog2(MEM_LENGTH)-1:0] write_address;
  reg [$clog2(MEM_LENGTH)-1:0] read_address;

  // Outputs
  wire [DATA_WIDTH-1:0] data_out;

  // Instantiate the Single_port_ram
  Single_port_ram #(DATA_WIDTH, MEM_LENGTH) dut (
    .data_out(data_out),
    .clk(clk),
    .rst(rst),
    .write_en(write_en),
    .data_in(data_in),
    .write_address(write_address),
    .read_address(read_address)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns clock period
  end

  // Test sequence
  initial begin
    // Initialize inputs
    rst = 1;
    write_en = 0;
    data_in = 0;
    write_address = 0;
    read_address = 0;

    // Reset the RAM
    #10 rst = 0;
    #10 rst = 1;

    // Test writing to RAM
    write_address = 7'd0;
    data_in = 8'd42;
    write_en = 1; // Enable writing
    #10 write_en = 0; // Disable writing

    // Read back from RAM
    read_address = 7'd0;
    #10; // Wait for a clock cycle
    $display("Data out (address 0): %d", data_out); // Should be 42

    // Write another value
    write_address = 7'd1;
    data_in = 8'd84;
    write_en = 1; // Enable writing
    #10 write_en = 0; // Disable writing

    // Read back the new value
    read_address = 7'd1;
    #10; // Wait for a clock cycle
    $display("Data out (address 1): %d", data_out); // Should be 84

    // Write value to another address
    write_address = 7'd2;
    data_in = 8'd126;
    write_en = 1; // Enable writing
    #10 write_en = 0; // Disable writing

    // Read back from address 2
    read_address = 7'd2;
    #10; // Wait for a clock cycle
    $display("Data out (address 2): %d", data_out); // Should be 126

    // Finish the simulation
    #10;
    $finish;
  end
  
  integer i;
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,tb_Single_port_ram);
  end
  
  always @(dut.RAM) begin
    for(i=0;i<64;i=i+1)
      $display("RAM[%0d]=%d",i,dut.RAM[i]);
    $display();
  end
endmodule
