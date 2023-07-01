`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/14 07:49:29
// Design Name: 
// Module Name: TB
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
module TB(
    );

reg clock;
reg reset;
reg [7:0] val = 0;            // intialize value to zero
reg[3:0] sel_module;
wire hsync,vsync;                        // hsync and vsync for the working of monitor
wire [3:0]red; 
wire [3:0]green;
wire [3:0]blue;  

always #10000 clock=~clock;
initial begin
reset=0;
clock=0;
sel_module=0;
#2;
reset=1;
end
vga_syncIndex uu(clock,reset,val,sel_module,hsync,vsync,red,green,blue);
endmodule