include ppball.inc
.data
space byte "*", 0                       ;用*填滿

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

MoveUpP1: 
    ;當板子碰到上border，不給動(cont.)
    ; eax = p1Y
    mov ebx, p1Y
	mov eax, [ebx]
	sub eax, [paddleHeight]				; y - height
	cmp eax, playTopEdge                ;如果小於等於
	jbe continueN                       ;跳continue, 忽略上下鍵要求

    ;往上移動時，覆蓋最下面的"*"
     mov eax, p1X
     mov dl, byte PTR [eax]                  ; x 座標
     mov eax, p1Y
     mov dh, byte PTR [eax]                  ; y 座標
     call Gotoxy
     mov eax, 0                              ; black
     call SetTextColor
     mov edx, OFFSET space
     call WriteString                        ; clear

     ;向上移動時，除了要擦去面，也要新增上方"*"
     mov eax, p1X
     mov dl, byte PTR [eax]                  ; x 座標
     mov eax, p1Y
     mov dh, byte PTR [eax]                  ; y 座標
     sub dh, byte PTR [paddleHeight]
     call Gotoxy
     mov eax, color                   ;紅色板板~~
     call SetTextColor
     mov edx, OFFSET space
     call WriteString                        ; draw

     sub [ebx], dword PTR 1                  ;y座標-1(才是正確座標底)
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
     mov dl, byte PTR [eax]                  ; x 座標
     mov eax, p1Y
     mov dh, byte PTR [eax]                  ; y 座標
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
     mov dl, byte PTR [eax]                  ; x 座標
     mov eax, p1Y
     mov dh, byte PTR [eax]                  ; y 座標
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
     mov dl, byte PTR [eax]                  ; x 座標
     mov eax, p2Y
     mov dh, byte PTR [eax]                  ; y 座標
     call Gotoxy
     mov eax, 0                              ; bg_color = black
     call SetTextColor
     mov edx, OFFSET space
     call WriteString                        ; clear bottom line

          ; moved up, create upper line.
     mov eax, p2X
     mov dl, byte PTR [eax]                  ; x 座標
     mov eax, p2Y
     mov dh, byte PTR [eax]                  ; y 座標
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
    inc eax
	cmp eax, playLowEdge
	jae continueN
	     ; skip if player2 is below or equal to room's upper border

          ; moved up, delete upper line
     mov eax, p2X
     mov dl, byte PTR [eax]                  ; x 座標
     mov eax, p2Y
     mov dh, byte PTR [eax]                  ; y 座標
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
     mov dl, byte PTR [eax]                  ; x 座標
     mov eax, p2Y
     mov dh, byte PTR [eax]                  ; y 座標
     call Gotoxy
     mov eax, yellow+(lightRed*16)                    ; bg_color = color
     call SetTextColor

     mov edx, OFFSET space
     call WriteString                        ; create bottom line

     jmp continueN

continueN:

	ret
ReadKeyBoard endp
end