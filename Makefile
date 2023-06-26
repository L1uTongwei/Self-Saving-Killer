Assembler := nasm
Compiler := g++
Objcopy := objcopy
DD := dd
RM := rm
VirtualMachine := qemu-system-i386
AssemblerFlag := -f bin -O0 -Werror -i src
DDFlag := bs=512 conv=notrunc,sync
VMFlag := -hda dist/Self-Saving-Killer.img -serial null -parallel stdio
.PHONY: init clear build run
build: init object/mbr.bin object/bootloader.bin assets/menu.bmp assets/ascii.font
	-rm -f dist/Self-Saving-Killer.img
	$(DD) if=object/mbr.bin of=dist/Self-Saving-Killer.img $(DDFlag) count=1 seek=0
	$(DD) if=object/bootloader.bin of=dist/Self-Saving-Killer.img $(DDFlag) count=1 seek=1
	$(DD) if=assets/menu.bmp of=dist/Self-Saving-Killer.img bs=1 conv=notrunc count=787456 seek=1024 skip=54
	$(DD) if=assets/ascii.font of=dist/Self-Saving-Killer.img $(DDFlag) count=8 seek=1542
run:
	$(VirtualMachine) $(VMFlag)
debug:
	$(VirtualMachine) $(VMFlag) -smp 2 -s -S
object/mbr.bin: src/boot/mbr.asm
	$(Assembler) $(AssemblerFlag) src/boot/mbr.asm -o object/mbr.bin
object/bootloader.bin: src/boot/bootloader.asm
	$(Assembler) $(AssemblerFlag) src/boot/bootloader.asm -o object/bootloader.bin
assets/ascii.font: assets/build/make_ascii.cpp
	$(Compiler) assets/build/make_ascii.cpp -o object/make_ascii.exe
	object/make_ascii.exe
init:
	-mkdir object
	-mkdir dist
clean:
	-rm -rf object
	-rm -rf dist