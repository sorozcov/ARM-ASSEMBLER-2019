/* Silvio Orozco 18282 */
/* Jose Castañeda 18162 */
/* Proyecto 3 Assembler */
/* Subruitina Gano */
/* 26-abril-2019 */
.global gano


gano:
	push {lr}
	/*Mensaje de Gano*/
	ldr r0,=ganaste
	mov r1,#0
	bl printf
	/*Regresa al programa principal*/
	pop {lr}
	MOV pc,lr

.data
ganaste:
	.asciz "
                         .$.     .M                     
               .,     M=    .O$$.   ,$$         .           
               M$..  M$$M  .M$$$M .D$Z$M     .M$N           
               7$$M..$$+$N M$$+N$NM$?+$$   .N$$$,           
              .$OO$$$$?++$$$7+++$$$=+++$MM$7++$$.           
       .$MMM?.M$8+I$$$+++D$$++++N$8++++$$$+++N$$.           
        O$+=$$$$Z+++$M++++M8+++++Z+++++O=?+++$$N            
         M$?++=$D?+++++++++?+++++++++++++++++$$M            
    ......M$=++++++++++++++++++++++++++Z$Z$M+$$$$$MM..      
     .$7$$$$$+++++++++++++++++++?+++$Z+$$$Z++++?M$$$$7.     
     .:$$++++D$$+++++Z$$+$$$7=$$MDNM$$M$$$+++++++$$$M.      
       N+++++++Z$$$                 +D?++++++++$Z       
      .M$$Z+++$$$D$     GANASTE     ?OD??++++8$$.          
    .7$N+++++++Z$$$                 +D?++++++++$Z,         
     ...M$$$?+++$M$N7$D?++??++++++?+++++++M$$$$$$M7.        
         7$+++++++++++++++++++++++++$+++++?$$$$$DMMM        
        M$O?++7?+++++?+++++++8?+++++$$$?+++$$               
        $$=$$$$7+++++$$$+++++$$M++++$$$$$?+$N               
       ,$$M+.N$$7?++$$8$$+++$$$$O++$$Z.$$$N$M               
             .7$$N+$$N.M$$+M$M.$$NM$$.  :$$$M               
              .$$$$$.  . 7$$$. .N$$$M    ..M.               
               M$$$.      N$~    M$M                        
                M$.        .                                "