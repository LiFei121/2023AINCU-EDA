`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/22 21:58:23
// Design Name: 
// Module Name: SPWM
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


module SPWM(
 
					input        clk,               //systerm clock  50MHz
					input 	     rst_n,
					input        fclock,//Ƶ�������ź�
					input        xclock ,//��λ�����ź�
					input        zclock,//ռ�ձ������ź�
				    input[1:0]f,
				    input[1:0]x,
				    input[1:0]z,
					output   reg pwm,
					output  reg [7:0]CNT,
					output  [9:0]dataout
    );
    
//wire [9:0] dataout;
DDS u0(.clk(clk),.rst(rst_n),.wave(0),.F(0),.A(0),.Pword(0),.dataout(dataout));

reg[7:0]  period; //Ƶ��               //pwm_period = 50MHz/period   5Hz 0.2s
reg[7:0]  h_time;//ռ�ձ�
reg[5:0]  x_time; //��λ
//reg [7:0] CNT;//������
reg[1:0]f1;
reg[1:0]x1;
reg[1:0]z1;
                //duty cycle = h_time/period   0.1s 50%占空�
initial
begin
    period<=8'd100;
    h_time<=dataout;
    x_time<=3'd0;
end
always@(posedge clk)
begin
    h_time<=dataout;
end


always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		CNT <= 0;
	else if(CNT >= (period - 1'd1) )
		CNT <= 0;
	else
		CNT <= CNT + 1'd1;
end


always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		pwm <= 0;
    else                                          //rst_n = 1
    begin
        //if(h_time==0)
        //begin
        //    pwm<=0;
        //end
        //else
        //begin
        if(h_time==99)
        begin
        if(CNT <h_time)
            pwm <= 1;
        else
            pwm <= 0;
        end
        else
        begin
            if(CNT <=h_time)
            pwm <= 1;
        else
            pwm <= 0;
        end
   end
end

/*Ƶ��
always@(posedge fclock or posedge xclock or posedge zclock)
begin
    //CNT<=0;
    case(f)
    2'b00: begin period<=8'd100;h_time<=8'd50;end
	2'b01: begin period<=8'd50;h_time<=8'd25;end	
	2'b10: begin period<=8'd10;h_time<=8'd5;end
	default: begin period<=8'd100;h_time<=8'd50;end
    endcase
    if(xclock)
    begin
    case(x)
    2'b00:begin x_time<=6'd0;period<=8'd100;h_time<=8'd50;end
	2'b01:begin x_time=6'd10;period<=8'd110;h_time<=8'd60;end	
	2'b10:begin x_time=6'd30;period<=8'd130;h_time<=8'd80;end
	default:begin x_time=6'd0;period<=8'd100;h_time<=8'd50;end
    endcase
    end
    else if(zclock)
    begin
    case(z)
    2'b00: h_time=8'd50;	
	2'b01: h_time=8'd25;	
	2'b10: h_time=8'd15;
	default: h_time=8'd50;
    endcase
    end
end*/
endmodule 

