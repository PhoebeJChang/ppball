include ppball.inc

.code 
ReadKeyBoard proc,
     color: dword,
    color2: dword,
	p1X: PTR dword,						; ���a�@ x�y��
	p1Y: PTR dword,						; ���a�@ y�y��
	p2X: PTR dword,						; ���a�G x�y��
	p2Y: PTR dword,						; ���a�G y�y��
	paddleHeight: dword,                ;5
	playTopEdge: dword,                 ;�̤W�y��
	playLowEdge: dword,                 ;�̤U�y��
    spaceWithStar: ptr byte				;"*"
    
    pushad
	
     call ReadKey
     je continueN

     cmp al, "w"
     je MoveUpP1                ;p1 paddle�V�W
     cmp al, "s"
     je MoveDownP1              ;p2 paddle�V�U
     
     cmp ah, 48h                ;�V�W��
     je MoveUpP2                ;p2 paddle�V�W
     cmp ah, 50h                ;�V�U��
     je MoveDownP2              ;p2 paddle�V�U

     jmp continueN

MoveUpP1: 
    ;��O�l�I��Wborder�A������(cont.)
    ; eax = p1Y
    mov ebx, p1Y
	mov eax, [ebx]
	sub eax, [paddleHeight]				; y - height
	cmp eax, playTopEdge                ;�p�G�p�󵥩�
	jbe continueN                       ;��continue, �����W�U��n�D

    ;���W���ʮɡA�л\�̤U����"*"
     mov eax, p1X
     mov dl, byte PTR [eax]                  ; x �y��
     mov eax, p1Y
     mov dh, byte PTR [eax]                  ; y �y��
     call Gotoxy
     mov eax, 0                              ; black
     call SetTextColor
     mov edx, spaceWithStar
     call WriteString                        ; clear

     ;�V�W���ʮɡA���F�n���h���A�]�n�s�W�W��"*"
     mov eax, p1X
     mov dl, byte PTR [eax]                  ; x �y��
     mov eax, p1Y
     mov dh, byte PTR [eax]                  ; y �y��
     sub dh, byte PTR [paddleHeight]
     call Gotoxy
     mov eax, color                   ;����O�O~~
     call SetTextColor
     mov edx, spaceWithStar
     call WriteString                        ; draw

     sub [ebx], dword PTR 1                  ;y�y��-1(�~�O���T�y�Щ�)
     jmp continueN

MoveDownP1:
     mov ebx, p1Y
	mov eax, [ebx]
    inc eax
	cmp eax, playLowEdge
	jae continueN
	     ; skip if player1 is below or equal to room's upper border

          ; moved up, delete upper line
     mov eax, p1X
     mov dl, byte PTR [eax]                  ; x �y��
     mov eax, p1Y
     mov dh, byte PTR [eax]                  ; y �y��
     sub dh, byte PTR [paddleHeight]
     add dh, byte PTR 1
     call Gotoxy
     mov eax, 0                              ; bg_color = black
     call SetTextColor                       ; set color to black
     mov edx, spaceWithStar
     call WriteString                        ; clear bottom line

     ; moved up, create lower line.
     add [ebx], dword PTR 1                  ; change actual coordinate in main
     mov eax, p1X
     mov dl, byte PTR [eax]                  ; x �y��
     mov eax, p1Y
     mov dh, byte PTR [eax]                  ; y �y��
     call Gotoxy
     mov eax, color                   ; bg_color = color
     call SetTextColor

     mov edx, spaceWithStar
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
     mov dl, byte PTR [eax]                  ; x �y��
     mov eax, p2Y
     mov dh, byte PTR [eax]                  ; y �y��
     call Gotoxy
     mov eax, 0                              ; bg_color = black
     call SetTextColor
     mov edx, spaceWithStar
     call WriteString                        ; clear bottom line

          ; moved up, create upper line.
     mov eax, p2X
     mov dl, byte PTR [eax]                  ; x �y��
     mov eax, p2Y
     mov dh, byte PTR [eax]                  ; y �y��
     sub dh, byte PTR [paddleHeight]
     call Gotoxy
     mov eax, color2                    ; bg_color = black
     call SetTextColor
     mov edx, spaceWithStar
     call WriteString                        ; clear bottom line

     sub [ebx], dword PTR 1                  ; change actual coordinate in main
     jmp continueN

MoveDownP2:
    mov ebx, p2Y
	mov eax, [ebx]
    inc eax
	cmp eax, playLowEdge
	jae continueN
	     ; skip if player2 is below or equal to room's upper border

          ; moved up, delete upper line
     mov eax, p2X
     mov dl, byte PTR [eax]                  ; x �y��
     mov eax, p2Y
     mov dh, byte PTR [eax]                  ; y �y��
     sub dh, byte PTR [paddleHeight]
     add dh, byte PTR 1
     call Gotoxy
     mov eax, 0                              ; bg_color = black
     call SetTextColor                       ; set color to black
     mov edx, spaceWithStar
     call WriteString                        ; clear bottom line

          ; moved up, create lower line.
     add [ebx], dword PTR 1                  ; change actual coordinate in main
     ;mGotoxy p2X, p2Y
     mov eax, p2X
     mov dl, byte PTR [eax]                  ; x �y��
     mov eax, p2Y
     mov dh, byte PTR [eax]                  ; y �y��
     call Gotoxy
     mov eax, color2                    ; bg_color = color
     call SetTextColor

     mov edx, spaceWithStar
     call WriteString                        ; create bottom line

     jmp continueN

continueN:

	ret
ReadKeyBoard endp
end