`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2021 12:46:10 PM
// Design Name: 
// Module Name: firework_display
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


module firework_display(
    input CLK,
    input [12:0] pixel_index,
    input [3:0] volume,
    input [15:0] random_color,
    input [2:0] display_setting,
    output reg [15:0] oled_data
    );
    
    wire count_0_16s;
    clk_variable clk2(CLK, 7999999, count_0_16s);
        
    reg [6:0] x_pos = 0;
    reg [5:0] y_pos = 0; 
    reg [3:0] speed = 0;
    reg [2:0] state = 0;
    reg [3:0] count = 0;
    reg [15:0] fireworkColor [6:0];
    reg [6:0] fireworkX[6:0];
    reg [6:0] fireworkY[6:0];
    reg [3:0] fireworkType[6:0];
    reg [6:0] nextX;
    reg [6:0] nextY;
    reg [15:0] color;
    reg [3:0]colorState= 0;
    reg [15:0] background = 0;
    reg [399:0] list = 400'b1001011011100100100010001001000000000111100101010101011001101101110100110101101100011111010010101010111110001110110011111101010000010101101101110101010011111111100110000100110010101000110000101001011001010000000001010110111011010101010011000101010100010111111100011101110010110110111010101000010110110101001010101010101010001010001011111111111000011100110010001000000111101010010101000010101010101010;
    reg temp;
    //LOGIC
    integer i;
    initial begin
        for(i = 0; i < 7;i = i + 1) begin
            fireworkX [i] = 0;
            fireworkY [i] = 0;
        end
    end
    always @(posedge count_0_16s) begin
        if(display_setting == 3) begin 
           //RANDOM FIREWORK COLOR
           
           if(volume < 4) speed = 1;
           else if ( volume < 8) speed = 2;
           else if (volume < 12) speed = 3;
           else speed = 4;           
           if(count == 0) begin
            nextX =  (list[256:250]%30)*2 + 18;
            nextY =  (list[64:58] % 30)*2 + 2;
            temp = list[399];
            list = list << 1;
            list = list + temp;
            colorState = list[11:8];
            case(colorState)
                        0,6: color = 65535;
                        1,7: color  = random_color;
                        2: color =  65504;
                        3:   color = 63488;
                        4:   color = 2020;
                        5:   color = random_color;
                       endcase
            end
           //RANDOM FIREWORK POSITION
           for(i = 0; i < 7; i = i + 1) begin
                if(state == i && count == 0) begin
                    fireworkColor[i] = color;
                    fireworkX[i] = nextX;
                    fireworkY[i] = nextY;   
                    fireworkType[i] = 0;             
                end
                
                else fireworkType[i] =  fireworkType[i] > 4 ? fireworkType[i] :fireworkType[i] + 1 ;
           end
           state = count == 0 ?  state + 1:  state;
           count = (count > 2) ? 0: count + speed;
        end
    end
    
    //DISPLAY
    reg [10:0] pixel_count = 0;
    always @ pixel_index begin
        
        
        if(display_setting == 3) begin 
            y_pos =  63 - pixel_index / 96;
            x_pos =  pixel_index % 96;
            oled_data = background;
            for(i = 0; i < 7; i = i + 1) begin
                if(fireworkX[i] != 0 && y_pos <= (fireworkY[i] + 6) && y_pos >= (fireworkY[i] - 6) && x_pos <= (fireworkX[i] + 6) && x_pos >= (fireworkX[i] - 6)) 
                begin
                    pixel_count = (x_pos - fireworkX[i] - 7 ) + 13 * ( fireworkY[i] + 6 - y_pos);
                 
                    case(fireworkType[i])
                        0:begin
                            if(( x_pos ==fireworkX[i] && (y_pos == fireworkY[i] || y_pos == fireworkY[i] + 2 ||y_pos == fireworkY[i] -2 ))||
                                ( y_pos ==fireworkY[i] && (x_pos == fireworkX[i] || x_pos == fireworkX[i] + 2 ||x_pos == fireworkX[i] -2 ))) oled_data = fireworkColor[i];
                        end
                        1: begin
                        if (i % 2 ==0) begin
                        case(pixel_count)
                        45: begin oled_data = fireworkColor[i] ; end
                        71: begin oled_data = fireworkColor[i] ; end
                        81: begin oled_data = fireworkColor[i] ; end
                        83: begin oled_data = fireworkColor[i] ; end
                        85: begin oled_data = fireworkColor[i] ; end
                        87: begin oled_data = fireworkColor[i] ; end
                        97: begin oled_data = fireworkColor[i] ; end
                        123: begin oled_data = fireworkColor[i] ; end
                        endcase
                        end
                        else begin
                        case(pixel_count)
                        45: begin oled_data = fireworkColor[i] ; end
                        56: begin oled_data = fireworkColor[i] ; end
                        58: begin oled_data = fireworkColor[i] ; end
                        60: begin oled_data = fireworkColor[i] ; end
                        81: begin oled_data = fireworkColor[i] ; end
                        82: begin oled_data = fireworkColor[i] ; end
                        84: begin oled_data = fireworkColor[i] ; end
                        86: begin oled_data = fireworkColor[i] ; end
                        87: begin oled_data = fireworkColor[i] ; end
                        108: begin oled_data = fireworkColor[i] ; end
                        110: begin oled_data = fireworkColor[i] ; end
                        112: begin oled_data = fireworkColor[i] ; end
                        123: begin oled_data = fireworkColor[i] ; end
                        endcase
                        end    
                            
                        end
                        2: begin
                        if (i % 2 ==0) begin
                        case(pixel_count)
                        32: begin oled_data = fireworkColor[i] ; end
                        44: begin oled_data = fireworkColor[i] ; end
                        46: begin oled_data = fireworkColor[i] ; end
                        58: begin oled_data = fireworkColor[i] ; end
                        68: begin oled_data = fireworkColor[i] ; end
                        74: begin oled_data = fireworkColor[i] ; end
                        80: begin oled_data = fireworkColor[i] ; end
                        82: begin oled_data = fireworkColor[i] ; end
                        84: begin oled_data = fireworkColor[i] ; end
                        86: begin oled_data = fireworkColor[i] ; end
                        88: begin oled_data = fireworkColor[i] ; end
                        94: begin oled_data = fireworkColor[i] ; end
                        100: begin oled_data = fireworkColor[i] ; end
                        110: begin oled_data = fireworkColor[i] ; end
                        122: begin oled_data = fireworkColor[i] ; end
                        124: begin oled_data = fireworkColor[i] ; end
                        136: begin oled_data = fireworkColor[i] ; end
                        endcase
                        end
                        else begin
                        case(pixel_count)
                        32: begin oled_data = fireworkColor[i] ; end
                        44: begin oled_data = fireworkColor[i] ; end
                        46: begin oled_data = fireworkColor[i] ; end
                        68: begin oled_data = fireworkColor[i] ; end
                        71: begin oled_data = fireworkColor[i] ; end
                        74: begin oled_data = fireworkColor[i] ; end
                        80: begin oled_data = fireworkColor[i] ; end
                        83: begin oled_data = fireworkColor[i] ; end
                        85: begin oled_data = fireworkColor[i] ; end
                        88: begin oled_data = fireworkColor[i] ; end
                        94: begin oled_data = fireworkColor[i] ; end
                        97: begin oled_data = fireworkColor[i] ; end
                        100: begin oled_data = fireworkColor[i] ; end
                        122: begin oled_data = fireworkColor[i] ; end
                        124: begin oled_data = fireworkColor[i] ; end
                        136: begin oled_data = fireworkColor[i] ; end
                        endcase
                        end
                        end
                        3: begin
                        if (i % 2 ==0) begin
                        case(pixel_count)
                        19: begin oled_data = fireworkColor[i] ; end
                        30: begin oled_data = fireworkColor[i] ; end
                        34: begin oled_data = fireworkColor[i] ; end
                        44: begin oled_data = fireworkColor[i] ; end
                        46: begin oled_data = fireworkColor[i] ; end
                        54: begin oled_data = fireworkColor[i] ; end
                        58: begin oled_data = fireworkColor[i] ; end
                        62: begin oled_data = fireworkColor[i] ; end
                        68: begin oled_data = fireworkColor[i] ; end
                        74: begin oled_data = fireworkColor[i] ; end
                        79: begin oled_data = fireworkColor[i] ; end
                        82: begin oled_data = fireworkColor[i] ; end
                        84: begin oled_data = fireworkColor[i] ; end
                        86: begin oled_data = fireworkColor[i] ; end
                        89: begin oled_data = fireworkColor[i] ; end
                        94: begin oled_data = fireworkColor[i] ; end
                        100: begin oled_data = fireworkColor[i] ; end
                        106: begin oled_data = fireworkColor[i] ; end
                        110: begin oled_data = fireworkColor[i] ; end
                        114: begin oled_data = fireworkColor[i] ; end
                        122: begin oled_data = fireworkColor[i] ; end
                        124: begin oled_data = fireworkColor[i] ; end
                        134: begin oled_data = fireworkColor[i] ; end
                        138: begin oled_data = fireworkColor[i] ; end
                        149: begin oled_data = fireworkColor[i] ; end
                        endcase
                        end
                        else begin
                        case(pixel_count)
                        32: begin oled_data = fireworkColor[i] ; end
                        42: begin oled_data = fireworkColor[i] ; end
                        44: begin oled_data = fireworkColor[i] ; end
                        46: begin oled_data = fireworkColor[i] ; end
                        48: begin oled_data = fireworkColor[i] ; end
                        56: begin oled_data = fireworkColor[i] ; end
                        58: begin oled_data = fireworkColor[i] ; end
                        60: begin oled_data = fireworkColor[i] ; end
                        68: begin oled_data = fireworkColor[i] ; end
                        74: begin oled_data = fireworkColor[i] ; end
                        80: begin oled_data = fireworkColor[i] ; end
                        82: begin oled_data = fireworkColor[i] ; end
                        84: begin oled_data = fireworkColor[i] ; end
                        86: begin oled_data = fireworkColor[i] ; end
                        88: begin oled_data = fireworkColor[i] ; end
                        94: begin oled_data = fireworkColor[i] ; end
                        100: begin oled_data = fireworkColor[i] ; end
                        108: begin oled_data = fireworkColor[i] ; end
                        110: begin oled_data = fireworkColor[i] ; end
                        112: begin oled_data = fireworkColor[i] ; end
                        120: begin oled_data = fireworkColor[i] ; end
                        122: begin oled_data = fireworkColor[i] ; end
                        124: begin oled_data = fireworkColor[i] ; end
                        126: begin oled_data = fireworkColor[i] ; end
                        136: begin oled_data = fireworkColor[i] ; end
                        endcase
                        end
                        end
                        4: begin
                        if (i % 2 ==0) begin
                        case(pixel_count)
                        6: begin oled_data = fireworkColor[i] ; end
                        14: begin oled_data = fireworkColor[i] ; end
                        18: begin oled_data = fireworkColor[i] ; end
                        20: begin oled_data = fireworkColor[i] ; end
                        24: begin oled_data = fireworkColor[i] ; end
                        28: begin oled_data = fireworkColor[i] ; end
                        36: begin oled_data = fireworkColor[i] ; end
                        42: begin oled_data = fireworkColor[i] ; end
                        44: begin oled_data = fireworkColor[i] ; end
                        46: begin oled_data = fireworkColor[i] ; end
                        48: begin oled_data = fireworkColor[i] ; end
                        58: begin oled_data = fireworkColor[i] ; end
                        66: begin oled_data = fireworkColor[i] ; end
                        68: begin oled_data = fireworkColor[i] ; end
                        74: begin oled_data = fireworkColor[i] ; end
                        76: begin oled_data = fireworkColor[i] ; end
                        78: begin oled_data = fireworkColor[i] ; end
                        82: begin oled_data = fireworkColor[i] ; end
                        84: begin oled_data = fireworkColor[i] ; end
                        86: begin oled_data = fireworkColor[i] ; end
                        90: begin oled_data = fireworkColor[i] ; end
                        92: begin oled_data = fireworkColor[i] ; end
                        94: begin oled_data = fireworkColor[i] ; end
                        100: begin oled_data = fireworkColor[i] ; end
                        102: begin oled_data = fireworkColor[i] ; end
                        110: begin oled_data = fireworkColor[i] ; end
                        120: begin oled_data = fireworkColor[i] ; end
                        122: begin oled_data = fireworkColor[i] ; end
                        124: begin oled_data = fireworkColor[i] ; end
                        126: begin oled_data = fireworkColor[i] ; end
                        132: begin oled_data = fireworkColor[i] ; end
                        140: begin oled_data = fireworkColor[i] ; end
                        144: begin oled_data = fireworkColor[i] ; end
                        148: begin oled_data = fireworkColor[i] ; end
                        150: begin oled_data = fireworkColor[i] ; end
                        154: begin oled_data = fireworkColor[i] ; end
                        162: begin oled_data = fireworkColor[i] ; end
                        endcase
                        end
                        else begin
                        case(pixel_count)
                        5: begin oled_data = fireworkColor[i] ; end
                        7: begin oled_data = fireworkColor[i] ; end
                        17: begin oled_data = fireworkColor[i] ; end
                        19: begin oled_data = fireworkColor[i] ; end
                        21: begin oled_data = fireworkColor[i] ; end
                        29: begin oled_data = fireworkColor[i] ; end
                        31: begin oled_data = fireworkColor[i] ; end
                        33: begin oled_data = fireworkColor[i] ; end
                        35: begin oled_data = fireworkColor[i] ; end
                        41: begin oled_data = fireworkColor[i] ; end
                        45: begin oled_data = fireworkColor[i] ; end
                        49: begin oled_data = fireworkColor[i] ; end
                        53: begin oled_data = fireworkColor[i] ; end
                        63: begin oled_data = fireworkColor[i] ; end
                        65: begin oled_data = fireworkColor[i] ; end
                        67: begin oled_data = fireworkColor[i] ; end
                        70: begin oled_data = fireworkColor[i] ; end
                        72: begin oled_data = fireworkColor[i] ; end
                        75: begin oled_data = fireworkColor[i] ; end
                        77: begin oled_data = fireworkColor[i] ; end
                        79: begin oled_data = fireworkColor[i] ; end
                        81: begin oled_data = fireworkColor[i] ; end
                        84: begin oled_data = fireworkColor[i] ; end
                        87: begin oled_data = fireworkColor[i] ; end
                        89: begin oled_data = fireworkColor[i] ; end
                        91: begin oled_data = fireworkColor[i] ; end
                        93: begin oled_data = fireworkColor[i] ; end
                        96: begin oled_data = fireworkColor[i] ; end
                        98: begin oled_data = fireworkColor[i] ; end
                        101: begin oled_data = fireworkColor[i] ; end
                        103: begin oled_data = fireworkColor[i] ; end
                        105: begin oled_data = fireworkColor[i] ; end
                        115: begin oled_data = fireworkColor[i] ; end
                        119: begin oled_data = fireworkColor[i] ; end
                        123: begin oled_data = fireworkColor[i] ; end
                        127: begin oled_data = fireworkColor[i] ; end
                        133: begin oled_data = fireworkColor[i] ; end
                        135: begin oled_data = fireworkColor[i] ; end
                        137: begin oled_data = fireworkColor[i] ; end
                        139: begin oled_data = fireworkColor[i] ; end
                        147: begin oled_data = fireworkColor[i] ; end
                        149: begin oled_data = fireworkColor[i] ; end
                        151: begin oled_data = fireworkColor[i] ; end
                        161: begin oled_data = fireworkColor[i] ; end
                        163: begin oled_data = fireworkColor[i] ; end
                        endcase
                        end
                        end
                    endcase
                end
            end
        end
    end
endmodule
