/* Silvio Orozco 18282 */
/* Jose Castaneda 18162 */
/* Laboratorio12 */
/* Subruitina encenderLed13 */
/* 06-MAYO-2019 */
.global encenderLed22


encenderLed13:
	push {lr}


	@GPIO 13 enciende el led (enciende puerto> directa)
	mov r0,#13
	mov r1,#1
	bl SetGpio
	pop {lr}
	MOV pc,lr

encenderLed19:
	push {lr}


	@GPIO 19 enciende el led (enciende puerto> directa)
	mov r0,#19
	mov r1,#1
	bl SetGpio
	pop {lr}
	MOV pc,lr
	
encenderLed27:
	push {lr}
	@GPIO 27 enciende el led (enciende puerto> directa)
	mov r0,#27
	mov r1,#1
	bl SetGpio
	pop {lr}
	MOV pc,lr

.data
