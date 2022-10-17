`timescale 1ns/100ps
`define CYCLE 50.0
`define End_CYCLE  1000 /*simulation 1s*/
`define reset 20.0

module divider_tb;
reg clk;
reg rst;
reg [22:0] cycle;
wire [31:0] clk_div_cnt;
wire [31:0] clk_cnt;

divider6 d6(
             .clk           (clk),
             .rst           (rst),
             .clk_div_cnt   (clk_div_cnt),
             .clk_cnt       (clk_cnt)
         );

initial
begin
    $fsdbDumpfile("conv.fsdb");
    $fsdbDumpvars(0,divider_tb);
end

initial
begin
    clk = 0;
    rst = 1;
    cycle = 0;
end

initial
begin
    #`reset rst = 0;
end

always
begin
    forever
        #(`CYCLE/2) clk=!clk; //T = 1 * 25 * 2 = 50 ns i.e. frequency = 1/50ns = 20 MHZ
end

always@(posedge clk)
begin
    cycle = cycle + 1;
    if(cycle == `End_CYCLE)
    begin
        $display("---finish !!---\n");
        $display("-------------------------------------\n");
        $display("clk_cnt = %d\n",clk_cnt);
        $display("clk_div_cnt = %d\n",clk_div_cnt);
        $finish;
    end
end

endmodule
