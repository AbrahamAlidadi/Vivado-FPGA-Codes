`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2021 06:36:14 PM
// Design Name: 
// Module Name: morse_code_two
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


module morse_code_two(
    input clk,reset_n,
    output dot_out,dash_out,
    input b
    );
    reg [2:0] state_reg, state_next;
    localparam s0 = 0;
    localparam s1 = 1;
    localparam s2 = 2;
    localparam s3 = 3;
    localparam s4 = 4;
    
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
        state_next = state_reg;
        case(state_reg)
              
            s0: if(~b) //goes to dot output
                    state_next = s0;
               else if (b)
                    state_next = s1;
               else
                    state_next = s0;
            s1: if(~b) 
                    state_next = s2;
               else if (b)
                    state_next = s3;
                         
             
            s2: if(~b)  
                    state_next = s0;
           
                    
            s3: if(b) //dash output
                    state_next = s4;
             else if (~b)
                    state_next = s2;
           
            s4: if(~b)  
                    state_next = s0;
                else if (b)
                    state_next = s4;
         
            default: state_next = state_reg;
        endcase
    
    end
    
  
     assign dot_out = (state_reg == s2) & (~b) ;
     assign dash_out =((state_reg == s4) & (~b));
     
   
     //assign lg = ((state_reg == sLG1) & (~b)) || ((state_reg == sLG2) & (~b)) ;
    // assign wg = ((state_reg == sWG2) & (~b)) || ((state_reg == sWG1) & (~b));
     
endmodule
