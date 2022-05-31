`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/21 18:05:29
// Design Name: 
// Module Name: volume_ctl
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


module volume_ctl(
    input clk,
    input rst_n,
    input up,
    input down,
    output reg [15:0] volume_max,
    output [15:0] volume_min,
    output reg [3:0] volume
    );
    reg [3:0] volume_next;
    
    always@*
        if (up)
            if (volume == 4'd15)
                volume_next = volume;
            else
                volume_next = volume + 4'd1;
        else if (down)
            if (volume == 4'd0)
                volume_next = volume;
            else
                volume_next = volume - 4'd1;  
        else
            volume_next = volume;  
    
    always@(posedge clk or negedge rst_n)
        if (~rst_n)
            volume <= 4'd4;
        else
            volume <= volume_next;   
    
    always@(volume)
        if(volume == 4'd0)begin
            volume_max = 16'h0000;
            volume_min = 16'h0000;
        end else if(volume == 4'd1)begin
            volume_max = 16'h11FF;
            volume_min = 16'hFF00;
        end else if(volume == 4'd2)begin
            volume_max = 16'h12FF;
            volume_min = 16'hFE00;
        end else if(volume == 4'd3)begin
            volume_max = 16'h13FF;
            volume_min = 16'hFD00;
        end else if(volume == 4'd4)begin
            volume_max = 16'h14FF;
            volume_min = 16'hFC00;
        end else if(volume == 4'd5)begin
            volume_max = 16'h15FF;
            volume_min = 16'hFB00;
        end else if(volume == 4'd6)begin
            volume_max = 16'h16FF;
            volume_min = 16'hFA00;
        end else if(volume == 4'd7)begin
            volume_max = 16'h15FF;
            volume_min = 16'hFB00;
        end else if(volume == 4'd8)begin
            volume_max = 16'h1FFF;
            volume_min = 16'hF000;
        end else if(volume == 4'd9)begin
            volume_max = 16'h2FFF;
            volume_min = 16'hE000;
        end else if(volume == 4'd10)begin
            volume_max = 16'h3FFF;
            volume_min = 16'hD000;
        end else if(volume == 4'd11)begin
            volume_max = 16'h4FFF;
            volume_min = 16'hC000;
        end else if(volume == 4'd12)begin
            volume_max = 16'h5000;
            volume_min = 16'hB000;
        end else if(volume == 4'd13)begin
            volume_max = 16'h6000;
            volume_min = 16'hA000;
        end else if(volume == 4'd14)begin
            volume_max = 16'h7000;
            volume_min = 16'h9000;
        end else if(volume == 4'd15)begin
            volume_max = 16'h7200;
            volume_min = 16'h9E00;
        end else begin
            volume_max = 16'h0000;
            volume_min = 16'h0000;
        end
    
endmodule