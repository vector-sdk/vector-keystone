################################################################################
#
# wasm-examples
#
################################################################################
WASM_EXAMPLES_VERSION = v0.1.0
WASM_EXAMPLES_SITE = https://github.com/vector-sdk/wasm-examples.git
WASM_EXAMPLES_SITE_METHOD = git
HOST_WASM_EXAMPLES_INSTALL_STAGING = YES
HOST_WASM_EXAMPLES_INSTALL_TARGET = YES

define HOST_WASM_EXAMPLES_BUILD_CMDS
    $(MAKE) -C $(@D)
endef

define HOST_WASM_EXAMPLES_INSTALL_CMDS
    (cd $(@D); cp *.wasm $(BUILDDIR)/overlay/root)
endef

$(eval $(host-generic-package))
