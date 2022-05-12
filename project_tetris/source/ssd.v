`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/12 09:58:21
// Design Name: 
// Module Name: ssd
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


module ssd(
    input clk,
    input rst_n,
    input [3:0] in3,
    input [3:0] in2,
    input [3:0] in1,
    input [3:0] in0,
    output [3:0] ssd_ctl,
    output [7:0] ssd_display
    );
    wire clk_d;
    wire [3:0] ssd_in;
    
    freq_div U0(
        .clk(clk),
        .rst_n(rst_n),
        .clk_out(clk_d)
    );
    scan_ctl U1(
        .clk(clk_d),
        .rst_n(rst_n),
        .in3(in3),
        .in2(in2),
        .in1(in1),
        .in0(in0),
        .ssd_in(ssd_in),
        .ssd_ctl(ssd_ctl)
    );
    BCD_display U2(
        .ssd_in(ssd_in),
        .ssd_display(ssd_display)
    );
    
endmodule
