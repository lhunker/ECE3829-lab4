`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:58:15 10/09/2014 
// Design Name: 
// Module Name:    lab4 
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
module lab4(
    input [2:0] sw,
    input clk,
    input reset,
	 input rx,
	 output tx,
    output [6:0] seg,
    output [3:0] anode,
    output HS,
    output VS,
    output [2:0] red,
    output [2:0] grn,
    output [1:0] blu
    );
	 
	wire[15:0] segin;
	wire [4:0] xpos;
	wire [3:0] ypos;
	wire [7:0] rgb;
	microblaze mcs (
	  .Clk(clk), // input Clk
	  .Reset(reset), // input Reset
	  .UART_Rx(rx), // input UART_Rx
	  .UART_Tx(tx), // output UART_Tx
	  .GPO1({xpos, ypos}), // output [8 : 0] GPO1 - block position
	  .GPO2(rgb), // output [7 : 0] GPO2 - color rgb
	  .GPO3(segin), // output [15 : 0] GPO3 - seg
	  .GPI1(sw), // input [2 : 0] GPI1 - sw
	  .GPI1_Interrupt() // output GPI1_Interrupt
	);
	
	wire clk_25m, clk_10m;
	dcm_25_10 dcm
		(// Clock in ports
		 .CLK_IN1(clk),      // IN
		 // Clock out ports
		 .CLK_OUT1(clk_25m),     // OUT
		 .CLK_OUT2(clk_10m),     // OUT
		 // Status and control signals
		 .RESET(reset));       // IN
		 
	seven_seg s1 (.in(segin), .seg(seg), .anodes(anode), .clk(clk_10m));

	wire [10:0] hcount;
	wire [10:0] vcount;
	wire blank;
	vga_controller_640_60 vga1 (.rst(reset), .pixel_clk(clk_25m), .HS(HS), .VS(VS), .hcount(hcount), .vcount(vcount), .blank(blank));

	//Add x, y to vga here

endmodule
