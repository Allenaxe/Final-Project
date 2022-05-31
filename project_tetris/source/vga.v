`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/11 00:00:19
// Design Name: 
// Module Name: vga
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

module vga(
    input clk,
    input [`BITS_PER_BLOCK-1:0] ctrl_blk,
    input [`BITS_BLK_POS-1:0] ctrl_blk_1,
    input [`BITS_BLK_POS-1:0] ctrl_blk_2,
    input [`BITS_BLK_POS-1:0] ctrl_blk_3,
    input [`BITS_BLK_POS-1:0] ctrl_blk_4,
    input [`BITS_BLK_POS-1:0] drop_blk_1,
    input [`BITS_BLK_POS-1:0] drop_blk_2,
    input [`BITS_BLK_POS-1:0] drop_blk_3,
    input [`BITS_BLK_POS-1:0] drop_blk_4,
    input [(`BOARD_WIDTH_BLK * `BOARD_HEIGHT_BLK)-1:0] stacked_block,
    output reg [3:0] red,
    output reg [3:0] green,
    output reg [3:0] blue,
    output hsync,
    output vsync
    );
    reg [9:0] counter_x;
    reg [9:0] counter_y;
    
    initial
        begin
        counter_x = 0;
        counter_y = 0;
        end
    
    assign hsync = ~(counter_x >= (`SCREEN_WIDTH_PIXEL + `HSYNC_FRONT_PORCH) &&
        counter_x < (`SCREEN_WIDTH_PIXEL + `HSYNC_FRONT_PORCH + `HSYNC_PULSE_WIDTH));
    assign vsync = ~(counter_y >= (`SCREEN_HEIGHT_PIXEL + `VSYNC_FRONT_PORCH) &&
        counter_y < (`SCREEN_HEIGHT_PIXEL + `VSYNC_FRONT_PORCH + `VSYNC_PULSE_WIDTH));
    
    wire [9:0] ctrl_blk_index;
    assign ctrl_blk_index = ((counter_x - `BOARD_X_START_PIXEL) / `BLOCK_SIZE_PIXEL) 
        + (((counter_y - `BOARD_Y_START_PIXEL) / `BLOCK_SIZE_PIXEL) * `BOARD_WIDTH_BLK);
    
    always @* 
        begin
        if (counter_x >= `BOARD_X_START_PIXEL && counter_y >= `BOARD_Y_START_PIXEL &&
            counter_x <= `BOARD_X_START_PIXEL + `BOARD_WIDTH_PIXEL && counter_y <= `BOARD_Y_START_PIXEL + `BOARD_HEIGHT_PIXEL) 
            if (counter_x == `BOARD_X_START_PIXEL || counter_x == `BOARD_X_START_PIXEL + `BOARD_WIDTH_PIXEL ||
                counter_y == `BOARD_Y_START_PIXEL || counter_y == `BOARD_Y_START_PIXEL + `BOARD_HEIGHT_PIXEL)
                // We're at the edge of the board, paint it white
                {red, green, blue} = `WHITE;
            else
                if (ctrl_blk_index == ctrl_blk_1 || ctrl_blk_index == ctrl_blk_2 ||
                    ctrl_blk_index == ctrl_blk_3 || ctrl_blk_index == ctrl_blk_4)
                    case (ctrl_blk)
                        `BLOCK_EMPTY: {red, green, blue} = `GRAY;
                        `BLOCK_I: {red, green, blue} = `CYAN;
                        `BLOCK_O: {red, green, blue} = `YELLOW;
                        `BLOCK_T: {red, green, blue} = `MAGENTA;
                        `BLOCK_S: {red, green, blue} = `GREEN;
                        `BLOCK_Z: {red, green, blue} = `RED;
                        `BLOCK_J: {red, green, blue} = `BLUE;
                        `BLOCK_L: {red, green, blue} = `ORANGE;
                    endcase
                else if (ctrl_blk_index == drop_blk_1 || ctrl_blk_index == drop_blk_2 ||
                    ctrl_blk_index == drop_blk_3 || ctrl_blk_index == drop_blk_4)
                    {red, green, blue} = `BLACK;
                else
                    {red, green, blue} = stacked_block[ctrl_blk_index] ? `WHITE : `GRAY;
        else 
            // Outside the board
            {red, green, blue} = `BLACK;
        end
    
    always @(posedge clk)
        if (counter_x >= `SCREEN_WIDTH_PIXEL + `HSYNC_FRONT_PORCH + `HSYNC_PULSE_WIDTH + `HSYNC_BACK_PORCH) 
            begin
            counter_x <= 0;
            if (counter_y >= `SCREEN_HEIGHT_PIXEL + `VSYNC_FRONT_PORCH + `VSYNC_PULSE_WIDTH + `VSYNC_BACK_PORCH)
               counter_y <= 0;
            else
               counter_y <= counter_y + 1;
            end 
        else 
            begin
            counter_x <= counter_x + 1;
            counter_y <= counter_y;
            end
    
endmodule
