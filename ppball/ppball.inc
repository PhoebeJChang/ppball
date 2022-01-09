include Irvine32.inc

DrawFrame proto,
    color: dword,						;GUI_COLOR
    playTopEdgeOffset: dword,			;PLAY_T_EDGE_OFFSET
	playLeftEdgeOffset: dword,			;PLAY_L_EDGE_OFFSET
    boardRowLength: dword,				;BOARD_R_LENGTH
	boardsinBetween: dword,				;BOARD_BETWEEN
	boardColumnLength: dword,					;BOARD_C_LENGTH
	space: ptr byte

ShowFirstTwoPaddles proto,
    color: dword,
	p1X: PTR dword,						; x座標
	p1Y: PTR dword,						; y座標
	p2X: PTR dword,						; x座標
	p2Y: PTR dword,						; y座標
	paddleHeight: dword,                        ;paddle 高度
     space: ptr byte

CheckMovement proto,
    color: dword,
	p1coordx: PTR dword,						; x-coord
	p1coordy: PTR dword,						; y-coord
	p2coordx: PTR dword,						; x-coord
	p2coordy: PTR dword,						; y-coord
	paddleHeight: dword,
	roomUpperBorder: dword,
	roomLowerBorder: dword
 
DrawBall proto,
     color: dword,
     xCoordBall: ptr dword,
     yCoordBall: ptr dword,
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
    xCoordBall: ptr dword,
    yCoordBall: ptr dword,
    color: dword,
    xRun: ptr dword,
	yRise: ptr dword,
	space: ptr byte,
	playTopEdgeOffset: dword,
	boardsinBetween: dword,
    leftPaddleX: dword,
    leftPaddleY: dword,
    rightPaddleX: dword,
    rightPaddleY: dword,
	paddleHeight: dword
	
ResetBall proto,
	xCoordBall: ptr dword,
	yCoordBall: ptr dword,
	newXCoordBall: dword,
	newYCoordBall: dword,
	xRun: ptr dword,
	yRise: ptr dword
 
Chill proto,
     timedu: dword