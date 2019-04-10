//this module is used to count the number of sequences detected
//it has 4 outputs, each output represents a Hexidecimal Digit
module counter
    (
    input clk,
    input wire reset,
    input wire seq_count,
    input wire max_tick,
    output reg [3:0] count0_reg, count1_reg, count2_reg, count3_reg,
    output reg pause_clk
    );
    
    //_next
    reg [3:0] count0_next, count1_next, count2_next, count3_next;
    reg pause_clk_next;
    
    //always block used to update the hex count values
    always @(posedge clk)
    begin
        //if reset is high then set the count_regs and pause_clock to zero
        if(reset)
        begin
            count0_reg <= 4'b0;
            count1_reg <= 4'b0;
            count2_reg <= 4'b0;
            count3_reg <= 4'b0;
            pause_clk  <= 1'b0;
        end 
        //else move to the update the next_regs
        else
        begin   
            count0_reg <= count0_next;
            count1_reg <= count1_next;
            count2_reg <= count2_next;
            count3_reg <= count3_next;
            pause_clk <= pause_clk_next;
        end
    end 
    
    //this always block will increment the next_regs when a sequence is detected     
    always @*
    begin
        //default: keep the previous value
        count0_next = count0_reg;
        count1_next = count1_reg;
        count2_next = count2_reg;
        count3_next = count3_reg;
        pause_clk_next = pause_clk;
        
        //if max_tick is reached pause the clock
        if(max_tick)
            pause_clk_next = 1'b1;
        
        //else if a sequence is detected and clk is not paused increment the count
        else if(seq_count && !pause_clk)
        begin
            //if XXXF has not been reached increment count0
            if (count0_reg != 15)
                count0_next = count0_reg + 1;
                
            //if we reach XXXF
            else
            begin
                //reset count0
                count0_next = 4'b0;
                //if XXFX has not been reached incremnent count1
                if (count1_reg != 15)
                    count1_next = count1_reg + 1;
                    
                //if we reach XXFF
                else       
                begin
                    //reset count1
                    count1_next = 4'b0;
                    //is XFXX has not been reached increment count2
                    if (count2_reg != 15)
                        count2_next = count2_reg + 1;
                        
                    //if we reach XFFF
                    else
                    begin
                        //reset count2
                        count2_next = 4'b0;
                        //is FXXX has not been reached increment count3
                        if(count3_reg != 15)
                            count3_next = count3_reg + 1;
                            
                        //if we reach FXXX
                        else
                            //reset count3
                            count3_next = 4'b0;
                    end 
                end
            end
        end
    end

endmodule