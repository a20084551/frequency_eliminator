module divider2(
           input clk,
           input rst,
           output reg [1:0] cnt,
           output reg clk_o
       );

parameter div2 = 2;
parameter div1 = 1;

always @(posedge clk, posedge rst)
begin
    if(rst)
    begin
        cnt <= 2'd0;
    end
    else
    begin
        if(cnt == div2-1)
        begin
            cnt <= 2'd0;
        end
        else
        begin
            cnt <= cnt + 2'd1;
        end
    end
end

always@(posedge clk , posedge rst)
begin
    if(rst)
    begin
        clk_o <= 1'd0;
    end
    else
    begin
        if( (cnt == div2-1) | (cnt == div1 -1) )
        begin
            clk_o = ~clk_o;
        end
        else
        begin
            clk_o = clk_o;
        end
    end
end

endmodule
