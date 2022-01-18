; (_newBallTime.asm)

include ppball.inc

.code 
NewBallTime PROC,
	revive: dword 

    pushad		;save general-purpose register

	mov eax, revive
	call Delay

    popad		;restore
	ret
NewBallTime endp
end

;text 5.2.1