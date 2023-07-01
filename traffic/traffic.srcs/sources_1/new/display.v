`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/18 21:15:25
// Design Name: 
// Module Name: display
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

//数码管显示模块
module display(clk,rst,counter,count_display,sel);
input clk;//时钟信号
input rst;//清零信号
input[15:0] counter;//分频计数
input[2:0] sel;//数码管显示计数
output reg[10:0] count_display;//7段显示译码管
wire[6:0] d1,d2,d3;//百位、十位、个位
assign d1= counter/100;//百位  
assign d2 = counter%100/10;//十位
assign d3= counter%10;//个位
//显示译码管
always @ (posedge clk or negedge rst)begin
    //清零
    if(!rst)begin count_display<= 11'b1111_1111111;end 
	 else begin
	 //数码管1
	 if(sel == 0)
	 begin
        case(d1)
            7'd00   : count_display <= 11'b1011_0000001;    //0
            7'd01   : count_display <= 11'b1011_1001111;    //1  
            7'd02   : count_display <= 11'b1011_0010010;    //2 
            7'd03   : count_display <= 11'b1011_0000110;    //3  
            7'd04   : count_display <= 11'b1011_1001100;    //4  
            7'd05   : count_display <= 11'b1011_0100100;    //5  
            7'd06   : count_display <= 11'b1011_0100000;    //6  
            7'd07   : count_display <= 11'b1011_0001111;    //7  
            7'd08   : count_display <= 11'b1011_0000000;    //8  
            7'd09   : count_display <= 11'b1011_0000100;    //9             
            default : count_display <= 11'b1111_1111111;    //error 
        endcase
        end
        //数码管2
        if(sel == 1)
        begin
        case(d2)
            7'd00   : count_display <= 11'b1101_0000001;    //0
            7'd01   : count_display <= 11'b1101_1001111;    //1  
            7'd02   : count_display <= 11'b1101_0010010;    //2 
            7'd03   : count_display <= 11'b1101_0000110;    //3  
            7'd04   : count_display <= 11'b1101_1001100;    //4  
            7'd05   : count_display <= 11'b1101_0100100;    //5  
            7'd06   : count_display <= 11'b1101_0100000;    //6  
            7'd07   : count_display <= 11'b1101_0001111;    //7  
            7'd08   : count_display <= 11'b1101_0000000;    //8  
            7'd09   : count_display <= 11'b1101_0000100;    //9             
            default : count_display <= 11'b1111_1111111;    //error 
        endcase
        end
        //数码管3
        if(sel == 2)
        begin                      
        case(d3)
            7'd00   : count_display <= 11'b1110_0000001;    //0
            7'd01   : count_display <= 11'b1110_1001111;    //1  
            7'd02   : count_display <= 11'b1110_0010010;    //2 
            7'd03   : count_display <= 11'b1110_0000110;    //3  
            7'd04   : count_display <= 11'b1110_1001100;    //4  
            7'd05   : count_display <= 11'b1110_0100100;    //5  
            7'd06   : count_display <= 11'b1110_0100000;    //6  
            7'd07   : count_display <= 11'b1110_0001111;    //7  
            7'd08   : count_display <= 11'b1110_0000000;    //8  
            7'd09   : count_display <= 11'b1110_0000100;    //9             
            default : count_display <= 11'b1111_1111111;    //error 
        endcase
        end
    end
end
endmodule

