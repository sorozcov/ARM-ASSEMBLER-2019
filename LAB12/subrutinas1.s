/* Silvio Orozco 18282 */
/* Jose Castaneda 18162 */
/* Laboratorio12 */
/* Subruitina encenderLed22 */
/* 06-MAYO-2019 */
.global encenderLed22


encenderLed22:
	push {lr}
	@GPIO 17 apaga el led (apaga puerto> directa)
	mov r0,#17
	mov r1,#0
	bl SetGpio

	@GPIO 22 enciende el led (enciende puerto> directa)
	mov r0,#22
	mov r1,#1
	bl SetGpio
	pop {lr}
	MOV pc,lr

encenderLed17:
	push {lr}
	
	@GPIO 22 apaga el led (apaga puerto> directa)
	mov r0,#22
	mov r1,#0
	bl SetGpio

	@GPIO 17 enciende el led (enciende puerto> directa)
	mov r0,#17
	mov r1,#1
	bl SetGpio
	
	pop {lr}
	MOV pc,lr

.data
