/*Silvio Orozco 18282*/
/*Jose Castaneda 18161*/
/*Proyecto 4 */
/*Stepper Motor Movimiento*/

/* 17-mayo-2019 */
 .text
 .align 2
 .global main
 
/*El programa tiene como objectivo mover un motor Stepper con una secuencia de doble paso.*/
/*El programa puede ser controlado por programa o por botones en hardware*/
/*Para conectar el circuito se necesita un driver ULN2803APG*/
/*Los puertos 6 ,13, 19 y 26 son nuestras salidas a este driver. Se conectan respectivamente en 1a, 2a, 3a,4a*/
/*Las salidas del otro lado del driver se conectan al motor stepper con el mismo color asignado. El orden es Azul, Rosado, Amarillo y Naranja*/
/*Admeas las salidas de puertos se conectan a leds para mostrar las salidas correctas.*/
/*Ademas hay 3 botones que controlan el motor. El primero para aumentar velocidad. El segundo para cambiar direccion. El tercero para disminuir velocidad.*/
/*Boton 1 conectado al puerto de entrada 21, Boton 2 conectado al puerto de entrada 20, Boton 3 conectado al puerto de entrada 16*/
/*Los leds estan conectados a resistencia por tierra. Los botones estan conectados a resistencia por 5v*/
/*Siga las insctrucciones del menu e ingrese correctamente lo que se le solicita.*/
 

	
/*Main principal del programa*/
main:

	/*Activacion de los puertos de entrada y salida.*/
	@utilizando la biblioteca GPIO (gpio0.s)
	bl GetGpioAddress @solo se llama una vez
	
	
	
	@GPIO para escritura puerto 6
	mov r0,#6
	mov r1,#1
	bl SetGpioFunction
	
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
	
	@GPIO para lectura puerto 21 aumentar velocidad
	mov r0,#21
	mov r1,#0
	bl SetGpioFunction
	
	@GPIO para lectura puerto 20 cambiar direccion
	mov r0,#20
	mov r1,#0
	bl SetGpioFunction
	
	@GPIO para lectura puerto 16 disminuir velocidad
	mov r0,#16
	mov r1,#0
	bl SetGpioFunction
	

	/*Mensaje de bienvenida*/
	ldr r0,=bienvenido
	bl puts
	/*Imagen de stepper*/
	ldr r0,=stepper
	bl puts

/*Main Menu*/	
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
	cmp r1,#1
	beq loop3
	blt errorNumero1
	cmp r1,#3
	beq endprogram
	bgt errorNumero1

	
	/*Variable de control de velocidad*/
	mov r4,#3
	b loop3teclado

/*Menu de Teclado*/
menuteclado:
	
	/*Mostrar menu. */
	ldr r0,=menusoftware
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
	/*Verifica el valor ingresado por el usuario para realizar lo que se le pide lleno a los ciclos correspondientes*/
	cmp r1,#1
	beq cambiardireccionteclado
	blt errorNumero2
	cmp r1,#2
	beq aumentarvelocidadteclado
	cmp r1,#3
	beq disminuirvelocidadteclado
	cmp r1,#4
	beq endprogram
	bgt errorNumero2

/*Cambiar direccion desde el teclado*/	
cambiardireccionteclado:
	cmp r4,#1
	beq loop1tecladoinverse
	cmp r4,#3
	beq loop3tecladoinverse
	cmp r4,#5
	beq loop5tecladoinverse
	cmp r4,#-1
	beq loop1teclado
	cmp r4,#-3
	beq loop3teclado
	cmp r4,#-5
	beq loop5teclado

/*Aumentar velocidad desde el teclado*/	
aumentarvelocidadteclado:
	cmp r4,#1
	beq loop1teclado
	cmp r4,#3
	beq loop1teclado
	cmp r4,#5
	beq loop3teclado
	cmp r4,#-1
	beq loop1tecladoinverse
	cmp r4,#-3
	beq loop1tecladoinverse
	cmp r4,#-5
	beq loop3tecladoinverse

