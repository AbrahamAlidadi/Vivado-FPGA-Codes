`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2021 08:05:05 PM
// Design Name: 
// Module Name: Final_Code
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


module Final_Code
(
     input clk,
    input reset_n,p1,p2,mid,
    output blue1,blue2,red1,red2,green1,green2,
    output [6:0] SSEG,
    output [7:0] AN
      
    );

   wire [7:0] lfsrout,lfsrout2;
    wire [7:0] out;
    wire [11:0] bcd,bcd2;
    wire [3:0] bcd3,bcd4;
    wire [7:0] udlout1,udlout2;    
     wire start,p2input,idle,p1winsround,p2winsround,p1winsgame,p2winsgame,clearstate;

 
   wire p1_db,p2_db, mid_db;
   
   button p1b( //player 1 button
    .clk(clk), 
    .reset_n(reset_n),
    .noisy(p1),
    .debounced(p1_db)
    );
    
  button p2b( //player 2 button
    .clk(clk), 
    .reset_n(reset_n),
    .noisy(p2),
    .debounced(p2_db)
    );
    
     button midb(  //middle button
    .clk(clk), 
    .reset_n(reset_n),
    .noisy(mid),
    .debounced(mid_db)
    );
    
    wire p1_control,p2_control, start_control, p2input_control;
    
     T_FF p1toggle(  //flipflop to hold control over the lfsr
    .clk(clk),
    .T(start),//based on state in state diagram
    .reset_n(reset_n),
    .Q(start_control)
    );
     
     T_FF p2toggle( //flipflop to hold control over the lfsr
    .clk(clk),
    .T(p2input), //based on state in state diagram
    .reset_n(reset_n),
    .Q(p2input_control)
    );
    
      wire timer1,timer2;
timer_parameter #(.FINAL_VALUE(19_999_999)) TP1 ( //500 ms for lfsr1
        .clk(clk),
        .reset_n(reset_n),
        .enable(1'b1),
        .done(timer1)       
        );

 timer_parameter #(.FINAL_VALUE(19_999_999)) TP2 ( //200 ms for lfsr2
        .clk(clk),
        .reset_n(reset_n),
        .enable(1'b1),
        .done(timer2)        
        );
        
   lfsr #(.N(8)) lfsr1( //player2
    .clk(timer1),
    .enable(p2input_control ),
    .reset_n(reset_n ),
    .Q(lfsrout2) 
    );
    
     lfsr #(.N(8)) lfsr2( //player1
    .clk(timer2),
    .enable(start_control ),
    .reset_n(reset_n),
    .Q(lfsrout) 
    );
 
     wire [1:0]pointcount1, pointcount2;//counts the player score
    
     udl_counter #(.BITS(2)) udl1 ( //counter for counting p1 points
        .clk(clk),
        .reset_n(reset_n | idle ), // reset when you get to idle state
        .enable(p1winsround),
        .load(),
        .D(2'b000),
        .up(1'b1), //only go up             
        .Q(pointcount1)
        
    );
      udl_counter #(.BITS(2)) udl2 ( //counter for counting p2 points
        .clk(clk),
        .reset_n(reset_n | idle ),// reset when you get to idle state
        .enable(p2winsround),
        .load(),
        .D(2'b000),
        .up(1'b1), //only go up             
        .Q(pointcount2)
        
    );
    
    game_fsm  fgsm(
    .clk(clk),
    .reset_n(reset_n),
    .p1(p1_db),
    .mid(mid_db),
    .p2(p2_db),
    .p1number(lfsrout2),
    .p2number(lfsrout),
    .p1count(pointcount1),
    .p2count(pointcount2),
    .start(start),
    .idle(idle),
    .p2input(p2input),
    .p1winsround(p1winsround),
    .p2winsround(p2winsround),
    .p1winsgame(p1winsgame),
    .p2winsgame(p2winsgame),
    .clearstate(clearstate)
 
    );
 
    bin2bcd_eddin #(.W(33)) bcd_0 ( //for LFSR 1
    .bin(lfsrout2),
    .bcd(bcd)
    );
    
    bin2bcd_eddin #(.W(33)) bcd_1 ( //for LFSR 2
    .bin(lfsrout),
    .bcd(bcd2)
    );
  bin2bcd_eddin #(.W(33)) bcd_pt1 (
    .bin(pointcount1),
    .bcd(bcd3)
    );
  bin2bcd_eddin #(.W(33)) bcd_pt2 (
    .bin(pointcount2),
    .bcd(bcd4)
    );

    sseg_driver driver (
    .clk(clk),
    .I0({1'b1, bcd3[3:0], 1'b1}), 
    .I1({1'b1, bcd[11:8], 1'b1}), 
    .I2({1'b1, bcd[7:4], 1'b1}), 
    .I3({1'b1, bcd[3:0], 1'b1}),
    .I4({1'b1, bcd4[3:0], 1'b1}),
    .I5({1'b1, bcd2[11:8], 1'b1}),
    .I6({1'b1, bcd2[7:4], 1'b1}), 
    .I7({1'b1, bcd2[3:0], 1'b1}), 
    .SSEG(SSEG),
    .AN(AN),
    .DP_ctrl_output(~DP_ctrl_output)
); 

wire udl_out3, udl_out4,tmr3out;
  rgb_driver #(.R(0)) rgbd1 ( //For player 1  - green and red lights
        .clk(clk),
        .reset_n(reset_n),
        .red_duty(~start  & ~p1winsgame & ~p2winsgame & ~idle & ~clearstate ), 
        .green_duty(start ),
        .red_LED(red1), 
        .green_LED(green1)
       
    );
    
    rgb_driver #(.R(0)) rgbd2 ( //For player 2 - green and red lights
        .clk(clk),
        .reset_n(reset_n),
        .red_duty(~p2input & ~p2winsgame & ~p1winsgame & ~idle & ~clearstate ), 
        .green_duty(p2input),
        .red_LED(red2), 
        .green_LED(green2)
    );
    
    wire udlblue1,udlblue2,timer3,timer4;
timer_parameter #(.FINAL_VALUE(29_999)) rgb (//500ms/10ns - 1 = 49_999_999
        .clk(clk),
        .reset_n(reset_n),
        .enable(1'b1),
        .done(tmr3out)
       );
 
    udl_counter #(.BITS(8)) bluecount1(
        .clk(tmr3out),
        .reset_n(reset_n ),
        .enable(p1winsgame), //fsm will control
        .up(1'b1),
        .load(),
        .D(2'b000),
        .Q(udl_out3)
);
 udl_counter #(.BITS(8)) bluecount2(
        .clk(tmr3out),
        .reset_n(reset_n),
        .enable(p2winsgame), //fsm will control
        .up(1'b1),
        .load(),
        .D(2'b000),
        .Q(udl_out4)
);
     rgb_driver #(.R(8)) rgbd3 ( //player 1
        .clk(clk),
        .reset_n(reset_n),
        .blue_duty(udl_out3),
        .blue_LED(blue1)
    ); 
     rgb_driver #(.R(8)) rgbd4 ( //play2
        .clk(clk),
        .reset_n(reset_n),
        .blue_duty(udl_out4),
        .blue_LED(blue2)
    );
       wire [3:0] udlsync1, udlsync2;
        
    udl_counter #(.BITS(4)) udltp ( 
        .clk(clk),
        .reset_n(reset_n),
        .enable((p2winsgame) & udlsync1 <9),
        .load(),
        .D(3'b000),
        .up(1'b1), //only go up             
        .Q(udlsync1)
        
    );
       udl_counter #(.BITS(4)) udltp2 ( 
        .clk(clk),
        .reset_n(reset_n),
        .enable((p1winsgame ) & udlsync2 <9),
        .load(),
        .D(3'b000),
        .up(1'b1), //only go up             
        .Q(udlsync2)
        
    );

endmodule

