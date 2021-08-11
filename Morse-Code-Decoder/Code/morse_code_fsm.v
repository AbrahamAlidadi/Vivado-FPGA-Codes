`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2021 01:27:32 PM
// Design Name: 
// Module Name: morse_code_fsm
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


module morse_code_fsm(
    input clk,reset_n,
    output dot_out,dash_out,lg,wg,
    input b
    );
   
    reg [10:0] state_reg, state_next;
    localparam s0 = 0;
    localparam s8 = 8;
    localparam s2 = 2;
    localparam s3 = 3;
    localparam s4 = 4;
    localparam s5 = 5;
    localparam s6 = 6;
    localparam s7 = 7;
    
    localparam s9 = 9;
    
    localparam s11 = 11;
    localparam s12 = 12;
    localparam s13 = 13;
    localparam sdot = 14;
    localparam sdash = 15;
    localparam sLG1 = 16;
    localparam sWG1 = 17;
    localparam sLG2 = 18;
    localparam sWG2 = 19;
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
        state_next = state_reg;
        case(state_reg)
              
            s0: if(~b) //goes to dot output
                    state_next = s0;
               else if (b)
                    state_next = sdot;
               else
                    state_next = s0;
            sdot: if(~b) 
                    state_next = s8;
               else if (b)
                    state_next = s2;
               else
                    state_next = sdot;            
             
            s2: if(b)  
                    state_next = sdash;
            else if (~b)
                    state_next = sdot;
            else 
                    state_next = s2;
                    
            sdash: if(b) //dash output
                    state_next = sdash;
             else if (~b)
                    state_next = s3;
             else
                    state_next = sdash;
            s3: if(~b)  
                    state_next = s4;
                else if (b)
                    state_next = sdot;
            s4: if(~b)  
                    state_next = s5;
                 else if (b)
                    state_next = sdot;
            s5: if(~b)  
                    state_next = s6;
                 else if (b)
                    state_next = sdot;
            s6: if(~b)  
                    state_next = s7;
                   else if (b)
                    state_next = sdot;  
            s7: if(~b)  
                    state_next = sWG2;
                    else if (b)
                    state_next = sdot;
            sWG2: if(~b)  
                    state_next = s0;
                    else if (b)
                    state_next = sdot;
            s9: if(~b)  
                    state_next = s9;
                    else if (b)
                    state_next = sdot;
            s9: if(~b)  
                    state_next = sLG1;
                    else if (b)
                    state_next = sdot;
             s11: if(~b)  
                    state_next = sLG1;
                    else if (b)
                    state_next = sdot;
             s12: if(~b)  
                    state_next = s13;
                    else if (b)
                    state_next = sdot;
             s13: if(~b)  
                    state_next = sWG1;
                    else if (b)
                    state_next = sdot; 
             sWG1: if(~b)  
                    state_next = s0;
                    else if (b)
                    state_next = sdot;
            default: state_next = state_reg;
        endcase
    
    end
    
  
     assign dot_out = (state_reg == sdot) & (~b) ;
     assign dash_out =((state_reg == sdash) & (~b));
     
   
     assign lg = ((state_reg == sLG1) & (~b)) || ((state_reg == sLG2) & (~b)) ;
     assign wg = ((state_reg == sWG2) & (~b)) || ((state_reg == sWG1) & (~b));
     
     

    
    endmodule