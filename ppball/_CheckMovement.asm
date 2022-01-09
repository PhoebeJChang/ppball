; (_CheckMovement.asm)

include ppball.inc
.data
space byte " ", 0

.code 
CheckMovement proc,
     color: dword,
	p1coordx: PTR dword,						; x-coord
	p1coordy: PTR dword,						; y-coord
	p2coordx: PTR dword,						; x-coord
	p2coordy: PTR dword,						; y-coord
	paddleHeight: dword,
	roomUpperBorder: dword,
	roomLowerBorder: dword
    
    pushad
	
     call ReadKey
     je endit

     cmp al, "w"
     je CheckUpKeyP1
     cmp al, "s"
     je CheckDownKeyP1
     cmp al, "o"
     je CheckUpKeyP2
     cmp al, "l"
     je CheckDownKeyP2
     jmp endit

CheckUpKeyP1:                                ; eax = p1coordy
     mov ebx, p1coordy
	mov eax, [ebx]
	sub eax, [paddleHeight]				; check with top of paddle rather than bottom.
	cmp eax, roomUpperBorder
	jbe endit
	     ; skip if player1 is above or equal to room's upper border

          ; moved up, clear bottom line
     mov eax, p1coordx
     mov dl, byte PTR [eax]                  ; x coordinate
     mov eax, p1coordy
     mov dh, byte PTR [eax]                  ; y coordinate
     call Gotoxy
     mov eax, 0                              ; bg_color = black
     call SetTextColor
     mov edx, OFFSET space
     call WriteString                        ; clear bottom line

          ; moved up, create upper line.
     mov eax, p1coordx
     mov dl, byte PTR [eax]                  ; x coordinate
     mov eax, p1coordy
     mov dh, byte PTR [eax]                  ; y coordinate
     sub dh, byte PTR [paddleHeight]
     call Gotoxy
     mov eax, white+(lightCyan*16)                    ; bg_color = black
     call SetTextColor
     mov edx, OFFSET space
     call WriteString                        ; clear bottom line

     sub [ebx], dword PTR 1                  ; change actual coordinate in main
     jmp endit

CheckDownKeyP1:
     mov ebx, p1coordy
	mov eax, [ebx]
     add eax, 1
	cmp eax, roomLowerBorder
	jae endit
	     ; skip if player1 is below or equal to room's upper border

          ; moved up, delete upper line
     mov eax, p1coordx
     mov dl, byte PTR [eax]                  ; x coordinate
     mov eax, p1coordy
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
     mov eax, p1coordx
     mov dl, byte PTR [eax]                  ; x coordinate
     mov eax, p1coordy
     mov dh, byte PTR [eax]                  ; y coordinate
     call Gotoxy
     mov eax, color                   ; bg_color = color
     call SetTextColor

     mov edx, OFFSET space
     call WriteString                        ; create bottom line

     jmp endit

CheckUpKeyP2:                                ; eax = p2coordy
     mov ebx, p2coordy
	mov eax, [ebx]
	sub eax, [paddleHeight]				; check with top of paddle rather than bottom.
	cmp eax, roomUpperBorder
	jbe endit
	     ; skip if player2 is above or equal to room's upper border

          ; moved up, clear bottom line
     mov eax, p2coordx
     mov dl, byte PTR [eax]                  ; x coordinate
     mov eax, p2coordy
     mov dh, byte PTR [eax]                  ; y coordinate
     call Gotoxy
     mov eax, 0                              ; bg_color = black
     call SetTextColor
     mov edx, OFFSET space
     call WriteString                        ; clear bottom line

          ; moved up, create upper line.
     mov eax, p2coordx
     mov dl, byte PTR [eax]                  ; x coordinate
     mov eax, p2coordy
     mov dh, byte PTR [eax]                  ; y coordinate
     sub dh, byte PTR [paddleHeight]
     call Gotoxy
     mov eax, color                    ; bg_color = black
     call SetTextColor
     mov edx, OFFSET space
     call WriteString                        ; clear bottom line

     sub [ebx], dword PTR 1                  ; change actual coordinate in main
     jmp endit

CheckDownKeyP2:
     mov ebx, p2coordy
	mov eax, [ebx]
     add eax, 1
	cmp eax, roomLowerBorder
	jae endit
	     ; skip if player2 is below or equal to room's upper border

          ; moved up, delete upper line
     mov eax, p2coordx
     mov dl, byte PTR [eax]                  ; x coordinate
     mov eax, p2coordy
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
     mov eax, p2coordx
     mov dl, byte PTR [eax]                  ; x coordinate
     mov eax, p2coordy
     mov dh, byte PTR [eax]                  ; y coordinate
     call Gotoxy
     mov eax, color                    ; bg_color = color
     call SetTextColor

     mov edx, OFFSET space
     call WriteString                        ; create bottom line

     jmp endit

endit:
	popad
	
     mov dl, byte ptr 0h
     mov dh, byte ptr 0h
     call Gotoxy
     ; reset color
     mov eax, 0
     call SetTextColor
	ret
CheckMovement endp
end