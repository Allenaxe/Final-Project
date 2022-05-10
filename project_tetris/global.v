`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/21 00:07:41
// Design Name: 
// Module Name: global
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

`define DIV_BY_25K 25_000
`define DIV_BY_25K_BIT_WIDTH 15
`define DIV_BY_TWO 2'd2
`define DIV_BY_FOUR 2'd2
`define DIV_BY_128 7'd64
`define DIV_BY_TWO_BIT_WIDTH 2
`define DIV_BY_FOUR_BIT_WIDTH 2
`define DIV_BY_128_BIT_WIDTH 7

`define BCD_BIT_WIDTH 4
`define SSD_NUM 4
`define SSD_BIT_WIDTH 8
`define SSD_ZERO   `SSD_BIT_WIDTH'b0000_0011 // 0
`define SSD_ONE    `SSD_BIT_WIDTH'b1001_1111 // 1
`define SSD_TWO    `SSD_BIT_WIDTH'b0010_0101 // 2
`define SSD_THREE  `SSD_BIT_WIDTH'b0000_1101 // 3
`define SSD_FOUR   `SSD_BIT_WIDTH'b1001_1001 // 4
`define SSD_FIVE   `SSD_BIT_WIDTH'b0100_1001 // 5
`define SSD_SIX    `SSD_BIT_WIDTH'b0100_0001 // 6
`define SSD_SEVEN  `SSD_BIT_WIDTH'b0001_1111 // 7
`define SSD_EIGHT  `SSD_BIT_WIDTH'b0000_0001 // 8
`define SSD_NINE   `SSD_BIT_WIDTH'b0000_1001 // 9
`define SSD_DEF    `SSD_BIT_WIDTH'b0000_0000 // default

`define ENABLED 1'b1
`define DISABLED 1'b0

`define BCD_ZERO 4'b0000
`define BCD_ONE 4'b0001
`define BCD_FIVE 4'b0101
`define BCD_NINE 4'b1001