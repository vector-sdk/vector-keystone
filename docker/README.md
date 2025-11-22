# Building Docker Image

Here are instructions to build and test Keystone with Rust SDK using
Docker. Currently the following two configurations are supported:

* Use 'Dockerfile' to build a QEMU version.

* Use 'Dockerfile.vf2' to build an image to StarFive VisionFive2
  development board.

## Experimenting with qemu docker image

Run the following command in this 'docker' subdirectory that also
includes the default configuration file 'Dockerfile':

```bash
$ docker build -t keystone:qemu .
```

Keystone is built using Ubuntu 24.04 development environment and the
docker image includes all Keystone and Rust SDK based examples. The
image can be started with a command:

```bash
$ docker run -it keystone:qemu
```

The container is started and there is a container root shell in a
directory '/keystone' that includes Keystone source tree and build
artifacts. The user can then start Keystone qemu image using 'make run'
and then load Keystone kernel module using 'modprobe'.

```bash
# make run
[...]
Welcome to Buildroot
buildroot login: root
Password:
# modprobe keystone-driver
[   40.862041] keystone_driver: loading out-of-tree module taints kernel.
[   40.868205] keystone_enclave: keystone enclave v1.0.0
#
```

Original Keystone demos are in '/usr/share/keystone/examples'
directory and Rust SDK demos are in '/root' directory. Some demos need
two shells.  Check the container id using 'docker ps', use 'docker
exec' to login to the container, and finally ssh login to RISC-V
qemu image using mapped port 9821:

```bash
$ docker ps
CONTAINER ID   IMAGE           COMMAND                  CREATED          STATUS          PORTS     NAMES
8847257cf6a4   keystone:qemu   "/bin/sh -c 'cd /key…"   14 seconds ago   Up 13 seconds             jolly_maxwell
$ docker exec -it 8847257cf6a4 /bin/bash
root@8847257cf6a4:/# ssh -l root -p 9821 localhost
root@localhost's password:
#
```

## Experimenting with StarFive Visionfive2 docker image

It is also possible to build a flashable image to StarFive VisionFive2
development board using Docker. There is a configuration file
'Dockerfile.vf2' that can be used to build a docker image and then
start the container using the following commands:

```bash
$ docker build -t keystone:vf2 -f Dockerfile.vf2 .
$ docker run -it keystone:vf2
root@ff9e71990ded:/keystone#
```

It is then possible to use 'docker ps' to get the conatiner id and then
use 'docker cp' to copy a flashable image from the container to the host.

```bash
$ docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED              STATUS              PORTS     NAMES
ff9e71990ded   keystone:vf2   "/bin/sh -c 'cd /key…"   About a minute ago   Up About a minute             angry_allen
$ docker cp ff9e71990ded:/keystone/build-starfive/visionfive264/buildroot.build/images/sdcard.img /tmp
Successfully copied 526MB to /tmp
```

## Additional instructions

Keystone open source project included Docker builds with the following
instructions. Note that it is possible to select a specific branch,
tag, or commit by passing 'CHECKOUT' variable to a docker file using
'--build-arg' command-line option.

### Building Docker Image

To build the image with master branch:
```bash
docker build -t keystoneenclaveorg/keystone:master .
```

dev branch:

```bash
docker build -t keystoneenclaveorg/keystone:dev --build-arg CHECKOUT=dev .
```

any other branches or tags:
```bash
docker build -t keystoneenclaveorg/keystone:<tag> --build-arg CHECKOUT=<tag> .
```

### Building CI images

RV64:

```
docker build -t keystoneenclaveorg/keystone:init-rv64gc --build-arg CHECKOUT=master . --platform linux/x86_64 -f Dockerfile.nobuild
docker push keystoneenclaveorg/keystone:init-rv64gc
```

RV32:

```
docker build -t keystoneenclaveorg/keystone:init-rv32gc --build-arg CHECKOUT=master . --platform linux/x86_64 -f Dockerfile.32.nobuild
docker push keystoneenclaveorg/keystone:init-rv32gc
```
