`timescale 1ns / 1ps

module main_tb(
    );
    
    localparam CLK_FREQ_MHZ   = 50;
    localparam CLK_SEMIPERIOD = ( 500 / CLK_FREQ_MHZ ) / 2;
    
    reg [1:0] KEY;
    reg [9:0] SW;
    reg       CLK;
    
    wire [6:0] HEX1;
    wire [6:0] HEX2;
    wire [9:0] LedR;
    reg CLK; 
    
    main DUT(
      .CLK  ( CLK       ),
      .SW   ( SW[9:0]   ),
      .KEY  ( KEY[1:0]  ),
      .HEX1 ( HEX1[6:0] ),
      .HEX2 ( HEX2[6:0] ),
      .LedR ( LedR[9:0] )
    );
    
     initial begin 
    CLK = 1'b0;
    forever #CLK_SEMIPERIOD CLK = ~CLK;
  end
        
    initial begin
      KEY[1] = 1'b0;
      repeat(16) begin
        #25
        KEY[1] = 1'b1;
        #500;
        KEY[1] = 1'b0;
      end  
    end
    
    initial begin
      repeat(16) begin
        #50
        KEY[0] = 1'b0;
        #50;
        KEY[0] = 1'b1;
      end  
    end
    
    initial begin
        SW[9:8]=2'd0;
       #400;
       SW[9:8]=2'd1;
       #400;
        SW[9:8]=2'd2;
        #400;
        SW[9:8]=2'd3;
       #400;
       $stop;
    end
    initial begin
        SW[3:0]=4'd0;
         SW[7:4]=4'd0;
        repeat(16) begin
           #100;
           SW[3:0]=$random();
           SW[7:4]=$random();
        end
    end
    
    
endmodule