TOLSRC = ./tolsrc
TOLSRC_OK = $(TOLSRC)/ok
EDIMG = $(TOLSRC_OK)/edimg

IPL_NAS = ./src/ipl.nas
IPL_BIN = ./build/ipl.bin
HARIBOTE_NAS = ./src/haribote.nas
HARIBOTE_SYS = ./build/haribote.sys
HARIBOTE_IMG = ./src/haribote.img

run.helloos: ./src/helloos.img
	qemu-system-i386 -drive file=./src/helloos.img,format=raw,if=floppy

ipl.bin: $(IPL_NAS)
	nasm $(IPL_NAS) -o $(IPL_BIN) -l ./build/ipl.lst

haribote.sys: $(HARIBOTE_NAS)
	nasm $(HARIBOTE_NAS) -o $(HARIBOTE_SYS) -l ./build/haribote.lst

haribote.img: $(IPL_BIN) $(HARIBOTE_SYS)
	$(EDIMG) imgin:$(TOLSRC)/edimg0j/fdimg0at.tek \
		wbinimg src:$(IPL_BIN) len:512 from:0 to:0 \
		copy from:$(HARIBOTE_SYS) to:@: \
		imgout:$(HARIBOTE_IMG)

run:
	@make ipl.bin
	@make haribote.sys
	@make haribote.img
	qemu-system-i386 -drive file=$(HARIBOTE_IMG),format=raw,if=floppy

clean:
	rm $(IPL_BIN)
	rm ./build/ipl.lst
	rm $(HARIBOTE_SYS)
	rm ./build/haribote.lst