/*Disminuir velocidad desde el teclado*/	
disminuirvelocidadteclado:
	cmp r4,#1
	beq loop3teclado
	cmp r4,#3
	beq loop5teclado
	cmp r4,#5
	beq loop5teclado
	cmp r4,#-1
	beq loop3tecladoinverse
	cmp r4,#-3
	beq loop5tecladoinverse
	cmp r4,#-5
	beq loop5tecladoinverse
	
/*Loop velocidad 3 para teclado*/
loop3teclado:
	mov r5,#0
	mov r4,#3
velocidad3teclado:	
	bl movement1
	bl waitvel3
	bl movement2
	bl waitvel3
	bl movement3
	bl waitvel3 
	bl movement4
	bl waitvel3
	add r5,r5,#1
	cmp r5,#500
	blt velocidad3teclado
	beq menuteclado
	
/*Loop velocidad 5 para teclado*/
loop5teclado:
	mov r5,#0
	mov r4,#5
velocidad5teclado:	
	bl movement1
	bl waitvel5
	bl movement2
	bl waitvel5
	bl movement3
	bl waitvel5 
	bl movement4
	bl waitvel5
	add r5,r5,#1
	cmp r5,#500
	blt velocidad5teclado
	beq menuteclado
	
/*Loop velocidad 1 para teclado*/
loop1teclado:
	mov r5,#0
	mov r4,#1
velocidad1teclado:	
	bl movement1
	bl waitvel1
	bl movement2
	bl waitvel1
	bl movement3
	bl waitvel1 
	bl movement4
	bl waitvel1
	add r5,r5,#1
	cmp r5,#500
	blt velocidad1teclado
	beq menuteclado

/*Loop para leer el boton a velocidad 3 -*/
loop3tecladoinverse:
	mov r5,#0
	mov r4,#-3
velocidad3tecladoinverse:		
	bl movement4
	bl waitvel3
	bl movement3
	bl waitvel3
	bl movement2
	bl waitvel3
	bl movement1
	bl waitvel3	
	add r5,r5,#1
	cmp r5,#500
	blt velocidad3tecladoinverse
	beq menuteclado

/*Loop para leer el boton a velocidad  5-*/
loop5tecladoinverse:
	mov r5,#0
	mov r4,#-5
velocidad5tecladoinverse:		
	bl movement4
	bl waitvel5
	bl movement3
	bl waitvel5
	bl movement2
	bl waitvel5
	bl movement1
	bl waitvel5	
	add r5,r5,#1
	cmp r5,#500
	blt velocidad5tecladoinverse
	beq menuteclado

/*Loop para leer el boton a velocidad  1-*/
loop1tecladoinverse:
	mov r5,#0
	mov r4,#-1
velocidad1tecladoinverse:		
	bl movement4
	bl waitvel1
	bl movement3
	bl waitvel1
	bl movement2
	bl waitvel1
	bl movement1
	bl waitvel1	
	add r5,r5,#1
	cmp r5,#500
	blt velocidad1tecladoinverse
	beq menuteclado
	
/*Loop para leer el boton a velocidad 3*/
loop3:
	
	bl movement1
	bl waitvel3
	bl movement2
	bl waitvel3
	bl movement3
	bl waitvel3 
	bl movement4
	bl waitvel3 	
	
	/*Llama a nuestra subrutina para leer entradas y cambiar de direccion*/
	mov r0,#20
	bl getGPIOInput
	cmp r0,#1
	beq loopinverse3
	
	/*Llama a nuestra subrutina para leer entradas y aumentar velocidad*/
	mov r0,#21
	bl getGPIOInput
	cmp r0,#1
	beq loop1
	
	/*Llama a nuestra subrutina para leer entradas y disminuir velocidad*/
	mov r0,#16
	bl getGPIOInput
	cmp r0,#1
	beq loop5

	b loop3
	
/*Loop para leer el boton a velocidad 5*/
loop5:
	
	bl movement1
	bl waitvel5
	bl movement2
	bl waitvel5
	bl movement3
	bl waitvel5 
	bl movement4
	bl waitvel5 	
	
	/*Llama a nuestra subrutina para leer entradas y cambiar de direccion*/
	mov r0,#20
	bl getGPIOInput
	cmp r0,#1
	beq loopinverse5
	
	/*Llama a nuestra subrutina para leer entradas y aumentar velocidad*/
	mov r0,#21
	bl getGPIOInput
	cmp r0,#1
	beq loop3
	
	/*Llama a nuestra subrutina para leer entradas y disminuir velocidad*/
	mov r0,#16
	bl getGPIOInput
	cmp r0,#1
	beq loop5

	b loop5

