// 3C7 Assignment1 2019
// this module takes 2 6-bit 2's compliment numbers and a 3-bit function number
// it then performs the corresponding operation on the the 2 numbers and gives and output and overflow.
module ALU(a, b, fxn, final_res, final_ovfl);
  
  // a and b are the 6-bit 2's complement numbers
  // fxn is 3 bit number representing function
  // final_res is the 6-bit 2's complement result
  input wire [5:0] a, b;
  input wire [2:0] fxn;
  output wire [5:0] final_res;
  output wire final_ovfl;
  
  //each of the wires below represent the result of each function
  //result for A, result for B, result for -A, result for -B, result for A >= B (1/0)
  //result for A ^ B, result for A + B, result for A - B, respectively.
  wire [5:0] result0, result1, result2, result3, result4, result5, result6, result7;
  
  //the wires below represent the overflow for the (A + B) & (A - B) operations
  wire ovfl0, ovfl1, ovfl_temp;
  
  //each function is instantiated and the results are stored
  //module for A (A + 0 = A), sel is set to 0
  Ripple_Adder L1(.x(a), .y(6'b0), .sel(1'b0), .overflow(ovfl_temp), .sum(result0));
  //module for B (B + 0 = B), sel is set to 0
  Ripple_Adder L2(.x(6'b0), .y(b), .sel(1'b0), .overflow(ovfl_temp), .sum(result1));
  //module for -A (0 - A = -A), sel is set to 1
  Ripple_Adder L3(.x(6'b0), .y(a), .sel(1'b1), .overflow(ovfl_temp), .sum(result2));
  //module for -B (0 - B = -B), sel is set to 1
  Ripple_Adder L4(.x(6'b0), .y(b), .sel(1'b1), .overflow(ovfl_temp), .sum(result3));
  //module for A >= B result is 1-bit (1/0)
  Grt_Equ L5(.x(a), .y(b), .value(result4));
  //module for A ^ B
  Ripple_XOR L6(.x(a), .y(b), .xor_ed(result5));
  //module for A + B, sel is set to 0
  Ripple_Adder L7(.x(a), .y(b), .sel(1'b0), .overflow(ovfl0), .sum(result6));
  //module for A - B, sel is set to 1
  Ripple_Adder L8(.x(a), .y(b), .sel(1'b1), .overflow(ovfl1), .sum(result7));
  
  //this module takes the function and the results above and stores the correct result in the final_res
  //it also takes the overflow values and stores the correct one in final_ovfl
  Select_fn L9(.res0(result0),
               .res1(result1), 
               .res2(result2), 
               .res3(result3),
               .res4(result4), 
               .res5(result5), 
               .res6(result6), 
               .res7(result7),
               .of0(ovfl0), 
               .of1(ovfl1),
               .final(final_res),
               .final_of(final_ovfl),
               .func(fxn));
               
endmodule