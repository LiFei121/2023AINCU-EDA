`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/17 22:04:04
// Design Name: 
// Module Name: _Cnt_TB
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

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/16 21:54:56
// Design Name: 
// Module Name: sim_CNT
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

module _Cnt_TB();
reg en,RST_n;
reg [4:0]M_SET;
wire [4:0] cnt_count ;
wire [10:0] display_segout;   
wire Led;
reg Mclock;
reg clk1;

initial
    begin
	   clk1= 1'b0;//时钟信号
	   en = 1'b1;//使能端
	   RST_n = 1'b1;//复位清零
	   
	   Mclock = 1'b0;
	   
	   
	   #100;
	   Mclock = 1'b1;
	    M_SET =10'd7;//模值设置为7\
	   #10;
	   Mclock = 1'b0;
	   
	  
	   
	   
	   #350;
	   RST_n=1'b0;//复位清零
	   #5;
	   RST_n=1'b1;
	   #30;
	   en=1'b0;//使能
	   #20;
	   en=1'b1;
	   #20;
	   Mclock = 1'b1;
	   M_SET = 5'd13;//模值设置为13
	   #10
	   Mclock =1'b0;
	   
	   #600;
	   $stop;
	   
    end
always
    begin
	   #10 clk1 = ~clk1;//时钟
    end
_Cnt U1(clk1,en,RST_n,M_SET,Mclock,cnt_count,display_segout,Led);

endmodule
