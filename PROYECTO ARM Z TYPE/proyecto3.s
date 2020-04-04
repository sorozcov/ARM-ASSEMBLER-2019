/* Silvio Orozco 18282 */
/* Jose Castañeda 18162 */
/* Proyecto 3 Assembler */
/* ARM Z TYPE */
/* 26-abril-2019 */
.text
.align 2
.global main
.type main,%function
/*Main Principal*/
main:
	/*Inicio. Se graba registro en base de pila.*/
	stmfd	sp!, {lr}

	/*ASCII ART bienvenida*/
	ldr r0,=ztype
	bl puts
	
	/*Mensaje de bienvenida*/
	ldr r0,=bienvenido
	bl puts
	/*Validacion para inicio de juego. Si ha pedido salir, termina el programa.*/
	bl validacion_inicio
	cmp r0,#10
	beq final
	
	/*Mensaje de Inicio*/
	ldr r0,=start
	bl puts
	/*R8 sera nuestro contador de aciertos*/
	mov r8,#0
	/*R7 sera nuestro contador de fallos */
	mov r7,#0
	
	
jugar:
	/*Se verifica si gano o perdio*/
	cmp r7,#3
	bleq perdio
	beq final
	cmp r8,#9
	bleq gano
	beq final
	/*Se juega un turno*/
	b turno

/*Ciclo para 1 turno*/
turno:
	mov r6,#1
	mov r3,#1
	/*Se guarda en R10 la direccion de las palabras completas.*/
	ldr r10, =palabras
	/*Se guarda en R11 la direccion de las respuestas.*/
	ldr r11, =respuestas
	b cicloMostrarPalabras
	
terminaMostrarPalabras:
	/*Mensaje de Ingreso*/
	ldr r0,=ingreso
	bl puts
	/*scanf de entrada*/
	ldr r0,=entrada
	ldr r1,=respuesta
	
	bl scanf
	mov r6,#1
	b cicloEsCorrecto
	

/*Ciclo para mostrar la palabra*/
cicloMostrarPalabras:
	@se guarda en r10 la direccion de las palabras
	ldr r0,[r10],#4
	mov r1,r6
	cmp r0,#0
	blne printf				@@se imprime la palabra
	addne r3,r3,#1
	add r6,r6,#1
	cmp r6,#10
	blt cicloMostrarPalabras
	b terminaMostrarPalabras
	


/*Si esta correcto*/
correcto:
	/*Se guarda en R10 la direccion de las palabras completas.*/
	ldr r10, =palabras
	/*Se guarda en R11 la direccion de las respuestas.*/
	ldr r11, =respuestas
	/*Se guarda en R12 la direccion de las respuestas.*/
	ldr r12, =palabraCompletas
	/*Se borra lo que existe en esas posiciones pues ya se ingreso.*/
	mov r5,#4
	sub r6,r6,#1
	mul r6,r6,r5
	mov r5,#0
	str r5,[r10,r6]
	str r5,[r11,r6]
	ldr r0, =mensaje_correcto
	ldr r1, [r12,r6]
	bl printf
	add r8,r8,#1
	b jugar

/*Si esta incorrecto*/
incorrecto:
	add r7, r7,#1
	ldr r0, =mensaje_incorrecto
	mov r1,r7
	bl printf
	b jugar
	
	
