Compiler := gcc
CompilerFlag := -fno-builtin -Og -g -m32 -nostdlib -nostartfiles -nodefaultlibs
Linker := ld
LinkerFlag := -s -Ttext 0x100000 -e start -m i386pe
ISOFlag := -b boot/grub/stage2_eltorito.img -l -J -allow-leading-dots --no-emul-boot --boot-load-size 4 -r \
	-copyright LICENSE -p L1uTongwei -abstract abstract.doc -V "SSK Boot CD" -input-charset iso8859-1 -gui -boot-info-table
.PHONY: init clean build run
build: init
	$(Compiler) $(CompilerFlag) -masm=intel -c src/main.c -o object/main.o
	$(Compiler) $(CompilerFlag) -c src/bootloader.S -o object/bootloader.o
	$(Linker) $(LinkerFlag) object/main.o object/bootloader.o -o object/kernel.pe
	objcopy -O elf32-i386 object/kernel.pe object/boot/kernel
	rm -rf object/kernel.pe
install: init
	-rm -rf target
	-rm -rf dist/Self-Saving-Killer.iso
	-mkdir target
	cp -rf assets/* target/
	cp -rf object/* target/
	cp -rf LICENSE target/
	mkisofs $(ISOFlag) -o dist/Self-Saving-Killer.iso target/
run:
	#qemu-system-i386 -cdrom dist/Self-Saving-Killer.iso -serial null -parallel stdio -m 256
	bochs -f bochsrc.bxrc
init:
	-mkdir -p object/boot
	-mkdir dist
	-mkdir target
clean:
	-rm -rf object
	-rm -rf dist
	-rm -rf target