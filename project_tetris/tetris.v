`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/10 17:34:53
// Design Name: 
// Module Name: tetris
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

module tetris(
    // 100MHz clock from crystal
    input clk_100MHz,
    // switch input
    input sw_rst_n,
    // button input
    input btn_pause,
    input btn_restart,
    // keyboard inout
    inout key_PS2_DATA,
    inout key_PS2_CLK,
    // vga output
    output [3:0] vga_red,
    output [3:0] vga_green,
    output [3:0] vga_blue,
    output vga_hsync,
    output vga_vsync,
    // ssd output
    output [3:0] ssd_ctrl,
    output [7:0] ssd_disp,
    // speaker output
    output audio_mclk,
    output audio_lrck,
    output audio_sck,
    output audio_sdin
    );
    
    // divide necessary clock
    wire clk_25MHz;
    wire clk_1Hz;
    wire clk_100Hz;
    clk_generator clk_gen(
        .clk_100MHz(clk_100MHz),
        .rst_n(sw_rst_n),
        .clk_25MHz(clk_25MHz),
        .clk_1Hz(clk_1Hz),
        .clk_100Hz(clk_100Hz)
    );
    
    // decode keyboard input to function button
    wire left_en;
    wire right_en;
    wire down_en;
    wire rotate_en;
    wire drop_en;
    keyboard keyboard(
        .clk(clk_100MHz),
        .rst_n(sw_rst_n),
        .PS2_CLK(key_PS2_CLK),
        .PS2_DATA(key_PS2_DATA),
        .left_btn(left_en),
        .right_btn(right_en),
        .down_btn(down_en),
        .rotate_btn(rotate_en),
        .drop_btn(drop_en)
    );
    
    // debounce button input
    wire pause;
    debounce db_btn_pause (
        .clk(clk_100Hz),
        .rst_n(sw_rst_n),
        .pb_in(btn_pause),
        .pb_debounced(pause)
    );
    wire restart;
    debounce db_btn_restart (
        .clk(clk_100Hz),
        .rst_n(sw_rst_n),
        .pb_in(btn_restart),
        .pb_debounced(restart)
    );
    
    // store the positions that stacked blocks exist
    // the top left position is stacked_block[0]
    // the bottom right position is stacked_block[(`BOARD_WIDTH_BLK * `BOARD_HEIGHT_BLK)-1]
    reg [(`BOARD_WIDTH_BLK * `BOARD_HEIGHT_BLK)-1:0] stacked_block;
    // store what kind of block is the controlling one
    reg [`BITS_PER_BLOCK-1:0] ctrl_blk;
    // the x position of control block
    reg [`BITS_X_POS-1:0] ctrl_pos_x;
    // the y position of control block
    reg [`BITS_Y_POS-1:0] ctrl_pos_y;
    // the rotation of control block
    reg [`BITS_ROT-1:0] ctrl_rot;
    
    wire [`BITS_BLK_POS-1:0] ctrl_blk_1;
    wire [`BITS_BLK_POS-1:0] ctrl_blk_2;
    wire [`BITS_BLK_POS-1:0] ctrl_blk_3;
    wire [`BITS_BLK_POS-1:0] ctrl_blk_4;
    
    wire [`BITS_BLK_SIZE-1:0] ctrl_width;
    wire [`BITS_BLK_SIZE-1:0] ctrl_height;
    
    block_size ctrl_block(
        .block(ctrl_blk),
        .pos_x(ctrl_pos_x),
        .pos_y(ctrl_pos_y),
        .rot(ctrl_rot),
        .blk_1(ctrl_blk_1),
        .blk_2(ctrl_blk_2),
        .blk_3(ctrl_blk_3),
        .blk_4(ctrl_blk_4),
        .width(ctrl_width),
        .height(ctrl_height)
    );
    
    vga vga(
        .clk(clk_25MHz),
        .ctrl_blk(ctrl_blk),
        .ctrl_blk_1(ctrl_blk_1),
        .ctrl_blk_2(ctrl_blk_2),
        .ctrl_blk_3(ctrl_blk_3),
        .ctrl_blk_4(ctrl_blk_4),
        .stacked_block(stacked_block),
        .red(vga_red),
        .green(vga_green),
        .blue(vga_blue),
        .hsync(vga_hsync),
        .vsync(vga_vsync)
    );

    //Speaker
    speaker speaker(
        .BTNC(btn_pause), 
        .clk(clk_100MHz), 
        .rst_n(sw_rst_n), 
        .audio_mclk(audio_mclk), 
        .audio_lrck(audio_lrck), 
        .audio_sck(audio_sck), 
        .audio_sdin(audio_sdin)
    );
    
    // The mode, used for finite state machine things. We also
    // need to store the old mode occasionally, like when we're paused.
    reg [`BITS_MODE-1:0] mode;
    reg [`BITS_MODE-1:0] last_mode;
    // The game clock
    wire fall_en;
    // The game clock reset
    reg fall_reset;
    reg [1:0] fall_speed;
    
    block_fall block_fall(
        .clk_100MHz(clk_100MHz),
        .rst_n(sw_rst_n),
        .fall_speed(fall_speed),
        .pause(mode != `MODE_PLAY),
        .reset(fall_reset),
        .fall_en(fall_en)
    );
    
    wire [`BITS_X_POS-1:0] drop_pos_x;
    wire [`BITS_Y_POS-1:0] drop_pos_y;
    wire [`BITS_ROT-1:0] drop_rot;
    wire [`BITS_BLK_POS-1:0] drop_blk_1;
    wire [`BITS_BLK_POS-1:0] drop_blk_2;
    wire [`BITS_BLK_POS-1:0] drop_blk_3;
    wire [`BITS_BLK_POS-1:0] drop_blk_4;
    wire [`BITS_BLK_SIZE-1:0] drop_width;
    wire [`BITS_BLK_SIZE-1:0] drop_height;
    
    drop_block drop_block(
        .clk(clk_100MHz),
        .rst_n(rst_n),
        .fall_reset(fall_reset),
        .stacked_block(stacked_block),
        .ctrl_blk(ctrl_blk),
        .ctrl_pos_x(ctrl_pos_x),
        .ctrl_pos_y(ctrl_pos_y),
        .ctrl_rot(ctrl_rot),
        .ctrl_height(ctrl_height),
        .drop_pos_x(drop_pos_x),
        .drop_pos_y(drop_pos_y),
        .drop_rot(drop_rot),
        .drop_blk_1(drop_blk_1),
        .drop_blk_2(drop_blk_2),
        .drop_blk_3(drop_blk_3),
        .drop_blk_4(drop_blk_4),
        .drop_width(drop_width),
        .drop_height(drop_height)
    );
    
    wire [(`BOARD_WIDTH_BLK * `BOARD_HEIGHT_BLK)-1:0] stacked_block_temp;
    wire [`BITS_PER_BLOCK-1:0] next_blk;
    wire [`BITS_X_POS-1:0] next_pos_x;
    wire [`BITS_Y_POS-1:0] next_pos_y;
    wire [`BITS_ROT-1:0] next_rot;
    reg game_start;
    
    next_block next_block(
        .clk(clk_100MHz),
        .rst_n(rst_n),
        .stacked_block(stacked_block),
        .fall_en(fall_en),
        .left_en(left_en),
        .right_en(right_en),
        .rotate_en(rotate_en),
        .down_en(down_en),
        .drop_en(drop_en),
        .game_start(game_start),
        .ctrl_blk(ctrl_blk),
        .ctrl_pos_x(ctrl_pos_x),
        .ctrl_pos_y(ctrl_pos_y),
        .ctrl_rot(ctrl_rot),
        .drop_blk_1(drop_blk_1),
        .drop_blk_2(drop_blk_2),
        .drop_blk_3(drop_blk_3),
        .drop_blk_4(drop_blk_4),
        .stacked_block_next(stacked_block_temp),
        .next_blk(next_blk),
        .next_pos_x(next_pos_x),
        .next_pos_y(next_pos_y),
        .next_rot(next_rot),
        .fall_reset(fall_reset)
    );
    
endmodule
