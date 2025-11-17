.macro DEBUG_PRINT reg
csrw 0x800, \reg
.endm
	
.text
.global div              # Export the symbol 'div' so we can call it from other files
.type div, @function
div:
    addi sp, sp, -32     # Allocate stack space

    # store any callee-saved register you might overwrite
    sw   ra, 28(sp)      # Function calls would overwrite
    sw   s0, 24(sp)      # If t0-t6 is not enough, can use s0-s11 if I save and restore them
    # ...

    # do your work

    beq x0, a1, zerofinish

    li a5, 0 # Q
    li a6, 0 # R

    li a3, 1 # Current power of 2
    li a2, 0 # Number of bits in N

    log:
        bltu a0, a3, algsetup
        slli a3, a3, 1
        addi a2, a2, 1
        j log

    algsetup:
        addi a2, a2, -1
        j alg

    alg:
        blt a2, x0, finish

        slli a6, a6, 1

        srl t1, a0, a2
        andi t1, t1, 1
        add a6, a6, t1

        bgeu a6, a1, cond

        addi a2, a2, -1

        j alg
        
    cond:
        sub a6, a6, a1

        li t3, 1
        sll t3, t3, a2
        or a5, a5, t3

        addi a2, a2, -1

        j alg

    finish:
        mv a0, a5
        mv a1, a6
        j cleanup

    zerofinish: 
        li a0, 0
        j cleanup

    cleanup:
        # load every register you stored above
        lw   ra, 28(sp)
        lw   s0, 24(sp)
        # ...
        addi sp, sp, 32      # Free up stack space
        ret

