/* Silvio Orozco 18282 */
/* Jose Castañeda 18162 */
/* Subrutina para validar inicio. */
/* 22-abril-2019 */
.global validacion_inicio

validacion_inicio:
	push {lr}
validacion:
	/*Espera el mensaje de SI para inicar el juego*/
	ldr r0,=listo
	bl puts
	/*scanf de entrada_inicio*/
	ldr r0,=entrada
	ldr r1,=entrada_inicio
	bl scanf
	ldr r1,=entrada_inicio
	ldrh r1, [r1,#0]
	/*cargar palaba si en R2*/
	ldr r2,=SI
	ldrh r2, [r2,#0]
	/*Si la entrada es SI, sale de la subrutina y regresa al programa principal. */
	cmp r1,r2
	beq end
	/*cargar palaba NO en R2*/
	ldr r2,=NO
	ldrh r2,[r2, #0]
	/*Si la entrada es no. Sale del programa.*/
	cmp r1,r2
	moveq r0,#10
	beq end
	/*Si la entrada no es valida. Repite el ciclo.*/
	bne mostrar_error 

mostrar_error:
	ldr r0,=mensaje_error
	bl puts
	b validacion

end:
	pop {lr}
	mov pc, lr


.data
.align 2
	
entrada:	.asciz " %s"
mensaje_correcto:  .asciz "Respuesta Correcta!"
mensaje_incorrecto:  .asciz "Respuesta Incorrecta!"

valortemp: .asciz ""

mensaje_error:
.asciz 	"Error en el dato ingresado."
ingreso:
.asciz 	"\nIngrese el numero de la palabra seguido de las letras faltantes en mayuscula: "
entrada_inicio:
.asciz 	"                           "
SI:
.asciz 	"SI"
NO:
.asciz 	"NO"
start:
.asciz 	".....................................INICIO....................................."
gracias:
.asciz 	".............................Gracias por jugar ARM ZTYPE........................"
listo:
.asciz 	".............................Listo para jugar (SI/NO)..........................."