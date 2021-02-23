`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2021 18:47:00
// Design Name: Lab1
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Top level module wrapper used to connect the Enter/Exit
// FSM to the car counter. Inputs are clk and reset, with the sensor gate signals. 
// Outputs is the 4-bit count value
//
//////////////////////////////////////////////////////////////////////////////////


module top(
    input        clk,
    input        reset,
    input        a,
    input        b,
    output [3:0] count,
    output [6:0] state
    );

    wire enter, exit;
    
    // FSM detection Enter/Exit events
    fsm fsm_i
        (
        .clk(clk),
        .reset(reset),
        .a(a),
        .b(b),
        .enter(enter),
        .exit(exit),
        .state(state)
        );
    
    // counter to track cars inside carpark
    counter counter_i
        (
        .clk(clk),
        .reset(reset),
        .inc(enter),
        .dec(exit),
        .count(count)
        );
    
endmodule