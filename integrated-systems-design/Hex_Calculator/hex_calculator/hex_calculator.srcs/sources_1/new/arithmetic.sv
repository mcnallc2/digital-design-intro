`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2021 16:15:47
// Design Name: 
// Module Name: arithmetic
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

//`define SIM

module arithmetic #(
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
    input clk,
    input reset,
    input [15:0] sw,
    input [4:0] state,
    input [4:0] operation,
    output [15:0] ss_value,
    output [15:0] leds
    );
    
    // multiplier registers
    reg  signed [15:0] value_a_mult_ff, value_a_mult_nxt;
    reg  signed [15:0] value_b_mult_ff, value_b_mult_nxt;
    wire signed [31:0] answer_mult;
    
    // divider axi registers
    reg  s_axis_div_tvalid_ff, s_axis_div_tvalid_nxt;
    reg  signed [15:0] s_axis_divisor_tdata_ff, s_axis_divisor_tdata_nxt;
    reg  signed [15:0] s_axis_dividend_tdata_ff, s_axis_dividend_tdata_nxt;
    wire s_axis_divisor_tready, s_axis_dividend_tready;
    wire m_axis_dout_tvalid;
    wire signed [31:0] m_axis_dout_tdata;
    
         
    reg signed [15:0] value_a_ff, value_a_nxt;
    reg signed [15:0] value_b_ff, value_b_nxt;
    
    reg [15:0] ss_val_ff, ss_val_nxt;
    reg [15:0] leds_ff, leds_nxt;
    assign ss_value = ss_val_ff;
    assign leds     = leds_ff;

    reg  signed [31:0] ans_ff, ans_nxt;
    
    // sequential block
    always @ (posedge clk) begin
        if (reset) begin     
            value_a_ff <= 'h0;            
            value_b_ff <= 'b0;
            ss_val_ff  <= 'b0;
            leds_ff    <= 'b0;
            ans_ff     <= 'b0;
            value_a_mult_ff           <= 'b0;
            value_b_mult_ff           <= 'b0;
            s_axis_div_tvalid_ff  <= 'b0;
            s_axis_divisor_tdata_ff   <= 'b0;
            s_axis_dividend_tdata_ff  <= 'b0;
        end
        else begin
            value_a_ff <= value_a_nxt;
            value_b_ff <= value_b_nxt;
            ss_val_ff  <= ss_val_nxt;
            leds_ff    <= leds_nxt;
            ans_ff     <= ans_nxt;
            value_a_mult_ff           <= value_a_mult_nxt;
            value_b_mult_ff           <= value_b_mult_nxt;  
            s_axis_div_tvalid_ff  <= s_axis_div_tvalid_nxt;
            s_axis_divisor_tdata_ff   <= s_axis_divisor_tdata_nxt;
            s_axis_dividend_tdata_ff  <= s_axis_dividend_tdata_nxt;
        end
    end
   
    // making calculations
    always @ (*) begin
        case (state)
            LOAD_A: begin // Load Value A
                ans_nxt                    = 'b0;
                value_a_mult_nxt           = 'b0;
                value_b_mult_nxt           = 'b0;
                s_axis_div_tvalid_nxt      = 'b0;
                s_axis_divisor_tdata_nxt   = 'b0;
                s_axis_dividend_tdata_nxt  = 'b0;
            end
            
            LOAD_B: begin // Load Value B
                ans_nxt                    = 'b0;
                value_a_mult_nxt           = 'b0;
                value_b_mult_nxt           = 'b0;
                s_axis_div_tvalid_nxt      = 'b0;
                s_axis_divisor_tdata_nxt   = 'b0;
                s_axis_dividend_tdata_nxt  = 'b0;      
            end
            
            DISP_ANS: begin // Display Answer
                case (operation)
                    ADD: begin // BTN U (+)
                        ans_nxt = value_a_ff + value_b_ff;
                        value_a_mult_nxt = 'b0;
                        value_b_mult_nxt = 'b0;
                        s_axis_div_tvalid_nxt      = 'b0;
                        s_axis_dividend_tdata_nxt  = 'b0;
                        s_axis_divisor_tdata_nxt   = 'b0;
                    end
                    SUB: begin // BTN L (-)
                        ans_nxt = value_a_ff - value_b_ff;
                        value_a_mult_nxt = 'b0;
                        value_b_mult_nxt = 'b0;
                        s_axis_div_tvalid_nxt = 'b0;
                        s_axis_dividend_tdata_nxt  = 'b0;
                        s_axis_divisor_tdata_nxt   = 'b0;
                    end                        
                    MUL: begin // BTN R (x)
`ifdef SIM                    
                        ans_nxt = value_a_ff * value_b_ff;
                        value_a_mult_nxt = 'b0;
                        value_b_mult_nxt = 'b0;
                        s_axis_div_tvalid_nxt = 'b0;
                        s_axis_dividend_tdata_nxt  = 'b0;
                        s_axis_divisor_tdata_nxt   = 'b0; 
`else                           
                        value_a_mult_nxt = value_a_ff;
                        value_b_mult_nxt = value_b_ff;
                        ans_nxt          = answer_mult;
                        s_axis_div_tvalid_nxt = 'b0;
                        s_axis_dividend_tdata_nxt  = 'b0;
                        s_axis_divisor_tdata_nxt   = 'b0;
`endif                        
                    end                        
                    DIV: begin // BTN D (/)
`ifdef SIM                    
                        ans_nxt = value_a_ff / value_b_ff;
                        value_a_mult_nxt = 'b0;
                        value_b_mult_nxt = 'b0;
                        s_axis_div_tvalid_nxt = 'b0;
                        s_axis_dividend_tdata_nxt  = 'b0;
                        s_axis_divisor_tdata_nxt   = 'b0;
