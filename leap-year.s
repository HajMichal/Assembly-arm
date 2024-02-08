.global _start 

.macro divide_number divider, nextStep, loop
   	mov r1, \divider                     
	mov r3, r0
	
    \loop:
		cmp     r1, r3         
		bgt     \nextStep    
		sub     r3, r3, r1      
		b       \loop
	
.endm 

_start: 

    ldr r0, =year
    ldr r0, [r0]
    mov r1, #3

    and r2, r0, r1
    cmp r2, #0
    beq divisible_by100
    bal not_divisible


divisible_by100:
	divide_number #100, divide_100_done, loop1

divisible_by400:
	divide_number #400, divide_400_done, loop2

divide_100_done:
	cmp r3, #0
	bne divisible
	bal divisible_by400
divide_400_done:
	cmp r3, #0
	bne not_divisible
	bal divisible

divisible:
	mov r5, #1
	mov r7, #0x4
	b exit

not_divisible:
	mov r5, #0
	mov r7, #4
	b exit

exit:
	mov r7, #1
	swi 0


.data
    year: .word 404

