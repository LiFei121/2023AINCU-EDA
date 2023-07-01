`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/18 21:41:50
// Design Name: 
// Module Name: traffic_tb
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


module traffic_tb();

    reg clk,rst,s;
    wire sout;
    wire[5:0]  Traffic_Light;
    wire[5:0] state;
    wire[15:0] cnt;
    
    traffic sim_traffic(
        .clk(clk),
        .rst(rst),
        .s(s),
        .sout(sout),
        .Traffic_Light(Traffic_Light[5:0]),
        .state(state[5:0]),
        .cnt(cnt[15:0])
    );
    initial begin
        clk = 0;
        rst = 1;
        s = 0;
        #3250
        s = 1;
//        #1000
//        s = 0;
    end
    
    always #10  clk = ~clk;





endmodule
