use16
org 0x7c00

;------------------------------------------------------------------------
; Set up the Screen                                                     |
mov ax, 0x03        ; ah = 0x0 al = 0x3                                 |
int 10h             ; Run Graphics Command                              |
;------------------------------------------------------------------------

;------------------------------------------------------------------------
; Get And Write Characters                                              |
; Gets character from keyboard and displays it                          |
characterLoop:                      ;                                   |
        mov ah, 0x0                 ; Get Key                           |
        int 16h                     ; Run keyboard command              |
                                    ; al now contains ascii character   |
        mov ah, 0xE                 ; Display al character              |
                                    ; al still set                      |
        int 10h                     ; Run display command               |
    jmp characterLoop               ; Keep Looping                      |
; Loop Never Ends                                                       |
;------------------------------------------------------------------------

;------------------------------------------------------------------------
; Halt the Processor                                                    |
halt:      ;                                                            |
    cli    ; Don't allow any more inturrptions                          |
    hlt    ; Halt the CPU                                               |
;------------------------------------------------------------------------

times 510 - ($-$$) db 0
dw 0xaa55
