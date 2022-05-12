`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/21 01:13:13
// Design Name: 
// Module Name: speaker_control
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

`include "global.vh"
module speaker_control(audio_mclk, audio_lrck, audio_sck, audio_sdin, audio_in_left, audio_in_right, rst_n, clk);
output reg audio_mclk;
output reg audio_lrck;
output reg audio_sck;
output wire audio_sdin;
input rst_n;
input clk;
input [15:0] audio_in_left;
input [15:0] audio_in_right;

reg [`DIV_BY_TWO_BIT_WIDTH-1:0] count_2, count_2_next;
reg audio_mclk_next;
reg [`DIV_BY_FOUR_BIT_WIDTH-1:0] count_4, count_4_next;
reg audio_sck_next;
reg [`DIV_BY_128_BIT_WIDTH-1:0] count_128, count_128_next;
reg audio_lrck_next;
reg [31:0] shifter;
reg [31:0] shifter_temp;
reg [5:0] counter;
reg [5:0] counter_temp;

// *******************
// Clock divider for 25M Hz
// *******************
// Clock Divider: Counter operation

always @*
  if (count_2 == `DIV_BY_TWO-1)
  begin
    count_2_next = `DIV_BY_TWO_BIT_WIDTH'd0;
    audio_mclk_next = ~audio_mclk;
  end
  else
  begin
    count_2_next = count_2 + 1'b1;
    audio_mclk_next = audio_mclk;
  end

// Counter flip-flops
always @(posedge clk or negedge rst_n)
  if (~rst_n)
  begin
    count_2 <=`DIV_BY_TWO_BIT_WIDTH'b0;
    audio_mclk <= 1'b0;
  end
  else
  begin
    count_2 <= count_2_next;
    audio_mclk <= audio_mclk_next;
  end
  
// *********************
// Clock divider for 25/128M Hz
// *********************
// Clock Divider: Counter operation 
always @*
  if (count_128 == `DIV_BY_128 - 1'b1)
  begin
    count_128_next = `DIV_BY_128_BIT_WIDTH'd0;
    audio_lrck_next = ~audio_lrck;
  end
  else
  begin
    count_128_next = count_128 + 1'b1;
    audio_lrck_next = audio_lrck;
  end


// Counter flip-flops
always @(posedge audio_mclk or negedge rst_n)
  if (~rst_n)
  begin
    count_128 <=`DIV_BY_128_BIT_WIDTH'b0;
    audio_lrck <=1'b0;
  end
  else
  begin
    count_128 <= count_128_next;
    audio_lrck <= audio_lrck_next;
  end

// *********************
// Clock divider for 6.25 Hz
// *********************
// Clock Divider: Counter operation 
always @*
  if (count_4 == `DIV_BY_FOUR-1)
  begin
    count_4_next = `DIV_BY_FOUR_BIT_WIDTH'd0;
    audio_sck_next = ~audio_sck;
  end
  else
  begin
    count_4_next = count_4 + 1'b1;
    audio_sck_next = audio_sck;
  end


// Counter flip-flops
always @(posedge audio_mclk or negedge rst_n)
  if (~rst_n)
  begin
    count_4 <=`DIV_BY_FOUR_BIT_WIDTH'b0;
    audio_sck <=1'b0;
  end
  else
  begin
    count_4 <= count_4_next;
    audio_sck <= audio_sck_next;
  end

always@(posedge audio_sck or negedge rst_n)
    if(~rst_n)
       counter <= 6'b011110;
    else
       counter <= counter_temp; 

always@(counter)
    if(counter == 6'b011111)
       begin
       counter_temp = 6'b0;
       shifter_temp = {audio_in_left, audio_in_right};
       end
    else
       begin
       counter_temp = counter + 1'b1;
       shifter_temp = shifter;
       end

always@(posedge audio_sck or negedge rst_n)
    if(~rst_n)
       shifter <= 31'h0;
    else
       shifter <= {shifter_temp[30:0], 1'h0}; 
       
assign audio_sdin = shifter[31];

endmodule
