`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/21 01:07:45
// Design Name: 
// Module Name: speaker
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
module speaker(mode, clk_100MHz, clk_bkHz, rst_n, volume_max, volume_min, audio_mclk, audio_lrck, audio_sck, audio_sdin);
// I/O declaration
input [1:0] mode;
input clk_100MHz; // clock from the crystal
input clk_bkHz;
input rst_n; // active low reset
input [15:0] volume_max;
input [15:0] volume_min;
output audio_mclk; // master clock
output audio_lrck; // left-right clock
output audio_sck; // serial clock
output audio_sdin; // serial audio data audio_in_left

reg [21:0] note_div_left;
reg [21:0] note_div_right;
reg [8:0] counter, counter_temp;
reg stop_next, stop;

always@(counter)
    case(counter)
        9'd0:begin
        note_div_left = 22'd151745; //NOTE_E5  659
        note_div_right = 22'd151745;
        end 
        9'd1:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd2:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd3:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd4:begin
        note_div_left = 22'd202429;  //NOTE_B4  494
        note_div_right = 22'd202429;
        end
        9'd5:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd6:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd7:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd8:begin
        note_div_left = 22'd170357;  //NOTE_D5  587
        note_div_right = 22'd170357;
        end
        9'd9:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd10:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd11:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd12:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd13:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd14:begin
        note_div_left = 22'd202429;  //NOTE_B4  494
        note_div_right = 22'd202429;
        end
        9'd15:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd16:begin
        note_div_left = 22'd227273;  //NOTE_A4  440
        note_div_right = 22'd227273;
        end
        9'd17:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd18:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd19:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd20:begin
        note_div_left = 22'd227273;  //NOTE_A4  440
        note_div_right = 22'd227273;
        end
        9'd21:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd22:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd23:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd24:begin
        note_div_left = 22'd151745; //NOTE_E5  659
        note_div_right = 22'd151745;
        end 
        9'd25:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd26:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd27:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd28:begin
        note_div_left = 22'd170357;  //NOTE_D5  587
        note_div_right = 22'd170357;
        end
        9'd29:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd30:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd31:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd32:begin
        note_div_left = 22'd202429;  //NOTE_B4  494
        note_div_right = 22'd202429;
        end
        9'd33:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd34:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd35:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd36:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd37:begin
        note_div_left = 22'd170357;  //NOTE_D5  587
        note_div_right = 22'd170357;
        end
        9'd38:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd39:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd40:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd41:begin
        note_div_left = 22'd151745; //NOTE_E5  659
        note_div_right = 22'd151745;
        end 
        9'd42:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd43:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd44:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd45:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd46:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd47:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd48:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd49:begin
        note_div_left = 22'd227273;  //NOTE_A4  440
        note_div_right = 22'd227273;
        end
        9'd50:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd51:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd52:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd53:begin
        note_div_left = 22'd227273;  //NOTE_A4  440
        note_div_right = 22'd227273;
        end
        9'd54:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd55:begin
        note_div_left = 22'd227273;  //NOTE_A4  440
        note_div_right = 22'd227273;
        end
        9'd56:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd57:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd58:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd59:begin
        note_div_left = 22'd202429;  //NOTE_B4  494
        note_div_right = 22'd202429;
        end
        9'd60:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd61:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd62:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd63:begin
        note_div_left = 22'd170357;  //NOTE_D5  587
        note_div_right = 22'd170357;
        end
        9'd64:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd65:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd66:begin
        note_div_left = 22'd143266;  //NOTE_F5  698
        note_div_right = 22'd143266;
        end
        9'd67:begin
        note_div_left = 22'd143266;
        note_div_right = 22'd143266;
        end
        9'd68:begin
        note_div_left = 22'd113636;  //NOTE_A5  880
        note_div_right = 22'd113636;
        end
        9'd69:begin
        note_div_left = 22'd113636;
        note_div_right = 22'd113636;
        end 
        9'd70:begin
        note_div_left = 22'd113636;
        note_div_right = 22'd113636;
        end
        9'd71:begin
        note_div_left = 22'd113636;
        note_div_right = 22'd113636;
        end
        9'd72:begin
        note_div_left = 22'd127551;  //NOTE_G5  784
        note_div_right = 22'd127551;
        end
        9'd73:begin
        note_div_left = 22'd127551;
        note_div_right = 22'd127551;
        end
        9'd74:begin
        note_div_left = 22'd143266;  //NOTE_F5  698
        note_div_right = 22'd143266;
        end
        9'd75:begin
        note_div_left = 22'd143266;
        note_div_right = 22'd143266;
        end
        9'd76:begin
        note_div_left = 22'd151745; //NOTE_E5  659
        note_div_right = 22'd151745;
        end 
        9'd77:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd78:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd79:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd80:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd81:begin
        note_div_left = 22'd151745; //NOTE_E5  659
        note_div_right = 22'd151745;
        end 
        9'd82:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd83:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd84:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd85:begin
        note_div_left = 22'd170357;  //NOTE_D5  587
        note_div_right = 22'd170357;
        end
        9'd86:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd87:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd88:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd89:begin
        note_div_left = 22'd202429;  //NOTE_B4  494
        note_div_right = 22'd202429;
        end
        9'd90:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd91:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd92:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd93:begin
        note_div_left = 22'd202429;  //NOTE_B4  494
        note_div_right = 22'd202429;
        end
        9'd94:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd95:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd96:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd97:begin
        note_div_left = 22'd170357;  //NOTE_D5  587
        note_div_right = 22'd170357;
        end
        9'd98:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd99:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd100:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd101:begin
        note_div_left = 22'd151745; //NOTE_E5  659
        note_div_right = 22'd151745;
        end 
        9'd102:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd103:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd104:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd105:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd106:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd107:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd108:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd109:begin
        note_div_left = 22'd227273;  //NOTE_A4  440
        note_div_right = 22'd227273;
        end
        9'd110:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd111:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd112:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd113:begin
        note_div_left = 22'd227273;  //NOTE_A4  440
        note_div_right = 22'd227273;
        end
        9'd114:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd115:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd116:begin
        note_div_left = 22'd227273;  
        note_div_right = 22'd227273;
        end
        9'd117:begin
        note_div_left = 22'd0; 
        note_div_right = 22'd0;
        end
        9'd118:begin
        note_div_left = 22'd0;
        note_div_right = 22'd0;
        end
        9'd119:begin
        note_div_left = 22'd0;
        note_div_right = 22'd0;
        end
        9'd120:begin
        note_div_left = 22'd0;
        note_div_right = 22'd0;
        end
        9'd121:begin
        note_div_left = 22'd151745; //NOTE_E5  659
        note_div_right = 22'd151745;
        end 
        9'd122:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd123:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd124:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd125:begin
        note_div_left = 22'd202429;  //NOTE_B4  494
        note_div_right = 22'd202429;
        end
        9'd126:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end 
        9'd127:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd128:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd129:begin
        note_div_left = 22'd170357;  //NOTE_D5  587
        note_div_right = 22'd170357;
        end
        9'd130:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd131:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd132:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd133:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd134:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd135:begin
        note_div_left = 22'd202429;  //NOTE_B4  494
        note_div_right = 22'd202429;
        end
        9'd136:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd137:begin
        note_div_left = 22'd227273;  //NOTE_A4  440
        note_div_right = 22'd227273;
        end
        9'd138:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd139:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd140:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd141:begin
        note_div_left = 22'd227273;  //NOTE_A4  440
        note_div_right = 22'd227273;
        end
        9'd142:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd143:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd144:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd145:begin
        note_div_left = 22'd151745; //NOTE_E5  659
        note_div_right = 22'd151745;
        end 
        9'd146:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd147:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd148:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd149:begin
        note_div_left = 22'd170357;  //NOTE_D5  587
        note_div_right = 22'd170357;
        end
        9'd150:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd151:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd152:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd153:begin
        note_div_left = 22'd202429;  //NOTE_B4  494
        note_div_right = 22'd202429;
        end
        9'd154:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd155:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd156:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd157:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd158:begin
        note_div_left = 22'd170357;  //NOTE_D5  587
        note_div_right = 22'd170357;
        end
        9'd159:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd160:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd161:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd162:begin
        note_div_left = 22'd151745; //NOTE_E5  659
        note_div_right = 22'd151745;
        end 
        9'd163:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd164:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd165:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd166:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd167:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd168:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd169:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd170:begin
        note_div_left = 22'd227273;  //NOTE_A4  440
        note_div_right = 22'd227273;
        end
        9'd171:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd172:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd173:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd174:begin
        note_div_left = 22'd227273;  //NOTE_A4  440
        note_div_right = 22'd227273;
        end
        9'd175:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd176:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd177:begin
        note_div_left = 22'd227273;  //NOTE_A4  440
        note_div_right = 22'd227273;
        end
        9'd178:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd179:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd180:begin
        note_div_left = 22'd202429;  //NOTE_B4  494
        note_div_right = 22'd202429;
        end
        9'd181:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd182:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd183:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd184:begin
        note_div_left = 22'd170357;  //NOTE_D5  587
        note_div_right = 22'd170357;
        end
        9'd185:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd186:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd187:begin
        note_div_left = 22'd143266;  //NOTE_F5  698
        note_div_right = 22'd143266;
        end
        9'd188:begin
        note_div_left = 22'd143266;
        note_div_right = 22'd143266;
        end
        9'd189:begin
        note_div_left = 22'd113636;  //NOTE_A5  880
        note_div_right = 22'd113636;
        end
        9'd190:begin
        note_div_left = 22'd113636;
        note_div_right = 22'd113636;
        end 
        9'd191:begin
        note_div_left = 22'd113636;
        note_div_right = 22'd113636;
        end
        9'd192:begin
        note_div_left = 22'd113636;
        note_div_right = 22'd113636;
        end
        9'd193:begin
        note_div_left = 22'd127551;  //NOTE_G5  784
        note_div_right = 22'd127551;
        end
        9'd194:begin
        note_div_left = 22'd127551;
        note_div_right = 22'd127551;
        end
        9'd195:begin
        note_div_left = 22'd143266;  //NOTE_F5  698
        note_div_right = 22'd143266;
        end
        9'd196:begin
        note_div_left = 22'd143266;
        note_div_right = 22'd143266;
        end
        9'd197:begin
        note_div_left = 22'd151745; //NOTE_E5  659
        note_div_right = 22'd151745;
        end 
        9'd198:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd199:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd200:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd201:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd202:begin
        note_div_left = 22'd151745; //NOTE_E5  659
        note_div_right = 22'd151745;
        end 
        9'd203:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd204:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd205:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd206:begin
        note_div_left = 22'd170357;  //NOTE_D5  587
        note_div_right = 22'd170357;
        end
        9'd207:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd208:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd209:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd210:begin
        note_div_left = 22'd202429;  //NOTE_B4  494
        note_div_right = 22'd202429;
        end
        9'd211:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd212:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd213:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd214:begin
        note_div_left = 22'd202429;  //NOTE_B4  494
        note_div_right = 22'd202429;
        end
        9'd215:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd216:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd217:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd218:begin
        note_div_left = 22'd170357;  //NOTE_D5  587
        note_div_right = 22'd170357;
        end
        9'd219:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd220:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd221:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd222:begin
        note_div_left = 22'd151745; //NOTE_E5  659
        note_div_right = 22'd151745;
        end 
        9'd223:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd224:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd225:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd226:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd227:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd228:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd229:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd230:begin
        note_div_left = 22'd227273;  //NOTE_A4  440
        note_div_right = 22'd227273;
        end
        9'd231:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd232:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd233:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd234:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd235:begin
        note_div_left = 22'd227273;  //NOTE_A4  440
        note_div_right = 22'd227273;
        end
        9'd236:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd237:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd238:begin
        note_div_left = 22'd0;
        note_div_right = 22'd0;
        end
        9'd239:begin
        note_div_left = 22'd0;  //REST
        note_div_right = 22'd0;
        end
        9'd240:begin
        note_div_left = 22'd0;
        note_div_right = 22'd0;
        end
        9'd241:begin
        note_div_left = 22'd0;
        note_div_right = 22'd0;
        end
        9'd242:begin
        note_div_left = 22'd151745; //NOTE_E5  659
        note_div_right = 22'd151745;
        end 
        9'd243:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd244:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd245:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd246:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd247:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd248:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd249:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd250:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd251:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd252:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd253:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd254:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd255:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd256:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd257:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd258:begin
        note_div_left = 22'd170357;  //NOTE_D5  587
        note_div_right = 22'd170357;
        end
        9'd259:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd260:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd261:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd262:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd263:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd264:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd265:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd266:begin
        note_div_left = 22'd202429;  //NOTE_B4  494
        note_div_right = 22'd202429;
        end
        9'd267:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd268:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd269:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd270:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd271:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd272:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd273:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd274:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd275:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd276:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd277:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd278:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd279:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd280:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd281:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd282:begin
        note_div_left = 22'd227273;  //NOTE_A4  440
        note_div_right = 22'd227273;
        end
        9'd283:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd284:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd285:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd286:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd287:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd288:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd289:begin
        note_div_left = 22'd227273;
        note_div_right = 22'd227273;
        end
        9'd290:begin
        note_div_left = 22'd240964;  //NOTE_GS4  415
        note_div_right = 22'd240964;
        end
        9'd291:begin
        note_div_left = 22'd240964;
        note_div_right = 22'd240964;
        end
        9'd292:begin
        note_div_left = 22'd240964;
        note_div_right = 22'd240964;
        end
        9'd293:begin
        note_div_left = 22'd240964;
        note_div_right = 22'd240964;
        end
        9'd294:begin
        note_div_left = 22'd240964;
        note_div_right = 22'd240964;
        end
        9'd295:begin
        note_div_left = 22'd240964;
        note_div_right = 22'd240964;
        end
        9'd296:begin
        note_div_left = 22'd240964;
        note_div_right = 22'd240964;
        end
        9'd297:begin
        note_div_left = 22'd240964;
        note_div_right = 22'd240964;
        end
        9'd298:begin
        note_div_left = 22'd202429;  //NOTE_B4  494
        note_div_right = 22'd202429;
        end
        9'd299:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd300:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd301:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd302:begin
        note_div_left = 22'd0;  //REST
        note_div_right = 22'd0;
        end
        9'd303:begin
        note_div_left = 22'd0;
        note_div_right = 22'd0;
        end
        9'd304:begin
        note_div_left = 22'd151745; //NOTE_E5  659
        note_div_right = 22'd151745;
        end 
        9'd305:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd306:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd307:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd308:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd309:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd310:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd311:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd312:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd313:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd314:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd315:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd316:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd317:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd318:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd319:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd320:begin
        note_div_left = 22'd170357;  //NOTE_D5  587
        note_div_right = 22'd170357;
        end
        9'd321:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd322:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd323:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd324:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd325:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd326:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd327:begin
        note_div_left = 22'd170357;
        note_div_right = 22'd170357;
        end
        9'd328:begin
        note_div_left = 22'd202429;  //NOTE_B4  494
        note_div_right = 22'd202429;
        end
        9'd329:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd330:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd331:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd332:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd333:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd334:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd335:begin
        note_div_left = 22'd202429;
        note_div_right = 22'd202429;
        end
        9'd336:begin
        note_div_left = 22'd191204;  //NOTE_C5  523
        note_div_right = 22'd191204;
        end
        9'd337:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd338:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd339:begin
        note_div_left = 22'd191204;
        note_div_right = 22'd191204;
        end
        9'd340:begin
        note_div_left = 22'd151745; //NOTE_E5  659
        note_div_right = 22'd151745;
        end 
        9'd341:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end 
        9'd342:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd343:begin
        note_div_left = 22'd151745;
        note_div_right = 22'd151745;
        end
        9'd344:begin
        note_div_left = 22'd113636;  //NOTE_A5  880
        note_div_right = 22'd113636;
        end
        9'd345:begin
        note_div_left = 22'd113636;
        note_div_right = 22'd113636;
        end 
        9'd346:begin
        note_div_left = 22'd113636;
        note_div_right = 22'd113636;
        end
        9'd347:begin
        note_div_left = 22'd113636;
        note_div_right = 22'd113636;
        end
        9'd348:begin
        note_div_left = 22'd113636;
        note_div_right = 22'd113636;
        end
        9'd349:begin
        note_div_left = 22'd113636;
        note_div_right = 22'd113636;
        end 
        9'd350:begin
        note_div_left = 22'd113636;
        note_div_right = 22'd113636;
        end
        9'd351:begin
        note_div_left = 22'd113636;
        note_div_right = 22'd113636;
        end
        9'd352:begin
        note_div_left = 22'd120337;  //NOTE_GS5  831
        note_div_right = 22'd120337;
        end
        9'd353:begin
        note_div_left = 22'd120337;
        note_div_right = 22'd120337;
        end
        9'd354:begin
        note_div_left = 22'd120337;
        note_div_right = 22'd120337;
        end
        9'd355:begin
        note_div_left = 22'd120337;
        note_div_right = 22'd120337;
        end
        9'd356:begin
        note_div_left = 22'd120337;
        note_div_right = 22'd120337;
        end
        9'd357:begin
        note_div_left = 22'd120337;
        note_div_right = 22'd120337;
        end
        9'd358:begin
        note_div_left = 22'd120337;
        note_div_right = 22'd120337;
        end
        9'd359:begin
        note_div_left = 22'd120337;
        note_div_right = 22'd120337;
        end
        default:begin
        note_div_left = 22'd0;
        note_div_right = 22'd0;
        end
    endcase

always@(counter or stop or mode)
begin
    stop_next = stop;
    if(mode != `MODE_PLAY) stop_next = 1'b1;
    else stop_next = 1'b0;
    if(stop) counter_temp = 9'b111111111;
    else if(counter == 9'b101101000) counter_temp = 9'b0;
    else counter_temp = counter + 1'b1;
end

always@(posedge clk_100MHz or negedge rst_n)
begin
    if(~rst_n) stop <= 1'b1;
    else stop <= stop_next;
end

always@(posedge clk_bkHz or negedge rst_n)
begin
    if(~rst_n) counter <= 9'b111111111;
    else counter <= counter_temp;
end

// Declare internal nodes
wire [15:0] audio_in_left, audio_in_right; // Note generation
note_gen Ung (
    .clk(clk_100MHz), // clock from crystal 
    .rst_n(rst_n), // active low reset 
    .volume_max(volume_max),
    .volume_min(volume_min),
    .note_div_left(note_div_left), // div for note generation
    .note_div_right(note_div_right),
    .audio_left(audio_in_left), // left sound audio 
    .audio_right(audio_in_right) // right sound audio
);

// Speaker controllor
speaker_control Usc ( 
    .clk(clk_100MHz), // clock from the crystal 
    .rst_n(rst_n), // active low reset 
    .audio_left(audio_in_left), // left channel audio data input 
    .audio_right(audio_in_right), // right channel audio data input
    .audio_mclk(audio_mclk), // master clock 
    .audio_lrck(audio_lrck), // left-right clock 
    .audio_sck(audio_sck), // serial clock 
    .audio_sdin(audio_sdin) // serial audio data input
);

endmodule

