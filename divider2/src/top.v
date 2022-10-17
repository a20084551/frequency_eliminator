module top(
           input clk,
           input rst
       );

wire clk_o;
wire clk_div4;
wire [1:0] cnt_d1;
wire [1:0] cnt_d2;

divider2 d1(
             .clk   (clk),
             .rst   (rst),
             .cnt   (cnt_d1),
             .clk_o (clk_o)
         );

divider2 d2(
             .clk   (clk_o),
             .rst   (rst),
             .cnt   (cnt_d2),
             .clk_o (clk_div4)
         );


endmodule
