`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/18 21:13:25
// Design Name: 
// Module Name: traffic
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

//交通灯模块
module traffic(clk,Traffic_Light,s,sout,rst,count_display,cnt,state,clk1);//,cnt,state,clk1
input clk,s,rst;//clk时钟信号输入，s来车信号（开关），rst复位信号输入（按钮）
output[10:0] count_display;//数码管输出
output[5:0] Traffic_Light;//5-3主  2-0乡 （led*6）
output sout;//sout来车信号显示（led）
output clk1;//分频时钟
output cnt;//cnt交通灯倒数计时
output state;//state交通灯状态
//固定参数
parameter[5:0] MGCR=6'b001100,MYCR=6'b010100,MRCG=6'b100001,MRCY=6'b100010;
reg[5:0] state;//交通灯状态
reg[15:0] cnt;//交通灯倒数
reg[5:0] Traffic_Light;//交通灯输出
reg clk1,sout;//分频时钟、s输出
//设定初始值
initial 
begin
	cnt<=59;
	state<=MGCR;
	Traffic_Light<=MGCR;
 end
//分频时钟：
reg[26:0] clk_cnt;
reg  [2:0]  sel=3'b0;
//always @(posedge clk)
//    begin clk_cnt=clk_cnt+1;
//         if (clk_cnt>20000000) begin clk1=1'b1;  clk_cnt=0;  end
//         else  clk1=1'b0;  //200M分频  0.25s
//    end  

//always @(posedge clk)
//    begin 
//        clk_cnt=clk_cnt+1;
//        if(clk_cnt==100000000)
//            begin
//            clk_cnt=0;
//            clk1=1'b1;
//            end
//        else
//            clk1=1'b0;
//        if(clk_cnt%100000==0) 
//            begin
//            sel=sel+1;
//            if(sel==3) 
//                sel=0;
//            end
//    end
//reg[26:0] clk_cnt;//波形仿真时设置为2分频
//always @(posedge clk)
//    begin clk_cnt=clk_cnt+1;
//         if (clk_cnt==2) begin clk1=1'b1;  clk_cnt=0;  end
//         else  clk1=1'b0;  //2分频
//    end 
//调用显示译码管模块
display SG_display(
    .clk (clk),
    .rst (rst),
    .counter (cnt),
    .count_display (count_display),
    .sel(sel)
);
//s信号
always @(s)
 begin
	if(s==1) sout=1;
	else sout=0;
 end
//状态转移
always @(posedge clk or negedge rst)
 if(!rst)begin state<=MGCR;cnt<=16'd59;end
 else	begin
		case (state)
		//主绿乡红
		MGCR:if (cnt==0) 
				begin 
				 if(s==1)begin Traffic_Light<=MYCR; cnt<=3; state<=MYCR; end
				 else cnt<=59;
				end 	
			  else cnt<=cnt-1;
		//主黄乡红
		MYCR:if (cnt==0)begin Traffic_Light<=MRCG; cnt<=19;state<=MRCG;end
			  else cnt<=cnt-1;
		//主红乡绿
		MRCG:if (cnt==0||s==0) begin Traffic_Light<=MRCY; cnt<=3;state<=MRCY;end  
		     else cnt<=cnt-1;
		//主红乡黄
		MRCY:if (cnt==0) begin Traffic_Light<=MGCR; cnt<=59;state<=MGCR;end 
		     else cnt<=cnt-1;
		//默认主绿乡红
		default: state<=MGCR;
		endcase
	end
endmodule

