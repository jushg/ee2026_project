`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2021 10:06:20 PM
// Design Name: 
// Module Name: display_volume
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


module display_volume(
    input CLK,
    input mode,
    input [3:0] level,
    output reg [6:0] seg,
    output reg[3:0] anode
    );
    reg state;
    wire clk_display;
    clk_variable clk2(CLK, 262467, clk_display);
    reg [6:0] first,second;
    initial begin
    seg = 0;
    anode = 4'b1111;
    state = 0;
    first = 0;
    second = 0;
    end
    always @(posedge clk_display) begin
    case(state)
        1'b0: begin
            seg <= first;
            anode <=  4'b0111;
        end
        1'b1:begin
         seg <= mode ? second : 7'b1111111;
         anode <=  4'b1011;
         end
   endcase
   state <= state + 1;
   end
   
   always @ (*) begin
           first = mode? (level > 4'd9) ?7'b1111001:7'b1000000 :
                    (level < 4'd6) ? 7'b1000111 : ( (level < 4'd11)? 7'b1101010 : 7'b0001001) ;
           case (level)
           4'd0,4'd10: second = 7'b1000000;
           4'd1,4'd11: second = 7'b1111001;
           4'd2,4'd12: second = 7'b0100100;
           4'd3,4'd13: second = 7'b0110000;
           4'd4,4'd14: second = 7'b0011001;
           4'd5,4'd15: second = 7'b0010010;
           4'd6: second = 7'b0000010;
           4'd7: second = 7'b1111000;
           4'd8: second = 7'b0000000;
           4'd9: second = 7'b0010000;
           endcase
       end
endmodule
