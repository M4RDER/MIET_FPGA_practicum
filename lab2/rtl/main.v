`timescale 1ns / 1ps



module main(
  input            clk_50MHZ,
  
  input      [9:0] SW_i,
  input      [2:0] KEY_i,
  
  output     [6:0] HEX0_o,
  output     [6:0] HEX1_o,
  output     [6:0] HEX2_o,
  output     [9:0] LedR_o
  );
  
  localparam CLK_FREQ_MHZ   = 50;
  localparam CLK_SEMIPERIOD = ( 500 / CLK_FREQ_MHZ ) / 2;
     
  wire    [7:0] hex;
  wire    [9:0] data;
  wire          dec_count;
  wire    [6:0] h0;
  wire    [6:0] h1;
  wire    [6:0] h2;
  
  registr u1(
    .clk_i  ( clk_50MHZ ),
    .data_i ( SW_i      ),
    .rstn_i ( KEY_i[1]  ),
    .en_i   ( KEY_i[0]  ),
    .data_o ( data      )
  ); 
  
  counter u2(
    .clk_i       ( clk_50MHZ ),
    .rstn_i      ( KEY_i[1]  ),
    .en_i        ( KEY_i[0]  ),
    .k2_i        ( KEY_i[2]  ),
    .counter_o   ( hex[7:0]  )    
  );
 
  
 dectohex dec
 (
  .count_i ( hex [7:0] ),
  .hex0_o  ( h0        ),
  .hex1_o  ( h1        ),
  .hex2_o  ( h2        )
  );
      
  assign HEX0_o = h0;
  assign HEX1_o = h1;
  assign HEX2_o = h2;
  assign LedR_o = data;
  
  
endmodule