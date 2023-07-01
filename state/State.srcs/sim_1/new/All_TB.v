`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/03 15:44:13
// Design Name: 
// Module Name: All_TB
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


module All_TB(
    );
    
    reg clk;
    reg RST_n;//«Â¡„
    reg ld;
    reg en;
    wire Led;
    wire [4:0] s;
   // wire f;
    wire seq;
//assign s = 5'b00000;
    always
    begin
	   #10 clk = ~clk;// ±÷”
    end
    
    initial begin
    clk = 1'b0;
    en = 1'b1;
    ld = 1'b0;
    RST_n = 1'b0;
   
    #12
    RST_n = 1'b1;
    #500
    RST_n = 1'b0;
    #10;
    RST_n = 1'b1;
    end
    All U3(clk,RST_n,ld,en,Led,s,seq);
    
endmodule
