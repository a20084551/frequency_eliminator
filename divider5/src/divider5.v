module divider5(
           input clk,
           input rst
       );

parameter div3 = 3;
parameter div1 = 1; //div1= (div3-1)/2

reg [1:0] cnt;
reg clk_div3_pos,clk_div3_neg;
wire clk_div3_50;

always@(posedge clk , posedge rst)
begin
    if(rst)
    begin
        cnt <= 2'd0;
    end
    else
    begin
        if(cnt == div3-1)
        begin
            cnt <= 2'd0;
        end
        else
        begin
            cnt <= cnt + 2'd1;
        end
    end
end

always@(posedge clk, posedge rst)
begin
    if(rst)
    begin
        clk_div3_pos <= 1'd0;
    end
    else
    begin
        if((cnt == div1) | (cnt == div3-1))
        begin
            clk_div3_pos <= !clk_div3_pos;
        end
        else
        begin
            clk_div3_pos <= clk_div3_pos;
        end
    end
end

always@(negedge clk, posedge rst)
begin
    if(rst)
    begin
        clk_div3_neg <= 1'd0;
    end
    else
    begin
        if((cnt == div1) | (cnt == div3-1))
        begin
            clk_div3_neg <= !clk_div3_pos;
        end
        else
        begin
            clk_div3_neg <= clk_div3_pos;
        end
    end
end

assign clk_div3_50 = clk_div3_pos | clk_div3_neg;

endmodule
