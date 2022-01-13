include Irvine32.inc
include Macros.inc

DrawFrame proto,
    color: dword,						;GUI_COLOR
    playTopEdgeOffset: dword,			;PLAY_T_EDGE_OFFSET
	playLeftEdgeOffset: dword,			;PLAY_L_EDGE_OFFSET
    boardRowLength: dword,				;BOARD_R_LENGTH
	boardsinBetween: dword,				;BOARD_BETWEEN
	boardColumnLength: dword,			;BOARD_C_LENGTH
	space: ptr byte

ShowFirstTwoPaddles proto,
    color: dword,
	p1X: PTR dword,						; 玩家一 x座標
	p1Y: PTR dword,						; 玩家一 y座標
	p2X: PTR dword,						; 玩家二 x座標
	p2Y: PTR dword,						; 玩家二 y座標
	paddleHeight: dword,                ;paddle 高度
    space: ptr byte

ReadKey proto,
    color: dword,
	p1X: PTR dword,						; 玩家一 x座標
	p1Y: PTR dword,						; 玩家一 y座標
	p2X: PTR dword,						; 玩家二 x座標
	p2Y: PTR dword,						; 玩家二 y座標
	paddleHeight: dword,
	playTopEdge: dword,
	playLowEdge: dword
 
DrawBall proto,
     color: dword,
     Ball_X: ptr dword,
     Ball_Y: ptr dword,
     xRun: ptr dword,
	yRise: ptr dword

DrawScore proto,
    textcolor: dword,
    color: dword,
	playTopEdgeOffset: dword,
	playLeftEdgeOffset: dword,
    boardRowLength: dword,
	boardsinBetween: dword,
	boardColumnLength: dword,
	space: ptr byte,
    p1score: ptr dword,
    p2score: ptr dword,
    p1string: ptr dword,
    p2string: ptr dword

 UpdateBall proto,
    Ball_X: ptr dword,			;球X座標
    Ball_Y: ptr dword,			;球Y座標
    color: dword,				;BALL_COLOR
    xRun: ptr dword,
	yRise: ptr dword,
	space: ptr byte,
	playTopEdgeOffset: dword,
	boardsinBetween: dword,
    p1X: dword,
    p1Y: dword,
    p2X: dword,
    p2Y: dword,
	paddleHeight: dword
	
ResetBall proto,
	Ball_X: ptr dword,
	Ball_Y: ptr dword,
	newBall_X: dword,
	newBall_Y: dword,
	xRun: ptr dword,
	yRise: ptr dword
 
Chill proto,
     timedu: dword