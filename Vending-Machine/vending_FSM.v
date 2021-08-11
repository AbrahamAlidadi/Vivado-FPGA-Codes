`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2021 10:32:46 PM
// Design Name: 
// Module Name: vending_FSM
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


module vending_FSM(
    input clk,
    input reset_n,
    input five,ten,twentyfive,item_taken,
   output dispense,R5,R10,R20,
   
   output reg [7:0] Rtotal,
   output [7:0] amount
    );
    
    reg [5:0] state_reg, state_next;
    localparam s0 = 0;
    localparam s1 = 5;
    localparam s2 = 10;
    localparam s3 = 25;
    localparam s4 = 15;
    localparam s5 = 20;
    localparam s6 = 30;
    localparam s7 = 35;
    localparam s8 = 40;
    localparam s9 = 45;

    
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
            s0:
               if(five) //0c
                    state_next = s1;//5
               else if (ten)
                    state_next = s2;    //10  
               else if (twentyfive)
                    state_next = s3;//25
              
            s1: if(five)  //5c
                    state_next = s2;//10
               else if (ten)
                    state_next = s4; //15
               else if (twentyfive)
                    state_next = s6; //30
             
             
            s2: if(five)//10c 
                    state_next = s4; //15
               else if (ten)
                    state_next = s5;//20
               else if (twentyfive)
                    state_next = s7;//35
              
            s3: if(five) //25
                    state_next = s6;//30
               else if (ten)//35
                    state_next = s7;        
               else if(item_taken) 
                    state_next = s0;
              
            s4: if(five) //15c
                    state_next = s5;//20
               else if (ten)
                    state_next = s3;//25
               else if (twentyfive)
                    state_next = s8;//40
              
            s5:if(five) //20
                    state_next = s3;//25                   
               else if (ten)
                    state_next = s6;//30
               else if (twentyfive)
                    state_next = s9;//45
              
            s6: if(item_taken) //30c
                    state_next = s0;               
              
            s7: if(item_taken) //35
                    state_next = s0;
                 
            s8: if(item_taken) //40
                    state_next = s0;
               
            s9: if(item_taken) //45
                    state_next = s0;
             
              
            default: state_next = state_reg;
        endcase
    
    end
    
    
     assign R5 =(state_reg == s6)||(state_reg == s8) ;
     assign R10 =(state_reg == s7)||(state_reg == s8);
     assign R20 =(state_reg == s9);
     assign dispense = (state_reg == s3)||(state_reg == s6)||(state_reg == s7)||(state_reg == s8);
    
    assign amount = state_reg; //amount of coins the user puts into the machine

//leftover change
    always @(*)
    begin   
    case(state_reg)  
      s6:
            Rtotal = 7'd5; 
      s7:
            Rtotal = 7'd10;
      s8:
            Rtotal = 7'd15;
      s9:
            Rtotal = 7'd20;           
      s0,s1, s2, s3, s4, s5:
            Rtotal = 7'd0; 
    endcase
    end

endmodule