/*Loop para leer el boton a velocidad 1*/
loop1:
	
	bl movement1
	bl waitvel1
	bl movement2
	bl waitvel1
	bl movement3
	bl waitvel1 
	bl movement4
	bl waitvel1 	
	
	/*Llama a nuestra subrutina para leer entradas y cambiar de direccion*/
	mov r0,#20
	bl getGPIOInput
	cmp r0,#1
	beq loopinverse1
	
	/*Llama a nuestra subrutina para leer entradas y aumentar velocidad*/
	mov r0,#21
	bl getGPIOInput
	cmp r0,#1
	beq loop1
	
	/*Llama a nuestra subrutina para leer entradas y disminuir velocidad*/
	mov r0,#16
	bl getGPIOInput
	cmp r0,#1
	beq loop3

	b loop1
	
/*Loop para leer el boton a velocidad 3 -*/
loopinverse3:
	
	bl movement4
	bl waitvel3
	bl movement3
	bl waitvel3
	bl movement2
	bl waitvel3
	bl movement1
	bl waitvel3	
	
	/*Llama a nuestra subrutina para leer entradas y cambiar de direccion*/
	mov r0,#20
	bl getGPIOInput
	cmp r0,#1
	beq loop3
	
	/*Llama a nuestra subrutina para leer entradas y aumentar velocidad*/
	mov r0,#21
	bl getGPIOInput
	cmp r0,#1
	beq loopinverse1
	
	/*Llama a nuestra subrutina para leer entradas y disminuir velocidad*/
	mov r0,#16
	bl getGPIOInput
	cmp r0,#1
	beq loopinverse5
	
	b loopinverse3

/*Loop para leer el boton a velocidad 5 -*/
loopinverse5:
	
	bl movement4
	bl waitvel5
	bl movement3
	bl waitvel5
	bl movement2
	bl waitvel5
	bl movement1
	bl waitvel5	
	
	/*Llama a nuestra subrutina para leer entradas y cambiar de direccion*/
	mov r0,#20
	bl getGPIOInput
	cmp r0,#1
	beq loop5
	
	/*Llama a nuestra subrutina para leer entradas y aumentar velocidad*/
	mov r0,#21
	bl getGPIOInput
	cmp r0,#1
	beq loopinverse3
	
	/*Llama a nuestra subrutina para leer entradas y disminuir velocidad*/
	mov r0,#16
	bl getGPIOInput
	cmp r0,#1
	beq loopinverse5
	
	b loopinverse5

/*Loop para leer el boton a velocidad 1 -*/
loopinverse1:
	
	bl movement4
	bl waitvel1
	bl movement3
	bl waitvel1
	bl movement2
	bl waitvel1
	bl movement1
	bl waitvel1	
	
	/*Llama a nuestra subrutina para leer entradas y cambiar de direccion*/
	mov r0,#20
	bl getGPIOInput
	cmp r0,#1
	beq loop1
	
	/*Llama a nuestra subrutina para leer entradas y aumentar velocidad*/
	mov r0,#21
	bl getGPIOInput
	cmp r0,#1
	beq loopinverse1
	
	/*Llama a nuestra subrutina para leer entradas y disminuir velocidad*/
	mov r0,#16
	bl getGPIOInput
	cmp r0,#1
	beq loopinverse3
	
	b loopinverse1

/*Error en opcion no valida*/
error:
	ldr r0,=mensaje_error
	bl puts
	bl getchar @para que borre la informacion del buffer de teclado
	b mainmenu

/*Error en opcion no valida*/
errorNumero1:
	ldr r0,=mensaje_errornumero1
	bl puts
	bl getchar @para que borre la informacion del buffer de teclado
	b mainmenu
	
/*Error en opcion no valida*/
errorNumero2:
	ldr r0,=mensaje_errornumero2
	bl puts
	bl getchar @para que borre la informacion del buffer de teclado
	b menuteclado	


