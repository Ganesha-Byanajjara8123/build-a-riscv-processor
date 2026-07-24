
.section .text
.globl _start
_start:
################################################
# BEQ (Taken)
################################################
addi x1,x0,10
addi x2,x0,10
beq x1,x2,BEQ_PASS
addi x3,x0,111          # guard - must be skipped if BEQ works
BEQ_PASS:
addi x4,x0,123           # target marker - separate register from guard

################################################
# BNE (Taken)
################################################
addi x5,x0,10
addi x6,x0,20
bne x5,x6,BNE_PASS
addi x7,x0,111
BNE_PASS:
addi x8,x0,123

################################################
# BLT (Taken)
################################################
addi x9,x0,5
addi x10,x0,10
blt x9,x10,BLT_PASS

addi x11,x0,111
BLT_PASS:
addi x12,x0,123

################################################
# BGE (Taken)
################################################
addi x13,x0,20
addi x14,x0,10
bge x13,x14,BGE_PASS
addi x15,x0,111
BGE_PASS:
addi x16,x0,123

################################################
# BLTU (Taken)
################################################
addi x17,x0,10
addi x18,x0,20
bltu x17,x18,BLTU_PASS
addi x19,x0,111
BLTU_PASS:
addi x20,x0,123

################################################
# BGEU (Taken)
################################################
addi x21,x0,20
addi x22,x0,10
bgeu x21,x22,BGEU_PASS
addi x23,x0,111
BGEU_PASS:
addi x24,x0,123

ecall
