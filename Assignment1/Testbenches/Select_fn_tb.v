// The `timescale directive specifies that
// the simulation time unit is 1 ns  and
// the simulation timestep is 10 ps
`timescale 1 ns/10 ps 

module ALU_tb;

   // signal declaration
   // 

   
   reg [5:0] test_in0;
   reg [5:0] test_in1;
   reg [5:0] test_in2;
   reg [5:0] test_in3;
   reg [5:0] test_in4;
   reg [5:0] test_in5;
   reg [5:0] test_in6;
   reg [5:0] test_in7;

   reg [2:0] fxn;
   
   wire [5:0] final_res;

   // instantiate the circuit under 
   Select_fn uut
        (.res0(test_in0), .res1(test_in1), .res2(test_in2), .res3(test_in3), .res4(test_in4), .res5(test_in5), .res6(test_in6), .res7(test_in7), .final(final_res), .func(fxn));

   //  test vector generator
   initial
   begin
      // test vector 1
      //A
      fxn = 3'b000;
      test_in0 = 6'b000000;
      test_in1 = 6'b000001;
      test_in2 = 6'b000010;
      test_in3 = 6'b000011;
      test_in4 = 6'b000100;
      test_in5 = 6'b000101;
      test_in6 = 6'b000110;
      test_in7 = 6'b000111;
      # 100;
      
            // test vector 1
      //A
      fxn = 3'b010;
      test_in0 = 6'b000000;
      test_in1 = 6'b000001;
      test_in2 = 6'b000010;
      test_in3 = 6'b000011;
      test_in4 = 6'b000100;
      test_in5 = 6'b000101;
      test_in6 = 6'b000110;
      test_in7 = 6'b000111;
      # 100;
            // test vector 1
      //A
      fxn = 3'b100;
      test_in0 = 6'b000000;
      test_in1 = 6'b000001;
      test_in2 = 6'b000010;
      test_in3 = 6'b000011;
      test_in4 = 6'b000100;
      test_in5 = 6'b000101;
      test_in6 = 6'b000110;
      test_in7 = 6'b000111;
      # 100;
            // test vector 1
      //A
      fxn = 3'b110;
      test_in0 = 6'b000000;
      test_in1 = 6'b000001;
      test_in2 = 6'b000010;
      test_in3 = 6'b000011;
      test_in4 = 6'b000100;
      test_in5 = 6'b000101;
      test_in6 = 6'b000110;
      test_in7 = 6'b000111;
      # 100;

      // stop simulation 
      $stop;
      
   end
   
endmodule
