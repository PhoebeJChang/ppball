include ppball.inc
.data
	ppballTitle byte "PPBALL !!",0
.code
DrawFrame proc,
    color: dword,
	playTopEdgeOffset: dword,
	playLeftEdgeOffset: dword,
    boardRowLength: dword,
	boardsinBetween: dword,
	boardColumnLength: dword,
	space: ptr byte
	

	pushad

	mGotoxy 55,4
	mov eax, red+(black*16)
	call SetTextColor
	mWriteString OFFSET ppballTitle

	mov eax, color
	call SetTextColor
	; place the cursor at the top left edge of the board
    mov eax, playTopEdgeOffset
    mov ebx, playLeftEdgeOffset
	mov dh, al
	mov dl, bl
	call Gotoxy

	mov edx, space
	mov ecx, 2
L0: push ecx
	mov ecx, boardColumnLength
L1: push ecx
	mov ecx, boardRowLength
L2: call WriteString	
	loop L2
	pop ecx
	loop L1
	pop ecx

    push eax
    push edx
    add eax, boardsinBetween			; 
    mov dh, al
	mov dl, bl
	call Gotoxy
    pop edx
    pop eax

	loop L0

	
	mov eax, 0
	call SetTextColor

    mov edx, 0
    call Gotoxy
	
	; and done
	popad
	ret
DrawFrame endp
end
	
	