/*Ciclo para ver si es correcto*/
cicloEsCorrecto:
	
	ldr r1,=respuesta
	ldrh r1, [r1,#1]

	ldr r2,[r11],#4
	ldrh r2, [r2,#0]
	
	cmp r1,r2
	
	beq correcto
	add r6,r6,#1
	cmp r6,#10
	blt cicloEsCorrecto
	beq incorrecto
	
	
final:

	/*Mensaje de Final*/
	ldr r0,=gracias
	bl puts
	
	/*Salida Correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr

.data
.align 2
	
entrada:	.asciz " %s"
respuesta:
.asciz 	"                           "
mensaje_correcto:  .asciz "Respuesta Correcta %s!\n"
mensaje_incorrecto:  .asciz "Respuesta Incorrecta! Llevas %d fallos\n"
mensaje_ingresa:  .asciz "Ingresa tu respuesta: "
valortemp: .asciz "                                       "
/*Palabras*/
palabras: .word palabra1, palabra2,palabra3,palabra4,palabra5,palabra6,palabra7,palabra8,palabra9
palabra1:	.asciz "(%d) H_L_ "
palabra2:	.asciz "(%d) JU_G_ "
palabra3:	.asciz "(%d) P_LA_RA "
palabra4:	.asciz "(%d) PAN_AL_A "
palabra5:	.asciz "(%d) IN_C_AR "
palabra6:	.asciz "(%d) DE_TR_IR "
palabra7:	.asciz "(%d) RE_ALC_LAR "
palabra8:	.asciz "(%d) SEG_N_OS "
palabra9:	.asciz "(%d) E_TR_ "
/*Palabras Completas*/
palabraCompletas: .word palabraCompleta1, palabraCompleta2,palabraCompleta3,palabraCompleta4,palabraCompleta5,palabraCompleta6,palabraCompleta7,palabraCompleta8,palabraCompleta9
palabraCompleta1:	.asciz "HOLA"
palabraCompleta2:	.asciz "JUEGO"
palabraCompleta3:	.asciz "PALABRA"
palabraCompleta4:	.asciz "PANTALLA"
palabraCompleta5:	.asciz "INICIAR"
palabraCompleta6:	.asciz "DESTRUIR"
palabraCompleta7:	.asciz "RECALCULAR"
palabraCompleta8:	.asciz "SEGUNDOS"
palabraCompleta9:	.asciz "EXTRA"
/*Respuestas*/
respuestas: .word respuesta1, respuesta2,respuesta3,respuesta4,respuesta5,respuesta6,respuesta7,respuesta8,respuesta9
respuesta1:	.asciz "OA"
respuesta2:	.asciz "EO"
respuesta3:	.asciz "AB"
respuesta4:	.asciz "TL"
respuesta5:	.asciz "II"
respuesta6:	.asciz "SU"
respuesta7:	.asciz "CU"
respuesta8:	.asciz "UD"
respuesta9:	.asciz "XA"
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
.asciz 	"\n.............................Gracias por jugar ARM ZTYPE........................"
listo:
.asciz 	".............................Listo para jugar (SI/NO)..........................."
bienvenido:
.asciz 	"			Bienvenido a ARM ZTYPE. 
	Debes 'destruir' las palabras completandolas. Selecciona el orden	
	seguido de sus caracteres faltantes: (1AE). Tienes que eliminar 
	todas las palabras para ganar. Solo puedes fallar 3 veces.
			Ingresa siempre tus respuestas en mayusculas."
ztype:	
	.asciz "
......... ............. .......... .. .. .......................................
NNNMMMMMMMMMMMMMNMNDMNNNMNMMMMMMMMMMMMMNNMMMMMNNN.......................?..N....
NNNMMMMMMMMMMMMMNMNDMNNNMNMMMMMMMMMMMMMNNMMMMMNNN................?,+....7+$.....
NNMMMMMO,,,,,D,,,,,,N,,MN,,M,,,,,,MM,,,,,MMMMMNNN........DD8D.M.8N...M?$OZO7....
NNNMMMMMMMD,,MMM,.MMN,,NM,,N,,,N,,.M,,MNNNMMMMNNN....8N  ?MM:8MMMMD:.....=..+...
NNNMMMMMMM,,MMMM,.MDN.,,,,DN,,,N,,.M,,MMMMMMMMNNN..D +MMMMMMMMMM8M8,.... .......
NNNMMMMMMD,,MMMM,.MNMN,,,,8N.,,M.,.N,,MMMMMMMMNNN.8.MMMMMMMMMMMMMMN.............
NNNMMMMMM,.NMMMM..MNMN,,.,DD..,N..,M.....MMMMMNNN=MMMMMMMMMMMMMMMMMD............
NNMMMMMMD..MMMMM..MMMND..NNN.....,NN..MMMMMMMMNNN?MMMMMMMMMMMMMMMMMD............
NNNMMMMM..MMMMMM..MNMMM..NND...NND$N..MMMMMMMMNNN NMMMMMMMMMMMMMMMM,............
NNNMMMMD..MMMMMM..NMMMM..NND...$NNNN..NNMMMMMMNNN. MMMMMMMMMMMMMMM=.............
NNNMMMM:.....MMM..MMMMM..MNN...ONN8M.....MMMMMNNN...DMMMMMMMMMMM8 ..............
NNNMMMMMMMMMMMMMMMMNMMMNNDNNNNNDNNN$DNNNMMMMMMNNN..::,:OD8DD88:::::,............
................................................................................"
breakpoint:
	.asciz "breakpoint"
