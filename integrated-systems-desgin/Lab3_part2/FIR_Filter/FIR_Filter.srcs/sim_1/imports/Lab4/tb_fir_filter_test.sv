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


logic clk;
logic reset;
logic enable;
logic signed  [15:0] fcw; // Frequency Control Word
logic  signed [15:0] amplitude_out;
logic  signed [15:0] test_sig_sine;
logic  signed [15:0] fir_out;

fir_filter_test  Ifir_test(
    .clk            (clk    ),
    .reset          (reset  ),
    .enable         (enable ),
    .fcw            (fcw    ),
    .amplitude_out  (amplitude_out),
    .test_sig_sine  (test_sig_sine),
    .fir_out        (fir_out      )
    );


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
    enable = 1;
    
    test_frequency(6554 ); // freq firmly in passband - 0.2  (xPI rad/sample)
    test_frequency(12434); // freq @ passband cut-off - 0.38 (xPI rad/sample)
    test_frequency(15697); // freq @ middle of transition-band - 0.48 (xPI rad/sample)
    test_frequency(18996); // freq @ stopband cut-off - 0.58 (xPI rad/sample)
    test_frequency(26214); // freq firmly in stopband - 0.8  (xPI rad/sample)

end

initial begin
    repeat(5000) @(posedge clk);
    $stop;
end


//======================================
// task definitions
//======================================

// task change input frequency and smaple amplitude
task test_frequency(
    input [15:0] new_fcw
    );
    begin
        reset = 1;
        repeat(2)  @(posedge clk);
        reset = 0;
        fcw = new_fcw; // 2**(W FCW)-1  / fcw  * Tclk  = Period of ramp
        $display("\nCase: FCW = %d", fcw);
        repeat(200) @(posedge clk);
        $display("Amplitude Sample: %d", amplitude_out);
        repeat(100) @(posedge clk);
    end
endtask

endmodule
