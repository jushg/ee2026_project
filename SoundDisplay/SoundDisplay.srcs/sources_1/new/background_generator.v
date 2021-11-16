`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2021 03:46:03 PM
// Design Name: 
// Module Name: background_generator
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


module background_generator(
    input [3:0] volume,
    output reg [15:0] background
    );
    
    reg [1:0] state;
    always @ volume begin
        state = volume[2]<<1 | volume[0];
         case(state)
         0: background = {5'b00000, 1'b0, volume, 1'b0, 5'b00111};
         1: background = {1'b0, volume, 5'b00000, 1'b0, 5'b00111};
         2: background = {1'b0, volume, 5'b00111, 1'b0, 5'b00000};
         3: background = {5'b00111, 1'b0, volume, 1'b0, 5'b00000};
         endcase
    end
endmodule
