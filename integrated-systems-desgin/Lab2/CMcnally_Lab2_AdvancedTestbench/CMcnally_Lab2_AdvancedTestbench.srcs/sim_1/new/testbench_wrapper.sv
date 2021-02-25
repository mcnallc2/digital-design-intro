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
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench_wrapper;

    wire clk;
    wire reset;
    wire a, b;
    wire check, terminate;
    wire [3:0] count, expected_count;
    wire [4:0] i, j;
    wire [6:0] state;
    wire [31:0] log_file;
    
    stim_gen stim_gen_i(
        .log_file(log_file),
        .test_clk(clk),
        .test_reset(reset),
        .test_a(a),
        .test_b(b),
        .expected_count(expected_count),
        .check(check),
        .terminate(terminate),
        .i(i),
        .j(j)
    );
    
    scoreboard scorecoard_i(
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
    
    top dut(
        .clk(clk),
        .reset(reset),
        .a(a),
        .b(b),
        .count(count),
        .state(state)
    );


endmodule
