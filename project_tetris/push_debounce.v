`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/24 15:45:37
// Design Name: 
// Module Name: push_debounce
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


module push_debounce(push_debounced, push, rst_n, clk);
input push, clk, rst_n;
output push_debounced;

reg push_debounced;
reg [3:0] push_window;

always@(posedge clk or negedge rst_n)
    if(~rst_n) push_window <= 4'b0000;
    else push_window <= {push, push_window[3:1]};
    
always@(posedge clk or negedge rst_n)
    begin
    if(~rst_n) push_debounced <= 1'b0;
    else
        begin
        if(push_window == 4'b1111) push_debounced <= 1'b1;
        else push_debounced <= 1'b0;
        end
    end

endmodule
