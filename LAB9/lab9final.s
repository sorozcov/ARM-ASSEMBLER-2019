/*Silvio Orozco 18282*/
/* Laboratorio 9 */
/* 01-abril-2019 */
.text
.align 2
.global main
.type main,%function

error:
	ldr r0,=mensaje_error
	bl puts
	b fin


main:

	/*Llama a la memoria*/
	stmfd sp!, {lr}	/* SP = R13 link register */
	
	/*Mensaje de bienvenida*/
	ldr r0,=bienvenido
	bl puts
	
	/*R4 Y R5 seran nuestro valor de asistencia y no asistencia que luego seran cargados a memorio*/
	mov r4,#0
	mov r5,#0
	
	/*R1,R2 Y R3 seran nuestras edades.*/
	/*Pide el ingreso del valor 1*/
	ldr r0,=mensaje_ingreso1
	bl puts
	
	/*scanf de edad1 */
	ldr r0,=entrada
	ldr r1,=edad1
	bl scanf
	
	@ compara y salta si r0 es 0 (error)
	cmp r0,#0
	beq error
	
	/* edad1 */
	ldr r0,=edad1
	ldr r1,[r0]
	
	cmp r1,#14
	addlt r4,r4,#1
	cmp r1,#65
	addgt r4,r4,#1
	
	
	/*Pide el ingreso del valor 2*/
	ldr r0,=mensaje_ingreso2
	bl puts
	
	/*scanf de edad1 */
	ldr r0,=entrada
	ldr r1,=edad2
	bl scanf
	
	@ compara y salta si r0 es 0 (error)
	cmp r0,#0
	beq error
	
	/* edad2 */
	ldr r0,=edad2
	ldr r2,[r0]
	
	cmp r2,#14
	addlt r4,r4,#1
	cmp r2,#65
	addgt r4,r4,#1

	/*Pide el ingreso del valor 3*/
	ldr r0,=mensaje_ingreso3
	bl puts
	
	/*scanf de edad1 */
	ldr r0,=entrada
	ldr r1,=edad3
	bl scanf
	
	@ compara y salta si r0 es 0 (error)
	cmp r0,#0
	beq error
	
	/* edad2 */
	ldr r0,=edad3
	ldr r3,[r0]
	
	cmp r3,#14
	addlt r4,r4,#1
	cmp r3,#65
	addgt r4,r4,#1

	/* subir resultados a memoria  */
	mov r5,#3
	sub r5,r5,r4
	/*asistencia */
	ldr r0,=asistencia
	str r4,[r0]
	/*no asistencia */
	ldr r0,=no_asistencia
	str r5,[r0]
	
	/*Formato para imprimir resultado asistencia */
	ldr r0,=formato_asistencia
	mov r1,r4
	bl printf
	/*Formato para imprimir resultado de no asistencia */
	ldr r0,=formato_no_asistencia
	mov r1,r5
	bl printf
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
formato_asistencia:
	.asciz "El numero de personas que necesitan asistencia es %d\n"
formato_no_asistencia:
	.asciz "El numero de personas que no necesitan asistencia es %d\n"
edad1:
	.word 0
edad2:
	.word 0
edad3:
	.word 0
asistencia:
	.word 0
no_asistencia:
	.word 0
entrada:
	.asciz " %d"
mensaje_ingreso1:
	.asciz "Ingrese edad 1: "
mensaje_ingreso2:
	.asciz "Ingrese edad 2: "
mensaje_ingreso3:
	.asciz "Ingrese edad 3: "
bienvenido:
	.asciz "Bienvenido al programa de asistencia para pasajeros. "
mensaje_error:
	.asciz "Error en dato ingresado. La edad debe ser un numero. Corra el programa de nuevo! "


