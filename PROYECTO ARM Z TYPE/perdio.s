/* Silvio Orozco 18282 */
/* Jose Castañeda 18162 */
/* Proyecto 3 PERDIO */
/* Subruitina Gano */
/* 26-abril-2019 */
.global perdio


perdio:
	push {lr}
	/*Mensaje de perdio*/
	ldr r0,=per
	mov r1,#0
	bl printf
	/*Regresa al programa principal*/
	pop {lr}
	MOV pc,lr

.data
per:
	.asciz "
888                                
888                                
888                                
888 .d88b. .d8888b  .d88b. 888d888 
888d88  88b88K     d8P  Y8b888P 
888888  888YY8888b.88888888888     
888Y88..88P     X88Y8b.    888     
888  Y88P   88888P  Y8888 888         
Lo siento, esta vez no ganaste.   "