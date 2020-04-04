/*Silvio Orozco 18282*/
/* Laboratorio 10Z Programa 2 */
/* 08-abril-2019 */
.text
.align 2
.global main
.type main,%function

	

main:

	/*Llama a la memoria*/
	stmfd sp!, {lr}	/* SP = R13 link register */
	
	/*Mensaje de bienvenida*/
	ldr r0,=bienvenido
	bl puts
	ldr r0,=mensaje_ingreso1
	bl puts
	
	/*scanf de cadena*/
	ldr r0,=entrada
	ldr r1,=cadena
	bl scanf

	
	/*R5 sera nuestro contador y R10 nuestra direccion para cadena.*/
	mov r5,#0
	ldr r10,=cadena
	ldr r11,=cadenaConvertida
/*Convierte char por char de mayuscula a minuscula o de minuscula a mayuscula.*/
convertir:
	ldrb r1, [r10],#1
	orr r2,r1,#0b11011111
	/*Compara si es mayuscula o si es minuscula*/
	cmp r2,#0b11111111
	/*Si es minuscula la convierte a myuscula*/
	beq minusculaaMayuscula
	/*Si es mayuscula lo convierte a minuscula*/
	bne mayusculaaMinuscula
	

/*Convierte char por char de mayuscula a minuscula .*/
mayusculaaMinuscula:
	/*Or para cambiar el bit 3 a 1*/
	orr r1,r1,#0b00100000
	strb r1,[r11],#1
	add r5,r5,#1
	cmp r5,#10	
	blt convertir
	beq fin

/*Convierte char por char de minuscula a mayuscula.*/ 
minusculaaMayuscula:
	/*And para cambiar el bit 3 a 0*/
	and r1,r1,#0b11011111
	strb r1,[r11],#1
	add r5,r5,#1
	cmp r5,#10	
	blt convertir
	beq fin


	
	

fin:
	
	/* printf de cadena*/
	ldr r0,=formato
	ldr r1,=cadenaConvertida
	bl printf
	
	/* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr
	

.data
.align 2
/*Directivas para data*/
entrada:
	.asciz "%s"
formato:
	.asciz "El nombre en mayusculas es %s\n"
mensaje_ingreso1:
	.asciz "Ingrese su nombre (max 10 caracteres en minuscula sin espacios): "
bienvenido:
	.asciz "Bienvenido al programa 2 del laboratorio 10. "
cadena: 
	.asciz "          "
cadenaConvertida: 
	.asciz "          "
