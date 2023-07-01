`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/03 15:11:09
// Design Name: 
// Module Name: Det
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

//�������ģ��
module Det(clk1,clr2,en,f,m,s,seq);

input clk1,clr2,en;//���ź�
input f;				//��ǰ�������
output m;			//ָʾ��
output reg [4:0]  s;
output reg seq;//�������
reg m;
parameter [4:0]  q1=5'b10101;//10101;	//Ҫ��������
reg[2:0] q2;//������׶�
reg[4:0] z=5'b00000;
always @(posedge clk1 or negedge  clr2)
	begin
		if(~clr2)begin q2<=0;m<=0; //����������
	end
	else if(en)
		case(q2)
		//״̬��
		//��һ�׶�
		0:if(f==q1[4]) 
		begin q2<=1;//����ڶ��׶�
		m<=0;
		end
		else 	
		begin q2<=0;
		 m<=0;
		end 
		//�ڶ��׶�			
		1:if(f==q1[3]) 
		begin q2<=2;//��������׶�
		m<=0;
		end 
		else  	
		begin 
		q2<=1;//�ص���һ�׶�
		m<=0;
		end 	
		//�����׶�					
		2:if(f==q1[2]) 
		begin q2<=3;//������Ľ׶�
		m<=0;
		end 
		else  	
		begin 
		q2<=0;//�ص���һ�׶�
		m<=0;
		end 
		//���Ľ׶�
		3:if(f==q1[1]) 
		begin q2<=4;//�������׶�
		m<=0;
		end
		else  	
		begin q2<=1;//�ص��ڶ��׶�
        m<=0;					  
		end 
        //����׶�								
		4:if(f==q1[0]) 
		begin q2<=3;//�ص����Ľ׶�
		m<=1;
		end 
		else 	begin 
		q2<=0;//�ص���һ�׶�
		m<=0;
		end 				
		default: q2<=0;
		endcase		
    end
    //�����������
	always @(posedge clk1 or negedge clr2)
		if(!clr2)//����	
			begin
				z<=0;
				s<=0;
				seq <=z[0];//�����������
			end
		else if(en)//ʹ��
				begin
					z[4:1]=z[3:0];
					z[0]=f;
					s<=z; 
					seq = z[0];//����������
				end
endmodule

