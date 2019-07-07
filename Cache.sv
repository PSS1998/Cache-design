module CacheMEM(input[13:0] counter_in, input rst, clk, read, input [14:0] address, input[31:0] data1, input[31:0] data2, input[31:0] data3, input[31:0] data4, output logic Memread, output logic [31:0] Out, output logic [13:0] counter_out);

  logic[35:0] cache [4095:0];
  integer i;
  logic miss;
  logic miss1;
  logic miss2;
  logic miss3;
  logic[31:0] readData;
  logic write;
  
  always@(posedge clk) begin
    if(rst)begin
      for (i = 0; i < 4096; i = i + 1)
 	  	   cache[i][35] <= 0;
    end
    if(write)begin
      cache[address[11:0]][31:0] <= data1;
      cache[address[11:0]][35] <= 1;
      cache[address[11:0]][34:32] <= address[14:12];
      cache[address[11:0]+1][31:0] <= data2;
      cache[address[11:0]+1][35] <= 1;
      cache[address[11:0]+1][34:32] <= address[14:12];
      cache[address[11:0]+2][31:0] <= data3;
      cache[address[11:0]+2][35] <= 1;
      cache[address[11:0]+2][34:32] <= address[14:12];
      cache[address[11:0]+3][31:0] <= data4;
      cache[address[11:0]+3][35] <= 1;
      cache[address[11:0]+3][34:32] <= address[14:12];
    end
    
  end
  
  always@(posedge clk)begin
    if(miss)begin
      counter_out <= counter_in+1;
    end
    else begin
      counter_out <= counter_in;
    end
  end
  
  always@(*)begin
    readData <= cache[address[11:0]][31:0];
    miss1 <= (cache[address[11:0]][34:32] == address[14:12])?1'b0:1'b1;
    miss2 <= cache[address[11:0]][35]?1'b0:1'b1;
    miss3 <= ~miss1?~miss2?1'b0:1'b1:1'b1;
    miss <= read?miss3:1'b0;
//  assign miss = read?(cache[address[11:0]][35]?((cache[address[11:0]][34:32] == address[14:12])?1'b0:1'b1):1'b1):1'b0;
//  assign miss = 1'b1;
    Memread <= miss?1'b1:1'b0;
    Out <= miss?data1:readData;
    write <= miss?1'b1:1'b0;
  end
  
/*  assign readData = cache[address[11:0]][31:0];
  assign miss1 = (cache[address[11:0]][34:32] == address[14:12])?1'b0:1'b1;
  assign miss2 = cache[address[11:0]][35]?1'b0:1'b1;
  assign miss3 = ~miss1?~miss2?1'b0:1'b1:1'b1;
  assign miss = read?miss3:1'b0;
//  assign miss = read?(cache[address[11:0]][35]?((cache[address[11:0]][34:32] == address[14:12])?1'b0:1'b1):1'b1):1'b0;
//  assign miss = 1'b1;
  assign Memread = miss?1'b1:1'b0;
  assign out = miss?data1:readData;
  assign write = miss?1'b1:1'b0;
  */


endmodule