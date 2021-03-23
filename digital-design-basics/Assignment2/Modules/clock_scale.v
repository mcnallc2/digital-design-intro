//this module is used to set the clock scale relative to the users selection
module clock_scale
    (
    input clk,
    input wire choose_freq,
    output reg [31:0] clk_freq
    );
    
    //next_reg for the frequency
    reg [31:0] next_freq;
    
    //this update the clock frequecy every clock cycle                     
    always @(posedge clk)
    begin
        clk_freq <= next_freq;
    end 
                    
    always @*
    begin 
        //this will select the correct frequnecy relatively to the button selected
        if(choose_freq)
            next_freq = 1000;
        else
            next_freq = 500000;
    end  

endmodule
