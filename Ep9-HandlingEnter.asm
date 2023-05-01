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
        ifKeyIsEnter:               ;                                   |
            cmp al, 0x0D            ; 0D is enter, adjusts z flag       |
            jz enterIsPressed       ; jump to enterIsPressed if z flag  |
        elseenterKey:               ; else                              |
            mov ah, 0xE             ; Display al character              |
                                    ; al still set                      |
            int 10h                 ; Run display command               |
        endIfKeyIsEnter:            ; end if
    jmp characterLoop               ; Keep Looping                      |
; Loop Never Ends                                                       |
;--------------- If Branches -------------------------------------------+
enterIsPressed:             ;                                       |
    call newLine                ; Generate \n essenially                |
    call newLine                ; Generate \n essenially                |
jmp endIfKeyIsEnter             ;                                       |
;------------------------------------------------------------------------

;------------------------------------------------------------------------
; Halt the Processor                                                    |
halt:      ;                                                            |
    cli    ; Don't allow any more inturrptions                          |
    hlt    ; Halt the CPU                                               |
;------------------------------------------------------------------------ 

;------------------------------------------------------------------------
; New Line                                                              |
; Basically \n support                                                  |
newLine:                    ;                                           |
    mov ah, 0x02            ; Set cursor position function              |
    mov dl, 0x00            ; Set column to 0                           |
    mov dh, [currentRow]    ; Set row on currentRow                     |
    int 10h                 ; Run Graphics Command                      |
    ; currentRow++                                                      |
    inc dh                  ; increase dh by one                        |
    mov [currentRow], dh    ; set currentRow to dh                      |
ret                         ;                                           |
;------------------------------------------------------------------------


;----------------------------------------------------------------------------
;                               Variables                                   |
;---------------------------------------------------------------------------+
currentRow: db 1        ;                                                   |
;----------------------------------------------------------------------------

times 510 - ($-$$) db 0
dw 0xaa55
