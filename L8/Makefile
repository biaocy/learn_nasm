OBJECTS = helloworld-args.o
LDFLAGS = -melf_i386
AS = nasm
ASFLAGS = -f elf

all: program.elf

program.elf: $(OBJECTS)
	ld $(LDFLAGS) $(OBJECTS) -o program.elf

run: program.elf
	./program.elf "This is one argument" "Second argument" 10

%.o: %.asm
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -f *.o program.elf
