module FSM_New(
    input clk,
    input reset_n,
    input DD, S,
    output dot,dash,lg,wg
    );
    
    reg [3:0] state_reg, state_next;
    localparam s0 = 0;
    localparam s1 = 1;
    localparam s2 = 2;
    localparam s3 = 3;
    localparam s4 = 4;
    localparam s5 = 5;
    
    // State register
    always @(posedge clk, negedge reset_n)
    begin
        if (~reset_n)
            state_reg <= s0;
        else
            state_reg <= state_next;
    end
    
    // Next State
    always @(*)
    begin
        case(state_reg)
            s0: if(DD || ~S) 
                    state_next = s1;
                else
                    state_next = s0;
            s1: if(DD == 3 || ~S ) 
                    state_next = s2;
                else
                    state_next = s3;
            s2: if(DD == 3 || ~S) 
                    state_next = s2;
                else
                    state_next = s3;
            s3: if(DD == 0 || S == 3)  
                    state_next = s4;
                else 
                    state_next = s1;    
            s4: if(DD == 0 || S == 7)  
                    state_next = s5;
                else
                    state_next = s1;
            s5: if(DD == 1 || S == 0)  
                    state_next = s1; //wg
                else
                    state_next = s5;     
            default: state_next = state_reg;
        endcase
    
    end
    
 
    assign dot = (state_reg == s1) & ~S;
    assign dash = (state_reg == s2) & S;
    assign lg = (state_reg == s4) & ~S;
    assign wg = (state_reg == s5) & ~S; 

    
endmodule