module Change_calculator (
    input wire clk,
    input wire reset,
    input wire [4:0] current_amount,
    input wire [4:0] product_price,
    input wire calculate,
    
    output reg [4:0] change_amount,
    output reg valid_transaction
);
    
    always @(posedge clk) begin
        if (reset) begin
            change_amount <= 5'd0;
            valid_transaction <= 1'b0;
        end
        else if (calculate) begin
            // SỬA: Logic rõ ràng hơn
            if (product_price > 5'd0 && current_amount >= product_price) begin
                // GIAO DỊCH THÀNH CÔNG - tính tiền thừa
                change_amount <= current_amount - product_price;
                valid_transaction <= 1'b1;
            end
            else begin
                // HỦY GIAO DỊCH hoặc KHÔNG ĐỦ TIỀN - trả lại toàn bộ
                change_amount <= current_amount;
                valid_transaction <= 1'b0;
            end
        end
        // SỬA: Không reset change_amount khi không calculate
        // Giữ nguyên giá trị để testbench có thể đọc được
    end
endmodule


