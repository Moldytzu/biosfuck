bits 16
cpu 8086

org 0x7C00

boot:
    jmp 0:main ; far jump to known code segment
main:
    mov ah, 0x0e ; routine to display character
    mov al, '?'
    int 0x10 ; call the bios

    jmp $

times 510-($-$$) db 0 ; fill the rest of the sector with 0
dw 0xAA55