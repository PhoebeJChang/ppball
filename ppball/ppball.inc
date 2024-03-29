include Irvine32.inc
include Macros.inc

MenuPage proto,
	colorTitle: dword,
	colorText: dword

ReadKeyBoard proto,
    color: dword,
	color2: dword,
	p1X: PTR dword,						; 玩家一 x座標
	p1Y: PTR dword,						; 玩家一 y座標
	p2X: PTR dword,						; 玩家二 x座標
	p2Y: PTR dword,						; 玩家二 y座標
	paddleHeight: dword,				;5
	playTopEdge: dword,
	playLowEdge: dword,
	spaceWithStar: ptr byte				;"*"

ShowFirstTwoPaddles proto,
    color: dword,
	color2: dword,
	blackX1: dword,						;PLAY_BLACK_X1
	blackY1: dword,						;PLAY_BLACK_Y1
	blackX2: dword,						;PLAY_BLACK_X2
	blackY2: dword,						;PLAY_BLACK_Y2
	p1X: PTR dword,						; 玩家一 x座標
	p1Y: PTR dword,						; 玩家一 y座標
	p2X: PTR dword,						; 玩家二 x座標
	p2Y: PTR dword,						; 玩家二 y座標
	paddleHeight: dword,                ;paddle 高度
    spaceWithStar: ptr byte				;"*"

DrawFrame proto,
    color: dword,						;UP_DOWN_B_COLOR 設light gray
    playTopEdgeOffset: dword,			;PLAY_T_EDGE_OFFSET 
	playLeftEdgeOffset: dword,			;PLAY_L_EDGE_OFFSET
    boardRowLength: dword,				;BOARD_R_LENGTH
	boardsinBetween: dword,				;BOARD_BETWEEN
	boardColumnLength: dword,			;BOARD_C_LENGTH
	space: ptr byte

DrawBall proto,
     color: dword,
     Ball_X: ptr dword,
     Ball_Y: ptr dword,
     xMove: ptr dword,
	 yMove: ptr dword

 Ball proto,
	color: dword,				;BALL_COLOR   
	Ball_X: ptr dword,			;球X座標
    Ball_Y: ptr dword,			;球Y座標
    xMove: ptr dword,
	yMove: ptr dword,
	space: ptr byte,
	playTopEdgeOffset: dword,
	boardsinBetween: dword,
    p1X: dword,
    p1Y: dword,
    p2X: dword,
    p2Y: dword,
	paddleHeight: dword,
	RESET_BALL_RATE: dword
	
ResetBall proto,
	Ball_X: ptr dword,
	Ball_Y: ptr dword,
	newBall_X: dword,
	newBall_Y: dword,
	RESET_BALL_RATE: ptr dword
 
SpeedOfBall proto,
     timedu: dword


NewBallTime proto,
	revive: dword