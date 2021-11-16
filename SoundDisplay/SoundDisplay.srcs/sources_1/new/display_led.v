`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2021 10:06:20 PM
// Design Name: 
// Module Name: display_led
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


module display_led(
    input [3:0] volume,
    output reg [15:0] led
    );
    always @(*) begin
        case(volume)
        4'd0: led = 0;
        4'd1: led = {1{1'b1}};
        4'd2: led = {2{1'b1}};
        4'd3: led = {3{1'b1}};
        4'd4: led = {4{1'b1}};
        4'd5: led = {5{1'b1}};
        4'd6: led = {6{1'b1}};
        4'd7: led = {7{1'b1}};
        4'd8: led = {8{1'b1}};
        4'd9: led = {9{1'b1}};
        4'd10: led = {10{1'b1}};
        4'd11: led = {11{1'b1}};
        4'd12: led = {12{1'b1}};
        4'd13: led = {13{1'b1}};
        4'd14: led = {14{1'b1}};
        4'd15: led = {15{1'b1}};
        endcase
    end
endmodule
