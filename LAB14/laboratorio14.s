/*Silvio Orozco 18282*/
/*Jose Castaneda 18161*/
/* Laboratorio 14 Programa Timer */
/* 17-mayo-2019 */
 .text
 .align 2
 .global main
 
error:
	ldr r0,=mensaje_error
	bl puts
	bl getchar @para que borre la informacion del buffer de teclado
	b mainmenu

errorNumero1:
	ldr r0,=mensaje_errornumero1
	bl puts
	bl getchar @para que borre la informacion del buffer de teclado
	b mainmenu
	
main:
	
	@utilizando la biblioteca GPIO (gpio0.s)
	bl GetGpioAddress @solo se llama una vez
	
	
	@GPIO para escritura puerto 17
	mov r0,#17
	mov r1,#1
	bl SetGpioFunction
	

	/*Mensaje de bienvenida*/
	ldr r0,=bienvenido
	bl puts
	
mainmenu:
	/*Mostrar menu. */
	ldr r0,=menus
	bl puts
	
	/*scanf del valor ingresado*/
	ldr r0,=entrada
	ldr r1,=temp
	bl scanf
	
	@ compara y salta si r0 es 0 (error)
	cmp r0,#0
	beq error
	
	ldr r1,=temp
	ldr r1,[r1]
	/*Dependiendo de la respuesta va a la opcion.*/
	cmp r1,#1
	beq segundo1
	blt errorNumero1
	cmp r1,#2
	beq segundo2
	cmp r1,#3
	beq segundo4
	cmp r1,#4
	beq endprogram
	bgt errorNumero1

/*Durante 10 segundos con nuestro ciclo calculado enciende 1 segundo, apaga 1 segundo*/	
segundo1:
	bl bin11
	bl retro
	bl bin10
	bl retro
	bl bin11
	bl retro
	bl bin10
	bl retro
	bl bin11
	bl retro
	bl bin10
	bl retro
	bl bin11
	bl retro
	bl bin10
	bl retro
	bl bin11
	bl retro
	bl bin10
	bl retro
	b mainmenu

/*Durante 6 segundos con nuestro ciclo calculado enciende 2 segundo, apaga 2 segundo*/	
segundo2:
	bl bin11
	bl retro
	bl retro
	bl bin10
	bl retro
	bl retro
	bl bin11
	bl retro
	bl retro
	bl bin10
	b mainmenu

/*Durante 12 segundos con nuestro ciclo calculado enciende 4 segundo, apaga 4 segundo*/	
segundo4:
	bl bin11
	bl retro
	bl retro
	bl retro
	bl retro
	bl bin10
	bl retro
	bl retro
	bl retro
	bl retro
	bl bin11
	bl retro
	bl retro
	bl retro
	bl retro
	bl bin10
	b mainmenu
	
endprogram:
	/*Mensaje de salida*/
	ldr r0,=gracias
	bl puts
	MOV R7, #1		@ Exit Syscall
	SWI 0


bin10:
	push {lr}
	@GPIO 17 apaga el led (apaga puerto> directa)
	mov r0,#17
	mov r1,#0
	bl SetGpio
	pop {lr}
	MOV pc,lr

bin11:
	push {lr}
	@GPIO 17 apaga el led (apaga puerto> directa)
	mov r0,#17
	mov r1,#1
	bl SetGpio
	pop {lr}
	MOV pc,lr



 .data
 .align 2
.global myloc
myloc: .word 0
bienvenido:			.asciz "Bienvenido al programa de timer. "
menus:		.asciz "Menu Timer \n 1. Tiempo 1 segundo \n 2. Tiempo 2 segundos \n 3. Tiempo 4 segundos  \n 4.Salir"
mensaje_error: 		.asciz "Error en dato ingresado. Debes ingresar un numero."
mensaje_errornumero1: 		.asciz "Error en dato ingresado. Debes ingresar un numero entre las opciones indicadas 1-4."
gracias:			.asciz "Gracias por utilizar el programa. "
start:   .word 0
cycles:  .word 0
delayReg:.word 0x286c329f
entrada:
	.asciz "%d"
temp:				
	.word 0		@temporal de ingreso

 .end

