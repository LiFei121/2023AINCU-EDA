`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/19 10:08:16
// Design Name: 
// Module Name: jiaotongdeng
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


module jiaotongdeng(clk,s,rst,MG,CR,MY,MR,CG,CY,SG0,SG1,sw,gw,clk1,c);
    input clk,rst,s;
	output reg MG,CR,MY,MR,CG,CY;		//主绿黄红，乡绿黄红
	output gw,sw,clk1;
	output reg [6:0] SG0,SG1;
	output reg [5:0] c;
	parameter s0=0,s1=1,s2=2,s3=3;
	reg clk1;
	reg [7:0] timCG,timMG,timY;
	//时间
	reg [7:0] tim;
	reg [1:0] cs;
	reg [1:0] next_state;
	reg [30:0] cnt;
	reg [7:0] a;
    reg [3:0]gw,sw;
	
//分频器
	//仿真
	always @(posedge clk)
       begin 
		   cnt=cnt+1;
         if(cnt>1) begin clk1=1'b1;  cnt=0;  end
         else clk1=1'b0;  
		        gw<=tim[3:0];
		        sw<=tim[7:4];
				  c[0]<=CY;c[1]<=CG;c[2]<=CR;
				  c[3]<=MY;c[4]<=MG;c[5]<=MR;			  
        end
	//跑板子，50MHZ-49999999
/*
		always @(posedge clk)
       begin 
		   cnt=cnt+1;
         if(cnt>49999999) begin clk1=1'b1;  cnt=0;  end
         else clk1=1'b0;  
		        gw<=tim[3:0];
		        sw<=tim[7:4];
				  c[0]<=CY;c[1]<=CG;c[2]<=CR;
				  c[3]<=MY;c[4]<=MG;c[5]<=MR;			  
         end
*/	
	//CS状态选择
	always@(cs)
	    case(cs)
	      s0:if(tim=='b0&&s=='b1) next_state<=s1; else next_state<=s0;
	      s1:if(tim=='b0) next_state <=s2; else next_state<=s1;
	      s2:if(tim=='b0||s==0) next_state<=s3; else next_state<=s2;
	      s3:if(tim=='b0) next_state<=s0; else next_state<=s3;
	      default: next_state<=s0;
	    endcase
	//复位	 
	 always@(posedge clk1 or negedge rst)
	    begin
		   if(!rst)
			  cs<=s0;
			else 
			  cs<=next_state;
		 end
	//cs-->此时状态	 
	 always@(negedge clk1)
	    case(cs)
		   s0:begin MY<='b0;MG<='b1;MR<='b0;CG<='b0;CY<='b0;CR<='b1;end		//主绿乡红
			s1:begin MY<='b1;MG<='b0;MR<='b0;CG<='b1;CY<='b0;CR<='b0;end		//主黄乡绿
			s2:begin MY<='b0;MG<='b0;MR<='b1;CG<='b1;CY<='b0;CR<='b0;end		//主红乡绿
			s3:begin MY<='b0;MG<='b0;MR<='b1;CG<='b0;CY<='b1;CR<='b0;end		//主红乡黄
			default:begin MY<='b0;MG<='b1;MR<='b1;CG<='b0;CY<='b0;CR<='b0;end
	    endcase
	//判断	 
    always@(negedge clk1,negedge rst)
        if(!rst)
	       begin timMG<=8'b01011001;timCG<=8'b00011001;timY<=8'b00000011; end	//89，25，3
		  else 
		    begin 
		      case(cs)
		        'b00:begin
				         if(timMG>0)
							  begin 
							    begin if(timMG[3:0]==0) timMG<=timMG-7;
								       else timMG<=timMG-1;
								 end 
								 tim<=timMG;
							  end 
							 else begin tim<=0;timMG<=8'b01011001;
						 end 
						 end 
				  'b01:begin
				         if(timY>0)
							  begin 
							    begin if(timY[3:0]==0) timY<=timY-7;
								       else timY<=timY-1;
								 end 
								 tim<=timY;
							  end 
							 else begin tim<=0;timY<=8'b00000011;
						 end 
						 end 
			     'b10:begin
				         if(timCG>0)
							  begin 
							    begin if(timCG[3:0]==0) timCG<=timCG-7;
								       else timCG<=timCG-1;
								 end 
								 tim<=timCG;
							  end 
							 else begin tim<=0;timCG<=8'b00011001;
						 end 
						 end 
			  	  'b11:begin
				         if(timY>0)
							  begin 
							    begin if(timY[3:0]==0) timY<=timY-7;
								       else timY<=timY-1;
								 end 
								 tim<=timY;;
							  end 
							 else begin tim<=0;timY<=8'b00000011;
						 end 
						 end 
					default:begin 
					          timMG<=8'b01011001;timCG<=8'b00011001;
								 timY<=8'b00000011;tim<=0;
							  end
					endcase 
				end 
    //数码管显示
   always@(posedge clk1)
       begin 
			case(gw)
			0:SG0<=7'b1000000; 1:SG0<=7'b1111001;
            2:SG0<=7'b0100100; 3:SG0<=7'b0110000;
            4:SG0<=7'b0011001; 5:SG0<=7'b0010010;
            6:SG0<=7'b0000010; 7:SG0<=7'b1111000;
            8:SG0<=7'b0000000; 9:SG0<=7'b0010000; //7段译码值
			endcase
			case(sw)
			   0:SG1<=7'b1000000; 1:SG1<=7'b1111001;
            2:SG1<=7'b0100100; 3:SG1<=7'b0110000;
            4:SG1<=7'b0011001; 5:SG1<=7'b0010010;
            6:SG1<=7'b0000010; 7:SG1<=7'b1111000;
            8:SG1<=7'b0000000; 9:SG1<=7'b0010000; //7段译码值
			endcase 	
		 end 
endmodule

