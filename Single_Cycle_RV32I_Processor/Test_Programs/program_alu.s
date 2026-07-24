.section .text
.globl _start

_start:

# I-Type
addi x1,x0,10
addi x2,x0,20

# R-Type
add  x3,x1,x2
sub  x4,x2,x1
and  x5,x1,x2
or   x6,x1,x2
xor  x7,x1,x2
sll  x8,x1,x2
srl  x9,x2,x1
sra  x10,x2,x1
slt  x11,x1,x2
sltu x12,x1,x2

# Store / Load
sw   x3,100(x0)
lw   x13,128(x0)

# LUI / AUIPC
lui   x14,0x12345
auipc x15,0

ecall
