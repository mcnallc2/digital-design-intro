// The `timescale directive specifies that
// the simulation time unit is 1 ns  and
// the simulation timestep is 10 ps
`timescale 1 ns/10 ps 

module d_ff_reset_tb;

   // signal declaration
   reg test_clk, test_reset, test_d;
   wire test_q;
   localparam T = 20;

   // instantiate the d_type_ff module
   d_ff_reset_syn uut 
        (
        .clk(test_clk), 
        .reset(test_reset), 
        .d(test_d), 
        .q(test_q)
        );
        
   always
   begin
      test_clk = 1'b1;
      #(T/2);
      test_clk = 1'b0;
      #(T/2);
   end
   
   
   initial
   begin
      test_reset = 1'b1;
      #(2*T);
      test_reset = 1'b0;
   end
    
   //  test vector generator
   initial
   begin
      test_reset = 1'b1;
      test_d = 1'b0;
      #T;
      test_d = 1'b1;
      #(T-5);
      test_reset = 1'b0;
      #(T/2);
      test_d = 1'b0;
      #(1.5 * T);
      test_d = 1'b1;
      #(2 * T);
      test_reset = 1'b1;
      #(1.5 * T);
      test_reset = 1'b0;
      #(1.5 * T);
      test_d = 1'b0;
      // stop simulation 
      $stop;
      
   end
   
endmodule
