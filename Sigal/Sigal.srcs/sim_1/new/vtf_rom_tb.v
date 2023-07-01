`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/02 15:28:23
// Design Name: 
// Module Name: vtf_rom_tb
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


`timescale 1ns / 1ps

module vtf_rom_tb;
// Inputs
reg sys_clk;
reg rst_n;
wire [7:0] rom_data;	  //ROM读出数据
wire [4:0] rom_addr; 

// Instantiate the Unit Under Test (UUT)
rom_test uut (
	.sys_clk(sys_clk), 		
	.rst_n(rst_n),
	.rom_data(rom_data),
	.rom_addr(rom_addr)
);

initial 
begin
	// Initialize Inputs
	sys_clk = 0;
	rst_n = 0;

	// Wait 100 ns for global reset to finish
	#100;
      rst_n = 1;       

 end

always #10 sys_clk = ~ sys_clk;   //20ns一个周期，产生50MHz时钟源
   
endmodule