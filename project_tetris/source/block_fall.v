`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/11 13:10:07
// Design Name: 
// Module Name: block_fall
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
`include "global.vh"

module block_fall(
    input clk_100MHz,
    input rst_n,
    input [1:0] fall_speed,
    input pause,
    input reset,
    output reg fall_en
    );
    
    reg [26:0] counter;
    always @ (posedge clk_100MHz or negedge rst_n)
        if (~rst_n) 
            begin
            counter <= 0;
            fall_en <= 0;
            end
        else
            if (!pause)
                if (reset) 
                    begin
                    counter <= 0;
                    fall_en <= 0;
                    end
                else
                    case (fall_speed)
                        `SPEED_SLOW:
                            if (counter == 27'd74_999_999) 
                                begin
                                counter <= 0;
                                fall_en <= 1;
                                end 
                            else 
                                begin
                                counter <= counter + 1;
                                fall_en <= 0;
                                end
                        `SPEED_NORMAL:
                            if (counter == 27'd49_999_999) 
                                begin
                                counter <= 0;
                                fall_en <= 1;
                                end 
                            else 
                                begin
                                counter <= counter + 1;
                                fall_en <= 0;
                                end
                        `SPEED_FAST:
                            if (counter == 27'd12_499_999) 
                                begin
                                counter <= 0;
                                fall_en <= 1;
                                end 
                            else 
                                begin
                                counter <= counter + 1;
                                fall_en <= 0;
                                end
                        default:
                            begin
                            counter <= 0;
                            fall_en <= 0;
                            end
                    endcase
            else
                begin
                counter <= counter;
                fall_en <= fall_en;
                end
    
endmodule
