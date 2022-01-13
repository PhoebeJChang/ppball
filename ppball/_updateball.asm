include ppball.inc

.code
UpdateBall proc,
	Ball_X: ptr dword,			;x coordinate of the ball 
	Ball_Y: ptr dword,			;y coordinate of the ball
    color: dword,				;BALL_COLOR : black+(yellow * 16)
	xRun: ptr dword,			;球在跑的時候x移動 dword 2
	yRise: ptr dword,			;球在跑的時候y移動 dword 1
	buffer: ptr byte,			;球笑臉(不見了QAQ)
	playTopEdgeOffset: dword,
	boardsinBetween: dword,
    p1X: dword,
    p1Y: dword,
    p2X: dword,
    p2Y: dword,
	paddleHeight: dword
	

	pushad
	
	mov eax, Ball_X		;球的X座標

	; 右邊範圍: 如果球跑出範圍，reset
	mov ebx, p2X		;在player 2 的X座標就是右邊邊框範圍
	add ebx, 5			;比邊框再出來一點點~
	cmp [eax], ebx		;如果[eax] > ebx，此時eax是ball的X座標
	ja Reset			;如果超過則跳去reset
	;player1 分數此時要加一 inc p1+1!!!!!!!!!!!!!!!!!!

	; 左邊範圍: 如果球跑出範圍，reset
	mov ebx, p1X		;在player 1 的X座標就是右邊邊框範圍
	sub ebx, 5			;比邊框再進去一點點
	cmp [eax], ebx		;如果[eax] > ebx，此時eax是ball的X座標

	ja CollisionTesting
	;player2 分數此時要加一 inc p1+1!!!!!!!!!!!!!!!!!!
Reset:
	mov eax, playTopEdgeOffset
	add eax, 10
	mov ebx, p1X
	add ebx, 40
	invoke ResetBall, Ball_X, Ball_Y, ebx, eax, xRun, yRise
	jmp Endit
	
CollisionTesting:
    ; if the ball is beyond the paddles, let it go checking that here
    mov eax, Ball_X
	mov ebx, p2X
	cmp [eax], ebx
	ja UpdateCoords
	mov ebx, p1X
	cmp [eax], ebx
	jb UpdateCoords

    ; check whether the ball is touching either frame
    ; bottom frame
	mov eax, [Ball_Y]
	mov ebx, playTopEdgeOffset
	add ebx, boardsinBetween
    dec ebx
	cmp [eax], ebx
	jb NotTouchingBottom
	mov eax, [yRise]
	neg dword ptr [eax]
	
NotTouchingBottom:
	; top frame
    mov eax, [Ball_Y]
	mov ebx, playTopEdgeOffset
	inc ebx						;ebx+1
	cmp [eax], ebx
	ja NotTouchingTop
	mov eax, [yRise]
	neg dword ptr [eax]
	
NotTouchingTop:
	; check whether the ball is touching either paddle
	; right paddle
	; first decide whether the ball's x-value is equal to the right paddle's x-value
	mov eax, p2X
	mov ebx, eax
	dec ebx
	mov eax, [Ball_X]
	cmp [eax], ebx
	jb NotTouchingRightPaddle
	; ball is potentially touching the right paddle - now check whether the ball's y-value is within the paddle's y-range
	; ball is not touching if it is below the paddle - checking that here
	mov eax, p2Y
	mov ebx, eax
	mov eax, [Ball_Y]
	cmp [eax], ebx
	ja NotTouchingRightPaddle
	; ball is not touching if it is above the paddle - checking that here
	mov eax, p2Y
	mov ebx, eax
	sub ebx, paddleHeight
	mov eax, [Ball_Y]
	cmp [eax], ebx
	jb NotTouchingRightPaddle
	mov eax, [xRun]
	neg dword ptr [eax]
	
NotTouchingRightPaddle:
	; now check the left paddle
	; first decide whether the ball's x-value is equal to the left paddle's x-value
	mov eax, p1X
	mov ebx, eax
    add ebx, 2
	mov eax, [Ball_X]
	cmp [eax], ebx
	ja NotTouchingLeftPaddle
	; ball is potentially touching the left paddle - now check whether the ball's y-value is within the paddle's y-range
	; ball is not touching if it is below the paddle - checking that here
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
	mov eax, [xRun]
	neg dword ptr [eax]
	
NotTouchingLeftPaddle:
UpdateCoords:
	; update the x- and y-coordinates of the ball
	; x
	mov eax, [xRun]
    mov ebx, [eax]
    mov eax, [Ball_X]
    add ebx, [eax]
	mov [eax], ebx
	; y
	mov eax, [yRise]
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
    mov eax, [xRun]
	sub ebx, [eax]
    ; now store the (original) x-coordinate value in Ball_X
    mov eax, [Ball_X]
    mov [eax], ebx

	; set y-coordinate back to its original value
    mov eax, [Ball_Y]
	mov ebx, [eax]
	mov eax, [yRise]
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
	mov eax, [xRun]
    mov ebx, [eax]
    mov eax, [Ball_X]
    add ebx, [eax]
	mov [eax], ebx
	; y
	mov eax, [yRise]
	mov ebx, [eax]
	mov eax, [Ball_Y]
	add ebx, [eax]
	mov [eax], ebx
	
    ; move the cursor back to 0 to get it out of the gamespace
    mov edx, 0
    call Gotoxy
Endit:
	popad
	ret

UpdateBall endp
end
	
	