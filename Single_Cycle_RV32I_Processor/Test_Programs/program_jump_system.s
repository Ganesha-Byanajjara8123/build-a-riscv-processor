.section .text
.globl _start
_start:
################################################
# JAL
################################################
jal x1,JUMP1              # x1 = return address (PC+4 of this instruction)
addi x2,x0,111              # never fetched -- PC redirects straight to JUMP1
JUMP1:
addi x3,x0,123                # target marker

################################################
# JALR (call/return pattern -- avoids depending on
# AUIPC/la correctness to test JALR)
################################################
jal  x4,SUBROUTINE          # x4 = return address
addi x5,x0,55                 # return marker: never fetched going out, executes on return
JALR_DONE:
ecall
HALT:
beq  x0,x0,HALT                # true program end

SUBROUTINE:
addi x6,x0,1                     # confirms subroutine was reached
jalr x0,x4,0                       # return to caller, discard link
addi x7,x0,111                       # true dead code -- nothing ever jumps back here
