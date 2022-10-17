`define cnt_bit 32
module divider6(
           input clk,
           input rst,
           output reg [`cnt_bit-1:0] clk_div_cnt,
           output reg [`cnt_bit-1:0] clk_cnt
       );

reg [`cnt_bit-1:0] cnt;
reg clk_div;

always@(posedge clk,posedge rst)
begin
    if(rst)
    begin
        cnt <= `cnt_bit'd0;
    end
    else
    begin
        cnt <= cnt + `cnt_bit'd1288490189;
    end
end

always@(posedge clk , posedge rst)
begin
    if(rst)
    begin
        clk_div <= 1'd0;
    end
    else
    begin
        if(cnt <= `cnt_bit'd2147483648)
        begin
            clk_div <= 1'd0;
        end
        else if(cnt > `cnt_bit'd2147483648)
        begin
            clk_div <= 1'd1;
        end
    end
end

/*verify*/
always@(posedge clk_div, posedge rst)
begin
    if(rst)
    begin
        clk_div_cnt <= `cnt_bit'd0;
    end
    else
    begin
        clk_div_cnt <= clk_div_cnt + `cnt_bit'd1;
    end
end

always@(posedge clk, posedge rst)
begin
    if(rst)
    begin
        clk_cnt <= `cnt_bit'd0;
    end
    else
    begin
        clk_cnt <= clk_cnt + `cnt_bit'd1;
    end
end

endmodule
