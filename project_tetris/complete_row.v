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
    
    assign get_score = &stacked_block[(row + 1) * `BOARD_WIDTH_BLK - 1 : row * `BOARD_WIDTH_BLK];
    
    always @*
        if (get_score)
            begin
            stacked_block_next[`BOARD_WIDTH_BLK - 1 : 0] = 0;
            stacked_block_next[(row + 1) * `BOARD_WIDTH_BLK - 1 : `BOARD_WIDTH_BLK] 
                = stacked_block[row * `BOARD_WIDTH_BLK - 1 : 0];
            stacked_block_next[`BOARD_HEIGHT_BLK * `BOARD_WIDTH_BLK - 1 : (row + 1) * `BOARD_WIDTH_BLK] 
                = stacked_block[`BOARD_HEIGHT_BLK * `BOARD_WIDTH_BLK - 1 : (row + 1) * `BOARD_WIDTH_BLK];
            end
        else
            stacked_block_next = stacked_block;
    
endmodule
