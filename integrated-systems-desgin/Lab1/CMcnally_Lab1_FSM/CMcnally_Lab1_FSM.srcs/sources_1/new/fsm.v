`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2021 14:51:22
// Design Name: Lab1
// Module Name: fsm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Finite State Machine module monitoring two gate sensors
// to determine whether a car has entered or exited the carpark
// 
//////////////////////////////////////////////////////////////////////////////////


module fsm(
    input   clk,
    input   reset,
    input   a,
    input   b,
    output  enter,
    output  exit
    );
    
    // registers
    reg [6:0] state_ff, state_nxt;
    reg       enter_ff, enter_nxt;
    reg       exit_ff, exit_nxt;

    // connect output regs to output wires
    assign enter = enter_ff;
    assign exit = exit_ff;
    
    // one-hot encoded state parameters
    parameter   clear               = 7'b0000001,
                a_blocked_enter     = 7'b0000010,
                a_blocked_exit      = 7'b0000100,
                b_blocked_enter     = 7'b0001000,
                b_blocked_exit      = 7'b0010000,
                both_blocked_enter  = 7'b0100000,
                both_blocked_exit   = 7'b1000000;
                
    
    // Sequential Logic - Asynchronous Reset
    always @(posedge clk, posedge reset) begin
        // if reset - state is clear with enter/exit low
        if(reset == 1'b1) begin 
            state_ff <= clear;
            enter_ff <= 1'b0;
            exit_ff  <= 1'b0;
        end
        // else update state and enter/exit regs
        else begin
            state_ff <= state_nxt;
            enter_ff <= enter_nxt;
            exit_ff  <= exit_nxt;
        end
    end


    // Combinational Logic
    always @(*) begin
        case(state_ff)
            // Both sensors are unblocked - Clear state
            clear: begin
                // enter/exit default low
                enter_nxt = 1'b0;
                exit_nxt  = 1'b0;
                
                // if A high and B low - Move to entering A blocked state
                if (a & ~b) begin
                    state_nxt = a_blocked_enter;
                end
                // if A low and B high - Move to exiting B blocked state
                else if (~a & b) begin
                    state_nxt = b_blocked_exit;
                end
                // else remain in current state
                else begin
                    state_nxt = state_ff;
                end
            end
            
            // Entering A blocked state
            a_blocked_enter: begin
                // enter/exit default low
                enter_nxt = 1'b0;
                exit_nxt  = 1'b0;
                
                // if A high and B high - Move to entering both blocking state
                if (a & b) begin
                    state_nxt = both_blocked_enter;
                end
                // if A low and B low - Move to clear state
                else if (~a & ~b) begin
                    state_nxt = clear;
                end
                // if A low and B high - Move to clear state
                else if (~a & b) begin
                    state_nxt = clear;
                end
                // else remain in current state
                else begin
                    state_nxt = state_ff;
                end
            end
            
            // Exiting A blocked state
            a_blocked_exit: begin
                // enter/exit default low
                enter_nxt = 1'b0;
                exit_nxt  = 1'b0;
                
                // if A high and B high - Move to exiting both blocking state
                if (a & b) begin
                    state_nxt = both_blocked_exit;
                end
                // if A low and B low - Move to clear state
                // Exit output is triggered
                else if (~a & ~b) begin
                    state_nxt = clear;
                    exit_nxt  = 1'b1;
                end
                // if A low and B low - Move to clear state 
                else if (~a & b) begin
                    state_nxt = clear;
                end
                // else remain in current state
                else begin
                    state_nxt = state_ff;
                end
            end
            
            // Entering B blocked state
            b_blocked_enter: begin
                // enter/exit default low                
                exit_nxt  = 1'b0;
                enter_nxt = 1'b0;
                
                // if A high and B high - Move to entering both blocked state
                if (a & b) begin
                    state_nxt = both_blocked_enter;
                end
                
                // if A high and B low - Move to clear state
                else if (a & ~b) begin
                    state_nxt = clear;
                end
                
                // if A low and B low - Move to clear state
                // Enter output is triggered
                else if (~a & ~b) begin
                    state_nxt = clear;
                    enter_nxt = 1'b1;
                end
                // else remain in current state
                else begin
                    state_nxt = state_ff;
                end
            end
            
            // Exiting B blocked state
            b_blocked_exit: begin
                // enter/exit default low
                enter_nxt = 1'b0;
                exit_nxt  = 1'b0;
                
                // if A high and B high - Move to both blocked state
                if (a & b) begin
                    state_nxt = both_blocked_exit;
                end
                // if A high and B low - Move to clear state
                else if (a & ~b) begin
                    state_nxt = clear;
                end
                // if A low and B low - Move to clear state
                else if (~a & ~b) begin
                    state_nxt = clear;
                end
                // else remain in current state
                else begin
                    state_nxt = state_ff;
                end
            end
            
            // Entering both blocking state
            both_blocked_enter: begin
                // enter/exit default low
                enter_nxt = 1'b0;
                exit_nxt  = 1'b0;
                
                // if A low and B high - Move to entering B blocking state
                if (~a & b) begin
                    state_nxt = b_blocked_enter;
                end
                
                // if A high and B low - Move to entering A blocking state
                else if (a & ~b) begin
                    state_nxt = a_blocked_enter;
                end
                // if A low and B low - Move to clear state
                else if (~a & ~b) begin
                    state_nxt = clear;
                end
                // else remain in current state
                else begin
                    state_nxt = state_ff;
                end
            end
            
            // Exiting both blocking state
            both_blocked_exit: begin
                // enter/exit default low
                enter_nxt = 1'b0;
                exit_nxt  = 1'b0;
                
                // if A high and B low - Move to exiting A blocking state
                if (a & ~b) begin
                    state_nxt = a_blocked_exit;
                end
                // if A high and b low - Move to entering B blocking state
                else if (a & ~b) begin
                    state_nxt = b_blocked_enter;
                end
                // if A low and B low - Move to clear state
                else if (~a & ~b) begin
                    state_nxt = clear;
                end
                // else remain in current state
                else begin
                    state_nxt = state_ff;
                end
            end
            
            // default to clear state with enter/exit low
            default: begin
                state_nxt = clear;
                enter_nxt = 1'b0;
                exit_nxt  = 1'b0;
            end
            
        endcase
    end
    
    
endmodule
