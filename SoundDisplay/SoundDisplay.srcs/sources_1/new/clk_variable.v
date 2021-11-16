`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2021 20:19:37
// Design Name: 
// Module Name: clk_variable
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


module clk_variable(
    input CLK,
    input [31:0] count_value,
    output reg clk_out
    );
    
    reg [31:0] count;
    
    always @ (posedge CLK) begin
        count <= (count == count_value) ? 0 : count + 1;
        clk_out <= (count == 0) ? ~clk_out : clk_out;
    end
    
endmodule
