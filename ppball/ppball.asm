include ppball.inc

; �ج[�j�p�M�C��ŧi
PLAY_T_EDGE_OFFSET equ 5d
PLAY_L_EDGE_OFFSET equ 20d
BOARD_R_LENGTH equ 80d                      ;��row
BOARD_C_LENGTH equ 1d                       ;�ecloumn
BOARD_BETWEEN equ 25d                       ;�O�l���Z��

;�s�W���k�ⰼ�ݤ��쪺�¦�boards
PLAY_BLACK_X1 equ 14d                  
PLAY_BLACK_Y1 equ 4d
PLAY_BLACK_X2 equ 104d                  
PLAY_BLACK_Y2 equ 4d

MENU_PPBALL_COLOR equ yellow + (cyan*16)         ;menu PPBALL
MENU_TEXT_COLOR equ white + (black*16)
UP_DOWN_B_COLOR equ (lightGray * 16)             ;�W�U�O�l�C��
PADDLE_COLOR equ blue+(lightCyan * 16)           ;��paddle color
PADDLE_COLOR_TWO equ yellow+(lightRed*16)        ;�kpaddle color
BALL_COLOR equ black+(yellow * 16)

;�y�H�C0.1��t�ײ���
FRAME_RATE equ 100d                          ;�y�]���t��

;reset�ɶ�����1.5��
RESET_BALL_RATE equ 1500d                    ;�yreset �N�o�ɶ�


.data

; �W�O�lY�y��(5)
playTopEdge dword (PLAY_T_EDGE_OFFSET)
; �U�O�lY�y��(5+25)
playLowEdge dword (PLAY_T_EDGE_OFFSET + BOARD_BETWEEN)

;�y���_�l�y�СAX = 20+40�AY = 5+12
Ball_X dword (PLAY_L_EDGE_OFFSET + 40)
Ball_Y dword (PLAY_T_EDGE_OFFSET + 12)

;�y����45�ר��A�]���y����Ӫť���Ҳզ�
;X�y�в��ʻݭn�]��2�A�ӫD1
xMove dword 2
yMove dword 1

;paddle �_�l�y��
;����player1
p1X dword (PLAY_L_EDGE_OFFSET)                 ;�]�wp1 paddle ��m�b��������
p1Y dword (PLAY_T_EDGE_OFFSET + (BOARD_BETWEEN / 2) + 2)

;�k��player2
p2X dword (PLAY_L_EDGE_OFFSET + BOARD_R_LENGTH - 1)
p2Y dword (PLAY_T_EDGE_OFFSET + (BOARD_BETWEEN / 2) + 2)

paddleHeight dword 5d       ;paddle��

; �񺡪F�FString
space byte " ", 0
space2 byte "  ", 0
spacePaddle byte "*", 0
buffer byte "  "            ;�y�y��߯��y�A�S�FQAQ

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
     
     ;�W�U�O�l
     invoke DrawFrame, UP_DOWN_B_COLOR, PLAY_T_EDGE_OFFSET, PLAY_L_EDGE_OFFSET, BOARD_R_LENGTH, BOARD_BETWEEN, BOARD_C_LENGTH, addr space
     
     ;���apaddle��l�M����
     invoke ShowFirstTwoPaddles, PADDLE_COLOR, PADDLE_COLOR_TWO, PLAY_BLACK_X1, PLAY_BLACK_Y1, PLAY_BLACK_X2, PLAY_BLACK_Y2, 
                                 addr p1X, addr p1Y, addr p2X, addr p2Y, addr paddleHeight, addr spacePaddle
	 invoke ReadKeyBoard, PADDLE_COLOR, PADDLE_COLOR_TWO, addr p1X, addr p1Y, addr p2X, addr p2Y, 
                          paddleHeight, playTopEdge, playLowEdge, addr spacePaddle
     
     ;�y��
     invoke Ball, BALL_COLOR, addr Ball_X, addr Ball_Y, addr xMove, addr yMove, addr buffer, PLAY_T_EDGE_OFFSET, 
                        BOARD_BETWEEN, p1X, p1Y, p2X, p2Y, paddleHeight, RESET_BALL_RATE
     
     invoke SpeedOfBall, FRAME_RATE

     
	jmp ppballMain
	
	
     exit
main endp
end main