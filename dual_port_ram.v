// Dual port ram PORT a amd PORT b

module Dual_port_ram #(parameter DATA_WIDTH=8, MEM_LENGTH=64) (
  output reg [DATA_WIDTH-1:0] data_out_a,data_out_b,
  input clk,rst,wen_a, wen_b,
  input [DATA_WIDTH-1:0] data_in_a,data_in_b,
  input [$clog2(MEM_LENGTH)-1:0] write_address_a, read_address_a, write_address_b, read_address_b
);
  
  // MEMORY declaration
  reg [DATA_WIDTH-1:0] RAM [0:MEM_LENGTH-1];
  
  // PORT a
  always @(posedge clk)
    begin
      if(!rst)
        data_out_a <= 8'd0;
      else
        begin
          if(wen_a)
            RAM[write_address_a] <= data_in_a;
          data_out_a <= RAM[read_address_a];
        end
    end
  
  // PORT b
  always @(posedge clk)
    begin
      if(!rst)
        data_out_b <= 8'd0;
      else
        begin
          if(wen_b)
            RAM[write_address_b] <= data_in_b;
          data_out_b <= RAM[read_address_b];
        end
    end
endmodule
