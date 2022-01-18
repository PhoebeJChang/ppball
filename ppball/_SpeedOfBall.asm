; (_SpeedOfBall.asm)

include ppball.inc

.code 
SpeedOfBall PROC,
	timedu: dword 

	; timedu - the length of time to SpeedOfBall in milliseconds

    pushad		;save general-purpose register

	mov eax, timedu
	call Delay

    popad		;restore
	ret
SpeedOfBall endp
end

;text 5.2.1