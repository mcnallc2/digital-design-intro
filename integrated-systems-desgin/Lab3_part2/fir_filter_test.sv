`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2021 18:01:05
// Design Name: 
// Module Name: fir_filter_test
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


module fir_filter_test(
    input                       clk,
    input                       reset,
    input                       enable,
    input  logic  signed [15:0] fcw,
    output logic  signed [15:0] amplitude_out
    );
    

logic signed  [15:0] test_sig_sine;
logic                phase_wrap;


// sig_gen
sig_gen sine_generator (.clk,
                        .reset,
                        .enable,
                        .fcw,
                        .phase_wrap,
                        .sine (test_sig_sine));

// FIR
logic signed [15:0] fir_out;
fir_compiler_0 fir (.aclk               (clk),
                    .s_axis_data_tvalid (enable),
                    .s_axis_data_tdata  (test_sig_sine),
                    .m_axis_data_tdata  (fir_out));

// Simple peak detector
// This simple peak detector recieves a sine input, and a flag to tell it when a full period of the sine has elapsed
// When a full period of the sinusoid has elapsed, the peak amplitude will be updated for that period
measure_sine_peak simple_peak_detector (.clk,
                                        .reset,
                                        .enable,
                                        .period_done (phase_wrap),
                                        .sine        (fir_out),
                                        .peak        (amplitude_out));


endmodule
