.data
prompt: .string "give me a number for analysis:"
big_msg: .string "wow-that's a big number!"
small_msg:.string "aww, what a cute number"
.globl __start
.text
__start:
la a1, prompt
li a0, 4 # print_string
ecall
li a0, 5 # read_int
ecall
li t0, 6 # threshold for comparison
blt a0, t0, smaller # jump if small input
# fall through to here if not smaller
li a0, 4
la a1, big_msg
ecall # print msg call
j done
smaller:
li a0, 4 # print msg call
la a1, small_msg
ecall
done:
li a0, 17 # exit call
li a1, 0 # exit code (0 == ok)
ecall