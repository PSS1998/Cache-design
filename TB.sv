`timescale 1ns/1ns
module TB();
  
  logic clk=1,reset=1;
  logic [14:0] address;
  logic[31:0] data1, data2, data3, data4;
  logic Memread;
  logic Memwrite = 0;
  logic read = 1;
  logic [31:0] Out;
  logic[31:0] writeData;
  logic[13:0] counter_in;
  logic[13:0] counter_out;
  
  initial begin
    counter_in <= -1;
//    counter_out <= 0;
  end
  
  CacheMEM cache (counter_in, reset, clk, read, address, data1, data2, data3, data4, Memread, Out, counter_out);
  DataMemory memory (clk, address, writeData, Memread, Memwrite, data1, data2, data3, data4);
  
  always@(*)begin
    counter_in <= counter_out;
  end
//  assign counter_in = counter_out;
  
  initial repeat (32776)#60 clk=~clk;
  initial repeat (8194)#240 address=address+1;
  initial begin #240 reset=0; end
  initial begin #240 address = 1024; end
  initial begin address = 0; end
  
endmodule
