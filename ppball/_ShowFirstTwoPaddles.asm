;ShowFirst2Paddles
include ppball.inc
.data
space2 byte "  ", 0
.code 
ShowFirstTwoPaddles proc,
     color: dword,
    color2: dword,
    blackX1: dword,						;PLAY_BLACK_X1
	blackY1: dword,						;PLAY_BLACK_Y1
    blackX2: dword,						;PLAY_BLACK_X2
	blackY2: dword,						;PLAY_BLACK_Y2
	p1X: PTR dword,						; x座標
	p1Y: PTR dword,						; y座標
	p2X: PTR dword,						; x座標
	p2Y: PTR dword,						; y座標
	paddleHeight: dword,                ;paddle 高度
    spaceWithStar: ptr byte             ;"*"
     

     ; 左黑board初始
     pushad 
     ;(14,4)起始 長28
     mov ebx, blackX1
     mov dl, bl
     mov eax, blackY1
     mov dh, al
     mov ecx, 28
BlackBoardLeft:
     call Gotoxy

     mov eax, (black*16)
     call SetTextColor

     push edx
     mov edx, OFFSET space2     ;space2 "  "
     call WriteString
     pop edx
     inc dh                     ;y座標加一，由上往下拼
     loop BlackBoardLeft
     popad
     ; 結束BlackBoardLeft


     ; 右黑board初始
     pushad 
     ;(104,4)起始 長28
     mov ebx, blackX2
     mov dl, bl
     mov eax, blackY2
     mov dh, al
     mov ecx, 28
BlackBoardRight:
     call Gotoxy

     mov eax, (black*16)
     call SetTextColor

     push edx
     mov edx, OFFSET space2
     call WriteString
     pop edx
     inc dh         ;往下畫，Y座標加一
     loop BlackBoardRight
     popad
     ; 結束BlackBoardRight


     ; p1 paddle 初始
     pushad 
     ;ptr 宣告的記得加[]
     ;x座標
     mov eax, [p1X]
     mov dl, byte PTR [eax]

     ;y座標
     mov eax, [p1Y]
     mov dh, byte PTR [eax]

     ;paddle高度傳入ECX
     mov eax, [paddleHeight]
     mov ecx, [eax]             ;ecx = 5
player1PaddleDraw:
     call Gotoxy                ;新的Y座標

     mov eax, color             ;淺藍底深藍字
     call SetTextColor
     push edx
     mov edx, spaceWithStar     ;"*"
     call WriteString
     pop edx

     dec dh                  ;每次Y座標-1，由下往上畫
     loop player1PaddleDraw

     popad
     ; 結束p1


     ;  p2 paddle 初始
     pushad

     ;x座標
     mov eax, [p2X]
     mov dl, byte PTR [eax]

     ;y座標
     mov eax, [p2Y]
     mov dh, byte PTR [eax]

     ;paddle高度
     mov eax, [paddleHeight]
     mov ecx, [eax]
player2PaddleDraw:
     call Gotoxy

     mov eax, color2               ;紅底黃字
     call SetTextColor
     push edx
     mov edx, spaceWithStar         ;"*"
     call WriteString
     pop edx

     dec dh                         ;每次Y座標-1，由下往上畫
     loop player2PaddleDraw

     popad
     ; 結束p2

     ;把起始點移動到左上
     mGotoxy 0,0
     
     pushad

     ret
ShowFirstTwoPaddles endp
end