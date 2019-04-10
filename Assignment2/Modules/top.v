//this module is my top level module that intantiates all my modules and forms the connections
module top
    (
    input top_CCLK,
    input wire top_reset,
    input wire choose_freq,
    output wire seq_detection,
    output wire [3:0] an,
    output wire [7:0] seven_seg,
    output wire pause_clk
    );

    //these wires form the connections between the modules
    wire top_lfsr_out, top_clk, top_max_tick_reg;
    wire [3:0] seg_count0, seg_count1, seg_count2, seg_count3;
    wire [31:0] clk_freq;
    
    //this is a clock module used to scale the basys3 boards clock by 100000
    clock clock(.CCLK(top_CCLK), 
                .clkscale(clk_freq), 
                .clk(top_clk)); 
                
    //instantiates the selected clock frequency module                     
    clock_scale scaler(.clk(top_clk),
                       .choose_freq(choose_freq),//this is selection
                       .clk_freq(clk_freq));//this is the outpur scale 
                
    //instantiating the lfsr with the new scaled clock signal
    lfsr lfsr(.clk(top_clk),
              .reset(top_reset), 
              .lfsr_out(top_lfsr_out), 
              .max_tick_reg(top_max_tick_reg));
    
    //this module recieves the bits that are shifted from the lfsr and uses FSMs to detect the sequence 
    sequence_detector seq_det(.clk(top_clk), 
                              .reset(top_reset), 
                              .lfsr_out(top_lfsr_out), 
                              .seq_det_out(seq_detection));
    
    //this module counts the number of times a sequence is detected      
    counter cntr(.clk(top_clk), 
                 .reset(top_reset), //reset the counter with both reset and max tick
                 .seq_count(seq_detection), 
                 .max_tick(top_max_tick_reg),
                 .count0_reg(seg_count0), 
                 .count1_reg(seg_count1), 
                 .count2_reg(seg_count2), 
                 .count3_reg(seg_count3),
                 .pause_clk(pause_clk));   
                               
    //instantiates the 4-digit 7-seg LED display module
    disp_hex_mux display(.clk(top_CCLK), 
                         .reset(top_reset),
                         .hex0(seg_count0), 
                         .hex1(seg_count1), 
                         .hex2(seg_count2), 
                         .hex3(seg_count3),
                         .dp_in(4'b1111), //this turns off all the decimal points
                         .an(an), 
                         .sseg(seven_seg)); 

endmodule