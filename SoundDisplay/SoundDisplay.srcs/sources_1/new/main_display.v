`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2021 10:11:37 PM
// Design Name: 
// Module Name: main_display
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


module main_display(
        input CLK,
        input btnU,
        input btnD,
        input btnL,
        input btnR,
        input btnC,
        input [15:0] sw,
        input [3:0] volume,
        output reg [2:0] display_setting = 0, //determines which display option will be used
        output [7:0] JB,
        output [15:0] led,
        output [6:0] seg,
        output [3:0] an
);

wire count_20kHz;
wire count_6_25mHz;
wire count_0_16s;
wire count_381Hz;
wire frame_begin, sending_pixels, sample_pixel, reset;
wire [12:0] pixel_index;
wire [4:0] test_state;
wire sp_btnU, sp_btnD, sp_btnL, sp_btnR, sp_btnC; //single pulse debounced outputs for the 4 buttons
wire db_btnU, db_btnD, db_btnL, db_btnR, db_btnC;

wire [3:0] sound_level;

//clocks
clk_variable clk1(CLK, 2499, count_20kHz); 
clk_variable clk2(CLK, 7, count_6_25mHz);
clk_variable clk3(CLK, 7999999, count_0_16s);
clk_variable clk4(CLK, 131233, count_381Hz);

//sound level and oled registers
assign sound_level = volume [3:0];
wire [15:0] oled_data;
wire [15:0] oled_data0;
wire [15:0] oled_data1;
wire [15:0] oled_data2;
wire [15:0] oled_data3;
wire [15:0] oled_data4;
wire [15:0] oled_data5;
wire [15:0] oled_data6;
wire [15:0] oled_data7;


//single pulse
single_pulse sp1(btnC, count_0_16s, sp_btnC);
single_pulse sp2(btnU, count_0_16s, sp_btnU);
single_pulse sp3(btnD, count_0_16s, sp_btnD);
single_pulse sp4(btnL, count_0_16s, sp_btnL);
single_pulse sp5(btnR, count_0_16s, sp_btnR);

//debounce
dff dff1(btnC, count_0_16s, db_btnC);
dff dff2(btnU, count_0_16s, db_btnU);
dff dff3(btnD, count_0_16s, db_btnD);
dff dff4(btnL, count_0_16s, db_btnL);
dff dff5(btnR, count_0_16s, db_btnR);


//menu
reg [2:0] current_setting = 0;
always @ (posedge count_0_16s) begin
    if (sw[15]) begin
        current_setting = 0;
        display_setting = 0;
    end
    if (display_setting == 0) begin
        if (sp_btnC) begin
            display_setting = current_setting == 6 || current_setting == 7 ? 0 : current_setting;
        end
        if (sp_btnL) begin
            current_setting = !current_setting[0] ? current_setting - 3 : current_setting - 1;
        end
        if (sp_btnR) begin
            current_setting = current_setting[0] ? current_setting + 3 : current_setting + 1;
        end
        if (sp_btnU) begin
            current_setting = current_setting[1] ? current_setting - 2 : current_setting;
        end
        if (sp_btnD) begin
            current_setting = !current_setting[1] ? current_setting + 2 : current_setting;
        end
    end
end

menu_display(count_6_25mHz, count_0_16s, display_setting, pixel_index, current_setting, oled_data0);


//audio display volume_setting = 1
wire border_setting; //determines the thickness of the box
wire [6:0] volume_bar_pos;
volume_settings(count_0_16s, display_setting, sp_btnU, sp_btnC, db_btnL, db_btnR, border_setting, volume_bar_pos);
volume_display(count_6_25mHz, display_setting, border_setting, sw[5:2], pixel_index, volume_bar_pos, sound_level, oled_data1);





//fishing game volume_setting = 4
wire [6:0] char_xpos;
wire [5:0] char_ypos;
wire walk;
wire [1:0] dir;
wire fishing;
wire casting;
wire cast;
wire bite;
wire reel;
wire caught;
wire escape;
wire [3:0] cast_power;
wire [4:0] fish_pos;
wire [4:0] hook_pos;
wire [1:0] result;
wire [1:0] leaf_frame;
wire [2:0] leaves;
wire [6:0] seg_fish;
wire [3:0] an_fish;
fishing_game_settings(count_0_16s, count_381Hz, display_setting, db_btnU, db_btnD, db_btnL, db_btnR, sp_btnC, db_btnC, sound_level, char_xpos, char_ypos, walk, dir, fishing, casting, cast, bite, reel, caught, escape, cast_power, fish_pos, hook_pos, result, leaf_frame, leaves, seg_fish, an_fish);
fishing_game_display(count_6_25mHz, display_setting, pixel_index, char_xpos, char_ypos, walk, dir, fishing, casting, cast, bite, reel, caught, escape, cast_power, fish_pos, hook_pos, result, leaf_frame, leaves, oled_data4);


//wave display
wire [15:0] background_color;
background_generator(volume, background_color);
wave_display(CLK, volume, background_color, pixel_index, display_setting, oled_data2);

//brick game
brick_game(CLK, display_setting, background_color,volume, btnC,btnL,btnR,pixel_index,oled_data5);

//firework
firework_display(CLK, pixel_index, volume, background_color, display_setting, oled_data3);


assign oled_data = display_setting == 7 ? oled_data7 : display_setting == 6 ? oled_data6 : display_setting == 5 ? oled_data5 : display_setting == 4 ? oled_data4 :
                   display_setting == 3 ? oled_data3 : display_setting == 2 ? oled_data2 : display_setting == 1 ? oled_data1 : oled_data0;

Oled_Display dis(count_6_25mHz, reset, frame_begin, sending_pixels,
  sample_pixel, pixel_index, oled_data, JB[0], JB[1], JB[3], JB[4], JB[5], JB[6],
  JB[7], test_state);
  
assign seg = display_setting == 4 ? seg_fish : 0;
assign an = display_setting == 4 ? an_fish : 0;

endmodule
