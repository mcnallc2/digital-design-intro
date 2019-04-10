`timescale 1ns / 1ps

module sequence_detector_tb;

   // signal declaration
   reg test_clk, test_reset;
   reg test_out;
   wire seq_det;
   
   localparam T = 2;
   // instantiate the LFSR module
   sequence_detector uut 
        (
        .clk(test_clk), 
        .reset(test_reset), 
        .lfsr_out(test_out),
        .seq_det_out(seq_det)
        );
        
   always
   begin
      test_clk = 1'b0;
      #(T/2);
      test_clk = 1'b1;
      #(T/2);
   end
   
   initial
   begin
     test_out = 0;
     test_reset = 1;
     #10;
     test_reset = 0;
     
     test_out = 1;
     #2;
     test_out = 1;
     #2;
     test_out = 1;
     #2;
     test_out = 0; 
     #2;
     test_out = 0; 
     #2;
     
     test_out = 1;
     #2;
     test_out = 1;
     #2;
     test_out = 1;
     #2;
     test_out = 1; 
     #2;
     test_out = 0; 
     #2;
     
     test_out = 1;
     #2;
     test_out = 1;
     #2;
     test_out = 1;
     #2;
     test_out = 1; 
     #2;
     test_out = 1; 
     #2;
     
     test_out = 1;
     #5;
     test_out = 1;
     #5;
     test_out = 0;
     #5;
     test_out = 1; 
     #5;
     test_out = 1; 
     #10;
      // stop simulation 
      $stop;
   end
      
endmodule