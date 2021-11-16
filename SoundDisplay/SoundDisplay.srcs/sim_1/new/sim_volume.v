`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2021 11:18:36 AM
// Design Name: 
// Module Name: sim_volume
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


module sim_volume(

    );
    
    reg [11:0] mic;
    reg clk;
    wire [15:0] volume;
    
    always #1 clk = ~clk;
    volume_convert vc(clk,mic,volume);
    
    initial begin
        mic = 0;
        clk = 0;
        #15 mic = 4000;
        # 20 mic = 1000;
    end
    
endmodule
