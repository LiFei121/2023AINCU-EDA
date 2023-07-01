`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/15 10:14:36
// Design Name: 
// Module Name: adder
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
//4位二进制加法器
module adder (a,b,cin,cout,sum,clk);
input	[3:0]	a,b;//本位输入
input		cin;//低位输入
output		cout;//进位输出
output	[3:0]	sum;//本位输出
input clk;//为了使用ILA调试工具引进的clk信号
wire	[3:1]	c;//用来存储中间变量
//调用1位全加器实现4位二进制加法
adder_ u1	(a[0],b[0],cin,c[1],sum[0]);
adder_	u2	(a[1],b[1],c[1],c[2],sum[1]);
adder_	u3	(a[2],b[2],c[2],c[3],sum[2]);
adder_	u4	(a[3],b[3],c[3],cout,sum[3]);

//ILA调试
ila_0 your_instance_name (
	.clk(clk), // input wire clk
	.probe0(a), // input wire [0:0]  probe0  
	.probe1(b), // input wire [0:0]  probe1 
	.probe2(cin), // input wire [0:0]  probe2 
	.probe3(cout), // input wire [0:0]  probe3 
	.probe4(sum) // input wire [0:0]  probe4
);
endmodule
