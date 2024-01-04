`timescale 1ns / 1ps
//unsimplified fsm module
module fsm(
  input clk, 
  input rst_n,
  input lfsr_out,
  output seq_detect 
);

//each state letter is for detecting each bit n the pattern 
//101111111111 -> ABCDEFGHIJKL
    localparam RESET = 4'b0000, A  = 4'b0001, B  = 4'b0010, C  = 4'b0011,  
                  D  = 4'b0100, E  = 4'b0101, F  = 4'b0110, G  = 4'b0111,  
                  H  = 4'b1000, I  = 4'b1001, J  = 4'b1010, K  = 4'b1011, L  = 4'b1100;  
    
  reg [3:0] current_state;
  reg [3:0] next_state;
  reg seq;
  
  //if the current state has reaches state L, the pattern has been detected and seq_detect is set as 1
  //assign seq_detect = (current_state == L) ? 1'b1 : 1'b0;
 
  // positive rising edge sentitive

  always @(posedge clk) begin
    if (!rst_n) begin
      current_state <= RESET;
    end else begin
      current_state <= next_state;
    end
  end
  
  always @(*) begin
    seq = 1'b0; 
    case (current_state)
    
      RESET: begin  // Reset state
        if (lfsr_out) begin
          next_state = A;
        end else begin
          next_state = RESET;
        end
      end
      
      A: begin  // 1 is detected
        if (!lfsr_out) begin
          next_state = B;
        end else begin
          next_state = A;
        end
      end
      
      B: begin  // 10 is detected
        if (lfsr_out) begin
          next_state = C;
        end else if (!lfsr_out) begin
          next_state = A;
        end
      end
      
      C: begin // 101 is detected
        if (lfsr_out) begin
          next_state = D;
        end else if (!lfsr_out) begin
          next_state = A;
        end
      end
      
      D: begin  // 1011 is detected
        if (lfsr_out) begin
          next_state = E;
        end else if (!lfsr_out) begin
          next_state = A;
        end
      end
      
      E: begin  // 10111 is detected
        if (lfsr_out) begin
          next_state = F;
        end else if (!lfsr_out) begin
          next_state = A;
        end
      end
      
      F: begin  // 101111 is detected
        if (lfsr_out) begin
          next_state = G;
        end else if (!lfsr_out) begin
          next_state = A;
        end
      end
      
      G: begin  // 1011111 is detected
        if (!lfsr_out) begin
          next_state = H;
        end else if (!lfsr_out) begin
          next_state = A;
        end
      end
      
      H: begin  // 10111111 is detected
       if (lfsr_out) begin
          next_state = I;
       end else if (!lfsr_out) begin
          next_state = A;
       end
     end
     
     I: begin   // 101111111 is detected
       if (lfsr_out) begin
          next_state = J;
       end else if (!lfsr_out) begin
          next_state = A;
       end
     end
     
     J: begin   // 1011111111 is detected
       if (lfsr_out) begin
          next_state = K;
       end else if (!lfsr_out) begin
          next_state = A;
       end
     end
     
     K: begin   // 10111111111 is detected
       if (lfsr_out) begin
          next_state = L;
       end else if (!lfsr_out) begin
          next_state = A;
       end
     end
     
     L: begin   // 101111111111(full sequence) is detected
       if (lfsr_out) begin
          next_state = A;
          seq = 1'b1;
       end else if (!lfsr_out) begin
          next_state = RESET;
       end
     end
     
       default: begin
          next_state = RESET;
       end
     
   endcase
 end
 assign seq_detect = seq; //assign seqeunce detection
endmodule
