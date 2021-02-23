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
// FSM to the car counter. The external button peripherals are used to 
// emulate the gate sensors, and the counter output is displayed on the 7-seg.
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input        clk,
    input        reset,
    input        btn_a,
    input        btn_b,
    output [6:0] seg,
    output [3:0] an
    );
    
    wire       db_btn_a, db_btn_b;
    wire       enter, exit;
    wire [3:0] count;
    
    // debouncing the button for gate sensor A
    debouncer debouncer_btn_a
        (
        .clk(clk),
        .reset(reset),
        .button(btn_a),
        .button_db(db_btn_a)
        );

    // debouncing the button for gate sensor B
    debouncer debouncer_btn_b
        (
        .clk(clk),
        .reset(reset),
        .button(btn_b),
        .button_db(db_btn_b)
        );
    
    // FSM detection Enter/Exit events
    fsm fsm_i
        (
        .clk(clk),
        .reset(reset),
        .a(db_btn_a),
        .b(db_btn_b),
        .enter(enter),
        .exit(exit)
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
    
    // module used to map counter output to the 7-seg display
    seven_seg_ctrl seven_seg_ctrl_i
        (
        .clk(clk),
        .reset(reset),
        .number({12'h0, count}),
        .led_out(seg),
        .anode_activate(an)
        );
    
endmodule