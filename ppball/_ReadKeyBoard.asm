include ppball.inc
.data
            
HintTitle BYTE "�C���ާ@��k",0
HintText  BYTE "�������a�ޱ�WS��Ӳ���Paddle�F          "
	       BYTE "�k�����a�ޱ��W�U��Ӳ���Paddle",0

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

;�Ŧ�O�O��MoveUpP1, MoveDownP1���label
MoveUpP1: 
    ;��O�l�I��Wborder�A������(cont.)
    ; eax = p1Y , [ebx] �s�۷�ɪ�y�y��!!!!
    mov ebx, p1Y
	mov eax, [ebx]
	sub eax, [paddleHeight]				; y - height
	cmp eax, playTopEdge                ;�p�G�p�󵥩�
	jbe continueN                       ;��continue, �����W��n�D

    ;���W���ʮɡA�л\�̤U����"*",���ɪ�XY�y��
    ;�]���ڭ̬O�ѤU���W�e�A�ҥH��ɪ��y�з|�O�̤U��
     mov eax, p1X
     mov dl, byte PTR [eax]                  ; x �y��
     mov eax, p1Y
     mov dh, byte PTR [eax]                  ; y �y��
     call Gotoxy
     mov eax, 0                              ; ��W�¦�
     call SetTextColor
     mov edx, spaceWithStar
     call WriteString                        ; �л\

     ;�V�W���ʮɡA���F�n���h�U���A�]�n�s�W�W��"*"
     mov eax, p1X
     mov dl, byte PTR [eax]                  ; x �y��
     mov eax, p1Y
     mov dh, byte PTR [eax]                  ; y �y��
     sub dh, byte PTR [paddleHeight]         ;��hpaddle���ױo�̰��I�y��
     call Gotoxy
     mov eax, color                          ;�Ŧ�O�O~~
     call SetTextColor
     mov edx, spaceWithStar
     call WriteString                        ; �e�W

     ;[ebx]�}�Y�s�۷�ɪ�y�y��
     sub [ebx], dword PTR 1                  ;[ebx]-1 �o�s�y��
     jmp continueN

MoveDownP1:
    ;��O�l�I��Uborder�A������(cont.)
    ; eax = p1Y , [ebx] �]�s�۷�ɪ�y�y��!!!!
     mov ebx, p1Y
	 mov eax, [ebx]
     inc eax                                ;p1Y + 1�өM�̩�Y�y�жi����
	 cmp eax, playLowEdge                   ;�p�GY�y�Фj�󵥩�Edge
	 jae continueN                          ;���hcontinueN, �����U��n�D

     ;���U���ʮɡA�л\�̤W����"*",���ɪ�XY�y��
     ;�]���ڭ̬O�ѤU���W�e�A�ҥH��ɪ��y�з|�O�̤U��
     mov eax, p1X
     mov dl, byte PTR [eax]                  ; x �y��
     mov eax, p1Y
     mov dh, byte PTR [eax]                  ; y �y��
     sub dh, byte PTR [paddleHeight]         ;��hpaddle���ױo�̰��I�y��
     add dh, byte PTR 1                      ;�O�o�[�@!!                      
     call Gotoxy
     mov eax, 0                              ; ��W�¦�
     call SetTextColor                       
     mov edx, spaceWithStar
     call WriteString                        ; �л\�̤W����*

     ;�V�U���ʮɡA���F�n���h�W���A�]�n�s�W�U��"*"
     mov eax, p1X
     mov dl, byte PTR [eax]                  ; x �y��
     mov eax, p1Y
     mov dh, byte PTR [eax]                  ; y �y��
     add dh, byte PTR 1                      ;�[�@���ױo�̧C�I�y��
     call Gotoxy
     mov eax, color                          ; �Ŧ�O�O
     call SetTextColor
     mov edx, spaceWithStar
     call WriteString                        ; �e�W

     add [ebx], dword PTR 1                  ;[ebx]+1 �o�s�y��
     jmp continueN

;����O�O��MoveUpP2, MoveDownP2���label
MoveUpP2:
    ;��O�l�I��Wborder�A������(cont.)
    ; eax = p2Y , [ebx] �s�۷�ɪ�y�y��!!!!
    mov ebx, p2Y
	mov eax, [ebx]                      
	sub eax, [paddleHeight]				     ; y - height
	cmp eax, playTopEdge                     ;�p�G�p�󵥩�
	jbe continueN                            ;��continue, �����W��n�D

    ;���W���ʮɡA�л\�̤U����"*",���ɪ�XY�y��
    ;�]���ڭ̬O�ѤU���W�e�A�ҥH��ɪ��y�з|�O�̤U��
    mov eax, p2X
    mov dl, byte PTR [eax]                   ; x �y��
    mov eax, p2Y
    mov dh, byte PTR [eax]                   ; y �y��
    call Gotoxy
    mov eax, 0                               ; ��W�¦�
    call SetTextColor
    mov edx, spaceWithStar
    call WriteString                         ; �л\

    ;�V�W���ʮɡA���F�n���h�U���A�]�n�s�W�W��"*"
    mov eax, p2X
    mov dl, byte PTR [eax]                  ; x �y��
    mov eax, p2Y
    mov dh, byte PTR [eax]                  ; y �y��
    sub dh, byte PTR [paddleHeight]         ;��hpaddle���ױo�̰��I�y��
    call Gotoxy
    mov eax, color2                         ; ����O�O
    call SetTextColor
    mov edx, spaceWithStar
    call WriteString                        ; ��*

    ;[ebx]�}�Y�s�۷�ɪ�y�y��
    sub [ebx], dword PTR 1                  ;[ebx]-1 �o�s�y��
    jmp continueN

