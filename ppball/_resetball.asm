include ppball.inc

.code
ResetBall proc,
	Ball_X: ptr dword,
	Ball_Y: ptr dword,
	newBall_X: dword,
	newBall_Y: dword,
	RESET_BALL_RATE: ptr dword

	pushad
	;�y����UX�y��Ball_X�N�J�s�y��(60)
	mov eax, Ball_X
	mov ebx, newBall_X
	mov [eax], ebx

	;�y����UY�y��Ball_X�N�J�s�y��(17)
	mov eax, Ball_Y
	mov ebx, newBall_Y
	mov [eax], ebx
	
continueN:

	invoke NewBallTime, RESET_BALL_RATE
	
	popad
	ret
ResetBall endp
end