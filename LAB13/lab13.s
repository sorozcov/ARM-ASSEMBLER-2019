/*Silvio Orozco 18282*/
/*Jose Castaneda 18161*/
/* Laboratorio 13 Programa Corrimiento de bit activo */
/* 06-mayo-2019 */
 .text
 .align 2
 .global main
 

	
main:
	
	@utilizando la biblioteca GPIO (gpio0.s)
	bl GetGpioAddress @solo se llama una vez
	
	
	@GPIO para escritura puerto 17
	mov r0,#17
	mov r1,#1
	bl SetGpioFunction
	
	@GPIO para escritura puerto 27
	mov r0,#27
	mov r1,#1
	bl SetGpioFunction
	
	@GPIO para escritura puerto 22
	mov r0,#22
	mov r1,#1
	bl SetGpioFunction
	
	@GPIO para lectura puerto 22
	mov r0,#24
	mov r1,#0
	bl SetGpioFunction
	

	/*Mensaje de bienvenida*/
	ldr r0,=bienvenido
	bl puts
	
	/*Inicializa contador*/
	mov r5,#1
	bl bin31
	bl bin20
	bl bin10
/*Loop para leer el boton*/
loop:
	/*Llama a nuestra subrutina para leer entradas*/
	mov r0,#24
	bl getGPIOInput
	/*Loop para leer el boton*/
	cmp r0,#1
	
	/*Si presiona el boton va a boton encendido*/
	bleq botonEncenido
	bleq wait 	
	/*Regresa al loop*/
	b loop
	
/*Loop para leer el boton*/
botonEncenido:
	push {lr}
	/*Mensaje de corrimiento*/
	ldr r0,=corrimiento
	bl puts
	
	/*Realiza el corrimiento correspondiente*/
	
	cmp r5,#0
	bleq led1
	
	cmp r5,#1
	bleq led2
	
	
	cmp r5,#2
	bleq led3
	
	/*Suma al contador*/
	cmp r5,#2
	addne r5,r5,#1
	moveq r5,#0
	
	pop {lr}
	MOV pc,lr
	
	
/*Enciende el led 1*/
led1:
	push {lr}
	bl bin31
	bl bin20
	bl bin10
	pop {lr}
	MOV pc,lr

/*Enciende el led 2*/
led2:
	push {lr}
	bl bin30
	bl bin21
	bl bin10
	pop {lr}
	MOV pc,lr

/*Enciende el led 3*/	
led3:
	push {lr}
	bl bin30
	bl bin20
	bl bin11
	pop {lr}
	MOV pc,lr


/*Subrutinas de encendido y apagado de GPIOS	*/
bin30:
	push {lr}
	
	@GPIO 17 apaga el led (apaga puerto> directa)
	mov r0,#17
	mov r1,#0
	bl SetGpio
	pop {lr}
	MOV pc,lr


bin20:
	push {lr}
	@GPIO 27 apaga el led (apaga puerto> directa)
	mov r0,#27
	mov r1,#0
	bl SetGpio
	pop {lr}
	MOV pc,lr

bin10:
	push {lr}
	@GPIO 22 apaga el led (apaga puerto> directa)
	mov r0,#22
	mov r1,#0
	bl SetGpio
	pop {lr}
	MOV pc,lr
	
bin31:
	push {lr}
	@GPIO 17 enciende el led (apaga puerto> directa)
	mov r0,#17
	mov r1,#1
	bl SetGpio
	pop {lr}
	MOV pc,lr

bin21:
	push {lr}
	@GPIO 27 enciende el led (apaga puerto> directa)
	mov r0,#27
	mov r1,#1
	bl SetGpio
	pop {lr}
	MOV pc,lr

bin11:
	push {lr}
	@GPIO 22 enciende el led (apaga puerto> directa)
	mov r0,#22
	mov r1,#1
	bl SetGpio
	pop {lr}
	MOV pc,lr



@ brief pause routine
wait:
 mov r0, #0x4000000 @ big number
sleepLoop:
 subs r0,#1
 bne sleepLoop @ loop delay
 mov pc,lr

 .data
 .align 2
.global myloc
myloc: .word 0
bienvenido:			.asciz "Bienvenido al programa para corrimiento de BITS con LEDs. "
corrimiento:			.asciz "El boton ha sido pulsado corrimiento. "
entrada:
	.asciz "%d"
temp:				
	.word 0		@temporal de ingreso

 .end

