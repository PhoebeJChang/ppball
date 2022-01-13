include ppball.inc

; 框架大小和顏色宣告
PLAY_T_EDGE_OFFSET equ 5d
PLAY_L_EDGE_OFFSET equ 20d
BOARD_R_LENGTH equ 80d                      ;長row
BOARD_C_LENGTH equ 1d                       ;寬cloumn
BOARD_BETWEEN equ 25d                       ;板子間距離

GUI_TEXT_COLOR equ (white)
GUI_COLOR equ lightMagenta+(lightGray * 16)      ;上下板子顏色
PADDLE_COLOR equ blue+(lightCyan * 16)           ;左右paddle color
BALL_COLOR equ black+(yellow * 16)

FRAME_RATE equ 100d                          ;速度

.data
;menu byte "hellooooooooooooooo", 0

; for passing into prototypes
playTopEdge dword (PLAY_T_EDGE_OFFSET)
playLowEdge dword (PLAY_T_EDGE_OFFSET + BOARD_BETWEEN)

; ball and paddle tracking
Ball_X dword PLAY_L_EDGE_OFFSET + 30
Ball_Y dword PLAY_T_EDGE_OFFSET + 15
xRun dword 2
yRise dword 1

; 填滿東東String
space byte " ", 0
spacePaddle byte "*",0
buffer byte 2h            ;球球實心笑臉

player1X dword (PLAY_L_EDGE_OFFSET)                 ;設定p1 paddle 位置在左側邊邊
player1Y dword (PLAY_T_EDGE_OFFSET + (BOARD_BETWEEN / 2) + 2)
player2X dword (PLAY_L_EDGE_OFFSET + BOARD_R_LENGTH - 1)
player2Y dword (PLAY_T_EDGE_OFFSET + (BOARD_BETWEEN / 2) + 2)

paddleHeight dword 5d       ;paddle長



; gui information 玩家計分
;p1scoreString byte "Player 1 score:", 0
;p2scoreString byte "Player 2 score:", 0
;p1score dword 0
;p2score dword 0

.code
main proc
     mov eax, 0
     call SetTextColor
     invoke DrawFrame, GUI_COLOR, PLAY_T_EDGE_OFFSET, PLAY_L_EDGE_OFFSET, BOARD_R_LENGTH, BOARD_BETWEEN, BOARD_C_LENGTH, addr space

     invoke ShowFirstTwoPaddles, PADDLE_COLOR, addr player1X, addr player1Y, addr player2X, addr player2Y, addr paddleHeight, addr spacePaddle

     mov ecx, 1
MainLoop:
	 invoke UpdateBall, addr Ball_X, addr Ball_Y, BALL_COLOR, addr xRun, addr yRise, addr buffer, PLAY_T_EDGE_OFFSET, 
                        BOARD_BETWEEN, player1X, player1Y, player2X, player2Y, paddleHeight
     inc ecx ; increment ecx to keep the loop going...when the ball goes out of bounds, set ecx to 0 so the inner loop can finish
     invoke Chill, FRAME_RATE

     ; check for movement and redraw paddle accordingly
     invoke ReadKey, PADDLE_COLOR, addr player1x, addr player1Y, addr player2X, addr player2y, paddleHeight, 
                            playTopEdge, playLowEdge
	jmp MainLoop
	
	
     exit
main endp
end main