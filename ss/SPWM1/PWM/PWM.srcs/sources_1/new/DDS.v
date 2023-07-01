`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/22 21:59:50
// Design Name: 
// Module Name: DDS
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


module DDS(
    input clk,//ʱ���ź�
    input rst,//�����ź�
    input wave,//����ѡ���ź�
    input F,//Ƶ��
    //input [9:0]Pword,//��λ
    input A,//����
    input [9:0]Pword,//��λ
    output [9:0]dataout//�����������
);
reg [6:0] BCD_OUT0;  // BCD����������  
reg [6:0] BCD_OUT1; // BCD���������� 
reg [6:0] BCD_OUT2; // BCD���������� 
reg [1:0]s_wave;
reg [1:0]s_F;
reg[1:0]s_A;
//reg [6:0] BCD_OUT3=7'd0; 
reg [1:0]wave1;//�����м����
reg [31:0]Fword;//Ƶ���м����
reg [9:0]Aword;//�����м����
//����
//�������ݣ�
reg [9:0] wavedata;
//�����ź�:
wire [9:0] sindata;//����
wire [9:0] squdata;//����
wire [9:0] tridata;//���ǲ�
wire [9:0] sawdata;//��ݲ�
reg [19:0]count=0; //�������ʾ����
reg [30:0]count2=0; //�������ʾ����
reg [2:0] sel=0; //�����ѡ�����
parameter T1MS=50000;//Ƶ�ʲ���
//����
//reg clk1;
//always @(posedge clk)
//	begin count2=count2+1;
//		if(count2/10000000%2==1)	begin clk1=1'b1; count2=0;end
//		else clk1=1'b0;
//		end
//ѡ��Ƶ���ź�
always @(posedge F or negedge rst)
begin
    //����
    if(!rst)
    begin
        s_F<=2'b00;//���Ҳ�
    end
    else
    begin
        //����������λ
        if(s_F==2'b10)
        begin
            s_F<=2'b00;
        end
        else
        begin
            s_F<=s_F+2'b01;
        end
    end
end
//ѡ���ֵ
always @(posedge A or negedge rst)
begin
    //����
    if(!rst)
    begin
        s_A<=2'b00;
    end
    else
    begin
    if(s_A==2'b10)
    begin
        s_A<=2'b00;
    end
    else
    begin
       s_A<=s_A+2'b01;
    end
    end
end
//ѡ����
always @(posedge wave or negedge rst)
begin
    //����
    if(!rst)
    begin
        s_wave<=2'b0;
    end
    else
    begin
    if(s_wave==2'b10)
    begin
        s_wave<=2'b00;
    end
    else
    begin
       s_wave<=s_wave+2'b01;
    end
   end
end
//���Ҳ��β�����
//��λ�Ĵ�����
reg [31:0]frechange; 
 //������������
always @(posedge clk or negedge rst) begin
   if(!rst)
       frechange <= 32'd0; 
   else
       frechange <= frechange + Fword;
end
//��λ�ۼ�����
reg [9:0]romaddr;
always @(posedge clk or negedge rst) begin
   if(!rst)
       romaddr <= 10'd0;
   else
       romaddr <= frechange[31:22] + Pword;
end
//IP��-------ROM���Ҳ���
rom_sin romsin (
  .clka(clk),       // input wire clka
  .addra(romaddr),  // input wire [9 : 0] addra
  .douta(sindata)      // output wire [9 : 0] douta
);
//�������β�������
reg [31:0] phaseacc;
always @(posedge clk or negedge rst) begin
	if(!rst) 
	   phaseacc <= 32'b0;
	else 
	   phaseacc <= phaseacc+Fword;
end
wire [31:0] phase=phaseacc+Pword;
//������
assign squdata = phase[31] ? 10'd1023:10'd0;
//���ǲ���
assign tridata = phase[31]? (~phase[30:21]): phase[30:21];
//��ݲ���
assign sawdata = phase[31:22];
//����ѡ��
always @(*) begin
	case(s_wave)
		2'b00: wavedata<= sindata;	
		2'b01: wavedata<= squdata;	
		2'b10: wavedata<= sawdata;
		default: wavedata<= sindata;
	endcase
end
//���ȱ任
always @(*) begin
	case(s_A)
		2'b00: Aword<= 10'd100;	
		2'b01: Aword<= 10'd256;	
		2'b10: Aword<= 10'd128;	
		//2'b11: Aword<= 10'd64;	
		default: Aword<= 10'd100;
	endcase
end

//Ƶ�ʱ任
always @(*) begin
	case(s_F)
		2'b00: Fword <= 32'd1617728;
		2'b01: Fword<= 32'd74217728;	
		2'b10: Fword<= 32'd234217728;	
		//2'b11: Fword<= 32'd134217;	
		default: Fword<= 32'd134217728;
	endcase
end
//���α任
wire [9:0] data;
assign data = wavedata;
reg [19:0] AMdata;
always@(posedge clk)
   if(!rst)
       AMdata<=1'd0;
   else
       AMdata<=data*Aword;
assign dataout = AMdata[19:10];
endmodule
