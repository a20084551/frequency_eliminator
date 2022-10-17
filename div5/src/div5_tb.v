`timescale 1ns/100ps
`define CYCLE 50.0
`define End_CYCLE  50
`define reset 20.0

module div5_tb;
reg clk;
reg rst;
reg [22:0] cycle;
wire [31:0] clk_cnt;
wire [31:0] clk_div5_cnt;

div5 div5(
         .clk           (clk),
         .rst           (rst),
         .clk_cnt       (clk_cnt),
         .clk_div5_cnt  (clk_div5_cnt)
     );

initial
begin
    $fsdbDumpfile("conv.fsdb");
    $fsdbDumpvars(0,div5_tb);
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
        #(`CYCLE/2) clk=!clk;
end

always@(posedge clk)
begin
    cycle = cycle + 1;
    if(cycle == `End_CYCLE)
    begin
        $display("-------------------------------------\n");
        $display("---finish !!---\n");
        $display("clk_cnt = %d\n",clk_cnt);
        $display("clk_div5_cnt = %d\n",clk_div5_cnt);
        $finish;
    end
end

endmodule
