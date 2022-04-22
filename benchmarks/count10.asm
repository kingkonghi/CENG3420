# This program counts from 10 to 0, the result is in t2
# t2 = 55 / 0x00000037
.data 
ten: .word 10
.text
_start:
    lui t0,0x0
    addi t0,t0,10
    lw t1, 0(t0)
    add t2, zero, zero
loop: add t2, t2, t1
    addi t1, t1, -1
    bne t1, zero, loop
