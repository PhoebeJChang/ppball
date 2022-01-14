;ShowFirst2Paddles
include ppball.inc

.code 
ShowFirstTwoPaddles proc,
     color: dword,
	p1X: PTR dword,						; x座標
	p1Y: PTR dword,						; y座標
	p2X: PTR dword,						; x座標
	p2Y: PTR dword,						; y座標
	paddleHeight: dword,                        ;paddle 高度
    space: ptr byte 
     
     pushad 
     ; p1 paddle 初始
     ;ptr 宣告的記得加[]

     mov eax, [p1X]
     mov dl, byte PTR [eax]
     mov eax, [p1Y]
     mov dh, byte PTR [eax]
     mov eax, [paddleHeight]
     mov ecx, [eax]
player1PaddleDraw:
     call Gotoxy

     ;mov al, '0'
     ;call WriteChar
     mov eax, color
     call SetTextColor

     push edx
     mov edx, space
     call WriteString
     pop edx
     dec dh
     loop player1PaddleDraw

     mov eax, 0
     call SetTextColor
     popad

     ; 結束p1

     ;  p2 paddle 初始
     pushad
     mov eax, [p2X]
     mov dl, byte PTR [eax]
     mov eax, [p2Y]
     mov dh, byte PTR [eax]
     mov eax, [paddleHeight]
     mov ecx, [eax]
player2PaddleDraw:
     call Gotoxy
     mov eax, yellow+(lightRed*16)
     call SetTextColor

     push edx
     mov edx, space
     call WriteString
     pop edx
     dec dh
     loop player2PaddleDraw

     mov eax, 0
     call SetTextColor
     popad

     ; 結束p2

     mov dl, 0
     mov dh, 0
     call Gotoxy
     
     pushad

     ret
ShowFirstTwoPaddles endp
end