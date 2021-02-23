//this module takes 2 6-bit numbers and performs and XOR operation on each bit
module Ripple_XOR(x, y, xor_ed);

  //x and y are the 6-bit 2's complement numbers to perform XOR on
  input wire [5:0] x, y;
  //xor_ed is the output of XOR of x and y
  output wire [5:0] xor_ed;
  
    //or_ing the bits 1 of 6
    Full_XOR FXO1(
        .a(x[0]),
        .b(y[0]), 
        .xr(xor_ed[0]));
    
    //or_ing the bits 1 of 6
    Full_XOR FXO2(
        .a(x[1]),
        .b(y[1]), 
        .xr(xor_ed[1]));
    
    //or_ing the bits 1 of 6
    Full_XOR FXO3(
        .a(x[2]),
        .b(y[2]), 
        .xr(xor_ed[2]));
        
    //or_ing the bits 1 of 6
    Full_XOR FXO4(
        .a(x[3]),
        .b(y[3]), 
        .xr(xor_ed[3]));
        
    //or_ing the bits 1 of 6
    Full_XOR FXO5(
        .a(x[4]),
        .b(y[4]), 
        .xr(xor_ed[4]));
    
    //or_ing the bits 1 of 6
    Full_XOR FXO6(
        .a(x[5]),
        .b(y[5]), 
        .xr(xor_ed[5]));
                                          
endmodule