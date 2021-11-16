`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2021 21:21:23
// Design Name: 
// Module Name: volume_settings
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


module volume_settings(
    input clk,
    input [2:0] display_setting,
    input sp_btnU,
    input sp_btnC,
    input db_btnL,
    input db_btnR,
    output reg border_setting = 0,
    output reg [6:0] volume_bar_pos = 45
    );
    
    always @ (posedge clk) begin
        if (display_setting == 1) begin
            border_setting = sp_btnU ? ~border_setting : border_setting;
            volume_bar_pos = db_btnL ? volume_bar_pos >= 7 ? volume_bar_pos - 2: 5: volume_bar_pos;
            volume_bar_pos = db_btnR ? volume_bar_pos <= 81 ? volume_bar_pos + 2: 83: volume_bar_pos;
            volume_bar_pos = sp_btnC ? 45 : volume_bar_pos;
        end
    end
    
endmodule
