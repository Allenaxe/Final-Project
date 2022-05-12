`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/12 09:59:13
// Design Name: 
// Module Name: freq_div
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


module freq_div(
input clk,
    input rst_n,
    output reg clk_out
    );
    reg [14:0] q;
    reg [15:0] q_next;
    
     always @*
        q_next = {clk_out, q} + 1'b1;
    always @(posedge clk or negedge rst_n)
        if(~rst_n) {clk_out, q} <=16'd0;
        else {clk_out, q} <= q_next;
    
    
endmodule