`else                        
                        value_a_mult_nxt = 'b0;
                        value_b_mult_nxt = 'b0;
                        
                        // send divider data
                        s_axis_div_tvalid_nxt = 1'b1;
                        s_axis_dividend_tdata_nxt  = value_a_ff;
                        s_axis_divisor_tdata_nxt   = value_b_ff;
                        
                        // if recieving divider data
                        if (m_axis_dout_tvalid) begin     
                            ans_nxt = m_axis_dout_tdata;
                        end
                        else begin
                            ans_nxt = ans_ff;
                        end
`endif                        
                    end
                    
                    default: begin
                        ans_nxt = ans_ff;
                        value_a_mult_nxt = 'b0;
                        value_b_mult_nxt = 'b0;
                        s_axis_div_tvalid_nxt = 'b0;
                        s_axis_dividend_tdata_nxt  = 'b0;
                        s_axis_divisor_tdata_nxt   = 'b0;
                    end                    
                endcase
            end
            
            LOAD_PREV_ANS: begin // Load Value A w/ previous Answer
                ans_nxt = ans_ff;
                value_a_mult_nxt = 'b0;
                value_b_mult_nxt = 'b0;
                s_axis_div_tvalid_nxt = 'b0;
                s_axis_dividend_tdata_nxt  = 'b0;
                s_axis_divisor_tdata_nxt   = 'b0;
            end
            
            default: begin
                ans_nxt = 'b0;
                value_a_mult_nxt = 'b0;
                value_b_mult_nxt = 'b0;
                s_axis_div_tvalid_nxt = 'b0;
                s_axis_dividend_tdata_nxt  = 'b0;
                s_axis_divisor_tdata_nxt   = 'b0;                      
            end
            
        endcase
    end
    
    // map memories to peripheries
    always @ (*) begin
        case (state)
            LOAD_A: begin // Load Value A
                value_a_nxt = sw;
                value_b_nxt = value_b_ff;
                ss_val_nxt  = value_a_ff[15:8];
                leds_nxt    = {value_a_ff[7:0], 8'h00};
            end
            
            LOAD_B: begin // Load Value B
                value_a_nxt = value_a_ff;
                value_b_nxt = sw;
                ss_val_nxt  = value_b_ff[15:8];
                leds_nxt    = {value_b_ff[7:0], 8'h00};       
            end
            
            DISP_ANS: begin // Display Answer
                value_a_nxt = value_a_ff;
                value_b_nxt = value_b_ff;
                
                case (operation)
                    ADD: begin // BTN U (+)
                        ss_val_nxt = ans_ff[31:8];
                        leds_nxt   = {ans_ff[7:0], 8'h00};
                    end
                    SUB: begin // BTN L (-)
                        ss_val_nxt = ans_ff[31:8];
                        leds_nxt   = {ans_ff[7:0], 8'h00};
                    end                        
                    MUL: begin // BTN R (x)
                        ss_val_nxt = ans_ff[31:16];
                        leds_nxt   = ans_ff[15:0];
                    end                        
                    DIV: begin // BTN D (/)
                        ss_val_nxt = ans_ff[31:16];
                        leds_nxt   = ans_ff[15:0];
                    end
                    default: begin
                        ss_val_nxt = ss_val_ff;
                        leds_nxt   = leds_ff;
                    end                    
                endcase
            end
            
            LOAD_PREV_ANS: begin // Load Value A w/ previous Answer
                ss_val_nxt = ss_val_ff;
                leds_nxt   = leds_ff;
                case (operation)
                    ADD: begin // BTN U (+)                    
                        value_a_nxt = ans_ff[15:0];
                        value_b_nxt = sw;
                    end
                    SUB: begin // BTN L (-)
                        value_a_nxt = ans_ff[15:0];
                        value_b_nxt = sw;          
                    end                        
                    MUL: begin // BTN R (x)
                        value_a_nxt = ans_ff[23:8];
                        value_b_nxt = sw;
                    end                        
                    DIV: begin // BTN D (/)
                        value_a_nxt = ans_ff[23:8];
                        value_b_nxt = sw;                  
                    end
                    default: begin
                        value_a_nxt = value_a_ff;
                        value_b_nxt = value_b_ff;
                    end                    
                endcase
            end
            
            default: begin
                value_a_nxt = value_a_ff;
                value_b_nxt = value_b_ff;
                ss_val_nxt  = ss_val_ff;
                leds_nxt    = leds_ff;                        
            end
            
        endcase
    end
    
`ifndef SIM    
    mult_gen_0(
        .CLK(clk),
        .A(value_a_mult_ff),
        .B(value_b_mult_ff),
        .P(answer_mult)
    );
    
    div_gen_0 div_gen_0_i(
        .aclk(clk),
        .s_axis_divisor_tvalid(s_axis_div_tvalid_ff),
        .s_axis_divisor_tdata(s_axis_divisor_tdata_ff),
        .s_axis_divisor_tready(s_axis_divisor_tready),
        .s_axis_dividend_tvalid(s_axis_div_tvalid_ff),
        .s_axis_dividend_tdata(s_axis_dividend_tdata_ff),
        .s_axis_dividend_tready(s_axis_dividend_tready),
        .m_axis_dout_tvalid(m_axis_dout_tvalid),
        .m_axis_dout_tdata(m_axis_dout_tdata)
    );
`endif

    
endmodule
