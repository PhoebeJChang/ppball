include ppball.inc

; �ج[�j�p�M�C��ŧi
PLAY_T_EDGE_OFFSET equ 5d
PLAY_L_EDGE_OFFSET equ 20d
BOARD_R_LENGTH equ 80d                      ;��row
BOARD_C_LENGTH equ 1d                       ;�ecloumn
BOARD_BETWEEN equ 25d                       ;�O�l���Z��

GUI_TEXT_COLOR equ (white)
GUI_COLOR equ (lightGray * 16)              ;�W�U�O�l�C��
PADDLE_COLOR equ (lightCyan * 16)           ;���kpaddle color
BALL_COLOR equ (yellow * 16)

FRAME_RATE equ 80d                          ;�t��

.data
;menu byte "hellooooooooooooooo", 0

; for passing into prototypes
roomUpperBorder dword (PLAY_T_EDGE_OFFSET)
roomLowerBorder dword (PLAY_T_EDGE_OFFSET + BOARD_BETWEEN)

; ball and paddle tracking
xCoordBall dword PLAY_L_EDGE_OFFSET + 30
yCoordBall dword PLAY_T_EDGE_OFFSET + 2
xRun dword 2
yRise dword 1

; character
space byte " ", 0

player1X dword (PLAY_L_EDGE_OFFSET)                 ;�]�wp1 paddle ��m�b��������
player1Y dword (PLAY_T_EDGE_OFFSET + (BOARD_BETWEEN / 2))
player2X dword (PLAY_L_EDGE_OFFSET + BOARD_R_LENGTH - 1)
player2Y dword (PLAY_T_EDGE_OFFSET + (BOARD_BETWEEN / 2))

paddleHeight dword 4h

ballDirection dword 90				; in degrees? or slope? 


; gui information ���a�p��
;p1scoreString byte "Player 1 score:", 0
;p2scoreString byte "Player 2 score:", 0
;p1score dword 0
;p2score dword 0

.code
main proc
     mov eax, 0
     call SetTextColor
     invoke DrawFrame, GUI_COLOR, PLAY_T_EDGE_OFFSET, PLAY_L_EDGE_OFFSET, BOARD_R_LENGTH, BOARD_BETWEEN, BOARD_C_LENGTH, addr space

     invoke ShowFirstTwoPaddles, PADDLE_COLOR, addr player1X, addr player1Y, addr player2X, addr player2Y, addr paddleHeight, addr space

     mov ecx, 1
MainLoop:
	 invoke UpdateBall, addr xCoordBall, addr yCoordBall, BALL_COLOR, addr xRun, addr yRise, addr space, PLAY_T_EDGE_OFFSET, 
                        BOARD_BETWEEN, player1X, player1Y, player2X, player2Y, paddleHeight
     inc ecx ; increment ecx to keep the loop going...when the ball goes out of bounds, set ecx to 0 so the inner loop can finish
     invoke Chill, FRAME_RATE

     ; check for movement and redraw paddle accordingly
     invoke CheckMovement, PADDLE_COLOR, addr player1x, addr player1Y, addr player2X, addr player2y, paddleHeight, 
                            roomUpperBorder, roomLowerBorder
	jmp MainLoop
	
	
     exit
main endp
end main