Compiler := gcc
Assembler := nasm
Objcopy := objcopy
DD := dd
RM := rm
VirtualMachine := qemu-system-i386
CFlag := -funsigned-char -nostdinc -O0 -Wall -Werror -Wextra -Wfatal-errors -fno-builtin -m32 \
	-Wconversion -nostartfiles -nodefaultlibs -nolibc -nostdlib -Wl,-fatal-warnings,-no-undefined \
	-Wl,--section-start=.text=0x0 -masm=intel -I src/tools
AssemblerFlag := -f bin -O0 -Werror -i src
DDFlag := bs=512 conv=notrunc,sync
VMFlag := -hda dist/Self-Saving-Killer.img -serial null -parallel stdio
ObjcopyFlag := -j .text -S --strip-all --strip-debug
.PHONY: init clear build run
build: init mbr bootloader readPixel writePixel setColor loadDisk squareWave stopWave main
run:
	$(VirtualMachine) $(VMFlag)
debug:
	$(VirtualMachine) $(VMFlag) -smp 2 -s -S
mbr: src/boot/mbr.asm
	$(Assembler) $(AssemblerFlag) src/boot/mbr.asm -o object/mbr.bin
	$(DD) if=object/mbr.bin of=dist/Self-Saving-Killer.img $(DDFlag) count=1 seek=0
bootloader: src/boot/bootloader.asm
	$(Assembler) $(AssemblerFlag) src/boot/bootloader.asm -o object/bootloader.bin
	$(DD) if=object/bootloader.bin of=dist/Self-Saving-Killer.img $(DDFlag) count=1 seek=1
readPixel: src/tools/readPixel.c
	$(Compiler) $(CFlag) -c src/tools/readPixel.c -o object/readPixel.o
	$(Objcopy) $(ObjcopyFlag) -O binary object/readPixel.o object/readPixel.bin
	$(DD) if=object/readPixel.bin of=dist/Self-Saving-Killer.img $(DDFlag) count=1 seek=2
writePixel: src/tools/writePixel.c
	$(Compiler) $(CFlag) -c src/tools/writePixel.c -o object/writePixel.o
	$(Objcopy) $(ObjcopyFlag) -O binary object/writePixel.o object/writePixel.bin
	$(DD) if=object/writePixel.bin of=dist/Self-Saving-Killer.img $(DDFlag) count=1 seek=3
setColor: src/tools/setColor.c
	$(Compiler) $(CFlag) -c src/tools/setColor.c -o object/setColor.o
	$(Objcopy) $(ObjcopyFlag) -O binary object/setColor.o object/setColor.bin
	$(DD) if=object/setColor.bin of=dist/Self-Saving-Killer.img $(DDFlag) count=1 seek=4
loadDisk: src/tools/loadDisk.c
	$(Compiler) $(CFlag) -c src/tools/loadDisk.c -o object/loadDisk.o
	$(Objcopy) $(ObjcopyFlag) -O binary object/loadDisk.o object/loadDisk.bin
	$(DD) if=object/loadDisk.bin of=dist/Self-Saving-Killer.img $(DDFlag) count=1 seek=5
squareWave: src/tools/squareWave.c
	$(Compiler) $(CFlag) -c src/tools/squareWave.c -o object/squareWave.o
	$(Objcopy) $(ObjcopyFlag) -O binary object/squareWave.o object/squareWave.bin
	$(DD) if=object/squareWave.bin of=dist/Self-Saving-Killer.img $(DDFlag) count=1 seek=6
stopWave: src/tools/stopWave.c
	$(Compiler) $(CFlag) -c src/tools/stopWave.c -o object/stopWave.o
	$(Objcopy) $(ObjcopyFlag) -O binary object/stopWave.o object/stopWave.bin
	$(DD) if=object/stopWave.bin of=dist/Self-Saving-Killer.img $(DDFlag) count=1 seek=6
main: src/tools/tools.h src/main.c
	$(Compiler) $(CFlag) -c src/main.c -o object/main.o
	$(Objcopy) $(ObjcopyFlag) -O binary object/main.o object/main.bin
	$(DD) if=object/main.bin of=dist/Self-Saving-Killer.img $(DDFlag) count=1 seek=7
init:
	-mkdir object
	-mkdir dist
	-rm -f dist/Self-Saving-Killer.img
clean:
	-rm -rf object
	-rm -rf dist