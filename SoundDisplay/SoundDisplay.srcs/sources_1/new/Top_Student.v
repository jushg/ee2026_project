`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//
//  LAB SESSION DAY (Delete where applicable):  THURSDAY A.M.
//
//  STUDENT A NAME: Hoang Trong Tan
//  STUDENT A MATRICULATION NUMBER: A0219767M
//
//  STUDENT B NAME: Justin Fidelis Wong Jun Wen
//  STUDENT B MATRICULATION NUMBER: A0219668M
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input  J_MIC3_Pin3,   // Connect from this signal to Audio_Capture.v
    output J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
    output J_MIC3_Pin4,    // Connect to this signal from Audio_Capture.v
    input [15:0] sw,
    input CLK,
    input btnU,
    input btnD,
    input btnL,
    input btnR,
    input btnC,
    output [7:0] JB,
    output [15:0] led,
    output [3:0] an,
    output [6:0] seg
    );
    
    wire count_20kHz;
    wire count_6_25mHz;
    wire count_0_16s;
    wire frame_begin, sending_pixels, sample_pixel;
    wire [12:0] pixel_index;
    wire [4:0] test_state;
    clk_variable clk1(CLK, 2499, count_20kHz);
    clk_variable clk2(CLK, 7, count_6_25mHz);
    clk_variable clk3(CLK, 7999999, count_0_16s);
    wire [11:0] mic_in; 
    wire reset;
    reg [15:0] oled_data;
    
    wire [2:0] display_setting;
    wire led_setting;
    
    wire [3:0] volume;
    wire [15:0] volume_led;
    wire [6:0] volume_seg;
    wire [3:0] volume_an;
    
    
    Audio_Capture ac(CLK, count_20kHz, J_MIC3_Pin3, J_MIC3_Pin1, J_MIC3_Pin4, mic_in);
    
    volume_intensity v1(CLK,sw[1],mic_in,volume_led,volume_seg,volume_an,volume);
    
    wire [15:0] display_led;
    wire [6:0] display_seg;
    wire [3:0] display_an;
    main_display d1(CLK,btnU,btnD,btnL,btnR,btnC,sw[15:0], volume, display_setting, JB, display_led, display_seg, display_an);
    
    assign led = sw[0] ? volume_led : mic_in;
    assign seg = display_setting != 4 ? volume_seg : display_seg;
    assign an = display_setting != 4 ? volume_an : display_an;
    

endmodule