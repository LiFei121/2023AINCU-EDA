`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/22 22:23:43
// Design Name: 
// Module Name: gen_PWMTB
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


module gen_PWMTB(
    );
reg clk;
reg rst_n;
reg fclock;
reg xclock;
reg zclock;
reg [1:0]f;
reg [1:0]x;
reg [1:0]z;
wire pwm1;
wire pwm2;
wire pwm3;
wire pwm4;
//wire [7:0] CNT1;
//wire [7:0] CNT2;
//wire [7:0] CNT3;
wire [7:0] CNT4;
wire [9:0]dataout;

initial begin
rst_n=0;
clk=0;
fclock=0;
xclock=0;
zclock=0;
f<=2'd0;
x<=2'd0;
z<=2'd0;
#2;
rst_n=1;
#2200;
fclock<=1;
f<=2'd1;
xclock<=1;
x<=2'd1;
zclock<=1;
z<=2'd1;
#2;
fclock<=0;
xclock<=0;
zclock<=0;
#2300;
fclock<=1;
f<=2'd2;
xclock<=1;
x<=2'd2;
zclock<=1;
z<=2'd2;
#2;
fclock<=0;
xclock<=0;
zclock<=0;
end

always #10 clk=~clk;
PWM1 U0(clk,rst_n,fclock,xclock,zclock,f,x,z,pwm1,pwm2,pwm3,pwm4,CNT4,dataout);
endmodule


