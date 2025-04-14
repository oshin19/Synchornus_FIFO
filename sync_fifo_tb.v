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

  // DUT instance
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

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Stimulus
  initial begin
    // Initial values
    reset = 1;
    wr_en = 0;
    rd_en = 0;
    data_in = 8'd0;

    // Hold reset
    #10;
    reset = 0;

    // Wait 1 clock after reset to avoid data loss
    #10;

    // Write 6 values into FIFO
    wr_en = 1;
    data_in = 8'd0; #10;
    data_in = 8'd1; #10;
    data_in = 8'd2; #10;
    data_in = 8'd3; #10;
    data_in = 8'd4; #10;
    data_in = 8'd5; #10;

    // Stop writing
    wr_en = 0;

    // Wait one cycle before reading
    #10;

    // Start reading
    rd_en = 1;
    #70; // Read out all written values with clock (6 x 10ns)

    // Finish simulation
    $finish;
  end

endmodule
