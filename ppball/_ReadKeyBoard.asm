include ppball.inc
.data
            
HintTitle BYTE "遊戲操作方法",0
HintText  BYTE "左側玩家操控WS鍵來移動Paddle；          "
	       BYTE "右側玩家操控上下鍵來移動Paddle",0

.code 
ReadKeyBoard proc,
     color: dword,
    color2: dword,
	p1X: PTR dword,						; 玩家一 x座標
	p1Y: PTR dword,						; 玩家一 y座標
	p2X: PTR dword,						; 玩家二 x座標
	p2Y: PTR dword,						; 玩家二 y座標
	paddleHeight: dword,                ;5
	playTopEdge: dword,                 ;最上座標
	playLowEdge: dword,                 ;最下座標
    spaceWithStar: ptr byte				;"*"
    
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

;藍色板板有MoveUpP1, MoveDownP1兩個label
MoveUpP1: 
    ;當板子碰到上border，不給動(cont.)
    ; eax = p1Y , [ebx] 存著當時的y座標!!!!
    mov ebx, p1Y
	mov eax, [ebx]
	sub eax, [paddleHeight]				; y - height
	cmp eax, playTopEdge                ;如果小於等於
	jbe continueN                       ;跳continue, 忽略上鍵要求

    ;往上移動時，覆蓋最下面的"*",抓當時的XY座標
    ;因為我們是由下往上畫，所以當時的座標會是最下方
     mov eax, p1X
     mov dl, byte PTR [eax]                  ; x 座標
     mov eax, p1Y
     mov dh, byte PTR [eax]                  ; y 座標
     call Gotoxy
     mov eax, 0                              ; 塗上黑色
     call SetTextColor
     mov edx, spaceWithStar
     call WriteString                        ; 覆蓋

     ;向上移動時，除了要擦去下面，也要新增上方"*"
     mov eax, p1X
     mov dl, byte PTR [eax]                  ; x 座標
     mov eax, p1Y
     mov dh, byte PTR [eax]                  ; y 座標
     sub dh, byte PTR [paddleHeight]         ;減去paddle高度得最高點座標
     call Gotoxy
     mov eax, color                          ;藍色板板~~
     call SetTextColor
     mov edx, spaceWithStar
     call WriteString                        ; 畫上

     ;[ebx]開頭存著當時的y座標
     sub [ebx], dword PTR 1                  ;[ebx]-1 得新座標
     jmp continueN

MoveDownP1:
    ;當板子碰到下border，不給動(cont.)
    ; eax = p1Y , [ebx] 也存著當時的y座標!!!!
     mov ebx, p1Y
	 mov eax, [ebx]
     inc eax                                ;p1Y + 1來和最底Y座標進行比較
	 cmp eax, playLowEdge                   ;如果Y座標大於等於Edge
	 jae continueN                          ;跳去continueN, 忽略下鍵要求

     ;往下移動時，覆蓋最上面的"*",抓當時的XY座標
     ;因為我們是由下往上畫，所以當時的座標會是最下方
     mov eax, p1X
     mov dl, byte PTR [eax]                  ; x 座標
     mov eax, p1Y
     mov dh, byte PTR [eax]                  ; y 座標
     sub dh, byte PTR [paddleHeight]         ;減去paddle高度得最高點座標
     add dh, byte PTR 1                      ;記得加一!!                      
     call Gotoxy
     mov eax, 0                              ; 塗上黑色
     call SetTextColor                       
     mov edx, spaceWithStar
     call WriteString                        ; 覆蓋最上面的*

     ;向下移動時，除了要擦去上面，也要新增下方"*"
     mov eax, p1X
     mov dl, byte PTR [eax]                  ; x 座標
     mov eax, p1Y
     mov dh, byte PTR [eax]                  ; y 座標
     add dh, byte PTR 1                      ;加一高度得最低點座標
     call Gotoxy
     mov eax, color                          ; 藍色板板
     call SetTextColor
     mov edx, spaceWithStar
     call WriteString                        ; 畫上

     add [ebx], dword PTR 1                  ;[ebx]+1 得新座標
     jmp continueN

;紅色板板有MoveUpP2, MoveDownP2兩個label
MoveUpP2:
    ;當板子碰到上border，不給動(cont.)
    ; eax = p2Y , [ebx] 存著當時的y座標!!!!
    mov ebx, p2Y
	mov eax, [ebx]                      
	sub eax, [paddleHeight]				     ; y - height
	cmp eax, playTopEdge                     ;如果小於等於
	jbe continueN                            ;跳continue, 忽略上鍵要求

    ;往上移動時，覆蓋最下面的"*",抓當時的XY座標
    ;因為我們是由下往上畫，所以當時的座標會是最下方
    mov eax, p2X
    mov dl, byte PTR [eax]                   ; x 座標
    mov eax, p2Y
    mov dh, byte PTR [eax]                   ; y 座標
    call Gotoxy
    mov eax, 0                               ; 塗上黑色
    call SetTextColor
    mov edx, spaceWithStar
    call WriteString                         ; 覆蓋

    ;向上移動時，除了要擦去下面，也要新增上方"*"
    mov eax, p2X
    mov dl, byte PTR [eax]                  ; x 座標
    mov eax, p2Y
    mov dh, byte PTR [eax]                  ; y 座標
    sub dh, byte PTR [paddleHeight]         ;減去paddle高度得最高點座標
    call Gotoxy
    mov eax, color2                         ; 紅色板板
    call SetTextColor
    mov edx, spaceWithStar
    call WriteString                        ; 補*

    ;[ebx]開頭存著當時的y座標
    sub [ebx], dword PTR 1                  ;[ebx]-1 得新座標
    jmp continueN

MoveDownP2:
    ;當板子碰到下border，不給動(cont.)
    ; eax = p1Y , [ebx] 也存著當時的y座標!!!!
    mov ebx, p2Y
	mov eax, [ebx]
    inc eax                                 ;p2Y + 1來和最底Y座標進行比較
	cmp eax, playLowEdge                    ;如果Y座標大於等於Edge
	jae continueN                           ;跳去continueN, 忽略下鍵要求

    ;往下移動時，覆蓋最上面的"*",抓當時的XY座標
    ;因為我們是由下往上畫，所以當時的座標會是最下方
    mov eax, p2X
    mov dl, byte PTR [eax]                  ; x 座標
    mov eax, p2Y
    mov dh, byte PTR [eax]                  ; y 座標
    sub dh, byte PTR [paddleHeight]         ;減去paddle高度得最高點座標
    add dh, byte PTR 1
    call Gotoxy
    mov eax, 0                              ; 塗上黑色
    call SetTextColor
    mov edx, spaceWithStar
    call WriteString                        ; 補黑色*

    ;向下移動時，除了要擦去上面，也要新增下方"*"
    mov eax, p2X
    mov dl, byte PTR [eax]                  ; x 座標
    mov eax, p2Y
    mov dh, byte PTR [eax]                  ; y 座標
    add dh, byte PTR 1                      ;加一高度得最低點座標
    call Gotoxy
    mov eax, color2                         ; 紅板板
    call SetTextColor
    mov edx, spaceWithStar
    call WriteString                        ;補*

    add [ebx], dword PTR 1                  ;[ebx]+1 得新座標
    jmp continueN

; 提示操作
Hint:
	INVOKE MessageBox, NULL, ADDR HintText,
	  ADDR HintTitle, MB_OK
    jmp continueN

continueN:
    
    mGotoxy 0,0         ;最終點設0,0
    cmp al,"h"
    je Hint
    popad
	ret
ReadKeyBoard endp
end