`timescale 1ns / 1ps

module fsm_TB(
  
  reg clk;
  reg rst_n;
  reg lfsr_out;
  wire seq_detect;
  
  // Instantiate the FSM module
  fsm uut (
    .clk(clk),
    .rst_n(rst_n),
    .lfsr_out(lfsr_out),
    .seq_detect(seq_detect)
  );
  
  // Clock generator
  always #5 clk <= ~clk;
  
  initial begin
    // Initialize the signals
    clk = 0;
    rst_n = 0;
    lfsr_out = 0;
    
    // set reset after 10 clock cycles
    #(10 * 5)
    rst_n = 1;
    
    // Test pattern detection
    // Send 101111111111 to the FSM
    //seq_detect should be 1 after 13 clock cycles
    #(5)
    lfsr_out = 1'b1;  
    #(5)
    lfsr_out = 1'b0;
    #(5)
    lfsr_out = 1'b1;
    #(5)
    lfsr_out = 1'b1;
    #(5)
    lfsr_out = 1'b1;
    #(5)
    lfsr_out = 1'b1;
    #(5)
    lfsr_out = 1'b1;
    #(5)
    lfsr_out = 1'b1;
    #(5)
    lfsr_out = 1'b1;
    #(5)
    lfsr_out = 1'b1;
    #(5)
    lfsr_out = 1'b1;
    #(5)
    
    $finish;
  end
  
endmodule
