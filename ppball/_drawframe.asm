; (_drawframe.asm)
include ppball.inc

.code
DrawFrame proc,
    color: dword,
	boardTopOffset: dword,
	boardLeftEdgeOffset: dword,
    boardWidth: dword,
	boardHeight: dword,
	borderWidth: dword,
	space: ptr byte
	
	; boardTopOffset - distance from the top edge of the console to the top edge of the game board
     ; boardLeftEdgeOffset - distance from the left edge of the console to the left edge of the game board
	; boardWidth - width of the board
	; boardHeight - the height of the board
	; borderWidth - the width of the boarder lines
	; space - the offset of a fill character

	pushad
	     
	; first, the top border
     ; set the the background color
	mov eax, color
	call SetTextColor
	; place the cursor at the top left edge of the board
    mov eax, boardTopOffset
    mov ebx, boardLeftEdgeOffset
	mov dh, al
	mov dl, bl
	call Gotoxy
	; load edx with the fill character
	mov edx, space
	; print the borders
	mov ecx, 2
L0: push ecx
	mov ecx, borderWidth
L1: push ecx
	mov ecx, boardWidth
L2: call WriteString	
	loop L2
	pop ecx
	loop L1
	pop ecx
    ; place the cursor at the start of the bottom border
    push eax
    push edx
    add eax, boardHeight
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
	
	