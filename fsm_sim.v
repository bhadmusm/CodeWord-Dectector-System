`timescale 1ns / 1ps

//simplified fsm (not used for topmodule)
module fsm_sim (
  input clk,
  input rst_n,
  input lfsr_out,
  output reg seq_detect
);

//each state letter is for detecting each bit n the pattern
//using less states
  localparam RESET = 3'b000, A = 3'b001, B = 3'b010, C = 3'b011,
             D = 3'b100, E = 3'b101, F = 3'b110, G = 3'b111;

  reg [2:0] state;
  
// positive rising edge sentitive
  always @(posedge clk) begin
    if (!rst_n) begin
      state <= RESET;
    end else begin
      case (state)
        RESET: begin // Reset state
          if (lfsr_out == 1) begin
            state <= A;
          end else begin
            state <= RESET;
          end
        end
        A: begin // 1 is detected
          if (lfsr_out == 0) begin
            state <= B;
          end else begin
            state <= A;
          end
        end
        B: begin // 0 is detected
          if (lfsr_out == 1) begin
            state <= C;
          end else begin
            state <= A;
          end
        end
        C: begin // 1 is detected
          if (lfsr_out == 1) begin
            state <= D;
          end else begin
            state <= A;
          end
        end
        D: begin // 1 is detected
          if (lfsr_out == 1) begin
            state <= E;
          end else begin
            state <= A;
          end
        end
        E: begin // 1 is detected
          if (lfsr_out == 1) begin
            state <= F;
          end else begin
            state <= A;
          end
        end
        F: begin // 1 is detected
          if (lfsr_out == 1) begin
            state <= G;
          end else begin
            state <= A;
          end
        end
        G: begin // 1 is detected
          if (lfsr_out == 1) begin
            seq_detect <= 1;
            state <= RESET;
          end else begin
            state <= A;
          end
        end
      endcase
    end
  end
endmodule
