`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2021 02:51:27 AM
// Design Name: 
// Module Name: morse_simple_fsm
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


module morse_simple_fsm( 
    input clk,reset_n,
    output dot_out,dash_out,lg,wg,
    input b
    );
   
    reg [6:0] state_reg, state_next;
    localparam s0 = 0;
    localparam s1 = 1;
    localparam s2 = 2;
    localparam s3 = 3;
    localparam s4 = 4;
    localparam s5 = 5;
    localparam s6 = 6;
    localparam s7 = 7;    
    localparam sLG = 9;
   localparam sWG = 10;
   localparam sdash = 10;
   
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
                    state_next = s3;
               else if (b)
                    state_next = s2;
                  
             
            s2: if(b)  
                    state_next = s3;
            else if (~b)
                    state_next = s1;
          
                    
            s3: if(~b) //dash output
                    state_next = s4;
             
            s3: if(~b)  
                    state_next = s4;
                
            s4: if(~b)  
                    state_next = sLG;
               
            sLG: if(~b)  
                    state_next = s5;
                 else if (b)
                    state_next = s1;
            s5: if(~b)  
                    state_next = s6;
                 
            s6: if(~b)  
                    state_next = s7;
                    
            s7: if(~b)  
                    state_next = sWG;
                   
            sWG: if(~b)  
                    state_next = sWG;
                    else if (b)
                    state_next = s1;
           
            default: state_next = state_reg;
        endcase
    
    end
    
  
     assign dot_out = (state_reg == s1) & (~b) ;
     assign dash_out =((state_reg == s2) & (b));
     
   
     assign lg = ((state_reg == sLG) & (b)) ;
     assign wg = ((state_reg == sWG) & (b));
     
     

    
    endmodule
