// Listing 1.1
module eq1
   // I/O ports
   (
    //input wires for for each bit
    input wire i0, i1, j0, j1,
    //output wires for the 3 cases
    output wire eq, ls, gt
   );
   
   //wires used to connect the AND operations before the OR gates
   wire p0, p1, p2, p3, p4, p5, p6, p7, p8, p9;
   
   //(A<B) a less than b (ls)
   assign ls = p0 | p1 | p2;  
   assign p0 = ~j0 & ~i0 & i1;
   assign p1 = ~j0 & j1;
   assign p2 = ~i0 & j1 & i1;

   //(A=B) a is equal to b (eq)
   assign eq = p3 | p4 | p5 | p6; 
   assign p3 = i0 & ~j0 & i1 & ~j1;
   assign p4 = i0 & j0 & i1 & j1;
   assign p5 = ~i0 & j0 & ~i1 & j1;
   assign p6 = ~i0 & ~j0 & ~i1 & ~j1;
   
   //(A>B) a greater than b (gt)
   assign gt = p7 | p8 | p9;
   assign p7 = j0 & ~j1;
   assign p8 = i0 & j0 & ~i1;
   assign p9 = i0 & ~i1 & ~j1;

endmodule