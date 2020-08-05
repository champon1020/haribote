SRC = ./src
IMG = ./src/helloos.img
NAS = ./src/ipl.nas

run: $(IMG)
	qemu-system-i386 -drive file=$(IMG),format=raw,if=floppy

asm: $(NAS)
	nasm $(NAS) -o ./src/ipl
	qemu-system-i386 -drive file=./src/ipl,format=raw,if=floppy
