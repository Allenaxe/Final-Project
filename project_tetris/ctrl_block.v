`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/10 23:10:32
// Design Name: 
// Module Name: ctrl_block
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

module ctrl_block(
    input [`BITS_PER_BLOCK-1:0] block,
    input [`BITS_X_POS-1:0] pos_x,
    input [`BITS_Y_POS-1:0] pos_y,
    input [`BITS_ROT-1:0] rot,
    output reg [`BITS_BLK_POS-1:0] blk_1,
    output reg [`BITS_BLK_POS-1:0] blk_2,
    output reg [`BITS_BLK_POS-1:0] blk_3,
    output reg [`BITS_BLK_POS-1:0] blk_4,
    output reg [`BITS_BLK_SIZE-1:0] width,
    output reg [`BITS_BLK_SIZE-1:0] height
    );
    
    always @* 
        begin
        case (block)
            `BLOCK_EMPTY: 
                begin
                blk_1 = `ERR_BLK_POS;
                blk_2 = `ERR_BLK_POS;
                blk_3 = `ERR_BLK_POS;
                blk_4 = `ERR_BLK_POS;
                width = 0;
                height = 0;
                end
            `BLOCK_I: 
                 case (rot) 
                    0,2:
                        begin
                        blk_1 = (pos_y * `BOARD_WIDTH_BLK) + pos_x;
                        blk_2 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x;
                        blk_3 = ((pos_y + 2) * `BOARD_WIDTH_BLK) + pos_x;
                        blk_4 = ((pos_y + 3) * `BOARD_WIDTH_BLK) + pos_x;
                        width = 1;
                        height = 4;
                        end 
                    default:
                        begin
                         blk_1 = (pos_y * `BOARD_WIDTH_BLK) + pos_x;
                         blk_2 = (pos_y * `BOARD_WIDTH_BLK) + pos_x + 1;
                         blk_3 = (pos_y * `BOARD_WIDTH_BLK) + pos_x + 2;
                         blk_4 = (pos_y * `BOARD_WIDTH_BLK) + pos_x + 3;
                         width = 4;
                         height = 1;
                        end
                endcase
            `BLOCK_O: 
                begin
                blk_1 = (pos_y * `BOARD_WIDTH_BLK) + pos_x;
                blk_2 = (pos_y * `BOARD_WIDTH_BLK) + pos_x + 1;
                blk_3 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x;
                blk_4 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x + 1;
                width = 2;
                height = 2;
                end
            `BLOCK_T:
                case (rot)
                    0: 
                        begin
                        blk_1 = (pos_y * `BOARD_WIDTH_BLK) + pos_x + 1;
                        blk_2 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x;
                        blk_3 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x + 1;
                        blk_4 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x + 2;
                        width = 3;
                        height = 2;
                        end
                    1: 
                        begin
                        blk_1 = (pos_y * `BOARD_WIDTH_BLK) + pos_x;
                        blk_2 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x;
                        blk_3 = ((pos_y + 2) * `BOARD_WIDTH_BLK) + pos_x;
                        blk_4 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x + 1;
                        width = 2;
                        height = 3;
                        end
                    2: 
                        begin
                        blk_1 = (pos_y * `BOARD_WIDTH_BLK) + pos_x;
                        blk_2 = (pos_y * `BOARD_WIDTH_BLK) + pos_x + 1;
                        blk_3 = (pos_y * `BOARD_WIDTH_BLK) + pos_x + 2;
                        blk_4 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x + 1;
                        width = 3;
                        height = 2;
                        end
                    default: 
                        begin
                        blk_1 = (pos_y * `BOARD_WIDTH_BLK) + pos_x + 1;
                        blk_2 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x + 1;
                        blk_3 = ((pos_y + 2) * `BOARD_WIDTH_BLK) + pos_x + 1;
                        blk_4 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x;
                        width = 2;
                        height = 3;
                        end
                endcase
            `BLOCK_S:
                case (rot) 
                    0,2:
                        begin
                        blk_1 = (pos_y * `BOARD_WIDTH_BLK) + pos_x + 1;
                        blk_2 = (pos_y * `BOARD_WIDTH_BLK) + pos_x + 2;
                        blk_3 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x;
                        blk_4 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x + 1;
                        width = 3;
                        height = 2;
                        end 
                    default:
                        begin
                        blk_1 = (pos_y * `BOARD_WIDTH_BLK) + pos_x;
                        blk_2 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x;
                        blk_3 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x + 1;
                        blk_4 = ((pos_y + 2) * `BOARD_WIDTH_BLK) + pos_x + 1;
                        width = 2;
                        height = 3;
                        end
                endcase
            `BLOCK_Z:
                case (rot) 
                    0,2:
                        begin
                        blk_1 = (pos_y * `BOARD_WIDTH_BLK) + pos_x;
                        blk_2 = (pos_y * `BOARD_WIDTH_BLK) + pos_x + 1;
                        blk_3 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x + 1;
                        blk_4 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x + 2;
                        width = 3;
                        height = 2;
                        end 
                    default: 
                        begin
                        blk_1 = (pos_y * `BOARD_WIDTH_BLK) + pos_x + 1;
                        blk_2 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x;
                        blk_3 = ((pos_y + 2) * `BOARD_WIDTH_BLK) + pos_x;
                        blk_4 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x + 1;
                        width = 2;
                        height = 3;
                        end
                endcase
            `BLOCK_J:
                case (rot)
                    0: 
                        begin
                        blk_1 = (pos_y * `BOARD_WIDTH_BLK) + pos_x + 1;
                        blk_2 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x + 1;
                        blk_3 = ((pos_y + 2) * `BOARD_WIDTH_BLK) + pos_x + 1;
                        blk_4 = ((pos_y + 2) * `BOARD_WIDTH_BLK) + pos_x;
                        width = 2;
                        height = 3;
                        end
                    1: 
                        begin
                        blk_1 = (pos_y * `BOARD_WIDTH_BLK) + pos_x;
                        blk_2 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x;
                        blk_3 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x + 1;
                        blk_4 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x + 2;
                        width = 3;
                        height = 2;
                        end
                    2: 
                        begin
                        blk_1 = (pos_y * `BOARD_WIDTH_BLK) + pos_x;
                        blk_2 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x;
                        blk_3 = ((pos_y + 2) * `BOARD_WIDTH_BLK) + pos_x;
                        blk_4 = (pos_y * `BOARD_WIDTH_BLK) + pos_x + 1;
                        width = 2;
                        height = 3;
                        end
                    default: 
                        begin
                        blk_1 = (pos_y * `BOARD_WIDTH_BLK) + pos_x;
                        blk_2 = (pos_y * `BOARD_WIDTH_BLK) + pos_x + 1;
                        blk_3 = (pos_y * `BOARD_WIDTH_BLK) + pos_x + 2;
                        blk_4 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x + 2;
                        width = 3;
                        height = 2;
                        end
                endcase
            `BLOCK_L:
                case (rot)
                    0: 
                        begin
                        blk_1 = (pos_y * `BOARD_WIDTH_BLK) + pos_x;
                        blk_2 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x;
                        blk_3 = ((pos_y + 2) * `BOARD_WIDTH_BLK) + pos_x;
                        blk_4 = ((pos_y + 2) * `BOARD_WIDTH_BLK) + pos_x + 1;
                        width = 2;
                        height = 3;
                        end
                    1: 
                        begin
                        blk_1 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x;
                        blk_2 = (pos_y * `BOARD_WIDTH_BLK) + pos_x;
                        blk_3 = (pos_y * `BOARD_WIDTH_BLK) + pos_x + 1;
                        blk_4 = (pos_y * `BOARD_WIDTH_BLK) + pos_x + 2;
                        width = 3;
                        height = 2;
                        end
                    2: 
                        begin
                        blk_1 = (pos_y * `BOARD_WIDTH_BLK) + pos_x + 1;
                        blk_2 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x + 1;
                        blk_3 = ((pos_y + 2) * `BOARD_WIDTH_BLK) + pos_x + 1;
                        blk_4 = (pos_y * `BOARD_WIDTH_BLK) + pos_x;
                        width = 2;
                        height = 3;
                        end
                    default: 
                        begin
                        blk_1 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x;
                        blk_2 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x + 1;
                        blk_3 = ((pos_y + 1) * `BOARD_WIDTH_BLK) + pos_x + 2;
                        blk_4 = (pos_y * `BOARD_WIDTH_BLK) + pos_x + 2;
                        width = 3;
                        height = 2;
                        end
                endcase
        endcase
    end
    
endmodule
