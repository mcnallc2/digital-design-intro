`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.02.2021 17:36:16
// Design Name: 
// Module Name: scoreboard
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

module scoreboard(
    input       clk,
    input       reset,
    input       a,
    input       b,
    input [3:0] expected_count,
    input [3:0] count,
    input       check,
    input       terminate,
    //
    output integer log_file
    );
    
    // variables to track number tests run and tests passed
    integer tests, passed;
    
    
    // Monitoring the check signal - compare stimulus with DUT on posedge
    always @(posedge check) begin
        $fdisplay(log_file, ">>>> Test No. %d", (tests+1));
        $fdisplay(log_file, ">>>> Expected Count: 0x%x; Count: 0x%x", expected_count, count);
        // increment tests run
        tests <= tests + 1;
        // if expected stimulus and real count are equal
        if (count == expected_count) begin
            // increment tests passed
            passed <= passed + 1;
            $fdisplay(log_file, ">>>> >>>> RESULT: PASS\n");
        end
        else begin
            $fdisplay(log_file, ">>>> >>>> RESULT: FAIL\n");
        end
    end
    
    
    // Monitor gate sensor stimulus and log changes
    always @(a, b) begin
        $fdisplay(log_file, "Gate Sensors: a = %d; b = %d", a, b);
    end
    
    
    // scoreboard procedure
    initial begin
        log_file = $fopen("fsm_advanced_testing.txt", "w");  //create testing logfile
        tests  = 0;                                          // init tests var
        passed = 0;                                          // init passed var
        termination_handler();                               // test termination handler
    end
    
    
    //======================================
    // task definitions
    //======================================
    // task to handle a test termination from the stimulus
    task termination_handler();
    begin
        // waiting for posedge on termination signal
        @(posedge terminate);
        
        // log full tests test results
        $fdisplay(log_file, ">>>> Test Terminated: %d of %d tests passed\n", passed, tests);
        
        // log final test result
        if (passed == tests) begin
            $fdisplay(log_file, ">>>> >>>> RESULT: ALL TESTS PASSED\n\n");
        end
        else begin
            $fdisplay(log_file, ">>>> >>>> RESULT: TESTS HAVE FAILED\n\n");
        end
        
        // close logfile
        $fclose(log_file);
    end
    endtask
    

endmodule