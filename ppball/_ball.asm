include ppball.inc

.code
Ball proc,
	color: dword,				;BALL_COLOR : black+(yellow * 16)
	Ball_X: ptr dword,			;球的X座標
	Ball_Y: ptr dword,			;球的Y座標
	xMove: ptr dword,			;球在跑的時候x移動 dword 2
	yMove: ptr dword,			;球在跑的時候y移動 dword 1
	buffer: ptr byte,			;球笑臉(不見了QAQ)
	playTopEdgeOffset: dword,
	boardsinBetween: dword,
    p1X: dword,
    p1Y: dword,
    p2X: dword,
    p2Y: dword,
	paddleHeight: dword,
	RESET_BALL_RATE: dword
	

	pushad
	
	mov eax, Ball_X		;球的X座標

	; 左邊範圍: 如果球跑出範圍，reset
	mov ebx, p1X		;在player 1 的X座標就是右邊邊框範圍
	sub ebx, 5			;比邊框再進去一點點
	cmp [eax], ebx		;如果[eax] < ebx，此時eax是ball的X座標
	jb Reset
	
	; 右邊範圍: 如果球跑出範圍，reset
	mov ebx, p2X		;在player 2 的X座標就是右邊邊框範圍
	add ebx, 5			;比邊框再出來一點點~
	cmp [eax], ebx		;如果[eax] > ebx，此時eax是ball的X座標
	ja Reset			;如果超過則跳去reset
	;player1 分數此時要加一 inc p1+1!!!

	jb BangTest
	;player2 分數此時要加一 inc p2+1!!!

Reset:
	;球起始點設定，大概從中間的位置(20+40,5+12)
	mov eax, playTopEdgeOffset	;從上邊框往下
	add eax, 12					;=17
	mov ebx, p1X				;從左邊板子數過來
	add ebx, 40					;=60

	;新座標傳入resset
	invoke ResetBall, Ball_X, Ball_Y, ebx, eax, RESET_BALL_RATE
	jmp ContinueN
	
BangTest:

    mov eax, Ball_X
	mov ebx, p2X
	cmp [eax], ebx
	ja UpdateCoords
	mov ebx, p1X
	cmp [eax], ebx
	jb UpdateCoords

	mov eax, [Ball_Y]
	mov ebx, playTopEdgeOffset
	add ebx, boardsinBetween
    dec ebx
	cmp [eax], ebx
	jb NotTouchingBottom
	mov eax, [yMove]
	neg dword ptr [eax]
	
NotTouchingBottom:

    mov eax, [Ball_Y]
	mov ebx, playTopEdgeOffset
	inc ebx						;ebx+1
	cmp [eax], ebx
	ja NotTouchingTop
	mov eax, [yMove]			;往上飛
	neg dword ptr [eax]
	
NotTouchingTop:
	mov eax, p2X
	mov ebx, eax
	sub ebx,3
	mov eax, [Ball_X]
	cmp [eax], ebx
	jb NotTouchingRightPaddle

	mov eax, p2Y
	mov ebx, eax
	mov eax, [Ball_Y]
	cmp [eax], ebx
	ja NotTouchingRightPaddle

	mov eax, p2Y
	mov ebx, eax
	sub ebx, paddleHeight
	mov eax, [Ball_Y]
	cmp [eax], ebx
	jb NotTouchingRightPaddle
	mov eax, [xMove]
	neg dword ptr [eax]
	
NotTouchingRightPaddle:

	mov eax, p1X
	mov ebx, eax
    add ebx, 2
	mov eax, [Ball_X]
	cmp [eax], ebx
	ja NotTouchingLeftPaddle

	mov eax, p1Y
	mov ebx, eax
	mov eax, [Ball_Y]
	cmp [eax], ebx
	ja NotTouchingLeftPaddle
	; ball is not touching if it is above the paddle - checking that here
	mov eax, p1Y
	mov ebx, eax
	sub ebx, paddleHeight
	mov eax, [Ball_Y]
	cmp [eax], ebx
	jb NotTouchingLeftPaddle
	mov eax, [xMove]
	neg dword ptr [eax]
	
NotTouchingLeftPaddle:
UpdateCoords:
	; update the x- and y-coordinates of the ball
	; x
	mov eax, [xMove]
    mov ebx, [eax]
    mov eax, [Ball_X]
    add ebx, [eax]
	mov [eax], ebx
	; y
	mov eax, [yMove]
	mov ebx, [eax]
	mov eax, [Ball_Y]
	add ebx, [eax]
	mov [eax], ebx
	
	; Gotoxy moves the cursor to the point whose x-value is in dl and whose y-value is in dh
	mov ebx, [Ball_X]
	mov dl, byte ptr [ebx]
	mov ebx, [Ball_Y]
	mov dh, byte ptr [ebx]
	call Gotoxy
	
	; change the fill color to white to represent the ball with a white-filled space
	mov eax, color
	call SetTextColor
	
	; print a space character to print the ball as a white space
	mov edx, buffer
	call WriteString
	
	; now set the text background color back to black like a friEndit
	mov eax, black * 16
	call SetTextColor

    ; now erase the ball's shadow from its previous location
    ; go to the ball's previous position
	; set x-coordinate back to its original value
    mov eax, [Ball_X]
    mov ebx, [eax]
    mov eax, [xMove]
	sub ebx, [eax]
    ; now store the (original) x-coordinate value in Ball_X
    mov eax, [Ball_X]
    mov [eax], ebx

	; set y-coordinate back to its original value
    mov eax, [Ball_Y]
	mov ebx, [eax]
	mov eax, [yMove]
	sub ebx, [eax]
	mov eax, [Ball_Y]
    mov [eax], ebx

    ; Gotoxy moves the cursor to the point whose x-value is in dl and whose y-value is in dh
    mov ebx, [Ball_X]
	mov dl, [ebx]
	mov ebx, [Ball_Y]
	mov dh, [ebx]
	call Gotoxy
	
	; now print a space with a black background to remove the ball's shadow
	mov edx, buffer
	call WriteString
	
	; now re-update Ball_X and Ball_Y with their new values
	; x
	mov eax, [xMove]
    mov ebx, [eax]
    mov eax, [Ball_X]
    add ebx, [eax]
	mov [eax], ebx
	; y
	mov eax, [yMove]
	mov ebx, [eax]
	mov eax, [Ball_Y]
	add ebx, [eax]
	mov [eax], ebx
	
    ; move the cursor back to 0 to get it out of the gamespace
    mov edx, 0
    call Gotoxy
ContinueN:
	popad
	ret

Ball endp
end
	
	