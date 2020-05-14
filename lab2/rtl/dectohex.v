`timescale 1ns / 1ps

module dectohex
  (
    input      [7:0]    count_i,
    
    output reg [6:0]    hex0_o,
    output reg [6:0]    hex1_o,
    output reg [6:0]    hex2_o
  );

always @ ( * ) begin
  case ( count_i % 10 )
    4'h0    : hex0_o = 7'b1000000;
    4'h1    : hex0_o = 7'b1111001;
    4'h2    : hex0_o = 7'b0100100;
    4'h3    : hex0_o = 7'b0110000;
    4'h4    : hex0_o = 7'b0011001;
    4'h5    : hex0_o = 7'b0010010;
    4'h6    : hex0_o = 7'b0000010;
    4'h7    : hex0_o = 7'b1111000;
    4'h8    : hex0_o = 7'b0000000;
    4'h9    : hex0_o = 7'b0010000;
    4'ha    : hex0_o = 7'b0001000;
    4'hb    : hex0_o = 7'b0000011;
    4'hc    : hex0_o = 7'b1000110;
    4'hd    : hex0_o = 7'b0100001;
    4'he    : hex0_o = 7'b0000110;
    4'hf    : hex0_o = 7'b0001110;
    default : hex0_o = 7'b1111111;
  endcase
  
  case ( ( count_i % 100 ) / 10 )
    4'h0    : hex1_o = 7'b1000000;
    4'h1    : hex1_o = 7'b1111001;
    4'h2    : hex1_o = 7'b0100100;
    4'h3    : hex1_o = 7'b0110000;
    4'h4    : hex1_o = 7'b0011001;
    4'h5    : hex1_o = 7'b0010010;
    4'h6    : hex1_o = 7'b0000010;
    4'h7    : hex1_o = 7'b1111000;
    4'h8    : hex1_o = 7'b0000000;
    4'h9    : hex1_o = 7'b0010000;
    4'ha    : hex1_o = 7'b0001000;
    4'hb    : hex1_o = 7'b0000011;
    4'hc    : hex1_o = 7'b1000110;
    4'hd    : hex1_o = 7'b0100001;
    4'he    : hex1_o = 7'b0000110;
    4'hf    : hex1_o = 7'b0001110;
    default : hex1_o = 7'b1111111;
  endcase
  
  case ( count_i  / 100 )
    4'h0    : hex2_o = 7'b1000000;
    4'h1    : hex2_o = 7'b1111001;
    4'h2    : hex2_o = 7'b0100100;
    4'h3    : hex2_o = 7'b0110000;
    4'h4    : hex2_o = 7'b0011001;
    4'h5    : hex2_o = 7'b0010010;
    4'h6    : hex2_o = 7'b0000010;
    4'h7    : hex2_o = 7'b1111000;
    4'h8    : hex2_o = 7'b0000000;
    4'h9    : hex2_o = 7'b0010000;
    4'ha    : hex2_o = 7'b0001000;
    4'hb    : hex2_o = 7'b0000011;
    4'hc    : hex2_o = 7'b1000110;
    4'hd    : hex2_o = 7'b0100001;
    4'he    : hex2_o = 7'b0000110;
    4'hf    : hex2_o = 7'b0001110;
    default : hex2_o = 7'b1111111;
  endcase
end

endmodule
