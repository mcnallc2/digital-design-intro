// Listing 1.4
module eq2
   (
    input  wire[1:0] a0, b0,			// a adn b are the two 2-bit numbers to compare
    input  wire[1:0] a1, b1,			// a adn b are the two 2-bit numbers to compare
    
    output wire aeqb				// single bit output. Should be high if a adn b the same
   );

   // internal signal declaration, used to wire outpus of the 1 bit comparators
   wire e0, e1, e2, e3;


   // body
   // instantiate two 1-bit comparators that we already know are tested and work
   // named instantiation allows us to change order of ports.
   eq1 eq_bit0_unit (.i0(a0[0]), .i1(b0[0]), .eq(e0));
   eq1 eq_bit1_unit (.eq(e1), .i0(a0[1]), .i1(b0[1]));
   eq1 eq_bit3_unit (.i0(a1[0]), .i1(b1[0]), .eq(e2));
   eq1 eq_bit4_unit (.eq(e3), .i0(a1[1]), .i1(b1[1]));
   
   


   // a and b are equal if individual bits are equal, which comes from the 1-bit comparators
   assign aeqb = e0 & e1;

endmodule