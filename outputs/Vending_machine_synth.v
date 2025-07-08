/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : W-2024.09-SP3
// Date      : Tue Jul  8 16:12:35 2025
/////////////////////////////////////////////////////////////


module money_counter ( clk, reset, coin_in, total_amount );
  input [1:0] coin_in;
  output [4:0] total_amount;
  input clk, reset;
  wire   \coin_in_prev[0] , N20, N21, N22, N23, N24, N27, N28, N29, N30, N31,
         N35, N36, N37, N38, N56, n31, n32, n33, n34, n35, \add_29/carry[4] ,
         \add_29/carry[3] , \add_29/carry[2] , n1, n2, n3, n4, n5, n6, n7, n8,
         n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22,
         n23, n24, n25, n26, n27, n28, n29, n30, n36, n37, n38, n39, n40, n41,
         n42, n43, n44, n45, n46;
  tri   clk;
  tri   [4:0] total_amount;
  tri   N34;
  assign total_amount[0] = N34;

  SAEDRVT14_ADDH_0P5 \add_29/U1_1_2  ( .A(total_amount[2]), .B(
        \add_29/carry[2] ), .CO(\add_29/carry[3] ), .S(N22) );
  SAEDRVT14_ADDH_0P5 \add_29/U1_1_3  ( .A(total_amount[3]), .B(
        \add_29/carry[3] ), .CO(\add_29/carry[4] ), .S(N23) );
  SAEDRVT14_ADDH_0P5 \add_29/U1_1_1  ( .A(total_amount[1]), .B(N34), .CO(
        \add_29/carry[2] ), .S(N21) );
  SAEDRVT14_FDPQB_V2LP_1 \coin_in_prev_reg[1]  ( .D(N56), .CK(clk), .QN(n46)
         );
  SAEDRVT14_FDPCBQ_V2LP_1 \coin_in_prev_reg[0]  ( .D(coin_in[0]), .RS(n6), 
        .CK(clk), .Q(\coin_in_prev[0] ) );
  SAEDRVT14_FDP_V2LP_1 \total_amount_reg[0]  ( .D(n34), .CK(clk), .Q(N34), 
        .QN(N20) );
  SAEDRVT14_FDP_V2LP_1 \total_amount_reg[1]  ( .D(n33), .CK(clk), .Q(
        total_amount[1]), .QN(N35) );
  SAEDRVT14_FDP_V2LP_1 \total_amount_reg[2]  ( .D(n32), .CK(clk), .Q(
        total_amount[2]), .QN(n25) );
  SAEDRVT14_FDP_V2LP_1 \total_amount_reg[3]  ( .D(n31), .CK(clk), .Q(
        total_amount[3]), .QN(n27) );
  SAEDRVT14_FDP_V2LP_1 \total_amount_reg[4]  ( .D(n35), .CK(clk), .Q(
        total_amount[4]), .QN(n15) );
  SAEDRVT14_INV_1P5 U3 ( .A(n6), .X(n7) );
  SAEDRVT14_INV_1P5 U4 ( .A(n12), .X(n6) );
  SAEDRVT14_BUF_ECO_1 U5 ( .A(n29), .X(n14) );
  SAEDRVT14_INV_1P5 U6 ( .A(reset), .X(n29) );
  SAEDRVT14_OAI22_0P75 U7 ( .A1(n17), .A2(n18), .B1(n15), .B2(n8), .X(n35) );
  SAEDRVT14_BUF_ECO_1 U8 ( .A(n9), .X(n13) );
  SAEDRVT14_INV_1P5 U9 ( .A(reset), .X(n9) );
  SAEDRVT14_BUF_ECO_1 U10 ( .A(n16), .X(n8) );
  SAEDRVT14_EN2_0P5 U11 ( .A1(total_amount[3]), .A2(n3), .X(N37) );
  SAEDRVT14_EN2_0P5 U12 ( .A1(total_amount[2]), .A2(n1), .X(N29) );
  SAEDRVT14_OA21_1 U13 ( .A1(total_amount[3]), .A2(n43), .B(total_amount[4]), 
        .X(n40) );
  SAEDRVT14_AN4_1 U14 ( .A1(total_amount[4]), .A2(total_amount[3]), .A3(N34), 
        .A4(n43), .X(n41) );
  SAEDRVT14_AN2_1 U15 ( .A1(total_amount[1]), .A2(N34), .X(n1) );
  SAEDRVT14_EN2_0P5 U16 ( .A1(total_amount[4]), .A2(n5), .X(N31) );
  SAEDRVT14_ND2_CDC_0P5 U17 ( .A1(total_amount[3]), .A2(n2), .X(n5) );
  SAEDRVT14_OR2_MM_0P5 U18 ( .A1(n1), .A2(total_amount[2]), .X(n2) );
  SAEDRVT14_EO2_V1_0P75 U19 ( .A1(\add_29/carry[4] ), .A2(total_amount[4]), 
        .X(N24) );
  SAEDRVT14_EN2_0P5 U20 ( .A1(total_amount[4]), .A2(n4), .X(N38) );
  SAEDRVT14_NR2_MM_0P5 U21 ( .A1(n3), .A2(total_amount[3]), .X(n4) );
  SAEDRVT14_AN2_1 U22 ( .A1(total_amount[2]), .A2(total_amount[1]), .X(n3) );
  SAEDRVT14_INV_1P5 U23 ( .A(N34), .X(N27) );
  SAEDRVT14_EO2_V1_0P75 U24 ( .A1(total_amount[2]), .A2(total_amount[1]), .X(
        N36) );
  SAEDRVT14_EO2_V1_0P75 U25 ( .A1(total_amount[1]), .A2(N34), .X(N28) );
  SAEDRVT14_EO2_V1_0P75 U26 ( .A1(total_amount[3]), .A2(n2), .X(N30) );
  SAEDRVT14_OAI21_0P5 U27 ( .A1(\coin_in_prev[0] ), .A2(n37), .B(n11), .X(n16)
         );
  SAEDRVT14_INV_S_0P5 U28 ( .A(n11), .X(n12) );
  SAEDRVT14_ND2_CDC_1 U29 ( .A1(n8), .A2(n13), .X(n18) );
  SAEDRVT14_INV_S_0P5 U30 ( .A(n10), .X(n11) );
  SAEDRVT14_INV_S_0P5 U31 ( .A(n14), .X(n10) );
  SAEDRVT14_AOI222_0P5 U32 ( .A1(N24), .A2(n19), .B1(N31), .B2(n20), .C1(N38), 
        .C2(n21), .X(n17) );
  SAEDRVT14_OAI22_0P5 U33 ( .A1(N27), .A2(n8), .B1(n22), .B2(n18), .X(n34) );
  SAEDRVT14_AOI222_0P5 U34 ( .A1(N20), .A2(n19), .B1(N27), .B2(n20), .C1(N34), 
        .C2(n21), .X(n22) );
  SAEDRVT14_OAI22_0P5 U35 ( .A1(n23), .A2(n8), .B1(n24), .B2(n18), .X(n33) );
  SAEDRVT14_AOI222_0P5 U36 ( .A1(N21), .A2(n19), .B1(N28), .B2(n20), .C1(N35), 
        .C2(n21), .X(n24) );
  SAEDRVT14_OAI22_0P5 U37 ( .A1(n25), .A2(n8), .B1(n26), .B2(n18), .X(n32) );
  SAEDRVT14_AOI222_0P5 U38 ( .A1(N22), .A2(n19), .B1(N29), .B2(n20), .C1(N36), 
        .C2(n21), .X(n26) );
  SAEDRVT14_OAI22_0P5 U39 ( .A1(n27), .A2(n8), .B1(n28), .B2(n18), .X(n31) );
  SAEDRVT14_AOI222_0P5 U40 ( .A1(N23), .A2(n19), .B1(N30), .B2(n20), .C1(N37), 
        .C2(n21), .X(n28) );
  SAEDRVT14_INV_0P5 U41 ( .A(n30), .X(n21) );
  SAEDRVT14_INV_0P5 U42 ( .A(n36), .X(n19) );
  SAEDRVT14_OAI21_0P5 U43 ( .A1(n38), .A2(n39), .B(n46), .X(n37) );
  SAEDRVT14_OAI22_0P5 U44 ( .A1(n40), .A2(n30), .B1(n41), .B2(n36), .X(n39) );
  SAEDRVT14_OR2_MM_0P5 U45 ( .A1(n42), .A2(coin_in[1]), .X(n36) );
  SAEDRVT14_OR2_MM_0P5 U46 ( .A1(n44), .A2(n42), .X(n30) );
  SAEDRVT14_NR2_MM_0P5 U47 ( .A1(n25), .A2(n23), .X(n43) );
  SAEDRVT14_INV_0P5 U48 ( .A(total_amount[1]), .X(n23) );
  SAEDRVT14_OA31_1 U49 ( .A1(n45), .A2(n27), .A3(n15), .B(n20), .X(n38) );
  SAEDRVT14_NR2_MM_0P5 U50 ( .A1(n44), .A2(coin_in[0]), .X(n20) );
  SAEDRVT14_AOI21_0P5 U51 ( .A1(N34), .A2(total_amount[1]), .B(total_amount[2]), .X(n45) );
  SAEDRVT14_NR2_MM_0P5 U52 ( .A1(n7), .A2(n44), .X(N56) );
  SAEDRVT14_INV_0P5 U53 ( .A(coin_in[1]), .X(n44) );
  SAEDRVT14_INV_0P5 U54 ( .A(coin_in[0]), .X(n42) );
