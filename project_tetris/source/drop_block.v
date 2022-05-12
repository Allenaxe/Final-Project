`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/11 22:29:37
// Design Name: 
// Module Name: drop_block
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

module drop_block(
    input clk,
    input rst_n,
    input fall_en,
    input left_en,
    input right_en,
    input down_en,
    input rotate_en,
    input drop_en,
    input [(`BOARD_WIDTH_BLK * `BOARD_HEIGHT_BLK)-1:0] stacked_block,
    input [`BITS_PER_BLOCK-1:0] ctrl_blk,
    input [`BITS_X_POS-1:0] ctrl_pos_x,
    input [`BITS_Y_POS-1:0] ctrl_pos_y,
    input [`BITS_ROT-1:0] ctrl_rot,
    input [`BITS_BLK_SIZE-1:0] ctrl_height,
    output [`BITS_X_POS-1:0] drop_pos_x,
    output [`BITS_Y_POS-1:0] drop_pos_y,
    output [`BITS_ROT-1:0] drop_rot,
    output [`BITS_BLK_POS-1:0] drop_blk_1,
    output [`BITS_BLK_POS-1:0] drop_blk_2,
    output [`BITS_BLK_POS-1:0] drop_blk_3,
    output [`BITS_BLK_POS-1:0] drop_blk_4
    );
    reg [4:0] counter;
    
    wire [`BITS_BLK_SIZE-1:0] drop_width;
    wire [`BITS_BLK_SIZE-1:0] drop_height;
    block_size drop_block(
        .block(ctrl_blk),
        .pos_x(ctrl_pos_x),
        .pos_y(drop_pos_y),
        .rot(ctrl_rot),
        .blk_1(drop_blk_1),
        .blk_2(drop_blk_2),
        .blk_3(drop_blk_3),
        .blk_4(drop_blk_4),
        .width(drop_width),
        .height(drop_height)
    );
    
    wire drop_overlap;
    assign drop_overlap = stacked_block[drop_blk_1 + `BOARD_WIDTH_BLK] || stacked_block[drop_blk_2 + `BOARD_WIDTH_BLK] || 
        stacked_block[drop_blk_3 + `BOARD_WIDTH_BLK] || stacked_block[drop_blk_4 + `BOARD_WIDTH_BLK];
    
    always @(posedge clk or negedge rst_n)
        if(~rst_n) 
            counter <= 0;
        else 
            if (fall_en || left_en || right_en || rotate_en || down_en || drop_en)
                counter <= 0;
            else if (drop_pos_y + drop_height <= `BOARD_HEIGHT_BLK - 1 && !drop_overlap)
                counter <= counter + 1;
            else
                counter <= counter;
    
    assign drop_pos_x = ctrl_pos_x;
    assign drop_pos_y = ctrl_pos_y + counter;
    assign drop_rot = ctrl_rot;
    
endmodule
