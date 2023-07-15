Compiler := gcc
CompilerFlag := -fno-builtin -Og -g -m32 -nostdlib -nostartfiles -nodefaultlibs -Wno-int-to-pointer-cast
Linker := ld
LinkerFlag := -Ttext 0x100000 -e start -m elf_i386
ISOFlag := -b boot/grub/stage2_eltorito.img -l -J -allow-leading-dots --no-emul-boot --boot-load-size 4 -r \
	-copyright LICENSE -p L1uTongwei -abstract abstract.doc -V "SSK Boot CD" -input-charset iso8859-1 \
	-boot-info-table -quiet
.PHONY: init clean build run
build: init
	@echo Building bootloader and main program...
	@$(Compiler) $(CompilerFlag) -c src/bootloader.S -o object/bootloader.o
	@$(Compiler) $(CompilerFlag) -masm=intel -c src/main.c -o object/main.o
	@echo Linking everything together...
	@$(Linker) $(LinkerFlag) object/bootloader.o object/main.o -o object/boot/kernel
	@echo Generating ISO Image...
	-@rm -rf target 2> /dev/null
	-@rm -rf dist/Self-Saving-Killer.iso 2> /dev/null
	-@mkdir target 2> /dev/null
	@cp -rf assets/* target/
	@cp -rf object/* target/
	@cp -rf LICENSE target/
	@mkisofs $(ISOFlag) -o dist/Self-Saving-Killer.iso target/ 2> /dev/null
run:
	@echo Strating qemu virtual machine...
	@qemu-system-i386 -cdrom dist/Self-Saving-Killer.iso -serial null -parallel stdio
debug:
	@echo Strating qemu virtual machine and GDB Debugger...
	@qemu-system-i386 -cdrom dist/Self-Saving-Killer.iso -serial null -parallel stdio -s -S &
	@gdb -ex "target remote :1234" -ex "symbol-file object/boot/kernel" -ex "b __main" -ex "c"
	@killall qemu-system-i386
init:
	-@mkdir -p object/boot 2> /dev/null || exit 0
	-@mkdir dist 2> /dev/null || exit 0
	-@mkdir target 2> /dev/null || exit 0
clean:
	-@rm -rf object 2> /dev/null
	-@rm -rf dist 2> /dev/null
	-@rm -rf target 2> /dev/null
onekey: build run
onekey_debug: build debug