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
mov di, enteredString               ; set up string destination index   |
characterLoop:                      ;                                   |
    ; Get Ascii Key                                                     |
    mov ah, 0x0                     ; Get Key                           |
    int 16h                         ; Run keyboard command              |
                                    ; al now contains ascii character   |
    ifKeyIsEnter:                   ;                                   |
        cmp al, 0x0D                ; 0D is enter, adjusts z flag       |
        jz enterIsPressed           ;                                   |
    elseEnterKey:                   ; else                              |
        stosb                       ; Write character to where di is    |                            ;                                   |
        mov ah, 0xE                 ; Display al character              |
                                    ; al still set                      |
        int 10h                     ; Run display command               |
    endIfKeyIsEnter:                ; end if                            |
jmp getAndWriteLoop                 ; Keep Looping                      |
;--------------- If Branching Section-----------------------------------+
enterIsPressed:                 ;                                       |
    ;Write final null character at end of string                        |
    mov al, 0x0                 ; store null character into `al`        |
    stosb                       ; Write `al` to end of string           |
                                ;                                       |
    call newLine                ; Generate \n essenially                |
    ; Write out "echo " + enteredString                                 |
    mov si, echoString          ; Point string source index to string   |
    mov ah, 0xE                 ; Write al character commnd             |
    displayCharacterLoop:       ;                                       |
        lodsb                   ; Load character into al                |
        or al, al               ; Set z-flag if al is zero              |
        jz breakOutDisplay      ; if zero then break                    |
        int 10h                 ; Display al character                  |
    jmp displayCharacterLoop    ;                                       |
                                ;                                       |
    breakOutDisplay:            ;                                       |
        mov di, enteredString   ; We want to overwrite old string       |
        call newLine            ; Generate \n essenially                |
        call newLine            ; Generate \n essenially                |
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
                        ;                                                   |
echoString: db "echo "  ; No 0 so it will always overflow to the next string|
enteredString: db 0     ;                                                   |
                        ;                                                   |
;----------------------------------------------------------------------------

times 510 - ($-$$) db 0
dw 0xaa55
