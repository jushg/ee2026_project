`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2021 00:27:34
// Design Name: 
// Module Name: fishing_game_settings
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


module fishing_game_settings(
    input clk,
    input clk_seg,
    input [2:0] display_setting, 
    input db_btnU, 
    input db_btnD, 
    input db_btnL, 
    input db_btnR, 
    input sp_btnC,
    input db_btnC,
    input [3:0] sound_level,
    output reg [6:0] char_xpos = 20,
    output reg [5:0] char_ypos = 31,
    output reg walk = 0,
    output reg [1:0] dir = 1, //0: right, 1: down, 2: left, 3: up
    output reg fishing = 0,
    output reg casting = 0,
    output reg cast = 0,
    output reg bite = 0,
    output reg reel = 0,
    output reg caught = 0,
    output reg escape = 0,
    output reg [3:0] cast_power,
    output reg [4:0] fish_pos,
    output reg [4:0] hook_pos,
    output reg [1:0] result,
    output reg [1:0] leaf_frame = 0,
    output reg [2:0] leaves = 0,
    output reg [6:0] seg,
    output reg [3:0] an
    );
    
    reg count_up = 1;
    reg [5:0] time_counter;
    reg [5:0] time_bite;
    reg [2:0] time_pull;
    
    reg [5:0] time_reel;
    reg [6:0] time_catching;
    reg fish_dir;
    reg hook_dir;
    reg [2:0] fish_speed;
    reg [2:0] hook_speed;
    reg [4:0] time_result = 0;
    reg [1:0] leaf_timer = 0;
    reg [12:0] score = 0;
    reg [1:0] seg_pos = 0;
    reg [3:0] digit = 0;
    
    always @ (posedge clk_seg) begin
        seg_pos = seg_pos + 1;
        if (seg_pos == 0) begin
            an = 4'b1110;
            digit = score % 10;
        end
        if (seg_pos == 1) begin
            an = 4'b1101;
            digit = (score / 10) % 10;
        end
        if (seg_pos == 2) begin
            an = 4'b1011;
            digit = (score / 100) % 10;
        end
        if (seg_pos == 3) begin
            an = 4'b0111;
            digit = score / 1000;
        end
        case (digit) 
        0: begin seg = 7'b1000000; end
        1: begin seg = 7'b1111001; end
        2: begin seg = 7'b0100100; end
        3: begin seg = 7'b0110000; end
        4: begin seg = 7'b0011001; end
        5: begin seg = 7'b0010010; end
        6: begin seg = 7'b0000010; end
        7: begin seg = 7'b1111000; end
        8: begin seg = 7'b0000000; end
        9: begin seg = 7'b0010000; end
        endcase
    end
    
    always @ (posedge clk) begin
        if (display_setting == 4) begin
            leaves = leaf_timer == 0 ? sound_level[3:1] : leaves;
            leaf_timer = leaf_timer + 1;
            leaf_frame = leaf_timer == 0 ? leaf_frame + 1 : leaf_frame;
            if (db_btnU && !fishing) begin
                dir = 3;
                walk = !walk;
                char_ypos = char_ypos > 40 ? 41 : char_ypos + 2;
            end
            else if (db_btnD && !fishing) begin
                dir = 1;
                walk = !walk;
                char_ypos = char_ypos < 4 ? 3 : char_ypos - 2;
            end
            else if (db_btnL && !fishing) begin
                dir = 2;
                walk = !walk;
                char_xpos = char_xpos < 12 ? 11 : char_xpos - 2;
            end
            else if (db_btnR && !fishing) begin
                dir = 0;
                walk = !walk;
                char_xpos = char_xpos > 33 ? 34 : char_xpos + 2;
            end
            else begin
                walk = 0;
            end
            if (dir == 0 && sp_btnC && !fishing & char_xpos > 30 && char_ypos < 42) begin
                fishing = 1;
                casting = 0;
                cast = 0;
                bite = 0;
                reel = 0;
                escape = 0;
                caught = 0;
                result = 0;
            end
            if (fishing && !casting && !db_btnC) begin
            casting = 1;
            cast_power = 0;
            end
            if (casting && !cast) begin
                count_up = cast_power == 15 ? 0 : cast_power == 0 ? 1 : count_up;
                if (db_btnC) begin
                  cast_power = count_up ? cast_power + 1 : cast_power - 1;
                end
                if (!db_btnC && cast_power != 0) begin
                    cast = 1;
                    time_bite = 63 / cast_power[3:1];
                    time_counter = 0;
                end
            end
            if (cast && !bite) begin
                time_counter = time_counter + 1;
                if (time_counter >= time_bite) begin
                    bite = 1;
                    time_pull = 0;
                end
            end
            if (bite && !reel) begin
                time_pull = time_pull + 1;
                if (time_pull == 7) begin
                    fishing = 0;
                    casting = 0;
                    cast = 0;
                    bite = 0;
                end
                if (sp_btnC) begin
                    reel = 1;
                    fish_pos = 10;
                    hook_pos = 10;
                    time_reel = 20;
                    time_catching = 0;
                    fish_dir = 0;
                    hook_dir = 0;
                    fish_speed = 0;
                    hook_speed = 0;
                end
            end
            if (reel && !caught && !escape) begin
                if (db_btnC) begin
                    hook_speed = hook_pos == 20 ? 0 : hook_dir ? hook_speed >= 5 ? 6 : hook_speed + 1 : hook_speed > 0 ? hook_speed - 1 : 0;
                    hook_dir = hook_speed == 0 ? 1 : hook_dir;
                end
                else begin
                    hook_speed = hook_pos == 0 ? 0 : !hook_dir ? hook_speed >= 5 ? 6 : hook_speed + 1 : hook_speed > 0 ? hook_speed - 1 : 0;
                    hook_dir = hook_speed == 0 ? 0 : hook_dir;
                end
                hook_pos = hook_dir ? hook_pos < 20 - hook_speed ? hook_pos + hook_speed : 20 : hook_pos > hook_speed ? hook_pos - hook_speed : 0; 
                fish_dir = fish_pos > 23 ? 0 : fish_pos < 1 ? 1 : !time_catching[5] ^ !time_catching[3];
                fish_speed = 1 + (sound_level >= 2) + (sound_level >= 4) + (sound_level >= 6) + (sound_level >= 8) + (sound_level >= 12) + (time_catching >= 32);
                fish_pos = fish_dir ? fish_pos < 25 - fish_speed ? fish_pos + fish_speed : 25 : fish_pos > fish_speed ? fish_pos - fish_speed : 0;
                result = result == 3 || sound_level >= 12 ? 3 : result == 2 || sound_level >= 8 ? 2 : result == 1 || sound_level > 4 ? 1 : 0;
                
                time_reel = fish_pos >= hook_pos && fish_pos <= hook_pos + 6 ? time_reel + 1 : time_reel - 1;
                escape = time_reel == 0;
                caught = time_reel >= 50;
                score = caught ? result == 0 ? score + 100 : result == 1 ? score + 250 : result == 2 ? score + 500 : score + 1000 : score;
            end
            
            if (caught || escape) begin
            time_result = time_result + 1;
                if (time_result == 0) begin
                fishing = 0;
                end
            end 
            
        end
    end
    
endmodule
