//this module takes the results of each operation and stores the correct result in final_of depenting on the the function
module Select_fn(res0, res1, res2, res3, res4, res5, res6, res7, of0, of1, final, final_of, func);
        
    //these are the input results from each operation, the final output result and the input function
    input wire [5:0] res0, res1, res2, res3, res4, res5, res6, res7;
    output reg [5:0] final;
    input wire [2:0] func;
    
    //these are the input overflows for (A+B) & (A-B), the output final overflow
    input wire of0, of1;
    output reg final_of;
    
    //this always block allows us to continuoulsy check our case statement
    always@(*)
    begin
        //this case statement is where we store the correct result and overflow value in their outputs - 
        //depending on t=what function is specified.
        case(func)
            // A
            3'b000:
                begin
                final = res0;
                final_of = 1'b0;
                end
            // B
            3'b001:
                begin
                final = res1;
                final_of = 1'b0;
                end
            // -A
            3'b010:
                begin
                final = res2;
                final_of = 1'b0;
                end
            // -B
            3'b011:
                begin
                final = res3;
                final_of = 1'b0;
                end
            // A >= B
            3'b100:
                begin
                final = res4;
                final_of = 1'b0;
                end
            // A ^ B
            3'b101:
                begin
                final = res5;
                final_of = 1'b0;
                end
            // A + B
            3'b110:
                begin
                final = res6;
                final_of = of0;
                end
            // A - B
            3'b111:
                begin
                final = res7;
                final_of = of1;
                end
            
            // default case adds A and B
            default: 
                begin
                final = res6;
                final_of = 1'b0;
                end
        endcase
    end

endmodule
