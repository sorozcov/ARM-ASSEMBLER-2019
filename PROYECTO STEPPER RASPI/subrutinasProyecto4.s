/* Silvio Orozco 18282 */
/* Jose Castaneda 18162 */
/* Proyecto 4 */
/* Subruitinas Movement y Encendido-Apaga GPIOS*/
/* 06-MAYO-2019 */


/*Secuencia de movimiento 1*/
.global movement1

movement1:
	push {lr}
	/*Secuencia1*/
	ldr r0,=secuencia1
	bl puts
	bl bit11
	bl bit20
	bl bit30
	bl bit41
	pop {lr}
	MOV pc,lr
	
/*Secuencia de movimiento 2*/
.global movement2
movement2:
	
	push {lr}
	/*Secuencia2*/
	ldr r0,=secuencia2
	bl puts
	bl bit11
	bl bit21
	bl bit30
	bl bit40
	pop {lr}
	MOV pc,lr

/*Secuencia de movimiento 3*/	
.global movement3
movement3:
	push {lr}
	/*Secuencia3*/
	ldr r0,=secuencia3
	bl puts
	bl bit10
	bl bit21
	bl bit31
	bl bit40
	pop {lr}
	MOV pc,lr
	
/*Secuencia de movimiento 4*/
.global movement4
movement4:
	push {lr}
	/*Secuencia4*/
	ldr r0,=secuencia4
	bl puts
	bl bit10
	bl bit20
	bl bit31
	bl bit41
	pop {lr}
	MOV pc,lr
	

	


/*Subrutinas de encendido y apagado de GPIOS	*/
/*Bit 4 apagado*/
bit40:
	push {lr}
	
	@GPIO 26 apaga el led (apaga puerto> directa)
	mov r0,#26
	mov r1,#0
	bl SetGpio
	pop {lr}
	MOV pc,lr

/*Bit 3 apagado*/	
bit30:
	push {lr}
	
	@GPIO 19 apaga el led (apaga puerto> directa)
	mov r0,#19
	mov r1,#0
	bl SetGpio
	pop {lr}
	MOV pc,lr

/*Bit 2 apagado*/
bit20:
	push {lr}
	@GPIO 13 apaga el led (apaga puerto> directa)
	mov r0,#13
	mov r1,#0
	bl SetGpio
	pop {lr}
	MOV pc,lr

/*Bit 1 apagado*/
bit10:
	push {lr}
	@GPIO 6 apaga el led (apaga puerto> directa)
	mov r0,#6
	mov r1,#0
	bl SetGpio
	pop {lr}
	MOV pc,lr

/*Bit 4 encendido*/	
bit41:
	push {lr}
	@GPIO 26 enciende el led (apaga puerto> directa)
	mov r0,#26
	mov r1,#1
	bl SetGpio
	pop {lr}
	MOV pc,lr


/*Bit 3 encendido*/		
bit31:
	push {lr}
	@GPIO 19 enciende el led (apaga puerto> directa)
	mov r0,#19
	mov r1,#1
	bl SetGpio
	pop {lr}
	MOV pc,lr


/*Bit 2 encendido*/		
bit21:
	push {lr}
	@GPIO 13 enciende el led (apaga puerto> directa)
	mov r0,#13
	mov r1,#1
	bl SetGpio
	pop {lr}
	MOV pc,lr


/*Bit 1 encendido*/	
bit11:
	push {lr}
	@GPIO 6 enciende el led (apaga puerto> directa)
	mov r0,#6
	mov r1,#1
	bl SetGpio
	pop {lr}
	MOV pc,lr

.data
secuencia1:			.asciz "Secuencia 1 enviada. "
secuencia2:			.asciz "Secuencia 2 enviada. "
secuencia3:			.asciz "Secuencia 3 enviada. "
secuencia4:			.asciz "Secuencia 4 enviada. "