; (_newBallTime.asm)

include ppball.inc

.code 
NewBallTime PROC,
	timedu: dword 

	; timedu - the length of time to SpeedOfBall in milliseconds

    pushad		;save general-purpose register

	mov eax, timedu
	call Delay

    popad		;restore
	ret
NewBallTime endp
end

;text 5.2.1