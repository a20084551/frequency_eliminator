module div5(
           input rst,
           input clk,
           output reg [31:0] clk_cnt,
           output reg [31:0] clk_div5_cnt
       );

parameter div5 = 5;
parameter div2 = 2; //div2 = (5-1)/2
reg [2:0] cnt_div5;
reg clk_div5;

always@(posedge clk , posedge rst)
begin
    if(rst)
    begin
        cnt_div5 <= 3'd0;
    end
    else
    begin
        if(cnt_div5 == div5-1)
        begin
            cnt_div5 <= 3'd0;
        end
        else
        begin
            cnt_div5 <= cnt_div5 + 3'd1;
        end
    end
end

always@(posedge clk , posedge rst)
begin
    if(rst)
    begin
        clk_div5 <= 1'd0;
    end
    else
    begin
        if((cnt_div5 == div2-1) | (cnt_div5 == div5-1))
        begin
            clk_div5 <= !clk_div5;
        end
        else
        begin
            clk_div5 <= clk_div5;
        end
    end
end

/*verify*/
always@(posedge clk,posedge rst)
begin
    if(rst)
    begin
        clk_cnt <= 32'd0;
    end
    else
    begin
        clk_cnt <= clk_cnt + 32'd1;
    end
end

always@(posedge clk_div5,posedge rst)
begin
    if(rst)
    begin
        clk_div5_cnt <= 32'd0;
    end
    else
    begin
        clk_div5_cnt <= clk_div5_cnt + 32'd1;
    end
end

endmodule
