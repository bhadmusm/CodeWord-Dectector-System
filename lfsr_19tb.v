`timescale 1ns / 1ps
module TB_lfsr_19bit;

  // Testbench signals
  reg clk;
  reg sh_en;
  reg rst_n;
  wire [15:0] Q_out;
  wire max_tick_reg;
  
  // Clock generator
  parameter clk_period = 10;
  always #(clk_period/2)clk <= ~clk;
  
  // Instantiate UUT
  sixteenbit_lfsr uut (
    .clk(clk),
    .sh_en(sh_en),
    .rst_n(rst_n),
    .Q_out(Q_out),
    .max_tick_reg(max_tick_reg)
  );
  
  initial begin
    // Initialize the signals
    clk = 0;
    sh_en = 1;
    rst_n = 1;

    // Generate reset for 10 clock cycles
    #(clk_period*10)
    rst_n = 0;
    // Run testbench for (2^19)-1 clock cycles
    repeat (524287) @(posedge clk);
    $finish;
  end
   
endmodule

