// Listing 1.4
module eq2
   (
    input  wire[7:0] a, b,			// a adn b are the two 8-bit numbers to compare
    output wire value				// single bit output. Should be high if a is greater than or equal to b
   );

   // internal signal declaration, used to wire outputs of the each operation 
   wire e0, e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11;
   //used to wire the processed logic and form the overall OR operation
   wire f0, f1, f2, f3;

   // body
   //here the 8-bit_1.v module is called to compare the 7th and 8th bits
   eq1 eq_bit76_unit (.i0(a[6]), .i1(b[6]), .j0(a[7]), .j1(b[7]), .ls(e0), .eq(e1), .gt(e2));
   //compare the 5th and 6th bits
   eq1 eq_bit54_unit (.i0(a[4]), .i1(b[4]), .j0(a[5]), .j1(b[5]), .ls(e3), .eq(e4), .gt(e5));
   //compare the 3th and 4th bits
   eq1 eq_bit32_unit (.i0(a[2]), .i1(b[2]), .j0(a[3]), .j1(b[3]), .ls(e6), .eq(e7), .gt(e8));
   //compare the 1st and 2nd bits
   eq1 eq_bit10_unit (.i0(a[0]), .i1(b[0]), .j0(a[1]), .j1(b[1]), .ls(e9), .eq(e10), .gt(e11));
   
   //check all the possible senarios
   assign f0 = e1 & e5;
   assign f1 = e1 & e4 & e8;
   assign f2 = e1 & e4 & e7 & e11;
   assign f3 = e1 & e4 & e7 & e10;
   
   //perfoms the OR operation on all the senarios
   assign value = e2 | f0 | f1 | f2 | f3;
   
endmodule