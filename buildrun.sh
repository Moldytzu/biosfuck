nasm bf.asm -f bin -o boot.flp
qemu-system-i386 -fda ./boot.flp -s -S &
gdb -q -ix "gdb_real.txt" -ex "target remote localhost:1234" -ex "b *0x7c00" -ex "c"