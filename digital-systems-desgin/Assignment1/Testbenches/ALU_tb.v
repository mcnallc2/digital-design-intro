// The `timescale directive specifies that
// the simulation time unit is 1 ns  and
// the simulation timestep is 10 ps
`timescale 1 ns/10 ps 

//this is a teshbench for testing the ALU itself
module ALU_tb;

   // signal declaration
   //these are the the input test vectors, function number, the output result and the overflow
   reg  [5:0] test_in0, test_in1;
   reg [2:0] test_sel;
   wire [5:0] test_out;
   wire test_ovfl;
   //this is a simple integer used for the for loops
   integer i;

   // instantiate the ALU circuit  
   ALU uut
        (.a(test_in0), .b(test_in1), .fxn(test_sel), .final_res(test_out), .final_ovfl(test_ovfl));

   //  test vector generator
   initial
   begin
   
    //first test is when A is larger than B
    test_in0 = 6'b000111;
    test_in1 = 6'b000001;
    test_sel = 3'b000; 
    
    //we begin at the first function and add 1 each iteration until all functions have been tested
    for(i=0; i<8; i=i+1)
        begin
        #10 ;
        //moving to the next funtion
        test_sel = test_sel + 3'b001;         
        end
    
    //next we test when A is less than B
    test_in0 = 6'b000001;
    test_in1 = 6'b000111;
    test_sel = 3'b000; 
  
    //we begin at the first function and add 1 each iteration until all functions have been tested
    for(i=0; i<8; i=i+1)
        begin
        #10 ;
        //moving to the next function
        test_sel = test_sel + 3'b001;         
        end  
         
    //next we test when A is equal to B, and both A and B are larger
    test_in0 = 6'b010111;
    test_in1 = 6'b010111;
    test_sel = 3'b000; 
    
    //we begin at the first function and add 1 each iteration until all functions have been tested    
    for(i=0; i<8; i=i+1)
        begin
        #10 ;
        //moving to the next iteration
        test_sel = test_sel + 3'b001;         
        end  
      
    //finally we test when when there is no carry, both A and B are large and A is less than B  
    test_in0 = 6'b010101;
    test_in1 = 6'b101010;
    test_sel = 3'b000; 
    
    //we begin at the first function and add 1 each iteration until all functions have been tested    
    for(i=0; i<8; i=i+1)
        begin
        #10 ;
        //moving to the next iteration
        test_sel = test_sel + 3'b001;         
        end    

      // stop simulation 
      $stop;
      
   end
   
endmodule