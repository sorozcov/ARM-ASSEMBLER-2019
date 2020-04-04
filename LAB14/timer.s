/* Silvio Orozco 18282 */
/* Jose Castaneda 18162 */
/* Laboratorio14 */
/* Subrutina timer */
/* 17-MAYO-2019 */
.global timer

/*Tomada de timer 1 y modificada para devolver 1 segundo en nuestra raspberry*/
/*Subrutinas tomadas de timer*/	
@ ---------------------------
@ Delay function
@ Input: r0 delay counter val
@ ---------------------------
delay:
    mov r7,#0

    b compare
loop:
    add r7,#1     @r7++
compare:
    cmp r7,r0     @test r7 == r0
    bne loop

   mov pc,lr

@ ---------------------------
@ Retro function
@ Input:
@ Output: seconds
@ ---------------------------
.global retro
retro:
    push {lr}
    # get CYCLES_PER_SEC 
    bl  getCPS
    mov r5,r0    

    # store START time
    bl getCycles
    ldr r1,=start
    str r0,[r1]

    # call delay funtcion
    ldr r8,=delayReg
    ldr r0,[r8]	
    bl delay    

    # get END time
    bl getCycles

    # END - START
    ldr r1,=start
    ldr r1,[r1]
    sub r2,r0,r1

    # CYCLES = END-START
    ldr r3,=cycles
    str r2,[r3]

    # convert CYCLES to F32 
    vmov s0,r2
    vcvt.F32.S32 s0,s0 

    # get CYCLES_PER_SEC 
    bl   getCPS
    vmov s1,r0
    vcvt.F32.S32 s1,s1 

    # compute seconds
    vdiv.F32 s2,s0,s1
    
    vmov r0,s2	@seconds

    pop {pc}

.data
 .align 2
start:   .word 0
cycles:  .word 0
delayReg:.word 0x286c329f

