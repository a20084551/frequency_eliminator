module divider7(
    input rst,
    input clk,
    output reg [31:0] v_clk_cnt,
    output reg [31:0] v_nclk_cnt
);

enum {idle,div4,delay1,div5} c_state,n_state;

reg [1:0] cnt_div4;
reg [2:0] clk_div4_cnt;
reg clk_div4;

reg [2:0] cnt_div5;
reg [2:0] clk_div5_cnt;
reg clk_div5;

wire new_clk;

/***controller***/
always_ff @ (posedge clk , posedge rst)begin 
    if(rst) begin 
        c_state <= idle;
    end else begin
        c_state <= n_state;
    end
end

always @ (*) begin
    case(c_state)
        idle : begin 
            if(rst)begin
                n_state = idle;
            end else begin 
                n_state = div4;
            end
        end

        div4 : begin 
            if(clk_div4_cnt == 3'd4)begin 
                n_state = div5;
            end else begin
                n_state = div4;
            end
        end

        div5 : begin 
            if((clk_div5_cnt == 3'd5) & (cnt_div5 == 3'd4))begin 
                n_state = div4;
            end else begin 
                n_state = div5;
            end
        end

        default : begin
            n_state = idle;
        end
    endcase
end

/***div4 state***/
always_ff @ (posedge clk , posedge rst)begin 
    if(rst)begin 
        cnt_div4 <= 2'd0;
    end else begin 
        if(c_state == div4)begin 
            cnt_div4 <= cnt_div4 + 2'd1;
        end else begin 
            cnt_div4 <= 2'd0;
        end
    end
end

always_ff @ (posedge clk , posedge rst)begin 
    if(rst) begin 
        clk_div4_cnt <= 3'd0;
    end else begin 
        if(c_state == div4)begin 
            if(cnt_div4 == 2'd3)begin 
                clk_div4_cnt <= clk_div4_cnt + 3'd1;
            end else begin 
                clk_div4_cnt <= clk_div4_cnt;
            end
        end else begin 
            clk_div4_cnt <= 3'd0;
        end
    end
end

always_ff @ (posedge clk , posedge rst)begin
    if(rst) begin
        clk_div4 <= 1'd0;
    end else begin 
        if(c_state == div4)begin
            if((cnt_div4 == 2'd3) | (cnt_div4 == 2'd1)) begin 
                clk_div4 <= !clk_div4;
            end else begin 
                clk_div4 <= clk_div4;
            end
        end else begin
            clk_div4 <= 1'd0;
        end
    end
end

/***div5 state***/
always@(posedge clk , posedge rst)begin
    if(rst) begin
        cnt_div5 <= 3'd0;
    end else begin 
        if(n_state == div5)begin 
            if(cnt_div5 == 3'd4)begin
                cnt_div5 <= 3'd0;
            end else begin 
                cnt_div5 <= cnt_div5 + 3'd1;
            end
        end else begin 
            cnt_div5 <= 3'd0;
        end
    end
end

always@(posedge clk_div5, posedge rst)begin 
    if(rst) begin 
        clk_div5_cnt <= 3'd0;
    end else begin 
        if(c_state == div5)begin 
            clk_div5_cnt <= clk_div5_cnt + 3'd1;
        end else begin 
            clk_div5_cnt <= 3'd0;
        end
    end
end

always_ff @ (posedge clk , posedge rst) begin
    if(rst) begin
        clk_div5 <= 1'd0;
    end else begin 
        if(c_state == div5)begin 
            if((cnt_div5 == 3'd1) | (cnt_div5 == 3'd4)) begin
                clk_div5 <= !clk_div5;
            end else begin 
                clk_div5 <= clk_div5;
            end
        end else begin 
            clk_div5 <= 1'd0;
        end
    end
end

/*new clock*/
assign new_clk = clk_div4 | clk_div5;
 
/*verify*/
always@(posedge clk,posedge rst)begin 
    if(rst) begin 
        v_clk_cnt <= 32'd0;
    end else begin 
        v_clk_cnt <= v_clk_cnt + 32'd1;
    end
end

always@(posedge new_clk,posedge rst)begin 
    if(rst) begin 
        v_nclk_cnt <= 32'd0;
    end else begin 
        v_nclk_cnt <= v_nclk_cnt + 32'd1;
    end
end

endmodule