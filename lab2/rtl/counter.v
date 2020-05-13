`timescale 1ns / 1ps


module counter(
input            clk_i,

input            en_i,
input            rstn_i,

input      [9:0] SW_i,

output reg [7:0] counter_o
);
 
reg sw_event;

always @( SW_i )begin
  if ( ( SW_i [0] + SW_i [1] + SW_i [2] + SW_i [3] + SW_i [4] + SW_i [5] + SW_i [6] + SW_i [7] + SW_i [8] + SW_i [9] ) > 4'd3 )  
    sw_event <= 1'b1; 
  else sw_event <= 1'b0;
end 


reg [2:0] button_syncroniser;
wire      button_was_pressed;

always @( posedge clk_i ) begin
  button_syncroniser[0] <= !en_i;
  button_syncroniser[1] <= button_syncroniser[0];
  button_syncroniser[2] <= button_syncroniser[1];
end

assign button_was_pressed =  ~button_syncroniser[2] & button_syncroniser[1] ;


always@( posedge clk_i or negedge rstn_i )begin
  if( !rstn_i ) counter_o <= 0;
  else if( button_was_pressed & sw_event ) counter_o <= counter_o + 1;
end
endmodule