`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2021 18:15:00
// Design Name: Lab1
// Module Name: counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Count module used to update a count registor based on
// the input increment and decrement signal pulses
// 
//////////////////////////////////////////////////////////////////////////////////


module counter(
    input        clk,
    input        reset,
    input        inc,
    input        dec,
    output [3:0] count
    );
    
    // count register
    reg [3:0] count_ff, count_nxt;

    // connect output reg to output wire
    assign count = count_ff;
    
    // Sequential Logic - Asynchronous Reset
    always @(posedge clk, posedge reset) begin
        // if reset - count is set to 0 
        if(reset == 1'b1) begin 
            count_ff <= 4'h0;
        end
        // else update count reg
        else begin
            count_ff <= count_nxt;
        end
    end

    // Combinational Logic
    always @(*) begin
        // if Inc pulse high and count is less than 15 - Increment counter
        if (inc && count_ff < 4'hf) begin
            count_nxt = count_ff + 4'h1;
        end
        // if Dec pulse high and count is greater than 0 - Decrement counter
        else if (dec && count_ff > 4'h0) begin
            count_nxt = count_ff - 4'h1;
        end
        // else counter maintains current value
        else begin
            count_nxt = count_ff;        
        end
    end
    
endmodule
