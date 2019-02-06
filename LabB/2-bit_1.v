// Listing 1.1
module eq1
   // I/O ports
   (
    //2 inputs and a wire for each bit (4)
    input wire i0, i1, j0, j1,
    //3 outputs for the 3 different cases
    output wire eq, ls, gt
   );
   
   //all the wires used for each situation, before entering OR gates
   wire p0, p1, p2, p3, p4, p5, p6, p7, p8, p9;
   
   //(A<B) logic used for a less than b (ls)
   assign ls = p0 | p1 | p2;  
   assign p0 = ~j0 & ~i0 & i1;
   assign p1 = ~j0 & j1;
   assign p2 = ~i0 & j1 & i1;

   //(A=B) logic used for a equal to b (eq)
   assign eq = p3 | p4 | p5 | p6; 
   assign p3 = i0 & ~j0 & i1 & ~j1;
   assign p4 = i0 & j0 & i1 & j1;
   assign p5 = ~i0 & j0 & ~i1 & j1;
   assign p6 = ~i0 & ~j0 & ~i1 & ~j1;
   
   //(A>B) logic used for a greater than b (gt)
   assign gt = p7 | p8 | p9;
   assign p7 = j0 & ~j1;
   assign p8 = i0 & j0 & ~i1;
   assign p9 = i0 & ~i1 & ~j1;

endmodule