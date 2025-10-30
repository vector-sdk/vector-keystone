################################################################################
#
# Elliptic curve Diffie-Hellman library
#
################################################################################
STATIC_DH_ECDH_VERSION = v0.1.1+
STATIC_DH_ECDH_SITE = https://github.com/vector-sdk/static-dh-ecdh.git
STATIC_DH_ECDH_SITE_METHOD = git
HOST_STATIC_DH_ECDH_INSTALL_STAGING = YES
HOST_STATIC_DH_ECDH_INSTALL_TARGET = YES

HOST_STATIC_DH_ECDH_DEPENDENCIES += host-rust-bin

define HOST_STATIC_DH_ECDH_BUILD_CMDS
    $(MAKE) -C $(@D)
endef

$(eval $(host-generic-package))
