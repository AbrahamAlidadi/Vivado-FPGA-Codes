`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2021 02:07:02 PM
// Design Name: 
// Module Name: morse_code_application
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


module morse_code_application(
    input clk, b, reset_n,
    output [6:0] SSEG,
    output [7:0] AN,
    output DP_ctrl_output

    );
    wire xor_gate, dot,dash;
    wire [4:0] shift_out;
    wire [3:0] bcd_output;
    wire [2:0] count_out;
      button bbutton(
        .clk(clk),
        .reset_n(reset_n),
        .noisy(b),
        .p_edge(b_db)
    );
    
     morse_decoder  md1(
    .clk(clk), //might be this one? change to fiftyms?
    .reset_n(reset_n),    
    .b(b), 
    .dot(dot),
    .dash(dash)
      );
      
      assign xor_gate = dot ^ dash;
        
        udl_counter #(.BITS(3)) udl2 ( 
        .clk(clk),
        .reset_n(reset_n),
        .enable(xor_gate),
        .load(count_out==5),
        .D(3'b000),
        .up(1'b1), //only go up             
        .Q(count_out)
        
    );
      univ_shift_reg #(.N(5)) usr1 (
        .clk(clk),
        .reset_n(reset_n),
        .LSB_in(dash),
        .s({xor_gate, 1'b0}),
        .Q(shift_out)
    );

       bin2bcd b2d1(
        .bin(count_out),
        .bcd(bcd_output) 
    );
       sseg_driver ssegD1(
            .clk(clk),            
            .I0({1'b1,bcd_output[3:0],1'b0}),
            .I1(6'b0_0000_0),
            .I2(6'b0_0000_0),
            .I3({count_out>4,{3'd0,shift_out[4]},1'b0}),
            .I4({count_out>3,{3'd0,shift_out[3]},1'b0}), //change 1'b1 to a statement???
            .I5({count_out>2,{3'd0,shift_out[2]},1'b0}),
            .I6({count_out>1,{3'd0,shift_out[1]},1'b0}),
            .I7({count_out>0,{3'd0,shift_out[0]},1'b0}),            
            .SSEG(SSEG),
            .AN(AN),
            .DP_ctrl_output(DP_ctrl_output)
    );
     
endmodule
