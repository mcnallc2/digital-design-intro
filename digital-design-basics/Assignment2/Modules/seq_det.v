//this my sequence detector that uses the output bit of the lfsr in order to detected the sequence 11110
//this sequneces detector has been minimised to 5 FSMs
module sequence_detector
    (
    input wire clk, reset,
    input wire lfsr_out,
    output reg seq_det_out
    );
    
    //signal declaration
    reg [2:0] current_state, next_state;
    //these parameters are used to differenciate between each FSM
    localparam A = 3'b000,
               B = 3'b001,
               C = 3'b010,
               D = 3'b011,
               E = 3'b100;
               
    // changing states
    always @(posedge clk, posedge reset)
        begin
        //if there is a reset, go back the FSM A
        if(reset)
            current_state <= A;
        //else move to the next state
        else
            current_state <= next_state;
        end
        
    // sequence detector using Mealy FSMs
    always @(current_state, lfsr_out)
        begin
        //check the state of the current FSM
        case(current_state)
            //if FSM A
            A:
            begin
            //no sequence detected
            seq_det_out = 0;
            //if we recieve a 1 move to B
            if(lfsr_out == 1)
                next_state = B;
            //else dont change
            else
                next_state = A;
            end
            
            //if FSM B  
            B:
            begin
            //no sequence detected
            seq_det_out = 0;
            //if we recieve a 1 move to C
            if(lfsr_out == 1)
                next_state = C;
            //else return to A
            else
                next_state = A;
            end
            
            //if FSM C
            C:
            begin
            //no sequence detected
            seq_det_out = 0;
            //if we recieve a 1 move to D
            if(lfsr_out == 1)
                next_state = D;
            //else return to A
            else
                next_state = A;
            end
              
            //if FSM D  
            D:
            begin
            //no sequence detected
            seq_det_out = 0;
            //if we recieve a 1 move to E
            if(lfsr_out == 1)
                next_state = E;
            //else return to A
            else
                next_state = A;
            end
              
            //if FSM E  
            E:
            //if we recieve a 0 move to sequence is detected, next state is A
            if(lfsr_out == 0)
            begin
                seq_det_out = 1;
                next_state = A;
            end
            //else there is no sequence detected, return to E
            else
            begin
                seq_det_out = 0;
                next_state = E;
            end
            
        endcase
        end
        
endmodule