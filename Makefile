Assembler := nasm
Compiler := g++
Objcopy := objcopy
DD := dd
RM := rm
VirtualMachine := qemu-system-i386
AssemblerFlag := -f bin -O0 -i src
DDFlag := bs=512 conv=notrunc,sync
VMFlag := -hda dist/Self-Saving-Killer.img -serial null -parallel stdio
.PHONY: init clear build run
build: init
	-rm -f dist/Self-Saving-Killer.img
	$(Assembler) $(AssemblerFlag) src/boot/mbr.asm -o object/mbr.bin
	$(DD) if=object/mbr.bin of=dist/Self-Saving-Killer.img $(DDFlag) count=1 seek=0
	$(Assembler) $(AssemblerFlag) src/boot/bootloader.asm -o object/bootloader.bin
	$(Assembler) $(AssemblerFlag) src/main.asm -o object/main.bin
	$(DD) if=object/bootloader.bin of=dist/Self-Saving-Killer.img $(DDFlag) count=1 seek=1
	$(DD) if=object/main.bin of=dist/Self-Saving-Killer.img $(DDFlag) count=1 seek=2
	$(DD) if=assets/ascii.font of=dist/Self-Saving-Killer.img $(DDFlag) count=8 seek=3
	$(DD) if=assets/menu.bmp of=dist/Self-Saving-Killer.img bs=1 conv=notrunc count=787456 seek=10752 skip=54
run:
	$(VirtualMachine) $(VMFlag)
init:
	-mkdir object
	-mkdir dist
clean:
	-rm -rf object
	-rm -rf dist