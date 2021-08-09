`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2021 04:15:39 PM
// Design Name: 
// Module Name: parkinglot_tb
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


module parkinglot_tb(

    );
    reg clk, reset_n, a,b;
    wire enter,exit;
      car_FSM utt0(
        .clk(clk),
        .reset_n(reset_n),
        .a(a),
        .b(b),
        .enter(enter),
        .exit(exit)
    );
    localparam T = 10;
    always
    begin
        clk = 1'b0;
        #(T / 2);
        clk = 1'b1;
        #(T / 2);
    end
    
    initial
    begin
        reset_n = 1'b0;
        a = 1'b0;
        b = 1'b0;
        @(negedge clk);
        reset_n = 1'b1;       
        
        a = 1'b0;
        b = 1'b0;
        #T  a = 1'b0;        
        #T  b = 1'b0;
        
        #T  a = 1'b1;        
        #T  b = 1'b0;
                
        #T  a = 1'b1;
        #T  b = 1'b1;
        
        #T  a = 1'b0;
        #T  b = 1'b1;
                
        #T  a = 1'b0;
        #T  b = 1'b0;
        
        #T  a = 1'b0;
        #T  b = 1'b1;
        
        #T  a = 1'b1;
        #T  b = 1'b1;
        
        #T  a = 1'b1;
        #T  b = 1'b0;
        
        #T  a = 1'b0;
        #T  b = 1'b0;
        
        #T  a = 1'b0;
        #T  b = 1'b0;
     
       
        #T  $finish;
    end
endmodule
