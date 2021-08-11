`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2021 04:06:27 PM
// Design Name: 
// Module Name: morse_decoder
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


module morse_decoder(
    input clk, reset_n,    
    input b,
    output dot,dash
      );
  
    wire fiftyms;
     timer_parameter #(.FINAL_VALUE(4_999_999)) tp1 //50 ms
    ( 
        .clk(clk),
        .reset_n(reset_n),
        .enable(b), //always enable
        .done(fiftyms) //50 ms timer
        );
     wire counter_out;
    udl_counter udl1 //sync with the 50 ms timer
    (
        .clk(clk),
        .reset_n(b),
        .enable(fiftyms),
        .up(1'b1),
        .Q(counter_out)

    );

 
    morse_simple_fsm msfsm(
        .clk(clk), //if this isnt right, i guess put it back to clk
         .reset_n(reset_n),      
        .b(counter_out),
     
        .dot_out(dot),
        .dash_out(dash)       
    );
   
endmodule
