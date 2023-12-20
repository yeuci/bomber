  processor 6502

  seg code
  org $F000       ; Define the code origin at $F000

Start:
  sei             ; Disable interrupts
  cld             ; Disable the BCD decimal math mode
  ldx #$FF        ; Loads the X register with #$FF
  txs             ; Transfer the X register to the stack pointer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Clear entire RAM space
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  lda #0          ; A = 0
  ldx #$FF        ; X = #$FF

MemLoop:
  sta $0,X        ; Store the value at register A in memory address $0 + X
  dex             ; X--
  bne MemLoop     ; Loop until z-flag is set

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fill the ROM size to exactly 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  org $FFFC
  .word Start     ; Reset vector at $FFFC
  .word Start     ; Interrupt vector (unused in VCS)
