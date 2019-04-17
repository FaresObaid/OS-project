# cross compiler
CC = /usr/local/i386elfgcc/bin/i386-elf-gcc
LD = /usr/local/i386elfgcc/bin/i386-elf-ld

os-img: boot/boot_sect.bin kernel.bin
	cat $^ > os-img

kernel.bin: boot/kernel_entry.o kernel/kernel.o
	${LD} -o $@ -Ttext 0x1000 $^ --oformat binary

kernel.o: kernel/kernel.c
	${CC} -freestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf -o $@

%.bin: %.asm
	nasm $< -f bin -o $@

clean:
	rm -rf *.bin *.dis *.o os-img
	rm -rf kernel/*.o boot/*.bin boot/*.o

run: os-img
	qemu-system-x86_64 $<
