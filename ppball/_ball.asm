include ppball.inc

.code
Ball proc,
	color: dword,				;BALL_COLOR : black+(yellow * 16)
	Ball_X: ptr dword,			;�y��X�y��
	Ball_Y: ptr dword,			;�y��Y�y��
	xMove: ptr dword,			;�y�b�]���ɭ�x���� dword 2
	yMove: ptr dword,			;�y�b�]���ɭ�y���� dword 1
	buffer: ptr byte,			;�y���y(�����FQAQ)
	playTopEdgeOffset: dword,
	boardsinBetween: dword,
    p1X: dword,
    p1Y: dword,
    p2X: dword,
    p2Y: dword,
	paddleHeight: dword,
	RESET_BALL_RATE: dword		;���Finvoke reset ball
	

	pushad
	
	mov eax, Ball_X		;�y��X�y��

	; ����d��: �p�G�y�]�X�d��Areset
	mov ebx, p1X		;�bplayer 1 ��X�y�дN�O�k����ؽd��
	sub ebx, 5			;����ئA�i�h�@�I�I
	cmp [eax], ebx		;�p�GBall_X < p1X�A����eax�Oball��X�y��
	jb Reset
	
	; �k��d��: �p�G�y�]�X�d��Areset
	mov ebx, p2X		;�bplayer 2 ��X�y�дN�O�k����ؽd��
	add ebx, 5			;����ئA�X�Ӥ@�I�I~
	cmp [eax], ebx		;�p�G[eax] > ebx�A����eax�Oball��X�y��
	ja Reset			;�p�G�W�L�h���hreset
	;player1 ���Ʀ��ɭn�[�@ inc p1+1!!!

	jb BangTest
	;player2 ���Ʀ��ɭn�[�@ inc p2+1!!!

Reset:
	;�y�_�l�I�]�w�A�j���q��������m(20+40,5+12)
	mov eax, playTopEdgeOffset	;�q�W��ة��U
	add eax, 12					;=17
	mov ebx, p1X				;�q����O�l�ƹL��
	add ebx, 40					;=60

	;�s�y�жǤJresset
	invoke ResetBall, Ball_X, Ball_Y, ebx, eax, RESET_BALL_RATE
	jmp ContinueN

;�brange�����y�A���զU��I���P�_	
BangTest:
	;������S���I�쩳
	mov eax, [Ball_Y]
	mov ebx, playTopEdgeOffset
	add ebx, boardsinBetween
    dec ebx						;������Y�y��
	cmp [eax], ebx				;�y��Y�y�ЩM��borderY�y�Ф��
	jb NotYetBottom				;�p�G�C��A���hNotYetBottom
	;�Y����Y�y���ܭt���A�^�u
	mov eax, [yMove]
	neg dword ptr [eax]			;Y�y�Эt�Ƥϼu
	
NotYetBottom:
	;�~����Y�y��
    mov eax, [Ball_Y]
	mov ebx, playTopEdgeOffset
	inc ebx						;ebx+1�A�W��border��1���p��
	cmp [eax], ebx				;�y��Y�y�ЩM�WborderY�y�Ф��
	ja NotYetTop				;����h�N���٨S���쳻
	;�Y�C��Y�y���ܭt���A�^�u���U
	mov eax, [yMove]			
	neg dword ptr [eax]			;���U��
	
NotYetTop:
	;�o�̤���O�_����k��paddle�AX�y��
	;�k�O�l����3�p��(��ı�W�t��)
	mov eax, p2X
	mov ebx, eax
	sub ebx,3
	;�y�M�y�Ф��
	mov eax, [Ball_X]
	cmp [eax], ebx
	jb NotYetHitP2			;�Y�p��A�N��yX�y���٨S����

	;�j��A�i��I��O�l�F
	;���ۧP�_Y�y��
	mov eax, p2Y
	mov ebx, eax
	mov eax, [Ball_Y]
	cmp [eax], ebx			;�Y�j��A�N��yY�y���٨S����
	ja NotYetHitP2			;�]�N�O�����ɲy��O�l�٭n�U��

	;�p��A�i��I��O�l�F
	;���ۧP�_���S���b�O�l�j�p�d��
	;�ѤU���W��5�椺�~��I��
	mov ebx, p2Y			;�O�lY�y�жǤJebx
	sub ebx, paddleHeight
	inc ebx					;�O�l�̰��I�y��
	mov eax, [Ball_Y]		;�yY�y��EAX
	cmp [eax], ebx			;����A�Y�A�p��A�N��y����m��O�l��(��W��)
	jb NotYetHitP2			;�S�I��k�O�l�A���h[�٨S�I��k�O�l]
	;�j��F�A�N��I��k���A���xMove
	mov eax, [xMove]
	neg dword ptr [eax]		;�ܭt�Ʃ��Ϥ�V�^�u	

	;�H�W�����Ҧ��I��k�O�l���P�_

