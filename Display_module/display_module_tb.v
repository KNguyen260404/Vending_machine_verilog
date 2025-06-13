module display_module_tb;
    // Tín hiệu đầu vào
    reg clk;
    reg reset;
    reg [4:0] current_amount;
    reg [2:0] current_state;
    reg [1:0] product_out;
    reg [4:0] change_out;
    
    // Tín hiệu đầu ra
    wire [7:0] amount_display;
    wire [7:0] status_display;
    wire [3:0] led_indicators;
    
    // Định nghĩa các trạng thái
    parameter IDLE = 3'b000;
    parameter MONEY_DEPOSIT = 3'b001;
    parameter PRODUCT_SELECT = 3'b010;
    parameter DISPENSE_PRODUCT = 3'b011;
    parameter RETURN_CHANGE = 3'b100;
    
    // Khởi tạo module kiểm tra
    display_module uut (
        .clk(clk),
        .reset(reset),
        .current_amount(current_amount),
        .current_state(current_state),
        .product_out(product_out),
        .change_out(change_out),
        .amount_display(amount_display),
        .status_display(status_display),
        .led_indicators(led_indicators)
    );
    
    // Tạo file VCD để xem waveform
    initial begin
        $dumpfile("display_module_tb.vcd");
        $dumpvars(0, display_module_tb);
    end
    
    // Tạo tín hiệu đồng hồ
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Chu kỳ đồng hồ 10ns
    end
    
    // Hàm hiển thị giá trị LED 7-đoạn
    function [7:0] decode_7seg;
        input [7:0] seg;
        begin
            case (seg)
                8'b11111100: decode_7seg = 0; // 0
                8'b01100000: decode_7seg = 1; // 1
                8'b11011010: decode_7seg = 2; // 2
                8'b11110010: decode_7seg = 3; // 3
                8'b01100110: decode_7seg = 4; // 4
                8'b10110110: decode_7seg = 5; // 5
                8'b10111110: decode_7seg = 6; // 6
                8'b11100000: decode_7seg = 7; // 7
                8'b11111110: decode_7seg = 8; // 8
                8'b11110110: decode_7seg = 9; // 9
                default: decode_7seg = 15;    // Không xác định
            endcase
        end
    endfunction
    
    // Kịch bản kiểm tra
    initial begin
        // Khởi tạo
        reset = 1;
        current_amount = 5'd0;
        current_state = IDLE;
        product_out = 2'b00;
        change_out = 5'd0;
        #20;
        
        // Giải phóng reset
        reset = 0;
        #10;
        
        // Kiểm tra trạng thái IDLE
        current_state = IDLE;
        current_amount = 5'd0;
        #20;
        
        // Kiểm tra trạng thái MONEY_DEPOSIT với các số tiền khác nhau
        current_state = MONEY_DEPOSIT;
        current_amount = 5'd5;
        #20;
        current_amount = 5'd10;
        #20;
        current_amount = 5'd15;
        #20;
        
        // Kiểm tra trạng thái PRODUCT_SELECT
        current_state = PRODUCT_SELECT;
        product_out = 2'b01; // Sản phẩm A
        #20;
        
        // Kiểm tra trạng thái DISPENSE_PRODUCT
        current_state = DISPENSE_PRODUCT;
        #20;
        
        // Kiểm tra trạng thái RETURN_CHANGE
        current_state = RETURN_CHANGE;
        change_out = 5'd7;
        #20;
        
        // Kiểm tra reset
        reset = 1;
        #10;
        reset = 0;
        #10;
        
        // Kiểm tra chuyển đổi giữa các trạng thái
        current_state = IDLE;
        #10;
        current_state = MONEY_DEPOSIT;
        current_amount = 5'd12;
        #10;
        current_state = PRODUCT_SELECT;
        #10;
        current_state = DISPENSE_PRODUCT;
        product_out = 2'b10; // Sản phẩm B
        #10;
        current_state = RETURN_CHANGE;
        change_out = 5'd3;
        #10;
        
        // Kết thúc mô phỏng
        #10;
        $finish;
    end
    
    // Giám sát và hiển thị kết quả
    initial begin
        $monitor("Time=%t, reset=%b, state=%d, amount=%d, product=%b, change=%d, amount_display=%d, status_display=%d, led=%b", 
                 $time, reset, current_state, current_amount, product_out, change_out,
                 decode_7seg(amount_display), decode_7seg(status_display), led_indicators);
    end
endmodule
