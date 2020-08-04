QEMU_PATH = ./qemu

IMG = ./helloos.img

run: $(IMG)
	cp $(IMG) $(QEMU_PATH)/fdimage0.bin
	cd $(QEMU_PATH) && ./run.sh
