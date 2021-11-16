`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2021 09:07:59 PM
// Design Name: 
// Module Name: wave_display
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


module wave_display(
    input CLK,
    //input [3:0] display_setting,
    input [3:0] volume,
    input [15:0] background,
    input [12:0] pixel_index,
    input [2:0] display_setting,
    output reg [15:0] oled_data
);
    reg [3:0] capture [23:0];
    wire count_10Hz;
    clk_variable clk1(CLK, 4999999, count_10Hz);
    reg [6:0] x_pos = 0;
    reg [6:0] y_pos = 0;
  
    reg [6:0] middle = 31;
  
    integer j;
    always @ pixel_index begin
         x_pos = pixel_index % 96; // [0:95]
         y_pos =  63 - pixel_index / 96; // [0:63]
        if (display_setting == 2) begin
        for(j = 0; j < 24; j = j + 1) begin
            if(x_pos >= (j * 4) && x_pos <= (j*4 + 3) ) begin
                        if (capture[j] >= 0 && y_pos == middle ) begin
                            oled_data = 2016;
                        end
                        else if (capture[j] >= 1 && (y_pos == middle + 2 || y_pos == middle - 2)) begin
                            oled_data = 2016;
                        end
                        
                        else if (capture[j] >= 2 && (y_pos == middle + 4 || y_pos == middle - 4)) begin
                            oled_data = 2016;
                        end
                        else if (capture[j] >= 3 && (y_pos == middle + 6 || y_pos == middle - 6)) begin
                            oled_data = 2016;
                        end
                        
                        else if (capture[j] >=  4 && (y_pos == middle + 8 ||y_pos == middle - 8)) begin
                            oled_data = 2016;
                        end
                         else if (capture[j] >= 5 && (y_pos == middle + 10 || y_pos == middle - 10)) begin
                            oled_data = 65504;
                        end
                       
                        else if (capture[j] >= 6 && ( y_pos == middle + 12 || y_pos == middle - 12)) begin
                            oled_data = 65504;
                        end
                        else if (capture[j] >= 7 && (y_pos == middle + 14 || y_pos == middle - 14)) begin
                            oled_data = 65504;
                        end
                        
                        else if (capture[j] >=  8 && (y_pos == middle + 16 || y_pos == middle - 16)) begin
                            oled_data = 65504;
                        end
                          else if (capture[j] >= 9 && (y_pos == middle + 18 || y_pos == middle - 18)) begin
                            oled_data = 65504;
                        end
                      
                        else if (capture[j] >= 10 && (y_pos == middle + 20 || y_pos == middle - 20)) begin
                            oled_data = 65504;
                        end
                         else if (capture[j] >= 11 && (y_pos == middle + 22 || y_pos == middle - 22)) begin
                            oled_data = 63488;
                        end
                       
                        else if (capture[j] >=  12 && (y_pos == middle + 24|| y_pos == middle - 24)) begin
                            oled_data = 63488;
                        end
                         else if (capture[j] >= 13 && (y_pos == middle + 26 || y_pos == middle - 26)) begin
                            oled_data = 63488;
                        end
                       
                        else if (capture[j] >=  14 &&( y_pos == middle + 28 || y_pos == middle - 28)) begin
                            oled_data = 63488;
                        end
                       else if (capture[j] >=  15 &&( y_pos == middle + 30 || y_pos == middle - 30)) begin
                            oled_data = 63488;
                       end
                        else begin
                            oled_data = background;
                        end 
            end
        end
      end
    end
    always @ (posedge count_10Hz) begin
            capture[23] = volume;
            capture[22] <= capture[23];
            capture[21] <= capture[22];
            capture[20] <= capture[21];
            capture[19] <= capture[20];
            capture[18] <= capture[19];
            capture[17] <= capture[18];
            capture[16] <= capture[17];
            capture[15] <= capture[16];
            capture[14] <= capture[15];
            capture[13] <= capture[14];
            capture[12] <= capture[13];
            capture[11] <= capture[12];
            capture[10] <= capture[11];
            capture[9] <= capture[10];
            capture[8] <= capture[9];
            capture[7] <= capture[8];
            capture[6] <= capture[7];
            capture[5] <= capture[6];
            capture[4] <= capture[5];
            capture[3] <= capture[4];
            capture[2] <= capture[3];
            capture[1] <= capture[2];
            capture[0] <= capture[1];
   end 
endmodule