endmodule


module product_selection ( clk, reset, product_sel, selected_price );
  input [1:0] product_sel;
  output [4:0] selected_price;
  input clk, reset;
  wire   n2, n3, n4, n5, n6, n7, n8, n1;
  tri   clk;
  tri   reset;
  tri   [4:0] selected_price;

  SAEDRVT14_AO21_1 U5 ( .A1(selected_price[0]), .A2(n2), .B(product_sel[0]), 
        .X(n4) );
  SAEDRVT14_OA21B_1 U6 ( .A1(selected_price[1]), .A2(product_sel[0]), .B(
        product_sel[1]), .X(n5) );
  SAEDRVT14_AO21B_0P5 U7 ( .A1(selected_price[2]), .A2(n2), .B(n3), .X(n6) );
  SAEDRVT14_AO21_1 U8 ( .A1(product_sel[0]), .A2(product_sel[1]), .B(n2), .X(
        n3) );
  SAEDRVT14_AO21_1 U9 ( .A1(selected_price[3]), .A2(n2), .B(product_sel[0]), 
        .X(n7) );
  SAEDRVT14_AO21_1 U10 ( .A1(selected_price[4]), .A2(n2), .B(product_sel[1]), 
        .X(n8) );
  SAEDRVT14_FDPRBQ_V2_1 \selected_price_reg[2]  ( .D(n6), .CK(clk), .RD(n1), 
        .Q(selected_price[2]) );
  SAEDRVT14_FDPRBQ_V2_1 \selected_price_reg[3]  ( .D(n7), .CK(clk), .RD(n1), 
        .Q(selected_price[3]) );
  SAEDRVT14_FDPRBQ_V2_1 \selected_price_reg[0]  ( .D(n4), .CK(clk), .RD(n1), 
        .Q(selected_price[0]) );
  SAEDRVT14_FDPRBQ_V2_1 \selected_price_reg[4]  ( .D(n8), .CK(clk), .RD(n1), 
        .Q(selected_price[4]) );
  SAEDRVT14_FDPRBQ_V2LP_1 \selected_price_reg[1]  ( .D(n5), .CK(clk), .RD(n1), 
        .Q(selected_price[1]) );
  SAEDRVT14_INV_1P5 U3 ( .A(reset), .X(n1) );
  SAEDRVT14_NR2_MM_0P5 U4 ( .A1(product_sel[0]), .A2(product_sel[1]), .X(n2)
         );
