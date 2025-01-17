#!/bin/sh
#
# Build StarFive VisionFive2 image
#
# The default target is to build 'all' using a parallel build. If
# there are parameters to this script then those are passed directly
# to 'make' command.
#
# Keystone build is using various 'clean' targets using special
# BUILDROOT_TARGET environment settings. The script sets the build
# target 'all' by default but the setting can be overridden by setting
# the environment variable:
#
# BUILDROOT_TARGET=keystone-driver-dirclean scripts/build-visionfive2.sh
#
# Markku Kylänpää <markku.kylanpaa@vtt.fi>
# VTT Technical Research Centre of Finland Ltd
# 29.1.2025
#
export KEYSTONE_PLATFORM=starfive/visionfive2
export KEYSTONE_BITS=64
export BUILDROOT_CONFIGFILE=riscv64_starfive_visionfive2_defconfig
export BUILDROOT_TARGET=${BUILDROOT_TARGET:-all}

if [ $# -eq 0 ]; then
    make -j$(nproc)
else
    make $@
fi
