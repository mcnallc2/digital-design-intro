`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2021 18:23:12
// Design Name: 
// Module Name: tb_fir_filter_test
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


module tb_fir_filter_test();


fir_filter_test  Ifir_test(
    .clk            (clk    ),
    .reset          (reset  ),
    .enable         (enable ),
    .fcw            (fcw    ),
    .amplitude_out  ()
    );
    
    
logic clk;
logic reset;
logic enable;
logic signed  [15:0] fcw; // Frequency Control Word

initial begin
    clk = 0;
    forever begin
        #20 clk = ~clk;
    end
end

initial begin
    reset  = 0;
    enable = 0;
    repeat(10) @(posedge clk);
    reset = 1;
    repeat(2)  @(posedge clk);
    reset = 0;
    repeat(20)  @(posedge clk);
    fcw = 2000; // 2**(W FCW)-1  / fcw  * Tclk  = Period of ramp
    enable = 1;
end

initial begin
    repeat(20000) @(posedge clk);
    $stop;
end

endmodule
