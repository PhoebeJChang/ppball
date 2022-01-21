include ppball.inc

; 框架大小和顏色宣告
PLAY_T_EDGE_OFFSET equ 5d
PLAY_L_EDGE_OFFSET equ 20d
BOARD_R_LENGTH equ 80d                      ;長row
BOARD_C_LENGTH equ 1d                       ;寬cloumn
BOARD_BETWEEN equ 25d                       ;板子間距離

;新增左右兩側看不到的黑色boards
PLAY_BLACK_X1 equ 14d                  
PLAY_BLACK_Y1 equ 4d
PLAY_BLACK_X2 equ 104d                  
PLAY_BLACK_Y2 equ 4d

MENU_PPBALL_COLOR equ yellow + (cyan*16)         ;menu PPBALL
MENU_TEXT_COLOR equ white + (black*16)
UP_DOWN_B_COLOR equ (lightGray * 16)             ;上下板子顏色
PADDLE_COLOR equ blue+(lightCyan * 16)           ;左paddle color
PADDLE_COLOR_TWO equ yellow+(lightRed*16)        ;右paddle color
BALL_COLOR equ black+(yellow * 16)

;球以每0.1秒速度移動
FRAME_RATE equ 100d                          ;球跑的速度

;reset時間等待1.5秒
RESET_BALL_RATE equ 1500d                    ;球reset 冷卻時間


.data

; 上板子Y座標(5)
playTopEdge dword (PLAY_T_EDGE_OFFSET)
; 下板子Y座標(5+25)
playLowEdge dword (PLAY_T_EDGE_OFFSET + BOARD_BETWEEN)

;球的起始座標，X = 20+40，Y = 5+12
Ball_X dword (PLAY_L_EDGE_OFFSET + 40)
Ball_Y dword (PLAY_T_EDGE_OFFSET + 12)

;球移動45度角，因為球為兩個空白鍵所組成
;X座標移動需要設為2，而非1
xMove dword 2
yMove dword 1

;paddle 起始座標
;左側player1
p1X dword (PLAY_L_EDGE_OFFSET)                 ;設定p1 paddle 位置在左側邊邊
p1Y dword (PLAY_T_EDGE_OFFSET + (BOARD_BETWEEN / 2) + 2)

;右側player2
p2X dword (PLAY_L_EDGE_OFFSET + BOARD_R_LENGTH - 1)
p2Y dword (PLAY_T_EDGE_OFFSET + (BOARD_BETWEEN / 2) + 2)

paddleHeight dword 5d       ;paddle長

; 填滿東東String
space byte " ", 0
space2 byte "  ", 0
spacePaddle byte "*", 0
buffer byte "  "            ;球球實心笑臉，沒了QAQ

; gui information 玩家計分
;p1scoreString byte "Player 1 score:", 0
;p2scoreString byte "Player 2 score:", 0
;p1score dword 0
;p2score dword 0

.code
main proc
    call clrscr

Menu:
    invoke MenuPage, MENU_PPBALL_COLOR, MENU_TEXT_COLOR


stop:
    call ReadChar
    call clrscr

ppballMain:
     
     ;上下板子
     invoke DrawFrame, UP_DOWN_B_COLOR, PLAY_T_EDGE_OFFSET, PLAY_L_EDGE_OFFSET, BOARD_R_LENGTH, BOARD_BETWEEN, BOARD_C_LENGTH, addr space
     
     ;玩家paddle初始和移動
     invoke ShowFirstTwoPaddles, PADDLE_COLOR, PADDLE_COLOR_TWO, PLAY_BLACK_X1, PLAY_BLACK_Y1, PLAY_BLACK_X2, PLAY_BLACK_Y2, 
                                 addr p1X, addr p1Y, addr p2X, addr p2Y, addr paddleHeight, addr spacePaddle
	 invoke ReadKeyBoard, PADDLE_COLOR, PADDLE_COLOR_TWO, addr p1X, addr p1Y, addr p2X, addr p2Y, 
                          paddleHeight, playTopEdge, playLowEdge, addr spacePaddle
     
     ;球的
     invoke Ball, BALL_COLOR, addr Ball_X, addr Ball_Y, addr xMove, addr yMove, addr buffer, PLAY_T_EDGE_OFFSET, 
                        BOARD_BETWEEN, p1X, p1Y, p2X, p2Y, paddleHeight, RESET_BALL_RATE
     
     invoke SpeedOfBall, FRAME_RATE

     
	jmp ppballMain
	
	
     exit
main endp
end main