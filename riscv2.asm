.globl _start

.data
array1: .word -1 22 8 35 5 4 11 2 1 78
.text
_start:
la s0,array1
li,a7,1 # print int
li a1,2 # first element = lo
li a2,10 # last element = hi
li a3,1 # 3rd element = pivot
j quicksort

quicksort:
bltu a3, a2, quicksort_exit # if (lo >= hi) we just return

# save stuff in the stack
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
mv s9, a0
# s9 = pivot
# s10 = lo
# s11 = hi
# recursively call quicksort on both subarrays

addi a3, s9, -1 # hi = pivot (-1)
mv a2, s10 # lo = lo
jal ra, quicksort # quicksort(a1, lo, pivot-1)

addi a2, s9, 1 # lo = pivot (+1)
mv a3, s11 # hi = hi
jal ra, quicksort # quicksort(a1, pivot+1, hi)

# load stuff back from the stack
lw ra, 0(sp)
lw s10, 8(sp)
lw s11, 16(sp)
lw s9, 24(sp)
addi sp, sp, 32

quicksort_exit:
ret

partition:
# save stuff in the stack
addi sp, sp, -24
sw ra, 0(sp)
sw s10, 8(sp)
sw s11, 16(sp)
# init pivot to high (a3)
add t0, a1, a3
lbu t0, 0(t0)
addi t2, a2, -1 # (i) index of the smaller element => t2 = low - 1
mv t6, a2 # t6 = j = low
addi t5, a3, -1 # t5 = high-1

partition_forloop:
bgt t6, t5, partition_forloop_end # if t6 > t5 then partition_forloop_end
add s11, a1, t6 # s11 = *arr[j]
lbu t1, 0(s11) # t1 = *(arr[j])
bgtu t1, t0, partition_forloop_inner_skip # if t1>t0 skip (if arr[j]>pivot)
addi t2, t2, 1 # i++
add s10, a1, t2 # s10 = *arr[t2] = *arr[i]
lbu t3, 0(s10) # t3 = *(arr[i])
sb t3, 0(s11) # arr[j] = t3
sb t1, 0(s10) # arr[i] = t1

partition_forloop_inner_skip:
addi t6, t6, 1 # j++
j partition_forloop

partition_forloop_end:
addi a0, t2, 1 # write return value as i+1
# swap(&arr[i+1], &arr[high])
add s10, a1, a0 # s10 = *arr[i+1]
add s11, a1, a3 # s11 = *arr[high]
lbu t2, 0(s10) # t2 = *s10
lbu t3, 0(s11) # t3 = *s11
sb t2, 0(s11)
sb t3, 0(s10)
# load stuff back from the stack
lw ra, 0(sp)
lw s10, 8(sp)
lw s11, 16(sp)
addi sp, sp, 24

partition_bail:
ret