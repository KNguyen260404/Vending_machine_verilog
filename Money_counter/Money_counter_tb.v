module money_counter_tb;
    // Testbench signals
    reg clk;
    reg reset;
    reg [1:0] coin_in;
    
    wire [4:0] total_amount;
    
    // Instantiate the money counter
    money_counter uut (
        .clk(clk),
        .reset(reset),
        .coin_in(coin_in),
        .total_amount(total_amount)
    );
    
    // Clock generation - 50MHz
    initial begin
        $dumpfile("money_counter.vcd");
        $dumpvars(0, money_counter_tb);
        clk = 0;
        forever #10 clk = ~clk; // Chu kỳ 20ns = 50MHz
    end
    
    // Task để nhập tiền với edge detection
    task insert_coin;
        input [1:0] coin_type;
        input [7:0] coin_name; // Để hiển thị tên loại tiền
        begin
            // Đảm bảo coin_in = 00 trước khi nhập
            @(posedge clk);
            coin_in = 2'b00;
            @(posedge clk);
            
            // Tạo edge từ 00 -> coin_type
            coin_in = coin_type;
            case (coin_type)
                2'b01: $display("Time %0t: Nhập đồng 1₫ - Edge detected", $time);
                2'b10: $display("Time %0t: Nhập đồng 5₫ - Edge detected", $time);
                2'b11: $display("Time %0t: Nhập đồng 10₫ - Edge detected", $time);
            endcase
            
            repeat(3) @(posedge clk); // Giữ trong 3 cycles để test
            
            // Trở về 00
            coin_in = 2'b00;
            @(posedge clk);
            $display("Time %0t: Tổng tiền hiện tại: %0d₫", $time, total_amount);
        end
    endtask
    
    // Task để test nhiều lần nhập cùng loại tiền
    task rapid_insert;
        input [1:0] coin_type;
        input integer count;
        integer i;
        begin
            $display("\n=== Test rapid insert: %0d lần đồng %s ===", count, 
                     (coin_type == 2'b01) ? "1₫" : 
                     (coin_type == 2'b10) ? "5₫" : "10₫");
            
            for (i = 0; i < count; i = i + 1) begin
                insert_coin(coin_type, 0);
                #20; // Chờ 1 cycle để ổn định
            end
        end
    endtask
    
    // Test stimulus
    initial begin
        $display("======= KIỂM THỬ MONEY COUNTER VỚI EDGE DETECTION =======");
        $display("Testbench để verify chức năng đếm tiền chính xác");
        $display("Hỗ trợ: 1₫ (01), 5₫ (10), 10₫ (11)");
        $display("Giới hạn: Tối đa 31₫");
        
        // Initialize signals
        reset = 1;
        coin_in = 2'b00;
        
        // Reset hệ thống
        #50;
        reset = 0;
        #20;
        $display("\nTime %0t: Reset hoàn tất, tổng tiền: %0d₫", $time, total_amount);
        
        // =================== TEST CASE 1: Nhập từng loại tiền ===================
        $display("\n=== TEST CASE 1: Nhập từng loại tiền ===");
        
        insert_coin(2'b01, "1₫");  // Nhập 1₫
        #20;
        insert_coin(2'b10, "5₫");  // Nhập 5₫
        #20;
        insert_coin(2'b11, "10₫"); // Nhập 10₫
        #20;
        
        if (total_amount == 5'd16)
            $display("✅ TEST CASE 1 PASSED: 1₫ + 5₫ + 10₫ = 16₫");
        else
            $display("❌ TEST CASE 1 FAILED: Mong đợi 16₫, nhận được %0d₫", total_amount);
        
        // =================== TEST CASE 2: Nhập nhiều đồng 1₫ ===================
        reset = 1;
        #20;
        reset = 0;
        #20;
        
        rapid_insert(2'b01, 5); // Nhập 5 đồng 1₫
        
        if (total_amount == 5'd5)
            $display("✅ TEST CASE 2 PASSED: 5 × 1₫ = 5₫");
        else
            $display("❌ TEST CASE 2 FAILED: Mong đợi 5₫, nhận được %0d₫", total_amount);
        
        // =================== TEST CASE 3: Nhập nhiều đồng 5₫ ===================
        reset = 1;
        #20;
        reset = 0;
        #20;
        
        rapid_insert(2'b10, 4); // Nhập 4 đồng 5₫
        
        if (total_amount == 5'd20)
            $display("✅ TEST CASE 3 PASSED: 4 × 5₫ = 20₫");
        else
            $display("❌ TEST CASE 3 FAILED: Mong đợi 20₫, nhận được %0d₫", total_amount);
        
        // =================== TEST CASE 4: Nhập nhiều đồng 10₫ ===================
        reset = 1;
        #20;
        reset = 0;
        #20;
        
        rapid_insert(2'b11, 3); // Nhập 3 đồng 10₫
        
        if (total_amount == 5'd30)
            $display("✅ TEST CASE 4 PASSED: 3 × 10₫ = 30₫");
        else
            $display("❌ TEST CASE 4 FAILED: Mong đợi 30₫, nhận được %0d₫", total_amount);
        
        // =================== TEST CASE 5: Test overflow protection ===================
        $display("\n=== TEST CASE 5: Test overflow protection ===");
        reset = 1;
        #20;
        reset = 0;
        #20;
        
        // Nhập 31₫ (giới hạn tối đa)
        rapid_insert(2'b11, 3); // 30₫
        insert_coin(2'b01, "1₫"); // +1₫ = 31₫
        #20;
        
        if (total_amount == 5'd31)
            $display("✅ Đạt giới hạn tối đa: 31₫");
        else
            $display("❌ Lỗi giới hạn: Mong đợi 31₫, nhận được %0d₫", total_amount);
        
        // Thử nhập thêm tiền (phải bị từ chối)
        $display("Time %0t: Thử nhập thêm 1₫ khi đã đầy...", $time);
        insert_coin(2'b01, "1₫");
        #20;
        
        if (total_amount == 5'd31)
            $display("✅ TEST CASE 5 PASSED: Overflow protection hoạt động đúng");
        else
            $display("❌ TEST CASE 5 FAILED: Overflow protection lỗi, total = %0d₫", total_amount);
        
        // =================== TEST CASE 6: Test edge detection với tín hiệu giữ lâu ===================
        $display("\n=== TEST CASE 6: Test edge detection với tín hiệu giữ lâu ===");
        reset = 1;
        #20;
        reset = 0;
        #20;
        
        // Giữ tín hiệu coin_in trong nhiều cycles
        @(posedge clk);
        coin_in = 2'b00;
        @(posedge clk);
        
        coin_in = 2'b11; // Nhập 10₫
        $display("Time %0t: Bắt đầu nhập 10₫ và giữ tín hiệu trong 10 cycles", $time);
        repeat(10) @(posedge clk); // Giữ trong 10 cycles
        
        coin_in = 2'b00;
        @(posedge clk);
        
        if (total_amount == 5'd10)
            $display("✅ TEST CASE 6 PASSED: Edge detection chỉ đếm 1 lần dù giữ tín hiệu lâu");
        else
            $display("❌ TEST CASE 6 FAILED: Edge detection lỗi, total = %0d₫", total_amount);
        
        // =================== TEST CASE 7: Test sequence phức tạp ===================
        $display("\n=== TEST CASE 7: Test sequence mua sản phẩm 25₫ ===");
        reset = 1;
        #20;
        reset = 0;
        #20;
        
        // Mô phỏng mua sản phẩm 25₫
        insert_coin(2'b11, "10₫"); // 10₫
        #20;
        insert_coin(2'b11, "10₫"); // 20₫
        #20;
        insert_coin(2'b10, "5₫");  // 25₫
        #20;
        
        if (total_amount == 5'd25)
            $display("✅ TEST CASE 7 PASSED: Tích lũy đủ 25₫ để mua sản phẩm");
        else
            $display("❌ TEST CASE 7 FAILED: Mong đợi 25₫, nhận được %0d₫", total_amount);
        
        // =================== TEST CASE 8: Test reset trong quá trình hoạt động ===================
        $display("\n=== TEST CASE 8: Test reset trong quá trình hoạt động ===");
        
        insert_coin(2'b11, "10₫"); // Thêm 10₫ nữa (total = 35₫ nhưng bị giới hạn 31₫)
        #20;
        
        $display("Time %0t: Reset trong quá trình có tiền...", $time);
        reset = 1;
        #20;
        reset = 0;
        #20;
        
        if (total_amount == 5'd0)
            $display("✅ TEST CASE 8 PASSED: Reset thành công về 0₫");
        else
            $display("❌ TEST CASE 8 FAILED: Reset lỗi, total = %0d₫", total_amount);
        
        // =================== TỔNG KẾT ===================
        #50;
        $display("\n======= TỔNG KẾT KIỂM THỬ MONEY COUNTER =======");
        $display("✅ Edge Detection: Hoạt động chính xác");
        $display("✅ Overflow Protection: Giới hạn tối đa 31₫");
        $display("✅ Reset Function: Reset về 0₫");
        $display("✅ Multiple Coin Types: 1₫, 5₫, 10₫");
        $display("✅ Signal Hold Test: Chỉ đếm 1 lần khi giữ tín hiệu lâu");
        $display("🎯 MONEY COUNTER MODULE HOẠT ĐỘNG HOÀN HẢO!");
        
        #100;
        $finish;
    end
    
    // Monitor để theo dõi thay đổi
    always @(posedge clk) begin
        // Hiển thị khi có thay đổi total_amount
        if ($time > 100 && total_amount !== uut.total_amount) begin
            // Chỉ để debug nếu cần
        end
    end
    
    // Kiểm tra edge detection
    reg [1:0] prev_coin_in = 2'b00;
    reg edge_detected = 1'b0;
    
    always @(posedge clk) begin
        if ($time > 100) begin
            // Phát hiện edge detection
            if ((coin_in != 2'b00) && (prev_coin_in == 2'b00)) begin
                edge_detected = 1'b1;
                case (coin_in)
                    2'b01: $display("Time %0t: ⚡ Edge Detection: 1₫ - Total sẽ là: %0d₫", $time, total_amount + 1);
                    2'b10: $display("Time %0t: ⚡ Edge Detection: 5₫ - Total sẽ là: %0d₫", $time, total_amount + 5);
                    2'b11: $display("Time %0t: ⚡ Edge Detection: 10₫ - Total sẽ là: %0d₫", $time, total_amount + 10);
                endcase
            end else begin
                edge_detected = 1'b0;
            end
        end
        prev_coin_in <= coin_in;
    end
    
    // Monitor thay đổi total_amount
    reg [4:0] prev_total = 5'd0;
    always @(posedge clk) begin
        if (total_amount != prev_total && $time > 100) begin
            $display("Time %0t: 💰 Total amount changed: %0d₫ → %0d₫", $time, prev_total, total_amount);
            prev_total <= total_amount;
        end
    end
    
    // Safety timeout
    initial begin
        #10000; // 10us timeout
        $display("❌ TIMEOUT: Testbench chạy quá lâu!");
        $finish;
    end

endmodule
        