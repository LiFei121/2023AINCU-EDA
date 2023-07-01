`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/17 22:02:58
// Design Name: 
// Module Name: _Cnt
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


module _Cnt(
    input CLK,          // 时钟输入
    input en ,       // 开关输入，用于计数器使能控制
    input RST_n,      	// 按键输入，用于计数器异步清零
    input [4:0] M_SET,  // 模数设置输入
    input Mclock,
 
    output reg [4:0] cnt_count,
    output reg [10:0] display_segout,
    output reg Led          //输出，用于显示进位状态
);
reg [6:0] BCD_OUT0;  // BCD计数结果输出  
reg [6:0] BCD_OUT1; // BCD计数结果输出  
reg [6:0] BCD_OUT2; // BCD计数结果输出 
reg [6:0] BCD_OUT3; 
reg [4:0] M;       // 计数器模数
wire [3:0] sw;//数码管计数显示十位
wire [3:0] gw;//数码管计数显示个位
wire [3:0]sw1;//数码管模值显示十位
wire [3:0]gw1;//数码管模值显示个位
//改变计数器模值
always@(posedge Mclock)
begin
 M[0]<=M_SET[0];
 M[1]<=M_SET[1];
 M[2]<=M_SET[2];
 M[3]<=M_SET[3];
 M[4]<=M_SET[4];
 //计数器置零
 cnt_count<=5'b0;
end
reg [19:0]count=0;//数码管计数 
reg [30:0]count2=0; //分频计数
reg [2:0] sel=0; //数码管刷新计数
parameter T1MS=50000;//基准频率参数
//多位数码管显示
always@(posedge CLK) 
     begin 
        count<=count+1; 
        if(count==T1MS) 
        begin 
            count<=0; 
            sel<=sel+1; 
            if(sel==3) 
            sel<=0; 
         end 
     end
////仿真
wire clk1;
assign clk1=CLK;
//板子计数频率
//reg clk1;
//always @(posedge CLK)
//	begin count2=count2+1;
//		if(count2/10000000%2==1)	begin clk1=1'b1; count2=0;end
//		else clk1=1'b0;
//	end
////板子数码管显示
always@(posedge CLK ) 
 begin 
    case(sel) 
        0:display_segout<={4'b0111,BCD_OUT0};
        1:display_segout<={4'b1011,BCD_OUT1};
        2:display_segout<={4'b1101,BCD_OUT2};
        3:display_segout<={4'b1110,BCD_OUT3};
        default:display_segout<=11'b1111_1111111; 
    endcase 
 end
 //计数器逻辑
always @(posedge clk1 or negedge RST_n)
begin
    begin
    if(RST_n == 1'b0||(Mclock==1'b1))   // 异步清零
        cnt_count <= 10'd0;
    else if( en== 1'b1)   // 使能控制
        begin
            if(cnt_count<(M-5'b1))
                begin
                    cnt_count<=cnt_count+10'd1;//计数器未达最大值计数加1
                 end
            else
                begin 
                    cnt_count<=5'd0;//计数器最大值后置零
                 end
        end
end       
end
//LED灯显示逻辑
always @(posedge clk1 or negedge RST_n)
begin
if(RST_n==1)//清零
begin
    if(cnt_count ==(M-5'd2))
    begin
        Led=1;//计数器最大值闪烁
    end
    else
        Led=0;//LED未闪烁
end
end
assign sw =cnt_count/10%10;//计算计数器十位
assign gw =cnt_count%10;//计算计数器个位

assign sw1 = M/10%10;//计算模值十位
assign gw1 = M%10;//计算模值个位
//数码管显示
always @(posedge clk1 or negedge RST_n)
    begin
        if(!RST_n)
            begin
            //清零
                BCD_OUT0<=7'b0000001;
                BCD_OUT1<=7'b0000001;
                //BCD_OUT2<=7'b0000001;
            end
         else
            begin
            //显示个位
				case (gw)
						0:BCD_OUT0<=7'b0000001; 1:BCD_OUT0<=7'b1001111;
						2:BCD_OUT0<=7'b0010010; 3:BCD_OUT0<=7'b0000110;
						4:BCD_OUT0<=7'b1001100; 5:BCD_OUT0<=7'b0100100;
						6:BCD_OUT0<=7'b0100000; 7:BCD_OUT0<=7'b0001111;
						8:BCD_OUT0<=7'b0000000; 9:BCD_OUT0<=7'b0000100; 
						default: BCD_OUT0<=7'b0000001;    
				endcase
				//显示十位
				case (sw)
						0:BCD_OUT1<=7'b0000001; 1:BCD_OUT1<=7'b1001111;
						2:BCD_OUT1<=7'b0010010; 3:BCD_OUT1<=7'b0000110;
						4:BCD_OUT1<=7'b1001100; 5:BCD_OUT1<=7'b0100100;
						6:BCD_OUT1<=7'b0100000; 7:BCD_OUT1<=7'b0001111;
						8:BCD_OUT1<=7'b0000000; 9:BCD_OUT1<=7'b0000100; 
						default: BCD_OUT1<=7'b0000001;        
				endcase
				 
			end 
	end
//模值显示模块
always@(posedge Mclock)
begin
//显示个位
case(gw1)
                        0:BCD_OUT2<=7'b0000001; 1:BCD_OUT2<=7'b1001111;
						2:BCD_OUT2<=7'b0010010; 3:BCD_OUT2<=7'b0000110;
						4:BCD_OUT2<=7'b1001100; 5:BCD_OUT2<=7'b0100100;
						6:BCD_OUT2<=7'b0100000; 7:BCD_OUT2<=7'b0001111;
						8:BCD_OUT2<=7'b0000000; 9:BCD_OUT2<=7'b0000100; 
						default: BCD_OUT2<=7'b0000001; 
endcase
//显示十位
case(sw1)
                        0:BCD_OUT3<=7'b0000001; 1:BCD_OUT3<=7'b1001111;
						2:BCD_OUT3<=7'b0010010; 3:BCD_OUT3<=7'b0000110;
						4:BCD_OUT3<=7'b1001100; 5:BCD_OUT3<=7'b0100100;
						6:BCD_OUT3<=7'b0100000; 7:BCD_OUT3<=7'b0001111;
						8:BCD_OUT3<=7'b0000000; 9:BCD_OUT3<=7'b0000100; 
						default: BCD_OUT3<=7'b0000001; 

endcase
end
endmodule