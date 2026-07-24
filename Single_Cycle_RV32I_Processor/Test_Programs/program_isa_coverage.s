.section .text
.globl _start
_start:

# ==================== AND/OR/XOR with distinguishing operands ====================
addi x1,x0,12          # x1 = 12
addi x2,x0,10            # x2 = 10
and  x3,x1,x2              # x3 = 8   (distinct from ADD's 22)
or   x4,x1,x2                # x4 = 14  (distinct from ADD's 22)
xor  x5,x1,x2                  # x5 = 6   (distinct from ADD's 22)

# ==================== Byte load/store + large-value LW diagnostic ====================
addi x6,x0,200          # x6 = 200 = 0xC8 -- high bit of the byte is set,
                          # but the full 32-bit value is small. This is the
                          # exact value that exposed the original load-width
                          # bug: a byte-truncated LW would sign-extend this
                          # to 0xFFFFFFC8 instead of giving 200 back.
sw   x6,0(x0)              # mem[0] = 0x000000C8
lb   x8,0(x0)                 # x8 = sign-extended byte  = 0xFFFFFFC8 (bit7 set)
lbu  x9,0(x0)                   # x9 = zero-extended byte = 0x000000C8 = 200
lw   x10,0(x0)                    # x10 = full word = 200 -- proves LW is NOT
                                    # silently behaving like a byte load

# ==================== Halfword load/store ====================
addi x7,x0,-1            # x7 = 0xFFFFFFFF (all bits set)
sw   x7,4(x0)               # mem[4] = 0xFFFFFFFF
lh   x11,4(x0)                 # x11 = sign-extended halfword = 0xFFFFFFFF
lhu  x12,4(x0)                    # x12 = zero-extended halfword = 0x0000FFFF

# ==================== I-type ALU (beyond ADDI) ====================
addi  x14,x0,7           # x14 = 7
andi  x15,x14,3            # x15 = 3
ori   x16,x14,8              # x16 = 15
xori  x17,x14,15               # x17 = 8
slli  x18,x14,2                  # x18 = 28
srli  x19,x14,1                    # x19 = 3
srai  x20,x14,1                      # x20 = 3
slti  x21,x14,10                       # x21 = 1
sltiu x22,x14,3                          # x22 = 0

ecall
