.globl _start

.data
var1: .byte 15
var2: .byte 19
blank: .asciz "\n"
.text
_start:
li a7, 1

la a0,var1
ecall
la a0,var2
ecall #print RAM addresses

lb s1,var1
lb s2,var2

addi s1,s1,1
add a0,zero,s1
ecall#print var1+1

li s0,4
mul s2,s2,s0
add a0,zero,s2
ecall#print var2*4

add s3,zero,s2
add s2,zero,s1
add s1,zero,s3 #swap them

add a0,zero,s1
ecall
add a0,zero,s2
ecall #print swapped var1 and var2