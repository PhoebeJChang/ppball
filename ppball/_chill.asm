; (_chill.asm)

include ppball.inc

.code 
Chill PROC,
	timedu: dword 

	; timedu - the length of time to chill in milliseconds

    pushad		;save general-purpose register

	mov eax, timedu
	call Delay

    popad		;restore
	ret
Chill endp
end

;text 5.2.1