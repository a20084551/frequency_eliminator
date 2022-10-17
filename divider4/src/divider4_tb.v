`timescale 1ns/100ps
`define CYCLE 50.0
`define End_CYCLE  50
`define reset 20.0

module divider_tb;
reg clk;
reg rst;
reg [22:0] cycle;

divider4 d4(
             .clk    (clk),
             .rst    (rst)
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
        $display("-------------------------------------\n");
        $display("---finish !!---\n");
        $display("-------------------------------------\n");
        $finish;
    end
end



endmodule
