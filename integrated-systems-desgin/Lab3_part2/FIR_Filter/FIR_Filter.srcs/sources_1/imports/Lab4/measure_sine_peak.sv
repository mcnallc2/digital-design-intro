`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2021 19:26:16
// Design Name: 
// Module Name: measure_sine_peak
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


module measure_sine_peak #(
    parameter W_SINE = 16
    )(
    input                      clk,
    input                      reset,
    input                      enable,
    input                      period_done,
    input  signed [W_SINE-1:0] sine,
    output signed [W_SINE-1:0] peak
    );
    
logic signed [W_SINE-1:0] max_ff, max_nxt, max_out_ff, max_out_nxt;

always_ff @(posedge clk) begin
    if (reset) begin
        max_ff     <= '0;
        max_out_ff <= '0;
    end else if (enable) begin
        max_ff     <= max_nxt;
        max_out_ff <= max_out_nxt;
    end
end

// TODO Replace phase_wrap with phase_wrap delayed by CORDIC latency
always_comb begin
    max_out_nxt = max_out_ff;
    max_nxt     =  (sine > max_ff)? sine : max_ff;
    if (period_done) begin
        max_out_nxt = max_ff;
        max_nxt     = '0;
    end
end

assign peak = max_out_ff;
endmodule
