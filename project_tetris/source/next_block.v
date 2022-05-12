`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/11 20:54:39
// Design Name: 
// Module Name: next_block
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

module next_block(
    input fall_en,
    input left_en,
    input right_en,
    input down_en,
    input rotate_en,
    input drop_en,
    input [(`BOARD_WIDTH_BLK * `BOARD_HEIGHT_BLK)-1:0] stacked_block,
    input [`BITS_PER_BLOCK-1:0] random_blk,
    input [`BITS_PER_BLOCK-1:0] ctrl_blk,
    input [`BITS_X_POS-1:0] ctrl_pos_x,
    input [`BITS_Y_POS-1:0] ctrl_pos_y,
    input [`BITS_ROT-1:0] ctrl_rot,
    input [`BITS_BLK_POS-1:0] ctrl_blk_1,
    input [`BITS_BLK_POS-1:0] ctrl_blk_2,
    input [`BITS_BLK_POS-1:0] ctrl_blk_3,
    input [`BITS_BLK_POS-1:0] ctrl_blk_4,
    input [`BITS_BLK_POS-1:0] drop_blk_1,
    input [`BITS_BLK_POS-1:0] drop_blk_2,
    input [`BITS_BLK_POS-1:0] drop_blk_3,
    input [`BITS_BLK_POS-1:0] drop_blk_4,
    output reg [(`BOARD_WIDTH_BLK * `BOARD_HEIGHT_BLK)-1:0] stacked_block_next,
    output reg [`BITS_PER_BLOCK-1:0] next_blk,
    output reg [`BITS_X_POS-1:0] next_pos_x,
    output reg [`BITS_Y_POS-1:0] next_pos_y,
    output reg [`BITS_ROT-1:0] next_rot,
    output reg fall_reset
    );
    
    wire [`BITS_X_POS-1:0] test_pos_x;
    wire [`BITS_Y_POS-1:0] test_pos_y;
    wire [`BITS_ROT-1:0] test_rot;
    // Combinational logic to determine what position/rotation we are testing.
    // This has been hoisted out into a module so that the code is shorter.
    test_block_pos test_block_pos (
        .fall_en(fall_en),
        .left_en(left_en),
        .right_en(right_en),
        .rotate_en(rotate_en),
        .down_en(down_en),
        .drop_en(drop_en),
        .ctrl_pos_x(ctrl_pos_x),
        .ctrl_pos_y(ctrl_pos_y),
        .ctrl_rot(ctrl_rot),
        .test_pos_x(test_pos_x),
        .test_pos_y(test_pos_y),
        .test_rot(test_rot)
    );
    
    wire [`BITS_BLK_POS-1:0] test_blk_1;
    wire [`BITS_BLK_POS-1:0] test_blk_2;
    wire [`BITS_BLK_POS-1:0] test_blk_3;
    wire [`BITS_BLK_POS-1:0] test_blk_4;
    wire [`BITS_BLK_SIZE-1:0] test_width;
    wire [`BITS_BLK_SIZE-1:0] test_height;
    
    block_size test_block(
        .block(ctrl_blk),
        .pos_x(test_pos_x),
        .pos_y(test_pos_y),
        .rot(test_rot),
        .blk_1(test_blk_1),
        .blk_2(test_blk_2),
        .blk_3(test_blk_3),
        .blk_4(test_blk_4),
        .width(test_width),
        .height(test_height)
    );

    // checks whether test block positions intersect
    // with any fallen pieces.
    wire test_overlap;
    assign test_overlap = stacked_block[test_blk_1] || stacked_block[test_blk_2] || 
        stacked_block[test_blk_3] || stacked_block[test_blk_4];
   
    always @*
        begin
        stacked_block_next = stacked_block;
        if (fall_en || down_en)
            if (test_pos_y + test_height - 1 < `BOARD_HEIGHT_BLK && !test_overlap) 
                // move down
                begin
                next_blk = ctrl_blk;
                next_pos_x = test_pos_x;
                next_pos_y = test_pos_y;
                next_rot = test_rot;
                fall_reset = 0;
                end 
            else 
                begin
                // add to stacked blocks
                stacked_block_next[ctrl_blk_1] = 1;
                stacked_block_next[ctrl_blk_2] = 1;
                stacked_block_next[ctrl_blk_3] = 1;
                stacked_block_next[ctrl_blk_4] = 1;
                // get a new block
                next_blk = random_blk;
                next_pos_x = (`BOARD_WIDTH_BLK / 2) - 1;
                next_pos_y = 0;
                next_rot = 0;
                // reset the game timer so the user has a full
                // cycle before the block falls
                fall_reset = 1;
                end
        else if (left_en)
            if (ctrl_pos_x > 0 && !test_overlap) 
                // move left
                begin
                next_blk = ctrl_blk;
                next_pos_x = test_pos_x;
                next_pos_y = test_pos_y;
                next_rot = test_rot;
                fall_reset = 0;
                end 
            else 
                begin
                // do nothing
                next_blk = ctrl_blk;
                next_pos_x = ctrl_pos_x;
                next_pos_y = ctrl_pos_y;
                next_rot = ctrl_rot;
                fall_reset = 0;
                end
        else if (right_en)
            if (test_pos_x + test_width - 1 < `BOARD_WIDTH_BLK && !test_overlap) 
                // move right
                begin
                next_blk = ctrl_blk;
                next_pos_x = test_pos_x;
                next_pos_y = test_pos_y;
                next_rot = test_rot;
                fall_reset = 0;
                end 
            else 
                begin
                // do nothing
                next_blk = ctrl_blk;
                next_pos_x = ctrl_pos_x;
                next_pos_y = ctrl_pos_y;
                next_rot = ctrl_rot;
                fall_reset = 0;
                end
        else if (rotate_en)
            if ((test_pos_x + test_width - 1 < `BOARD_WIDTH_BLK)  && 
                (test_pos_y + test_height - 1 < `BOARD_HEIGHT_BLK) && !test_overlap) 
                // rotate
                begin
                next_blk = ctrl_blk;
                next_pos_x = test_pos_x;
                next_pos_y = test_pos_y;
                next_rot = test_rot;
                fall_reset = 0;
                end 
            else 
                begin
                // do nothing
                next_blk = ctrl_blk;
                next_pos_x = ctrl_pos_x;
                next_pos_y = ctrl_pos_y;
                next_rot = ctrl_rot;
                fall_reset = 0;
                end
        else if (drop_en)
            begin
            // add to stacked blocks
            stacked_block_next[drop_blk_1] = 1;
            stacked_block_next[drop_blk_2] = 1;
            stacked_block_next[drop_blk_3] = 1;
            stacked_block_next[drop_blk_4] = 1;
            // get a new block
            next_blk = random_blk;
            next_pos_x = (`BOARD_WIDTH_BLK / 2) - 1;
            next_pos_y = 0;
            next_rot = 0;
            // reset the game timer so the user has a full
            // cycle before the block falls
            fall_reset = 1;
            end
        else
            begin
            // do nothing
            next_blk = ctrl_blk;
            next_pos_x = ctrl_pos_x;
            next_pos_y = ctrl_pos_y;
            next_rot = ctrl_rot;
            fall_reset = 0;
            end
        end
    
    
endmodule
