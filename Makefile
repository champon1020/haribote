SRC = ./src
IMG = ./src/helloos.img
NAS = ./src/ipl.nas

run: $(IMG)
	qemu-system-i386 -drive file=$(IMG),format=raw,if=floppy

asm: $(NAS)
	nasm $(NAS) -o ./src/ipl -l ./src/ipl.lst
	qemu-system-i386 -drive file=./src/ipl,format=raw,if=floppy

clean: ./src/ipl ./src/ipl.lst
	rm ./src/ipl ./src/ipl.lst
