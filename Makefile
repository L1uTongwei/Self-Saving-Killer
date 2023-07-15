Compiler := gcc
CompilerFlag := -fno-builtin -Og -g -m32 -nostdlib -nostartfiles -nodefaultlibs -Wno-int-to-pointer-cast
Linker := ld
LinkerFlag := -Ttext 0x100000 -e start -m elf_i386
ISOFlag := -b boot/grub/stage2_eltorito.img -l -J -allow-leading-dots --no-emul-boot --boot-load-size 4 -r \
	-copyright LICENSE -p L1uTongwei -abstract abstract.doc -V "SSK Boot CD" -input-charset iso8859-1 \
	-boot-info-table -quiet
.PHONY: init clean build run
build: init
	$(Compiler) $(CompilerFlag) -masm=intel -c src/main.c -o object/main.o
	$(Compiler) $(CompilerFlag) -c src/bootloader.S -o object/bootloader.o
	$(Linker) $(LinkerFlag) object/bootloader.o object/main.o -o object/boot/kernel
install: init
	-@rm -rf target 2> /dev/null
	-@rm -rf dist/Self-Saving-Killer.iso 2> /dev/null
	-@mkdir target 2> /dev/null
	@cp -rf assets/* target/
	@cp -rf object/* target/
	@cp -rf LICENSE target/
	mkisofs $(ISOFlag) -o dist/Self-Saving-Killer.iso target/
run:
	qemu-system-i386 -cdrom dist/Self-Saving-Killer.iso -serial null -parallel stdio
debug:
	qemu-system-i386 -cdrom dist/Self-Saving-Killer.iso -serial null -parallel stdio -s -S &
	gdb -ex "target remote :1234" -ex "symbol-file object/boot/kernel" -ex "b __main" -ex "c"
	killall qemu-system-i386
init:
	-@mkdir -p object/boot 2> /dev/null
	-@mkdir dist 2> /dev/null
	-@mkdir target 2> /dev/null
clean:
	-@rm -rf object 2> /dev/null
	-@rm -rf dist 2> /dev/null
	-@rm -rf target 2> /dev/null
onekey: build install run