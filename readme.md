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
$ ./select-toolchain.sh
available configs:
        1) config.cross-armv7
        2) config.cross-i686
        3) config.native-armv7a
        4) config.native-i686
4
.config -> config.native-i686
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
