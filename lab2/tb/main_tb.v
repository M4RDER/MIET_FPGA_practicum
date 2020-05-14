`timescale 1ns / 1ps

module main_tb(
    );
    
    localparam CLK_FREQ_MHZ   = 50;
    localparam CLK_SEMIPERIOD = ( 500 / CLK_FREQ_MHZ ) / 2;
    
    reg [2:0] key_i;
    reg [9:0] sw_i;
    reg       CLK;
    
    wire [6:0] HEX0;
    wire [6:0] HEX1;
    wire [6:0] HEX2;
    wire [9:0] LedR;
    reg CLK; 
    
    main DUT(
      .clk_50MHZ ( CLK       ),
      .SW_i      ( sw_i[9:0]   ),
      .KEY_i     ( key_i[2:0]  ),
      .HEX0_o    ( HEX0[6:0] ),
      .HEX1_o    ( HEX1[6:0] ),
      .HEX2_o    ( HEX2[6:0] ),
      .LedR_o    ( LedR[9:0] )
    );
    
    initial begin 
      CLK = 1'b0;
      forever
        #CLK_SEMIPERIOD CLK = ~CLK;
    end
        
    initial begin
      key_i[1] <= 1'b1;
      #20
      key_i[1] <= 1'b0;
      #20
      key_i[1] <= 1'b1;
      #140
      key_i[1] <= 1'b0;
      #180
      key_i[1] <= 1'b1;
    end

    initial begin 
      sw_i[9:0] <= 0;
      repeat(120) begin
        #9;
        sw_i[9:0] <= $random()/100;
      end
    end

    initial begin
      key_i[0] <= 1;
      forever 
        #16 key_i[0] <= ~key_i[0];
     end 

    initial begin
      key_i[2] <= 1;
      forever 
        #32 key_i[2] <= ~key_i[2];
    end


    initial begin 
      sw_i[10] <= 1'b1;
      #100;
      sw_i[10] <= 1'b0;
      #64;
      sw_i[10] <= 1'b1;
      #300;
      sw_i[10] <= 1'b0;
      #330;
      sw_i[10] <= 1'b1;
    end
    
 endmodule