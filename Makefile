Compiler := gcc
Linker := ld
Assembler := nasm
DD := dd
RM := rm
VirtualMachine := qemu-system-i386
CFlag := -x c -funsigned-char -nostdinc -O0 -Wall -Werror -Wextra -Wfatal-errors -fno-builtin -m32 \
	-Wstrict-prototypes -Wmissing-prototypes -Wnested-extern -Wconversion
AssemblerFlag := -f bin -O0 -Werror -i src
LinkerFlag := -flinker-output=exec -nostartfiles -nodefaultlibs -nolibc -nostdlib -m32 \
	-Map symbols.map -fatal-warnings -no-undefined
DDFlag := bs=512 conv=notrunc
VMFlag := -hda dist/Self-Saving-Killer.img -serial null -parallel stdio
.PHONY: init clear build run
build: init mbr bootloader
	$(DD) if=dist/mbr.bin of=dist/Self-Saving-Killer.img $(DDFlag) count=1 seek=0
	$(DD) if=dist/bootloader.bin of=dist/Self-Saving-Killer.img $(DDFlag) count=5 seek=1
run:
	$(VirtualMachine) $(VMFlag)
mbr: src/mbr.asm
	$(Assembler) $(AssemblerFlag) src/mbr.asm -o dist/mbr.bin
bootloader: src/bootloader.asm
	$(Assembler) $(AssemblerFlag) src/bootloader.asm -o dist/bootloader.bin
init:
	-mkdir object
	-mkdir dist
clean:
	-rm -rf object
	-rm -rf dist