################################################################################
#
# rust-sdk-demo
#
################################################################################
RUST_SDK_DEMO_VERSION = v0.4.0
RUST_SDK_DEMO_SITE = https://github.com/vector-sdk/rust-sdk-demo.git
RUST_SDK_DEMO_SITE_METHOD = git
HOST_RUST_SDK_DEMO_INSTALL_STAGING = YES
HOST_RUST_SDK_DEMO_INSTALL_TARGET = YES

HOST_RUST_SDK_DEMO_DEPENDENCIES += host-rust-sdk
HOST_RUST_SDK_DEMO_DEPENDENCIES += keystone-examples

define HOST_RUST_SDK_DEMO_BUILD_CMDS
    $(MAKE) -C $(@D) all
endef

# Creates a self-extracting archive using makeself. This archive
# includes eyrie-rt and loader components sourced from the
# keystone-examples package, introducing a new dependency. The
# resulting self-extracting application, rust-sdk-demo.ke, is
# installed to the root user's home directory.
define HOST_RUST_SDK_DEMO_INSTALL_CMDS
    (cd $(@D); mkdir -p pkg; \
     cp ./target/riscv64gc-unknown-none-elf/release/rust-eapp pkg; \
     cp ./target/riscv64gc-unknown-linux-gnu/release/rust-happ pkg; \
     cp $(BUILDDIR)/buildroot.build/build/keystone-examples-*/hello/eyrie-rt pkg; \
     cp $(BUILDDIR)/buildroot.build/build/keystone-examples-*/hello/runtime/src/eyrie-hello-eyrie/loader-binary/loader pkg; \
     makeself --tar-extra "--owner=0 --group=0" --noprogress pkg rust-sdk-demo.ke "Rust SDK demo" ./rust-happ rust-eapp eyrie-rt loader; \
     cp rust-sdk-demo.ke $(BUILDDIR)/overlay/root)
endef

$(eval $(host-generic-package))
