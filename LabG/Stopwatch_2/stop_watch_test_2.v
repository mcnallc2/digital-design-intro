// Listing 4.19
module stop_watch_test_2
   (
    input wire clk,
    input wire go, clr,
    input wire direction,
    output wire [3:0] an,
    output wire [7:0] sseg
   );

   // signal declaration
   //new d3 added for minutes
   wire [3:0]  d3, d2, d1, d0;

   // instantiate 7-seg LED display module
   disp_hex_mux disp_unit
      (.clk(clk), .reset(1'b0),
        .hex3(d3), .hex2(d2), .hex1(d1), .hex0(d0),//added new d3 to give minutes its value
       .dp_in(4'b0101), .an(an), .sseg(sseg)); //added the new decimal point here

   // instantiate stopwatch
   stop_watch_if_2 counter_unit
      (.clk(clk), .go(go), .clr(clr), .direc(direction), // added direction variable to mondule instantiation
       .d3(d3), .d2(d2), .d1(d1), .d0(d0) );//d3 added to count for minutes
   
   //my approach has been tested and works. I have added a switch that will increment the stopwatch is on,
   // if the switch is off the stopwatch will decrement.
   //in the module stop_watch_if_2 I have used an simple if statement that will carry out
   // either the incremetation or decrementation.
   //to decrement i simply subtract from that regs value until it is zero then is set the next order to 9 or 5.
   
   
   //disable the unused display by setting it to 1
   //assign an = an | 4'b1000;

endmodule
