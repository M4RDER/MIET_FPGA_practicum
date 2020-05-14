`timescale 1ns / 1ps


module counter(
  input                clk_i,

  input                rstn_i,
  input                en_i,
  input                k2_i,
  
  output reg     [7:0] counter_o
  );
 
  reg [1:0] button_syncroniser;
  wire      k_event;

  assign k_event =  en_i || k2_i;

  always @( posedge clk_i or negedge rstn_i ) begin
    if ( !rstn_i )
      button_syncroniser <= 2'b0;
    else begin
      button_syncroniser[0] <= ~k_event;
      button_syncroniser[1] <=  button_syncroniser[0];
    end
  end

  assign synced_signal_o = ~button_syncroniser[1] & button_syncroniser[0];

  always @( posedge clk_i or negedge rstn_i ) begin
  if ( !rstn_i ) 
    counter_o <= 0; 
  else if ( synced_signal_o ) begin 
    counter_o <= counter_o + 1;
  end
end


  endmodule