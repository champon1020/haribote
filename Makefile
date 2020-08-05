QEMU_PATH = ./qemu

IMG = ./src/01/helloos.img

run: $(IMG)
	cp $(IMG) $(QEMU_PATH)/fdimage0.bin
	cd $(QEMU_PATH) && ./run.sh
