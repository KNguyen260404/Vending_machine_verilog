module display_module (
    input wire clk,
    input wire reset,
    input wire [4:0] current_amount,
    input wire [2:0] current_state,
    input wire [1:0] product_out,
    input wire [4:0] change_out,
    
    output reg [7:0] amount_display,    // 7-đoạn cho số tiền hiện tại
    output reg [7:0] status_display,    // 7-đoạn cho trạng thái
    output reg [3:0] led_indicators     // LED chỉ thị trạng thái
);
    // Định nghĩa các trạng thái
    parameter IDLE = 3'b000;
    parameter MONEY_DEPOSIT = 3'b001;
    parameter PRODUCT_SELECT = 3'b010;
    parameter DISPENSE_PRODUCT = 3'b011;
    parameter RETURN_CHANGE = 3'b100;
    
    // Mã 7-đoạn cho các số từ 0-9 (thực tế)
    // Format: MSB=A, LSB=DP (abcdefgp)
    parameter [7:0] DIGIT_0 = 8'b11111100; // 0: abcdef--
    parameter [7:0] DIGIT_1 = 8'b01100000; // 1: -bc----
    parameter [7:0] DIGIT_2 = 8'b11011010; // 2: ab-de-g-
    parameter [7:0] DIGIT_3 = 8'b11110010; // 3: abcd--g-
    parameter [7:0] DIGIT_4 = 8'b01100110; // 4: -bc--fg-
    parameter [7:0] DIGIT_5 = 8'b10110110; // 5: a-cd-fg-
    parameter [7:0] DIGIT_6 = 8'b10111110; // 6: a-cdefg-
    parameter [7:0] DIGIT_7 = 8'b11100000; // 7: abc-----
    parameter [7:0] DIGIT_8 = 8'b11111110; // 8: abcdefg-
    parameter [7:0] DIGIT_9 = 8'b11110110; // 9: abcd-fg-
    
    // Chuyển đổi số thành hiển thị 7-đoạn
    function [7:0] bcd_to_7seg;
        input [3:0] bcd;
        begin
            case (bcd)
                4'd0: bcd_to_7seg = DIGIT_0;
                4'd1: bcd_to_7seg = DIGIT_1;
                4'd2: bcd_to_7seg = DIGIT_2;
                4'd3: bcd_to_7seg = DIGIT_3;
                4'd4: bcd_to_7seg = DIGIT_4;
                4'd5: bcd_to_7seg = DIGIT_5;
                4'd6: bcd_to_7seg = DIGIT_6;
                4'd7: bcd_to_7seg = DIGIT_7;
                4'd8: bcd_to_7seg = DIGIT_8;
                4'd9: bcd_to_7seg = DIGIT_9;
                default: bcd_to_7seg = 8'h00;
            endcase
        end
    endfunction
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            amount_display <= DIGIT_0;
            status_display <= DIGIT_0;
            led_indicators <= 4'b0000;
        end
        else begin
            // Hiển thị số tiền (chuyển đổi số tiền sang 7-đoạn)
            // Đơn giản hóa: chỉ hiển thị đơn vị
            amount_display <= bcd_to_7seg(current_amount[3:0]);
            
            // Hiển thị trạng thái
            case (current_state)
                IDLE: begin
                    status_display <= DIGIT_0;
                    led_indicators <= 4'b0001;
                end
                MONEY_DEPOSIT: begin
                    status_display <= DIGIT_1;
                    led_indicators <= 4'b0010;
                end
                PRODUCT_SELECT: begin
                    status_display <= DIGIT_2;
                    led_indicators <= 4'b0100;
                end
                DISPENSE_PRODUCT: begin
                    status_display <= DIGIT_3;
                    led_indicators <= 4'b1000;
                end
                RETURN_CHANGE: begin
                    status_display <= DIGIT_4;
                    led_indicators <= 4'b1100;
                end
                default: begin
                    status_display <= DIGIT_0;
                    led_indicators <= 4'b0000;
                end
            endcase
        end
    end
endmodule
