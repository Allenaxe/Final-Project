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
    input btn_volume_up,
    input btn_volume_down,
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
    output [3:0] volume,
    output audio_mclk,
    output audio_lrck,
    output audio_sck,
    output audio_sdin,
    // led
    output reg [1:0] mode
    );
    
    // divide necessary clock
    wire clk_25MHz;
    wire clk_1Hz;
    clk_generator clk_gen(
        .clk_100MHz(clk_100MHz),
        .rst_n(sw_rst_n),
        .clk_25MHz(clk_25MHz),
        .clk_1Hz(clk_1Hz)
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
    
    one_pulse O0(.push_onepulse(pause), .clk(clk_100MHz), .rst_n(sw_rst_n), .push_debounced(btn_pause));
    one_pulse O1(.push_onepulse(up), .clk(clk_100MHz), .rst_n(sw_rst_n), .push_debounced(btn_volume_up));
    one_pulse O2(.push_onepulse(down), .clk(clk_100MHz), .rst_n(sw_rst_n), .push_debounced(btn_volume_down));
    
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
    
    wire [`BITS_BLK_POS-1:0] drop_blk_1;
    wire [`BITS_BLK_POS-1:0] drop_blk_2;
    wire [`BITS_BLK_POS-1:0] drop_blk_3;
    wire [`BITS_BLK_POS-1:0] drop_blk_4;
    
    vga vga(
        .clk(clk_25MHz),
        .ctrl_blk(ctrl_blk),
        .ctrl_blk_1(ctrl_blk_1),
        .ctrl_blk_2(ctrl_blk_2),
        .ctrl_blk_3(ctrl_blk_3),
        .ctrl_blk_4(ctrl_blk_4),
        .drop_blk_1(drop_blk_1),
        .drop_blk_2(drop_blk_2),
        .drop_blk_3(drop_blk_3),
        .drop_blk_4(drop_blk_4),
        .stacked_block(stacked_block),
        .red(vga_red),
        .green(vga_green),
        .blue(vga_blue),
        .hsync(vga_hsync),
        .vsync(vga_vsync)
    );

    //Speaker
    speaker speaker(
        .state(mode),
        .clk(clk_100MHz), 
        .rst_n(sw_rst_n),
        .volume_max(volume_max),
        .volume_min(volume_min),
        .audio_mclk(audio_mclk), 
        .audio_lrck(audio_lrck), 
        .audio_sck(audio_sck), 
        .audio_sdin(audio_sdin)
    );

    //volume control

    wire [15:0] volume_max, volume_min;
    wire [3:0] volume;
    volume_ctl volume_ctl(
        .clk(clk_100MHz),
        .rst_n(sw_rst_n),
        .up(up),
        .down(down),
        .volume_max(volume_max),
        .volume_min(volume_min),
        .volume(volume)
    );
    
    wire game_start;
    assign game_start = mode == `MODE_IDLE && pause;
    
    // The game clock
    wire fall_en;
    // The game clock reset
    wire fall_reset;
    reg [1:0] fall_speed, fall_speed_next;
    
    always@(score0 or score1 or score2 or score3)
    if(score0 == 4'b0000 && score1 == 4'b0000 && score2 == 4'b0001 && score3 == 4'b0000) fall_speed_next = `SPEED_NORMAL;
    else if(score0 == 4'b0000 && score1 == 4'b0000 && score2 == 4'b0111 && score3 == 4'b0000) fall_speed_next = `SPEED_FAST;
    else fall_speed_next = fall_speed;

    always@(posedge clk or negedge sw_rst_n)
    if(~sw_rst_n) fall_speed <= `SPEED_SLOW;
    else fall_speed <= fall_speed_next;

    block_fall block_fall(
        .clk_100MHz(clk_100MHz),
        .rst_n(sw_rst_n),
        .fall_speed(fall_speed),
        .pause(mode != `MODE_PLAY),
        .reset(fall_reset & game_start),
        .fall_en(fall_en)
    );
    
    wire [`BITS_X_POS-1:0] drop_pos_x;
    wire [`BITS_Y_POS-1:0] drop_pos_y;
    wire [`BITS_ROT-1:0] drop_rot;
    
    wire [`BITS_BLK_SIZE-1:0] drop_width;
    wire [`BITS_BLK_SIZE-1:0] drop_height;
    
    drop_block drop_block(
        .clk(clk_100MHz),
        .rst_n(sw_rst_n),
        .fall_en(fall_en),
        .left_en(left_en),
        .right_en(right_en),
        .rotate_en(rotate_en),
        .down_en(down_en),
        .drop_en(drop_en),
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
        .drop_blk_4(drop_blk_4)
    );
    
    // generator random block (3'b001 ~ 3'b111)
    wire [`BITS_PER_BLOCK-1:0] random_blk;
    random_generator block_gen(
        .clk(clk_100MHz),
        .rst_n(sw_rst_n),
        .random(random_blk)
    );
    
    wire [(`BOARD_WIDTH_BLK * `BOARD_HEIGHT_BLK)-1:0] stacked_block_temp;
    wire [`BITS_PER_BLOCK-1:0] next_blk;
    wire [`BITS_X_POS-1:0] next_pos_x;
    wire [`BITS_Y_POS-1:0] next_pos_y;
    wire [`BITS_ROT-1:0] next_rot;
    
    next_block next_block(
        .stacked_block(stacked_block),
        .fall_en(fall_en),
        .left_en(left_en),
        .right_en(right_en),
        .rotate_en(rotate_en),
        .down_en(down_en),
        .drop_en(drop_en),
        .random_blk(random_blk),
        .ctrl_blk(ctrl_blk),
        .ctrl_pos_x(ctrl_pos_x),
        .ctrl_pos_y(ctrl_pos_y),
        .ctrl_rot(ctrl_rot),
        .ctrl_blk_1(ctrl_blk_1),
        .ctrl_blk_2(ctrl_blk_2),
        .ctrl_blk_3(ctrl_blk_3),
        .ctrl_blk_4(ctrl_blk_4),
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
    
    wire [(`BOARD_WIDTH_BLK * `BOARD_HEIGHT_BLK)-1:0] stacked_block_next;
    wire get_score;
    complete_row complete_row(
        .clk(clk_100MHz),
        .rst_n(sw_rst_n),
        .stacked_block(stacked_block_temp),
        .stacked_block_next(stacked_block_next),
        .get_score(get_score)
    );
    
    wire [3:0] score0;
    wire [3:0] score1;
    wire [3:0] score2;
    wire [3:0] score3;
    reg reset;
    score_control score_control(
        .clk(clk_100MHz),
        .rst_n(sw_rst_n),
        .get_score(get_score),
        .reset(game_start),
        .score0(score0),
        .score1(score1),
        .score2(score2),
        .score3(score3)
    );
    
    ssd ssd(
        .clk(clk_100MHz),
        .rst_n(sw_rst_n),
        .in0(score0),
        .in1(score1),
        .in2(score2),
        .in3(score3),
        .ssd_ctl(ssd_ctrl),
        .ssd_display(ssd_disp)
    );
    
    wire ctrl_overlap;
    assign ctrl_overlap = stacked_block[ctrl_blk_1] || stacked_block[ctrl_blk_2] || 
        stacked_block[ctrl_blk_3] || stacked_block[ctrl_blk_4];
    
    wire game_over;
    assign game_over = ctrl_pos_y == 0 && ctrl_overlap;
    
    // Main game logic
    always @ (posedge clk_100MHz or negedge sw_rst_n) 
        if (~sw_rst_n)
            begin
            mode <= `MODE_IDLE;
            ctrl_blk <= `BLOCK_EMPTY;
            ctrl_pos_x <= (`BOARD_WIDTH_BLK / 2) - 1;
            ctrl_pos_y <= 0;
            ctrl_rot <= 0;
            stacked_block <= 0;
            end
        else
            case (mode)
                `MODE_IDLE:
                    if (pause)
                        begin
                        mode <= `MODE_PLAY;
                        ctrl_blk <= random_blk;
                        ctrl_pos_x <= (`BOARD_WIDTH_BLK / 2) - 1;
                        ctrl_pos_y <= 0;
                        ctrl_rot <= 0;
                        stacked_block <= 0;
                        end
                    else
                        begin
                        mode <= `MODE_IDLE;
                        ctrl_blk <= `BLOCK_EMPTY;
                        ctrl_pos_x <= (`BOARD_WIDTH_BLK / 2) - 1;
                        ctrl_pos_y <= 0;
                        ctrl_rot <= 0;
                        stacked_block <= stacked_block;
                        end
                `MODE_PLAY:
                    if (pause)
                        begin
                        mode <= `MODE_PAUSE;
                        ctrl_blk <= ctrl_blk;
                        ctrl_pos_x <= ctrl_pos_x;
                        ctrl_pos_y <= ctrl_pos_y;
                        ctrl_rot <= ctrl_rot;
                        stacked_block <= stacked_block_next;
                        end
                    else if (game_over)
                        begin
                        mode <= `MODE_IDLE;
                        ctrl_blk <= `BLOCK_EMPTY;
                        ctrl_pos_x <= (`BOARD_WIDTH_BLK / 2) - 1;
                        ctrl_pos_y <= 0;
                        ctrl_rot <= 0;
                        stacked_block <= stacked_block;
                        end
                    else
                        begin
                        mode <= `MODE_PLAY;
                        ctrl_blk <= next_blk;
                        ctrl_pos_x <= next_pos_x;
                        ctrl_pos_y <= next_pos_y;
                        ctrl_rot <= next_rot;
                        stacked_block <= stacked_block_next;
                        end
                `MODE_PAUSE:
                    if (pause)
                        begin
                        mode <= `MODE_PLAY;
                        ctrl_blk <= next_blk;
                        ctrl_pos_x <= next_pos_x;
                        ctrl_pos_y <= next_pos_y;
                        ctrl_rot <= next_rot;
                        stacked_block <= stacked_block_next;
                        end
                    else
                        begin
                        mode <= `MODE_PAUSE;
                        ctrl_blk <= ctrl_blk;
                        ctrl_pos_x <= ctrl_pos_x;
                        ctrl_pos_y <= ctrl_pos_y;
                        ctrl_rot <= ctrl_rot;
                        stacked_block <= stacked_block_next;
                        end
                default:
                    begin
                    mode <= `MODE_IDLE;
                    ctrl_blk <= `BLOCK_EMPTY;
                    ctrl_pos_x <= (`BOARD_WIDTH_BLK / 2) - 1;
                    ctrl_pos_y <= 0;
                    ctrl_rot <= 0;
                    stacked_block <= stacked_block;
                    end
                
            endcase
            
    
endmodule
