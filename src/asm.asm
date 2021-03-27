.data
arr db 254 dup (?)

.code
GetPrimes proc

	mov rdx, 2 ; value to set current element to

	mov rcx, OFFSET arr

	REPEAT LENGTHOF arr
		mov byte ptr [rcx], dl ; move value into array
		inc rcx
		inc rdx
	ENDM


	xor r15, r15 ; r15 always contains zero

	mov r8, 0 ; r8 = outer loop counter
	xor r10, r10

	mov r11, byte ptr OFFSET arr ; outer element adress
	OuterLoop:
	;{
		mov r9, r8 ; inner loop counter
		inc r9 ; starts with element after outer element

		; if a number is found to not be a prime, it is set to zero. we must not divide by zero
		cmp byte ptr [r11], 0
		je OuterLoopEnd

		mov r12, byte ptr OFFSET arr ; inner element adress
		add r12, r9 ; starts with element after outer element

		InnerLoop:
		;{


			; Prepare for division:
			; AX is divided with DIV's parameter
			; Remainder is in AH


			; we are dividing the inner element with the outer element
			xor ah, ah ; upper part of AX is zero
			mov al, byte ptr [r12] ; lower part is the inner element
			div byte ptr [r11]

			; now AH has the Remainder
			; if the Remainder is zero, we know, that the inner element is not a prime -> set it to zero
			cmp ah, 0
			mov r13b, byte ptr [r12]; ensure, that r13d is not zero
			cmove r13d, r15d ; conditionally move zero into r13d, then move r13b to the inner element - this is done because you cant use cmov for memory and you also cant use a byte register
			mov byte ptr [r12], r13b
				

			InnerLoopEnd:
			inc r12 ; increment adress
		;}
		inc r9
		cmp r9, LENGTHOF arr
		jb InnerLoop

		;}
	OuterLoopEnd:

	inc r11 ; increment adress
	

	

	inc r8 ; increment outer index
	cmp r8, LENGTHOF arr
	jb OuterLoop ; if counter is at zero



	mov rax, OFFSET arr ; return adress of arr

	ret

GetPrimes endp
end