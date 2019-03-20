//this module is used to connected the lfsr and clock modules
//mainly used to scale the clock on the basys3 board
module top
    (
    input top_CCLK,
    input wire top_reset,
    output wire top_max_tick_reg,
    output wire [13:0] top_lfsr_out,
    output wire top_clk
    );
    
    //this is a clock module used to scale the basys3 boards clock by 50 million
    clock clock(.CCLK(top_CCLK), .clkscale(50000000), .clk(top_clk));   
    //instantiating the lfsr with the new scaled clock signal with a period of 1s
    LFSR lfsr(.clk(top_clk), .reset(top_reset), .lfsr_out(top_lfsr_out), .max_tick_reg(top_max_tick_reg));
     
endmodule
