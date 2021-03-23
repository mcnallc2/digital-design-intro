//this module is my 20-bit XNOR LFSR
//the output only shows 14-bits as there are not enough LEDs
module LFSR
    (
    input wire clk, reset,
    output wire [13:0] lfsr_out,
    output reg max_tick_reg
    );
    //signal declaration
    reg [19:0] lfsr_reg; // register storage
    reg [19:0] lfsr_next; // next value
    reg lfsr_tap; // to hold feedback
    integer i = 0; //counter variable to keep track of cycle
    localparam seed_value = 20'b00110100011100010011;
    
    // body
    
    // register
    always @(posedge clk, posedge reset)
        begin
        //if reset is high set to seed value and set counter back to zero
        if (reset)
            begin
            //set to my seed value and my counter to zero
            lfsr_reg <= seed_value; // a seed value
            i<=0;
            end
        //else go to new value
        else
            begin
            //go to the next value
            lfsr_reg <= lfsr_next;
            //if the counter has reached a full cycle
            if(i == 1048575)
                begin
                //send max tick high and set counter to zero
                max_tick_reg <= 1'b1;
                i<=0;
                end
            //else keep max_tick low
            else
                max_tick_reg <= 1'b0;
            end
  
        end
        
    // next-state logic
    always @*
        begin
        // generate the feedback by XNOR of tap 17 and 20
        lfsr_tap = !(lfsr_reg[16] ^ lfsr_reg[19]);
        // feedback goes into 0 position. Other bits shift up
        lfsr_next = {lfsr_reg[18:0], lfsr_tap};
        //increment counter
        i = i + 1;
        end // next state logic
        
    //output is now the shifted out bit
    assign lfsr_out = lfsr_reg[19:6];
endmodule