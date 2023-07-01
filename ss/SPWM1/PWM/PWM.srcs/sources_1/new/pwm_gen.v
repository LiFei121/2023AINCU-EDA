`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/22 21:56:59
// Design Name: 
// Module Name: pwm_gen
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

//PWM����������ģ��
module pwm_gen(
					input        clk,//systerm clock  50MHz
					input 	     rst_n,
					input        fclock,//Ƶ�������ź�
					input        xclock ,//��λ�����ź�
					input        zclock,//ռ�ձ������ź�
				    input[1:0]f,//Ƶ�������ź�
				    input[1:0]x,//��λ�����ź�
				    input[1:0]z,//ռ�ձ������ź�
					output reg   pwm,//PWM���
					output reg [7:0]CNT//������
		                                        //two channel pwm output
                 );
reg[7:0]  period; //Ƶ��               //pwm_period = 50MHz/period   5Hz 0.2s
reg[7:0]  h_time;//ռ�ձ�
reg[5:0]  x_time; //��λ
//reg [7:0] CNT;//������
reg[1:0]f1;//Ƶ�ʼ����м����
reg[1:0]x1;//��λ�����м����
reg[1:0]z1;//ռ�ձȼ����м����
//�����źų�ֵ
initial
begin
    period<=8'd100;
    h_time<=8'd50;
    x_time<=3'd0;
end
//ʹ�ü�����������ݲ�
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		CNT <= 0;
	else if(CNT >= (period - 1'd1) )
		CNT <= 0;
	else
		CNT <= CNT + 1'd1;
end

//����PWM�ź�
always@(posedge clk or negedge rst_n or posedge fclock or posedge xclock or posedge zclock)
begin
	if(!rst_n)
		pwm <= 0;
    else                                          //rst_n = 1
    begin
    if(fclock || xclock || zclock)//�任�ź�ʱ��Ҫ����
    begin
        CNT<=0;
        pwm<=0;
    end
    else
    begin
        if(CNT <=(h_time - 1)&&(CNT>=x_time))
            pwm <= 1;
        else
            pwm <= 0;
   end
   end
end

//Ƶ��
//����Ƶ��1��2��3
always@(posedge fclock)
begin
    //CNT<=0;
    case(f)
    2'b00: begin period<=8'd100;h_time<=8'd50;end
	2'b01: begin period<=8'd50;h_time<=8'd25;end	
	2'b10: begin period<=8'd10;h_time<=8'd5;end
	default: begin period<=8'd100;h_time<=8'd50;end
    endcase
end
//������λ
//1��2��3
always@(posedge xclock)
begin
    case(x)
    2'b00:begin x_time<=6'd0;period<=8'd100;h_time<=8'd50;end
	2'b01:begin x_time=6'd10;period<=8'd110;h_time<=8'd60;end	
	2'b10:begin x_time=6'd30;period<=8'd130;h_time<=8'd80;end
	default:begin x_time=6'd0;period<=8'd100;h_time<=8'd50;end
    endcase
end
//����ռ�ձ�
//1��2��3
always@(posedge zclock)
begin
 case(z)
    2'b00: h_time=8'd50;	
	2'b01: h_time=8'd25;	
	2'b10: h_time=8'd15;
	default: h_time=8'd50;
	endcase
end
endmodule 

