//top module to instataniate the other modules
module top_module(
        input wire clk, rst_n, sh_en,
        output wire [3:0] an, 
        output wire [7:0] sseg, 
        output wire max_t,
        output wire [18:0] lfsr_sequence
    );
    
    wire [3:0] d2, d1, d0;
    wire clk_out;
    wire seq_det; 
    
    //instantiating all modules
    clock clock_module (.cclk(clk), .clk_scale(5000000), .clk_output(clk_out));
    
    lfsr_19bit lfsr_19bit (.clk(clk_out),.sh_en(sh_en), .rst_n(rst_n), .Q_out(lfsr_sequence), .max_tick_reg(max_t));
    
    fsm fsm_sequence_detect (.clk(clk_out), .rst_n(rst_n), .lfsr_out(lfsr_sequence[18]), .seq_detect(seq_det));
    
    disp_hex_mux seven_seg_display (.clk(clk), .reset(1'b0), .hex2(d2), .hex1(d1), .hex0(d0), .dp_in(4'b1111), .an(an), .sseg(sseg));
    
    counter pattern_counter (.clk(clk_out), .rst_n(rst_n), .lfsr_out(seq_det), .max_tick_reg(max_t), .d2(d2), .d1(d1), .d0(d0));
    
    //setting all 4 of the digits of the even_seg_display
    assign an = an | 4'b0000;
    
endmodule
