/*Silvio Orozco 18282*/
/* Laboratorio 10 Programa 1 */
/* 08-abril-2019 */
	.global main
	.func main
error:
	/*Mensaje de error*/
	ldr r0,=mensaje_error
	bl puts
	bl getchar @para que borre la informacion del buffer de teclado
	b ingreso
	


main:
	
	/*Mensaje de bienvenida*/
	ldr r0,=bienvenido
	bl puts
	
	/*Contadores r5 y r6. r6 para mover en vector, r5 para verificar cantidad de datos*/
	mov r5,#0
	mov r6,#0
	
ingreso:
	/*Mensaje de ingreso*/
	ldr r0,=mensaje_ingreso1
	add r1,r5,#1
	bl printf	
	
	/*Lee el valor del numero en el arreglo de flotantes*/
	ldr r0,=fnum	@ingresa numero
	ldr r1,values
	add r1,r1,r6
	bl scanf
	
	@ compara y salta si r0 es 0 (error)
	cmp r0,#0
	beq error
	
	add r6,r6,#4	@pero agrega 4 bytes --> para el siguiente elemento
	add r5,r5,#1
	cmp r5,#10
	blt ingreso
	
	/*Contadores r5 y r6. r6 para mover en vector, r5 para verificar cantidad de datos*/
	mov r5,#0
	mov r6,#0

	/*Mensaje de original*/
	ldr r0,=mensajeOriginal
	bl puts	
	
	/*Arreglo 2 invertido*/
	ldr r11,values2
	add r11, r11,#36
	
	/*Suma es 0 al inicio en d8*/
	mov r1,#0
	vmov s15,r1		@mueve r1 a un registro simple
	vcvt.f64.f32 d8,s15	@convierte el registro simple a doble

mostrarOriginal:
	/*Se cargan los valores para ser mostrados*/
	ldr r1,values
	add r1,r1,r6
	ldr r1,[r1]		@carga el 1er elemento del arreglo valor flotante a r1
	/*Se hace el store en el invertido*/
	str r1,[r11]
	sub r11,r11,#4
	vmov s15,r1		@mueve r1 a un registro simple
	vcvt.f64.f32 d5,s15	@convierte el registro simple a doble
	/*Se realiza la suma para ser imprimida luego*/
	vadd.f64 d8,d8,d5
	vmov r2,r3,d5	@lo mueve a r2 para imprimir
	ldr r0,=string
	bl printf
	add r6,r6,#4	@pero agrega 4 bytes --> para el siguiente elemento
	add r5,r5,#1
	cmp r5,#10
	blt mostrarOriginal
	
	
	/*Mensaje de invertido*/
	ldr r0,=mensajeInverso
	bl puts	
	
	/*Contadores*/
	mov r5,#0
	mov r6,#0

mostrarInvertido:
	/*Se cargan los valores para ser mostrados*/
	ldr r1,values2
	add r1,r1,r6
	ldr r1,[r1]		@carga el 1er elemento del arreglo valor flotante a r1
	vmov s15,r1		@mueve r1 a un registro simple
	vcvt.f64.f32 d5,s15	@convierte el registro simple a doble
	vmov r2,r3,d5	@lo mueve a r2 para imprimir
	ldr r0,=string
	bl printf
	add r6,r6,#4	@pero agrega 4 bytes --> para el siguiente elemento
	add r5,r5,#1
	cmp r5,#10
	blt mostrarInvertido

	/*Imprime resultado de suma*/
	vmov r2,r3,d8	@lo mueve a r2 para imprimir
	ldr r0,=suma
	bl printf
	
	MOV R7, #1		@ Exit Syscall
	SWI 0

addr_value1:  
	.word value1
values:  
	.word arreglo1
values2:  
	.word arreglo2

	.data
mensajeOriginal:	.asciz "\nOriginal"
mensajeInverso:     .asciz "\nInvertido "
mensaje_ingreso1:	.asciz "Ingrese el numero %d: \n"
bienvenido:			.asciz "Bienvenido al programa de lectura de arreglos. "
mensaje_error: 		.asciz "Error en dato ingresado. Debes ingresar un numero."
value1:	.float 1.54321
string:	.asciz "Valor: %f\n"
suma:	.asciz "La suma fue: %f\n"
fnum:	.asciz "%f"
.align 2
arreglo1: 	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
.align 2
arreglo2: 	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0


