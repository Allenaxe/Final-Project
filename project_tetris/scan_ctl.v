`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/12 09:59:57
// Design Name: 
// Module Name: scan_ctl
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


module scan_ctl(
    input clk,
    input rst_n,
    input [3:0] in3,
    input [3:0] in2,
    input [3:0] in1,
    input [3:0] in0,
    output reg [3:0] ssd_in,
    output reg [3:0] ssd_ctl
    );
    reg [1:0] ssd_en_index;
    reg [1:0] ssd_en_index_next;
    
    always @*
        ssd_en_index_next = ssd_en_index + 2'd1;
        
    always @(posedge clk or negedge rst_n) 
        if (~rst_n) 
            ssd_en_index <= 2'd0;
        else 
            ssd_en_index <= ssd_en_index_next;
    
    always @*
        case (ssd_en_index)
            2'b00: ssd_in = in0;
            2'b01: ssd_in = in1;
            2'b10: ssd_in = in2;
            2'b11: ssd_in = in3;
            default: ssd_in = 4'd0;
        endcase

    always @*
        case (ssd_en_index)
            2'b00: ssd_ctl = 4'b1110;
            2'b01: ssd_ctl = 4'b1101;
            2'b10: ssd_ctl = 4'b1011;
            2'b11: ssd_ctl = 4'b0111;
            default: ssd_ctl = 4'b1111;
        endcase
    
endmodule
