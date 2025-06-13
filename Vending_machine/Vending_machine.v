`include "Money_counter.v"
`include "Product_selection.v"
`include "FSM_controller.v"
`include "Change_calculator.v"

module Vending_machine(
    // Đầu vào hệ thống
    input wire clk,                    // Đồng hồ hệ thống 50MHz
    input wire reset,                  // Reset đồng bộ
    input wire [1:0] coin_in,          // Loại tiền xu nhập vào: 00: không có, 01: 1₫, 10: 5₫, 11: 10₫
    input wire [1:0] product_sel,      // Sản phẩm được chọn: 00: không chọn, 01: sản phẩm A (15₫), 10: sản phẩm B (20₫), 11: sản phẩm C (25₫)
    input wire cancel,                 // Tín hiệu hủy giao dịch
    
    // Đầu ra hệ thống
    output wire [4:0] current_amount_display, // Hiển thị số tiền hiện có (0-31₫)
    output wire [1:0] product_out,     // Sản phẩm được xuất: 01: sản phẩm A, 10: sản phẩm B, 11: sản phẩm C
    output wire [4:0] change_out,      // Số tiền thối lại (0-31₫)
    output wire [2:0] state_out        // Trạng thái hiện tại của máy bán hàng
);

    // Dây nội bộ kết nối giữa các module
    wire [4:0] current_amount;         // Tổng số tiền từ Money Counter
    wire [4:0] selected_price;         // Giá sản phẩm từ Product Selection
    wire dispense_command;             // Lệnh xuất sản phẩm từ FSM
    wire calculate_change;             // Lệnh tính toán tiền thừa từ FSM
    wire reset_money;                  // Lệnh reset bộ đếm tiền từ FSM
    wire valid_transaction;            // Tín hiệu giao dịch hợp lệ từ Change Calculator

    // 1. Module đếm tiền
    money_counter money_counter_inst (
        .clk(clk),                        
        .reset(reset | reset_money),      // Kết hợp reset hệ thống và reset từ FSM
        .coin_in(coin_in),                
        .total_amount(current_amount)     
    );
    
    // 2. Module chọn sản phẩm
    product_selection product_selection_inst (
        .clk(clk),                        
        .reset(reset),                    
        .product_sel(product_sel),        
        .selected_price(selected_price)   
    );
    
    // 3. Module điều khiển FSM
    fsm_controller fsm_controller_inst (
        .clk(clk),                        
        .reset(reset),                    
        .coin_in(coin_in),                
        .product_sel(product_sel),        
        .cancel(cancel),                  
        .current_amount(current_amount),  
        .selected_price(selected_price),  
        .valid_transaction(valid_transaction), 
        .current_state(state_out),        
        .dispense_command(dispense_command), 
        .calculate_change(calculate_change), 
        .reset_money(reset_money),        
        .product_out(product_out)         
    );
    
    // 4. Module tính tiền thừa
    change_calculator change_calculator_inst (
        .clk(clk),                        
        .reset(reset),                    
        .current_amount(current_amount),  
        .product_price(selected_price),   
        .calculate(calculate_change),     
        .change_amount(change_out),       
        .valid_transaction(valid_transaction) 
    );
    
    // Kết nối đầu ra hiển thị số tiền
    assign current_amount_display = current_amount;
endmodule
