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
    input clk,//时钟信号
    input rst,//清零信号
    input wave,//波形选择信号
    input F,//频率
    //input [9:0]Pword,//相位
    input A,//幅度
    input [9:0]Pword,//相位
    output [9:0]dataout//波形数据输出
);
reg [6:0] BCD_OUT0;  // BCD计数结果输出  
reg [6:0] BCD_OUT1; // BCD计数结果输出 
reg [6:0] BCD_OUT2; // BCD计数结果输出 
reg [1:0]s_wave;
reg [1:0]s_F;
reg[1:0]s_A;
//reg [6:0] BCD_OUT3=7'd0; 
reg [1:0]wave1;//波形中间变量
reg [31:0]Fword;//频率中间变量
reg [9:0]Aword;//幅度中间变量
//计数
//波形数据：
reg [9:0] wavedata;
//波形信号:
wire [9:0] sindata;//正弦
wire [9:0] squdata;//方波
wire [9:0] tridata;//三角波
wire [9:0] sawdata;//锯齿波
reg [19:0]count=0; //数码管显示计数
reg [30:0]count2=0; //数码管显示计数
reg [2:0] sel=0; //数码管选择计数
parameter T1MS=50000;//频率参数
//板子
//reg clk1;
//always @(posedge clk)
//	begin count2=count2+1;
//		if(count2/10000000%2==1)	begin clk1=1'b1; count2=0;end
//		else clk1=1'b0;
//		end
//选择频率信号
always @(posedge F or negedge rst)
begin
    //清零
    if(!rst)
    begin
        s_F<=2'b00;//正弦波
    end
    else
    begin
        //设置三个档位
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
//选择幅值
always @(posedge A or negedge rst)
begin
    //清零
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
//选择波形
always @(posedge wave or negedge rst)
begin
    //清零
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
//正弦波形产生：
//相位寄存器：
reg [31:0]frechange; 
 //产生波形数据
always @(posedge clk or negedge rst) begin
   if(!rst)
       frechange <= 32'd0; 
   else
       frechange <= frechange + Fword;
end
//相位累加器：
reg [9:0]romaddr;
always @(posedge clk or negedge rst) begin
   if(!rst)
       romaddr <= 10'd0;
   else
       romaddr <= frechange[31:22] + Pword;
end
//IP核-------ROM正弦波表：
rom_sin romsin (
  .clka(clk),       // input wire clka
  .addra(romaddr),  // input wire [9 : 0] addra
  .douta(sindata)      // output wire [9 : 0] douta
);
//其他波形产生器：
reg [31:0] phaseacc;
always @(posedge clk or negedge rst) begin
	if(!rst) 
	   phaseacc <= 32'b0;
	else 
	   phaseacc <= phaseacc+Fword;
end
wire [31:0] phase=phaseacc+Pword;
//方波：
assign squdata = phase[31] ? 10'd1023:10'd0;
//三角波：
assign tridata = phase[31]? (~phase[30:21]): phase[30:21];
//锯齿波：
assign sawdata = phase[31:22];
//波形选择：
always @(*) begin
	case(s_wave)
		2'b00: wavedata<= sindata;	
		2'b01: wavedata<= squdata;	
		2'b10: wavedata<= sawdata;
		default: wavedata<= sindata;
	endcase
end
//幅度变换
always @(*) begin
	case(s_A)
		2'b00: Aword<= 10'd100;	
		2'b01: Aword<= 10'd256;	
		2'b10: Aword<= 10'd128;	
		//2'b11: Aword<= 10'd64;	
		default: Aword<= 10'd100;
	endcase
end

//频率变换
always @(*) begin
	case(s_F)
		2'b00: Fword <= 32'd1617728;
		2'b01: Fword<= 32'd74217728;	
		2'b10: Fword<= 32'd234217728;	
		//2'b11: Fword<= 32'd134217;	
		default: Fword<= 32'd134217728;
	endcase
end
//波形变换
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
