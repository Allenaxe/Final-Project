`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/12 10:03:51
// Design Name: 
// Module Name: score_control
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


module score_control(
    input clk,
    input rst_n,
    input get_score,
    input reset,
    output [3:0] score0,
    output [3:0] score1,
    output [3:0] score2,
    output [3:0] score3
    );
    wire carry_0;
    wire carry_1;
    wire carry_2;
    wire carry_3;
    
    up_cnt U0(
        .clk(clk),
        .rst_n(rst_n),
        .load_en(reset),
        .count_en(get_score),
        .load_value(4'd0),
        .init_value(4'd0),
        .limit_value(4'd9),
        .q(score0),
        .carry(carry_0)
    );
    up_cnt U1(
        .clk(clk),
        .rst_n(rst_n),
        .load_en(reset),
        .count_en(carry_0),
        .load_value(4'd0),
        .init_value(4'd0),
        .limit_value(4'd9),
        .q(score1),
        .carry(carry_1)
    );
    up_cnt U2(
        .clk(clk),
        .rst_n(rst_n),
        .load_en(reset),
        .count_en(carry_0 & carry_1),
        .load_value(4'd0),
        .init_value(4'd0),
        .limit_value(4'd9),
        .q(score2),
        .carry(carry_2)
    );
    up_cnt U3(
        .clk(clk),
        .rst_n(rst_n),
        .load_en(reset),
        .count_en(carry_0 & carry_1 & carry_2),
        .load_value(4'd0),
        .init_value(4'd0),
        .limit_value(4'd9),
        .q(score3),
        .carry(carry_3)
    );
    
endmodule
