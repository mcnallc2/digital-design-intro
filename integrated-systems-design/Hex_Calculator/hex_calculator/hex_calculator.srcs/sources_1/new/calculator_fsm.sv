`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2021 16:05:10
// Design Name: 
// Module Name: calculator_fsm
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


module calculator_fsm #(
    // State Parameters
    parameter LOAD_A        = 5'b00001,
    parameter LOAD_B        = 5'b00010,
    parameter DISP_ANS      = 5'b00100,
    parameter LOAD_PREV_ANS = 5'b01000,
    // Arithmetic Parameters
    parameter EQU = 5'b00001,
    parameter ADD = 5'b00010,
    parameter SUB = 5'b00100,
    parameter MUL = 5'b01000,
    parameter DIV = 5'b10000
    )(
    input        clk,
    input        reset,
    input  [4:0] btn,
    output [4:0] operation,
    output [4:0] state
    );
    
    reg [4:0]  op_ff, op_nxt;
    reg [4:0]  state_ff, state_nxt;

    assign operation = op_ff;
    assign state     = state_ff;
    
    always @ (posedge clk) begin
        if (reset) begin                
            op_ff    <= 'b0;
            state_ff <= LOAD_A;
        end
        else begin
            op_ff    <= op_nxt;
            state_ff <= state_nxt;
        end
    end
    
    always @ (*) begin
        case (state_ff)
            LOAD_A: begin // Load Value A
                case (btn)
                    ADD: begin // BTN U (+)
                        op_nxt    = ADD;
                        state_nxt = LOAD_B;
                    end
                    SUB: begin // BTN L (-)
                        op_nxt    = SUB;
                        state_nxt = LOAD_B;
                    end                        
                    MUL: begin // BTN R (x)
                        op_nxt    = MUL;
                        state_nxt = LOAD_B;
                    end                        
                    DIV: begin // BTN D (/)
                        op_nxt    = DIV;
                        state_nxt = LOAD_B;
                    end
                    default: begin
                        op_nxt    = op_ff;
                        state_nxt = state_ff;        
                    end                    
                endcase
            end
            
            LOAD_B: begin // Load Value B
                op_nxt = op_ff;
                if (btn == EQU) begin // C (=)
                    state_nxt = DISP_ANS;
                end
                else begin
                    state_nxt = LOAD_B;        
                end                    
            end
            
            DISP_ANS: begin // Display Answer
                case (btn)
                    ADD: begin // BTN U (+)
                        op_nxt    = ADD;
                        state_nxt = LOAD_PREV_ANS;
                    end
                    SUB: begin // BTN L (-)
                        op_nxt    = SUB;
                        state_nxt = LOAD_PREV_ANS;
                    end                        
                    MUL: begin // BTN R (x)
                        op_nxt    = MUL;
                        state_nxt = LOAD_PREV_ANS;
                    end                        
                    DIV: begin // BTN D (/)
                        op_nxt    = DIV;
                        state_nxt = LOAD_PREV_ANS;
                    end
                    default: begin
                        op_nxt    = op_ff;
                        state_nxt = state_ff;        
                    end                    
                endcase
            end
            
            LOAD_PREV_ANS: begin // Load Value A w/ prev answer
                op_nxt    = op_ff;
                state_nxt = LOAD_B;                   
            end
            
            default: begin
                op_nxt    = op_ff;
                state_nxt = LOAD_A;                         
            end
            
        endcase
    end
    
endmodule
