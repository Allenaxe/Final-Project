`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/10 21:50:45
// Design Name: 
// Module Name: random_generator
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


module random_generator(
    input clk,
    input rst_n,
    output reg [2:0] random
    );
    
    always @(posedge clk or negedge rst_n)
        if(rst_n) 
            random <= 3'b111;
        else 
            begin
            random[0] <= random[1] ^ random[2];
            random[1] <= random[0];
            random[2] <= random[1];
            end
    
    
endmodule
