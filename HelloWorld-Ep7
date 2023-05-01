use16
org 0x7c00

;----------------------------------------
; Set Video Mode                        |
; Setting to mode 3 which text only     |
mov ax, 0x3 ; Set Video Mode to 3       |
int 10h     ; Call the Video SubRoutine |
;----------------------------------------

;------------------------------------------------------------
; Show a String                                             |       
mov ah, 0xE             ; Write a character                 |       
mov si, stringLabel     ; Address of stringLabel into `si`  |
    loopThroughCharacters: ;                                |
        lodsb           ; load letter into `al`             |
        or al, al       ; check if `al` is zero             |
        jz breakOut     ; break                             |
        int 10h         ; Call Video                        |
    jmp loopThroughCharacters  ;                            |
breakOut:               ; Break out of loop                 |
;------------------------------------------------------------

cli         ; Clear Interrupt Flag
hlt         ; Halt The Processor

stringLabel:
db "Hello World Again!", 0

times 510 - ($ - $$) db 0
dw 0xaa55
