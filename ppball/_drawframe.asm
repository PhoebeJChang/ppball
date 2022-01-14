; (_drawframe.asm)
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
	
	; playTopEdgeOffset - distance from the top edge of the console to the top edge of the game board
     ; playLeftEdgeOffset - distance from the left edge of the console to the left edge of the game board
	; boardRowLength - width of the board
	; boardsinBetween - the height of the board
	; boardColumnLength - the width of the boarder lines
	; space - the offset of a fill character

	pushad
	     
	; first, the top border
    ; set the the background color

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
	; load edx with the fill character
	mov edx, space
	; print the borders
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
    ; place the cursor at the start of the bottom border
    push eax
    push edx
    add eax, boardsinBetween			; 
    mov dh, al
	mov dl, bl
	call Gotoxy
    pop edx
    pop eax
    ; now repeat to draw the bottom border
	loop L0

	
	; set the text and background colors back to the defaults like a friend
	mov eax, 0
	call SetTextColor
    ; move the cursor back to the top left corner of the console
    mov edx, 0
    call Gotoxy
	
	; and done
	popad
	ret
DrawFrame endp
end
	
	