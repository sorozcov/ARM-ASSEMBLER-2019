@ Jose Castaneda 18161
@ Silvio Orozco 18282
@ Lab12_Pr1.s

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
	@GPIO para escritura puerto 22
	mov r0,#22
	mov r1,#1
	bl SetGpioFunction
	
	@GPIO 17 apaga el led (apaga puerto> directa)
	mov r0,#17
	mov r1,#0
	bl SetGpio
	
	@GPIO 22 apaga el led (apaga puerto> directa)
	mov r0,#22
	mov r1,#0
	bl SetGpio
	
loop:
	

	@Se muestra el mensaje de inicio
	ldr r0,=inicio
	bl puts
	@Se pide el caracter
	@ lee caracter en R0, se graba en car1
	ldr r0,=car
	ldr r1,=car1
	bl scanf

	@trae el caracter en memoria
	ldr r1,=car1
	ldrb r1,[r1,#0]
	
	@Compara si es una letra minuscula
	cmp r1, #123
	cmplt r1, #96
	bgt encenderLet
	
	@Compara si es una letra mayuscula
	cmp r1, #91
	cmplt r1, #64
	bgt encenderLet
	
	@Compara si es una numero
	cmp r1, #58
	cmplt r1, #47
	bgt encenderNum
	
	
	

	

encenderNum:
	
	@GPIO 22 apaga el led (apaga puerto> directa)
	mov r0,#22
	mov r1,#0
	bl SetGpio

	@GPIO 17 enciende el led (enciende puerto> directa)
	mov r0,#17
	mov r1,#1
	bl SetGpio

	b loop
	
encenderLet:
	
	@GPIO 17 apaga el led (apaga puerto> directa)
	mov r0,#17
	mov r1,#0
	bl SetGpio

	@GPIO 22 enciende el led (enciende puerto> directa)
	mov r0,#22
	mov r1,#1
	bl SetGpio

	b loop
	

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
car1:	.asciz " "
inicio:  .asciz "Ingrese un caracter:"
car:	.asciz "%s"



 .end

