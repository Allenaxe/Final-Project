`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/12 09:57:00
// Design Name: 
// Module Name: up_cnt
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


module up_cnt(
input clk,
    input rst_n,
    input count_en,
    input load_en,
    input [3:0] load_value,
    input [3:0] init_value,
    input [3:0] limit_value,
    output reg [3:0] q,
    output reg carry
    );
    reg [3:0] q_next;
    
    always @*
        if (load_en)
            q_next = load_value;
        else
            case ({count_en, q == limit_value})
                2'b10: q_next = q + 4'd1;
                2'b11: q_next = init_value;
                default: q_next = q;
            endcase
     
     always @(posedge clk or negedge rst_n) 
        if (~rst_n) 
            q <= 4'd0;
        else 
            q <= q_next;
    
    always @*
        case ({load_en, count_en, q == limit_value})
            3'b011: carry = 1'b1;
            default: carry = 1'b0;
        endcase
    
endmodule