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
//4λ�����Ƽӷ���
module adder (a,b,cin,cout,sum,clk);
input	[3:0]	a,b;//��λ����
input		cin;//��λ����
output		cout;//��λ���
output	[3:0]	sum;//��λ���
input clk;//Ϊ��ʹ��ILA���Թ���������clk�ź�
wire	[3:1]	c;//�����洢�м����
//����1λȫ����ʵ��4λ�����Ƽӷ�
adder_ u1	(a[0],b[0],cin,c[1],sum[0]);
adder_	u2	(a[1],b[1],c[1],c[2],sum[1]);
adder_	u3	(a[2],b[2],c[2],c[3],sum[2]);
adder_	u4	(a[3],b[3],c[3],cout,sum[3]);

//ILA����
ila_0 your_instance_name (
	.clk(clk), // input wire clk
	.probe0(a), // input wire [0:0]  probe0  
	.probe1(b), // input wire [0:0]  probe1 
	.probe2(cin), // input wire [0:0]  probe2 
	.probe3(cout), // input wire [0:0]  probe3 
	.probe4(sum) // input wire [0:0]  probe4
);
endmodule
