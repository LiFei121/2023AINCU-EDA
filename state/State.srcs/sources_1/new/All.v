module All(clk,clr,ld,en,m,s,seq);
	input clk,clr,ld;//时钟、清零、序列
	input en;//使能
	output m;//检测成功标志  			
	reg [30:0]cnt;	//分频计数器		 
	output [4:0] s; //状态输出
	output seq;//输出序列
	wire f;//序列中间变量
	//分频器
	reg clk1;
    //调用产生序列模块
	Gen U1(.clk1(clk),.clr1(clr),.en(en),.ld(ld), .f(f));	
	//调用序列检测模块
	Det U2(.clk1(clk), .clr2(clr),.en(en),.f(f), .m(m), .s(s),.seq(seq));	
endmodule 