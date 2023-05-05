nasm bf.asm -f bin -o boot.flp
qemu-system-i386 -fda ./boot.flp