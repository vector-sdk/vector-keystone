
# We override some of the variables that we get from the Buildroot
# infrastructure here. Specifically, we don't want to use the provided
# CFLAGS since these assume that the build target isn't firmware-like
# (i.e. we want nostdlib, nostartfiles, etc).

override CFLAGS := \
	-mcmodel=medany \
	-nostdlib -nostartfiles -fno-common -std=gnu11 \
	-static \
	-fPIC \
	-fno-stack-protector \
	-g -Og -Wall

# ^ consider taking out -g -Og and putting in -O2

O ?=.

# Overriding also a C compiler. This project uses an older version of
# the C compiler (version 12.2.0) to resolve a QEMU boot issue where
# the system hangs during execution of the boot ROM code. The compiler
# was obtained from Bootlin's toolchain releases and is bundled as the
# keystone-bootrom-toolchain package.
override CC := $(BUILDROOT_BUILDDIR)/per-package/host-keystone-bootrom-toolchain/host/opt/riscv64-elf-legacy/bin/riscv64-buildroot-linux-gnu-gcc

bootloaders=\
	$(O)/bootrom.elf \
	$(O)/bootrom.bin

.PHONY: all
all: $(bootloaders)

.PHONY: clean
clean:
	rm -f $(bootloaders)

bootrom_sources = \
	./bootloader.S \
	./bootloader.c \
	./ed25519/*.c \
	./sha3/*.c

%.elf: $(bootrom_sources) bootloader.lds
	$(CC) $(CFLAGS) -I./ -L . -T bootloader.lds -o $@ $(bootrom_sources)

%.bin: %.elf
	$(OBJCOPY) -O binary --only-section=.text $< $@;

