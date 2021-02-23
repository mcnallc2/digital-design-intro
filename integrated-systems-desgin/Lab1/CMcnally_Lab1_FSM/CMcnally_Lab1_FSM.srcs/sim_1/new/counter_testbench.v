`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2021 18:27:32
// Design Name: 
// Module Name: counter_testbench
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


module counter_testbench;

    reg        clk, reset;
    reg        inc, dec;
    wire [3:0] count;
    
    parameter T = 2;
    
    counter uut
        (
        .clk(clk),
        .reset(reset),
        .inc(inc),
        .dec(dec),
        .count(count)
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
        $display("Behavoural Simulation for Counter\n");
        inc = 0;
        dec = 0;
        
        reset = 1;
        #10;
        reset = 0;
        #10
        
        // sim for attempting to decrement when 'count' is 0x0
        $display("Attempting to decrement when 'count' is 0x0 - Expect no change");
        dec = 1;
        #2  
        dec = 0;
        #2
        $display("Count: 4'h%x\n", count);
        #15
        
        // increment 15 times until 'count' is 0xF
        $display("Incrementing until 'count' is 0xF");
        inc = 1;
        #2  
        inc = 0;
        #8
        $display("Count: 4'h%x", count);
        inc = 1;
        #2  
        inc = 0;
        #8
        $display("Count: 4'h%x", count);
        inc = 1;
        #2  
        inc = 0;
        #8
        $display("Count: 4'h%x", count);
        inc = 1;
        #2  
        inc = 0;
        #8
        $display("Count: 4'h%x", count);
        inc = 1;
        #2  
        inc = 0;
        #8
        $display("Count: 4'h%x", count);
        inc = 1;
        #2  
        inc = 0;
        #8
        $display("Count: 4'h%x", count);
        inc = 1;
        #2  
        inc = 0;
        #8
        $display("Count: 4'h%x", count);
        inc = 1;
        #2  
        inc = 0;
        #8
        $display("Count: 4'h%x", count);
        inc = 1;
        #2  
        inc = 0;
        #8
        $display("Count: 4'h%x", count);
        inc = 1;
        #2  
        inc = 0;
        #8
        $display("Count: 4'h%x", count);
        inc = 1;
        #2  
        inc = 0;
        #8
        $display("Count: 4'h%x", count);
        inc = 1;
        #2  
        inc = 0;
        #8
        $display("Count: 4'h%x", count);
        inc = 1;
        #2  
        inc = 0;
        #8
        $display("Count: 4'h%x", count);
        inc = 1;
        #2  
        inc = 0;
        #8
        $display("Count: 4'h%x", count);
        inc = 1;
        #2  
        inc = 0;
        #8
        $display("Count: 4'h%x\n", count);
        
        
        // sim for attempting to increment when 'count' is 0xF
        $display("Attempting to increment when 'count' is 0xF - Expect no change");
        inc = 1;
        #2  
        inc = 0;
        #8
        $display("Count: 4'h%x\n", count);
        #15     
        
        
        // decrement 2 times until 'count' is 0xD
        $display("Decrement 2 times when 'count' is 0xF - Expect 'count' to be 0xD");
        dec = 1;
        #2  
        dec = 0;
        #8
        $display("Count: 4'h%x", count);
        dec = 1;
        #2  
        dec = 0;
        #8
        $display("Count: 4'h%x\n", count);
        
        
        #15
        // stop simulation 
        $stop;
    end  

endmodule
