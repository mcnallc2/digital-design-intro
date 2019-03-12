//this module takes in 2 6-bit numbers and gives a 1-bit binary outputs representing if A is greater than or equal to B
//it compares the bits in 2-bit pairs.
module Grt_Equ(

   //a adn b are the two 6-bit numbers to compare
   input  wire[5:0] x, y,
   //value is the single bit output should be high if a is greater than or equal to b
   output wire[5:0] value
   
   );

   //internal signal declarations e0, e1, e2, used to wire outputs of the each operation 
   wire e3, e4, e5, e6, e7, e8, e9, e10, e11;
   //used to wire the processed logic and form the overall OR operation
   wire f0, f1, f2, f3;

   //this is a change to the original file. this is commented as we only need to compare 6-bit numbers.
//   //compare the 7th and 8th bits and obtain a value for less than, greater than, or equal to.
//   eq1 eq_bit76_unit (.i0(a[6]), .i1(b[6]), .j0(a[7]), .j1(b[7]), .ls(e0), .eq(e1), .gt(e2));

   //compare the 5th and 6th bits, and obtain a value for less than, greater than, or equal to. 
   eq1 eq_bit54_unit (.i0(x[4]), .i1(y[4]), .j0(x[5]), .j1(y[5]), .ls(e3), .eq(e4), .gt(e5));
   //compare the 3th and 4th bits, and obtain a value for less than, greater than, or equal to.
   eq1 eq_bit32_unit (.i0(x[2]), .i1(y[2]), .j0(x[3]), .j1(y[3]), .ls(e6), .eq(e7), .gt(e8));
   //compare the 1st and 2nd bits, and obtain a value for less than, greater than, or equal to.
   eq1 eq_bit10_unit (.i0(x[0]), .i1(y[0]), .j0(x[1]), .j1(y[1]), .ls(e9), .eq(e10), .gt(e11));
   
   //again! only need to compare 6-bit numbers, therefore there is a slight change
//   //check all the possible senarios
//   assign f0 = e1 & e5;
//   assign f1 = e1 & e4 & e8;
//   assign f2 = e1 & e4 & e7 & e11;
//   assign f3 = e1 & e4 & e7 & e10;
    
   //stores the indivual results to prepare for further logic.
   assign f1 = e4 & e8;
   assign f2 = e4 & e7 & e11;
   assign f3 = e4 & e7 & e10;
   
   //as we only nee a single bit output we can set bits 1-5 as zero
   assign value[5] = 1'b0;
   assign value[4] = 1'b0;
   assign value[3] = 1'b0;
   assign value[2] = 1'b0;
   assign value[1] = 1'b0;
   
   //now we perform the final OR operation on the above results to obtain our final value.
   assign value[0] = e5 | f1 | f2 | f3;
   
endmodule