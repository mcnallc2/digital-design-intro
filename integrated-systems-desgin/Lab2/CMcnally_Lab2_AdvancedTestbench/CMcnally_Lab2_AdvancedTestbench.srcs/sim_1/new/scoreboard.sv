`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.02.2021 17:36:16
// Design Name: 
// Module Name: scoreboard
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

module scoreboard(
    input       clk,
    input       reset,
    input       a,
    input       b,
    input [3:0] expected_count,
    input [3:0] count,
    input       check
    );

    // Sequential Logic - Asynchronous Reset
    always @(posedge check) begin
        // if reset - state is clear with enter/exit low
        $display("\n>>>> Expected Count: 0x%x; Count: 0x%x", expected_count, count);
        if (count == expected_count) begin
            $display(">>>> >>>> RESULT: PASS");
        end
        else begin
            $display(">>>> >>>> RESULT: FAIL");
        end
    end
    
    // Sequential Logic - Asynchronous Reset
    always @(a, b) begin
        $display(">>>> Gate Sensors: a = %d; b = %d", a, b);
    end
    
    
    
endmodule