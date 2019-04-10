
module clock
    (
    input CCLK,
    input [31:0] clkscale,
    output reg clk
    );
    //CCLK crystal clock oscillator 100 MHz
    //clock register, inital value of 0
    reg [31:0] clkq = 0;
    
    always @(posedge CCLK)
        begin
        //increment clock register
        clkq = clkq + 1;
        //clock scaling
        if(clkq >= clkscale)
        //only if change clock value if it is >= the scaling parameter
            begin
            //output clock
            clk = ~clk;
            //reset clock register
            clkq = 0;
            end
        end
endmodule
