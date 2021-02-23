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

module stim_gen(
    output reg       test_clk,
    output reg       test_reset,
    output reg       test_a,
    output reg       test_b,
    output reg [3:0] expected_count,
    output reg       check,
    //
    output reg [4:0] i,
    output reg [4:0] j
    );
    
    parameter T = 2;
    parameter delay = 4;
    reg [4:0] i = 0;
    reg [4:0] j = 0;  
     
    always
    begin
        test_clk = 1'b0;
        #(T/2);
        test_clk = 1'b1;
        #(T/2);
    end
    

    initial begin
        $display(">>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~ >>>>");
        $display(">>>> Behavoural Simulation Begin >>>>");
        $display(">>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~ >>>>");
        
        // initilising values
        expected_count = 1;
        check  = 0;
        test_a = 0;
        test_b = 0;
        
        // setting reset
        system_reset;
        
//        $display("<<< Testing FSM >>>\n");      
//        // running through all possible cases for the finite state machine 
//        // counter should only change value twice for enter/exit cases
//        for(i=0; i<5'h1F; i=i+1) begin
//            for(j=0; j<5'h1F; j=j+1) begin       
//                input_sequence_task(i,j);
//                system_reset;
//            end
//        end
//        #(delay*2);
        
        $display("\n>>>> Testing Counter >>>>");  
        $display("\n>>>> >>>> Attempting to exit when 'count' is 0x0 - Expect no change");
        // exit case
        input_sequence_task(5'b01100, 5'b00110);  // expect 0x0
        trigger_check();
        
        $display("\n>>>> >>>> Incrementing until 'count' is 0xF");
        while (expected_count < 4'hF) begin
            // enter case
            input_sequence_task(5'b00110, 5'b01100); // expect 0xF
        end
        trigger_check();
        
        $display("\n>>>> >>>> Attempting to increment when 'count' is 0xF - Expect no change");
        // enter case   
        input_sequence_task(5'b00110, 5'b01100); // expect 0xF
        trigger_check();
                
        $display("\n>>>> >>>> Decrementing until 'count' is 0x0");
        while (expected_count > 4'h0) begin
            // exit case
            input_sequence_task(5'b01100, 5'b00110); // expect 0x0
        end
        trigger_check();
                
        #(delay*2);
        // stop simulation 
        $stop;
    end
    
    
    task input_sequence_task(
        input [4:0] a, 
        input [4:0] b
        );
        begin
            // sim for a car entering
//            $display("Case: (%d%d)->(%d%d)->(%d%d)->(%d%d)->(%d%d)",a[0],b[0],a[1],b[1],a[2],b[2],a[3],b[3],a[4],a[4]);
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
            #(delay/2);

            if (expected_count < 4'hF) begin
                if (a==5'b00110 && b==5'b01100) begin
                    expected_count = expected_count + 1;
                end
                else if (a==5'b00111 && b==5'b01101) begin
                    expected_count = expected_count + 1;
                end
                else begin
                    expected_count = expected_count;    
                end
            end
            else begin
                expected_count = expected_count;
            end
            
            if (expected_count > 4'h0) begin  
                if (a==5'b01100 && b==5'b00110) begin
                    expected_count = expected_count - 1;
                end  
                else if (a==5'b01101 && b==5'b00111) begin
                    expected_count = expected_count - 1;
                end
                else begin
                    expected_count = expected_count;
                end
            end
            else begin
                expected_count = expected_count;
            end
            
            #(delay*2);
        end
    endtask


    task system_reset;
    begin   
        $display(">>>> System Reset");  
        test_reset = 1;
        test_a = 0;
        test_b = 0;
        expected_count = 0;
        #delay;
        test_reset = 0;
        #delay;
    end
    endtask
    
    task trigger_check;
    begin   
        $display(">>>> Trigger Counter Check");  
        check = 1;
        #(delay/2);
        check = 0;
        #(delay/2);
    end
    endtask
    
    
    
endmodule