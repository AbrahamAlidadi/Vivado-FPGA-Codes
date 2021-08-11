`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2021 01:56:29 PM
// Design Name: 
// Module Name: five_bit_shift_reg
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


module five_bit_shift_reg
(
    input clk, 
    input reset_n, 
    input shift, SI,
    output reg [4:0] Q
    );

    always@(posedge clk, negedge reset_n)
    begin
    if(reset_n)
        Q<=0;
    else if(shift)
        Q[4] <= Q[3];
        Q[3] <= Q[2];
        Q[2] <= Q[1];
        Q[1] <= Q[0];
        Q[0] <= SI;
    end
endmodule