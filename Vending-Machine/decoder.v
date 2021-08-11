`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2021 12:19:50 AM
// Design Name: 
// Module Name: decoder
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


module decoder(
    input w0, w1, w2,
    input  s,
    output reg [7: 0] f
    );
    always @(w0, w1, w2)
    begin
        case(s)
            w0: f = 8'b00101; //5
            //w1: f = 8'b01111; //10
           // w2: f = 8'b10100; //20
            default: f = 8'b00000;
        endcase
    end
endmodule
