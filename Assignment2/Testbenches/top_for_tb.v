//this module is my top level module that intantiates all my modules and form the connections
module top
    (
    input top_clk,
    input wire top_reset,
    output wire top_max_tick_reg, seq_detection, pause_clk,
    output wire [3:0] seg_count0, seg_count1, seg_count2, seg_count3
    );
    
    wire top_lfsr_out;
                   
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
                 .reset(top_reset), 
                 .seq_count(seq_detection),
                 .max_tick(top_max_tick_reg), 
                 .count0_reg(seg_count0), 
                 .count1_reg(seg_count1), 
                 .count2_reg(seg_count2), 
                 .count3_reg(seg_count3),
                 .pause_clk(pause_clk));

endmodule
