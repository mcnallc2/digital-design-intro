`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2021 19:16:20
// Design Name: 
// Module Name: sig_gen
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


module sig_gen #(
    parameter W_SINE  = 16,
    parameter W_PHASE = 16)
    (
    input                        clk,
    input                        reset,
    input                        enable,
    input  signed  [W_PHASE-1:0] fcw,
    output                       phase_wrap,
    output signed  [W_SINE-1:0]  sine
    );
    
// Local variables and constants
localparam W_CORDIC_IN  = 24;
localparam W_CORDIC_OUT = 24;
localparam MAX_POS      = 2**(W_PHASE-1)-1;
localparam MIN_NEG      = -2**(W_PHASE-1);

logic signed [W_PHASE-1:0]        phase_ff, phase_nxt;
logic signed [W_CORDIC_IN-1:0]    cordic_in;
logic        [2*W_CORDIC_OUT-1:0] cordic_out; // [7b zero pad, 17b sin, 7b zero pad, 17b cos]
logic signed [W_CORDIC_OUT-1:0]   sin;
logic signed [W_SINE-1:0]         sin_sat, sin_ff;

 
// Phase accumulator: Create ramp signal with desired test signal frequency
always_ff @ (posedge clk) begin
    if (reset)            phase_ff <= 'h8000; // Reset to most negative number
    else if (enable)      phase_ff <= phase_nxt;
end

assign phase_nxt   = phase_ff + fcw;
assign phase_wrap  = enable & (phase_nxt < phase_ff); // Assumes fcw > 0
assign cordic_in   = phase_ff;

// CORDIC: Convert phase into sin/cos
cordic_0 test_sig_gen  (.aclk               (clk       ),
                        .s_axis_phase_tvalid(enable    ),
                        .s_axis_phase_tdata (cordic_in ),
                        .m_axis_dout_tvalid (          ),
                        .m_axis_dout_tdata  (cordic_out));
assign sin = cordic_out[47:24]; // cordic_out = [24b sine, 25b cosine];

// Saturate to remove extra MSBs at CORDIC output
always_comb begin
    if (sin > MAX_POS)       sin_sat = MAX_POS;   // Clip at max positive value
    else if (sin < MIN_NEG) sin_sat =  MIN_NEG;  // Clip at min negative value
    else                     sin_sat = sin[W_SINE-1:0]; // Drop MSBs
end    

// Register outputs
always_ff @ (posedge clk) begin
    if (reset)       sin_ff <= '0;
    else if (enable) sin_ff <= sin_sat;
end

assign sine = sin_ff;

endmodule
