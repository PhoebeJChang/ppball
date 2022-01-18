include ppball.inc

; �ج[�j�p�M�C��ŧi
PLAY_T_EDGE_OFFSET equ 5d
PLAY_L_EDGE_OFFSET equ 20d
BOARD_R_LENGTH equ 80d                      ;��row
BOARD_C_LENGTH equ 1d                       ;�ecloumn
BOARD_BETWEEN equ 25d                       ;�O�l���Z��

MENU_PPBALL_COLOR equ yellow + (cyan*16)         ;menu PPBALL
MENU_TEXT_COLOR equ white + (black*16)
GUI_TEXT_COLOR equ (white)
GUI_COLOR equ lightMagenta+(lightGray * 16)      ;�W�U�O�l�C��
PADDLE_COLOR equ blue+(lightCyan * 16)           ;��paddle color
PADDLE_COLOR_TWO equ yellow+(lightRed*16)        ;�kpaddle color
BALL_COLOR equ black+(yellow * 16)

FRAME_RATE equ 100d                          ;�y�]���t��
RESET_BALL_RATE equ 1500d                    ;�yreset �N�o�ɶ�


.data
;ppballHeight1 dword 6
;ppballHeight2 dword 2


; for passing into prototypes
playTopEdge dword (PLAY_T_EDGE_OFFSET)
playLowEdge dword (PLAY_T_EDGE_OFFSET + BOARD_BETWEEN)

; ball and paddle tracking
Ball_X dword PLAY_L_EDGE_OFFSET + 30
Ball_Y dword PLAY_T_EDGE_OFFSET + 15
xRun dword 2              ;
yRise dword 1

; �񺡪F�FString
space byte " ", 0
space2 byte "  ", 0
spacePaddle byte "*", 0
buffer byte 2h            ;�y�y��߯��y

player1X dword (PLAY_L_EDGE_OFFSET)                 ;�]�wp1 paddle ��m�b��������
player1Y dword (PLAY_T_EDGE_OFFSET + (BOARD_BETWEEN / 2) + 2)
player2X dword (PLAY_L_EDGE_OFFSET + BOARD_R_LENGTH - 1)
player2Y dword (PLAY_T_EDGE_OFFSET + (BOARD_BETWEEN / 2) + 2)

paddleHeight dword 5d       ;paddle��


; gui information ���a�p��
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
     
     invoke DrawFrame, GUI_COLOR, PLAY_T_EDGE_OFFSET, PLAY_L_EDGE_OFFSET, BOARD_R_LENGTH, BOARD_BETWEEN, BOARD_C_LENGTH, addr space
     invoke ShowFirstTwoPaddles, PADDLE_COLOR, PADDLE_COLOR_TWO, addr player1X, addr player1Y, addr player2X, addr player2Y, addr paddleHeight, addr spacePaddle
	 invoke UpdateBall, addr Ball_X, addr Ball_Y, BALL_COLOR, addr xRun, addr yRise, addr buffer, PLAY_T_EDGE_OFFSET, 
                        BOARD_BETWEEN, player1X, player1Y, player2X, player2Y, paddleHeight, RESET_BALL_RATE
     
     invoke SpeedOfBall, FRAME_RATE

     invoke ReadKeyBoard, PADDLE_COLOR, PADDLE_COLOR_TWO, addr player1x, addr player1Y, addr player2X, addr player2y, paddleHeight, 
                            playTopEdge, playLowEdge
	jmp ppballMain
	
	
     exit
main endp
end main