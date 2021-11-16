`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2021 07:42:49 PM
// Design Name: 
// Module Name: brick_game
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


module brick_game(
    input CLK,
    input [2:0] display_setting,
    input[15:0] background,
    input [3:0] volume,
    input btnC,btnL,btnR, //CONTROL
    input [12:0] pixel_index,
    output[15:0] oled_data 
    );

    wire count_0_16s;
    clk_variable clk2(CLK, 7999999, count_0_16s);
    
    //game state
    reg  win = 0,lose = 0,transition = 1;
    reg[2:0] round = 1;
    reg [10:0] score;
    reg [6:0] x_pos = 0;
    reg [5:0] y_pos = 0; 
    reg [3:0] speed = 1;
    //reg [15:0] background = 0;
    
    //for enemy
    reg [6:0] enemyX[5:0];
    reg [6:0] enemyY;
    reg [5:0] enemyAlive = 6'b111111;
    reg [6:0] enemyState = 1;
    reg enemyDir = 1;

    //boundary
    reg [6:0] left_bound = 2,right_bound = 93;
    //for shooty things
    reg[3:0] bullet_left = 8;
    reg[6:0] bulletX[7:0],bulletY[7:0];
    //reg[6:0] ballX_next[4:0] ,ballY_next[4:0];
    
    //reg [3:0] win_state = 0;
    reg [3:0] transition_state = 5;
    reg [2:0] win_state = 1;
    //spaceship position
    reg[6:0] spaceX = 48;
    
    //boolean for collision
    wire [5:0] hit; 
    //collision logic
   assign hit[0] = ((enemyY <= bulletY[0] && bulletY[0] <= ( enemyY + 17) &&  enemyX[0] <= bulletX[0] && bulletX[0] <= (enemyX[0] +9))||(enemyY <= bulletY[1] && bulletY[1] <= ( enemyY + 17) &&  enemyX[0] <= bulletX[1] && bulletX[1] <= (enemyX[0] +9))||(enemyY <= bulletY[2] && bulletY[2] <= ( enemyY + 17) &&  enemyX[0] <= bulletX[2] && bulletX[2] <= (enemyX[0] +9))||(enemyY <= bulletY[3] && bulletY[3] <= ( enemyY + 17) &&  enemyX[0] <= bulletX[3] && bulletX[3] <= (enemyX[0] +9))||(enemyY <= bulletY[4] && bulletY[4] <= ( enemyY + 17) &&  enemyX[0] <= bulletX[4] && bulletX[4] <= (enemyX[0] +9))||(enemyY <= bulletY[5] && bulletY[5] <= ( enemyY + 17) &&  enemyX[0] <= bulletX[5] && bulletX[5] <= (enemyX[0] +9))||(enemyY <= bulletY[6] && bulletY[6] <= ( enemyY + 17) &&  enemyX[0] <= bulletX[6] && bulletX[6] <= (enemyX[0] +9))||(enemyY <= bulletY[7] && bulletY[7] <= ( enemyY + 17) &&  enemyX[0] <= bulletX[7] && bulletX[7] <= (enemyX[0] +9)));
   assign hit[1] = ((enemyY <= bulletY[0] && bulletY[0] <= ( enemyY + 17) &&  enemyX[1] <= bulletX[0] && bulletX[0] <= (enemyX[1] +9))||(enemyY <= bulletY[1] && bulletY[1] <= ( enemyY + 17) &&  enemyX[1] <= bulletX[1] && bulletX[1] <= (enemyX[1] +9))||(enemyY <= bulletY[2] && bulletY[2] <= ( enemyY + 17) &&  enemyX[1] <= bulletX[2] && bulletX[2] <= (enemyX[1] +9))||(enemyY <= bulletY[3] && bulletY[3] <= ( enemyY + 17) &&  enemyX[1] <= bulletX[3] && bulletX[3] <= (enemyX[1] +9))||(enemyY <= bulletY[4] && bulletY[4] <= ( enemyY + 17) &&  enemyX[1] <= bulletX[4] && bulletX[4] <= (enemyX[1] +9))||(enemyY <= bulletY[5] && bulletY[5] <= ( enemyY + 17) &&  enemyX[1] <= bulletX[5] && bulletX[5] <= (enemyX[1] +9))||(enemyY <= bulletY[6] && bulletY[6] <= ( enemyY + 17) &&  enemyX[1] <= bulletX[6] && bulletX[6] <= (enemyX[1] +9))||(enemyY <= bulletY[7] && bulletY[7] <= ( enemyY + 17) &&  enemyX[1] <= bulletX[7] && bulletX[7] <= (enemyX[1] +9)));
   assign hit[2] = ((enemyY <= bulletY[0] && bulletY[0] <= ( enemyY + 17) &&  enemyX[2] <= bulletX[0] && bulletX[0] <= (enemyX[2] +9))||(enemyY <= bulletY[1] && bulletY[1] <= ( enemyY + 17) &&  enemyX[2] <= bulletX[1] && bulletX[1] <= (enemyX[2] +9))||(enemyY <= bulletY[2] && bulletY[2] <= ( enemyY + 17) &&  enemyX[2] <= bulletX[2] && bulletX[2] <= (enemyX[2] +9))||(enemyY <= bulletY[3] && bulletY[3] <= ( enemyY + 17) &&  enemyX[2] <= bulletX[3] && bulletX[3] <= (enemyX[2] +9))||(enemyY <= bulletY[4] && bulletY[4] <= ( enemyY + 17) &&  enemyX[2] <= bulletX[4] && bulletX[4] <= (enemyX[2] +9))||(enemyY <= bulletY[5] && bulletY[5] <= ( enemyY + 17) &&  enemyX[2] <= bulletX[5] && bulletX[5] <= (enemyX[2] +9))||(enemyY <= bulletY[6] && bulletY[6] <= ( enemyY + 17) &&  enemyX[2] <= bulletX[6] && bulletX[6] <= (enemyX[2] +9))||(enemyY <= bulletY[7] && bulletY[7] <= ( enemyY + 17) &&  enemyX[2] <= bulletX[7] && bulletX[7] <= (enemyX[2] +9)));
   assign hit[3] = ((enemyY <= bulletY[0] && bulletY[0] <= ( enemyY + 17) &&  enemyX[3] <= bulletX[0] && bulletX[0] <= (enemyX[3] +9))||(enemyY <= bulletY[1] && bulletY[1] <= ( enemyY + 17) &&  enemyX[3] <= bulletX[1] && bulletX[1] <= (enemyX[3] +9))||(enemyY <= bulletY[2] && bulletY[2] <= ( enemyY + 17) &&  enemyX[3] <= bulletX[2] && bulletX[2] <= (enemyX[3] +9))||(enemyY <= bulletY[3] && bulletY[3] <= ( enemyY + 17) &&  enemyX[3] <= bulletX[3] && bulletX[3] <= (enemyX[3] +9))||(enemyY <= bulletY[4] && bulletY[4] <= ( enemyY + 17) &&  enemyX[3] <= bulletX[4] && bulletX[4] <= (enemyX[3] +9))||(enemyY <= bulletY[5] && bulletY[5] <= ( enemyY + 17) &&  enemyX[3] <= bulletX[5] && bulletX[5] <= (enemyX[3] +9))||(enemyY <= bulletY[6] && bulletY[6] <= ( enemyY + 17) &&  enemyX[3] <= bulletX[6] && bulletX[6] <= (enemyX[3] +9))||(enemyY <= bulletY[7] && bulletY[7] <= ( enemyY + 17) &&  enemyX[3] <= bulletX[7] && bulletX[7] <= (enemyX[3] +9)));
   assign hit[4] = ((enemyY <= bulletY[0] && bulletY[0] <= ( enemyY + 17) &&  enemyX[4] <= bulletX[0] && bulletX[0] <= (enemyX[4] +9))||(enemyY <= bulletY[1] && bulletY[1] <= ( enemyY + 17) &&  enemyX[4] <= bulletX[1] && bulletX[1] <= (enemyX[4] +9))||(enemyY <= bulletY[2] && bulletY[2] <= ( enemyY + 17) &&  enemyX[4] <= bulletX[2] && bulletX[2] <= (enemyX[4] +9))||(enemyY <= bulletY[3] && bulletY[3] <= ( enemyY + 17) &&  enemyX[4] <= bulletX[3] && bulletX[3] <= (enemyX[4] +9))||(enemyY <= bulletY[4] && bulletY[4] <= ( enemyY + 17) &&  enemyX[4] <= bulletX[4] && bulletX[4] <= (enemyX[4] +9))||(enemyY <= bulletY[5] && bulletY[5] <= ( enemyY + 17) &&  enemyX[4] <= bulletX[5] && bulletX[5] <= (enemyX[4] +9))||(enemyY <= bulletY[6] && bulletY[6] <= ( enemyY + 17) &&  enemyX[4] <= bulletX[6] && bulletX[6] <= (enemyX[4] +9))||(enemyY <= bulletY[7] && bulletY[7] <= ( enemyY + 17) &&  enemyX[4] <= bulletX[7] && bulletX[7] <= (enemyX[4] +9)));
   assign hit[5] = ((enemyY <= bulletY[0] && bulletY[0] <= ( enemyY + 17) &&  enemyX[5] <= bulletX[0] && bulletX[0] <= (enemyX[5] +9))||(enemyY <= bulletY[1] && bulletY[1] <= ( enemyY + 17) &&  enemyX[5] <= bulletX[1] && bulletX[1] <= (enemyX[5] +9))||(enemyY <= bulletY[2] && bulletY[2] <= ( enemyY + 17) &&  enemyX[5] <= bulletX[2] && bulletX[2] <= (enemyX[5] +9))||(enemyY <= bulletY[3] && bulletY[3] <= ( enemyY + 17) &&  enemyX[5] <= bulletX[3] && bulletX[3] <= (enemyX[5] +9))||(enemyY <= bulletY[4] && bulletY[4] <= ( enemyY + 17) &&  enemyX[5] <= bulletX[4] && bulletX[4] <= (enemyX[5] +9))||(enemyY <= bulletY[5] && bulletY[5] <= ( enemyY + 17) &&  enemyX[5] <= bulletX[5] && bulletX[5] <= (enemyX[5] +9))||(enemyY <= bulletY[6] && bulletY[6] <= ( enemyY + 17) &&  enemyX[5] <= bulletX[6] && bulletX[6] <= (enemyX[5] +9))||(enemyY <= bulletY[7] && bulletY[7] <= ( enemyY + 17) &&  enemyX[5] <= bulletX[7] && bulletX[7] <= (enemyX[5] +9)));   
   
   integer i ;
    initial begin
    for (i = 0; i < 8; i = i + 1) begin
        bulletX[i] = 0;bulletY[i] = 0;
    end
    //enemy position
    enemyX[0] = 7;enemyX[1] = 22;enemyX[2] = 37; enemyX[3] = 52; enemyX[4] = 67;enemyX[5] = 82; enemyY = 41;
    end
    
    //boolean logic

    //GAME LOGIC
    always @(posedge count_0_16s) begin
      if (display_setting == 5) begin
            if(!win && !lose && ! transition) begin
                //spaceship movement
                if(volume < 4) speed = 1;
                else if ( volume < 8) speed = 2;
                else if (volume < 12) speed = 3;
                else speed = 4;
                if(btnL) begin
                    spaceX = spaceX <= (left_bound + 7) ? spaceX : spaceX - 2;
                end
                else if(btnR) begin
                    spaceX = spaceX >= (right_bound - 7) ? spaceX : spaceX + 2;
                end
                //shoot
                if(btnC) begin
                    case(bullet_left)
                        8: begin bulletX[0] = spaceX; bulletY[0] = 12; end
                        7: begin bulletX[1] = spaceX; bulletY[1] = 12; end
                        6: begin bulletX[2] = spaceX; bulletY[2] = 12; end
                        5: begin bulletX[3] = spaceX; bulletY[3] = 12; end
                        4: begin bulletX[4] = spaceX; bulletY[4] = 12; end
                        3: begin bulletX[5] = spaceX; bulletY[5] = 12; end
                        2: begin bulletX[6] = spaceX; bulletY[6] = 12; end
                        1: begin bulletX[7] = spaceX; bulletY[7] = 12; end
                    endcase
                    bullet_left = bullet_left != 0 ? bullet_left - 1 : 8;
                end 
                //collision
                for (i = 0; i < 6; i = i + 1) begin
                    enemyAlive[i] = (hit[i] && enemyAlive[i])? 0:enemyAlive[i];
                end
                for (i = 0; i < 8; i = i + 1) begin
                    if(bulletY[i] >= 62 || bulletX[i] == 0) begin
                        bulletY[i] = 0; bulletX[i] = 0;
                    end
                    else bulletY[i] =  bulletY[i] + speed ;
                end
                if(enemyX[5] >= 85) enemyDir = 0; // move left
                else if(enemyX[0] <= 1) enemyDir = 1; // move right
                if(enemyDir == 1 &&enemyState == 0 && enemyY > 12)begin
                    for (i = 0; i < 6; i = i + 1) begin
                        enemyX[i] = enemyX[i] + 1;
                    end
                end
                else if(enemyDir == 0 &&enemyState == 0 && enemyY > 12) begin
                for (i = 0; i < 6; i = i + 1) begin
                      enemyX[i] = enemyX[i] - 1;
                end
                    
                end
                enemyY = (enemyState == 0 && enemyY > 11)? enemyY - 1: enemyY;
                enemyState = enemyState >= 8 ? 0: enemyState + round;
                lose = enemyY <= 11? 1:0;
                win = enemyAlive ? 0 : 1;                  
            end
            else if (transition) begin
                transition_state = transition_state - 1;
                transition = transition_state == 0 ? 0:1;
            end
            else if (win) begin
             //For now
                if(btnC && round < 3) begin
                    round = round + 1;
                    bullet_left = 8;
                    enemyAlive = 6'b111111;
                    enemyX[0] = 7; enemyX[1] = 22; enemyX[2] = 37;enemyX[3] = 52;enemyX[4] = 67;enemyX[5] = 82;enemyY = 41;
                    for (i = 0; i < 8; i = i + 1) begin
                            bulletX[i] = 0; bulletY[i] = 0;
                    end
                    transition_state = 6;
                    transition = 1;
                    win = 0;
                end
                else if(round >= 3) begin
                    win_state = btnC ? win_state + 1: win_state;
                    if(win_state  >  4) begin
                        round =  1;
                        bullet_left = 8;
                        enemyAlive = 6'b111111;
                        enemyX[0] = 7;enemyX[1] = 22;enemyX[2] = 37;enemyX[3] = 52;enemyX[4] = 67;enemyX[5] = 82;enemyY = 41;
                        for (i = 0; i < 8; i = i + 1) begin
                            bulletX[i] = 0; bulletY[i] = 0;
                        end
                        transition_state = 6;
                        transition = 1;
                        win_state = 1;
                        win = 0;                  
                    end
                end
            end
            else if (lose) begin
                    //GAME OVER, TRY AGAIN ?
                    if(btnC ) begin
                       round =  1;
                        bullet_left = 8;
                       enemyAlive = 6'b111111;
                       enemyX[0] = 7;enemyX[1] = 22;enemyX[2] = 37;enemyX[3] = 52;enemyX[4] = 67;enemyX[5] = 82;enemyY = 41;
                       for (i = 0; i < 8; i = i + 1) begin
                        bulletX[i] = 0; bulletY[i] = 0;
                      end
                      transition_state = 6;
                      transition = 1;
                      lose = 0;
              end
            end
        end
    end
    
    spaceship_game_display(pixel_index,win, lose, transition,spaceX, bulletX[0],bulletX[1],bulletX[2],bulletX[3],bulletX[4],bulletX[5],bulletX[6],bulletX[7],
    bulletY[0],bulletY[1],bulletY[2],bulletY[3],bulletY[4],bulletY[5],bulletY[6],bulletY[7],enemyX[0],enemyX[1],enemyX[2],enemyX[3],enemyX[4],enemyX[5],enemyX[6],enemyX[7],
    enemyY,enemyAlive,round,win_state,background,display_setting,oled_data);
    
endmodule
