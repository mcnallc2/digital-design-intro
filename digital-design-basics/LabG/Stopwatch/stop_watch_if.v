// Listing 4.18
module stop_watch_if
   (
    input wire clk,
    input wire go, clr,
    output wire [3:0] d3, d2, d1, d0 //added d3 minutes variable
   );

   // declaration
   localparam  DVSR = 10000000;
   reg [23:0] ms_reg;
   wire [23:0] ms_next;
   reg [3:0] d3_reg, d2_reg, d1_reg, d0_reg;//minutes reg added
   reg [3:0] d3_next, d2_next, d1_next, d0_next;//next minute reg added
   wire ms_tick;

   // body
   // register
   always @(posedge clk)
   begin
      ms_reg <= ms_next;
      d3_reg <= d3_next; // moving to next minute value
      d2_reg <= d2_next;
      d1_reg <= d1_next;
      d0_reg <= d0_next;
   end

   // next-state logic
   // 0.1 sec tick generator: mod-5000000
   assign ms_next = (clr || (ms_reg==DVSR && go)) ? 4'b0 :
                    (go) ? ms_reg + 1 :
                           ms_reg;
   assign ms_tick = (ms_reg==DVSR) ? 1'b1 : 1'b0;
   // 3-digit bcd counter
   
   
   always @*
   begin
    
      // default: keep the previous value
      d0_next = d0_reg;
      d1_next = d1_reg;
      d2_next = d2_reg;
      d3_next = d3_reg;//added for next minute
      if (clr)
         begin
            d0_next = 4'b0;
            d1_next = 4'b0;
            d2_next = 4'b0;
            d3_next = 4'b0;//reset for minutes
         end
      else if (ms_tick)
         if (d0_reg != 9)
            d0_next = d0_reg + 1;
         else              // reach XXX9
            begin
               d0_next = 4'b0;
               if (d1_reg != 9)
                  d1_next = d1_reg + 1;
               else       // reach XX99
                  begin
                     d1_next = 4'b0;
                     if (d2_reg != 5)//60 seconds in a minute
                        d2_next = d2_reg + 1;
                     else // reach X999
                     //if 60 seconds is reached add 1 to minute
                        begin
                            d2_next = 4'b0;
                            if(d3_reg != 9)//if 9 minutes is reached go back to 0
                                d3_next = d3_reg + 1;
                            else // reach 9999
                                d3_next = 4'b0;
                        end 
                  end
            end
   end

   // output logic
   assign d0 = d0_reg;
   assign d1 = d1_reg;
   assign d2 = d2_reg;
   assign d3 = d3_reg;//sent minute to its new output

endmodule