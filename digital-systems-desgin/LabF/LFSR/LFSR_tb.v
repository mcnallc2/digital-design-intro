// The `timescale directive specifies that
// the simulation time unit is 1 ns  and
// the simulation timestep is 10 ps
`timescale 1 ns/10 ps 

module LFSR_tb;

   // signal declaration
   reg test_clk, test_reset;
   wire [13:0]test_out;
   wire max_tick;
   localparam T = 2;

   // instantiate the LFSR module
   LFSR uut 
        (
        .clk(test_clk), 
        .reset(test_reset), 
        .lfsr_out(test_out),
        .max_tick_reg(max_tick)
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
      test_reset = 1'b1;
      #(10*T);
      test_reset = 1'b0;
      #2100000;
      // stop simulation 
      $stop;
   end
   
endmodule