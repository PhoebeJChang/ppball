include ppball.inc

.data
;Menu Page
MenuTitle byte "PPball !!",0
MenuClass byte "- 資工二甲 -" ,0
MenuOurName1 byte "張甄庭 409261287",0
MenuOurName2 byte "鍾馥羽 409261328",0
MenuIntroTitle byte "************** -  遊戲介紹  - ***************",0
MenuPlayerOne1 byte "玩家一需要使用W、S鍵",0
MenuPlayerOne2 byte "來控制左邊的",0
MenuPlayerOne3 byte "藍色PADDLE",0
MenuPlayerOne4 byte "上下移動",0

MenuPlayerTwo1 byte "玩家二需要使用上、下鍵",0
MenuPlayerTwo2 byte "來控制右邊的",0
MenuPlayerTwo3 byte "紅色PADDLE",0
MenuPlayerTwo4 byte "上下移動",0

MenuStartGame1 byte "---------- 請按任意鍵 ----------",0
MenuStartGame2 byte "開始遊戲",0

space byte " ", 0
space2 byte "  ", 0
.code
MenuPage proc,
	colorTitle: dword,
    colorText: dword

    pushad

    ;macros
    mGotoxy 55,4
    mov eax, colorTitle
    call SetTextColor
    
    ;mWriteString OFFSET MenuTitle
    
    ;P
    mGotoxy 30,1
    mWriteString OFFSET space2
    mGotoxy 30,2
    mWriteString OFFSET space2
    mGotoxy 30,3
    mWriteString OFFSET space2
    mGotoxy 30,4
    mWriteString OFFSET space2
    mGotoxy 30,5
    mWriteString OFFSET space2
    mGotoxy 30,6
    mWriteString OFFSET space2

    mGotoxy 32,1
    mWriteString OFFSET space2
    mGotoxy 34,1
    mWriteString OFFSET space2

    mGotoxy 36,2
    mWriteString OFFSET space2
    mGotoxy 36,3
    mWriteString OFFSET space2

    mGotoxy 32,4
    mWriteString OFFSET space2
    mGotoxy 34,4
    mWriteString OFFSET space2

    ;P
    mGotoxy 40,1
    mWriteString OFFSET space2
    mGotoxy 40,2
    mWriteString OFFSET space2
    mGotoxy 40,3
    mWriteString OFFSET space2
    mGotoxy 40,4
    mWriteString OFFSET space2
    mGotoxy 40,5
    mWriteString OFFSET space2
    mGotoxy 40,6
    mWriteString OFFSET space2

    mGotoxy 42,1
    mWriteString OFFSET space2
    mGotoxy 44,1
    mWriteString OFFSET space2

    mGotoxy 46,2
    mWriteString OFFSET space2
    mGotoxy 46,3
    mWriteString OFFSET space2

    mGotoxy 42,4
    mWriteString OFFSET space2
    mGotoxy 44,4
    mWriteString OFFSET space2
    
    ;B
    mGotoxy 50,1
    mWriteString OFFSET space2
    mGotoxy 50,2
    mWriteString OFFSET space2
    mGotoxy 50,3
    mWriteString OFFSET space2
    mGotoxy 50,4
    mWriteString OFFSET space2
    mGotoxy 50,5
    mWriteString OFFSET space2
    mGotoxy 50,6
    mWriteString OFFSET space2

    mGotoxy 52,1
    mWriteString OFFSET space2
    mGotoxy 54,1
    mWriteString OFFSET space2

    mGotoxy 56,2
    mWriteString OFFSET space2
    mGotoxy 56,3

    mGotoxy 52,3
    mWriteString OFFSET space2
    mGotoxy 54,3
    mWriteString OFFSET space2

    mGotoxy 56,4
    mWriteString OFFSET space2
    mGotoxy 56,5
    mWriteString OFFSET space2

    mGotoxy 52,6
    mWriteString OFFSET space2
    mGotoxy 54,6
    mWriteString OFFSET space2


    ;A
    mGotoxy 60,2
    mWriteString OFFSET space2
    mGotoxy 60,3
    mWriteString OFFSET space2
    mGotoxy 60,4
    mWriteString OFFSET space2
    mGotoxy 60,5
    mWriteString OFFSET space2
    mGotoxy 60,6
    mWriteString OFFSET space2

    mGotoxy 66,2
    mWriteString OFFSET space2
    mGotoxy 66,3
    mWriteString OFFSET space2
    mGotoxy 66,4
    mWriteString OFFSET space2
    mGotoxy 66,5
    mWriteString OFFSET space2
    mGotoxy 66,6
    mWriteString OFFSET space2

    mGotoxy 62,1
    mWriteString OFFSET space2
    mGotoxy 64,1
    mWriteString OFFSET space2

    mGotoxy 62,4
    mWriteString OFFSET space2
    mGotoxy 64,4
    mWriteString OFFSET space2

    ;L
    mGotoxy 70,1
    mWriteString OFFSET space2
    mGotoxy 70,2
    mWriteString OFFSET space2
    mGotoxy 70,3
    mWriteString OFFSET space2
    mGotoxy 70,4
    mWriteString OFFSET space2
    mGotoxy 70,5
    mWriteString OFFSET space2
    mGotoxy 70,6
    mWriteString OFFSET space2

    mGotoxy 72,6
    mWriteString OFFSET space2
    mGotoxy 74,6
    mWriteString OFFSET space2
    mGotoxy 76,6
    mWriteString OFFSET space2

    ;L
    mGotoxy 80,1
    mWriteString OFFSET space2
    mGotoxy 80,2
    mWriteString OFFSET space2
    mGotoxy 80,3
    mWriteString OFFSET space2
    mGotoxy 80,4
    mWriteString OFFSET space2
    mGotoxy 80,5
    mWriteString OFFSET space2
    mGotoxy 80,6
    mWriteString OFFSET space2

    mGotoxy 82,6
    mWriteString OFFSET space2
    mGotoxy 84,6
    mWriteString OFFSET space2
    mGotoxy 86,6
    mWriteString OFFSET space2

    ;WE ARE?
    mov eax, white + (gray*16)
    call SetTextColor
    mGotoxy 53,10
    mWriteString OFFSET MenuClass

    mov eax, colorText
    call SetTextColor
    mGotoxy 51,13
    mWriteString OFFSET MenuOurName1
    mGotoxy 51,15
    mWriteString OFFSET MenuOurName2

    ;遊戲介紹 
    mov eax, white + (gray*16)
    call SetTextColor
    mGotoxy 37,18
    mWriteString OFFSET MenuIntroTitle      ;遊戲介紹

    mov eax, colorText
    call SetTextColor
    mGotoxy 50, 20
    mWriteString OFFSET MenuPlayerOne1
    mGotoxy 45,22
    mWriteString OFFSET MenuPlayerOne2
    mov eax, white + (lightBlue*16)
    call SetTextColor
    mWriteString OFFSET MenuPlayerOne3
    mov eax, colorText
    call SetTextColor
    mWriteString OFFSET MenuPlayerOne4

    mGotoxy 50, 25
    mWriteString OFFSET MenuPlayerTwo1
    mGotoxy 45,27
    mWriteString OFFSET MenuPlayerTwo2
    mov eax, white + (lightRed*16)
    call SetTextColor
    mWriteString OFFSET MenuPlayerTwo3
    mov eax, colorText
    call SetTextColor
    mWriteString OFFSET MenuPlayerTwo4

    mGotoxy 44, 30
    mWriteString OFFSET MenuStartGame1
    mov eax, white + (lightMagenta*16)
    call SetTextColor
    mGotoxy 56, 32
    mWriteString OFFSET MenuStartGame2
    mov eax, colorText
    call SetTextColor
    mWriteString OFFSET space

    popad
    ret
MenuPage endp
end