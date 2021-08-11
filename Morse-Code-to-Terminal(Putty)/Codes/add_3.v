`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2021 06:06:04 PM
// Design Name: 
// Module Name: add_3
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


module add_3(
    input [3:0] A,
    output reg [3:0] S

    );
    always@(A)
    begin 
        if ( A <= 4'b0100)
           S = A;
        else if (A > 4'b0100 & A <= 4'b1001)
           S = A + 3;
        else
           S = 4'bxxxx;
    end
           
    
    
endmodule
