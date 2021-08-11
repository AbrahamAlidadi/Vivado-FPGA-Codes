`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2021 12:00:35 PM
// Design Name: 
// Module Name: uart_test
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


module uart_test(
input b,reset_n,clk,
output tx
    );
    wire [2:0] udl_out;
    wire done2;
     
    button bb1(
    .clk(clk), 
    .reset_n(reset_n),
    .noisy(b),
    .debounced(b_db)
    );
    timer_parameter #(.FINAL_VALUE(49_999_999)) TP2 ( //1 ms
        .clk(clk),
        .reset_n(reset_n),
        .enable(1'b1),
        .done(done2)        
        );
        
    udl_counter #(.BITS(3)) udl1 ( 
        .clk(done2),
        .reset_n(reset_n ),
        .enable(b_db),
        .load(udl_out ==5),
        .D(3'b000),
        .up(1'b1), //only go up             
        .Q(udl_out)
        
    );
       wire [7:0]muxout;
   mux_8x1_nbit 
    #(.N(8)) (
    .w0(8'b10000110),//p
    .w1(8'b10101111), //1
    .w2(8'b01100011), //w
    .w3(8'b01000010), //i
    .w4(8'b01000110),//n
    .w5(8'b01100000), //s
    .w6(8'b00000000), //space
    .w7(8'b00000000),
    .s(udl_out), //2:0
    .f(muxout)  //7:0
    );
        

       wire [7:0] data_out;
    synch_rom sr1(
    .clk(clk),
    .addr(muxout),
    .data(data_out)
    );
 wire full;
     uart ut1 
    (
       .clk(clk), 
       .reset_n(reset_n),
               
       .r_data(1'b0),
       .rd_uart(1'b0),
       .rx_empty(1'b0),
       .rx(1'b0),
        
        
        .w_data(data_out),
        .wr_uart(~full & (b_db)),
        .tx_full(full),
        .tx(tx),
        
        // baud rate generator
       .TIMER_FINAL_VALUE(11'd650)
    );  
  
endmodule
