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
;ppballHeight1 dword 6
;ppballHeight2 dword 2
;Menu Page
MenuTitle byte "PPball !!",0
MenuClass byte "- 資工二甲 -" ,0
MenuOurName1 byte "張甄庭 409261287",0
MenuOurName2 byte "鍾馥羽 409261328",0
MenuIntroTitle byte "************** -  遊戲介紹  - ***************",0
MenuPlayerOne1 byte "玩家一需要使用W、S鍵",0
MenuPlayerOne2 byte "來控制左邊的",0
MenuPlayerOne3 byte "藍色PADDLE",0
MenuPlayerOne4 byte "上下移動",0

MenuPlayerTwo1 byte "玩家二需要使用上、下鍵",0
MenuPlayerTwo2 byte "來控制右邊的",0
MenuPlayerTwo3 byte "紅色PADDLE",0
MenuPlayerTwo4 byte "上下移動",0

MenuStartGame1 byte "---------- 請按任意鍵 ----------",0
MenuStartGame2 byte "開始遊戲",0


; for passing into prototypes
playTopEdge dword (PLAY_T_EDGE_OFFSET)
playLowEdge dword (PLAY_T_EDGE_OFFSET + BOARD_BETWEEN)

; ball and paddle tracking
Ball_X dword PLAY_L_EDGE_OFFSET + 30
Ball_Y dword PLAY_T_EDGE_OFFSET + 15
xRun dword 2              ;
yRise dword 1

; 填滿東東String
space byte " ", 0
space2 byte "  ",0
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
    call clrscr

