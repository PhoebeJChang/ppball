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
	p1X: PTR dword,						; x�y��
	p1Y: PTR dword,						; y�y��
	p2X: PTR dword,						; x�y��
	p2Y: PTR dword,						; y�y��
	paddleHeight: dword,                ;paddle ����
    spaceWithStar: ptr byte             ;"*"
     

     ; ����board��l
     pushad 
     ;(14,4)�_�l ��28
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
     inc dh                     ;y�y�Х[�@�A�ѤW���U��
     loop BlackBoardLeft
     popad
     ; ����BlackBoardLeft


     ; �k��board��l
     pushad 
     ;(104,4)�_�l ��28
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
     inc dh         ;���U�e�AY�y�Х[�@
     loop BlackBoardRight
     popad
     ; ����BlackBoardRight


     ; p1 paddle ��l
     pushad 
     ;ptr �ŧi���O�o�[[]
     ;x�y��
     mov eax, [p1X]
     mov dl, byte PTR [eax]

     ;y�y��
     mov eax, [p1Y]
     mov dh, byte PTR [eax]

     ;paddle���׶ǤJECX
     mov eax, [paddleHeight]
     mov ecx, [eax]             ;ecx = 5
player1PaddleDraw:
     call Gotoxy                ;�s��Y�y��

     mov eax, color             ;�L�ũ��`�Ŧr
     call SetTextColor
     push edx
     mov edx, spaceWithStar     ;"*"
     call WriteString
     pop edx

     dec dh                  ;�C��Y�y��-1�A�ѤU���W�e
     loop player1PaddleDraw

     popad
     ; ����p1


     ;  p2 paddle ��l
     pushad

     ;x�y��
     mov eax, [p2X]
     mov dl, byte PTR [eax]

     ;y�y��
     mov eax, [p2Y]
     mov dh, byte PTR [eax]

     ;paddle����
     mov eax, [paddleHeight]
     mov ecx, [eax]
player2PaddleDraw:
     call Gotoxy

     mov eax, color2               ;�������r
     call SetTextColor
     push edx
     mov edx, spaceWithStar         ;"*"
     call WriteString
     pop edx

     dec dh                         ;�C��Y�y��-1�A�ѤU���W�e
     loop player2PaddleDraw

     popad
     ; ����p2

     ;��_�l�I���ʨ쥪�W
     mGotoxy 0,0
     
     pushad

     ret
ShowFirstTwoPaddles endp
end