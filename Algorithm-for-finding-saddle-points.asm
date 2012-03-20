.data
	col DD 0
	row DD 0
	p   DD 0

...

SaddlePoint proc
	push ebp		; ��������� ���������� �������� EBP.
 	mov ebp, esp		; ���������� ���������� �����.
	mov ebx, [EBP+8]	; ���������� � ���������� 
	mov row,ebx		; ���������� �����.
	mov ebx, [EBP+12]	; ���� ����� ������ �� ���������.
	mov col,ebx		;
	mov esi, [EBP+16]	; ��������� ��������� �� �������
	xor ecx,ecx		;
	xor edx,edx		;
	.WHILE ecx<row
		xor ebx,ebx
		.WHILE ebx<col
			mov eax,[esi][edx*4] ; ���� ������� �������
			mov p,eax            ; � ��������� ��� � ����������.
			;----------------------------------------------
			PUSH ebx	;
			PUSH ecx	; ��������� �������� ���������
			PUSH edx	;
			;------------------------------------;
				mov eax,col		     ;
				mul ecx			     ;
				mov edx,eax		     ;
				xor ebx,ebx                  ;
				.WHILE ebx<col               ;
					mov eax,[esi][edx*4] ; ��������� ������ ������� � ������
					cmp p,eax            ;
					jg exit              ;
					inc ebx              ;
					inc edx              ;
				.ENDW                        ;
			;-------------------------------------
			POP edx  ;
			POP ecx  ;
			POP ebx  ; ����������� ��������
			PUSH ebx ;
			PUSH ecx ;
			PUSH edx ;
			;------------------------------------
				xor ecx,ecx                 ;
				mov edx,ebx                 ;
				.WHILE ecx<row              ;
					mov eax,[esi][edx*4];
					cmp p,eax           ;
					jl exit             ;
					inc ecx             ; ��������� ������ ������� � ��������
					mov eax,col         ;
					mul ecx             ;
					add edx,eax         ;
					add edx,ebx         ;
				.ENDW	                    ;
			;------------------------------------
			inc r		; ���� �� �� - �������� ����� �������
			exit:           ;
				POP edx ;
				POP ecx ; ��������� �� ����� ��������
				POP ebx	;	
			;----------------------------------------------
			inc ebx ;
			inc edx ; ��������� � ���������� �������� � ������
		.ENDW
		inc ecx     ;
		mov eax,col ;
		mul ecx     ; ��������� �� ����� ������ �������
		add edx,eax ; � ����� �� ���������
	.ENDW
	mov eax,r ; ���������� ��������� � EAX
	pop EBP
 	ret 16
 SaddlePoint endp
