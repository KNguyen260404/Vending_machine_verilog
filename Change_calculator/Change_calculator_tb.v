module change_calculator_tb;
    // Tín hiệu đầu vào
    reg clk;
    reg reset;
    reg [4:0] current_amount;
    reg [4:0] product_price;
    reg calculate;
    
    // Tín hiệu đầu ra
    wire [4:0] change_amount;
    wire valid_transaction;
    
    // Khởi tạo module kiểm tra
    change_calculator uut (
        .clk(clk),
        .reset(reset),
        .current_amount(current_amount),
        .product_price(product_price),
        .calculate(calculate),
        .change_amount(change_amount),
        .valid_transaction(valid_transaction)
    );
    
    // Tạo file VCD để xem waveform
    initial begin
        $dumpfile("change_calculator_tb.vcd");
        $dumpvars(0, change_calculator_tb);
    end
    
    // Tạo tín hiệu đồng hồ
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Chu kỳ đồng hồ 10ns
    end
    
    // Kịch bản kiểm tra
    initial begin
        // Khởi tạo
        reset = 1;
        current_amount = 5'd0;
        product_price = 5'd0;
        calculate = 0;
        #20;
        
        // Giải phóng reset
        reset = 0;
        #10;
        
        // Trường hợp 1: Đủ tiền (25₫ mua sản phẩm 15₫)
        current_amount = 5'd25;
        product_price = 5'd15;
        calculate = 0;
        #10;
        calculate = 1;  // Kích hoạt tính toán
        #10;
        calculate = 0;
        #20;
        
        // Trường hợp 2: Vừa đủ tiền (20₫ mua sản phẩm 20₫)
        current_amount = 5'd20;
        product_price = 5'd20;
        #10;
        calculate = 1;
        #10;
        calculate = 0;
        #20;
        
        // Trường hợp 3: Không đủ tiền (10₫ mua sản phẩm 15₫)
        current_amount = 5'd10;
        product_price = 5'd15;
        #10;
        calculate = 1;
        #10;
        calculate = 0;
        #20;
        
        // Trường hợp 4: Kiểm tra reset
        reset = 1;
        #10;
        reset = 0;
        #10;
        
        // Trường hợp 5: Số tiền lớn (30₫ mua sản phẩm 25₫)
        current_amount = 5'd30;
        product_price = 5'd25;
        #10;
        calculate = 1;
        #10;
        calculate = 0;
        #20;
        
        // Kết thúc mô phỏng
        #10;
        $finish;
    end
    
    // Giám sát và hiển thị kết quả
    initial begin
        $monitor("Time=%t, reset=%b, current=%d, price=%d, calc=%b, change=%d, valid=%b", 
                 $time, reset, current_amount, product_price, calculate, 
                 change_amount, valid_transaction);
    end
endmodule
