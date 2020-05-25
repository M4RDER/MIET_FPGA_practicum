//`timescale 1ns / 1ps

module stopwatch #(
  parameter DEFALULT_PULSE = 260000,
            PULSE = 100
  )
(
  input        clk100_i,
  input        rstn_i,
  input        start_stop_i,
  input        set_i,
  input        change_i,
  
  output [6:0] hex0_o,
  output [6:0] hex1_o,
  output [6:0] hex2_o,
  output [6:0] hex3_o
  );
  
  wire [2:0] fsm_state;
  wire       increment;
  wire       passed_all;
  
  // Синхронизация  стоп паузы
  reg [2:0] button_syncroniser;
  wire button_was_pressed;
  
  always @( posedge clk100_i ) begin
    button_syncroniser[0] <= start_stop_i;
    button_syncroniser[1] <= button_syncroniser[0];
    button_syncroniser[2] <= button_syncroniser[1];
  end
  
  assign button_was_pressed = ~ button_syncroniser[2]
                              & button_syncroniser[1];
                              
reg [2:0] set_sync;
wire set_was_pressed;

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) begin
    set_sync[0] <= 1'b0;
    set_sync[1] <= 1'b0;
    set_sync[2] <= 1'b0;
  end
  else begin
    set_sync[0] <= set_i;
    set_sync[1] <= set_sync[0];
    set_sync[2] <= set_sync[1];
  end
end

assign set_was_pressed = ~ set_sync[2] && set_sync[1];


reg [2:0] change_sync;
wire change_was_pressed;

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) begin
    change_sync[0] <= 1'b0;
    change_sync[1] <= 1'b0;
    change_sync[2] <= 1'b0;
  end
  else begin
    change_sync[0] <= change_i;
    change_sync[1] <= change_sync[0];
    change_sync[2] <= change_sync[1];
  end
end

assign change_was_pressed = ~ change_sync[2] && change_sync[1];

// DEVICE_RUNNING
reg device_running;

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    device_running <= 1'b0;
  if ( passed_all )
      device_running <= 1'b1;
  else if ( fsm_state == IDLE )
    if ( button_was_pressed )
      device_running <= ~device_running;
end

    
  // Счетчик импульсов и признак истечения 0,01 сек
  reg [16:0] pulse_counter;
  wire       passed_100_sec = ( pulse_counter == PULSE - 1 );
  
  always @( posedge clk100_i or negedge rstn_i ) begin
    if ( !rstn_i ) pulse_counter <= 4'd0; // Асинхронный сброс
    else if ( device_running || passed_100_sec )
      if ( passed_100_sec ) pulse_counter <= 4'd0;
      else pulse_counter <= pulse_counter + 1;       
  end
  
  // Основные счетчики
  reg [3:0] counter_100s = 4'd0;
  wire      passed_10s_sec = ( ( counter_100s == 4'd9 ) & passed_100_sec);
  
  always @( posedge clk100_i or negedge rstn_i ) begin
    if ( !rstn_i ) counter_100s <= 0;
    else if ( passed_100_sec )
      if ( passed_10s_sec ) counter_100s <=0;
      else counter_100s <= counter_100s + 1;
  end
  
  reg [3:0] counter_10s = 4'd0;
  wire      second_passed = ( ( counter_10s ==4'd9 ) & passed_10s_sec);
  
  always @( posedge clk100_i or negedge rstn_i ) begin
    if ( !rstn_i ) counter_10s <=0;
    else if ( passed_10s_sec )  
      if ( second_passed ) 
        counter_10s <= 0;
      else counter_10s <= counter_10s + 1;  
   end
   
   reg [3:0] seconds_counter = 4'd0;
   wire      passed_10_sec = ( ( seconds_counter == 4'd9 ) & second_passed ); 
   
   always @( posedge clk100_i or negedge rstn_i ) begin
    if ( !rstn_i ) seconds_counter <= 0;
    else if (second_passed)
      if (passed_10_sec) seconds_counter <=0;
      else seconds_counter <= seconds_counter + 1;  
   end 
  
  reg [3:0] counter_10_sec = 4'd0;
  
  always @( posedge clk100_i or negedge rstn_i ) begin
    if ( !rstn_i ) counter_10_sec <= 0;
    else if ( passed_10_sec )
      if ( counter_10_sec == 4'd9 )
        counter_10_sec <= 0;
      else counter_10_sec <= counter_10_sec + 1;    
  end 
  
  // Отображение на семисигментниках
  dectohex to_hex3(
  .dec_i ( counter_10_sec ),
  .hex_o ( hex3_o              )
  );

dectohex to_hex2(
  .dec_i ( seconds_counter ),
  .hex_o ( hex2_o          )
  );

dectohex to_hex1(
  .dec_i ( counter_10s ),
  .hex_o ( hex1_o         )
  );

dectohex to_hex0(
  .dec_i ( counter_100s ),
  .hex_o ( hex0_o             )
  ); 

// работа конечного автомата
      
finstate fsm(
  .clk_i        ( clk100_i           ),
  .rstn_i       ( rstn_i             ),
  .dev_run_i    ( device_running     ),
  .set_i        ( set_was_pressed    ),
  .change_i     ( change_was_pressed ),
  .state_value_o( fsm_state          ),
  .inc_this_o   ( increment          ),
  .passed_all   ( passed_all         )
);

  
endmodule
