################################################################################
#
# rust-sdk
#
################################################################################
RUST_SDK_VERSION = v0.4.0
RUST_SDK_SITE = git@github.com:vector-sdk/rust-sdk.git
RUST_SDK_SITE_METHOD = git
HOST_RUST_SDK_INSTALL_STAGING = YES
HOST_RUST_SDK_INSTALL_TARGET = YES

HOST_RUST_SDK_DEPENDENCIES += host-rust-bin

define HOST_RUST_SDK_BUILD_CMDS
    $(MAKE) -C $(@D) all
endef

$(eval $(host-generic-package))
