C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
C_HEADERS = $(wildcard kernel/*.h drivers/*.h)

OBJ = ${C_SOURCES:.c=.o}

run: all
	qemu-system-i386 os-image

all: os-image

os-image: boot/boot_sector.bin kernel.bin
	cat $^ > $@

# $^ is substituted with all of the target's dependancy files
kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary

# $< is the first dependancy and $@ is the target file
%.o: %.c
	gcc -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf64 -o $@

%.bin: %.asm
	nasm $< -f bin -I boot/ -o $@

clean:
	rm -fr *.bin *.o *.dis *.map os-image
	rm -fr kernel/*.o boot/*.bin drivers/*.o

kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@
