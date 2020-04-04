/*Silvio Orozco 18282*/
/* Laboratorio 10 Programa 1 */
/* 08-abril-2019 */
.text
.align 2
.global main
.type main,%function

error:
	ldr r0,=mensaje_error
	bl puts
	bl getchar @para que borre la informacion del buffer de teclado
	b cicloData
	


main:

	/*Llama a la memoria*/
	stmfd sp!, {lr}	/* SP = R13 link register */
	
	/*Mensaje de bienvenida*/
	ldr r0,=bienvenido
	bl puts
	
	/*R5 sera nuestro contador.*/
	mov r5,#0
	ldr r10,=arregloOriginal
	/*Ciclo para ingresar datos (10 datos)*/
	
cicloData:
	ldr r0,=mensaje_ingreso1
	add r1,r5,#1
	bl printf
	/*scanf de valor*/
	ldr r0,=entrada
	ldr r1,=temp
	bl scanf
	
	@ compara y salta si r0 es 0 (error)
	cmp r0,#0
	beq error
	
	@mete el valor en el arreglo
	ldr r1,=temp
	ldr r1,[r1]
	str r1,[r10],#4
	
	@suma al contador y regresa al ciclo si es menor a 10
	add r5,r5,#1
	cmp r5,#10
	blt cicloData
	
	/*R5 sera nuestro contador.*/
	mov r5,#0
	ldr r10,=arregloOriginal
	ldr r11,=arregloInvertido
	subs r10,r10,#4
	add r11,r11,#40
	ldr r0,=mensajeOriginal
	bl puts
	
cicloOriginal:
	ldr r1,[r10,#4]!
	str r1,[r11,#-4]!
	ldr r0,=numeroSalida
	bl printf
	
	add r5,r5,#1
	cmp r5,#10
	blt cicloOriginal

	/*R5 sera nuestro contador.*/
	mov r5,#0
	ldr r11,=arregloInvertido
	
	ldr r0,=mensajeInverso
	bl puts
	
cicloOInvertido:
	ldr r1,[r11],#4
	ldr r0,=numeroSalida
	bl printf
	add r5,r5,#1
	cmp r5,#10
	blt cicloOInvertido
	b fin	

fin:
	/* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr
	

.data
.align 2
/*Directivas para data*/
numeroSalida:
	.asciz "%d\n"
mensajeOriginal:
	.asciz "\nOriginal"
mensajeInverso:
	.asciz "\nInvertido "
arregloOriginal: 
    .word 0,0,0,0,0,0,0,0,0,0
arregloInvertido: 
    .word 1,0,0,0,0,0,0,0,5,0
entrada:
	.asciz " %d"
temp:				
	.word 0		@temporal de ingreso
mensaje_ingreso1:
	.asciz "Ingrese el numero %d: \n"
bienvenido:
	.asciz "Bienvenido al programa de lectura de arreglos. "
mensaje_error:
	.asciz "Error en dato ingresado. La edad debe ser un numero."

