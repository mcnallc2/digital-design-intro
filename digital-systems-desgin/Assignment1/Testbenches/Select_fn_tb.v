// The `timescale directive specifies that
// the simulation time unit is 1 ns  and
// the simulation timestep is 10 ps
`timescale 1 ns/10 ps 

//this test bench is used to test the accuray of the my function selection module.
//it should take the indivual results of each 8 operations a function number.
//it should then 
module Funtion_Sel_tb;

   // signal declaration
   reg [5:0] test_in0, test_in1, test_in2, test_in3, test_in4, test_in5, test_in6, test_in7;
   reg [2:0] fxn;
   wire [5:0] final_res;
   integer i;

   // instantiate the Select_fn module
   Select_fn uut
        (.res0(test_in0), .res1(test_in1), .res2(test_in2), .res3(test_in3), .res4(test_in4), .res5(test_in5), .res6(test_in6), .res7(test_in7), .final(final_res), .func(fxn));

   //  test vector generator
   initial
   begin
      
      //these are the input test vectors representing the results from each operation
      test_in0 = 6'b000000;
      test_in1 = 6'b000001;
      test_in2 = 6'b000010;
      test_in3 = 6'b000011;
      test_in4 = 6'b000100;
      test_in5 = 6'b000101;
      test_in6 = 6'b000110;
      test_in7 = 6'b000111;
      //the inital function is 000
      fxn = 3'b000;
      
      //this loops through testing fro all 8 functions.
      for(i=0; i<8; i=i+1)
        begin
        #100;
        //increments to the next operation.
        fxn = fxn + 3'b001;
        end

      // stop simulation 
      $stop;
      
   end
   
endmodule
