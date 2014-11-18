Assembler Hacking
=================

Where I keep my acquired/in-acquisition assembler knowledge

### Inspiration

I've been reading along with [this pdf on building your own OS from scratch](http://micropenguin.net/files/Other/OS/os-dev.pdf),
and and slowly making my way through it.

I started this endeavour at railscamp, and it's probably the most removed of a project I could have under taken from ruby, apart
from, perhaps, kite surfing.

I'm only barely past bootsector stuff at the moment, but soon enough I'll be loading code from past that first realm.

### Getting it to werk

First of all, you need to build it:

    $ nasm boot_sector_print_stuff.asm -f bin -o boot_sect_asm.bin

I used qemu to run it. However, this is not as straight forward as it seems, unless of course you read this readme,
in which case you can just copy the following:

    $ qemu-system-x86_64 -fda boot_sect_asm.bin --boot order=a
    
What this does is tell qemu to attach the disk image as the first floppy disk, and to boot from it. I've had issues with
plain ol' HDD emulation, which I suspect requires LBA disk reads. That said though, that doesn't necessarily make sense
as all BIOS' should be able to perform CHS lookups on a disk...

### A couple of gotchas

- `BX` is the only register that can be used for indexing ( i.e. the `[bx + offset]` syntax in nasm - returns the data
  pointed to by the address given by `bx + offset`)
- `CL` is the only register able to be used with shift (SHL/SHR, SAL/SAR) operations as the source operand.
