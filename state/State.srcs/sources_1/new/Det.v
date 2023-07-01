`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/03 15:11:09
// Design Name: 
// Module Name: Det
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

//检测序列模块
module Det(clk1,clr2,en,f,m,s,seq);

input clk1,clr2,en;//输信号
input f;				//当前序列输出
output m;			//指示灯
output reg [4:0]  s;
output reg seq;//输出序列
reg m;
parameter [4:0]  q1=5'b10101;//10101;	//要检测的序列
reg[2:0] q2;//储存检测阶段
reg[4:0] z=5'b00000;
always @(posedge clk1 or negedge  clr2)
	begin
		if(~clr2)begin q2<=0;m<=0; //清除检测序列
	end
	else if(en)
		case(q2)
		//状态机
		//第一阶段
		0:if(f==q1[4]) 
		begin q2<=1;//进入第二阶段
		m<=0;
		end
		else 	
		begin q2<=0;
		 m<=0;
		end 
		//第二阶段			
		1:if(f==q1[3]) 
		begin q2<=2;//进入第三阶段
		m<=0;
		end 
		else  	
		begin 
		q2<=1;//回到第一阶段
		m<=0;
		end 	
		//第三阶段					
		2:if(f==q1[2]) 
		begin q2<=3;//进入第四阶段
		m<=0;
		end 
		else  	
		begin 
		q2<=0;//回到第一阶段
		m<=0;
		end 
		//第四阶段
		3:if(f==q1[1]) 
		begin q2<=4;//进入第五阶段
		m<=0;
		end
		else  	
		begin q2<=1;//回到第二阶段
        m<=0;					  
		end 
        //第五阶段								
		4:if(f==q1[0]) 
		begin q2<=3;//回到第四阶段
		m<=1;
		end 
		else 	begin 
		q2<=0;//回到第一阶段
		m<=0;
		end 				
		default: q2<=0;
		endcase		
    end
    //产生输出序列
	always @(posedge clk1 or negedge clr2)
		if(!clr2)//清零	
			begin
				z<=0;
				s<=0;
				seq <=z[0];//输出序列清零
			end
		else if(en)//使能
				begin
					z[4:1]=z[3:0];
					z[0]=f;
					s<=z; 
					seq = z[0];//输出输出序列
				end
endmodule

