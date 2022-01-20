include ppball.inc
.data
	ppballTitle byte " Hope You Enjoy The Game !! ",0
	ppballHint1 byte " * * * * * * * * * * * * Press",0
	ppballHint2 byte " 'h' ",0
	ppballHint3 byte "to get a hint * * * * * * * * * * * * ",0
.code
DrawFrame proc,
    color: dword,				;灰
	playTopEdgeOffset: dword,
	playLeftEdgeOffset: dword,
    boardRowLength: dword,
	boardsinBetween: dword,
	boardColumnLength: dword,
	space: ptr byte
	
	pushad
	;上面小小字
	mGotoxy 45,3
	mov eax, black+(lightCyan*16)
	call SetTextColor
	mWriteString OFFSET ppballTitle

	;下面小小字
	mGotoxy 22,32
	mov eax, cyan+(black*16)
	call SetTextColor
	mWriteString OFFSET ppballHint1
	mov eax, lightGreen+(black*16)
	call SetTextColor
	mWriteString OFFSET ppballHint2
	mov eax, cyan+(black*16)
	call SetTextColor
	mWriteString OFFSET ppballHint3

	mov eax, color		;灰色
	call SetTextColor

	;定下border 左上座標(20,5)
    mov ebx, playLeftEdgeOffset		;20d    
	mov eax, playTopEdgeOffset		;5d
	mov dl, bl		;column X座標
	mov dh, al		;row Y座標
	call Gotoxy

	mov edx, space
	mov ecx, 2			;UpDownBoards loop跑兩次因為有上下兩個
UpDownBoards: 
	push ecx			;ecx = 2 
	mov ecx, boardColumnLength		;ecx = 1 (boardColumnLength)

	ColumnOfBoard: 
		push ecx	;ecx = 1
		mov ecx, boardRowLength			;ecx = 80 (boardRowLength)

		;厚度為一的board畫80次
		DrawTheBoard: 
			call WriteString	
		loop DrawTheBoard

		pop ecx		;ecx = 1
	loop ColumnOfBoard		;跑一次

	pop ecx			;ecx = 2

    push eax		;5d
    push edx		;儲存edx

    add eax, boardsinBetween			; 兩個board間距25d(5+25=30)
    mov dl, bl		;X座標不變
	mov dh, al
	call Gotoxy
    pop edx			;恢復
    pop eax

	loop UpDownBoards

	
	popad
	ret
DrawFrame endp
end
	
	