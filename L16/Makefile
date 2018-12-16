OBJECTS = calculator-*.o
LDFLAGS = -melf_i386
AS = nasm
ASFLAGS = -f elf

all: program.elf

program.elf: $(OBJECTS)
	ld $(LDFLAGS) $(OBJECTS) -o program.elf

run: program.elf
	./program.elf ${ARGS}

%.o: %.asm
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -f *.o program.elf
