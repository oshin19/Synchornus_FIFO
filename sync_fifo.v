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
reg [adress-1:0] wr_ptr,rd_ptr;
reg[adress:0] count;

always @(posedge clk)begin
if(reset) begin
wr_ptr <=0;
rd_ptr <=0;
full <=0;
empty <=1;
count <=0;
end
else begin
if(wr_en&&!full) begin
fifo[wr_ptr] <=data_in;
wr_ptr <=wr_ptr+1;
count <=count+1;
end

if(rd_en&&!empty) begin
data_out <= fifo[rd_ptr];
rd_ptr <=rd_ptr+1;
count<=count-1;


end
end

full<=(count==depth);
empty<=(count==0);

end
endmodule














  

