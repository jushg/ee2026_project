`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2021 10:22:55
// Design Name: 
// Module Name: single_pulse
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


module single_pulse(
    input signal,
    input CLK,
    output pulse
    );
    
    wire q1;
    wire q2_not;
    
    
    dff f1(signal, CLK, q1,);
    dff f2(q1, CLK, , q2_not);
    assign pulse = q1 & q2_not;
endmodule
