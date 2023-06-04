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


module delta_sigma_modulation(
    input wire [9:0] input_sig
    , input wire reset
    , input wire clk
	, output reg out_sig
    );
    
    parameter max_tap = 11'd1023;
    //parameter tap_threash = max_tap/2;
	parameter tap_threash = 511;//max_tap/2;
	parameter clk_div = 100;/*1MHz/100 = 1MHz*/
	parameter STATE_UPDATE_Y_CURRENT = 2'd0;
	parameter STATE_UPDATE_PDM_OUT = 2'd1;
	parameter STATE_UPDATE_OUT_SIG = 2'd2;
	parameter STATE_UPDATE_OTHER = 2'd3;

	reg [27:0]counter_tapup;//max 100Million
	reg signed [11:0] y_current;
	reg signed [11:0] y_previous;
	reg signed [11:0] pdm_out_current;
	reg signed [11:0] pdm_out_previous;
	reg [1:0] state;
	reg signed [11:0] input_sig_buf;

	/*このモジュールが受け取るinput_sigは10bitの信号である。
	一方、このモジュール内では、符号+10bitのデータを計算に使用するため、合計11bitサイズのデータ同氏の計算を行う。
	input_sigだけ10bitデータであると正しい演算が行えないため、11bitのinput_sig_bufで受けて、このレジスタを用いて内部演算を行う。*/
	always @ (posedge clk) begin
		if(reset == 0) begin
			input_sig_buf <= 0;
		end else begin
			input_sig_buf <= input_sig[9:0];
		end
	end
		
	
    
    always @ (posedge clk) begin
		if(reset == 0) begin
			out_sig <= 0;
			counter_tapup <= 28'b0;
			y_current <= 12'b0;
			y_previous <= 12'b0;
			pdm_out_current <= 12'b0;
			pdm_out_previous <= 12'b0;
			state <= STATE_UPDATE_Y_CURRENT;
		end else begin
			if(counter_tapup == clk_div) begin
				if(state == STATE_UPDATE_Y_CURRENT) begin
					y_current <= input_sig_buf  - pdm_out_previous + y_previous ;
					state <= STATE_UPDATE_PDM_OUT;
				end else if(state == STATE_UPDATE_PDM_OUT) begin
					if(y_current > tap_threash) begin
						pdm_out_current <= max_tap;
					end else begin
						pdm_out_current <= 12'b0;
					end
					state <= STATE_UPDATE_OUT_SIG;
				end else if(state == STATE_UPDATE_OUT_SIG) begin
					if(pdm_out_current == max_tap) begin
						out_sig <= 1'b1;
					end else begin
						out_sig <= 1'b0;
					end
					state <= STATE_UPDATE_OTHER;
				end else if(state == STATE_UPDATE_OTHER) begin
					y_previous <= y_current;
					pdm_out_previous <= pdm_out_current;
					counter_tapup <= 28'b0;
					state <= STATE_UPDATE_Y_CURRENT;
				end
			end else begin
				counter_tapup <= counter_tapup + 28'b1;
			end
		end
	end


   
    
endmodule




