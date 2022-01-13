; (_ReadKeyBoard.asm)

include ppball.inc
.data
space byte "*", 0                       ;用空白填滿

.code 
ReadKeyBoard proc,
     color: dword,
	p1X: PTR dword,						; x-coord
	p1Y: PTR dword,						; y-coord
	p2X: PTR dword,						; x-coord
	p2Y: PTR dword,						; y-coord
	paddleHeight: dword,
	playTopEdge: dword,
	playLowEdge: dword
    
    pushad
	
     call ReadKey
     je continueN

     cmp al, "w"
     je MoveUpP1                ;p1 paddle向上
     cmp al, "s"
     je MoveDownP1              ;p2 paddle向下
     
     cmp ah, 48h                ;向上鍵
     je MoveUpP2                ;p2 paddle向上
     cmp ah, 50h                ;向下鍵
     je MoveDownP2              ;p2 paddle向下

     jmp continueN

MoveUpP1:                                ; eax = p1Y
     mov ebx, p1Y
	mov eax, [ebx]
	sub eax, [paddleHeight]				; check with top of paddle rather than bottom.
	cmp eax, playTopEdge
	jbe continueN
	     ; skip if player1 is above or equal to room's upper border

          ; moved up, clear bottom line
     mov eax, p1X
     mov dl, byte PTR [eax]                  ; x coordinate
     mov eax, p1Y
     mov dh, byte PTR [eax]                  ; y coordinate
     call Gotoxy
     mov eax, 0                              ; bg_color = black
     call SetTextColor
     mov edx, OFFSET space
     call WriteString                        ; clear bottom line

          ; moved up, create upper line.
     mov eax, p1X
     mov dl, byte PTR [eax]                  ; x coordinate
     mov eax, p1Y
     mov dh, byte PTR [eax]                  ; y coordinate
     sub dh, byte PTR [paddleHeight]
     call Gotoxy
     mov eax, color                   ; bg_color = black
     call SetTextColor
     mov edx, OFFSET space
     call WriteString                        ; clear bottom line

     sub [ebx], dword PTR 1                  ; change actual coordinate in main
     jmp continueN

MoveDownP1:
     mov ebx, p1Y
	mov eax, [ebx]
     add eax, 1
	cmp eax, playLowEdge
	jae continueN
	     ; skip if player1 is below or equal to room's upper border

          ; moved up, delete upper line
     mov eax, p1X
     mov dl, byte PTR [eax]                  ; x coordinate
     mov eax, p1Y
     mov dh, byte PTR [eax]                  ; y coordinate
     sub dh, byte PTR [paddleHeight]
     add dh, byte PTR 1
     call Gotoxy
     mov eax, 0                              ; bg_color = black
     call SetTextColor                       ; set color to black
     mov edx, OFFSET space
     call WriteString                        ; clear bottom line

          ; moved up, create lower line.
     add [ebx], dword PTR 1                  ; change actual coordinate in main
     mov eax, p1X
     mov dl, byte PTR [eax]                  ; x coordinate
     mov eax, p1Y
     mov dh, byte PTR [eax]                  ; y coordinate
     call Gotoxy
     mov eax, color                   ; bg_color = color
     call SetTextColor

     mov edx, OFFSET space
     call WriteString                        ; create bottom line

     jmp continueN

MoveUpP2:                                ; eax = p2Y
     mov ebx, p2Y
	mov eax, [ebx]
	sub eax, [paddleHeight]				; check with top of paddle rather than bottom.
	cmp eax, playTopEdge
	jbe continueN
	     ; skip if player2 is above or equal to room's upper border

          ; moved up, clear bottom line
     mov eax, p2X
     mov dl, byte PTR [eax]                  ; x coordinate
     mov eax, p2Y
     mov dh, byte PTR [eax]                  ; y coordinate
     call Gotoxy
     mov eax, 0                              ; bg_color = black
     call SetTextColor
     mov edx, OFFSET space
     call WriteString                        ; clear bottom line

          ; moved up, create upper line.
     mov eax, p2X
     mov dl, byte PTR [eax]                  ; x coordinate
     mov eax, p2Y
     mov dh, byte PTR [eax]                  ; y coordinate
     sub dh, byte PTR [paddleHeight]
     call Gotoxy
     mov eax, yellow+(lightRed*16)                    ; bg_color = black
     call SetTextColor
     mov edx, OFFSET space
     call WriteString                        ; clear bottom line

     sub [ebx], dword PTR 1                  ; change actual coordinate in main
     jmp continueN

MoveDownP2:
    mov ebx, p2Y
	mov eax, [ebx]
    add eax, 1
	cmp eax, playLowEdge
	jae continueN
	     ; skip if player2 is below or equal to room's upper border

          ; moved up, delete upper line
     mov eax, p2X
     mov dl, byte PTR [eax]                  ; x coordinate
     mov eax, p2Y
     mov dh, byte PTR [eax]                  ; y coordinate
     sub dh, byte PTR [paddleHeight]
     add dh, byte PTR 1
     call Gotoxy
     mov eax, 0                              ; bg_color = black
     call SetTextColor                       ; set color to black
     mov edx, OFFSET space
     call WriteString                        ; clear bottom line

          ; moved up, create lower line.
     add [ebx], dword PTR 1                  ; change actual coordinate in main
     ;mGotoxy p2X, p2Y
     mov eax, p2X
     mov dl, byte PTR [eax]                  ; x coordinate
     mov eax, p2Y
     mov dh, byte PTR [eax]                  ; y coordinate
     call Gotoxy
     mov eax, yellow+(lightRed*16)                    ; bg_color = color
     call SetTextColor

     mov edx, OFFSET space
     call WriteString                        ; create bottom line

     jmp continueN

continueN:
	popad
	;要把多出來的東西用黑色
     mGotoxy 0h,0h
     ; reset color
     mov eax, 0
     call SetTextColor
	ret
ReadKeyBoard endp
end