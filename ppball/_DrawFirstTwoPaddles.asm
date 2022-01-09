; (_DrawFirstTwoPaddles.asm)

include ppball.inc

.code 
DrawFirstTwoPaddles proc,
     color: dword,
	p1X: PTR dword,						; x�y��
	p1Y: PTR dword,						; y�y��
	p2X: PTR dword,						; x�y��
	p2Y: PTR dword,						; y�y��
	paddleHeight: dword,                        ;paddle ����
     space: ptr byte 
     
     pushad 
     ; p1 paddle ��l
     ;ptr �ŧi���O�o�[[]

     mov eax, [p1X]
     mov dl, byte PTR [eax]
     mov eax, [p1Y]
     mov dh, byte PTR [eax]
     mov eax, [paddleHeight]
     mov ecx, [eax]
initialDrawP1:
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
     loop initialDrawP1

     mov eax, 0
     call SetTextColor
     popad

     ; ����p1

     ;  p2 paddle ��l
     pushad
     mov eax, [p2X]
     mov dl, byte PTR [eax]
     mov eax, [p2Y]
     mov dh, byte PTR [eax]
     mov eax, [paddleHeight]
     mov ecx, [eax]
initialDrawP2:
     call Gotoxy
     mov eax, color
     call SetTextColor

     push edx
     mov edx, space
     call WriteString
     pop edx
     dec dh
     loop initialDrawP2

     mov eax, 0
     call SetTextColor
     popad

     ; ����p2

     mov dl, 0
     mov dh, 0
     call Gotoxy
     
     pushad

     ret
DrawFirstTwoPaddles endp
end