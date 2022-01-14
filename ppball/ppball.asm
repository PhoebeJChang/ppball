include ppball.inc

; �ج[�j�p�M�C��ŧi
PLAY_T_EDGE_OFFSET equ 5d
PLAY_L_EDGE_OFFSET equ 20d
BOARD_R_LENGTH equ 80d                      ;��row
BOARD_C_LENGTH equ 1d                       ;�ecloumn
BOARD_BETWEEN equ 25d                       ;�O�l���Z��

GUI_TEXT_COLOR equ (white)
GUI_COLOR equ lightMagenta+(lightGray * 16)      ;�W�U�O�l�C��
PADDLE_COLOR equ blue+(lightCyan * 16)           ;���kpaddle color
BALL_COLOR equ black+(yellow * 16)

FRAME_RATE equ 100d                          ;�t��


.data
;ppballHeight1 dword 6
;ppballHeight2 dword 2
;Menu Page
MenuTitle byte "PPball !!",0


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
space2 byte "  ",0
spacePaddle byte "*",0
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

stop:
    call ReadChar
    

NextState:
    ;���]�w�I���� �¦�~
    call clrscr
    pushad

    XOR eax,eax
     mov eax, white+(black*16)
     call SetTextColor

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