`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2021 09:45:35
// Design Name: 
// Module Name: top_level_wrapper
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

//`define SIM

module top_level_wrapper(
    input         clk,
    input  [15:0] sw,
    input  [4:0]  btn, // C-U-L-R-D
`ifdef SIM
    output [32:0] disp_value,
`endif
    output [15:0] led,
    output [6:0]  seg,
    output [3:0]  an
    );
    
                // Time Delay Param
`ifdef SIM
    parameter   AC_DELAY = 32'd100;
`else
    parameter   AC_DELAY = 32'd100_000_000;
`endif

                // State Parameters
    parameter   LOAD_A        = 5'b00001,
                LOAD_B        = 5'b00010,
                DISP_ANS      = 5'b00100,
                LOAD_PREV_ANS = 5'b01000,
                // Arithmetic Parameters
                EQU = 5'b00001,
                ADD = 5'b00010,
                SUB = 5'b00100,
                MUL = 5'b01000,
                DIV = 5'b10000;
    
    wire reset;
    wire [4:0] operation;
    wire [4:0] state;
    wire [15:0] ss_value;


`ifdef SIM
    assign disp_value = {ss_value, led};
`endif


    all_clear #(
        // Time Delay Param
        .AC_DELAY(AC_DELAY))
    all_clear_i(
        .clk(clk),
        .btn(btn),
        .reset(reset)
    );

    calculator_fsm #(
        // State Parameters
        .LOAD_A(LOAD_A),
        .LOAD_B(LOAD_B),
        .DISP_ANS(DISP_ANS),
        .LOAD_PREV_ANS(LOAD_PREV_ANS),
        // Arithmetic Parameters
        .EQU(EQU),
        .ADD(ADD),
        .SUB(SUB),
        .MUL(MUL),
        .DIV(DIV))
    calculator_fsm_i(
        .clk(clk),
        .reset(reset),
        .btn(btn),
        .operation(operation),
        .state(state)
    );

    arithmetic #(
        // State Parameters
        .LOAD_A(LOAD_A),
        .LOAD_B(LOAD_B),
        .DISP_ANS(DISP_ANS),
        .LOAD_PREV_ANS(LOAD_PREV_ANS),
        // Arithmetic Parameters
        .EQU(EQU),
        .ADD(ADD),
        .SUB(SUB),
        .MUL(MUL),
        .DIV(DIV))
    arithmetic_i(
        .clk(clk),
        .reset(reset),
        .sw(sw),
        .state(state),
        .operation(operation),
        .ss_value(ss_value),
        .leds(led)
    );
    
    seven_seg_ctrl seven_seg_ctrl_i(
        .clk(clk),
        .reset(reset),
        .number(ss_value),  // [15:0]
        .led_out(seg),      // [6:0]
        .anode_activate(an) // [3:0]
    );
    
    
endmodule
