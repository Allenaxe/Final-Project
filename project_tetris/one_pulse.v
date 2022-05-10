`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/24 15:58:20
// Design Name: 
// Module Name: one_pluse
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


module one_pulse(push_onepulse, clk, rst_n, push_debounced);
input clk, rst_n, push_debounced;
output push_onepulse;

reg push_onepulse;
reg push_onepulse_next;
reg push_debounced_delay;

always@*
    push_onepulse_next = push_debounced & ~push_debounced_delay;

always@(posedge clk or negedge rst_n)
    if(~rst_n) push_onepulse <= 1'b0;
    else push_onepulse <= push_onepulse_next;

always@(posedge clk or negedge rst_n)
    if(~rst_n) push_debounced_delay <= 1'b0;
    else push_debounced_delay <= push_debounced;

endmodule
