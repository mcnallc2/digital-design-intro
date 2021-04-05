`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2021 11:16:44
// Design Name: 
// Module Name: calculator_tb
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


module calculator_tb();

    logic        clk;
    logic [15:0] sw;
    logic [4:0]  btn; // C-U-L-R-D
    logic [32:0] disp_value;
    logic [15:0] led;
    logic [6:0]  seg;
    logic [3:0]  an;

    top_level_wrapper top_level_wrapper_i(
        .clk(clk),
        .sw(sw),
        .btn(btn),
        .disp_value(disp_value),
        .led(led),
        .seg(seg),
        .an(an)
    );
    
    
    
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    
    initial begin
        sw = 0;
        
        // addition tests
        system_reset();
        test_operation(16'b0000_0011_1100_0000, 16'b0000_0011_1100_0000, 5'b00010); // 3 + 3
        system_reset();
        test_operation(16'b1111_1101_1100_0000, 16'b1111_1101_1100_0000, 5'b00010); // -3 + (-3)
        system_reset();
        test_operation(16'b1111_1101_1100_0000, 16'b0000_0011_1100_0000, 5'b00010); // 3 + (-3)

        // subtraction tests
        system_reset();
        test_operation(16'b0000_0011_1100_0000, 16'b0000_0011_1100_0000, 5'b00100); // 3 - 3
        system_reset();
        test_operation(16'b1111_1101_1100_0000, 16'b1111_1101_1100_0000, 5'b00100); // -3 - (-3)
        system_reset();
        test_operation(16'b1111_1101_1100_0000, 16'b0000_0011_1100_0000, 5'b00100); // 3 - (-3)

        // multplication tests
        system_reset();
        test_operation(16'b0000_0011_1100_0000, 16'b0000_0011_1100_0000, 5'b01000); // 3 * 3
        system_reset();
        test_operation(16'b1111_1101_1100_0000, 16'b1111_1101_1100_0000, 5'b01000); // -3 * (-3)
        system_reset();
        test_operation(16'b1111_1101_1100_0000, 16'b0000_0011_1100_0000, 5'b01000); // 3 * (-3)

        // division tests
        system_reset();
        test_operation(16'b0000_0011_1100_0000, 16'b0000_0011_1100_0000, 5'b10000); // 3 / 3
        system_reset();
        test_operation(16'b1111_1101_1100_0000, 16'b1111_1101_1100_0000, 5'b10000); // -3 / (-3)
        system_reset();
        test_operation(16'b1111_1101_1100_0000, 16'b0000_0011_1100_0000, 5'b10000); // 3 / (-3)


        // testing answer memory
        system_reset();
        test_operation(16'b0000_0011_0000_0000, 16'b0000_0011_0000_0000, 5'b00010); // 3 + 3 = 6
        repeat(5) @(posedge clk);
        test_prev_ans_operation(16'b0000_0011_0000_0000, 5'b00010); // 6 + 3 = 9
        repeat(5) @(posedge clk);
        test_prev_ans_operation(16'b0000_0011_0000_0000, 5'b00010); // 9 + 3 = 12
        repeat(5) @(posedge clk);

    end
    
    
    //======================================
    // task definitions
    //======================================
    
    // task to sim system reset
    task system_reset();
        begin
            btn  = 5'b00001;
            repeat(100) @(posedge clk);
            btn  = 5'b00000;
        end
    endtask

    // task to perfom operation
    task test_operation(
        input [15:0] value_a,
        input [15:0] value_b,
        input [4:0] operation
        );
        begin
            sw = value_a;
            repeat(5) @(posedge clk);
            btn = operation;            
            repeat(5) @(posedge clk);
            sw = value_b;
            repeat(5) @(posedge clk);
            btn = 5'b00001;
            repeat(5) @(posedge clk); 
        end
    endtask

    // task to perfom operation on previous answer
    task test_prev_ans_operation(
        input [15:0] value_b,
        input [4:0] operation
        );
        begin
            btn = operation;            
            repeat(5) @(posedge clk);
            sw = value_b;
            repeat(5) @(posedge clk);
            btn = 5'b00001;
            repeat(5) @(posedge clk); 
        end
    endtask
    
endmodule
