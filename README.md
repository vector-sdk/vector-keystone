# Keystone: An Open-Source Secure Enclave Framework for RISC-V Processors

## Introduction

This repository is cloned from the original
[Keystone repository](https://github.com/keystone-enclave/keystone) from
GitHub. The repository includes additional commits to support StarFive
VisionFive2 RISC-V development board. Upstream Keystone is still available
in the branch 'upstream'. See the original
[README-KEYSTONE.md](https://github.com/keystone-enclave/keystone/blob/master/README-KEYSTONE.md)
file to check Keystone goals, status, documentation, and current hardware
support. 

## Goals

The repository is used to test VECTOR Rust SDK with RISC-V hardware
that is not yet supported by the upstream Keystone.

## Status

The repository includes one unmerged
[pull request](https://github.com/keystone-enclave/keystone/pull/467)
from the original Keystone repository and few additional commits that
enable the use of Keystone test keys with StarFive VisionFive2 RISC-V
development board.

This has been tested with qemu and StarFive VisionFive2 RISC-V
development board.

The repository now includes also Rust SDK and Rust SDK demo packages.
Rust SDK demonstrator is installed to the target system root user's
home directory with a name rust-sdk-demo.ke.

Keystone has been updated to use newer buildroot (2025.05). Build
assumes that Rust environment is installed separtely to the host
system using rustup and nightly build is set as a default target
(Rust SDK is utilizing a Cargo workspace feature that still is only
available in nightly builds).

## Build and test instructions

### StarFive VisionFive2

Keystone build can be controlled using various environment variables
and configuration files. The following script can be used to build
Keystone for StarFive VisionFive2:

    scripts/build_visionfive2.sh

The build will produce an image file:

    build-starfive/visionfive264/buildroot.build/images/sdcard.img

Flash the image file to a microSD card using,
e.g., [balenaEtcher](https://etcher.balena.io/). For console output
you may need an USB-to-UART adapter like
[Raspberry Pi Debug Probe](https://www.raspberrypi.com/documentation/microcontrollers/debug-probe.html).
Login with credentials (root/starfive).

The script can also be used with Keystone 'dirclean' targets that are
set using BUILDROOT_TARGET environment variables. The following command
will clean Linux driver build directory:

    BUILDROOT_TARGET=keystone-driver-dirclean scripts/build-visionfive2.sh

Files from

    build-starfive/visionfive264/overlay/root

end up to root user's home directory and can be used to test VECTOR Rust SDK.

### Qemu

Generic is still the default target. Compilation can be done with make:

    make

Qemu is invoked with

    make run

Login with credentials (root/sifive).

Also here Keystone 'dirclean' targets that are set using
BUILDROOT_TARGET environment variables. The following command will
clean Linux driver build directory:

    BUILDROOT_TARGET=keystone-driver-dirclean make

Files from

    build-generic64/overlay/root

end up to root user's home directory and can be used to test VECTOR Rust SDK.

## Acknowledgment

This work is partly supported by the European Union’s Horizon Europe
research and innovation programme in the scope of the the
[CONFIDENTIAL6G](https://confidential6g.eu/) project under Grant
Agreement 101096435.



