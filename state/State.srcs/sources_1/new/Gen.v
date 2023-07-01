`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/03 15:09:21
// Design Name: 
// Module Name: Gen
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

//产生序列模块
module Gen(clk1,clr1,en,ld,f);	
	input clk1,clr1,ld,en;	//ld-赋值序列给信号，高电平启用
	output reg f;			//输出序列
	reg[15:0] wo;//储存要产生的序列
	parameter [15:0]xulie=16'b0110101010101101;//要产生的序列
//产生序列
always @(posedge clk1 or negedge  clr1)
	if(~clr1) 
		begin
			f<=0; //清产生序列
			wo<=xulie;
		end
	else if(ld) wo<=xulie;	//赋值序列给信号
	else if(en)//使能
		begin 
			wo[0]<=wo[15];		
			f<=wo[15];			//f-15即第一个
			wo[15:1]<=wo[14:0];//并行转串行--右移一位
		end
endmodule 
