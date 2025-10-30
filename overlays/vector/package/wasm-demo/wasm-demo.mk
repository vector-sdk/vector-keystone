################################################################################
#
# wasm-demo
#
################################################################################
WASM_DEMO_VERSION = v0.3.0
WASM_DEMO_SITE = https://github.com/vector-sdk/wasm-demo.git
WASM_DEMO_SITE_METHOD = git
HOST_WASM_DEMO_INSTALL_STAGING = YES
HOST_WASM_DEMO_INSTALL_TARGET = YES

HOST_WASM_DEMO_DEPENDENCIES += host-rust-sdk
HOST_WASM_DEMO_DEPENDENCIES += host-static-dh-ecdh
HOST_WASM_DEMO_DEPENDENCIES += keystone-examples

define HOST_WASM_DEMO_BUILD_CMDS
    $(MAKE) -C $(@D)
endef

# Creates a self-extracting archive using makeself. This archive
# includes eyrie-rt and loader components sourced from the
# keystone-examples package, introducing a new dependency. The
# resulting self-extracting application, wasm-demo.ke, is
# installed to the root user's home directory.
define HOST_WASM_DEMO_INSTALL_CMDS
    (cd $(@D); mkdir -p pkg; \
     cp ./target/riscv64gc-unknown-none-elf/release/wasm-rt pkg; \
     cp ./target/riscv64gc-unknown-linux-gnu/release/wasm-host pkg; \
     cp $(BUILDDIR)/buildroot.build/build/keystone-examples-*/hello/eyrie-rt pkg; \
     cp $(BUILDDIR)/buildroot.build/build/keystone-examples-*/hello/runtime/src/eyrie-hello-eyrie/loader-binary/loader pkg; \
     makeself --tar-extra "--owner=0 --group=0" --noprogress pkg wasm-demo.ke "WebAssembly demo" ./wasm-host -e wasm-rt -r eyrie-rt -l loader; \
     cp wasm-demo.ke $(BUILDDIR)/overlay/root; \
     cp ./target/riscv64gc-unknown-linux-gnu/release/wasm-client $(BUILDDIR)/overlay/root)
endef

$(eval $(host-generic-package))
