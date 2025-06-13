module money_counter (
    input wire clk,
    input wire reset,
    input wire [1:0] coin_in,    // 00: no coin, 01: 1₫, 10: 5₫, 11: 10₫
    output reg [4:0] total_amount
);
    // Định nghĩa giá trị tiền
    parameter COIN_1 = 5'd1;
    parameter COIN_5 = 5'd5;
    parameter COIN_10 = 5'd10;
    
    // SỬA: Thêm edge detection để chỉ đếm 1 lần cho mỗi coin
    reg [1:0] coin_in_prev;
    wire coin_inserted = (coin_in != 2'b00) && (coin_in_prev == 2'b00);
    
    always @(posedge clk) begin
        if (reset) begin
            total_amount <= 5'd0;
            coin_in_prev <= 2'b00;
        end
        else begin
            coin_in_prev <= coin_in;
            
            // CHỈ cộng tiền khi phát hiện EDGE (từ 00 -> coin)
            if (coin_inserted) begin
                case (coin_in)
                    2'b01: begin
                        if (total_amount <= 5'd30)
                            total_amount <= total_amount + COIN_1;
                    end
                    2'b10: begin
                        if (total_amount <= 5'd26)
                            total_amount <= total_amount + COIN_5;
                    end
                    2'b11: begin
                        if (total_amount <= 5'd21)
                            total_amount <= total_amount + COIN_10;
                    end
                endcase
            end
        end
    end
endmodule
