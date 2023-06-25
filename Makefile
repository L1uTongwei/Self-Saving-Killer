Assembler := nasm
Objcopy := objcopy
DD := dd
RM := rm
VirtualMachine := qemu-system-i386
AssemblerFlag := -f bin -O0 -Werror -i src
DDFlag := bs=512 conv=notrunc,sync
VMFlag := -hda dist/Self-Saving-Killer.img -serial null -parallel stdio
.PHONY: init clear build run
build: init mbr bootloader
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
init:
	-mkdir object
	-mkdir dist
	-rm -f dist/Self-Saving-Killer.img
clean:
	-rm -rf object
	-rm -rf dist