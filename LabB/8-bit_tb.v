// Listing 1.7
// The `timescale directive specifies that
// the simulation time unit is 1 ns  and
// the simulation timestep is 10 ps
`timescale 1 ns/10 ps

module eq2_testbench;
   // signal declaration, now 8-bit!!!!
   reg  [7:0] test_in0, test_in1;
   wire  test_out;

   // instantiate the circuit under test
   eq2 uut
      (.a(test_in0), .b(test_in1), .value(test_out0));

   //  test vector generator
   initial
   begin
      // test vector 1
      test_in0 = 8'b00000000; //all changed to random 8-bit values
      test_in1 = 8'b00000000;
      # 200;
      // test vector 2
      test_in0 = 8'b00000001;
      test_in1 = 8'b00000000;
      # 200;
      // test vector 3
      test_in0 = 8'b00000000;
      test_in1 = 8'b00000010;
      # 200;
      // test vector 4
      test_in0 = 8'b00000010;
      test_in1 = 8'b00000100;
      # 200;
      // test vector 5
      test_in0 = 8'b00000100;
      test_in1 = 8'b00000011;
      # 200;
      // test vector 6
      test_in0 = 8'b00011000;
      test_in1 = 8'b01100000;
      # 200;
      // test vector 7
      test_in0 = 8'b11000000;
      test_in1 = 8'b01100101;
      # 200;
      // stop simulation
      $stop;
   end
   

endmodule