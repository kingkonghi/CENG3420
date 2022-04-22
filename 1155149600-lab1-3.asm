.globl _start

.data
array1: .word 10 9 8 7 6 5 4 3 2 1
blank: .asciz " "

.text
_start: 
li a7,1
li a2,0 # first element = lo
li a3,9 # last element = hi
la s0,array1 # load array1(A)

jal quicksort

quicksort:
bge a2,a3,L1 # if (lo >= hi)
addi sp, sp, -32
sw ra, 0(sp)
sw s10, 8(sp) # s10 is going to hold lo
sw s11, 16(sp) # s11 is going to hold hi
sw s9, 24(sp) # s9 is going to hold the pivot

# hold lo and hi
mv s10, a2 # s10 <- lo
mv s11, a3 # s11 <- hi
# call partition
jal ra, partition
# save the pivot on s9
mv s9, a4
# s9 = pivot
# s10 = lo
# s11 = hi
# recursively call quicksort on both subarrays
addi a3, s9, -1 # hi = pivot (-1)
mv a2, s10 # lo = lo
jal ra, quicksort # quicksort(array, lo, pivot-1)

addi a2, s9, 1 # lo = pivot (+1)
mv a3, s11 # hi = hi
jal ra, quicksort # quicksort(array, pivot+1, hi)
# load stuff back from the stack

lw ra, 0(sp)
lw s10, 8(sp)
lw s11, 16(sp)
lw s9, 24(sp)
addi sp, sp, 32
jal exit

L1:
ret

partition:
addi,sp,sp,-12
sw ra,0(sp)
sw s10,4(sp)
sw s11,8(sp)

slli s8,a3,2
add s8,s0,s8
lw t0,0(s8) #load the A[hi] be pivot to t0

addi t2,a2,-1 #i = lo-1
mv t6,a2      #t6 = lo
addi t5,a3,-1 # t5 = hi-1

partition_forloop:
bgt t6,t5,partition_forloop_end #for j = lo; j  hi-1; j   j+1 do
	slli s11,t6,2 # get the offset of A[j] relative to A[0]
	add s11,s0,s11
	lw t1, 0(s11) # t1 = A[j]

	bgt t1,t0,partition_forloop_inner_skip #if A[j]> pivot
	addi t2, t2, 1 # i++
	slli s10,t2,2
	add s10,s0,s10 # s10 = A[i]
	lw t3, 0(s10) 
	sw t3, 0(s11) # A[j] = t3
	sw t1, 0(s10) # A[i] = t1

	partition_forloop_inner_skip:
	addi t6, t6, 1 # j++
	
jal partition_forloop

partition_forloop_end:
addi a4,t2,1 #i=i+1

slli s10,a4,2
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

partition_bail:
ret

exit:
li t0,0
li a7,1
li t1,10
jal print

print: # print the array out
beq t0,t1,done # if all elements have been printed
slli t2,t0,2 
add t2,s0,t2
lw a0,0(t2) # a0 = A[i]
ecall
addi t0,t0,1 #i= i + 1
li a7,4
la a0,blank #print a blank
ecall
li a7,1
jal print

done:
