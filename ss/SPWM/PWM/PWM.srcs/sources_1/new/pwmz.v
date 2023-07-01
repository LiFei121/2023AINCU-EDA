`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/24 08:43:26
// Design Name: 
// Module Name: pwmz
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


module pwmz(
					input        clk,               //systerm clock  50MHz
					input 	     rst_n,
					input        fclock,//频率设置信号
					input        xclock ,//相位设置信号
					input        zclock,//占空比设置信号
				    input[1:0]f,
				    input[1:0]x,
				    input[1:0]z,
					output reg   pwm,
					output reg [7:0]CNT
		                                        //two channel pwm output
                 );
                 
reg[7:0]  period; //频率               //pwm_period = 50MHz/period   5Hz 0.2s
reg[7:0]  h_time;//占空比
reg[5:0]  x_time; //相位
//reg [7:0] CNT;//计数器
reg[1:0]f1;
reg[1:0]x1;
reg[1:0]z1;
                //duty cycle = h_time/period   0.1s 50%鍗犵┖姣
initial
begin
    period<=8'd100;
    h_time<=8'd50;
    x_time<=3'd0;
    CNT<=0;
end

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		CNT <= 0;
	else begin
	 if(CNT >= (period - 1'd1) )
		CNT <= 8'd0;
	else
		CNT <= CNT + 1'd1;
end
end


always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		pwm <= 0;
    else                                          //rst_n = 1
        begin
            if(CNT <=(h_time - 1)&&(CNT>=x_time))
            pwm <= 1;
        else
            pwm <= 0;
   end
   end

//频率
always@( posedge zclock)
begin
    case(z)
    2'b00: h_time<=8'd50;	
	2'b01: h_time<=8'd25;	
	2'b10: h_time<=8'd15;
	default: h_time<=8'd50;
    endcase
end

endmodule 

