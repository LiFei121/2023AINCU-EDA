`timescale 1ns / 1ps

module _adderTB();
reg	[3:0]	a,b;
reg		cin;
wire	cout;
wire	[3:0]	sum;
adder t1 (.a(a),.b(b),.cin(cin),.cout(cout),.sum(sum));
integer seed1,seed2,seed3;
initial
begin
    seed1=1;seed2=2;seed3=3;
	a=0;b=0;cin=0;
	repeat(10)
		begin
		#10	a=($random(seed1)/16);b=($random(seed2)/16);cin=($random(seed3)/2);
		end
	#10	$stop;
end
endmodule

