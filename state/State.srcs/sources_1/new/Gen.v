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

//��������ģ��
module Gen(clk1,clr1,en,ld,f);	
	input clk1,clr1,ld,en;	//ld-��ֵ���и��źţ��ߵ�ƽ����
	output reg f;			//�������
	reg[15:0] wo;//����Ҫ����������
	parameter [15:0]xulie=16'b0110101010101101;//Ҫ����������
//��������
always @(posedge clk1 or negedge  clr1)
	if(~clr1) 
		begin
			f<=0; //���������
			wo<=xulie;
		end
	else if(ld) wo<=xulie;	//��ֵ���и��ź�
	else if(en)//ʹ��
		begin 
			wo[0]<=wo[15];		
			f<=wo[15];			//f-15����һ��
			wo[15:1]<=wo[14:0];//����ת����--����һλ
		end
endmodule 
