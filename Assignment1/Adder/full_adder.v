//this module takes 2 1-bit numbers and a carry_in bit and gives the sum and the carry_out bit
module FullAdder(a, b, cin, s, cout);

  // a and b are the bits to add
  // cin is carry in
  input wire a, b, cin;
  
  // s is the sum of a and b. cout is any carry out bit
  output wire s, cout;

  // logic for sum and carry
  assign s = cin ^ a ^ b;
  assign cout = (b & cin) | (a & cin) | (a & b); 
  
endmodule