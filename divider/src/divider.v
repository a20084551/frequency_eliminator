module divider(
           input clk,
           input rst
       );

parameter div4 = 4;
parameter div2 = 2;

reg [2:0] cnt;
reg clk_div4;

always @ (posedge clk,posedge rst)
begin
    if(rst)
    begin
        cnt <= 3'd0;
    end
    else
    begin
        if(cnt == div4-1)
        begin
            cnt <= 3'd0;
        end
        else
        begin
            cnt <= cnt + 3'd1;
        end
    end
end

always @ (posedge clk , posedge rst)
begin
    if(rst)
    begin
        clk_div4 <= 1'd0;
    end
    else
    begin
        if( (cnt == div2-1) | (cnt == div4-1))
        begin
            clk_div4 <= ~clk_div4;
        end
        else
        begin
            clk_div4 <= clk_div4;
        end
    end
end

endmodule
