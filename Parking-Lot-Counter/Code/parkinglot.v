`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2021 06:20:12 PM
// Design Name: 
// Module Name: parkinglot
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


module parkinglot(
    input clk, reset,
    input a, b,
    output a_led, b_led,
    //output car_enter, car_exit,
    output [6:0] SSEG,
    output [7:0] AN,
    output DP_ctrl_output

    );
    assign a_led= a_db;
    assign b_led= b_db;
    
    wire a_db, b_db; // A and B debounce  
    wire [7:0] Q;
    wire car_enter, car_exit;
    wire [11:0] bcd_output;

    debouncer_delayed dd1a(
        .clk(clk),
        .reset_n(reset),
        .noisy(a),
        .debounced(a_db)
    );

    debouncer_delayed dd1b(
        .clk(clk),
        .reset_n(reset),
        .noisy(b),
        .debounced(b_db)
    );

    car_FSM  cfsm(
        .clk(clk),
        .reset_n(reset),
        .a(a_db), 
        .b(b_db),
        .enter(car_enter),
        .exit(car_exit)
    );
   udl_counter#(.BITS(8)) count1 (
        .clk(clk),
        .reset_n(reset),
        .enable(car_enter | car_exit),
        .up(car_enter),
        .Q(Q)
    );

    bin2bcd b2d(
        .bin(Q),
        .bcd(bcd_output)
    );

    sseg_driver  ssd1(
        .clk(clk),
        .reset_n(reset),   
        .I0({1'b1,bcd_output[11:8],1'b0}),
        .I1({1'b1,bcd_output[7:4],1'b0}),
        .I2({1'b1,bcd_output[3:0],1'b0}),
        .I3(6'b0_0000_0),
        .I4(6'b0_0000_0),
        .I5(6'b0_0000_0),
        .I6(6'b0_0000_0),
        .I7(6'b0_0000_0),
        .SSEG(SSEG),
        .AN(AN),
        .DP_ctrl_output(DP_ctrl_output)
    );
   
endmodule
