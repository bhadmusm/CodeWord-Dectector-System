module lfsr_19bit
  #(parameter seed = 19'b1110000010100000100)
  (input clk, sh_en, rst_n, 
   output [18:0] Q_out,
   output reg max_tick_reg);
  
  reg [18:0] Q_state;
  wire [18:0] Q_ns;
  wire Q_fb;
   
   
    // positive rising edge sentitive

  always @ (posedge clk, posedge rst_n) begin
    if (rst_n == 1'b0) begin
      Q_state <= seed;
      max_tick_reg <= 0;
    end else begin
      if (sh_en) begin
        Q_state <= Q_ns;
      end
      if (Q_state == seed) begin
        max_tick_reg <= 1;
      end else begin
        max_tick_reg <= 0;
      end
    end
  end
  
  //xor feedback
  assign Q_fb = Q_state[4] ^ Q_state[13] ^ Q_state[17] ^ Q_state[18];
  assign Q_ns = {Q_state[17:0], Q_fb};
  assign Q_out = Q_state;
  
endmodule

