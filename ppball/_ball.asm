include ppball.inc

.code
Ball proc,
	color: dword,				;BALL_COLOR : black+(yellow * 16)
	Ball_X: ptr dword,			;球的X座標
	Ball_Y: ptr dword,			;球的Y座標
	xMove: ptr dword,			;球在跑的時候x移動 dword 2
	yMove: ptr dword,			;球在跑的時候y移動 dword 1
	buffer: ptr byte,			;球笑臉(不見了QAQ)
	playTopEdgeOffset: dword,
	boardsinBetween: dword,
    p1X: dword,
    p1Y: dword,
    p2X: dword,
    p2Y: dword,
	paddleHeight: dword,
	RESET_BALL_RATE: dword		;為了invoke reset ball
	

	pushad
	
	mov eax, Ball_X		;球的X座標

	; 左邊範圍: 如果球跑出範圍，reset
	mov ebx, p1X		;在player 1 的X座標就是右邊邊框範圍
	sub ebx, 5			;比邊框再進去一點點
	cmp [eax], ebx		;如果Ball_X < p1X，此時eax是ball的X座標
	jb Reset
	
	; 右邊範圍: 如果球跑出範圍，reset
	mov ebx, p2X		;在player 2 的X座標就是右邊邊框範圍
	add ebx, 5			;比邊框再出來一點點~
	cmp [eax], ebx		;如果[eax] > ebx，此時eax是ball的X座標
	ja Reset			;如果超過則跳去reset
	;player1 分數此時要加一 inc p1+1!!!

	jb BangTest
	;player2 分數此時要加一 inc p2+1!!!

Reset:
	;球起始點設定，大概從中間的位置(20+40,5+12)
	mov eax, playTopEdgeOffset	;從上邊框往下
	add eax, 12					;=17
	mov ebx, p1X				;從左邊板子數過來
	add ebx, 40					;=60

	;新座標傳入resset
	invoke ResetBall, Ball_X, Ball_Y, ebx, eax, RESET_BALL_RATE
	jmp ContinueN

;在range內的球，測試各邊碰撞與否	
BangTest:
	;比較有沒有碰到底
	mov eax, [Ball_Y]
	mov ebx, playTopEdgeOffset
	add ebx, boardsinBetween
    dec ebx						;底部的Y座標
	cmp [eax], ebx				;球的Y座標和底borderY座標比較
	jb NotYetBottom				;如果低於，跳去NotYetBottom
	;若高於Y座標變負的，回彈
	mov eax, [yMove]
	neg dword ptr [eax]			;Y座標負數反彈
	
NotYetBottom:
	;繼續比較Y座標
    mov eax, [Ball_Y]
	mov ebx, playTopEdgeOffset
	inc ebx						;ebx+1，上面border有1的厚度
	cmp [eax], ebx				;球的Y座標和上borderY座標比較
	ja NotYetTop				;高於則代表還沒飛到頂
	;若低於Y座標變負的，回彈往下
	mov eax, [yMove]			
	neg dword ptr [eax]			;往下飛
	
NotYetTop:
	;這裡比較是否撞到右邊paddle，X座標
	;右板子往內3小格(視覺上差異)
	mov eax, p2X
	mov ebx, eax
	sub ebx,3
	;球和座標比較
	mov eax, [Ball_X]
	cmp [eax], ebx
	jb NotYetHitP2			;若小於，代表球X座標還沒飛到

	;大於，可能碰到板子了
	;接著判斷Y座標
	mov eax, p2Y
	mov ebx, eax
	mov eax, [Ball_Y]
	cmp [eax], ebx			;若大於，代表球Y座標還沒飛到
	ja NotYetHitP2			;也就是說此時球比板子還要下面

	;小於，可能碰到板子了
	;接著判斷有沒有在板子大小範圍內
	;由下往上數5格內才算碰到
	mov ebx, p2Y			;板子Y座標傳入ebx
	sub ebx, paddleHeight
	inc ebx					;板子最高點座標
	mov eax, [Ball_Y]		;球Y座標EAX
	cmp [eax], ebx			;比較，若再小於，代表球的位置比板子高(更上方)
	jb NotYetHitP2			;沒碰到右板子，跳去[還沒碰到右板子]
	;大於了，代表碰到右側，更改xMove
	mov eax, [xMove]
	neg dword ptr [eax]		;變負數往反方向回彈	

	;以上結束所有碰到右板子的判斷

NotYetHitP2:
	;還沒碰到右板子
	;開始比較左邊板子判定
	mov ebx, p1X			;左邊板子X座標傳入EBX
    add ebx, 2				;視覺上差異，EBX+2
	mov eax, [Ball_X]		;球的X座標傳入EAX

	;球的X座標和板子X座標比較
	cmp [eax], ebx			;若大於，代表球還沒碰到左板子的可能性
	ja NotYetHitP1			;跳去還沒碰到左板子的label

	;若小於，有碰到板子的可能性
	;判斷Y座標，注意此時是板子Y座標底判斷
	mov ebx, p1Y
	mov eax, [Ball_Y]
	cmp [eax], ebx			;比較兩者Y座標，若大於，代表球比板子還要更下方
	ja NotYetHitP1			;跳去還沒碰到左板子
	
	;若小於，代表球的位置比板子底高
	;判斷有無在板子高度內
	mov ebx, p1Y
	sub ebx, paddleHeight
	inc ebx					;板子最高點座標
	mov eax, [Ball_Y]
	cmp [eax], ebx			;比較兩者，若小於代表此時球的高度比板子最高點還要高
	jb NotYetHitP1			;沒碰到左板子

	;碰到了，xMove改變方向
	mov eax, [xMove]
	neg dword ptr [eax]		;反方向飛

	;以上結束所有上下左右可能性
NotYetHitP1:
	;不需要再進行比較，直接跳去下方做球的移動和座標變化
BallMovement:
	;遮掉當下的球
	mov eax, 0				;塗黑
	call SetTextColor
    ;要遮掉的座標位置
    mov eax, [Ball_X]
	mov dl, [eax]
	mov eax, [Ball_Y]
	mov dh, [eax]
	call Gotoxy
	mov edx, buffer
	call WriteString		;畫出

	; 更新球的XY座標，畫新的球
	; X座標
	mov eax, xMove			;2
    mov ebx, [eax]			;ebx = xMove
    mov eax, [Ball_X]		;eax = Ball_X
    add ebx, [eax]			;X當下座標加上2
	mov [eax], ebx			;新的X座標
	mov dl, [eax]			;Gotoxy
	; Y座標
	mov eax, yMove			;1
	mov ebx, [eax]			;1
	mov eax, [Ball_Y]		;Y當下座標
	add ebx, [eax]			;Y當下座標加上1
	mov [eax], ebx			;新的Y座標
	mov dh, [eax]			;Gotoxy
	
	;傳入新座標，印出新球球
	mov eax, color			;黃色
	call SetTextColor
	call Gotoxy				;新球球座標定出
	mov edx, buffer
	call WriteString		;印出新球球
		
ContinueN:
	mGotoxy 0,0
	popad
	ret

Ball endp
end
	
	