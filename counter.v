module counter(
    input clk,
    input rst_n,
    input lfsr_out,
    input max_tick_reg,
    output wire [3:0] d2, d1, d0
    );

   // declaration
   reg [3:0] d2_reg, d1_reg, d0_reg;
   reg [3:0] d2_next, d1_next, d0_next;

   // register
   always @(posedge clk)
   begin
      d2_reg <= d2_next;
      d1_reg <= d1_next;
      d0_reg <= d0_next;
   end

   // 3-digit bcd counter
   always @*
   begin
      // default: keep the previous value
      d0_next = d0_reg;
      d1_next = d1_reg;
      d2_next = d2_reg;
      if (max_tick_reg)
         begin
            d0_next = 4'b0;
            d1_next = 4'b0;
            d2_next = 4'b0;
         end
      else if (lfsr_out)
         if (d0_reg != 9)
            d0_next = d0_reg + 1;
         else              // reach XX9
            begin
               d0_next = 4'b0;
               if (d1_reg != 9)
                  d1_next = d1_reg + 1;
               else       // reach X99
                  begin
                     d1_next = 4'b0;
                     if (d2_reg != 9)
                        d2_next = d2_reg + 1;
                     else // reach 999
                        d2_next = 4'b0;
                  end
            end
   end

   // output logic
   assign d0 = d0_reg;
   assign d1 = d1_reg;
   assign d2 = d2_reg;

endmodule