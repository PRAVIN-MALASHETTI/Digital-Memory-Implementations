// Single port ram 

module Single_port_ram #(parameter DATA_WIDTH=8,MEM_LENGTH=64) (
  output reg [DATA_WIDTH-1:0]data_out,
  input clk,rst,write_en,
  input [DATA_WIDTH-1:0] data_in,
  input [$clog2(MEM_LENGTH)-1:0] write_address, read_address
);
  
  // memeory declaration
  reg [DATA_WIDTH-1:0] RAM [MEM_LENGTH-1:0];
  
  always @(posedge clk)
    begin
      if(!rst)
        data_out <= 8'd0;
      else
        begin
          if(write_en)
            RAM[write_address] <= data_in;
          data_out <= RAM[read_address];
        end
    end  
endmodule

