use16
org 0x7c00

;----------------------------------------
; Set Video Mode                        |
; Setting to mode 3 which text only     |
mov ax, 0x3 ; Set Video Mode to 3       |
int 10h     ; Call the Video SubRoutine |
;----------------------------------------

times 510 - ($ - $$) db 0
dw 0xaa55
