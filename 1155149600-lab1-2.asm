.globl _start

.data
array1: .word -1 22 8 35 5 4 11 2 1 78
.text
_start:

li a0,2 # pivot
li a2,0 # first element = lo
li a3,9 # last element = hi
la s0,array1 # load array1(A)
j partition

partition:
addi,sp,sp,-12
sw ra,0(sp)
sw s10,4(sp)
sw s11,8(sp)

slli s7,a0,2
add s7,s0,s7
lw t0,0(s7)
slli s8,a3,2
add s8,s0,s8
lw t1,-4(s8)
sw t1,0(s7)
sw t0,-4(s8)

slli s8,a3,2
add s8,s0,s8
lw t0,-4(s8)

addi t2,a2,-1 #i = lo-1
mv t6,a2 #t6 = lo
addi t5,a3,-1# t5 = high-1

partition_forloop:
bgt t6,t5,partition_forloop_end #for j = lo; j  hi-1; j   j+1 do
	slli s11,t6,2
	add s11,s0,s11
	lw t1,0(s11) # t1 = *(arr[j])
	
	bgt t1,t0,partition_forloop_inner_skip
		addi t2,t2,1 #i++
		slli s10,t2,2
		add s10,s0,s10
		lw t3,0(s10)# t3 = *(arr[i])
		sw t3,0(s11)
		sw t1,0(s10)
	
	partition_forloop_inner_skip:
	addi t6, t6, 1 # j++
	
j partition_forloop

partition_forloop_end:

slli s10,a0,2
add s10,s0,s10
slli s11,a3,2
add s11,s0,s11
lw t2,0(s10)
lw t3,0(s11)
sw t2,0(s11)
sw t3,0(s10)

lw ra,0(sp)
lw s10,4(sp)
lw s11,8(sp)
addi sp,sp,12

li a7,1
li t1,5
slli t2,t1,2
add t2,s0,t2
lw a0,0(t2)
ecall
