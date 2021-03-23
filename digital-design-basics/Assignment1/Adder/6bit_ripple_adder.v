//this module takes in a function for addtion and subtraction and adds 2 6-bit numbers bit by bit
module Ripple_Adder(x, y, sel, overflow, sum);

  // x and y are the 6-bit 2's complement numbers to add
  // sel determines either addition or subtraction (if there is a negitive number its subtraction)
  input wire [5:0] x, y;
  input wire sel;
  
  // overflow output that flags an overflow
  // cout is the 6-bit number for each carry
  // sum is the 6-bit 2's complement sum of x and y
  output wire overflow; 
  output wire [5:0] sum;
  wire [5:0] cout;
  
  //adding the bits 1 of 6 using c_init
  FullAdder FA1(
            .a(x[0]),
            .b(y[0] ^ sel),
            .cin(sel), 
            .s(sum[0]), 
            .cout(cout[0]));
  //adding the bits 2 of 6 using c_out of prev
  FullAdder FA2(
            .a(x[1]), 
            .b(y[1] ^ sel), 
            .cin(cout[0]), 
            .s(sum[1]), 
            .cout(cout[1]));
  //adding the bits 3 of 6 using c_out of prev
  FullAdder FA3(
            .a(x[2]), 
            .b(y[2] ^ sel), 
            .cin(cout[1]), 
            .s(sum[2]), 
            .cout(cout[2]));
  //adding the bits 4 of 6 using c_out of prev          
  FullAdder FA4(
            .a(x[3]), 
            .b(y[3] ^ sel), 
            .cin(cout[2]), 
            .s(sum[3]), 
            .cout(cout[3]));
  //adding the bits 5 of 6 using c_out of prev           
  FullAdder FA5(
            .a(x[4]), 
            .b(y[4] ^ sel), 
            .cin(cout[3]), 
            .s(sum[4]), 
            .cout(cout[4]));
  //adding the bits 6 of 6 using c_out of prev            
  FullAdder FA6(
            .a(x[5]), 
            .b(y[5] ^ sel), 
            .cin(cout[4]), 
            .s(sum[5]), 
            .cout(cout[5]));
       
    //overflow is set to the last carried out bit
    assign overflow = cout[5]; 
  
endmodule
