`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/14 10:00:11
// Design Name: 
// Module Name: VGA_Control
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


module VGA_Control
(
	input clk,
	input rst,
	
	input [1:0]snake,
	input [5:0]apple_x,
	input [4:0]apple_y,
	output reg[9:0]x_pos,
	output reg[9:0]y_pos,	
	output reg hsync,
	output reg vsync,
	output reg [11:0] color_out
);
     parameter  //点阵字模：每一行char_lineXX是显示的一行，共272列,256
    char_line00=256'h0420020001000000000000000000000000000000000000000000000000000000,  //第1行
    char_line01=256'h0410010000800000000000000000000000000000000000000000000000000000,  //第2行
    char_line02=256'h7FFC01003FFE0000000000000000000000000000000000000000000000000000,  //第3行
    char_line03=256'h0920FFFE20801FF81FF807E00FE000800FF00080008007E00FF0000000000000,  //第4行
    char_line04=256'h09C410102FF81000100018183018078030180780078018183018000000000000,  //第5行
    char_line05=256'h17041010208810001000381C300C0180380C01800180381C380C000000000000,  //第6行
    char_line06=256'h20FC08203FFE10001000300C700C0180101801800180300C1018000000000000,  //第7行
    char_line07=256'hC4400820208817F017F0300C301C0180001801800180300C0018000000000000,  //第8行
    char_line08=256'h044004402FF818181818300C382C0180006001800180300C0060000000000000,  //第9行
    char_line09=256'h3FF802802880000C000C300C0FCC0180018001800180300C0180000000000000,  //第10行
    char_line0a=256'h0440010024C4000C000C300C001C0180060001800180300C0600000000000000,  //第11行
    char_line0b=256'h0440028022A8380C380C38180018018008040180018038180804000000000000,  //第12行
    char_line0c=256'hFFFE04404490301830181C1038300180300C018001801C10300C000000000000,  //第13行
    char_line0d=256'h0820082048880FE00FE007E00FC00FF83FF80FF80FF807E03FF8000000000000,  //第14行
    char_line0e=256'h1010301892860000000000000000000000000000000000000000000000000000,  //第15行
    char_line0f=256'h2008C00601000000000000000000000000000000000000000000000000000000,  //第16行
    char_line10=256'h2028FFFE01000000000000000000000000000000000000000000000000000000,  //第17行
    char_line11=256'h2010000001000000000000000000000000000000000000000000000000000000;  //第18行
    reg [7:0] char_bit;
    
	reg [19:0]clk_cnt;
	reg [9:0]line_cnt;
	reg clk_25M;
	
	localparam NONE = 2'b00;
	localparam HEAD = 2'b01;
	localparam BODY = 2'b10;
	localparam WALL = 2'b11;
	
	localparam HEAD_COLOR = 12'b0000_1111_0000;
	localparam BODY_COLOR = 12'b0000_1111_1111;
	
	
	reg [3:0]lox;
	reg [3:0]loy;
		
	always@(posedge clk or negedge rst) begin
		if(rst) begin
			clk_cnt <= 0;
			line_cnt <= 0;
			hsync <= 1;
			vsync <= 1;
		end
		else begin
		    x_pos <= clk_cnt - 144;
			y_pos <= line_cnt - 33;	
			if(clk_cnt == 0) begin
			    hsync <= 0;
				clk_cnt <= clk_cnt + 1;
            end
			else if(clk_cnt == 96) begin
				hsync <= 1;
				clk_cnt <= clk_cnt + 1;
            end
			else if(clk_cnt == 799) begin
				clk_cnt <= 0;
				line_cnt <= line_cnt + 1;
			end
			else clk_cnt <= clk_cnt + 1;
			if(line_cnt == 0) begin
				vsync <= 0;
            end
			else if(line_cnt == 2) begin
				vsync <= 1;
			end
			else if(line_cnt == 521) begin
				line_cnt <= 0;
				vsync <= 0;
			end
			
			if(x_pos >= 0 && x_pos < 640 && y_pos >= 20 && y_pos < 480) begin
			    lox = x_pos[3:0];
				loy = y_pos[3:0];						
				if(x_pos[9:4] == apple_x && y_pos[9:4] == apple_y)
					case({loy,lox})
						8'b0000_0000:color_out = 12'b0000_0000_0000;
						default:color_out = 12'b0000_0000_1111;
					endcase						
				else if(snake == NONE)
					color_out = 12'b0000_0000_0000;
				else if(snake == WALL)
					color_out = 3'b101;
				else if(snake == HEAD|snake == BODY) begin   //根据当前扫描到的点是哪一部分输出相应颜色
					case({lox,loy})
						8'b0000_0000:color_out = 12'b0000_0000_0000;
						default:color_out = (snake == HEAD) ?  HEAD_COLOR : BODY_COLOR;
					endcase
				end
			end

			
			else if(x_pos >=0 && x_pos <256 && y_pos >= 0 && y_pos<20)begin
			 if(x_pos == 0)char_bit<=8'd256;
			 else if(x_pos >0 && x_pos <= 640)begin
			  char_bit<=char_bit-1'b1;
                    case(y_pos)            //Y控制图像的纵向显示边界：从距离屏幕顶部200像素开始显示第一行数据
                        10'd0:
                        if(char_line00[char_bit])color_out<=12'b0000_1111_0000;  //如果该行有数据 则颜色为红色
                        else color_out<=12'b0000_0000_0000;                      //否则为黑色
                        10'd1:
                        if(char_line01[char_bit])color_out<=12'b0000_1111_0000;
                        else color_out<=12'b0000_0000_0000;
                        10'd2:
                        if(char_line02[char_bit])color_out<=12'b0000_1111_0000;
                        else color_out<=12'b0000_0000_0000;
                        10'd3:
                        if(char_line03[char_bit])color_out<=12'b0000_1111_0000;
                        else color_out<=12'b0000_0000_0000;
                        10'd4:
                        if(char_line04[char_bit])color_out<=12'b0000_1111_0000;
                        else color_out<=12'b0000_0000_0000; 
                        10'd5:
                        if(char_line05[char_bit])color_out<=12'b0000_1111_0000;
                        else color_out<=12'b0000_0000_0000;
                        10'd6:
                        if(char_line06[char_bit])color_out<=12'b0000_1111_0000;
                        else color_out<=12'b0000_0000_0000; 
                        10'd7:
                        if(char_line07[char_bit])color_out<=12'b0000_1111_0000;
                        else color_out<=12'b0000_0000_0000;
                        10'd8:
                        if(char_line08[char_bit])color_out<=12'b0000_1111_0000;
                        else color_out<=12'b0000_0000_0000; 
                        10'd9:
                        if(char_line09[char_bit])color_out<=12'b0000_1111_0000;
                        else color_out<=12'b0000_0000_0000;
                        10'd10:
                        if(char_line0a[char_bit])color_out<=12'b0000_1111_0000;
                        else color_out<=12'b0000_0000_0000;
                        10'd11:
                        if(char_line0b[char_bit])color_out<=12'b0000_1111_0000;
                        else color_out<=12'b0000_0000_0000;
                        10'd12:
                        if(char_line0c[char_bit])color_out<=12'b0000_1111_0000;
                        else color_out<=12'b0000_0000_0000;
                        10'd13:
                        if(char_line0d[char_bit])color_out<=12'b0000_1111_0000;
                        else color_out<=12'b0000_0000_0000;
                        10'd14:
                        if(char_line0e[char_bit])color_out<=12'b0000_1111_0000;
                        else color_out<=12'b0000_0000_0000;
                        10'd15:
                        if(char_line0f[char_bit])color_out<=12'b0000_1111_0000;
                        else color_out<=12'b0000_0000_0000;
                        10'd16:
                        if(char_line10[char_bit])color_out<=12'b0000_1111_0000;
                        else color_out<=12'b0000_0000_0000;
                        10'd17:
                        if(char_line11[char_bit])color_out<=12'b0000_1111_0000;
                        else color_out<=12'b0000_0000_0000;
                        default:color_out<=12'b0000_0000_0000;   //默认颜色黑色
                    endcase 
              end
			end
			
			else color_out = 12'b0000_0000_0000;
			
		end
    end
endmodule
