bits 16
cpu 8086

boot:
    jmp $

times 510-($-$$) db 0 ; fill the rest of the sector with 0
dw 0xaa55