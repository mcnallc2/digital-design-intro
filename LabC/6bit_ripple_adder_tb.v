// The `timescale directive specifies that
// the simulation time unit is 1 ns  and
// the simulation timestep is 10 ps
`timescale 1 ns/10 ps 

module Ripple_Adder_tb;

   // signal declaration
   reg  [5:0] test_in0, test_in1;
   wire [5:0] test_out;

   // instantiate the circuit under test
   Ripple_Adder uut
      (.x(test_in0), .y(test_in1), .sum(test_out));

   //  test vector generator
   initial
   begin
      // test vector 1
      test_in0 = 6'b000001;
      test_in1 = 6'b000000;
      # 200;

      // stop simulation 
      $stop;
      
   end
   
endmodule