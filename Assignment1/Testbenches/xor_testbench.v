// The `timescale directive specifies that
// the simulation time unit is 1 ns  and
// the simulation timestep is 10 ps
`timescale 1 ns/10 ps 

module Ripple_XOR_tb;

   //two 6-bit inputs
   //6-bit output representing OR value
   reg  [5:0] test_in0, test_in1;
   wire [5:0] test_out;

   // instantiate the circuit under test
   Ripple_XOR uut
      (.x(test_in0), .y(test_in1), .xor_ed(test_out));

   //  test vector generator
   initial
   begin
      // test vector 1
      test_in0 = 6'b000000;
      test_in1 = 6'b000000;
      # 100;
      
      // test vector 2
      test_in0 = 6'b001010;
      test_in1 = 6'b000101;
      # 100
      
      // test vector 3
      test_in0 = 6'b101010;
      test_in1 = 6'b100101;
      # 100
      
      // test vector 4
      test_in0 = 6'b101010;
      test_in1 = 6'b000101;
      # 100
      
      // test vector 5
      test_in0 = 6'b100010;
      test_in1 = 6'b100011;
      # 100
      
      // test vector 6
      test_in0 = 6'b111111;
      test_in1 = 6'b111111;
      # 100
      
      // test vector 7
      test_in0 = 6'b101010;
      test_in1 = 6'b010101;
      # 100
      
      // test vector 8
      test_in0 = 6'b000010;
      test_in1 = 6'b000011;
      # 100

      // stop simulation 
      $stop;
      
   end
   
endmodule