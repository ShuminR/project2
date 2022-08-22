module seg_static(
	input 	wire			sys_clk,
	input 	wire 			sys_rst_n,
	output	reg		[5:0]	sel,
	output 	reg 	[7:0]	seg
);

reg 	[24:0]	cnt_wait;
reg		[3:0]	num;
reg 			add_flag;

parameter CNT_MAX = 25'd24_999_999;
parameter SEG_0 = 8'b1100_0000, SEG_1 = 8'b1111_1001,
		  SEG_2 = 8'b1010_0100, SEG_3 = 8'b1011_0000,
		  SEG_4 = 8'b1001_1001, SEG_5 = 8'b1001_0010,
		  SEG_6 = 8'b1000_0010, SEG_7 = 8'b1111_1000,
		  SEG_8 = 8'b1000_0000, SEG_9 = 8'b1001_0000,
		  SEG_A = 8'b1000_1000, SEG_B = 8'b1000_0011,
		  SEG_C = 8'b1100_0110, SEG_D = 8'b1010_0001,
		  SEG_E = 8'b1000_0110, SEG_F = 8'b1000_1110;
parameter IDLE 	= 8'b1111_1111;

always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		cnt_wait <= 25'b0;
	else if(cnt_wait == CNT_MAX)
		cnt_wait <= 25'b0;
	else	
		cnt_wait <= cnt_wait + 1'b1;
		
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		add_flag <= 1'b0;
	else if(cnt_wait == CNT_MAX - 1'b1)
		add_flag <= 1'b1;
	else
		add_flag <= 1'b0;
		
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		num <= 4'd0;
	else if(add_flag <= 1'b1)
		num <= num + 1'b1;
	else 
		num <= num;

always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		sel <= 6'b000000;
	else
		sel <= 6'b111111;
		
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		seg <= IDLE;
	else case(num)
		4'd0 :	seg <= SEG_0 ;
		4'd1 :	seg <= SEG_1 ;
		4'd2 :	seg <= SEG_2 ;
		4'd3 :	seg <= SEG_3 ;
		4'd4 :	seg <= SEG_4 ;
		4'd5 :	seg <= SEG_5 ;
		4'd6 :	seg <= SEG_6 ;
		4'd7 :	seg <= SEG_7 ;
		4'd8 :	seg <= SEG_8 ;
		4'd9 :	seg <= SEG_9 ;
		4'd10:	seg <= SEG_A ;
		4'd11:	seg <= SEG_B ;
		4'd12:	seg <= SEG_C ;
		4'd13:	seg <= SEG_D ;
		4'd14:	seg <= SEG_E ;
		4'd15:	seg <= SEG_F ;
		default: seg <= IDLE;
	endcase
	
endmodule