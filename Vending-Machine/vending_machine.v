`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2021 11:09:51 PM
// Design Name: 
// Module Name: vending_machine
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


module vending_machine(
    input clk, reset_n,
    input five,ten,twentyfive,buy,   
    output five_led, ten_led,twenty_led,
    output red, green,
    output [6:0] SSEG,
    output [7:0] AN,
    output DP

    );
 
    wire R5,R10,R20,dispense;
    wire f_db, ten_db, twen_db, buy_db;  
    wire [7:0] change_bcd, amount_bcd,change_total, amount_total;
   
    
    button fivecents(
        .clk(clk),
        .reset_n(reset_n),
        .noisy(five),
        .p_edge(f_db)
    );

    button tencents(
        .clk(clk),
        .reset_n(reset_n),
        .noisy(ten),
        .p_edge(t_db)
    );

    button twentycents(
        .clk(clk),
        .reset_n(reset_n),
        .noisy(twentyfive),
        .p_edge(twen_db)
    );

     button item_taken(
        .clk(clk),
        .reset_n(reset_n),
        .noisy(buy),
        .p_edge(buy_db)
    );
  
    
   vending_FSM vfsm(
        .clk(clk),
        .reset_n(reset_n),        
        .five(f_db),
        .ten(t_db),
        .twentyfive(twen_db),
        .item_taken(buy_db),
        .dispense(dispense),
        .R5(R5),
        .R10(R10),
        .R20(R20),
        .Rtotal(change_total),
        .amount(amount_total)
    );
    
//to calculate the amount of coins put into the machine
 /* wire d;
  reg [7:0]amount_total;
  assign d = dispense;//if dispense is true, we dont want it to increment. Dispense holds it, buy clears it
  always @(d)
    begin
      if (f_db && ~d)
       amount_total = amount_total + 8'd5;
       else if (t_db && ~d)                 
       amount_total = amount_total + 8'd10;
       else if (twen_db && ~d)                 
       amount_total = amount_total + 8'd25;
        else if (buy && d)
       amount_total = 8'd0;
       else if (d) 
       amount_total = amount_total -  8'd25;
      
    end 
 
  //creates values for remainders and adds them up
  wire [7:0]change_five,change_ten,change_twenty,change_total;
  assign change_five= R5 ? 8'b00000101 : 8'b00000000;
  assign change_ten= R10 ? 8'b00001111 : 8'b00000000;
  assign change_twenty= R20 ? 8'b00010100 : 8'b00000000;
  assign change_total = change_five + change_ten + change_twenty;
  */
    assign five_led = R5;
    assign ten_led = R10;
    assign twenty_led = R20;
    
 

    bin2bcd b2d1(
        .bin(amount_total),
        .bcd(amount_bcd)
    );
    
   
    bin2bcd b2d2(
        .bin(change_total),
        .bcd(change_bcd)
    );
    sseg_driver  ssd1(
        .clk(clk),          
        .I0({1'b1,change_bcd[7:4],1'b0}),
        .I1({1'b1,change_bcd[3:0],1'b0}),
        .I2({6'b000000}),
        .I3(6'b000000),
        .I4(6'b000000),       
        .I5(6'b000000),
        .I6({1'b1,amount_bcd[7:4],1'b0}),
        .I7({1'b1,amount_bcd[3:0],1'b0}),
        .SSEG(SSEG),
        .AN(AN),
        .DP_ctrl_output(DP)
    );
    
     rgb_driver #(.R(0)) rgbd1 (
        .clk(clk),
        .reset_n(reset_n),
        .red_duty(~dispense), 
        .green_duty(dispense),
        .red_LED(red), 
        .green_LED(green)
    );

   
   endmodule
