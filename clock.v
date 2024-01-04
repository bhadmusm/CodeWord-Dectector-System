//clock module
module clock(input wire cclk,
     input wire [31:0] clk_scale,
     output reg clk_output );
     
    reg [31:0] clkq = 0;
    
    // positive rising edge sentitive
    always@(posedge cclk)
        begin
          clkq = clkq + 1;
              if(clkq >= clk_scale)
                  begin
                      clk_output = ~clk_output;
                      clkq = 0;
                  end
        end
        
endmodule
