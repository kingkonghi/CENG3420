.globl _start

.data
array1: .word -1 22 8 35 5 4 11 2 1 78
.text
_start:
lw s1,array1

swap: slli t1, a1, 2 # get the offset of v[k] relative to v[0]
add t1, a0, t1 # get the address of v[k]
lw t0, 0(t1) # load the v[k] to t0
lw t2, 4(t1) # load the v[k + 1] to t2
sw t2, 0(t1) # store t2 to the v[k]
sw t0, 4(t1)


exit:
