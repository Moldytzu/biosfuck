bits 16
cpu 8086

org 0x7C00

TAPE_BASE equ 0x7E00

boot:
    jmp 0:main ; far jump to known code segment
main:
    mov ah, 0x0e ; routine to display character

    xor cx, cx ; initialise our program counter 
    mov ds, cx ; initialise the data segment
    mov dx, cx ; initialise the tape counter
    mov si, program ; point to the program

    mov cx, 0xFF
    mov di, dx
    add di, TAPE_BASE
zero:
    mov byte [di], 0
    inc di
    dec cx
    loop zero

    ; main loop
.loop:
    lodsb ; read character from program into al

    cmp al, 0 ; halt if zero
    jz halt

    ; jump to operation handlers
    cmp al, '+'
    je .plus

    cmp al, '.'
    je .dump

    jmp .continue

.plus:
    mov di, dx ; compute tapeCounter + tapeBase to get address of cell
    add di, TAPE_BASE

    ; increment cell
    mov al, [di]
    inc al
    mov [di], al

    jmp .continue

.dump:
    mov di, dx ; compute tapeCounter + tapeBase to get address of cell
    add di, TAPE_BASE

    ; display cell
    mov al, [di]
    int 0x10
    jmp .continue

.continue:
    inc si ; increment program pointer
    inc cx ; increment program counter

    jmp .loop ; jump back

halt:
    jmp $

program: db '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.', 0 ; displays an '$'

times 510-($-$$) db 0 ; fill the rest of the sector with 0
dw 0xAA55