About
=====

This repository contains tools needed to create proper toolchain for project
"builder". This can create both cross-compilers (working on amd64 host and
generate binary for example armv7 or sparc) and native compilers that work
on ie armv7 host and generate code for armv7

Usage
=====

Select what compiler to create using select-toolchain.sh script like

~~~
./select-toolchain.sh
usage: ./select-toolchain.sh <config_number>

supported configs are:
        0) cross.aarch64-builder-linux-gnu
        1) cross.armv5te926-builder-linux-gnueabihf
        2) cross.armv6j1136-builder-linux-gnueabihf
        3) cross.armv7a15-builder-linux-gnueabihf
        4) cross.armv7a9-builder-linux-gnueabihf
        5) cross.i686-builder-linux-gnu
        6) cross.i686-builder-linux-musl
        7) cross.i686-builder-linux-uclibc
        8) cross.mips-builder-linux-gnu
        9) cross.nios2-builder-linux-gnu
        10) cross.x86_64-builder-linux-gnu
        11) cross.x86_64-builder-linux-musl
        12) cross.x86_64-builder-linux-uclibc
        13) native.aarch64-builder-linux-gnu
        14) native.armv5te926-builder-linux-gnueabihf
        15) native.armv6j1136-builder-linux-gnueabihf
        16) native.armv7a15-builder-linux-gnueabihf
        17) native.armv7a9-builder-linux-gnueabihf
        18) native.i686-builder-linux-gnu
        19) native.i686-builder-linux-musl
        20) native.i686-builder-linux-uclibc
        21) native.mips-builder-linux-gnu
        22) native.nios2-builder-linux-gnu
        23) native.x86_64-builder-linux-gnu
        24) native.x86_64-builder-linux-musl
        25) native.x86_64-builder-linux-uclibc
$ ./select-toolchain.sh 18
.config -> config.cross.i686-builder-linux-gnu
~~~

and then execute "make". This will build toolchain and create opkg package.

Bugs
====

Native toolchain must be built in directory they will be executed from. For
example if we want native compiler to be in */usr/native-toolchain* on host,
we need to build toolchain in */usr/native-toolchain* on build machine. This
requires build user to have write access to */usr* directory.

While above may not be true when building cross-compiler, cross-compiler is
too build in */usr* for simplicity

Taking above into consideration, safest way to build such toolchains is to do
it in container or virtual machine.
