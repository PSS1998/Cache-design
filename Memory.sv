module DataMemory(input clk, input[14:0] address, input[31:0] writeData, input read, write, output logic [31:0] readData1, readData2, readData3, readData4);
  
  logic[31:0] RAM [32767:0];
  integer i;
  
	initial  begin
	  for (i = 1024; i < 9216; i = i + 1)
 	  	   RAM[i]<= i;
	end


  
  always@(posedge clk)begin
    if(write)
      RAM[address] <= writeData;
  end
  
  assign readData1 = read?RAM[address]:32'b0;
  assign readData2 = read?RAM[address+1]:32'b0;
  assign readData3 = read?RAM[address+2]:32'b0;
  assign readData4 = read?RAM[address+3]:32'b0;

  
endmodule


