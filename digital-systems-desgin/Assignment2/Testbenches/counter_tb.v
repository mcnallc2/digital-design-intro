`timescale 1ns / 1ps

module counter_tb;

   // signal declaration
   reg test_clk, test_reset, test_seq_det, test_max_tick;
   wire [3:0] test_count0, test_count1, test_count2, test_count3;
   wire test_pause;
   
   localparam T = 2;
   integer i;
   // instantiate the LFSR module
   counter uut 
        (
        .clk(test_clk), 
        .reset(test_reset), 
        .seq_count(test_seq_det),
        .max_tick(test_max_tick),
        .count0_reg(test_count0),
        .count1_reg(test_count1),
        .count2_reg(test_count2),
        .count3_reg(test_count3),
        .pause_clk(test_pause)
        );
        
   always
   begin
      test_clk = 1'b0;
      #(T/2);
      test_clk = 1'b1;
      #(T/2);
   end
   
   initial
   begin
   test_max_tick = 1'b0;
   test_reset = 1'b1;
   #10
   test_reset = 1'b0;
   
   for(i=0; i<2000; i=i+1)
   begin
    test_seq_det = 1'b1;
    #2;
   end
   
   for(i=0; i<500; i=i+1)
   begin
    test_seq_det = 1'b0;
    #2;
   end
   
   for(i=0; i<2500; i=i+1)
   begin
    test_seq_det = 1'b1;
    #2;
   end
   
   test_max_tick = 1'b1;
   #100
   test_max_tick = 1'b0;
   #1000
   
   test_reset = 1'b1;
   #100
   test_reset = 1'b0;
   
   for(i=0; i<500; i=i+1)
   begin
    test_seq_det = 1'b1;
    #2;
   end

   // stop simulation 
   $stop;
   end
      
endmodule