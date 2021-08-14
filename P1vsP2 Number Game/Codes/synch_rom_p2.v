`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2021 11:27:08 AM
// Design Name: 
// Module Name: synch_rom_p2
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


module synch_rom_p2(
 input clk,
    input [3:0] addr,
    output reg [7:0] data
    );

    (*rom_style = "block"*) reg [7:0] rom [0:7];
    
    initial
        $readmemb("p2wins.mem", rom);
        
    always @(posedge clk)
    begin
        data <= rom[addr];
    end    
endmodule