endprogram:
	/*Mensaje de salida*/
	ldr r0,=gracias
	bl puts
	MOV R7, #1		@ Exit Syscall
	SWI 0

@ brief pause routine
waitvel1:
 mov r0, #0x00300000   @ big number
 b sleepLoop

@ brief pause routine
waitvel2:
 mov r0, #0x00600000   @ big number
 b sleepLoop
 
@ brief pause routine
waitvel3:
 mov r0, #0x00900000   @ big number
 b sleepLoop
 
@ brief pause routine
waitvel4:
 mov r0, #0x00c00000   @ big number
 b sleepLoop

@ brief pause routine
waitvel5:
 mov r0, #0x00f00000   @ big number
 b sleepLoop
 
sleepLoop:
 subs r0,#1
 bne sleepLoop @ loop delay
 mov pc,lr
 .data
 .align 2
.global myloc
myloc: .word 0
bienvenido:		.asciz "Bienvenido al programa de movimiento de MOTOR STEPPER. "
stepper:   .asciz "
........................................................... 
...   ...........................I...:......................
.........................8IIIM ....=..,......I.. S..M.......
...........IIIIIIIIIM .?II...IS.............. ....MM........
........II77MIIIIIIIIIIIII ..I7...........88D... .... ......
......I77S77MZIIIIIIIIIIIIIIIM...................  .I.......
 ....IIIMNO8DIIIIIIIIIIIIII?.................7..............
 ...IIMINDN7OIIIIIIIIIIIIII8....=III,.. ....... .   .. .....
...SII7IIZNMIIMIIIIIIIIIIIII ......I?.?.......I.....  . ....
...IIIII8IIIMIIIIIIIIIIIIIIIZ.....?.I,.:,,,,,,7,,,,.... ....
...IIIIIIIIIIIIIIIIIIIIIIIIII.................7........ ....
...IIIIIIIIIIIIIIIIIIIIIIIII7..............,.,.......,......
...IIIIIIIIIIIIIIIIIIIIIIIIINZ................II,...........
..IZIIIIIIIIIIIIIIIIIIIIIIIIZZ..............................
..:ZMIIIIIIIIIIIIIIIIIIIIIIIINZ.............................
 . IIIIIIIIIIIIIIIIIIIIIIIII8ZD................ ............
.NIMMIIIIIIIIIIIIIIIIIIIIIOZDZD. ............ ............ .
.II.ZOIIIMIIIIIIIIIIIIII?ZZN7DDZ............................
.NI8IIIN88DDNNMNMNZZZIIZZND8DD7.Z,..........................
...MM?M888DDNNNNDDMMMZZNSD8D.O.7?.7.........................
........88DDNNNNDDMMDNMDDOD.Z.O7.?.....77.?.,7,., ..7,II,...
............MNNNDMMMDNMDD..S.:7.NZ...I=............... .....
........... ........DNM.....IZ......,I.....,:.:::.=..,.=I?..
.............................=....I.....II..................
....................................I.......Z...S:ZZ...S....
................................:...........................
. ....................... ......... ....?.I=I,I..?.=:I......
......................... .,.,III.. ............. ..........
........................................................... "
menus:		.asciz "Menu Inicial \n Presione 1 para controlar el motor por medio de botones (hardware). \n Presione 2 para controlar el boton por medio del teclado (software). \n Presione 3 para salir.  "
menusoftware:		.asciz "Menu Teclado \n Presione 1 para cambiar de direccion.\n Presione 2 para aumentar velocidad. \n Presione 3 para disminuir velocidad \n Presione 4 para salir"
gracias:			.asciz "Gracias por utilizar el programa. "

mensaje_error: 		.asciz "Error en dato ingresado. Debes ingresar un numero."
mensaje_errornumero1: 		.asciz "Error en dato ingresado. Debes ingresar un numero entre las opciones indicadas 1-3."
mensaje_errornumero2: 		.asciz "Error en dato ingresado. Debes ingresar un numero entre las opciones indicadas 1-4."
entrada:
	.asciz "%d"
temp:				
	.word 0		@temporal de ingreso



 .end

