// The `timescale directive specifies that
// the simulation time unit is 1 ns  and
// the simulation timestep is 1 ps
`timescale 1 ns/1 ps 

module top_tb;

   // signal declaration
   reg test_clk, test_reset;
   wire test_max_tick, test_seq_detection, test_pause_clk;
   wire [3:0] test_seg_count0, test_seg_count1, test_seg_count2, test_seg_count3;
   parameter T = 2;
   integer i = 0;

   // instantiate the d_type_ff module
   top uut 
        (
        .top_clk(test_clk), 
        .top_reset(test_reset), 
        .top_max_tick_reg(test_max_tick),
        .seq_detection(test_seq_detection),
        .pause_clk(test_pause_clk),
        .seg_count0(test_seg_count0),
        .seg_count1(test_seg_count1),
        .seg_count2(test_seg_count2),
        .seg_count3(test_seg_count3)
        );
     
   always
   begin
      test_clk = 1'b1;
      #(T/2);
      test_clk = 1'b0;
      #(T/2);
      i = i + 1;
   end
   
   initial
   begin
      test_reset = 1'b1;
      #(2*T);
      test_reset = 1'b0;
      #2200000
      test_reset = 1'b1;
      #500
      test_reset = 1'b0;
      
   end
   
endmodule
