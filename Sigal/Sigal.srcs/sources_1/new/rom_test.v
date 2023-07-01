`timescale 1ns / 1ps

module rom_test(
	input sys_clk,	//50MHzʱ��
	input rst_n,	//��λ���͵�ƽ��Ч
    output wire[7:0] rom_data,	  //ROM��������
    output reg	 [4:0] rom_addr  
    );

//wire [7:0] rom_data;	  //ROM��������
//reg	 [4:0] rom_addr;      //ROM�����ַ 

//����ROM��ַ��ȡ����
always @ (posedge sys_clk or negedge rst_n)
begin
    if(!rst_n)
        rom_addr <= 10'd0;
    else
        rom_addr <= rom_addr+1'b1;
end        
//ʵ����ROM
rom_ip rom_ip_inst
(
    .clka   (sys_clk    ),      //inoput clka
    .addra  (rom_addr   ),      //input [4:0] addra
    .douta  (rom_data   )       //output [7:0] douta
);
endmodule