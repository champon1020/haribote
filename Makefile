TOOLS = z_tools
TOLSRC = tolsrc/ok

TEK = $(TOOLS)/fdimg0at.tek
RULE_FILE = $(TOOLS)/haribote/haribote.rul

NASK = $(TOOLS)/nask
EDIMG = $(TOOLS)/edimg
CC1 = $(TOOLS)/gocc1
GAS2NASK = $(TOOLS)/gas2nask
OBJ2BIM = $(TOOLS)/obj2bim
BIM2HRB = $(TOOLS)/bim2hrb
BIN2OBJ = $(TOOLS)/bin2obj
MKFONT = $(TOOLS)/makefont

CFILES = src/*.c
IPL = ./src/ipl.nas
BIN = ./build/ipl.bin
ASM = ./src/asmhead.nas
FUNC = ./src/naskfunc.nas
ASM_BIN = ./build/asmhead.bin
SYS = ./build/haribote.sys

HRB = ./build/bootpack.hrb
IMG = ./src/haribote.img

bin: $(IPL) $(ASM)
	$(NASK) $(IPL) $(BIN) ./build/ipl.lst
	$(NASK) $(ASM) $(ASM_BIN) ./build/asmhead.lst

sys: $(ASM_BIN) $(HRB)
	cat $(ASM_BIN) $(HRB) > $(SYS)

img: $(BIN) $(SYS)
	$(EDIMG) imgin:$(TEK) \
		wbinimg src:$(BIN) len:512 from:0 to:0 \
		copy from:$(SYS) to:@: \
		imgout:$(IMG)

%.gas: ./src/%.c
	$(CC1) -o ./tmp/$*.gas ./src/$*.c

%.nas: ./tmp/%.gas
	$(GAS2NASK) ./tmp/$*.gas ./tmp/$*.nas

%.obj: ./tmp/%.nas
	$(NASK) ./tmp/$*.nas ./tmp/$*.obj

naskfunc.obj: $(FUNC)
	$(NASK) $< ./tmp/$@

bootpack.bim:
	$(OBJ2BIM) @$(RULE_FILE) \
		out:./tmp/$@ \
		stack:3136k \
		map:./tmp/bootpack.map \
		$< ./tmp/*.obj
#$< ./tmp/naskfunc.obj ./tmp/hankaku.obj ./tmp/graphic.obj \
		./tmp/dsctbl.obj ./tmp/int.obj ./tmp/fifo.obj

bootpack.hrb: ./tmp/bootpack.bim
	$(BIM2HRB) $< $(HRB) 0

hankaku.bin: ./src/hankaku.txt
	$(MKFONT) $< ./tmp/$@

hankaku.obj: ./tmp/hankaku.bin
	$(BIN2OBJ) $< ./tmp/$@ _$(basename $@)

ccompile:
	@for file in $(CFILES); do \
		make "$$(basename $${file%.*}).gas"; \
		make "$$(basename $${file%.*}).nas"; \
		make "$$(basename $${file%.*}).obj"; \
	done

makefont:
	@make hankaku.bin
	@make hankaku.obj

hrb:
	@make ccompile
	@make naskfunc.obj
	@make makefont
	@make bootpack.bim
	@make bootpack.hrb

run:
	@make bin
	@make hrb
	@make sys
	@make img
# qemu-system-i386 -m 32 -drive file=$(IMG),format=raw,if=floppy
	qemu-system-i386 -m 32 -vga std -fda $(IMG) -enable-kvm

clean:
	rm ./build/*
	rm ./tmp/*
