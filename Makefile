all: os-image

os-image: boot_sector.bin kernel.bin
	cat $^ > $@

boot_sector.bin: boot_sector_into_kernel.asm
	nasm $< -f bin -o $@

# $^ is substituted with all of the target's dependancy files
kernel.bin: kernel_entry.o kernel.o
	ld -o kernel.bin -Ttext 0x1000 $^ --oformat binary

# $< is the first dependancy and $@ is the target file
kernel.o: kernel.c
	gcc -ffreestanding -c $< -o $@

kernel_entry.o: kernel_entry.asm
	nasm $< -f elf64 -o $@

clean:
	rm -fr *.bin *.o *.dis *.map os-image

kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@
