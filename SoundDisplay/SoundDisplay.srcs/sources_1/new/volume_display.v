`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2021 20:26:19
// Design Name: 
// Module Name: volume_display
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


module volume_display(
    input clk,
    input [2:0] display_setting,
    input border_setting,
    input [3:0] sw,
    input [12:0] pixel_index,
    input [6:0] volume_bar_pos,
    input [3:0] sound_level,
    output reg [15:0] oled_data = 65535
    );
    
    reg [6:0] x_pos = 0;
    reg [5:0] y_pos = 0; 
    
    always @ (posedge clk) begin
        if (display_setting == 1) begin
        y_pos =  63 - pixel_index / 96;
        x_pos =  pixel_index % 96;
        
            if (sw[0] && border_setting && (y_pos < 3 || y_pos > 60 || x_pos < 3 || x_pos > 92)) begin
                oled_data = sw[3] ? sw[2] ? 38066 : 64768 : sw[2] ? 65504 : 65535;
            end 
            else if (sw[0] && !border_setting && (y_pos == 0 || y_pos == 63 || x_pos == 0 || x_pos == 95)) begin
                oled_data = sw[3] ? sw[2] ? 38066 : 64768 : sw[2] ? 65504 : 65535;
            end
            else if (sw[1] && sound_level >= 0 && (y_pos >= 5 && y_pos <= 6 && x_pos >= volume_bar_pos && x_pos <= volume_bar_pos + 7)) begin
                oled_data = sw[3] ? sw[2] ? 5664 : 47092 : sw[2] ? 36848 : 2016;
            end
            else if (sw[1] && sound_level >= 1 && (y_pos >= 8 && y_pos <= 9 && x_pos >= volume_bar_pos && x_pos <= volume_bar_pos + 7)) begin
                oled_data = sw[3] ? sw[2] ? 5664 : 47092 : sw[2] ? 36848 : 2016;
            end
            else if (sw[1] && sound_level >= 2 && (y_pos >= 11 && y_pos <= 12 && x_pos >= volume_bar_pos && x_pos <= volume_bar_pos + 7)) begin
                oled_data = sw[3] ? sw[2] ? 5664 : 47092 : sw[2] ? 36848 : 2016;
            end
            else if (sw[1] && sound_level >= 3 && (y_pos >= 14 && y_pos <= 15 && x_pos >= volume_bar_pos && x_pos <= volume_bar_pos + 7)) begin
                oled_data = sw[3] ? sw[2] ? 5664 : 47092 : sw[2] ? 36848 : 2016;
            end
            else if (sw[1] && sound_level >= 4 && (y_pos >= 17 && y_pos <= 18 && x_pos >= volume_bar_pos && x_pos <= volume_bar_pos + 7)) begin
                oled_data = sw[3] ? sw[2] ? 5664 : 47092 : sw[2] ? 36848 : 2016;
            end
            else if (sw[1] && sound_level >= 5 && (y_pos >= 20 && y_pos <= 21 && x_pos >= volume_bar_pos && x_pos <= volume_bar_pos + 7)) begin
                oled_data = sw[3] ? sw[2] ? 5664 : 47092 : sw[2] ? 36848 : 2016;
            end
            else if (sw[1] && sound_level >= 6 && (y_pos >= 23 && y_pos <= 24 && x_pos >= volume_bar_pos && x_pos <= volume_bar_pos + 7)) begin
                oled_data = sw[3] ? sw[2] ? 50624 : 24550 : sw[2] ? 12287 : 65504;
            end
            else if (sw[1] && sound_level >= 7 && (y_pos >= 26 && y_pos <= 27 && x_pos >= volume_bar_pos && x_pos <= volume_bar_pos + 7)) begin
                oled_data = sw[3] ? sw[2] ? 50624 : 24550 : sw[2] ? 12287 : 65504;
            end
            else if (sw[1] && sound_level >= 8 && (y_pos >= 29 && y_pos <= 30 && x_pos >= volume_bar_pos && x_pos <= volume_bar_pos + 7)) begin
                oled_data = sw[3] ? sw[2] ? 50624 : 24550 : sw[2] ? 12287 : 65504;
            end
            else if (sw[1] && sound_level >= 9 && (y_pos >= 32 && y_pos <= 33 && x_pos >= volume_bar_pos && x_pos <= volume_bar_pos + 7)) begin
                oled_data = sw[3] ? sw[2] ? 50624 : 24550 : sw[2] ? 12287 : 65504;
            end
            else if (sw[1] && sound_level >= 10 && (y_pos >= 35 && y_pos <= 36 && x_pos >= volume_bar_pos && x_pos <= volume_bar_pos + 7)) begin
                oled_data = sw[3] ? sw[2] ? 50624 : 24550 : sw[2] ? 12287 : 65504;
            end
            else if (sw[1] && sound_level >= 11 && (y_pos >= 38 && y_pos <= 39 && x_pos >= volume_bar_pos && x_pos <= volume_bar_pos + 7)) begin
                oled_data = sw[3] ? sw[2] ? 45056 : 12000 : sw[2] ? 1819 : 63488;
            end
            else if (sw[1] && sound_level >= 12 && (y_pos >= 41 && y_pos <= 42 && x_pos >= volume_bar_pos && x_pos <= volume_bar_pos + 7)) begin
                oled_data = sw[3] ? sw[2] ? 45056 : 12000 : sw[2] ? 1819 : 63488;
            end
            else if (sw[1] && sound_level >= 13 && (y_pos >= 44 && y_pos <= 45 && x_pos >= volume_bar_pos && x_pos <= volume_bar_pos + 7)) begin
                oled_data = sw[3] ? sw[2] ? 45056 : 12000 : sw[2] ? 1819 : 63488;
            end
            else if (sw[1] && sound_level >= 14 && (y_pos >= 47 && y_pos <= 48 && x_pos >= volume_bar_pos && x_pos <= volume_bar_pos + 7)) begin
                oled_data = sw[3] ? sw[2] ? 45056 : 12000 : sw[2] ? 1819 : 63488;
            end
            else if (sw[1] && sound_level >= 15 && (y_pos >= 50 && y_pos <= 51 && x_pos >= volume_bar_pos && x_pos <= volume_bar_pos + 7)) begin
                oled_data = sw[3] ? sw[2] ? 45056 : 12000 : sw[2] ? 1819 : 63488;
            end
            else begin
                oled_data = sw[3] && sw[2] ? 65535 : 0;
            end
        
        end
        
    end
    
endmodule
