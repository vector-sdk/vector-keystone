################################################################################
#
# schannel-demo
#
################################################################################
SCHANNEL_DEMO_VERSION = v0.4.0
SCHANNEL_DEMO_SITE = https://github.com/vector-sdk/schannel-demo.git
SCHANNEL_DEMO_SITE_METHOD = git
HOST_SCHANNEL_DEMO_INSTALL_STAGING = YES
HOST_SCHANNEL_DEMO_INSTALL_TARGET = YES

HOST_SCHANNEL_DEMO_DEPENDENCIES += host-rust-sdk
HOST_SCHANNEL_DEMO_DEPENDENCIES += host-static-dh-ecdh
HOST_SCHANNEL_DEMO_DEPENDENCIES += keystone-examples

define HOST_SCHANNEL_DEMO_BUILD_CMDS
    $(MAKE) -C $(@D)
endef

# Creates a self-extracting archive using makeself. This archive
# includes eyrie-rt and loader components sourced from the
# keystone-examples package, introducing a new dependency. The
# resulting self-extracting application, rust-sdk-demo.ke, is
# installed to the root user's home directory.
define HOST_SCHANNEL_DEMO_INSTALL_CMDS
    (cd $(@D); mkdir -p pkg; \
     cp ./target/riscv64gc-unknown-none-elf/release/schannel-eapp pkg; \
     cp ./target/riscv64gc-unknown-linux-gnu/release/schannel-host pkg; \
     cp $(BUILDDIR)/buildroot.build/build/keystone-examples-*/hello/eyrie-rt pkg; \
     cp $(BUILDDIR)/buildroot.build/build/keystone-examples-*/hello/runtime/src/eyrie-hello-eyrie/loader-binary/loader pkg; \
     makeself --tar-extra "--owner=0 --group=0" --noprogress pkg schannel-demo.ke "Secure channel demo" ./schannel-host schannel-eapp eyrie-rt loader; \
     cp schannel-demo.ke $(BUILDDIR)/overlay/root; \
     cp ./target/riscv64gc-unknown-linux-gnu/release/schannel-client $(BUILDDIR)/overlay/root)
endef

$(eval $(host-generic-package))
