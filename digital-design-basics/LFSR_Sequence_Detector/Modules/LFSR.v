//this module is my 20-bit XNOR LFSR
//the outputs are the 1-bit shifted out and the full cycle indicator max_tick
module lfsr
    (
    input wire clk, reset,
    output wire lfsr_out,
    output reg max_tick_reg
    );
    
    //signal declaration
    reg [19:0] lfsr_reg; // register storage
    reg [19:0] lfsr_next; // next value
    reg lfsr_tap, max_tick_next; // to hold feedback
    localparam seed_value = 20'b00110100011100010011; //specific seed value
    
    // body
    // register
    always @(posedge clk, posedge reset)
        begin
        //if reset is high set to seed value and set counter back to zero
        if (reset)
            begin
            //set to my seed value and max_tick to zero
            lfsr_reg <= seed_value;
            max_tick_reg <= 1'b0;
            end
        //else go to new value
        else
            begin
               //go to the next value, update max_tick
               lfsr_reg <= lfsr_next;
               max_tick_reg <= max_tick_next;
            end
        end
        
    // next-state logic
    always @*
        begin 
        // generate the feedback by XNOR of tap 17 and 20
        lfsr_tap = !(lfsr_reg[16] ^ lfsr_reg[19]);
        // feedback goes into 0 position. Other bits shift up
        lfsr_next = {lfsr_reg[18:0], lfsr_tap};     
                   
        //if the counter has reached a full cycle (next value is seed)
        //send max tick high
        if(lfsr_next == seed_value)
            max_tick_next = 1'b1;
        //else keep max_tick low
        else
            max_tick_next = 1'b0;
        end   
    //output is now the shifted out bit
    assign lfsr_out = lfsr_reg[19];
endmodule