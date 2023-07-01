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

//1λȫ����
module	adder_	(a,b,cin,cout,sum);
input	a,b;//��λ����
input	cin;//��λ����
output	cout;//��λ���
output	sum;//��λ���
wire	[2:0]w;
//������������
and
	a1(w[0],a,cin),
	a2(w[1],a,b),
	a3(w[2],b,cin);
//�����������ñ�λ���sum
xor	a4(sum,a,b,cin);
//���û�����ý�λ���cout
or	a5(cout,w[0],w[1],w[2]);
endmodule