endmodule


module fsm_controller ( clk, reset, coin_in, product_sel, cancel, 
        current_amount, selected_price, valid_transaction, current_state, 
        dispense_command, calculate_change, reset_money, product_out );
  input [1:0] coin_in;
  input [1:0] product_sel;
  input [4:0] current_amount;
  input [4:0] selected_price;
  output [2:0] current_state;
  output [1:0] product_out;
  input clk, reset, cancel, valid_transaction;
  output dispense_command, calculate_change, reset_money;
  wire   money_reset_done, transaction_cancelled, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40,
         n41, n42, n43, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n14,
         n15, n16, n17, n18, n19, n20, n44, n45, n46, n47;
  wire   [2:0] next_state;
  wire   [1:0] selected_product;
  tri   clk;
  tri   reset;
  tri   [4:0] current_amount;
  tri   [4:0] selected_price;
  tri   calculate_change;

  SAEDRVT14_AN3_0P75 U12 ( .A1(n47), .A2(n15), .A3(n27), .X(next_state[1]) );
  SAEDRVT14_ND2B_U_0P5 U44 ( .A(current_state[0]), .B(n34), .X(n32) );
  SAEDRVT14_FDPRBQ_V2LP_1 \current_state_reg[1]  ( .D(next_state[1]), .CK(clk), 
        .RD(n44), .Q(current_state[1]) );
  SAEDRVT14_FDPRBQ_V2_1 money_reset_done_reg ( .D(n43), .CK(clk), .RD(n44), 
        .Q(money_reset_done) );
  SAEDRVT14_FDPRBQ_V2_1 \selected_product_reg[1]  ( .D(n41), .CK(clk), .RD(n44), .Q(selected_product[1]) );
  SAEDRVT14_FDPRBQ_V2_0P5 \selected_product_reg[0]  ( .D(n40), .CK(clk), .RD(
        n44), .Q(selected_product[0]) );
  SAEDRVT14_FDPRBQ_V2_1 transaction_cancelled_reg ( .D(n42), .CK(clk), .RD(n44), .Q(transaction_cancelled) );
  SAEDRVT14_FDPRBQ_V2_1 \current_state_reg[0]  ( .D(next_state[0]), .CK(clk), 
        .RD(n44), .Q(current_state[0]) );
  SAEDRVT14_FDPRBQ_V2_1 \current_state_reg[2]  ( .D(next_state[2]), .CK(clk), 
        .RD(n44), .Q(current_state[2]) );
  SAEDRVT14_OR2_MM_0P5 U3 ( .A1(n39), .A2(n23), .X(n37) );
  SAEDRVT14_ND2_CDC_0P5 U4 ( .A1(n23), .A2(n47), .X(n38) );
  SAEDRVT14_OAI21_0P75 U5 ( .A1(n28), .A2(n29), .B(n30), .X(n27) );
  SAEDRVT14_OAI21_0P75 U6 ( .A1(n31), .A2(n20), .B(n21), .X(n30) );
  SAEDRVT14_OAI21_0P75 U7 ( .A1(n39), .A2(n17), .B(n47), .X(n42) );
  SAEDRVT14_OA21_1 U8 ( .A1(n36), .A2(n16), .B(n31), .X(n35) );
  SAEDRVT14_NR2_MM_0P5 U9 ( .A1(n15), .A2(n26), .X(calculate_change) );
  SAEDRVT14_OAI22_0P75 U10 ( .A1(n14), .A2(n46), .B1(n22), .B2(n19), .X(
        product_out[0]) );
  SAEDRVT14_OAI22_0P75 U11 ( .A1(n14), .A2(n45), .B1(n22), .B2(n18), .X(
        product_out[1]) );
  SAEDRVT14_INV_1P5 U13 ( .A(n23), .X(n14) );
  SAEDRVT14_NR4_0P75 U14 ( .A1(money_reset_done), .A2(current_state[2]), .A3(
        current_state[0]), .A4(n21), .X(reset_money) );
  SAEDRVT14_INV_1P5 U15 ( .A(n17), .X(n3) );
  SAEDRVT14_INV_1P5 U16 ( .A(n21), .X(n2) );
  SAEDRVT14_INV_1P5 U17 ( .A(transaction_cancelled), .X(n17) );
  SAEDRVT14_AOI21_0P5 U18 ( .A1(n32), .A2(n33), .B(current_state[2]), .X(
        next_state[0]) );
  SAEDRVT14_ND3B_0P75 U19 ( .A(n29), .B1(n47), .B2(n28), .X(n33) );
  SAEDRVT14_OAI22_0P75 U20 ( .A1(current_state[1]), .A2(n31), .B1(cancel), 
        .B2(n35), .X(n34) );
  SAEDRVT14_AO221_0P5 U21 ( .A1(selected_price[3]), .A2(n10), .B1(
        selected_price[4]), .B2(n9), .C(n7), .X(n8) );
  SAEDRVT14_INV_1P5 U22 ( .A(current_amount[3]), .X(n10) );
  SAEDRVT14_OR2_MM_0P5 U23 ( .A1(n28), .A2(n1), .X(n36) );
  SAEDRVT14_OA21_1 U24 ( .A1(selected_price[4]), .A2(n9), .B(n8), .X(n1) );
  SAEDRVT14_ND2_CDC_0P5 U25 ( .A1(current_state[0]), .A2(n16), .X(n29) );
  SAEDRVT14_INV_1P5 U26 ( .A(current_state[2]), .X(n15) );
  SAEDRVT14_ND3B_0P75 U27 ( .A(n16), .B1(n15), .B2(current_state[0]), .X(n24)
         );
  SAEDRVT14_ND2_CDC_0P5 U28 ( .A1(n24), .A2(n25), .X(next_state[2]) );
  SAEDRVT14_ND3B_0P75 U29 ( .A(current_state[2]), .B1(cancel), .B2(n26), .X(
        n25) );
  SAEDRVT14_OAI21_0P75 U30 ( .A1(current_state[2]), .A2(n26), .B(n47), .X(n39)
         );
  SAEDRVT14_INV_1P5 U31 ( .A(current_amount[4]), .X(n9) );
  SAEDRVT14_OA2BB2_V1_1 U32 ( .A1(n4), .A2(selected_price[0]), .B1(
        current_amount[1]), .B2(n12), .X(n5) );
  SAEDRVT14_INV_1P5 U33 ( .A(selected_price[1]), .X(n12) );
  SAEDRVT14_NR2_MM_0P5 U34 ( .A1(current_state[2]), .A2(n26), .X(n43) );
  SAEDRVT14_INV_1P5 U35 ( .A(current_amount[2]), .X(n11) );
  SAEDRVT14_INV_1P5 U36 ( .A(selected_product[0]), .X(n19) );
  SAEDRVT14_INV_1P5 U37 ( .A(selected_product[1]), .X(n18) );
  SAEDRVT14_AOI21_0P5 U38 ( .A1(n17), .A2(calculate_change), .B(
        dispense_command), .X(n22) );
  SAEDRVT14_INV_1P5 U39 ( .A(n24), .X(dispense_command) );
  SAEDRVT14_INV_1P5 U40 ( .A(reset), .X(n44) );
  SAEDRVT14_INV_1P5 U41 ( .A(cancel), .X(n47) );
  SAEDRVT14_NR2_MM_0P5 U42 ( .A1(product_sel[0]), .A2(product_sel[1]), .X(n28)
         );
  SAEDRVT14_NR2_MM_0P5 U43 ( .A1(coin_in[0]), .A2(coin_in[1]), .X(n31) );
  SAEDRVT14_INV_1P5 U45 ( .A(product_sel[1]), .X(n45) );
  SAEDRVT14_INV_1P5 U46 ( .A(product_sel[0]), .X(n46) );
  SAEDRVT14_NR4_0P75 U47 ( .A1(n2), .A2(n36), .A3(n3), .A4(current_state[2]), 
        .X(n23) );
  SAEDRVT14_NR2_MM_0P5 U48 ( .A1(n16), .A2(current_state[0]), .X(n21) );
  SAEDRVT14_OR2_MM_0P5 U49 ( .A1(current_state[0]), .A2(current_state[1]), .X(
        n26) );
  SAEDRVT14_OAI22_0P5 U50 ( .A1(n18), .A2(n37), .B1(n45), .B2(n38), .X(n41) );
  SAEDRVT14_OAI22_0P5 U51 ( .A1(n19), .A2(n37), .B1(n46), .B2(n38), .X(n40) );
  SAEDRVT14_INV_1P5 U52 ( .A(current_state[1]), .X(n16) );
  SAEDRVT14_INV_S_0P5 U53 ( .A(n36), .X(n20) );
  SAEDRVT14_AOI21_0P5 U54 ( .A1(current_amount[1]), .A2(n12), .B(
        current_amount[0]), .X(n4) );
  SAEDRVT14_AO21B_0P5 U55 ( .A1(n11), .A2(selected_price[2]), .B(n5), .X(n6)
         );
  SAEDRVT14_OA221_U_0P5 U56 ( .A1(selected_price[3]), .A2(n10), .B1(
        selected_price[2]), .B2(n11), .C(n6), .X(n7) );
