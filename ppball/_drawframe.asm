include ppball.inc
.data
	ppballTitle byte " Hope You Enjoy The Game !! ",0
	ppballHint1 byte " * * * * * * * * * * * * Press",0
	ppballHint2 byte " 'h' ",0
	ppballHint3 byte "to get a hint * * * * * * * * * * * * ",0
.code
DrawFrame proc,
    color: dword,				;��
	playTopEdgeOffset: dword,
	playLeftEdgeOffset: dword,
    boardRowLength: dword,
	boardsinBetween: dword,
	boardColumnLength: dword,
	space: ptr byte
	
	pushad
	;�W���p�p�r
	mGotoxy 45,3
	mov eax, black+(lightCyan*16)
	call SetTextColor
	mWriteString OFFSET ppballTitle

	;�U���p�p�r
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

	mov eax, color		;�Ǧ�
	call SetTextColor

	;�w�Uborder ���W�y��(20,5)
    mov ebx, playLeftEdgeOffset		;20d    
	mov eax, playTopEdgeOffset		;5d
	mov dl, bl		;column X�y��
	mov dh, al		;row Y�y��
	call Gotoxy

	mov edx, space
	mov ecx, 2			;UpDownBoards loop�]�⦸�]�����W�U���
UpDownBoards: 
	push ecx			;ecx = 2 
	mov ecx, boardColumnLength		;ecx = 1 (boardColumnLength)

	ColumnOfBoard: 
		push ecx	;ecx = 1
		mov ecx, boardRowLength			;ecx = 80 (boardRowLength)

		;�p�׬��@��board�e80��
		DrawTheBoard: 
			call WriteString	
		loop DrawTheBoard

		pop ecx		;ecx = 1
	loop ColumnOfBoard		;�]�@��

	pop ecx			;ecx = 2

    push eax		;5d
    push edx		;�x�sedx

    add eax, boardsinBetween			; ���board���Z25d(5+25=30)
    mov dl, bl		;X�y�Ф���
	mov dh, al
	call Gotoxy
    pop edx			;��_
    pop eax

	loop UpDownBoards

	
	popad
	ret
DrawFrame endp
end
	
	