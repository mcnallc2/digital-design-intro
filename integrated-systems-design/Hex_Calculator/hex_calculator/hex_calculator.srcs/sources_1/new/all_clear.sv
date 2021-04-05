`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2021 16:32:13
// Design Name: 
// Module Name: all_clear
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module all_clear #(
    parameter AC_DELAY = 32'd100_000_000 // 1 second
    )(
    input clk,
    input [4:0] btn,
    output reset
    );
    
    reg        reset_ff;
    reg [31:0] count;

    assign reset = reset_ff;
    
    // When the push-button is pushed or released, we increment or decrement the counter
    // The counter has to reach threshold before we decide that the push-button state has changed
    always @(posedge clk) begin
        if (btn == 5'b00001) begin // if btn[0] is 1 
            if (~&count) begin // if it isn't at the count limit. Make sure won't count up at the limit. First AND all count and then not the AND
                count <= count + 1;
            end 
        end 
        else begin 
            count <= 'b0; //when btn relesed, set count to 0
        end
        
        if (count > AC_DELAY) begin // if the count is greater the threshold 
            reset_ff <= 1; // reset is 1
        end else begin 
            reset_ff <= 0; // reset is 0          
        end
    end
    
endmodule
