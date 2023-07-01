`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/18 21:13:25
// Design Name: 
// Module Name: traffic
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

//��ͨ��ģ��
module traffic(clk,Traffic_Light,s,sout,rst,count_display,cnt,state,clk1);//,cnt,state,clk1
input clk,s,rst;//clkʱ���ź����룬s�����źţ����أ���rst��λ�ź����루��ť��
output[10:0] count_display;//��������
output[5:0] Traffic_Light;//5-3��  2-0�� ��led*6��
output sout;//sout�����ź���ʾ��led��
output clk1;//��Ƶʱ��
output cnt;//cnt��ͨ�Ƶ�����ʱ
output state;//state��ͨ��״̬
//�̶�����
parameter[5:0] MGCR=6'b001100,MYCR=6'b010100,MRCG=6'b100001,MRCY=6'b100010;
reg[5:0] state;//��ͨ��״̬
reg[15:0] cnt;//��ͨ�Ƶ���
reg[5:0] Traffic_Light;//��ͨ�����
reg clk1,sout;//��Ƶʱ�ӡ�s���
//�趨��ʼֵ
initial 
begin
	cnt<=59;
	state<=MGCR;
	Traffic_Light<=MGCR;
 end
//��Ƶʱ�ӣ�
reg[26:0] clk_cnt;
reg  [2:0]  sel=3'b0;
//always @(posedge clk)
//    begin clk_cnt=clk_cnt+1;
//         if (clk_cnt>20000000) begin clk1=1'b1;  clk_cnt=0;  end
//         else  clk1=1'b0;  //200M��Ƶ  0.25s
//    end  

//always @(posedge clk)
//    begin 
//        clk_cnt=clk_cnt+1;
//        if(clk_cnt==100000000)
//            begin
//            clk_cnt=0;
//            clk1=1'b1;
//            end
//        else
//            clk1=1'b0;
//        if(clk_cnt%100000==0) 
//            begin
//            sel=sel+1;
//            if(sel==3) 
//                sel=0;
//            end
//    end
//reg[26:0] clk_cnt;//���η���ʱ����Ϊ2��Ƶ
//always @(posedge clk)
//    begin clk_cnt=clk_cnt+1;
//         if (clk_cnt==2) begin clk1=1'b1;  clk_cnt=0;  end
//         else  clk1=1'b0;  //2��Ƶ
//    end 
//������ʾ�����ģ��
display SG_display(
    .clk (clk),
    .rst (rst),
    .counter (cnt),
    .count_display (count_display),
    .sel(sel)
);
//s�ź�
always @(s)
 begin
	if(s==1) sout=1;
	else sout=0;
 end
//״̬ת��
always @(posedge clk or negedge rst)
 if(!rst)begin state<=MGCR;cnt<=16'd59;end
 else	begin
		case (state)
		//�������
		MGCR:if (cnt==0) 
				begin 
				 if(s==1)begin Traffic_Light<=MYCR; cnt<=3; state<=MYCR; end
				 else cnt<=59;
				end 	
			  else cnt<=cnt-1;
		//�������
		MYCR:if (cnt==0)begin Traffic_Light<=MRCG; cnt<=19;state<=MRCG;end
			  else cnt<=cnt-1;
		//��������
		MRCG:if (cnt==0||s==0) begin Traffic_Light<=MRCY; cnt<=3;state<=MRCY;end  
		     else cnt<=cnt-1;
		//�������
		MRCY:if (cnt==0) begin Traffic_Light<=MGCR; cnt<=59;state<=MGCR;end 
		     else cnt<=cnt-1;
		//Ĭ���������
		default: state<=MGCR;
		endcase
	end
endmodule

