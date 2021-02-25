`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.02.2021 17:36:16
// Design Name: 
// Module Name: stim_gen
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

module stim_gen
   #(parameter T=2, delay=4)
   (input  [31:0]    log_file,
    output reg       test_clk,
    output reg       test_reset,
    output reg       test_a,
    output reg       test_b,
    output reg [3:0] expected_count,
    output reg       check,
    output reg       terminate,
    // debug
    output reg [4:0] i,
    output reg [4:0] j
    );
    
    
    // clock runnning forever
    always
    begin
        test_clk = 1'b0;
        #(T/2);
        test_clk = 1'b1;
        #(T/2);
    end
    
    
    // test procedure
    initial begin
        initialise();
        system_reset();
        
        $fdisplay(log_file, "\n\n>>>> >>>> COUNTER TESTS >>>>\n"); 
         
        // test to fully increment counter unitl it hits 0xF
        $fdisplay(log_file, ">>>> >>>> Incrementing until 'count' is 0xF\n");
        while (expected_count < 4'hF) begin
            // enter case
            run_5_step_gate_sequence(5'b00110, 5'b01100); // expect 0xF
        end
        check_counters();
        
        // test to attempt to increment when counter is 0xF
        $fdisplay(log_file, ">>>> >>>> Attempting to increment when 'count' is 0xF - Expect no change\n");
        // enter case   
        run_5_step_gate_sequence(5'b00110, 5'b01100); // expect 0xF
        check_counters();
        
        // test to decrement counter unitl it hits 0x0
        $fdisplay(log_file, ">>>> >>>> Decrementing until 'count' is 0x0\n");
        while (expected_count > 4'h0) begin
            // exit case
            run_5_step_gate_sequence(5'b01100, 5'b00110); // expect 0x0
        end
        check_counters();
        
        // test to attempt to decrment when it is 0x0
        $fdisplay(log_file, ">>>> >>>> Attempting to decrement when 'count' is 0x0 - Expect no change\n");
        // exit case
        run_5_step_gate_sequence(5'b01100, 5'b00110);  // expect 0x0
        check_counters();
        
        system_reset(); // reset system        
        
        
        
        $fdisplay(log_file, "\n\n>>>> >>>> FSM TESTS >>>>\n");
        $fdisplay(log_file, "\n>>>> >>>> Required Behaviour\n");  
        
        // test to attempt to increment
        $fdisplay(log_file, ">>>> >>>> Attempting to increment using 3 supported sequences\n");
        // enter case   
        run_5_step_gate_sequence(5'b00110, 5'b01110);       // expect increment
        check_counters();
        run_7_step_gate_sequence(7'b0011110, 7'b0110100);   // expect increment 
        check_counters();
        run_7_step_gate_sequence(7'b0010110, 7'b0111100);   // expect increment 
        check_counters();
        
        // test to attempt to decrement
        $fdisplay(log_file, ">>>> >>>> Attempting to increment using 3 supported sequences\n");
        // enter case   
        run_5_step_gate_sequence(5'b01100, 5'b00110);       // expect decrement
        check_counters();
        run_7_step_gate_sequence(7'b0110100, 7'b0011110);   // expect decrement 
        check_counters();
        run_7_step_gate_sequence(7'b0111100, 7'b0010110);   // expect decrement 
        check_counters();
        
        system_reset(); // reset system        
        
        
        // adaptive distinguishing sequence to test all possible 5-step edge cases
        $fdisplay(log_file, "\n>>>> >>>> Adaptive distinguishing sequence\n"); 
        // running through all possible 5 step sequences for the finite state machine 
        // counter should only change value twice for enter/exit cases
        
        // nested for loop to iterate through sequence values
        for(i=0; i<5'h1F; i=i+1) begin
            for(j=0; j<5'h1F; j=j+1) begin   
                // init counter to value of 0x1 so that it can decrement
//                run_5_step_gate_sequence(5'b00110, 5'b01100);   // set to 0x1
                run_5_step_gate_sequence(i,j);                  // run the sequence  
                check_counters();                               // check counters
                system_reset();                                 // reset system
            end
        end
        #(delay*2);
        
        
        // terminate the test
        terminate_test();
        #(delay*2);
        // stop simulation 
        $stop;
    end
    
    
    //======================================
    // task definitions
    //======================================
    // task run a 5 step sequence of gate sensor configurations
    // (a[0],b[0])->(a[1],b[1])->(a[2],b[2])->(a[3],b[3])->(a[4],b[4])
    task run_5_step_gate_sequence(
        input [4:0] a, 
        input [4:0] b
        );
        begin
            // sim for a car entering
            $fdisplay(log_file, "Case: (%d%d)->(%d%d)->(%d%d)->(%d%d)->(%d%d)",a[0],b[0],a[1],b[1],a[2],b[2],a[3],b[3],a[4],a[4]);
            
            // assign stimulus outputs in intervals
            test_a = a[0];
            test_b = b[0];
            #delay;
            test_a = a[1];
            test_b = b[1];
            #delay;
            test_a = a[2];
            test_b = b[2];
            #delay;
            test_a = a[3];
            test_b = b[3];
            #delay;
            test_a = a[4];
            test_b = b[4];
            
            // wait half clock cycle to modify expected count
            // this keeps the stimulus in sync with the DUT
            #(delay/2);
            
            // this portion performs the desired counter behaviour  
            // if input gate sequence is correct for entry
            if (a==5'b00110 && b==5'b01100) begin
                // if count is less than 0xF we increment exp count
                if (expected_count < 4'hF) begin
                    expected_count = expected_count + 1;
                end
                else begin
                    expected_count = expected_count;    
                end
            end
            // if input gate sequence is correct for exit
            else if (a==5'b01100 && b==5'b00110) begin
                // if count is greater than 0x0 we deccrement exp count
                if (expected_count > 4'h0) begin  
                    expected_count = expected_count - 1;
                end  
                else begin
                    expected_count = expected_count;
                end
            end
            // else exp counter does not change
            else begin
                expected_count = expected_count;
            end

            #(delay*2);
        end
    endtask


    // task run a 7 step sequence of gate sensor configurations
    // (a[0],b[0])->(a[1],b[1])->(a[2],b[2])->(a[3],b[3])->(a[4],b[4])->(a[5],b[5])->(a[6],b[6])
    task run_7_step_gate_sequence(
        input [6:0] a, 
        input [6:0] b
        );
        begin
            // sim for a car entering
            $fdisplay(log_file, "Case: (%d%d)->(%d%d)->(%d%d)->(%d%d)->(%d%d)->(%d%d)->(%d%d)",a[0],b[0],a[1],b[1],a[2],b[2],a[3],b[3],a[4],a[4],a[5],a[5],a[6],a[6]);
            
            // assign stimulus outputs in intervals
            test_a = a[0];
            test_b = b[0];
            #delay;
            test_a = a[1];
            test_b = b[1];
            #delay;
            test_a = a[2];
            test_b = b[2];
            #delay;
            test_a = a[3];
            test_b = b[3];
            #delay;
            test_a = a[4];
            test_b = b[4];
            #delay;
            test_a = a[5];
            test_b = b[5];
            #delay;
            test_a = a[6];
            test_b = b[6];
            
            // wait half clock cycle to modify expected count
            // this keeps the stimulus in sync with the DUT
            #(delay/2);
            
            // this portion performs the desired counter behaviour  
            // if input gate sequence is correct for entry
            if ((a==7'b0011110 && b==7'b0110100) || (a==7'b0010110 && b==7'b0111100)) begin
                // if count is less than 0xF we increment exp count
                if (expected_count < 4'hF) begin
                    expected_count = expected_count + 1;
                end
                else begin
                    expected_count = expected_count;    
                end
            end
            // if input gate sequence is correct for exit
            else if ((a==7'b0110100 && b==7'b0011110) || (a==7'b0111100 && b==7'b0010110)) begin
                // if count is greater than 0x0 we deccrement exp count
                if (expected_count > 4'h0) begin  
                    expected_count = expected_count - 1;
                end  
                else begin
                    expected_count = expected_count;
                end
            end
            // else exp counter does not change
            else begin
                expected_count = expected_count;
            end

            #(delay*2);
        end
    endtask
    
    
    // task to init the test procedure
    task initialise();
    begin   
        $fdisplay(log_file, ">>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ >>>>");
        $fdisplay(log_file, ">>>> Beginning FSM Advanded Testbench >>>>");
        $fdisplay(log_file, ">>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ >>>>");
        
        // init 
        expected_count  = 0; 
        check           = 0;
        terminate       = 0;
        test_a          = 0;
        test_b          = 0;
        i               = 0;
        j               = 0;
    end
    endtask

    
    // task to trigger system reset
    task system_reset();
    begin   
        $display(">>>> System Reset");  
        test_reset = 1;     // enable reset for DUT
        test_a = 0;         // 
        test_b = 0;
        expected_count = 0;
        #delay;
        test_reset = 0;
        #delay;
    end
    endtask
    
    
     // task to trigger scoreboard check
    task check_counters();
    begin   
        $display(">>>> Triggering Counter Check");  
        check = 1;
        #(delay/2);
        check = 0;
        #(delay/2);
    end
    endtask
    
    
    // task to trigger test termination
    task terminate_test();
    begin   
        $display(">>>> Triggering Test Termination");  
        terminate = 1;
        #(delay/2);
        terminate = 0;
        #(delay/2);
    end
    endtask
    
    
endmodule