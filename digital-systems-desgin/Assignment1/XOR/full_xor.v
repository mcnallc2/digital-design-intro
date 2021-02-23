//this module takes 2 1-bit numbers and performs XOR on them
module Full_XOR(a, b, xr);

  //a and b are the bits to OR
  input wire a, b;
  
  //r is the output XOR of a and b
  output wire xr;

  //logic for OR
  assign xr = a ^ b;
  
endmodule