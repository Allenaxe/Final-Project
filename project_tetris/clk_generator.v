`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/10 21:29:30
// Design Name: 
// Module Name: clk_generator
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


module clk_generator(
    input clk_100MHz,
    input rst_n,
    output reg clk_25MHz
    );
    
    reg clk_count;
    always @(posedge clk_100MHz or negedge rst_n)
        if(rst_n) 
            {clk_25MHz, clk_count} <= 2'd0;
        else 
            {clk_25MHz, clk_count} <= {clk_25MHz, clk_count} + 2'd1;
    
endmodule
