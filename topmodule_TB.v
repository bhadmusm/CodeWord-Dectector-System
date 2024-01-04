`timescale 1ns / 1ps

module topmodule_TB;


  reg clk;
  reg rst_n;
  reg sh_en;
  wire [3:0] an;
  wire [7:0] sseg;
  wire max_t;
  wire [18:0] lfsr_sequence;
  
  // Instantiate top module
  top_module uut (
    .clk(clk),
    .rst_n(rst_n),
    .sh_en(sh_en),
    .an(an),
    .sseg(sseg),
    .max_t(max_t),
    .lfsr_sequence(lfsr_sequence)
  );
  
  // Clock generator
  always #5 clk <= ~clk;
  
  initial begin
    // Initialize the signals
    clk = 0;
    rst_n = 0;
    sh_en = 0;
    
    // setting reset after 10 clock cycles
    #(10 * 5)
    rst_n = 1;
    
    // setting sh_en
    #(5)
    sh_en = 1;
    
    // loop to wait for sequence to be detected
    repeat (500) @(posedge clk);
    
    
    $finish;
  end
  
endmodule

