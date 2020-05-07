`timescale 1ns / 1ps


module counter(
input            en_i,
input            clk_i,
input            rstn_i,
input      [9:0] SW,
output reg [7:0] counter_o
);

 
reg sw_event;
always @( SW )begin
 if ( ( SW[0] + SW[1] + SW[2] + SW[3] + SW[4] + SW[5] + SW[6] + SW[7] + SW[8] + SW[9] ) > 4'd3 )  sw_event <= 1'b1; 
 else sw_event <= 1'b0;
end 


reg [2:0] button_syncroniser;
wire button_was_pressed;

always @( posedge clk_i ) begin
  button_syncroniser[0] <= en_i;
  button_syncroniser[1] <= button_syncroniser[0];
  button_syncroniser[2] <= button_syncroniser[1];
end

assign button_was_pressed = ~button_syncroniser[2] & button_syncroniser[1];


always@( posedge clk_i or negedge rstn_i )begin
  if( !rstn_i ) counter_o <= 0;
  else if( button_was_pressed & sw_event ) counter_o <= counter_o + 1;
end
endmodule