Menu:
    ;macros
    mGotoxy 55,4
    mov eax, yellow(cyan*16)
    call SetTextColor
    
    ;mWriteString OFFSET MenuTitle
    
    ;P
    mGotoxy 30,1
    mWriteString OFFSET space2
    mGotoxy 30,2
    mWriteString OFFSET space2
    mGotoxy 30,3
    mWriteString OFFSET space2
    mGotoxy 30,4
    mWriteString OFFSET space2
    mGotoxy 30,5
    mWriteString OFFSET space2
    mGotoxy 30,6
    mWriteString OFFSET space2

    mGotoxy 32,1
    mWriteString OFFSET space2
    mGotoxy 34,1
    mWriteString OFFSET space2

    mGotoxy 36,2
    mWriteString OFFSET space2
    mGotoxy 36,3
    mWriteString OFFSET space2

    mGotoxy 32,4
    mWriteString OFFSET space2
    mGotoxy 34,4
    mWriteString OFFSET space2

    ;P
    mGotoxy 40,1
    mWriteString OFFSET space2
    mGotoxy 40,2
    mWriteString OFFSET space2
    mGotoxy 40,3
    mWriteString OFFSET space2
    mGotoxy 40,4
    mWriteString OFFSET space2
    mGotoxy 40,5
    mWriteString OFFSET space2
    mGotoxy 40,6
    mWriteString OFFSET space2

    mGotoxy 42,1
    mWriteString OFFSET space2
    mGotoxy 44,1
    mWriteString OFFSET space2

    mGotoxy 46,2
    mWriteString OFFSET space2
    mGotoxy 46,3
    mWriteString OFFSET space2

    mGotoxy 42,4
    mWriteString OFFSET space2
    mGotoxy 44,4
    mWriteString OFFSET space2
    
    ;B
    mGotoxy 50,1
    mWriteString OFFSET space2
    mGotoxy 50,2
    mWriteString OFFSET space2
    mGotoxy 50,3
    mWriteString OFFSET space2
    mGotoxy 50,4
    mWriteString OFFSET space2
    mGotoxy 50,5
    mWriteString OFFSET space2
    mGotoxy 50,6
    mWriteString OFFSET space2

    mGotoxy 52,1
    mWriteString OFFSET space2
    mGotoxy 54,1
    mWriteString OFFSET space2

    mGotoxy 56,2
    mWriteString OFFSET space2
    mGotoxy 56,3

    mGotoxy 52,3
    mWriteString OFFSET space2
    mGotoxy 54,3
    mWriteString OFFSET space2

    mGotoxy 56,4
    mWriteString OFFSET space2
    mGotoxy 56,5
    mWriteString OFFSET space2

    mGotoxy 52,6
    mWriteString OFFSET space2
    mGotoxy 54,6
    mWriteString OFFSET space2


    ;A
    mGotoxy 60,2
    mWriteString OFFSET space2
    mGotoxy 60,3
    mWriteString OFFSET space2
    mGotoxy 60,4
    mWriteString OFFSET space2
    mGotoxy 60,5
    mWriteString OFFSET space2
    mGotoxy 60,6
    mWriteString OFFSET space2

    mGotoxy 66,2
    mWriteString OFFSET space2
    mGotoxy 66,3
    mWriteString OFFSET space2
    mGotoxy 66,4
    mWriteString OFFSET space2
    mGotoxy 66,5
    mWriteString OFFSET space2
    mGotoxy 66,6
    mWriteString OFFSET space2

    mGotoxy 62,1
    mWriteString OFFSET space2
    mGotoxy 64,1
    mWriteString OFFSET space2

    mGotoxy 62,4
    mWriteString OFFSET space2
    mGotoxy 64,4
    mWriteString OFFSET space2

    ;L
    mGotoxy 70,1
    mWriteString OFFSET space2
    mGotoxy 70,2
    mWriteString OFFSET space2
    mGotoxy 70,3
    mWriteString OFFSET space2
    mGotoxy 70,4
    mWriteString OFFSET space2
    mGotoxy 70,5
    mWriteString OFFSET space2
    mGotoxy 70,6
    mWriteString OFFSET space2

    mGotoxy 72,6
    mWriteString OFFSET space2
    mGotoxy 74,6
    mWriteString OFFSET space2
    mGotoxy 76,6
    mWriteString OFFSET space2

    ;L
    mGotoxy 80,1
    mWriteString OFFSET space2
    mGotoxy 80,2
    mWriteString OFFSET space2
    mGotoxy 80,3
    mWriteString OFFSET space2
    mGotoxy 80,4
    mWriteString OFFSET space2
    mGotoxy 80,5
    mWriteString OFFSET space2
    mGotoxy 80,6
    mWriteString OFFSET space2

    mGotoxy 82,6
    mWriteString OFFSET space2
    mGotoxy 84,6
    mWriteString OFFSET space2
    mGotoxy 86,6
    mWriteString OFFSET space2

    ;WE ARE?
    mov eax, white + (gray*16)
    call SetTextColor
    mGotoxy 53,10
    mWriteString OFFSET MenuClass

    mov eax, white + (black*16)
    call SetTextColor
    mGotoxy 51,13
    mWriteString OFFSET MenuOurName1
    mGotoxy 51,15
    mWriteString OFFSET MenuOurName2

    ;遊戲介紹 
    mov eax, white + (gray*16)
    call SetTextColor
    mGotoxy 37,18
    mWriteString OFFSET MenuIntroTitle      ;遊戲介紹

    mov eax, white + (black*16)
    call SetTextColor
    mGotoxy 50, 20
    mWriteString OFFSET MenuPlayerOne1
    mGotoxy 45,22
    mWriteString OFFSET MenuPlayerOne2
    mov eax, white + (lightBlue*16)
    call SetTextColor
    mWriteString OFFSET MenuPlayerOne3
    mov eax, white + (black*16)
    call SetTextColor
    mWriteString OFFSET MenuPlayerOne4

    mGotoxy 50, 25
    mWriteString OFFSET MenuPlayerTwo1
    mGotoxy 45,27
    mWriteString OFFSET MenuPlayerTwo2
    mov eax, white + (lightRed*16)
    call SetTextColor
    mWriteString OFFSET MenuPlayerTwo3
    mov eax, white + (black*16)
    call SetTextColor
    mWriteString OFFSET MenuPlayerTwo4

    mGotoxy 44, 30
    mWriteString OFFSET MenuStartGame1
    mov eax, white + (lightMagenta*16)
    call SetTextColor
    mGotoxy 56, 32
    mWriteString OFFSET MenuStartGame2
    mov eax, white + (black*16)
    call SetTextColor
    mWriteString OFFSET space


stop:
    call ReadChar
    call clrscr

ppballMain:
     
     invoke DrawFrame, GUI_COLOR, PLAY_T_EDGE_OFFSET, PLAY_L_EDGE_OFFSET, BOARD_R_LENGTH, BOARD_BETWEEN, BOARD_C_LENGTH, addr space
     invoke ShowFirstTwoPaddles, PADDLE_COLOR, addr player1X, addr player1Y, addr player2X, addr player2Y, addr paddleHeight, addr spacePaddle
	 invoke UpdateBall, addr Ball_X, addr Ball_Y, BALL_COLOR, addr xRun, addr yRise, addr buffer, PLAY_T_EDGE_OFFSET, 
                        BOARD_BETWEEN, player1X, player1Y, player2X, player2Y, paddleHeight
     inc ecx ; increment ecx to keep the loop going...when the ball goes out of bounds, set ecx to 0 so the inner loop can finish
     invoke Chill, FRAME_RATE

     ; check for movement and redraw paddle accordingly
     invoke ReadKeyBoard, PADDLE_COLOR, addr player1x, addr player1Y, addr player2X, addr player2y, paddleHeight, 
                            playTopEdge, playLowEdge
	jmp ppballMain
	
	
     exit
main endp
end main