NotYetHitP2:
	;�٨S�I��k�O�l
	;�}�l�������O�l�P�w
	mov ebx, p1X			;����O�lX�y�жǤJEBX
    add ebx, 2				;��ı�W�t���AEBX+2
	mov eax, [Ball_X]		;�y��X�y�жǤJEAX

	;�y��X�y�ЩM�O�lX�y�Ф��
	cmp [eax], ebx			;�Y�j��A�N��y�٨S�I�쥪�O�l���i���
	ja NotYetHitP1			;���h�٨S�I�쥪�O�l��label

	;�Y�p��A���I��O�l���i���
	;�P�_Y�y�СA�`�N���ɬO�O�lY�y�Щ��P�_
	mov ebx, p1Y
	mov eax, [Ball_Y]
	cmp [eax], ebx			;������Y�y�СA�Y�j��A�N��y��O�l�٭n��U��
	ja NotYetHitP1			;���h�٨S�I�쥪�O�l
	
	;�Y�p��A�N��y����m��O�l����
	;�P�_���L�b�O�l���פ�
	mov ebx, p1Y
	sub ebx, paddleHeight
	inc ebx					;�O�l�̰��I�y��
	mov eax, [Ball_Y]
	cmp [eax], ebx			;�����̡A�Y�p��N���ɲy�����פ�O�l�̰��I�٭n��
	jb NotYetHitP1			;�S�I�쥪�O�l

	;�I��F�AxMove���ܤ�V
	mov eax, [xMove]
	neg dword ptr [eax]		;�Ϥ�V��

	;�H�W�����Ҧ��W�U���k�i���
NotYetHitP1:
	;���ݭn�A�i�����A�������h�U�谵�y�����ʩM�y���ܤ�
BallMovement:
	;�B����U���y
	mov eax, 0				;���
	call SetTextColor
    ;�n�B�����y�Ц�m
    mov eax, [Ball_X]
	mov dl, [eax]
	mov eax, [Ball_Y]
	mov dh, [eax]
	call Gotoxy
	mov edx, buffer
	call WriteString		;�e�X

	; ��s�y��XY�y�СA�e�s���y
	; X�y��
	mov eax, xMove			;2
    mov ebx, [eax]			;ebx = xMove
    mov eax, [Ball_X]		;eax = Ball_X
    add ebx, [eax]			;X��U�y�Х[�W2
	mov [eax], ebx			;�s��X�y��
	mov dl, [eax]			;Gotoxy
	; Y�y��
	mov eax, yMove			;1
	mov ebx, [eax]			;1
	mov eax, [Ball_Y]		;Y��U�y��
	add ebx, [eax]			;Y��U�y�Х[�W1
	mov [eax], ebx			;�s��Y�y��
	mov dh, [eax]			;Gotoxy
	
	;�ǤJ�s�y�СA�L�X�s�y�y
	mov eax, color			;����
	call SetTextColor
	call Gotoxy				;�s�y�y�y�Щw�X
	mov edx, buffer
	call WriteString		;�L�X�s�y�y
		
ContinueN:
	mGotoxy 0,0
	popad
	ret

Ball endp
end
	
	