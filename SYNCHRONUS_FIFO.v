`timescale 1ns / 1ps

module sync_fifo #(parameter depth=8,
parameter width=8
)(input wire [width-1:0]data_in,
input wire clk, 
input wire  wr_en,
input wire rd_en,
input wire reset,
output reg full,
output reg [width-1:0] data_out,
output reg empty
);

localparam adress = $clog2(depth);

reg [width-1:0] fifo [depth-1:0];
reg [adress-1:0] w_ptr,r_ptr;
reg[adress:0] count;

always @(posedge clk)begin
if(reset) begin
w_ptr <=0;
r_ptr <=0;
full <=0;
empty <=1;
count <=0;
end
else begin
if(wr_en&&!full) begin
fifo[w_ptr] <=data_in;
w_ptr <=w_ptr+1;
count <=count+1;
end

if(rd_en&&!empty) begin
data_out <= fifo[r_ptr];
r_ptr <=r_ptr+1;
count<=count-1;


end
end

full<=(count==depth);
empty<=(count==0);

end
endmodule














  

