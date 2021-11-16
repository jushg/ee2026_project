`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2021 10:05:06 PM
// Design Name: 
// Module Name: volume_intensity
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module volume_intensity(
    input CLK,
    input sw,
    input [11:0] mic_in,
    output [15:0] volume_led,
    output [6:0] seg,
    output [3:0] an,
    output reg [3:0] volume
    );
    wire  clk_20kHz,clk_display;
    reg [12:0] count_sample;
    clk_variable clk1(CLK, 2499, clk_20kHz); 
    reg [11:0] max_mic;
    
    initial begin
        count_sample = 0;
        volume = {2{1'b1}};
        max_mic = 0;
    end
    always @(posedge clk_20kHz) begin
        count_sample <= (count_sample == 12'd1999)? 0:count_sample + 1; //1999
        max_mic <= count_sample == 0 ? mic_in : (mic_in > max_mic ? mic_in : max_mic);    
        volume <= (count_sample == 0)?  max_mic[10:7] : volume;    
    end
    
    //Seven SEG and LED
    display_volume d1(CLK,sw ,volume,seg,an);
    display_led d2(volume,volume_led);
    
    
    
endmodule
