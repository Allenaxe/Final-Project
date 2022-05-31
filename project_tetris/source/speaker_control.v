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
module speaker_control(audio_mclk, audio_lrck, audio_sck, audio_sdin, audio_left, audio_right, rst_n, clk);
output audio_mclk;
output audio_lrck;
output audio_sck;
output reg audio_sdin;
input rst_n;
input clk;
input [15:0] audio_left;
input [15:0] audio_right;

reg  [8:0] q;
    reg [8:0] q_next;
    reg [15:0] audio_left_saved;
    reg [15:0] audio_right_saved;
    reg [4:0] cnt;
    reg [4:0] cnt_next;
    reg audio_sdin_next;
    
    always @*
        q_next = q + 9'd1;
    
    always @(posedge clk or negedge rst_n)
        if(~rst_n) 
            q <= 9'd0;
        else 
            q <= q_next;
            
    assign audio_mclk = q[1];
    assign audio_lrck = q[8];
    assign audio_sck = q[3];
    
    always @(negedge audio_lrck or negedge rst_n)
        if(~rst_n) 
            begin
            audio_left_saved <= 16'd0;
            audio_right_saved <= 16'd0;
            end
        else 
            begin
            audio_left_saved <= audio_left;
            audio_right_saved <= audio_right;
            end
    
    always @*
        cnt_next = cnt + 5'd1;
    
    always @(negedge audio_sck or negedge rst_n)
        if(~rst_n) 
            cnt <= 5'd0;
        else 
            cnt <= cnt_next;
            
    always@* 
        case(cnt)
            5'd0: audio_sdin_next = audio_left_saved[15];
            5'd1: audio_sdin_next = audio_left_saved[14];
            5'd2: audio_sdin_next = audio_left_saved[13];
            5'd3: audio_sdin_next = audio_left_saved[12];
            5'd4: audio_sdin_next = audio_left_saved[11];
            5'd5: audio_sdin_next = audio_left_saved[10];
            5'd6: audio_sdin_next = audio_left_saved[9];
            5'd7: audio_sdin_next = audio_left_saved[8];
            5'd8: audio_sdin_next = audio_left_saved[7];
            5'd9: audio_sdin_next = audio_left_saved[6];
            5'd10: audio_sdin_next = audio_left_saved[5];
            5'd11: audio_sdin_next = audio_left_saved[4];
            5'd12: audio_sdin_next = audio_left_saved[3];
            5'd13: audio_sdin_next = audio_left_saved[2];
            5'd14: audio_sdin_next = audio_left_saved[1];
            5'd15: audio_sdin_next = audio_left_saved[0];
            5'd16: audio_sdin_next = audio_right_saved[15];
            5'd17: audio_sdin_next = audio_right_saved[14];
            5'd18: audio_sdin_next = audio_right_saved[13];
            5'd19: audio_sdin_next = audio_right_saved[12];
            5'd20: audio_sdin_next = audio_right_saved[11];
            5'd21: audio_sdin_next = audio_right_saved[10];
            5'd22: audio_sdin_next = audio_right_saved[9];
            5'd23: audio_sdin_next = audio_right_saved[8];
            5'd24: audio_sdin_next = audio_right_saved[7];
            5'd25: audio_sdin_next = audio_right_saved[6];
            5'd26: audio_sdin_next = audio_right_saved[5];
            5'd27: audio_sdin_next = audio_right_saved[4];
            5'd28: audio_sdin_next = audio_right_saved[3];
            5'd29: audio_sdin_next = audio_right_saved[2];
            5'd30: audio_sdin_next = audio_right_saved[1];
            5'd31: audio_sdin_next = audio_right_saved[0];
            default: audio_sdin_next = 1'b0;
        endcase
    
    always @(negedge audio_sck or negedge rst_n)
        if(~rst_n) 
            audio_sdin <= 1'd0;
        else 
            audio_sdin <= audio_sdin_next;
    
    
endmodule

