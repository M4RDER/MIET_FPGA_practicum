`timescale 1ns / 1ps

module registr(
  input        clk_i ,
  input        rstn_i ,
  input        en_i,
  input  [9:0] data_i,
  output [9:0] data_o 
  );
  
  reg [9:0] data;
  
  always@( posedge clk_i or negedge rstn_i ) begin
    if ( !rstn_i ) 
      data <= 0;
    else if ( en_i )
      data <= data_i;
  end
  
  assign data_o = data;
  
endmodule
