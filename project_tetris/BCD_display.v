`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/12 10:01:10
// Design Name: 
// Module Name: BCD_display
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
`define SS_0 8'b00000011
`define SS_1 8'b10011111
`define SS_2 8'b00100101
`define SS_3 8'b00001101
`define SS_4 8'b10011001
`define SS_5 8'b01001001
`define SS_6 8'b01000001
`define SS_7 8'b00011111
`define SS_8 8'b00000001
`define SS_9 8'b00001001

module BCD_display(
    input [3:0] ssd_in,
    output reg [7:0] ssd_display
    );
    
    always @*
        case(ssd_in)
            4'd0: ssd_display = `SS_0;
            4'd1: ssd_display = `SS_1;
            4'd2: ssd_display = `SS_2;
            4'd3: ssd_display = `SS_3;
            4'd4: ssd_display = `SS_4;
            4'd5: ssd_display = `SS_5;
            4'd6: ssd_display = `SS_6;
            4'd7: ssd_display = `SS_7;
            4'd8: ssd_display = `SS_8;
            4'd9: ssd_display = `SS_9;
            default: ssd_display = 8'b1111_1111;
        endcase
    
endmodule
