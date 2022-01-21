; SpeedOfBall
include ppball.inc

.code 
SpeedOfBall PROC,
	timedu: dword 

    pushad

	mov eax, timedu
	call Delay

    popad
	ret
SpeedOfBall endp
end

;text 5.2.1