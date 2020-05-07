`timescale 1ns / 1ps



module main(
  input            clk_50MHZ,
  input      [9:0] SW,
  input      [1:0] KEY,
  output reg [6:0] HEX1,
  output reg [6:0] HEX2,
  output     [9:0] LedR
  );
  
  localparam CLK_FREQ_MHZ   = 50;
  localparam CLK_SEMIPERIOD = ( 500 / CLK_FREQ_MHZ ) / 2;
     
  wire [7:0] hex;
  wire [9:0] data;
  
  registr u1(
    .clk_i  ( clk_50MHZ ),
    .data_i ( SW        ),
    .rstn_i ( KEY[1]    ),
    .en_i   ( KEY[0]    ),
    .data_o ( data      )
  ); 
  
  counter u2(
    .SW        ( SW        ),
    .clk_i     ( clk_50MHZ ),
    .rstn_i    ( KEY[1]    ),
    .en_i      ( KEY[0]    ),
    .counter_o ( hex[7:0]  )
  );
  
  always@( posedge clk_50MHZ ) begin
    case (hex[3:0])
      4'd0  : HEX1 = 7'b100_0000;
      4'd1  : HEX1 = 7'b111_1001;
      4'd2  : HEX1 = 7'b010_0100;
      4'd3  : HEX1 = 7'b011_0000;
      4'd4  : HEX1 = 7'b001_1001;
      4'd5  : HEX1 = 7'b001_0010;
      4'd6  : HEX1 = 7'b000_0010;
      4'd7  : HEX1 = 7'b111_1000;
      4'd8  : HEX1 = 7'b000_0000;
      4'd9  : HEX1 = 7'b001_0000;
      4'd10 : HEX1 = 7'b000_1000;
      4'd11 : HEX1 = 7'b000_0011;
      4'd12 : HEX1 = 7'b100_0110;
      4'd13 : HEX1 = 7'b010_0001;
      4'd14 : HEX1 = 7'b000_0110;
      4'd15 : HEX1 = 7'b000_1110;
    endcase
    
    case (hex[7:4])
      4'd0  : HEX2 = 7'b100_0000;
      4'd1  : HEX2 = 7'b111_1001;
      4'd2  : HEX2 = 7'b010_0100;
      4'd3  : HEX2 = 7'b011_0000;
      4'd4  : HEX2 = 7'b001_1001;
      4'd5  : HEX2 = 7'b001_0010;
      4'd6  : HEX2 = 7'b000_0010;
      4'd7  : HEX2 = 7'b111_1000;
      4'd8  : HEX2 = 7'b000_0000;
      4'd9  : HEX2 = 7'b001_0000;
      4'd10 : HEX2 = 7'b000_1000;
      4'd11 : HEX2 = 7'b000_0011;
      4'd12 : HEX2 = 7'b100_0110;
      4'd13 : HEX2 = 7'b010_0001;
      4'd14 : HEX2 = 7'b000_0110;
      4'd15 : HEX2 = 7'b000_1110;
    endcase
  end
  
  assign LedR = data;
  
  
endmodule
