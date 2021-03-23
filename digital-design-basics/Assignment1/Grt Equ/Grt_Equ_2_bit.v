//this module takes 2, 2-bit numbers and compares them to see if one is less than, greater than, or equal to the other.
module eq1(

   //input wires for for each bit, '0' is used for one number and '1' for the other
   //the 'i' and 'j' represent bits 0 or 1, read this carefully as it can be confusing!!!
   input wire i0, i1, j0, j1,
   //output wires for the 3 possible outcomes
   output wire eq, ls, gt
   );
   
   //wires used to make the design clearer. These wires are the results for the initial AND operations
   wire p0, p1, p2, p3, p4, p5, p6, p7, p8, p9;
   
   //(A<B) a less than b (ls)
   assign ls = p0 | p1 | p2; 
   //a=00, b=-1 
   assign p0 = ~j0 & ~i0 & i1;
   //a=0-, b=1-
   assign p1 = ~j0 & j1;
   //a=-0, b=11
   assign p2 = ~i0 & j1 & i1;

   //(A=B) a is equal to b (eq)
   assign eq = p3 | p4 | p5 | p6; 
   //a=01, b=01
   assign p3 = i0 & ~j0 & i1 & ~j1;
   //a=11, b=11
   assign p4 = i0 & j0 & i1 & j1;
   //a=10, b=10
   assign p5 = ~i0 & j0 & ~i1 & j1;
   //a=00, b=00
   assign p6 = ~i0 & ~j0 & ~i1 & ~j1;
   
   //(A>B) a greater than b (gt)
   assign gt = p7 | p8 | p9;
   //a=1-, b=0-
   assign p7 = j0 & ~j1;
   //a=11, b=-0
   assign p8 = i0 & j0 & ~i1;
   //a=-1, b=00
   assign p9 = i0 & ~i1 & ~j1;

endmodule