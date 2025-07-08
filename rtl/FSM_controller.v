module fsm_controller (
    input wire clk,                    // Clock 50MHz
    input wire reset,                  // Reset đồng bộ
    input wire [1:0] coin_in,          // 00: no coin, 01: 1₫, 10: 5₫, 11: 10₫
    input wire [1:0] product_sel,      // 00: no selection, 01: product A (15₫), 10: product B (20₫), 11: product C (25₫)
    input wire cancel,                 // Tín hiệu hủy giao dịch
    input wire [4:0] current_amount,   // Số tiền hiện có (0-31₫)
    input wire [4:0] selected_price,   // Giá sản phẩm được chọn
    input wire valid_transaction,      // Giao dịch hợp lệ
    
    output reg [2:0] current_state,    // Trạng thái hiện tại
    output reg dispense_command,       // Lệnh xuất sản phẩm
    output reg calculate_change,       // Lệnh tính tiền thừa
    output reg reset_money,            // Reset bộ đếm tiền
    output reg [1:0] product_out       // Sản phẩm được xuất
);

    // Định nghĩa trạng thái
    parameter IDLE = 3'b000;           // Chờ nhận tiền
    parameter MONEY_DEPOSIT = 3'b001;  // Đang nhận tiền
    parameter PRODUCT_SELECT = 3'b010;  // Chọn sản phẩm
    parameter DISPENSE_PRODUCT = 3'b011; // Xuất sản phẩm
    parameter RETURN_CHANGE = 3'b100;   // Trả tiền thừa
    
    // SỬA: Thêm biến lưu sản phẩm đã chọn và cờ cancel
    reg [1:0] selected_product;
    reg money_reset_done;
    reg transaction_cancelled; // SỬA: Thêm cờ để theo dõi cancel
    
    // Bộ đếm thời gian (tắt để tránh timeout)
    reg [4:0] timeout_counter;
    wire timeout = 1'b0; // SỬA: TẮT TIMEOUT để tránh treo
    
    reg [2:0] next_state;
    
    // SỬA: Lưu sản phẩm và trạng thái cancel
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            selected_product <= 2'b00;
            money_reset_done <= 1'b0;
            transaction_cancelled <= 1'b0;
        end
        else begin
            current_state <= next_state;
            
            // SỬA: Lưu sản phẩm KHI VỪA ĐỦ TIỀN
            if (current_state == PRODUCT_SELECT && product_sel != 2'b00 && current_amount >= selected_price && !transaction_cancelled) begin
                selected_product <= product_sel;
            end
            // Reset sản phẩm khi về IDLE
            else if (current_state == IDLE) begin
                selected_product <= 2'b00;
                transaction_cancelled <= 1'b0; // Reset cancel flag
            end
            
            // SỬA: Theo dõi trạng thái cancel - NGAY LẬP TỨC
            if (cancel) begin
                transaction_cancelled <= 1'b1;
                selected_product <= 2'b00; // Xóa sản phẩm khi cancel
            end
            
            // Kiểm soát reset money
            if (current_state == IDLE && !money_reset_done) begin
                money_reset_done <= 1'b1;
            end
            else if (current_state != IDLE) begin
                money_reset_done <= 1'b0;
            end
        end
    end
    
    // Khối xử lý trạng thái tiếp theo
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (coin_in != 2'b00)
                    next_state = MONEY_DEPOSIT;
                else
                    next_state = IDLE;
            end
            
            MONEY_DEPOSIT: begin
                if (cancel || timeout)
                    next_state = RETURN_CHANGE;
                else if (product_sel != 2'b00)
                    next_state = PRODUCT_SELECT;
                else
                    next_state = MONEY_DEPOSIT;
            end
            
            PRODUCT_SELECT: begin
                if (cancel || timeout)
                    next_state = RETURN_CHANGE;
                else if (current_amount >= selected_price && product_sel != 2'b00)
                    next_state = DISPENSE_PRODUCT;
                else if (coin_in != 2'b00)
                    next_state = MONEY_DEPOSIT;
                else
                    next_state = PRODUCT_SELECT;
            end
            
            DISPENSE_PRODUCT: begin
                next_state = RETURN_CHANGE;
            end
            
            RETURN_CHANGE: begin
                next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end
    
    // SỬA: Khối xử lý đầu ra
    always @(*) begin
        // Mặc định giá trị
        dispense_command = 1'b0;
        calculate_change = 1'b0;
        reset_money = 1'b0;
        product_out = 2'b00;
        
        case (current_state)
            IDLE: begin
                reset_money = !money_reset_done;
                product_out = 2'b00;
            end
            
            PRODUCT_SELECT: begin
                // SỬA: Chỉ hiển thị sản phẩm khi ĐỦ TIỀN và CHƯA BỊ CANCEL
                if (current_amount >= selected_price && product_sel != 2'b00 && !transaction_cancelled)
                    product_out = product_sel;
            end
            
            DISPENSE_PRODUCT: begin
                dispense_command = 1'b1;
                product_out = selected_product;
            end
            
            RETURN_CHANGE: begin
                calculate_change = 1'b1;
                // SỬA: Nếu bị cancel thì không hiển thị sản phẩm
                if (!transaction_cancelled)
                    product_out = selected_product;
                else
                    product_out = 2'b00;
            end
            
            default: begin
                // Giữ nguyên các giá trị mặc định
            end
        endcase
    end
endmodule