MoveDownP2:
    ;��O�l�I��Uborder�A������(cont.)
    ; eax = p1Y , [ebx] �]�s�۷�ɪ�y�y��!!!!
    mov ebx, p2Y
	mov eax, [ebx]
    inc eax                                 ;p2Y + 1�өM�̩�Y�y�жi����
	cmp eax, playLowEdge                    ;�p�GY�y�Фj�󵥩�Edge
	jae continueN                           ;���hcontinueN, �����U��n�D

    ;���U���ʮɡA�л\�̤W����"*",���ɪ�XY�y��
    ;�]���ڭ̬O�ѤU���W�e�A�ҥH��ɪ��y�з|�O�̤U��
    mov eax, p2X
    mov dl, byte PTR [eax]                  ; x �y��
    mov eax, p2Y
    mov dh, byte PTR [eax]                  ; y �y��
    sub dh, byte PTR [paddleHeight]         ;��hpaddle���ױo�̰��I�y��
    add dh, byte PTR 1
    call Gotoxy
    mov eax, 0                              ; ��W�¦�
    call SetTextColor
    mov edx, spaceWithStar
    call WriteString                        ; �ɶ¦�*

    ;�V�U���ʮɡA���F�n���h�W���A�]�n�s�W�U��"*"
    mov eax, p2X
    mov dl, byte PTR [eax]                  ; x �y��
    mov eax, p2Y
    mov dh, byte PTR [eax]                  ; y �y��
    add dh, byte PTR 1                      ;�[�@���ױo�̧C�I�y��
    call Gotoxy
    mov eax, color2                         ; ���O�O
    call SetTextColor
    mov edx, spaceWithStar
    call WriteString                        ;��*

    add [ebx], dword PTR 1                  ;[ebx]+1 �o�s�y��
    jmp continueN

; ���ܾާ@
Hint:
	INVOKE MessageBox, NULL, ADDR HintText,
	  ADDR HintTitle, MB_OK
    jmp continueN

continueN:
    
    mGotoxy 0,0         ;�̲��I�]0,0
    cmp al,"h"
    je Hint
    popad
	ret
ReadKeyBoard endp
end