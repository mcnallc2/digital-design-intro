module Ripple_Adder(x, y, sel, overflow, cout, sum);
  // 3C7 LabC 2019
  // x and y are the 6-bit 2's complement numbers to add
  // sel determines either addition or subtraction
  input wire[5:0] x, y;
  input wire sel;
  
  // overflow output that flags an overflow
  // cout is the MSB carried out from the sum
  // sum is the 6-bit 2's complement sum of x and y
  output wire overflow, cout; 
  output wire[5:0] sum;
  
  assign c_init = 1'b0;
  
  FullAdder FA1( .a(x[0]), .b(y[0]), .cin(c_init), .s(sum[0]), .cout(cout));
//  FullAdder FA2( .a(x[1]), .b(y[1]), .cin(c_init), .s(sum[1]), .cout(cout));
//  FullAdder FA3( .a(x[2]), .b(y[2]), .cin(c_init), .s(sum[2]), .cout(cout));
//  FullAdder FA4( .a(x[3]), .b(y[3]), .cin(c_init), .s(sum[3]), .cout(cout));
//  FullAdder FA5( .a(x[4]), .b(y[4]), .cin(c_init), .s(sum[4]), .cout(cout));
//  FullAdder FA6( .a(x[5]), .b(y[5]), .cin(c_init), .s(sum[5]), .cout(cout));
  
endmodule
