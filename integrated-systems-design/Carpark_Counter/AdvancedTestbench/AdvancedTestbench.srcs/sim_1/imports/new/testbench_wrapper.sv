`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.02.2021 17:58:42
// Design Name: 
// Module Name: testbench_wrapper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: This is the toplevel testbench wrapper used to connect
//  the design under test with the stimulus generator and the scoreboard
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench_wrapper;

    // wires used to connect the modules
    wire clk;                           // test_clk
    wire reset;                         // test_reset
    wire a, b;                          // gate sensor stimuli
    wire check, terminate;              // scorecoard control signals
    wire [3:0] count, expected_count;   // counter values
    wire [31:0] log_file;               // log file pointer
    // debug
    wire [6:0] state;
    wire [4:0] i, j;
    
    // instantiating the stimulus generator
    stim_gen stim_gen_i(
        .log_file(log_file),
        .test_clk(clk),
        .test_reset(reset),
        .test_a(a),
        .test_b(b),
        .expected_count(expected_count),
        .check(check),
        .terminate(terminate),
        // debug
        .i(i),
        .j(j)
    );

    // instantiating the scoreboard   
    scoreboard scoreboard_i(
        .clk(clk),
        .reset(reset),
        .a(a),
        .b(b),
        .expected_count(expected_count),
        .count(count),
        .check(check),
        .terminate(terminate),
        .log_file(log_file)
    );
    
    // instantiating the Desgin Under Test
    top dut(
        .clk(clk),
        .reset(reset),
        .a(a),
        .b(b),
        .count(count),
        .state(state)
    );


endmodule
