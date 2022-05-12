`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/21 00:05:32
// Design Name: 
// Module Name: note_gen
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


module note_gen( clk, // clock from crystal 
rst_n, // active low reset 
note_div_left, // div for note generation
note_div_right, 
audio_left, // left sound audio 
audio_right, // right sound audio
);

input clk; // clock from crystal
input rst_n; // active low reset
input [21:0] note_div_left; // div for note generation
input [21:0] note_div_right; // div for note generation
output [15:0] audio_left; // left sound audio
output [15:0] audio_right; // right sound audio

// Declare internal signals
reg [21:0] clk_cnt_left_next, clk_cnt_left, clk_cnt_right_next, clk_cnt_right;
reg b_clk_left, b_clk_left_next, b_clk_right, b_clk_right_next; // Note frequency generation

always @(posedge clk or negedge rst_n) 
if (~rst_n) begin 
clk_cnt_left <= 22'd0; 
b_clk_left <= 1'b0; 
end else begin 
clk_cnt_left <= clk_cnt_left_next; 
b_clk_left <= b_clk_left_next; 
end

always @* 
if (clk_cnt_left == note_div_left) begin 
clk_cnt_left_next = 22'd0; 
b_clk_left_next = ~b_clk_left; 
end else begin 
clk_cnt_left_next = clk_cnt_left + 1'b1; 
b_clk_left_next = b_clk_left; 
end

always @(posedge clk or negedge rst_n) 
if (~rst_n) begin 
clk_cnt_right <= 22'd0; 
b_clk_right <= 1'b0; 
end else begin 
clk_cnt_right <= clk_cnt_right_next; 
b_clk_right <= b_clk_right_next; 
end

always @* 
if (clk_cnt_right == note_div_right) begin 
clk_cnt_right_next = 22'd0; 
b_clk_right_next = ~b_clk_right; 
end else begin 
clk_cnt_right_next = clk_cnt_right + 1'b1; 
b_clk_right_next = b_clk_right; 
end 

// Assign the amplitude of the note
assign audio_left = (b_clk_left == 1'b0) ? 16'hB000 : 16'h5FFF;
assign audio_right = (b_clk_right == 1'b0) ? 16'hB000 : 16'h5FFF;

endmodule
