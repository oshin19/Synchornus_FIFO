`timescale 1ns / 1ps

module sync_fifo_tb;

  parameter depth = 8;
  parameter width = 8;

  reg clk;
  reg reset;
  reg wr_en, rd_en;
  reg [width-1:0] data_in;
  wire [width-1:0] data_out;
  wire full, empty;

  sync_fifo #(depth, width) dut (
    .data_in(data_in),
    .clk(clk),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .reset(reset),
    .full(full),
    .data_out(data_out),
    .empty(empty)
  );

 
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  
  initial begin
    
    reset = 1;
    wr_en = 0;
    rd_en = 0;
   

    #10;
    reset = 0;

    
    #10;

   
    wr_en = 1;#15;
    
    data_in = 8'd0; #10;
    data_in = 8'd1; #10;
    data_in = 8'd2; #10;
    data_in = 8'd3; #10;
    data_in = 8'd4; #10;
    data_in = 8'd5; #10;


    wr_en = 0;

    
    #10;

  
    rd_en = 1;
    #80; 

    
    $finish;
  end

endmodule
