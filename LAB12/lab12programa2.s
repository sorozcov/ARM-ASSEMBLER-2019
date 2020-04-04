/*Silvio Orozco 18282*/
/*Jose Castaneda 18161*/
/* Laboratorio 12 Programa 2 */
/* 06-mayo-2019 */
 .text
 .align 2
 .global main
 
error:
	ldr r0,=mensaje_error
	bl puts
	bl getchar @para que borre la informacion del buffer de teclado
	bl number0
	b obtenerNumero

errorNumero:
	ldr r0,=mensaje_errornumero
	bl puts
	bl number0
	bl getchar @para que borre la informacion del buffer de teclado
	b obtenerNumero
	
main:
	
	@utilizando la biblioteca GPIO (gpio0.s)
	bl GetGpioAddress @solo se llama una vez
	
	
	@GPIO para escritura puerto 13
	mov r0,#13
	mov r1,#1
	bl SetGpioFunction
	
	@GPIO para escritura puerto 19
	mov r0,#19
	mov r1,#1
	bl SetGpioFunction
	
	@GPIO para escritura puerto 26
	mov r0,#26
	mov r1,#1
	bl SetGpioFunction
	

	/*Mensaje de bienvenida*/
	ldr r0,=bienvenido
	bl puts
	
	bl number0

obtenerNumero:	
		
	
	
	/*Mensaej de ingreso*/
	ldr r0,=mensaje_ingreso
	bl puts
	
	/*scanf de valor*/
	ldr r0,=entrada
	ldr r1,=temp
	bl scanf
	
	
	
	
	@ compara y salta si r0 es 0 (error)
	cmp r0,#0
	beq error
	
	
	
	ldr r1,=temp
	ldr r1,[r1]
	cmp r1,#0
	blt errorNumero
	cmp r1,#7
	bgt errorNumero
	
	
	
	/*R4 PARA COMPARAR CADA BIT DEL NUMERO ENTRE 0 Y 7 Y ASI ENCENDER O APAGAR.*/
	ldr r1,=temp
	ldrb r1,[r1,#0]
	
	
	/*Comparamos por numero para ver cual es*/
	cmp r1,#0
	bleq number0

	cmp r1,#1
	bleq number1

	cmp r1,#2
	bleq number2
	
	cmp r1,#3
	bleq number3
	
	cmp r1,#4
	bleq number4
	
	cmp r1,#5
	bleq number5
	
	cmp r1,#6
	bleq number6
	
	cmp r1,#7
	bleq number7
	
	
	b obtenerNumero
	
bin30:
	push {lr}
	
	@GPIO 13 apaga el led (apaga puerto> directa)
	mov r0,#13
	mov r1,#0
	bl SetGpio
	pop {lr}
	MOV pc,lr


bin20:
	push {lr}
	@GPIO 19 apaga el led (apaga puerto> directa)
	mov r0,#19
	mov r1,#0
	bl SetGpio
	pop {lr}
	MOV pc,lr

bin10:
	push {lr}
	@GPIO 26 apaga el led (apaga puerto> directa)
	mov r0,#26
	mov r1,#0
	bl SetGpio
	pop {lr}
	MOV pc,lr
	
bin31:
	push {lr}
	@GPIO 13 enciende el led (apaga puerto> directa)
	mov r0,#13
	mov r1,#1
	bl SetGpio
	pop {lr}
	MOV pc,lr

bin21:
	push {lr}
	@GPIO 19 enciende el led (apaga puerto> directa)
	mov r0,#19
	mov r1,#1
	bl SetGpio
	pop {lr}
	MOV pc,lr

bin11:
	push {lr}
	@GPIO 26 enciende el led (apaga puerto> directa)
	mov r0,#26
	mov r1,#1
	bl SetGpio
	pop {lr}
	MOV pc,lr

number0:
	push {lr}
	bl bin10
	bl bin20
	bl bin30
	pop {lr}
	MOV pc,lr

number1:
	push {lr}
	bl bin10
	bl bin20
	bl bin31
	pop {lr}
	MOV pc,lr

number2:	
	push {lr}
	bl bin10
	bl bin21
	bl bin30
	pop {lr}
	MOV pc,lr
	
number3:	
	push {lr}
	bl bin10
	bl bin21
	bl bin31
	pop {lr}
	MOV pc,lr
	
number4:	
	push {lr}	
	cmp r1,#4
	bl bin11
	bl bin20
	bl bin30
	pop {lr}
	MOV pc,lr
	
number5:	
	push {lr}
	bl bin11
	bl bin20
	bl bin31
	pop {lr}
	MOV pc,lr
	
number6:	
	push {lr}
	bl bin11
	bl bin21
	bl bin30
	pop {lr}
	MOV pc,lr
	
number7:	
	push {lr}
	bl bin11
	bl bin21
	bl bin31
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
bienvenido:			.asciz "Bienvenido al programa para mostrar un numero en binario con LEDs. "
mensaje_error: 		.asciz "Error en dato ingresado. Debes ingresar un numero."
mensaje_ingreso: 		.asciz "Ingrese un numero:"
mensaje_errornumero: 		.asciz "Error en dato ingresado. Debes ingresar un numero entre 0 y 7."
entrada:
	.asciz "%d"
temp:				
	.word 0		@temporal de ingreso

 .end

