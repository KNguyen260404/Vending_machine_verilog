module product_selection_tb;
    // Tín hiệu đầu vào
    reg clk;
    reg reset;
    reg [1:0] product_sel;
    
    // Tín hiệu đầu ra
    wire [4:0] selected_price;
    
    // Khởi tạo module kiểm tra
    product_selection uut (
        .clk(clk),
        .reset(reset),
        .product_sel(product_sel),
        .selected_price(selected_price)
    );
    
    // Tạo file VCD để xem waveform
    initial begin
        $dumpfile("product_selection_tb.vcd");
        $dumpvars(0, product_selection_tb);
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
        product_sel = 2'b00;
        #20;
        
        // Giải phóng reset
        reset = 0;
        #10;
        
        // Kiểm tra chọn sản phẩm A (15₫)
        product_sel = 2'b01;
        #20;
        
        // Kiểm tra chọn sản phẩm B (20₫)
        product_sel = 2'b10;
        #20;
        
        // Kiểm tra chọn sản phẩm C (25₫)
        product_sel = 2'b11;
        #20;
        
        // Kiểm tra không chọn sản phẩm
        product_sel = 2'b00;
        #20;
        
        // Kiểm tra reset
        reset = 1;
        #10;
        reset = 0;
        #10;
        
        // Kiểm tra chuyển đổi giữa các sản phẩm
        product_sel = 2'b01; // Sản phẩm A
        #20;
        product_sel = 2'b11; // Sản phẩm C
        #20;
        product_sel = 2'b10; // Sản phẩm B
        #20;
        
        // Kết thúc mô phỏng
        #10;
        $finish;
    end
    
    // Giám sát và hiển thị kết quả
    initial begin
        $monitor("Time=%t, reset=%b, product_sel=%b, selected_price=%d", 
                 $time, reset, product_sel, selected_price);
    end
endmodule
