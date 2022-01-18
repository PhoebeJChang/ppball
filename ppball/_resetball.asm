include ppball.inc

.code
ResetBall proc,
	Ball_X: ptr dword,
	Ball_Y: ptr dword,
	newBall_X: dword,
	newBall_Y: dword,
	xRun: ptr dword,
	yRise: ptr dword

	; 存取前一刻狀態(往下就往下開始)
	mov eax, Ball_X
	mov ebx, newBall_X
	mov [eax], ebx
	mov eax, Ball_Y
	mov ebx, newBall_Y
	mov [eax], ebx
	mov eax, xRun
	cmp dword ptr [eax], 0
	jg Endit
	neg dword ptr [eax]
	mov eax, yRise
	cmp dword ptr [eax], 0
	jg Endit
	neg dword ptr [eax]
Endit:
	mov ecx, 1000
	invoke Chill, ecx
	
	; restore the pre-function call register states
	popad
	ret
ResetBall endp
end