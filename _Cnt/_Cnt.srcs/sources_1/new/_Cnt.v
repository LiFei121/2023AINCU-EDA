`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/17 22:02:58
// Design Name: 
// Module Name: _Cnt
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


module _Cnt(
    input CLK,          // ʱ������
    input en ,       // �������룬���ڼ�����ʹ�ܿ���
    input RST_n,      	// �������룬���ڼ������첽����
    input [4:0] M_SET,  // ģ����������
    input Mclock,
 
    output reg [4:0] cnt_count,
    output reg [10:0] display_segout,
    output reg Led          //�����������ʾ��λ״̬
);
reg [6:0] BCD_OUT0;  // BCD����������  
reg [6:0] BCD_OUT1; // BCD����������  
reg [6:0] BCD_OUT2; // BCD���������� 
reg [6:0] BCD_OUT3; 
reg [4:0] M;       // ������ģ��
wire [3:0] sw;//����ܼ�����ʾʮλ
wire [3:0] gw;//����ܼ�����ʾ��λ
wire [3:0]sw1;//�����ģֵ��ʾʮλ
wire [3:0]gw1;//�����ģֵ��ʾ��λ
//�ı������ģֵ
always@(posedge Mclock)
begin
 M[0]<=M_SET[0];
 M[1]<=M_SET[1];
 M[2]<=M_SET[2];
 M[3]<=M_SET[3];
 M[4]<=M_SET[4];
 //����������
 cnt_count<=5'b0;
end
reg [19:0]count=0;//����ܼ��� 
reg [30:0]count2=0; //��Ƶ����
reg [2:0] sel=0; //�����ˢ�¼���
parameter T1MS=50000;//��׼Ƶ�ʲ���
//��λ�������ʾ
always@(posedge CLK) 
     begin 
        count<=count+1; 
        if(count==T1MS) 
        begin 
            count<=0; 
            sel<=sel+1; 
            if(sel==3) 
            sel<=0; 
         end 
     end
////����
wire clk1;
assign clk1=CLK;
//���Ӽ���Ƶ��
//reg clk1;
//always @(posedge CLK)
//	begin count2=count2+1;
//		if(count2/10000000%2==1)	begin clk1=1'b1; count2=0;end
//		else clk1=1'b0;
//	end
////�����������ʾ
always@(posedge CLK ) 
 begin 
    case(sel) 
        0:display_segout<={4'b0111,BCD_OUT0};
        1:display_segout<={4'b1011,BCD_OUT1};
        2:display_segout<={4'b1101,BCD_OUT2};
        3:display_segout<={4'b1110,BCD_OUT3};
        default:display_segout<=11'b1111_1111111; 
    endcase 
 end
 //�������߼�
always @(posedge clk1 or negedge RST_n)
begin
    begin
    if(RST_n == 1'b0||(Mclock==1'b1))   // �첽����
        cnt_count <= 10'd0;
    else if( en== 1'b1)   // ʹ�ܿ���
        begin
            if(cnt_count<(M-5'b1))
                begin
                    cnt_count<=cnt_count+10'd1;//������δ�����ֵ������1
                 end
            else
                begin 
                    cnt_count<=5'd0;//���������ֵ������
                 end
        end
end       
end
//LED����ʾ�߼�
always @(posedge clk1 or negedge RST_n)
begin
if(RST_n==1)//����
begin
    if(cnt_count ==(M-5'd2))
    begin
        Led=1;//���������ֵ��˸
    end
    else
        Led=0;//LEDδ��˸
end
end
assign sw =cnt_count/10%10;//���������ʮλ
assign gw =cnt_count%10;//�����������λ

assign sw1 = M/10%10;//����ģֵʮλ
assign gw1 = M%10;//����ģֵ��λ
//�������ʾ
always @(posedge clk1 or negedge RST_n)
    begin
        if(!RST_n)
            begin
            //����
                BCD_OUT0<=7'b0000001;
                BCD_OUT1<=7'b0000001;
                //BCD_OUT2<=7'b0000001;
            end
         else
            begin
            //��ʾ��λ
				case (gw)
						0:BCD_OUT0<=7'b0000001; 1:BCD_OUT0<=7'b1001111;
						2:BCD_OUT0<=7'b0010010; 3:BCD_OUT0<=7'b0000110;
						4:BCD_OUT0<=7'b1001100; 5:BCD_OUT0<=7'b0100100;
						6:BCD_OUT0<=7'b0100000; 7:BCD_OUT0<=7'b0001111;
						8:BCD_OUT0<=7'b0000000; 9:BCD_OUT0<=7'b0000100; 
						default: BCD_OUT0<=7'b0000001;    
				endcase
				//��ʾʮλ
				case (sw)
						0:BCD_OUT1<=7'b0000001; 1:BCD_OUT1<=7'b1001111;
						2:BCD_OUT1<=7'b0010010; 3:BCD_OUT1<=7'b0000110;
						4:BCD_OUT1<=7'b1001100; 5:BCD_OUT1<=7'b0100100;
						6:BCD_OUT1<=7'b0100000; 7:BCD_OUT1<=7'b0001111;
						8:BCD_OUT1<=7'b0000000; 9:BCD_OUT1<=7'b0000100; 
						default: BCD_OUT1<=7'b0000001;        
				endcase
				 
			end 
	end
//ģֵ��ʾģ��
always@(posedge Mclock)
begin
//��ʾ��λ
case(gw1)
                        0:BCD_OUT2<=7'b0000001; 1:BCD_OUT2<=7'b1001111;
						2:BCD_OUT2<=7'b0010010; 3:BCD_OUT2<=7'b0000110;
						4:BCD_OUT2<=7'b1001100; 5:BCD_OUT2<=7'b0100100;
						6:BCD_OUT2<=7'b0100000; 7:BCD_OUT2<=7'b0001111;
						8:BCD_OUT2<=7'b0000000; 9:BCD_OUT2<=7'b0000100; 
						default: BCD_OUT2<=7'b0000001; 
endcase
//��ʾʮλ
case(sw1)
                        0:BCD_OUT3<=7'b0000001; 1:BCD_OUT3<=7'b1001111;
						2:BCD_OUT3<=7'b0010010; 3:BCD_OUT3<=7'b0000110;
						4:BCD_OUT3<=7'b1001100; 5:BCD_OUT3<=7'b0100100;
						6:BCD_OUT3<=7'b0100000; 7:BCD_OUT3<=7'b0001111;
						8:BCD_OUT3<=7'b0000000; 9:BCD_OUT3<=7'b0000100; 
						default: BCD_OUT3<=7'b0000001; 

endcase
end
endmodule