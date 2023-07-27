Compiler := gcc
CompilerFlag := -fno-builtin -Og -g -m32 -nostdlib -nostartfiles -nodefaultlibs -Wno-int-to-pointer-cast -Wno-incompatible-pointer-types
LOOP := $(shell losetup -f)
XLOOP := $(subst /dev/,,$(LOOP))
.PHONY: init clean build run
build: init
	@echo "\033[1;32mBuilding bootloader and main program\033[0m"
	$(Compiler) $(CompilerFlag) -c src/bootloader.S -o object/bootloader.o
	$(Compiler) $(CompilerFlag) -masm=intel -c src/main.c -o object/main.o
	@echo "\033[1;32mLinking everything together\033[0m"
	ld -Tlinkfile.lds -m elf_i386
	@echo "\033[1;32mGenerating Game Package\033[0m"
	#node SSKgenerater/SSKgenerater.js demo/jail object/jail.ssk SSKgenerater/simsun.ttc
	@echo "\033[1;32mGenerating Game Image\033[0m"
	-@rm -rf target 2> /dev/null
	-@rm -rf dist/Self-Saving-Killer.iso 2> /dev/null
	-@mkdir target 2> /dev/null
	@cp -rf assets/* target/
	@cp -rf object/boot target/
	@cp -rf LICENSE target/
	@rm -f dist/Self-Saving-Killer.img 
	dd if=/dev/zero of=dist/Self-Saving-Killer.img bs=128M count=1
	@echo "n\n\n\n\n\nw\n" | fdisk dist/Self-Saving-Killer.img
	losetup $(LOOP) dist/Self-Saving-Killer.img
	kpartx -av $(LOOP)
	mkfs -t vfat -F 16 /dev/mapper/$(XLOOP)p1 
	-mkdir /tmp/image_install
	mount /dev/mapper/$(XLOOP)p1 /tmp/image_install -o iocharset=utf8
	cp -rf target/* /tmp/image_install/
	grub-install --target=i386-pc --no-floppy --recheck --root-directory=/tmp/image_install $(LOOP)
	umount /tmp/image_install
	losetup -d $(LOOP)
	-@rm -rf /tmp/image_install
	qemu-img convert -f raw dist/Self-Saving-Killer.img -O vdi dist/Self-Saving-Killer.vdi
	qemu-img convert -f raw dist/Self-Saving-Killer.img -O vhdx dist/Self-Saving-Killer.vhdx
	qemu-img convert -f raw dist/Self-Saving-Killer.img -O vmdk dist/Self-Saving-Killer.vmdk
run:
	@echo "\033[1;32mStrating qemu virtual machine\033[0m"
	qemu-system-i386 -drive format=raw,file=dist/Self-Saving-Killer.img -serial null -parallel stdio
debug:
	@echo "\033[1;32mStrating qemu virtual machine and GDB Debugger\033[0m"
	qemu-system-i386 -drive format=raw,file=dist/Self-Saving-Killer.img -serial null -parallel stdio -s -S &
	gdb -ex "target remote :1234" -ex "symbol-file object/boot/kernel" -ex "set disassembly-flavor intel" -ex "b entry" -ex "c" -q
	killall qemu-system-i386
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