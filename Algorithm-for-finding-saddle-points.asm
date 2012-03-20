.data
	col DD 0
	row DD 0
	p   DD 0

...

SaddlePoint proc
	push ebp		; Сохраняем содержимое регистра EBP.
 	mov ebp, esp		; Записываем содержимое стека.
	mov ebx, [EBP+8]	; Записываем в переменную 
	mov row,ebx		; количество строк.
	mov ebx, [EBP+12]	; Тоже самое только со столбцами.
	mov col,ebx		;
	mov esi, [EBP+16]	; Запиываем указатель на матрицу
	xor ecx,ecx		;
	xor edx,edx		;
	.WHILE ecx<row
		xor ebx,ebx
		.WHILE ebx<col
			mov eax,[esi][edx*4] ; Берём элемент массива
			mov p,eax            ; и сохраняем его в переменной.
			;----------------------------------------------
			PUSH ebx	;
			PUSH ecx	; Сохранякм значение регистров
			PUSH edx	;
			;------------------------------------;
				mov eax,col		     ;
				mul ecx			     ;
				mov edx,eax		     ;
				xor ebx,ebx                  ;
				.WHILE ebx<col               ;
					mov eax,[esi][edx*4] ; Проверяем каждый элемент в строке
					cmp p,eax            ;
					jg exit              ;
					inc ebx              ;
					inc edx              ;
				.ENDW                        ;
			;-------------------------------------
			POP edx  ;
			POP ecx  ;
			POP ebx  ; Перегружаем регистры
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
					inc ecx             ; Проверяем каждый элемент в столбике
					mov eax,col         ;
					mul ecx             ;
					add edx,eax         ;
					add edx,ebx         ;
				.ENDW	                    ;
			;------------------------------------
			inc r		; Если всё Ок - седловая точка найдена
			exit:           ;
				POP edx ;
				POP ecx ; Загружаем из стека регистры
				POP ebx	;	
			;----------------------------------------------
			inc ebx ;
			inc edx ; Переходим к следуюшему элементу в строке
		.ENDW
		inc ecx     ;
		mov eax,col ;
		mul ecx     ; Переходим на новую строку матрицы
		add edx,eax ; и снова всё проверяем
	.ENDW
	mov eax,r ; Возвращаем результат в EAX
	pop EBP
 	ret 16
 SaddlePoint endp
