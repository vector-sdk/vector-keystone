################################################################################
#
# Keystone boot ROM toolchain
#
################################################################################

KEYSTONE_BOOTROM_TOOLCHAIN_VERSION = 2022.08-1
KEYSTONE_BOOTROM_TOOLCHAIN_SOURCE = riscv64-lp64d--glibc--bleeding-edge-$(KEYSTONE_BOOTROM_TOOLCHAIN_VERSION).tar.bz2
KEYSTONE_BOOTROM_TOOLCHAIN_SITE = https://toolchains.bootlin.com/downloads/releases/toolchains/riscv64-lp64d/tarballs
KEYSTONE_BOOTROM_TOOLCHAIN_SITE_METHOD = wget

ifeq ($(KEYSTONE),)
$(error KEYSTONE directory is not defined)
endif

HOST_KEYSTONE_BOOTROM_TOOLCHAIN_INSTALL_DIR = $(HOST_DIR)/opt/riscv64-elf-legacy

define HOST_KEYSTONE_BOOTROM_TOOLCHAIN_INSTALL_CMDS
	mkdir -p $(HOST_KEYSTONE_BOOTROM_TOOLCHAIN_INSTALL_DIR)
	cp -rf $(@D)/* $(HOST_KEYSTONE_BOOTROM_TOOLCHAIN_INSTALL_DIR)/

	mkdir -p $(HOST_DIR)/bin
	cd $(HOST_DIR)/bin && \
	for i in ../opt/riscv64-elf-legacy/bin/*; do \
		ln -sf $$i; \
	done
endef

$(eval $(host-generic-package))
