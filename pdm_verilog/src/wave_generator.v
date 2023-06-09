`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/03 22:05:04
// Design Name: 
// Module Name: wave_generator
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


module wave_generator(
    output reg [9:0] out_wave
    , input wire reset
    , input wire clk
    );
    
    parameter max_tap = 10'd1023;
	//parameter count_of_1sec = 100000000;/*100MHz*/
	parameter count_of_1sec = 10000000;/*100MHz*/
	parameter count_limit_of_tapup = count_of_1sec/max_tap;

	reg [27:0]counter_tapup;//max 100Million
    
    always @ (posedge clk) begin
		if(reset == 0) begin
			out_wave <= 0;
			counter_tapup <= 28'b0;
		end else begin
			if(out_wave == max_tap) begin
			end else begin
				if(counter_tapup == count_limit_of_tapup) begin
					counter_tapup <= 28'b0;
					out_wave <= out_wave + 10'b1;
				end else begin
					counter_tapup <= counter_tapup + 28'b1;
				end
			end
		end
	end
   
    
endmodule




