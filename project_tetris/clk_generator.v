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
    output reg clk_25MHz,
    output reg clk_1Hz
    );
    
    reg clk_25MHz_count;
    always @(posedge clk_100MHz or negedge rst_n)
        if(~rst_n) 
            {clk_25MHz, clk_25MHz_count} <= 2'd0;
        else 
            {clk_25MHz, clk_25MHz_count} <= {clk_25MHz, clk_25MHz_count} + 2'd1;
    
    reg [25:0] clk_1Hz_count;
    reg [25:0] clk_1Hz_count_next;
    reg clk_1Hz_next;
    always @*
        if (clk_1Hz_count == 26'd49_999_999) 
            begin
            clk_1Hz_count_next = 26'd0;
            clk_1Hz_next = ~clk_1Hz;
            end
        else 
            begin
            clk_1Hz_count_next = clk_1Hz_count + 1'b1;
            clk_1Hz_next = clk_1Hz;
            end
    
    always @(posedge clk_100MHz or negedge rst_n)
        if (~rst_n) 
            begin
            clk_1Hz_count <= 26'd0;
            clk_1Hz <= 1'b0;
            end
        else 
            begin
            clk_1Hz_count <= clk_1Hz_count_next;
            clk_1Hz <= clk_1Hz_next;
            end
    
endmodule
