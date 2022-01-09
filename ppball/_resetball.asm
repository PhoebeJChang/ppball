include ppball.inc

.code
ResetBall proc,
	xCoordBall: ptr dword,
	yCoordBall: ptr dword,
	newXCoordBall: dword,
	newYCoordBall: dword,
	xRun: ptr dword,
	yRise: ptr dword

	; save the register states from before the function call
	pushad
	
	mov eax, xCoordBall
	mov ebx, newXCoordBall
	mov [eax], ebx
	mov eax, yCoordBall
	mov ebx, newYCoordBall
	mov [eax], ebx
	mov eax, xRun
	cmp dword ptr [eax], 0
	jg Finish
	neg dword ptr [eax]
	mov eax, yRise
	cmp dword ptr [eax], 0
	jg Finish
	neg dword ptr [eax]
Finish:
	mov ecx, 1000
	invoke Chill, ecx
	
	; restore the pre-function call register states
	popad
	ret
ResetBall endp
end