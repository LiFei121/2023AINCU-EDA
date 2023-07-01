`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/15 10:01:34
// Design Name: 
// Module Name: adder_
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

//1位全加器
module	adder_	(a,b,cin,cout,sum);
input	a,b;//本位输入
input	cin;//低位输入
output	cout;//进位输出
output	sum;//本位输出
wire	[2:0]w;
//调用三个与门
and
	a1(w[0],a,cin),
	a2(w[1],a,b),
	a3(w[2],b,cin);
//调用异或门求得本位输出sum
xor	a4(sum,a,b,cin);
//调用或门求得进位输出cout
or	a5(cout,w[0],w[1],w[2]);
endmodule
