`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/15 10:04:05
// Design Name: 
// Module Name: adder_TB
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


module	adder_TB();
reg	a,b;
reg	cin;
wire	cout;
wire	sum;
adder_ u1 (.a(a),.b(b),.cin(cin),.cout(cout),.sum(sum));

initial
begin
#0	a=0;b=0;cin=0;
#10	a=0;b=1;
#10	a=1;b=0;
#10	a=1;b=1;
#00	a=0;b=0;cin=1;
#10	a=0;b=1;
#10	a=1;b=0;
#10	a=1;b=1;
end


endmodule
