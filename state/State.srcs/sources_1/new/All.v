module All(clk,clr,ld,en,m,s,seq);
	input clk,clr,ld;//ʱ�ӡ����㡢����
	input en;//ʹ��
	output m;//���ɹ���־  			
	reg [30:0]cnt;	//��Ƶ������		 
	output [4:0] s; //״̬���
	output seq;//�������
	wire f;//�����м����
	//��Ƶ��
	reg clk1;
    //���ò�������ģ��
	Gen U1(.clk1(clk),.clr1(clr),.en(en),.ld(ld), .f(f));	
	//�������м��ģ��
	Det U2(.clk1(clk), .clr2(clr),.en(en),.f(f), .m(m), .s(s),.seq(seq));	
endmodule 