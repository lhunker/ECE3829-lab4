`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:46:10 10/09/2014 
// Design Name: 
// Module Name:    xytovga 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module xytovga(
    input [4:0] x,
    input [3:0] y,
	 input [10:0] hcount,
	 input [10:0] vcount,
    input [7:0] color,
    input blank,
    output [7:0] rgbout
    );
	 
	 parameter black = 8'b0;
	 reg currentspot;
	 
	 always @ (x, y, hcount, vcount)
	 if(32 * x < hcount && 32*(x+1) > hcount &&
			32 * y < vcount && 32 * (y+1) > vcount)
			currentspot = 1'b1;
	 else
			currentspot = 1'b0;
	 
	 assign rgbout = blank ? black : currentspot ? color : black;


endmodule
