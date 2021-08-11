`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2021 06:02:13 PM
// Design Name: 
// Module Name: morse2ascii
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


module morse2ascii(
  input clk, b,r, reset_n,
  output empty_led,
    output [6:0] SSEG,
    output [7:0] AN,
    output DP_ctrl_output

    );
    wire dot,dash,lg,wg;
    wire b_db,r_db;
   
    button bb1(
    .clk(clk), 
    .reset_n(reset_n),
    .noisy(b),
    .debounced(b_db)
    );
    
    button bb2(
    .clk(clk), 
    .reset_n(reset_n),
    .noisy(r),
    .p_edge(r_db)
    );
 
    morse_decoder_2 mdd1(
    .clk(clk), 
    .reset_n(reset_n),
    .b(b_db),
    .dot(dot), 
    .dash(dash), 
    .lg(lg), 
    .wg(wg)
    );
    wire xor_gate;
     assign xor_gate = dot ^ dash;
     wire [4:0]symbol;
     
    univ_shift_reg #(.N(5)) usr1 (
        .clk(clk),
        .reset_n(reset_n & ~(lg | wg)),
        .LSB_in(dash),
        .s({xor_gate, 1'b0}),
        .Q(symbol)
    );
    wire [2:0] symbol_count;
     udl_counter #(.BITS(3)) udl1 ( 
        .clk(clk),
        .reset_n(reset_n & ~(lg | wg)),
        .enable(xor_gate),
        .load(symbol_count==5),
        .D(3'b000),
        .up(1'b1), //only go up             
        .Q(symbol_count)
        
    );
    wire [7:0]muxout,data_out;
    
    mux_2x1_nbit  #(.N(8))m2n(
    .w0({symbol_count[2:0],symbol[4:0]}), 
    .w1(8'b1110_0000),
    .s(wg),
    .f(muxout)
    );
    
    synch_rom sr1(
    .clk(clk),
    .addr(muxout),
    .data(data_out)
    );
    
    wire wg_delay;
     D_FF_pos dfn1( 
     .D(wg),
     .clk(clk),
     .Q(wg_delay)
    );
  wire full,empty;
  wire [7:0]dout;
    
  fifo_generator fifog1 (
  .clk(clk),      // input wire clk
  .srst(~reset_n),    // input wire srst
  .din(data_out),      // input wire [7 : 0] din
  .wr_en(~full & (lg|wg|wg_delay)),  // input wire wr_en
  .rd_en(r_db),  // input wire rd_en
  .dout(dout),    // output wire [7 : 0] dout
  .full(full),    // output wire full
  .empty(empty)  // output wire empty
);

  assign empty_led = empty;

  sseg_driver ssegD1(
            .clk(clk),            
            .I0({~empty,dout[7:4],1'b0}),
            .I1({~empty,dout[3:0],1'b0}),    //6'b0_0000_0
            .I2(6'b0_0000_0),
            .I3({symbol_count>4,{3'b0,symbol[4]},1'b0}),
            .I4({symbol_count>3,{3'b0,symbol[3]},1'b0}), 
            .I5({symbol_count>2,{3'b0,symbol[2]},1'b0}),
            .I6({symbol_count>1,{3'b0,symbol[1]},1'b0}),
            .I7({symbol_count>0,{3'b0,symbol[0]},1'b0}),            
            .SSEG(SSEG),
            .AN(AN),
            .DP_ctrl_output(DP_ctrl_output)
    );
    
endmodule
