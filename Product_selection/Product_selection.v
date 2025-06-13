module product_selection (
    input wire clk,
    input wire reset,
    input wire [1:0] product_sel,  // 00: no selection, 01: product A, 10: product B, 11: product C
    output reg [4:0] selected_price
);
    // Định nghĩa giá sản phẩm
    parameter PRODUCT_A_PRICE = 5'd15;
    parameter PRODUCT_B_PRICE = 5'd20;
    parameter PRODUCT_C_PRICE = 5'd25;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            selected_price <= 5'd0;
        end
        else begin
            case (product_sel)
                2'b01: selected_price <= PRODUCT_A_PRICE;
                2'b10: selected_price <= PRODUCT_B_PRICE;
                2'b11: selected_price <= PRODUCT_C_PRICE;
                default: selected_price <= selected_price; // Giữ nguyên giá trị
            endcase
        end
    end
endmodule
