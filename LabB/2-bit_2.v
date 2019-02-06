// Listing 1.4
module eq2
   (
    input  wire[1:0] a, b,			// a adn b are the two 2-bit numbers to compare
    output wire agteqb				// output for fro greater than or equal to value
   );

   // internal signal declaration, used to wire outputs of the comparitor
   wire e0, e1, e2;

   // body
   //module used to run the inputs into the logic to give the output.
   eq1 eq_2bit_unit (.i0(a[0]), .i1(b[0]), .j0(a[1]), .j1(b[1]), .ls(e0), .eq(e1), .gt(e2));
   
   //assinging the output to the values of greater than OR equal to
   assign agteqb = e1 | e2;

endmodule