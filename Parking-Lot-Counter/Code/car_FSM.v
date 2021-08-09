`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2021 02:12:20 PM
// Design Name: 
// Module Name: conseq_sequence
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


module car_FSM(
    input clk,
    input reset_n,
    input a,b,
   output enter,exit
    );
    
    reg [2:0] state_reg, state_next;
    localparam s0 = 0;
    localparam s1 = 1;
    localparam s2 = 2;
    localparam s3 = 3;
    localparam s4 = 4;
    localparam s5 = 5;
    localparam s6 = 6;

    
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
            s0: if(a & ~b) 
                    state_next = s1;
               else if (~a & b)
                    state_next = s4;      
               else if (~a & ~b)
                    state_next = s0;
               else if (a & b)
                    state_next = s0;
            s1: if(a & b) 
                    state_next = s2;
               else if (~a & ~b)
                    state_next = s0;
               else if (a & ~b)
                    state_next = s1;
               else if (~a & b)
                    state_next = s1;
             
            s2: if(~a & b)  
                    state_next = s3;
               else if (a & ~b)
                    state_next = s1;
               else if (a & b)
                    state_next = s2;
               else if (~a & ~b)
                    state_next = s2;
            s3: if(~a & ~b)  
                    state_next = s0;
               else if (a & b)
                    state_next = s2;
               else if (~a & b)
                    state_next = s3;
               else if(a & ~b)  
                    state_next = s3;
            s4: if(a & b)  
                    state_next = s5;
                else if (~a & ~b)
                    state_next = s0;
                else if (~a & b)
                    state_next = s4;
                else if (a & ~b)
                    state_next = s0;
            s5: if(a & ~b)  
                    state_next = s6; 
                else if (~a & b)
                    state_next = s4;
               else if (a & b)
                    state_next = s5;
               else if (~a & ~b)
                    state_next = s5;
            s6: if(~a & ~b)
                    state_next = s0;
                else if (a & b)
                    state_next = s5;
                else if (a & ~b)
                    state_next = s6;
                else if (a & ~b)
                    state_next = s6;
                    
            default: state_next = state_reg;
        endcase
    
    end

     assign exit =(state_reg == s6) & (~a & ~b);
     assign enter =(state_reg == s3) & (~a & ~b);
    endmodule
