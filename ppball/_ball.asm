include ppball.inc

.code
Ball proc,
	Ball_X: ptr dword,			;x coordinate of the ball 
	Ball_Y: ptr dword,			;y coordinate of the ball
    color: dword,				;BALL_COLOR : black+(yellow * 16)
	xRun: ptr dword,			;�y�b�]���ɭ�x���� dword 2
	yRise: ptr dword,			;�y�b�]���ɭ�y���� dword 1
	buffer: ptr byte,			;�y���y(�����FQAQ)
	playTopEdgeOffset: dword,
	boardsinBetween: dword,
    p1X: dword,
    p1Y: dword,
    p2X: dword,
    p2Y: dword,
	paddleHeight: dword,
	RESET_BALL_RATE: dword
	

	pushad
	
	mov eax, Ball_X		;�y��X�y��

	; �k��d��: �p�G�y�]�X�d��Areset
	mov ebx, p2X		;�bplayer 2 ��X�y�дN�O�k����ؽd��
	add ebx, 5			;����ئA�X�Ӥ@�I�I~
	cmp [eax], ebx		;�p�G[eax] > ebx�A����eax�Oball��X�y��
	ja Reset			;�p�G�W�L�h���hreset
	;player1 ���Ʀ��ɭn�[�@ inc p1+1!!!

	; ����d��
	mov ebx, p1X		;�bplayer 1 ��X�y�дN�O�k����ؽd��
	sub ebx, 5			;����ئA�i�h�@�I�I
	cmp [eax], ebx		;�p�G[eax] > ebx�A����eax�Oball��X�y��

	ja BangTest
	;player2 ���Ʀ��ɭn�[�@ inc p2+1!!!

Reset:
	;�y�_�l�I�]�w
	mov eax, playTopEdgeOffset
	add eax, 10
	mov ebx, p1X
	add ebx, 40
	invoke ResetBall, Ball_X, Ball_Y, ebx, eax, xRun, yRise, RESET_BALL_RATE
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
	mov eax, [yRise]
	neg dword ptr [eax]
	
NotTouchingBottom:

    mov eax, [Ball_Y]
	mov ebx, playTopEdgeOffset
	inc ebx						;ebx+1
	cmp [eax], ebx
	ja NotTouchingTop
	mov eax, [yRise]			;���W��
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
	mov eax, [xRun]
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
ContinueN:
	popad
	ret

Ball endp
end
	
	