endmodule


module Vending_machine ( clk, reset, coin_in, product_sel, cancel, 
        current_amount_display, product_out, change_out, state_out );
  input [1:0] coin_in;
  input [1:0] product_sel;
  output [4:0] current_amount_display;
  output [1:0] product_out;
  output [4:0] change_out;
  output [2:0] state_out;
  input clk, reset, cancel;
  wire   _0_net_, reset_money;
  tri   clk;
  tri   reset;
  tri   [4:0] current_amount_display;
  tri   [4:0] change_out;
  tri   [4:0] selected_price;
  tri   valid_transaction;
  tri   calculate_change;

  money_counter money_counter_inst ( .clk(clk), .reset(_0_net_), .coin_in(
        coin_in), .total_amount(current_amount_display) );
  product_selection product_selection_inst ( .clk(clk), .reset(reset), 
        .product_sel(product_sel), .selected_price(selected_price) );
  fsm_controller fsm_controller_inst ( .clk(clk), .reset(reset), .coin_in(
        coin_in), .product_sel(product_sel), .cancel(cancel), .current_amount(
        current_amount_display), .selected_price(selected_price), 
        .valid_transaction(valid_transaction), .current_state(state_out), 
        .calculate_change(calculate_change), .reset_money(reset_money), 
        .product_out(product_out) );
  change_calculator change_calculator_inst ( .clk(clk), .reset(reset), 
        .current_amount(current_amount_display), .product_price(selected_price), .calculate(calculate_change), .change_amount(change_out), 
        .valid_transaction(valid_transaction) );
  SAEDRVT14_OR2_MM_0P5 U2 ( .A1(reset), .A2(reset_money), .X(_0_net_) );
endmodule

