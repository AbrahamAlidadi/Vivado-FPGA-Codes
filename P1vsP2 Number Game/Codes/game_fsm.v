`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/12/2021 08:46:38 PM
// Design Name: 
// Module Name: game_fsm
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


module game_fsm(
    input clk,
    input reset_n,
    input p1,mid,p2,
    input [7:0] p1number,p2number,
    input [1:0] p1count,p2count,
    output start,idle,p2input,p1winsround,p2winsround,p1winsgame,p2winsgame,clearstate
    );
    
    reg [7:0] state_reg, state_next;
    localparam s0 = 0;  //idle state
    localparam s1 = 1;  //p1starts
    localparam s2 = 2;  //p2starts
    localparam s3 = 3;  //compare
    localparam s4 = 4;  //p1winsround
    localparam s5 = 5;  //p12winsround
    localparam s6 = 6;  //p1winsgames
    localparam s7 = 7;  //p2winsgames
    localparam s8 = 8;  //clearstate
  
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
            s0: if(mid)  //idle state
                    state_next = s1;
                else
                    state_next = s0;
            s1: if(p1) 
                    state_next = s2;
                else
                    state_next = s1;
            s2: if(p2)  
                    state_next = s3;
              else
                    state_next = s2;
                    
            s3: 
           
            if(p1number>p2number)  
                    state_next = s4; //p1 winsround
               else if (p1number<p2number)
                    state_next = s5; //p2winsround           
               
               
                    
            s4: if(p1count==1)  //p1 wins games when p1 has score 2
                    state_next = s6;
                    
                else 
                    state_next = s1;
            
            s5: if(p2count==1)  //p2 wins games when p1 has score 2
                    state_next = s7; 
               else 
                    state_next = s1;
                    
           s6: if(mid)  //clear state for a reset
                    state_next = s8;
                    
            else 
                    state_next = s6;
                    
            s7: if(mid)  
                    state_next = s8; 
          else 
                    state_next = s7;
                    
        s8: if(mid)  //go back to idle state
                    state_next = s0; 
          else 
                    state_next = s8;
            default: state_next = state_reg;
        endcase
    
    end
    

   assign start =  (state_reg == s1);
   assign idle =  (state_reg == s0);
   assign p2input =  (state_reg == s2);
   assign p1winsround =  (state_reg == s4);
   assign p2winsround =  (state_reg == s5);
   assign p1winsgame  =  (state_reg == s6);
   assign p2winsgame  =  (state_reg == s7);
   assign clearstate =  (state_reg == s8); 
  
    endmodule