`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/10 17:50:06
// Design Name: 
// Module Name: keyboard
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

module keyboard(
    input clk,
    input rst_n,
    inout PS2_DATA,
    inout PS2_CLK,
    output left_btn,
    output right_btn,
    output down_btn,
    output rotate_btn,
    output drop_btn
    );
    
    wire [511:0] key_down;
    wire [8:0] last_change;
    wire key_valid;
    KeyboardDecoder decoder(
        .clk(clk),
        .rst(~rst_n),
        .key_down(key_down),
        .last_change(last_change),
        .key_valid(key_valid),
        .PS2_CLK(PS2_CLK),
        .PS2_DATA(PS2_DATA)
    );
    
    always @*
        if (key_valid)
            begin
            if (key_down[`KEY_UP]) 
                rotate_btn = 1'b1;
            else 
                rotate_btn = 1'b0;
            if (key_down[`KEY_DOWN])
                down_btn = 1'b1;
            else
                down_btn = 1'b0;
            if (key_down[`KEY_LEFT])
                left_btn = 1'b1;
            else
                left_btn = 1'b0;
            if (key_down[`KEY_RIGHT])
                right_btn = 1'b1;
            else
                right_btn = 1'b0;
            if (key_down[`KEY_SPACE])
                drop_btn = 1'b1;
            else
                drop_btn = 1'b0;
            end
        else
            begin
            down_btn = 1'b0;
            left_btn = 1'b0;
            right_btn = 1'b0;
            rotate_btn = 1'b0;
            drop_btn = 1'b0;
            end
    
endmodule
