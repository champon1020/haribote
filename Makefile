TOOLS = z_tools

TEK = $(TOOLS)/fdimg0at.tek
RULE_FILE = $(TOOLS)/haribote/haribote.rul

NASK = $(TOOLS)/nask
EDIMG = $(TOOLS)/edimg
CC1 = $(TOOLS)/gocc1
GAS2NASK = $(TOOLS)/gas2nask
OBJ2BIM = $(TOOLS)/obj2bim
BIM2HRB = $(TOOLS)/bim2hrb

IPL = ./src/ipl.nas
BIN = ./build/ipl.bin
ASM = ./src/asmhead.nas
FUNC = ./src/naskfunc.nas
ASM_BIN = ./build/asmhead.bin
SYS = ./build/haribote.sys

BOTPAK = ./src/bootpack.c
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

bootpack.gas: $(BOTPAK)
	$(CC1) $< -o ./tmp/$@

bootpack.nas: ./tmp/bootpack.gas
	$(GAS2NASK) $< ./tmp/$@

bootpack.obj: ./tmp/bootpack.nas
	$(NASK) $< ./tmp/$@

naskfunc.obj: $(FUNC)
	$(NASK) $< ./tmp/$@

bootpack.bim: ./tmp/bootpack.obj ./tmp/naskfunc.obj
	$(OBJ2BIM) @$(RULE_FILE) \
		out:./tmp/$@ \
		stack:3136k \
		map:./tmp/bootpack.map \
		$< ./tmp/naskfunc.obj

bootpack.hrb: ./tmp/bootpack.bim
	$(BIM2HRB) $< $(HRB) 0

compile:
	@make bootpack.gas
	@make bootpack.nas
	@make bootpack.obj
	@make naskfunc.obj
	@make bootpack.bim
	@make bootpack.hrb

run:
	@make bin
	@make compile
	@make sys
	@make img
	qemu-system-i386 -drive file=$(IMG),format=raw,if=floppy

clean:
	rm ./build/*
	rm ./tmp/*
