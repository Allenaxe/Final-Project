`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/11 23:33:10
// Design Name: 
// Module Name: complete_row
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


module complete_row(
    input clk,
    input rst_n,
    input [(`BOARD_WIDTH_BLK * `BOARD_HEIGHT_BLK)-1:0] stacked_block,
    output reg [(`BOARD_WIDTH_BLK * `BOARD_HEIGHT_BLK)-1:0] stacked_block_next,
    output get_score
    );
    
    reg [4:0] row;
    always @(posedge clk or negedge rst_n)
        if(~rst_n) 
            row <= 0;
        else 
            if (row == `BOARD_HEIGHT_BLK - 1)
                row <= 0;
            else
                row <= row + 1;
    
    assign get_score = &stacked_block[row * `BOARD_WIDTH_BLK +: `BOARD_WIDTH_BLK];
    
    always @*
        if (get_score)
            begin
            stacked_block_next[`BOARD_WIDTH_BLK - 1 : 0] = 0;
            case (row)
                0: 
                    begin
                    stacked_block_next[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK] = stacked_block[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK];
                    end
                1:
                    begin
                    stacked_block_next[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 2] = stacked_block[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 2];
                    stacked_block_next[`BOARD_WIDTH_BLK * 2 - 1: `BOARD_WIDTH_BLK] = stacked_block[(`BOARD_WIDTH_BLK * 1) - 1: 0];
                    end
                2:
                    begin
                    stacked_block_next[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 3] = stacked_block[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 3];
                    stacked_block_next[`BOARD_WIDTH_BLK * 3 - 1: `BOARD_WIDTH_BLK] = stacked_block[(`BOARD_WIDTH_BLK * 2) - 1: 0];
                    end
                3:
                    begin
                    stacked_block_next[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 4] = stacked_block[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 4];
                    stacked_block_next[`BOARD_WIDTH_BLK * 4 - 1: `BOARD_WIDTH_BLK] = stacked_block[(`BOARD_WIDTH_BLK * 3) - 1: 0];
                    end
                4:
                    begin
                    stacked_block_next[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 5] = stacked_block[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 5];
                    stacked_block_next[`BOARD_WIDTH_BLK * 5 - 1: `BOARD_WIDTH_BLK] = stacked_block[(`BOARD_WIDTH_BLK * 4) - 1: 0];
                    end
                5:
                    begin
                    stacked_block_next[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 6] = stacked_block[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 6];
                    stacked_block_next[`BOARD_WIDTH_BLK * 6 - 1: `BOARD_WIDTH_BLK] = stacked_block[(`BOARD_WIDTH_BLK * 5) - 1: 0];
                    end
                6:
                    begin
                    stacked_block_next[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 7] = stacked_block[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 7];
                    stacked_block_next[`BOARD_WIDTH_BLK * 7 - 1: `BOARD_WIDTH_BLK] = stacked_block[(`BOARD_WIDTH_BLK * 6) - 1: 0];
                    end
                7:
                    begin
                    stacked_block_next[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 8] = stacked_block[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 8];
                    stacked_block_next[`BOARD_WIDTH_BLK * 8 - 1: `BOARD_WIDTH_BLK] = stacked_block[(`BOARD_WIDTH_BLK * 7) - 1: 0];
                    end
                8:
                    begin
                    stacked_block_next[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 9] = stacked_block[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 9];
                    stacked_block_next[`BOARD_WIDTH_BLK * 9 - 1: `BOARD_WIDTH_BLK] = stacked_block[(`BOARD_WIDTH_BLK * 8) - 1: 0];
                    end
                9:
                    begin
                    stacked_block_next[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 10] = stacked_block[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 10];
                    stacked_block_next[`BOARD_WIDTH_BLK * 10 - 1: `BOARD_WIDTH_BLK] = stacked_block[(`BOARD_WIDTH_BLK *9 ) - 1: 0];
                    end
                10:
                    begin
                    stacked_block_next[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 11] = stacked_block[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 11];
                    stacked_block_next[`BOARD_WIDTH_BLK * 11 - 1: `BOARD_WIDTH_BLK] = stacked_block[(`BOARD_WIDTH_BLK * 10) - 1: 0];
                    end
                11:
                    begin
                    stacked_block_next[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 12] = stacked_block[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 12];
                    stacked_block_next[`BOARD_WIDTH_BLK * 12 - 1: `BOARD_WIDTH_BLK] = stacked_block[(`BOARD_WIDTH_BLK * 11) - 1: 0];
                    end
                12:
                    begin
                    stacked_block_next[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 13] = stacked_block[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 13];
                    stacked_block_next[`BOARD_WIDTH_BLK * 13 - 1: `BOARD_WIDTH_BLK] = stacked_block[(`BOARD_WIDTH_BLK * 12) - 1: 0];
                    end
                13:
                    begin
                    stacked_block_next[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 14] = stacked_block[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 14];
                    stacked_block_next[`BOARD_WIDTH_BLK * 14 - 1: `BOARD_WIDTH_BLK] = stacked_block[(`BOARD_WIDTH_BLK * 13) - 1: 0];
                    end
                14:
                    begin
                    stacked_block_next[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 15] = stacked_block[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 15];
                    stacked_block_next[`BOARD_WIDTH_BLK * 15 - 1: `BOARD_WIDTH_BLK] = stacked_block[(`BOARD_WIDTH_BLK * 14) - 1: 0];
                    end
                15:
                    begin
                    stacked_block_next[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 16] = stacked_block[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 16];
                    stacked_block_next[`BOARD_WIDTH_BLK * 16 - 1: `BOARD_WIDTH_BLK] = stacked_block[(`BOARD_WIDTH_BLK * 15) - 1: 0];
                    end
                16:
                    begin
                    stacked_block_next[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 17] = stacked_block[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 17];
                    stacked_block_next[`BOARD_WIDTH_BLK * 17 - 1: `BOARD_WIDTH_BLK] = stacked_block[(`BOARD_WIDTH_BLK * 16) - 1: 0];
                    end
                17:
                    begin
                    stacked_block_next[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 18] = stacked_block[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 18];
                    stacked_block_next[`BOARD_WIDTH_BLK * 18 - 1: `BOARD_WIDTH_BLK] = stacked_block[(`BOARD_WIDTH_BLK * 17) - 1: 0];
                    end
                18:
                    begin
                    stacked_block_next[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 19] = stacked_block[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 19];
                    stacked_block_next[`BOARD_WIDTH_BLK * 19 - 1: `BOARD_WIDTH_BLK] = stacked_block[(`BOARD_WIDTH_BLK * 18) - 1: 0];
                    end
                19:
                    begin
                    stacked_block_next[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 20] = stacked_block[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 20];
                    stacked_block_next[`BOARD_WIDTH_BLK * 20 - 1: `BOARD_WIDTH_BLK] = stacked_block[(`BOARD_WIDTH_BLK * 19) - 1: 0];
                    end
                20:
                    begin
                    stacked_block_next[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 21] = stacked_block[(`BOARD_WIDTH_BLK * 22) - 1: `BOARD_WIDTH_BLK * 21];
                    stacked_block_next[`BOARD_WIDTH_BLK * 21 - 1: `BOARD_WIDTH_BLK] = stacked_block[(`BOARD_WIDTH_BLK * 20) - 1: 0];
                    end
                21:
                    begin
                    stacked_block_next[`BOARD_WIDTH_BLK * 22 - 1: `BOARD_WIDTH_BLK] = stacked_block[(`BOARD_WIDTH_BLK * 21) - 1: 0];
                    end
                default:
                    begin
                    stacked_block_next = stacked_block;
                    end
            endcase
            end
        else
            stacked_block_next = stacked_block;
    
endmodule
