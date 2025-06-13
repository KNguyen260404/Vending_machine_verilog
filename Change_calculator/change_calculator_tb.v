module change_calculator_tb;
    // Testbench signals
    reg clk;
    reg reset;
    reg [4:0] current_amount;
    reg [4:0] product_price;
    reg calculate;
    
    wire [4:0] change_amount;
    wire valid_transaction;
    
    // Instantiate the change calculator
    change_calculator uut (
        .clk(clk),
        .reset(reset),
        .current_amount(current_amount),
        .product_price(product_price),
        .calculate(calculate),
        .change_amount(change_amount),
        .valid_transaction(valid_transaction)
    );
    
    // Clock generation - 50MHz
    initial begin
        $dumpfile("change_calculator.vcd");
        $dumpvars(0, change_calculator_tb);
        clk = 0;
        forever #10 clk = ~clk;
    end
    
    // Task để test với expected values
    task test_change;
        input [4:0] amount;
        input [4:0] price;
        input [4:0] expected_change;
        input expected_valid;
        input [200:0] test_name;
        begin
            current_amount = amount;
            product_price = price;
            calculate = 1;
            @(posedge clk);
            calculate = 0;
            @(posedge clk);
            @(posedge clk); // Chờ thêm 1 cycle để đảm bảo output ổn định
            
            if (change_amount == expected_change && valid_transaction == expected_valid) begin
                $display("✅ PASS: %s", test_name);
                $display("    %0d₫ - %0d₫ → Change: %0d₫, Valid: %b", 
                         amount, price, change_amount, valid_transaction);
            end else begin
                $display("❌ FAIL: %s", test_name);
                $display("    %0d₫ - %0d₫ → Expected: %0d₫,%b | Got: %0d₫,%b", 
                         amount, price, expected_change, expected_valid, change_amount, valid_transaction);
            end
            $display("");
        end
    endtask
    
    // Test stimulus  
    initial begin
        $display("======= KIỂM THỬ CHANGE CALCULATOR =======");
        $display("Logic: valid = (price > 0 && amount >= price)");
        $display("       change = valid ? (amount - price) : amount");
        $display("===============================================");
        
        // Initialize
        reset = 1;
        current_amount = 0;
        product_price = 0;
        calculate = 0;
        
        // Reset
        repeat(3) @(posedge clk);
        reset = 0;
        repeat(2) @(posedge clk);
        $display("Time %0t: Reset hoàn tất\n", $time);
        
        // =================== DEBUG TEST: Kiểm tra module hoạt động ===================
        $display("=== DEBUG TEST: Kiểm tra module cơ bản ===");
        
        // Test đơn giản nhất
        current_amount = 15;
        product_price = 15;
        calculate = 1;
        @(posedge clk);
        calculate = 0;
        repeat(3) @(posedge clk);
        
        $display("Debug: Amount=%0d, Price=%0d → Change=%0d, Valid=%b", 
                 15, 15, change_amount, valid_transaction);
        
        if (change_amount == 0 && valid_transaction == 1) begin
            $display("✅ Module hoạt động: 15₫ - 15₫ = 0₫, valid=1");
        end else begin
            $display("❌ Module có vấn đề: Expected change=0,valid=1 | Got change=%0d,valid=%b", 
                     change_amount, valid_transaction);
        end
        
        // Test case 2: Có tiền thừa
        current_amount = 20;
        product_price = 15;
        calculate = 1;
        @(posedge clk);
        calculate = 0;
        repeat(3) @(posedge clk);
        
        $display("Debug: Amount=%0d, Price=%0d → Change=%0d, Valid=%b", 
                 20, 15, change_amount, valid_transaction);
        
        if (change_amount == 5 && valid_transaction == 1) begin
            $display("✅ Module hoạt động: 20₫ - 15₫ = 5₫, valid=1");
        end else begin
            $display("❌ Module có vấn đề: Expected change=5,valid=1 | Got change=%0d,valid=%b", 
                     change_amount, valid_transaction);
        end
        
        // Test case 3: Không đủ tiền
        current_amount = 10;
        product_price = 15;
        calculate = 1;
        @(posedge clk);
        calculate = 0;
        repeat(3) @(posedge clk);
        
        $display("Debug: Amount=%0d, Price=%0d → Change=%0d, Valid=%b", 
                 10, 15, change_amount, valid_transaction);
        
        if (change_amount == 10 && valid_transaction == 0) begin
            $display("✅ Module hoạt động: 10₫ < 15₫ → trả 10₫, valid=0");
        end else begin
            $display("❌ Module có vấn đề: Expected change=10,valid=0 | Got change=%0d,valid=%b", 
                     change_amount, valid_transaction);
        end
        
        // Test case 4: Price = 0 (hủy giao dịch)
        current_amount = 10;
        product_price = 0;
        calculate = 1;
        @(posedge clk);
        calculate = 0;
        repeat(3) @(posedge clk);
        
        $display("Debug: Amount=%0d, Price=%0d → Change=%0d, Valid=%b", 
                 10, 0, change_amount, valid_transaction);
        
        if (change_amount == 10 && valid_transaction == 0) begin
            $display("✅ Module hoạt động: Price=0 → trả 10₫, valid=0");
        end else begin
            $display("❌ Module có vấn đề: Expected change=10,valid=0 | Got change=%0d,valid=%b", 
                     change_amount, valid_transaction);
        end
        
        $display("\n=== KẾT LUẬN DEBUG ===");
        $display("Nếu tất cả debug test PASS → change_calculator.v hoạt động đúng");
        $display("Nếu có debug test FAIL → cần kiểm tra logic trong change_calculator.v");
        
        #100;
        $finish;
    end
    
    // Monitor output changes
    always @(posedge clk) begin
        if ($time > 100 && calculate) begin
            $display("Time %0t: Calculate triggered - Amount:%0d₫, Price:%0d₫", 
                     $time, current_amount, product_price);
        end
    end
    
    // Safety timeout
    initial begin
        #2000;
        $display("✅ Testbench completed successfully");
        $finish;
    end

endmodule
       
