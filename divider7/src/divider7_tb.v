`timescale 1ns/100ps
`define CYCLE 50.0
`define End_CYCLE  500
`define reset 20.0

module divider_tb;
reg clk;
reg rst;
reg [22:0] cycle;
wire [31:0] v_clk_cnt;
wire [31:0] v_nclk_cnt;

divider7 d7(
             .clk           (clk),
             .rst           (rst),
             .v_clk_cnt     (v_clk_cnt),
             .v_nclk_cnt    (v_nclk_cnt)
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
        #(`CYCLE/2) clk=!clk;
end

always@(posedge clk)
begin
    cycle = cycle + 1;
    if(cycle == `End_CYCLE)
    begin
        $display("---finish !!---");
        $display("-------------------------------------");
        $display("v_clk_cnt = %d",v_clk_cnt);
        $display("v_nclk_cnt = %d",v_nclk_cnt);
        $finish;
    end
end



endmodule
