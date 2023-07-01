`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/19 10:39:37
// Design Name: 
// Module Name: Testbench
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


module Testbench(
    );
    reg clk;
    reg rst;
    reg s;
    
    wire MG,CR,MY,MR,CG,CY;		//Ö÷ÂÌ»Æºì£¬ÏçÂÌ»Æºì
	wire gw,sw;
	reg clk1;
	wire [6:0] SG0,SG1;
	wire  [5:0] c;
	always
    begin
	   #10 clk = ~clk;//Ê±ÖÓ
    end
    initial begin
    clk = 1'b0;
    rst = 1'b0;
    s = 1'b0;
    #8
    rst = 1'b1;
    
    #600
    s = 1'b1;
    end
    jiaotongdeng U1(clk,s,rst,MG,CR,MY,MR,CG,CY,SG0,SG1,sw,gw,clk1,c);
endmodule
