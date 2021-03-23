`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2021 17:33:05
// Design Name: 
// Module Name: fsm_testbench
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


module fsm_testbench;

    reg  clk, reset;
    reg  a, b;
    wire enter, exit;
    
    parameter T = 2;
    
    fsm uut
        (
        .clk(clk),
        .reset(reset),
        .a(a),
        .b(b),
        .enter(enter),
        .exit(exit)
        );
        
    always
    begin
        clk = 1'b0;
        #(T/2);
        clk = 1'b1;
        #(T/2);
    end  
        
    initial
    begin
        $display("Behavoural Simulation for Finite State Machine\n");
        a = 0;
        b = 0;
        
        reset = 1;
        #10;
        reset = 0;
        #10
        
        // sim for a car entering
        $display("Simulation car entering - Expect 'Enter' to trigger");
        a = 1;
        #5;
        b = 1;
        #5;
        a = 0;
        #5
        b = 0;
        #2
        $display("Enter: 1'b%d - Exit: 1'b%d\n", enter, exit);
        #15
        
        // sim for a car exiting
        $display("Simulation car exiting - Expect 'Exit' to trigger");
        b = 1;
        #5;
        a = 1;
        #5;
        b = 0;
        #5
        a = 0;
        #2
        $display("Enter: 1'b%d - Exit: 1'b%d\n", enter, exit);
        #15
        
        // sim for a car entering halfway but then leaving
        $display("Simulation entering halfway but then leaving - Expect no trigger");
        a = 1;
        #5;
        b = 1;
        #5;
        b = 0;
        #5
        a = 0;
        #1
        $display("Enter: 1'b%d - Exit: 1'b%d\n", enter, exit);
        #15
        
        // sim for a car exiting halfway but then staying
        $display("Simulation exiting halfway but then staying - Expect no trigger");
        b = 1;
        #5;
        a = 1;
        #5;
        a = 0;
        #5
        b = 0;
        #1
        $display("Enter: 1'b%d - Exit: 1'b%d\n", enter, exit);
        #15
        
        // sim for a pedestrian/cyclist entering
        $display("Simulation for a pedestrian/cyclist entering - Expect no trigger");
        a = 1;
        #5;
        a = 0;
        #5;
        b = 1;
        #5
        b = 0;
        #1
        $display("Enter: 1'b%d - Exit: 1'b%d\n", enter, exit);
        #15
        
        // sim for a pedestrian/cyclist exiting
        $display("Simulation for a pedestrian/cyclist exiting - Expect no trigger");
        b = 1;
        #5;
        b = 0;
        #5;
        a = 1;
        #5
        a = 0;
        #1
        $display("Enter: 1'b%d - Exit: 1'b%d\n", enter, exit);
        #15
        
        // sim for a car entering halfway but then disappearing
        $display("Simulation car entering halfway but then disappearing - Expect no trigger");
        a = 1;
        #5;
        b = 1;
        #5;
        b = 0;
        #5
        a = 0;
        #1
        $display("Enter: 1'b%d - Exit: 1'b%d\n", enter, exit);
        #15
        
        // sim for a car exiting halfway but then disappearing
        $display("Simulation car exiting halfway but then disappearing - Expect no trigger");
        a = 1;
        #5;
        b = 1;
        #5;
        b = 0;
        #5
        a = 0;
        #1
        $display("Enter: 1'b%d - Exit: 1'b%d\n", enter, exit);
        #15  
        
        // stop simulation 
        $stop;
    end  

    
endmodule
