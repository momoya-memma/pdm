`timescale 1ns/1ps

module sim_result;/*このモジュール名がsim実行結果のファイル名になる。*/
  reg clk ;/*テストベンチ内で使用するレジスタを宣言する*/
  reg ck_rst;
  wire out_sig;


  parameter CYC = 10;/*10ns = 100MHz*/

  always #(CYC/2) clk=~clk;

  top_module top_module ( /*sim対象のモジュールをdutという名前でインスタンス化*/
    .out_sig (out_sig)/*モジュールのポートCLK100MHZに（）の中身の値を対応づける*/
    , .ck_rst (ck_rst)
    , .CLK100MHZ (clk)
  );

  initial begin
    $dumpfile("sim_result.vcd"); // vcd file name
    $dumpvars(0,sim_result);     // dump targetは「全部」

    // Initilai value
    #(CYC* 0)   clk=0;ck_rst=0;

    // Set seed
    #(CYC*10)   ck_rst=1'b1;   //







    // Stop simulation
	//#(CYC*110000000)   $finish;
	#(CYC*11000000)   $finish;
  end
  
endmodule
