`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/11 19:59:10
// Design Name: 
// Module Name: test_block_pos
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

module test_block_pos(
    input fall_en,
    input fall_reset,
    input left_en,
    input right_en,
    input down_en,
    input rotate_en,
    input drop_en,
    input [`BITS_X_POS-1:0] ctrl_pos_x,
    input [`BITS_Y_POS-1:0] ctrl_pos_y,
    input [`BITS_ROT-1:0] ctrl_rot,
    output reg [`BITS_X_POS-1:0] test_pos_x,
    output reg [`BITS_Y_POS-1:0] test_pos_y,
    output reg [`BITS_ROT-1:0] test_rot
    );
    
    always @* 
        if (fall_en) 
            begin
            test_pos_x = ctrl_pos_x;
            test_pos_y = ctrl_pos_y + 1; // move down
            test_rot = ctrl_rot;
            end 
        else if (left_en) 
            begin
            test_pos_x = ctrl_pos_x - 1; // move left
            test_pos_y = ctrl_pos_y;
            test_rot = ctrl_rot;
            end 
        else if (right_en) 
            begin
            test_pos_x = ctrl_pos_x + 1; // move right
            test_pos_y = ctrl_pos_y;
            test_rot = ctrl_rot;
            end 
        else if (rotate_en) 
            begin
            test_pos_x = ctrl_pos_x;
            test_pos_y = ctrl_pos_y;
            test_rot = ctrl_rot + 1; // rotate
            end 
        else if (down_en) 
            begin
            test_pos_x = ctrl_pos_x;
            test_pos_y = ctrl_pos_y + 1; // move down
            test_rot = ctrl_rot;
            end 
        else if (drop_en) 
            begin
            // do nothing, we set to drop mode
            test_pos_x = ctrl_pos_x;
            test_pos_y = ctrl_pos_y;
            test_rot = ctrl_rot;
            end 
        else 
            begin
            // do nothing, the block isn't moving this cycle
            test_pos_x = ctrl_pos_x;
            test_pos_y = ctrl_pos_y;
            test_rot = ctrl_rot;
            end
    
endmodule
