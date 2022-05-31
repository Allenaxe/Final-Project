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
            volume <= 4'd0;
        else
            volume <= volume_next;   
    
    always@*
        case(volume)
            4'd0: volume_max = 16'h0000;
            4'd1: volume_max = 16'h0999;
            4'd2: volume_max = 16'h0fff;
            4'd3: volume_max = 16'h1999;
            4'd4: volume_max = 16'h1fff;
            4'd5: volume_max = 16'h2999;
            4'd6: volume_max = 16'h2fff;
            4'd7: volume_max = 16'h3999;
            4'd8: volume_max = 16'h3fff;
            4'd9: volume_max = 16'h4999;
            4'd10: volume_max = 16'h4fff;
            4'd11: volume_max = 16'h5999;
            4'd12: volume_max = 16'h5fff;
            4'd13: volume_max = 16'h6999;
            4'd14: volume_max = 16'h6fff;
            4'd15: volume_max = 16'h7999;
            default:volume_max = 16'h0000;
        endcase
    
    assign volume_min = 16'h0000 - volume_max;
    
endmodule
