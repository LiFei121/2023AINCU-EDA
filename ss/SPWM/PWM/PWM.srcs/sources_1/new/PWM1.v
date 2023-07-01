`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/22 21:57:48
// Design Name: 
// Module Name: PWM1
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


module PWM1(
                    input        clk,               //systerm clock  50MHz
					input 	     rst_n,
					input        fclock,//频率设置信号
					input        xclock ,//相位设置信号
					input        zclock,//占空比设置信号
				    input[1:0]f,
				    input[1:0]x,
				    input[1:0]z,
					output    pwm1,
					output    pwm2,
					output    pwm3,
					output    pwm4,
					
					//output    [7:0]CNT2,
					//output    [7:0]CNT2,
					//output    [7:0]CNT3,
					//output    [7:0]CNT4
					output    [9:0]dataout
    );
    
wire [7:0]CNT1;
wire[7:0]CNT2;
wire [7:0]CNT3;
wire [7:0]CNT4;
//wire [9:0]dataout;
reg [19:0]count=0; 
reg [30:0]count2=0; 
reg [2:0] sel=0; 
parameter T1MS=50000;


//仿真
//wire clk1;
//assign clk1=clk;
//板子
reg clk1;
always @(posedge clk)
	begin count2=count2+1;
		if(count2/100000%2==1)	begin clk1=1'b1; count2=0;end
		else clk1=1'b0;
	end
    
    
    
//频率变换
pwm_gen U1(.clk(clk),.rst_n(rst_n),.fclock(fclock),.xclock(0),.zclock(0),.f(f),.x(x),.z(z),.pwm(pwm1),.CNT(CNT1));
//相位变换
pwm_gen U2(.clk(clk),.rst_n(rst_n),.fclock(0),.xclock(xclock),.zclock(0),.f(f),.x(x),.z(z),.pwm(pwm2),.CNT(CNT2));
//占空比变换
pwmz U3(.clk(clk),.rst_n(rst_n),.fclock(0),.xclock(0),.zclock(zclock),.f(f),.x(x),.z(z),.pwm(pwm3),.CNT(CNT3));

//SPWM
SPWM U4(.clk(clk),.rst_n(rst_n),.fclock(0),.xclock(0),.zclock(0),.f(0),.z(0),.x(0),.pwm(pwm4),.CNT(CNT4),.dataout(dataout));

ila_0 U5 (
	.clk(clk), // input wire clk


	.probe0(pwm1), // input wire [0:0]  probe0  
	.probe1(pwm2), // input wire [0:0]  probe1 
	.probe2(pwm3), // input wire [0:0]  probe2 
	.probe3(pwm4), // input wire [0:0]  probe3
	.probe4(dataout)
);

endmodule

