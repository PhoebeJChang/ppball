; newBallTime
include ppball.inc

.code 
NewBallTime PROC,
	revive: dword 

    pushad	

	mov eax, revive
	call Delay

    popad
	ret
NewBallTime endp
end

;���� 5.2.1(�ҥ�)