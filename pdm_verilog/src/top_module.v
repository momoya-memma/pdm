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


module top_module(
    input wire ck_rst
    , input wire CLK100MHZ
	, output wire out_sig
    );

	wire [9:0] wave_signal;
    
	/*元となる波形を生成するモジュール*/
	wave_generator wave_generator(.out_wave(wave_signal)
								, .reset(ck_rst)
								, .clk(CLK100MHZ));

	/*元波形をΔΣ変調し、1bit PDMデータをリアルタイムで生成するモジュール*/
	delta_sigma_modulation delta_sigma_modulation(.input_sig(wave_signal)
												, .reset(ck_rst)
												, .clk(CLK100MHZ)
												, .out_sig(out_sig));		
endmodule




